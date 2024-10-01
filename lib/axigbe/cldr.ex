defmodule Axigbe.Cldr do
  use Cldr,
    locales: ["fr", "en"],
    default_locale: "fr",
    providers: [Cldr.Number, Money]
end
