
Given /^I have input file\(s\) named "(.*?)"$/ do |arg1|
  @filenames = arg1.split(/,/)
end

When /^I execute "(.*?)"$/ do |arg1|
  if @filenames[0] != nil
    @cmd = arg1 + ' < ' + @filenames[0]
  else
    @cmd = arg1
  end
end

Then(/^I expect the named output to match the named output "(.*?)"$/) do |arg1|
  RegressionTest::CliExec::exec(@cmd,arg1,ignore: '(##BioVcf|date|"version":)').should be_true
end

Then(/^I expect an error and the named output to match the named output "(.*?)" in under (\d+) seconds$/) do |arg1,arg2|
  RegressionTest::CliExec::exec(@cmd,arg1,ignore: '(FATAL|Waiting|from|vcf|Options|Final pid)',should_fail: true,timeout:arg2.to_i).should be_true
end
