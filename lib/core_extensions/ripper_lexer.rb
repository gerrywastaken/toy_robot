require 'ripper'

module CoreExtensions
  class Ripper
    # This patch was added to address an error in Ruby 2.3.0 where squiggly
    # heredocs cause errors when running specs. I will remove this patch as soon
    # as there is a stable relase with the fix. At the moment the fix is only in
    # trunk.
    # https://github.com/ruby/ruby/commit/a43f2cbaa11c792cf417c6400d76710df77cd1
    # Patch source (I made slight modifications to pass RuboCop checks):
    # https://github.com/rspec/rspec-core/issues/2163#issuecomment-193657248
    class Lexer
      def on_heredoc_dedent(v, w)
        @buf.last.each do |e|
          if e.event == :on_tstring_content
            next unless (n = dedent_string(e.tok, w)) > 0
            e.pos[1] += n
          end
        end
        v
      end
    end
  end
end
