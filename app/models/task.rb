class Task < ApplicationRecord
  belongs_to :project

  validates :status, inclusion: { in: ['Not Started', 'In Progress', 'Complete']}
  validates :name, presence: true, allow_blank: false
  STATUS_OPTIONS = [
  'Not Started', 'In Progress', 'Complete']

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

  def complete?
    status == 'Complete'
  end

  def in_progress?
    status == 'In Progress'
  end

  def not_started?
    status == 'Not Started'
  end
end
