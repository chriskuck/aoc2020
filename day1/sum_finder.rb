exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
report = File.read(ARGV[0])

two_combo = report.split.map(&:to_i).combination(2).map { |c| [ c[0], c[1], c[0]+c[1] ] }.find {|e| e[2] == 2020 }
three_combo = report.split.map(&:to_i).combination(3).map { |c| [ c[0], c[1], c[2], c[0]+c[1]+c[2] ] }.find {|e| e[3] == 2020 }

puts "2: #{two_combo.to_s} - #{two_combo[0]*two_combo[1]}"
puts "3: #{three_combo.to_s} - #{three_combo[0]*three_combo[1]*three_combo[2]}"
