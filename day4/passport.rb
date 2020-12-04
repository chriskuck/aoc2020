class Passport

  attr_accessor :birth_year, :issue_year, :expire_year, :height, :hair_color, :eye_color
  attr_accessor :passport_id, :country_id

  FIELD_MAP = { 
    "byr": 'birth_year',
    "iyr": 'issue_year',
    "eyr": 'expire_year',
    "hgt": 'height',
    "hcl": 'hair_color',
    "ecl": 'eye_color',
    "pid": 'passport_id',
    "cid": 'country_id'
  }

  def initialize(passport_str)
    key_values = passport_str.join(" ").split(" ").compact
    key_values
      .map { |kv| kv.split(":") }
      .each { |key,value| 
         field_sym = FIELD_MAP[key.to_sym].to_s
         self.send(field_sym+"=", value)
      }
  end

  def valid?
    return false if !year_validator(:birth_year, 4, 1920, 2002)
    return false if !year_validator(:issue_year, 4, 2010, 2020)
    return false if !year_validator(:expire_year, 4, 2020, 2030)
    return false if !height_valid?
    return false if !hair_color_valid?
    return false if !eye_color_valid?
    return false if !passport_id_valid?

    true
  end

  def year_validator(field_name, length, min, max)
    field = self.send(field_name)
    return false if field.nil?
    return false if field.length != length
    field.to_i >= min && field.to_i <= max
  end

  def height_valid?
    return false if height.nil?
    match = height.match(/(\d+)(cm|in)/)
    return false if match.nil?
    return false if match[2] == "cm" && (match[1].to_i < 150 || match[1].to_i > 193)
    return false if match[2] == "in" && (match[1].to_i < 59 || match[1].to_i > 76)
    true
  end

  def hair_color_valid?
    return false if hair_color.nil?
    match = hair_color.match(/#[a-f0-9]{6}/)
    !match.nil?
  end

  def eye_color_valid?
    return false if eye_color.nil?
    ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include?(eye_color)
  end

  def passport_id_valid?
    return false if passport_id.nil?
    match = passport_id.match(/^\d{9}$/)
    !match.nil?
  end
end
