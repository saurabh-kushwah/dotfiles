import boto3

# for input() to save history
import readline

class EC2:

    def __init__(self, access_key, secret_key, region, logger):
        self.logger = logger

        self.client = boto3.client('ec2',
            region_name=region,
            aws_access_key_id=access_key,
            aws_secret_access_key=secret_key,
        )

    def list_instances(self, **kawrgs):
        instances = []
        next_token = ""

        while True:
            res = self.client.describe_instances(NextToken='', **kawrgs)

            for reservation in res['Reservations']:
                instances.append(reservation['Instances'])

            next_token = res['NextToken']
            if not next_token:
                break

        return instances
