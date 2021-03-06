#
# Cookbook Name:: group
# Provider:: account
#
# Copyright 2012, Blue Box Group, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

%w{create remove modify manage lock unlock}.each do |name|
  action name.to_sym do
    group_resource name.to_sym
  end
end

private

def group_resource(exec_action)
  r = group new_resource.group_name do
    gid       new_resource.gid      if new_resource.gid
    append    new_resource.append   if new_resource.append
    system    new_resource.system   if new_resource.system
    members   new_resource.members  if new_resource.members
    action    :nothing
  end
  r.run_action(exec_action)
  new_resource.updated_by_last_action(true) if r.updated_by_last_action?
end
