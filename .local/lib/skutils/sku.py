import logging
import sys


def get_default_logger(stream=sys.stdout, handlers=[]):
    stdout_handler = logging.StreamHandler(stream)
    handlers.append(stdout_handler)

    for name in ["boto", "urllib3", "s3transfer", "boto3", "botocore", "nose"]:
        logging.getLogger(name).setLevel(logging.CRITICAL)

    logging.basicConfig(
        level=logging.DEBUG,
        format="[%(filename)s:%(lineno)d] %(asctime)s [%(levelname)s]: %(message)s",
        handlers=handlers,
    )

    return logging.getLogger()
