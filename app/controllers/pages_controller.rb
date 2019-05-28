class PagesController < ApplicationController
  def about
    @title = 'Sobre nosotros'
    @content = 'Somos una empresa que lleva 38 años en el mercado.'
  end
end
