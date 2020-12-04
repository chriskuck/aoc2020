require './passport'
require 'pry'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
passport_strings = File.read(ARGV[0]).split("\n").map { |s| s.empty? ? :break : s }.append(:break)

current_entry = []
passports = []

passport_strings.each do |str|
  if str == :break
    passport = Passport.new(current_entry)
    puts passport.passport_id if passport.valid?
    passports << passport
    current_entry = []
  else
    current_entry << str
  end
end

puts "valid passports #{passports.count { |p| p.valid? } }"
