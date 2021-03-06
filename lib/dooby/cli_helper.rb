module Dooby
  class CLIHelper
    
    DEL_TASKS = "Sure you want to delete all the items???".red_on_white.bold
    TRASH = "Sure you want to delete the .dooby directory???".red_on_white.bold
    
    def self.flush?
      agree DEL_TASKS, true      
    end
    
    def self.trash?
      agree TRASH, true
    end
    
    def self.keep_asking(question, autocompletion = [])
      Readline.basic_word_break_characters = 
          Readline.basic_word_break_characters.delete("@")
      Readline.completion_append_character = " "
      Readline.completion_proc = proc { |s| autocompletion.grep( /^#{Regexp.escape(s)}/ ) }
      
      stty_save = `stty -g`.chomp
      
      while value = Readline.readline(question, true)
          exit if value == 'q'
          yield value.chomp.strip
      end      

      rescue Interrupt
        system("stty", stty_save)
        exit
    end
    
  end
end