module Codebreaker
  class Game

  	CODE_SIZE = 4

  	attr_accessor :attempts, :gamer_name
  	attr_reader   :user_code, :hint, :answer, :attempts_count, :hint_code, :secret_code

    def initialize(gamer_name)
      @secret_code = ""
      @gamer_name = gamer_name
      @attempts_count = 0
      @hint = false
      @hint_code = '****'
      @attempts = ''
    end
 
    def start
      @secret_code = CODE_SIZE.times.map{ |i| i = Random.new.rand(1..6).to_s }
    end

    def user_code_split(arg)
      @user_code = arg.split("")
    end

    def comparison_codes(user_code)
      @user_code = self.user_code_split(user_code)
      if attempts_count == attempts
      	return false
      elsif @secret_code == @user_code
      	return true
      else
      	@answer = ''
      	@attempts_count += 1
      	return self.create_answer
      end
    end

    def create_answer
      sc = @secret_code.dup
      for i in 0...CODE_SIZE
  		if sc[i] == @user_code[i]
  		  @answer << '+'
  		  sc[i] = 0
  		  @user_code[i] = 0
  		end
  	  end
	  for x in 0...CODE_SIZE
        
	  	for y in 0...CODE_SIZE
	  	  if sc[x] <=> '0' && sc[x] == @user_code[y]
	  	  	@answer << '-'
	  	  	sc[x] = 0
	  	  	@user_code[y] = 0
	  	  end
	  	end

	  end
	  @answer
    end

    def requests_hint
      if @hint == false
      	@hint = true
        rand_number = Random.new.rand(0...CODE_SIZE-1)
        @hint_code = @hint_code.split ''
        @hint_code[rand_number] = @secret_code[rand_number]
        return @hint_code.join
      else
      	return @hint_code.join
      end
    end


    def save_score
      hash = Hash.new
      return unless File.exists?("save_score.txt")
      item_fields = File.readlines('save_score.txt')
      item_fields.map do |i|
      	i = i.chomp.split(":")
      	hash[i[0]] = "#{i[1]}, #{i[2]}"
      end
      hash
    end
  
  end
end