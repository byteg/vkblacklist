require 'clockwork'
include Clockwork

every(5.minutes, 'groups.check_unbanned') { Group.check_unbanned}
