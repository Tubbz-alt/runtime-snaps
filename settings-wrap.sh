#!/bin/bash

export LIBGL_DRIVERS_PATH="/var/lib/snapd/lib/gl:/usr/lib/dri"
export PATH="/bin:$PATH"

exec "$SNAP"/bin/lsi-settings
