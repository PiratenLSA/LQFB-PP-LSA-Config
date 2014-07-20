config.app_name = "LiquidFeedback"

config.absolute_base_url = "https://lqfb.piraten-lsa.de/" .. config.instance_prefix .. "/"

-- config.app_title = config.app_name .. " der " .. config.instance_name

-- config.app_logo = "logo.png"

config.app_service_provider = "Piratenpartei Sachsen-Anhalt<br />Pflugstr. 9a<br />10115 Berlin<br /><br /><br \>E-Mail Administratoren: <a href='mailto:lqfb@piraten-lsa.de'>lqfb@piraten-lsa.de</a><br /><br />Weitere Informationen & FAQ: <a href='http://wiki.piratenpartei.de/LSA:LiquidFeedback'>http://wiki.piratenpartei.de/LSA:LiquidFeedback</a>"

config.use_terms = "=== Nutzungsbedingungen ===\nAlles ist verboten"
--config.use_terms_html = ""

config.use_terms_checkboxes = {
  {
    name = "nutzungsbedingungen_v1",
    html = "Ich akzeptiere die Bedingungen.",
    not_accepted_error = "Du musst die Bedingungen akzeptieren, um dich zu registrieren."
  }
}


config.formatting_engine_executeables = {
  rocketwiki= "/opt/rocketwiki-lqfb/rocketwiki-lqfb",
  compat = "/opt/rocketwiki-lqfb/rocketwiki-lqfb-compat"
}

config.default_lang = "de"

-- after how long is a user considered inactive and the trustee will see warning
-- notation is according to postgresql intervals
config.delegation_warning_time = '6 months'

config.mail_envelope_from = "noreply@lqfb.piraten-lsa.de"
config.mail_from = { name = "LiquidFeedback - Piratenpartei Sachsen-Anhalt", address = "noreply@lqfb.piraten-lsa.de" }
config.mail_reply_to = "lqfb@piraten-lsa.de"

config.fastpath_url_func = function(member_id, image_type)
  return config.absolute_base_url .. "fastpath/getpic?" .. tostring(member_id) .. "+" .. tostring(image_type)
end

config.public_access = "none"  -- Available options: "none", "anonymous", "pseudonym", "authors_pseudonymous", "all_pseudonymous", "everything"

-- require 'webmcp_accelerator'
-- if cgi then collectgarbage("stop") end

config.database = { engine='postgresql', dbname='liquid_feedback_' .. config.instance_prefix }

config.footer_html = "<table style=\"width:100%;font-weight:bold;font-size: 90%; margin-top: 8px;\">\
  <colgroup>\
    <col width=\"25%\" />\
    <col width=\"25%\" />\
    <col width=\"25%\" />\
    <col width=\"25%\" />\
  </colgroup>\
  <tbody>\
    <tr>\
      <td colspan=\"4\" style=\"padding-left:1em;padding-right:1em;\"><hr></td>\
    </tr>\
    <tr>\
      <td style=\"font-size: 90%;text-align: center;\">\
        <a href=\"" .. config.absolute_base_url .. "index/usage_terms.html\">Nutzungsbedingungen</a>\
      </td>\
      <td style=\"font-size: 90%;text-align: center;\">\
        <a href=\"" .. config.absolute_base_url .. "static/doc/pseudonyme.html\">Hinweise zum Umgang mit Pseudonymen</a>\
      </td>\
      <td style=\"font-size: 90%;text-align: center;\">\
        <a href=\"" .. config.mitgliedwerden .. "\">Mitglied werden</a>\
      </td>\
      <td style=\"font-size: 90%;text-align: center;\">\
        <a href=\"" .. config.absolute_base_url .. "index/about.html\">Impressum</a>\
      </td>\
    </tr>\
  </tbody>\
</table>"


execute.config("init")
