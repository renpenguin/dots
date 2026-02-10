{ ... }: {
  programs.librewolf = {
    enable = true;

    languagePacks = [ "en-GB" ];
    settings = {
      "browser.toolbars.bookmarks.visibility" = "newtab";
      "browser.tabs.allowTabDetach" = false;
      "middlemouse.paste" = false;

      "browser.search.separatePrivateDefault" = false;

      "identity.fxaccounts.enabled" = true;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = false;
      "webgl.disabled" = false;
      "privacy.resistFingerprinting" = false;
      "network.cookie.lifetimePolicy" = 0;

      "cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
      "cookiebanners.service.mode" = 2; # Block cookie banners
      "privacy.donottrackheader.enabled" = true;
      "privacy.fingerprintingProtection" = true;
    };
  };

  # System-wide
  # programs.firefox = {
  #   enable = true;
  #   package = pkgs.librewolf;
  #
  #   languagePacks = [ "en-GB" ];
  #   
  #   policies = { # https://mozilla.github.io/policy-templates/
  #     DisableTelemetry = true;
  #     DisableFirefoxStudies = true;
  #     Preferences = {
  #       "browser.toolbars.bookmarks.visibility" = "newtab";
  #       "browser.search.separatePrivateDefault" = false;
  #       "middlemouse.paste" = false;
  #
  #       "identity.fxaccounts.enabled" = true;
  #       "privacy.clearOnShutdown.history" = false;
  #       "privacy.clearOnShutdown.downloads" = false;
  #
  #       "cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
  #       "cookiebanners.service.mode" = 2; # Block cookie banners
  #       "privacy.donottrackheader.enabled" = true;
  #       "privacy.fingerprintingProtection" = true;
  #       "privacy.resistFingerprinting" = true;
  #       "privacy.trackingprotection.emailtracking.enabled" = true;
  #       "privacy.trackingprotection.enabled" = true;
  #       "privacy.trackingprotection.fingerprinting.enabled" = true;
  #       "privacy.trackingprotection.socialtracking.enabled" = true;
  #     };
  #     SearchEngines = {
  #       "Default" = "DuckDuckGo";
  #       "Remove" = [ "Bing" "Google" ];
  #       "Add" = [
  #         {
  #           Name = "Brave Search";
  #           URLTemplate = "https://search.brave.com/search?q={searchTerms}";
  #           Method = "GET";
  #           IconURL = "https://brave.com/favicon.ico";
  #           Alias = ":b";
  #           Description = "Description";
  #           PostData = "name=value&q={searchTerms}";
  #           SuggestURLTemplate = "https://www.search.brave.com/suggestions/q={searchTerms}";
  #         }
  #       ];
  #     };
  #     ExtensionSettings = {
  #       "jid1-ZAdIEUB7XOzOJw@jetpack" = { # DuckDuckGo Privacy Essentails
  #         install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
  #         installation_mode = "force_installed";
  #       };
  #       "uBlock0@raymondhill.net" = { # uBlock Origin
  #         install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
  #         installation_mode = "force_installed";
  #       };
  #       "wayback_machine@mozilla.org" = { # Wayback Machine
  #         install_url = "https://addons.mozilla.org/firefox/downloads/latest/wayback-machine_new/latest.xpi";
  #         installation_mode = "force_installed";
  #       };
  #       "addon@darkreader.org" = { # Dark Reader
  #         install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
  #         installation_mode = "force_installed";
  #       };
  #     };
  #   };
  # };
}
