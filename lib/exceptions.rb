# Holds information about command parsing issues
class ParseError < Exception; end

# An exception wrapper for requests outside of the platform
class OutsideBounds < Exception; end

# Holds information about requests for an unknown direction.
class InvalidDirextion < Exception; end

# Hold information about object moves that would end up outside of a platform.
class InvalidMove < Exception; end
