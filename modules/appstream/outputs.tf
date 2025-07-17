output "fleet_id" {
  description = "ID of the AppStream fleet."
  value       = aws_appstream_fleet.this.id
}

output "stack_id" {
  description = "ID of the AppStream stack."
  value       = aws_appstream_stack.this.id
}

output "image_builder_id" {
  description = "ID of the AppStream image builder."
  value       = aws_appstream_image_builder.this.id
}
