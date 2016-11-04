#!/bin/sh
echo '{ "AuthServerWhitelist": "*.smartsheet.com",
    "AuthNegotiateDelegateWhitelist": "*.smartsheet.com" }' | sudo tee /etc/opt/chrome/policies/managed/smartsheet.json > /dev/null
