import sys
import logging


def get_default_logger(stream=sys.stdout, log_level=logging.DEBUG, handlers=[]):
    stdout_handler = logging.StreamHandler(stream)
    handlers.append(stdout_handler)

    for name in ["boto", "urllib3", "s3transfer", "boto3", "botocore", "nose"]:
        logging.getLogger(name).setLevel(logging.CRITICAL)

    logging.basicConfig(
        level=log_level,
        format="[%(filename)s:%(lineno)d] %(asctime)s [%(levelname)s]: %(message)s",
        handlers=handlers,
    )

    return logging.getLogger()
