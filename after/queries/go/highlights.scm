; extends

; Struct

[
  "struct"
] @struct

; Interface

[
  "interface"
] @interface

; Field declaration types

(field_declaration_list
  (field_declaration
    name: (field_identifier) 
    type: (type_identifier) @property.type))

; Type element
(generic_type
  type: (type_identifier)
  type_arguments: (type_arguments
    (type_elem
      (type_identifier) @type.parameter)))
