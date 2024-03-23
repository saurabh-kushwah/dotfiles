import fzf
import boto3

from datetime import timezone, datetime


class EC2:

    def __init__(self, logger, **kwargs):
        self.logger = logger
        self.client = boto3.client("ec2", **kwargs)

    def list_instances(self, **kwargs):

        instances = []
        next_token = ""

        while True:
            res = self.client.describe_instances(**kwargs, NextToken=next_token)

            for reservation in res["Reservations"]:
                instances.extend(reservation["Instances"])

            next_token = res.get("NextToken")
            if not next_token:
                break

        current_time = datetime.now(timezone.utc)

        for instance in instances:
            for tag in instance["Tags"]:
                if tag["Key"] == "Name":
                    instance["InstanceName"] = tag["Value"]

            launch_time = instance["LaunchTime"]
            time_difference = current_time - launch_time

            days = time_difference.days
            hours, remainder = divmod(time_difference.seconds, 3600)
            minutes, seconds = divmod(remainder, 60)

            instance["__fzf_prompt__"] = (
                f"""
                    {instance['InstanceId']: <20} => {instance['InstanceName']: <60} => {instance['State']['Name']: <15} => {instance['InstanceType']: <10} => {days:02d}:{hours:02d}:{minutes:02d}:{seconds:02d}
                """.strip()
            )

        return instances

    def get_instances(self, multi=False, **kwargs):
        instances = self.list_instances(**kwargs)

        dct = {}
        choices = []

        for instance in instances:
            dct[instance["InstanceId"]] = instance
            choices.append(instance["__fzf_prompt__"])

        selections = fzf.prompt(choices=choices, multi=multi)
        return [dct[selection.split("=>")[0].strip()] for selection in selections]
