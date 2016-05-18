# Holds information about command parsing issues
class ParseError < Exception; end

# An exception wrapper for requests outside of the platform
class OutsideBounds < Exception; end
