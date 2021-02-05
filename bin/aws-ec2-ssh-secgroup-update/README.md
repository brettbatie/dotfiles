## aws-ec2-ssh-secgroup-update

## Synopsis

Update an AWS security group with a new dynamic IP from the command line or cron job.

If your public IP address changes routinely due to your ISP, frequent physical relocation, or any other reason it can be tempting to leave SSH open to 0.0.0.0/0 in your AWS EC2 security groups. This is generally a bad idea. This script allows you to add a simple cron job that will handle that update for you transparently in the background.

## Dependencies

It is assumed you have both NodeJS/NPM running locally and a working AWS CLI configured.

## Installation

Head to a directory that you would like the script to run out of:

    cd ~/Documents

Clone the repo and install node dependencies:

    git clone https://github.com/mikeapted/aws-ec2-ssh-secgroup-update.git
    cd aws-ec2-ssh-secgroup-update
    npm install

## Usage

Options

    -s|--secgroup   AWS security group ID (i.e. 'sg-XXXXXXX')
    -r|--region     AWS region (defaults to 'us-east-1')
    -f|--force      Force update regardless of old/new IP comparison results

Run directly from CLI:

    ./update.js -s <security_group_id> [-r <region>] [-f|--force] 

or add it to your cron:

    * * * * * bash -l -c '/path/to/aws-ec2-ssh-secgroup-update/update.js -s <security_group_id> [-r <region>] [-f|--force]'

Note: We need to tell bash to login to get our environment variables, etc.

## Contribute

Contributions are always welcome!

## License

GNU GPL v2.0
