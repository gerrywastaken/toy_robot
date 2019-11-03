# Holds information about command parsing issues
class ParseError < RuntimeError; end

# An exception wrapper for requests outside of the platform
class OutsideBounds < RuntimeError; end

# Holds information about requests for an unknown direction.
class InvalidDirextion < RuntimeError; end

# Hold information about object moves that would end up outside of a platform.
class InvalidMove < RuntimeError; end
