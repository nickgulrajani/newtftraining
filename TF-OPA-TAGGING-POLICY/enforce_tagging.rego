package azurepolicy

default allow = false

# Define allowed tags and their values
allowed_tags = {
  "Environment": ["Development", "Production"],
  "Department": ["IT", "Finance", "HR"]
}

# Check if the resource has all the required tags and their values are allowed
allow {
  all_tags_present
  all_tags_allowed
}

# Check if all the required tags are present
all_tags_present {
  required_tags := ["Development", "IT"]
  required_tags[_] = tag
  tag = input.tags[required_tags[_]]
}

# Check if all the tags are allowed based on the allowed_tags defined above
all_tags_allowed {
  tag_name = tag
  allowed_values = allowed_tags[tag_name]
  allowed_values[_] = value
  value = input.tags[tag_name]
}

