# frozen_string_literal: true

class OrderStateMachine
  include Statesman::Machine

  state :new, initial: true
  state :confirmed
  state :in_progress
  state :shipped
  state :cancelled

  transition from: :new, to: %i[confirmed cancelled]
  transition from: :confirmed, to: %i[in_progress cancelled]
  transition from: :in_progress, to: %i[shipped cancelled]
  transition from: :shipped, to: [:cancelled]

  after_transition(to: :cancelled) do |order, _transition|
    OrderMailer.order_cancelled(order).deliver
  end

  after_transition(to: :confirmed) do |order, _transition|
    OrderMailer.order_confirmation(order).deliver
  end

  after_transition(to: :in_progress) do |order, _transition|
    OrderMailer.order_in_progress(order).deliver
  end

  after_transition(to: :shipped) do |order, _transition|
    OrderMailer.order_shipped(order).deliver
  end

  def self.states_map
    {
      'new' => 'Niepotwierdzone',
      'confirmed' => 'Złożone przez klienta',
      'in_progress' => 'Przyjęte do realizacji',
      'shipped' => 'Wysłane',
      'cancelled' => 'Anulowane'
    }
  end
end
