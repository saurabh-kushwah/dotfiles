import boto3

# for input() to save history
import readline

class SSM:

    def __init__(self, access_key, secret_key, region, logger):
        self.logger = logger

        self.client = boto3.client('ssm',
            "region_name"=region,
            "aws_access_key_id"=access_key,
            "aws_secret_access_key"=secret_key,
        )

    def send_command(self, instances, commands):

        res = self.client.send_command(
            InstanceIds = [ instance['instance_id'] for instance in instances ],
            DocumentName = 'AWS-RunShellScript',
            Parameters = {
                'commands': commands
            }
        )
        command_id = res['Command']['CommandId']

        cmd_res = {}

        for instance in instances:
            instance_id, instance_name = instance['instance_id'], instance[instance_name]

            tries = 0

            while tries < 10:
                tries += 1

                try:
                    time.sleep(0.1)

                    res = self.client.get_command_invocation(
                        CommandId = command_id,
                        InstanceId = instance_id,
                    )

                    if res['Status'] == 'InProgress':
                        self.logger.info(f"{instance_id: <23}: command execution in progress")
                        continue

                    output = res.get('StandardOutputContent') + '\n\n' + res.get('StandardErrorContent')
                    cmd_res[instance_id] = output.strip()
                    break

                except self.client.exceptions.InvocationDoesNotExist:
                    continue

        return cmd_res

    def attach_to_instance(self, instance):

        while True:
            try:
                command = input('$ ').strip()
            except:
                break

            if not command:
                continue

            self.run_command(instances, [command])

