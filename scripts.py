import configparser
from datetime import datetime
import os
from pathlib import Path
import subprocess
import traceback
from urllib.parse import quote

import pytz
from sqlalchemy import create_engine
from sqlalchemy.exc import OperationalError

def main():
    try:
        print("Hello Python")

    except Exception as _:
        traceback.print_exc()

if __name__ == "__main__":
    main()
