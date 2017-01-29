# check_snds

This is a monitoring plugin for [icinga](https://www.icinga.com) to check, if a given IP address is blacklisted in Smart Network Data Service ([SNDS](https://postmaster.live.com/snds/)) by Microsoft.


### Requirements
You need to sign up for [SNDS](https://postmaster.live.com/snds/) and request access to the desired IP addresses. Afterwards  go to "Edit profile" and enable automated access. You find the key that is needed for this plugin there as well.


### Usage
Try the plugin at the command line like this:
```
./check_snds.sh -i 1.2.3.4 -k aaa-bbb-ccc-111-222-333
```

You can define the icinga2 check command as follows:
```
/* Define check command for check_snds */
object CheckCommand "snds" {
  import "plugin-check-command"
  command = [ PluginDir + "/check_snds.sh" ]

  arguments = {
    "-i" = {
      "required" = true
      "value" = "$snds_ip$"
    }
    "-k" = {
      "required" = true
      "value" = "$snds_key$"
    }
  }
}
```


### License
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
