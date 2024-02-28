import time
import boto3

from typing import List

"""
kwargs = {
    "region_name": 'us-east-1',
    "aws_access_key_id": os.environ["AWS_ACCESS_KEY_ID"],
    "aws_secret_access_key": os.environ["AWS_SECRET_ACCESS_KEY"],
    "aws_session_token": os.environ["AWS_SESSION_TOKEN"],
}
"""


class SSM:
    def __init__(self, logger, **kwargs):
        self.logger = logger
        self.client = boto3.client("ssm", **kwargs)

    def send_command(self, instance_ids: List[str], commands: List[str]):
        res = self.client.send_command(
            InstanceIds=instance_ids,
            DocumentName="AWS-RunShellScript",
            Parameters={"commands": commands},
        )
        command_id = res["Command"]["CommandId"]

        cmd_res = {}

        for instance_id in instance_ids:
            tries = 0

            while tries < 10:
                tries += 1

                try:
                    time.sleep(0.1)

                    res = self.client.get_command_invocation(
                        CommandId=command_id,
                        InstanceId=instance_id,
                    )

                    if res["Status"] == "InProgress":
                        continue

                    cmd_res[instance_id] = (
                        res.get("StandardOutputContent")
                        + "\n\n"
                        + res.get("StandardErrorContent")
                    ).strip()

                    break

                except self.client.exceptions.InvocationDoesNotExist:
                    continue

        return cmd_res
