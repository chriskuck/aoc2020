require 'pry'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
passwords = File.read(ARGV[0])

pol_pass_arr = passwords.split("\n").map { |pol_pass| pol_pass.split(':') }
policy_passwords = pol_pass_arr.map do |pol, pass|
  {
    policy: {
      char: pol.split(" ")[1],
      min: pol.split(" ")[0].split("-")[0].to_i,
      max: pol.split(" ")[0].split("-")[1].to_i
    },
    password: pass
  }
end

valid_passwords = policy_passwords.select do |e|
  char_count = e[:password].count(e[:policy][:char])
  char_count >= e[:policy][:min] && char_count <= e[:policy][:max]
end

puts valid_passwords.size

