# coding: utf-8
class Producer < ApplicationRecord
  has_many :liquors
  validates_presence_of :name, :message => 'El nombre introducido existe'
  validates_uniqueness_of :name, :message => 'El nombre no es único'
  validates_length_of :name, :in => 2..255, :message => 'El nombre ha de tener como mínimo 2 caracteres y como máximo 255 caracteres'
end
