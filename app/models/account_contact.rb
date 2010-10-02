# Fat Free CRM
# Copyright (C) 2008-2010 by Michael Dvorkin
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#------------------------------------------------------------------------------

# == Schema Information
# Schema version: 27
#
# Table name: account_contacts
#
#  id         :integer(4)      not null, primary key
#  account_id :integer(4)
#  contact_id :integer(4)
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
class AccountContact < ActiveRecord::Base
  belongs_to :account
  belongs_to :contact
  validates_presence_of :account_id, :contact_id

  # acts_as_paranoid
end
