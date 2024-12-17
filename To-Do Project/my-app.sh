#!/bin/bash

# File to store tasks
task_file="todo_list.txt"
# File to store logs
log_file="log.txt"

# Function to display the menu
display_menu() {
  echo "\n==================== To-Do List Manager ===================="
  echo "1. Add a Task"
  echo "2. View All Tasks"
  echo "3. Update a Task"
  echo "4. Delete a Task"
  echo "5. Categorize Tasks"
  echo "6. Exit"
  echo "========================================================="
}

# Function to add a task
add_task() {
  echo -n "Enter task description: "
  read description
  echo -n "Enter task category (e.g., Work, Personal, Study): "
  read category
  echo -n "Enter due date (YYYY-MM-DD): "
  read due_date

  echo "$description | $category | $due_date" >> "$task_file"
  echo "Task added successfully!"
}

# Function to view all tasks
view_tasks() {
  if [ ! -s "$task_file" ]; then
    echo "No tasks found!"
    return
  fi

  echo "\n==================== All Tasks ====================="
  echo "ID | Description | Category | Due Date"
  echo "---------------------------------------------------"
  nl -s " | " "$task_file"
  echo "==================================================="
}

# Function to update a task
update_task() {
  view_tasks

  echo -n "Enter the task ID to update: "
  read task_id

  if ! sed -n "${task_id}p" "$task_file" > /dev/null 2>&1; then
    echo "Invalid task ID!"
    return
  fi

  old_task=$(sed -n "${task_id}p" "$task_file")

  echo -n "Enter new task description: "
  read new_description
  echo -n "Enter new task category: "
  read new_category
  echo -n "Enter new due date (YYYY-MM-DD): "
  read new_due_date

  sed -i "${task_id}s/.*/$new_description | $new_category | $new_due_date/" "$task_file"
  new_task="$new_description | $new_category | $new_due_date"

  echo "Task updated successfully!"
  echo "Updated Task ID $task_id: \nOld: $old_task\nNew: $new_task" >> "$log_file"
}

# Function to delete a task
delete_task() {
  view_tasks

  echo -n "Enter the task ID to delete: "
  read task_id

  if ! sed -n "${task_id}p" "$task_file" > /dev/null 2>&1; then
    echo "Invalid task ID!"
    return
  fi

  deleted_task=$(sed -n "${task_id}p" "$task_file")
  sed -i "${task_id}d" "$task_file"

  echo "Task deleted successfully!"
  echo "Deleted Task ID $task_id: $deleted_task" >> "$log_file"
}

# Function to categorize tasks
categorize_tasks() {
  if [ ! -s "$task_file" ]; then
    echo "No tasks found!"
    return
  fi

  echo -n "Enter category to filter by: "
  read category

  echo "\n==================== Tasks in '$category' =================="
  grep -i "| $category |" "$task_file" || echo "No tasks found in this category."
  echo "========================================================="
}

# Main script execution loop
while true; do
  display_menu
  echo -n "Enter your choice: "
  read choice

  case $choice in
    1)
      add_task
      ;;
    2)
      view_tasks
      ;;
    3)
      update_task
      ;;
    4)
      delete_task
      ;;
    5)
      categorize_tasks
      ;;
    6)
      echo "Exiting To-Do List Manager. Goodbye!"
      exit 0
      ;;
    *)
      echo "Invalid choice. Please try again."
      ;;
  esac

done

