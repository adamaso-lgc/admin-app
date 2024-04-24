variable "service_name" {
  description = "Defines the service the generated table belongs to"
  type = string
}

variable "table" {
  description = "Purpose of the table in the app"
  type = string
}

variable "attribute_hash_key" {
  default = {
      name = "HashKey",
      type = "S",
  }
  type = object({ name = string, type = string })
}

variable "attribute_range_key" {
  default = {
      name = "RangeKey",
      type = "S", 
   }
  type = object({ name = string, type = string })
}

variable "stream_enabled" {
  type = bool
  default = true
}

variable "environment" {
  description = "The environment of the table"
  type        = string
}