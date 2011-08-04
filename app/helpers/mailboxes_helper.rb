module MailboxesHelper
  class Password
    class << self
      # Generate an MD5 salt string
      def salt
        seeds = ('a'..'z').to_a
        seeds.concat( ('A'..'Z').to_a )
        seeds.concat( (0..9).to_a )
        seeds.concat ['/', '.']
        seeds.compact!

        salt_string = '$1$'
        8.times { salt_string << seeds[ rand(seeds.size) ].to_s }
        salt_string << '$'

        salt_string
      end

      # Crypt a password suitable for use in shadow files
      def crypt( string )
        string.crypt( self.salt )
      end
    end
  end
end
