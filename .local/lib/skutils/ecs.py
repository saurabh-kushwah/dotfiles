import fzf

import json
import boto3


class ECS:
    def __init__(self, logger, **kwargs):
        self.logger = logger
        self.client = boto3.client("ecs", **kwargs)

    def list_task_definition_families(self, family_prefix, **kwargs):

        next_token = ""
        families = []

        while True:
            response = self.client.list_task_definition_families(
                familyPrefix=family_prefix,
                nextToken=next_token,
                **kwargs,
            )

            families.extend(response["families"])
            next_token = response.get("nextToken")

            if not next_token:
                break

        return families

    def list_task_definitions(self, family_prefix, **kwargs):

        next_token = ""
        task_definition_arns = []

        while True:
            response = self.client.list_task_definitions(
                familyPrefix=family_prefix,
                nextToken=next_token,
                **kwargs,
            )

            task_definition_arns.extend(response["taskDefinitionArns"])
            next_token = response.get("nextToken")

            if not next_token:
                break

        return task_definition_arns

    def describe_task_definitions(self, family_prefix, **kwargs):
        families = self.list_task_definition_families(family_prefix, **kwargs)

        task_definitions = []

        for task_family in fzf.prompt(families, multi=True):
            task_definition_arns = self.list_task_definitions(task_family, **kwargs)

            for task_definition_arn in task_definition_arns:
                res = self.client.describe_task_definition(
                    taskDefinition=task_definition_arn
                )

                task_definitions.append(res)

        return task_definitions
