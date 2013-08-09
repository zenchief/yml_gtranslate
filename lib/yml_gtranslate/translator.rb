require 'json'
require 'uri'
require 'ya2yaml'
require 'yaml'


module YmlGtranslate
	class Translator
		def initialize(from_lang, to_lang, dir)
		  @from_lang = from_lang
			@to_lang = to_lang
			@directory = dir
		end



		def translate(string)
			command = <<-EOF
			curl -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20100101 Firefox/5.0" "http://translate.google.com/translate_a/t?client=t&text=#{URI.escape(string)}&hl=#{@from_lang}&sl=auto&tl=#{@to_lang}&multires=1&prev=conf&psl=auto&ptl=#{@from_lang}&otf=1&it=sel.7123%2Ctgtd.3099&ssel=0&tsel=4&uptl=#{@to_lang}&sc=1"
			EOF
			command.strip!
			res = `#{command}`.gsub!(/,+/, ",")
			JSON.parse(res).first.first.first.strip + "#i18n-GT"
		end


		def compare(hash1, hash2)
		 hash1.inject({}) do |h, pair|
			 key, value = pair
			 if hash2.key?(key)
				 h[key] = value.is_a?(Hash) ? compare(value, hash2[key]) : hash2[key]
			 else
				 h[key] = value.is_a?(Hash) ? compare(value, {}) : value.is_a?(String) ? translate(value) : value  
			 end
			 h
		 end
		end
    
    
	
  
  def translate_locales
    regexp = "*#{@from_lang}.yml"

    Dir.glob(File.join(@directory, regexp)).each do |f|
			prefix = f.split("#{@from_lang}.yml").first.to_s
			to_file =  "#{prefix}#{@to_lang}.yml"
			from_hash = YAML.load_file(f)[@from_lang.to_s]
		
			to_hash = {}
			if File.exists?(to_file)
				incomment = "sed s/\\\"\\ #i18n-GT/#i18n-GT\\\"/g #{to_file} > tmp.yml; rm #{to_file}; mv tmp.yml #{to_file}"
				`#{incomment}`
				to_hash = YAML.load_file(to_file)[@to_lang.to_s]
			end

			result = compare(from_hash, to_hash)

			File.open("#{to_file}", 'w') do |out|
				out.write({@to_lang.to_s => result}.ya2yaml)
			end

			comment = "sed s/#i18n-GT\\\"/\\\"\\ #i18n-GT/g #{to_file} > tmp.yml; rm #{to_file}; mv tmp.yml #{to_file}"
		
			`#{comment}`
		end
  end


	end
end
