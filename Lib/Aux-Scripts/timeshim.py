"""
Using %#I comes from https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/strftime-wcsftime-strftime-l-wcsftime-l?view=msvc-160

see also https://dateutil.readthedocs.io/en/stable/tz.html

NOTE: THIS REQUIRES the dateutil and click libraries to work!
Otherwise it will silently fail!
"""

import click
from dateutil.parser import parse
from dateutil.tz import gettz, UTC
from ctypes import windll as w

# TODO: load this from a fixture
tzinfos = {
    "CST": gettz("America/Chicago"),
    "EST": gettz("America/New_York"),
    "PST": gettz("America/Los_Angeles"),
    "PDT": gettz("America/Los_Angeles"),
    "CEST": gettz("Europe/Berlin"),
    "IT": gettz("Israel")
        }

@click.command()
@click.option('--date')
# Just outputs the Central and UTC timezones because that's what I care about
# You could add your own timezones if you steal this
def timeshim(date):
    out = parse(date, tzinfos=tzinfos, fuzzy=True)
    cst = out.astimezone(tzinfos["CST"])
    utc = out.astimezone(UTC)
    fmt = "%#I:%M %p %Z" # h:mm PM Timezone
    out= utc.strftime(fmt), cst.strftime(fmt)
    w.user32.MessageBoxW(0, "\n".join(out), "", 0)

if __name__ == "__main__":
    timeshim()

