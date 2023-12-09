import fzf
import boto3

# for input() to save history
import readline


class EC2:
    def __init__(self, logger, **kwargs):
        self.logger = logger
        self.client = boto3.client("ec2", **kwargs)

    def list_instances(self, **kwargs):
        res = self.client.describe_instances(**kwargs)
        instances = []

        for reservation in res["Reservations"]:
            instances.extend(reservation["Instances"])

        for instance in instances:
            for tag in instance["Tags"]:
                if tag["Key"] == "Name":
                    instance["InstanceName"] = tag["Value"]

            instance[
                "__fzf_prompt__"
            ] = f"""
                {instance['InstanceId']: <25} => {instance['InstanceName']: <60} => {instance['State']['Name']: <16} => {instance['InstanceType']}
            """.strip()

        return instances

    def get_instances(self, multi=True, **kwargs):
        instances = self.list_instances(**kwargs)

        dct = {}
        choices = []

        for instance in instances:
            dct[instance["InstanceId"]] = instance
            choices.append(instance["__fzf_prompt__"])

        selections = fzf.prompt(choices=choices, multi=multi)
        return [dct[selection.split("=>")[0].strip()] for selection in selections]
