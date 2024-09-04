defmodule AxigbeWeb.Auth.Overrides do
  use AshAuthentication.Phoenix.Overrides
  alias AshAuthentication.Phoenix.{Components}







  override Components.Banner do
    set :root_class, "w-full flex justify-center py-2"
    set :href_class, nil
    set :href_url, "/"
    set :image_class, "block dark:hidden h-12 w-auto sm:h-14"
    set :dark_image_class, "hidden dark:block h-12 w-auto sm:h-14"

    set :image_url,
        "/images/logo-white.svg"

    set :dark_image_url,
      "/images/logo-white.svg"


  end










end
