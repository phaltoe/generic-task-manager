module ApplicationHelper
  def toggle_button(task)
    if policy(task).toggle_complete?
      button_text = task.completed? ? 'Mark incomplete' : 'Mark completed'
      button_to button_text, project_toggle_task_complete_path(task.project, task), { class: 'btn btn-xs' }
    end
  end

  def destroy_button(task)
    if policy(task).destroy?
      button_to 'Delete task', project_task_path(task.project, task), method: "delete", class: 'btn btn-xs'
    end
  end
end
