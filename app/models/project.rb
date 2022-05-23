class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user

  def badge_color
    case status
    when 'Not Started'
      'secondary'
    when 'In Progress'
      'info'
    else
      'success'
    end
  end

  def status
    return 'Not Started' if tasks.none?
    if tasks.all? { |task| task.complete? }
      'Complete'
    elsif tasks.any? { |task| task.in_progress? || task.complete? }
      'In Progress'
    else
      'Not Started'
    end
  end

  def percent_complete
    return 0 if tasks.none?
    ((total_complete.to_f / total_tasks) * 100).round
  end

  def total_complete
    tasks.select { |task| task.complete? }.count
  end

  def total_tasks
    tasks.count
  end
end
