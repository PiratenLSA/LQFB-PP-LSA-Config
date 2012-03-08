config.app_name = "LiquidFeedback"
config.app_version = "beta33"

config.absolute_base_url = "/".. config.instance_prefix .. "/"

config.app_title = config.app_name .. " der " .. config.instance_name

config.app_logo = "logo.png"

config.app_service_provider = "Piratenpartei Sachsen-Anhalt<br />Pflugstr. 9a<br />10115 Berlin<br /><br /><br \>E-Mail Administratoren: <a href='mailto:it@piraten-lsa.de'>it@piraten-lsa.de</a><br /><br />Weitere Informationen & FAQ: <a href='http://wiki.piratenpartei.de/LQPP'>http://wiki.piratenpartei.de/LQPP</a>"

config.use_terms = "=== Nutzungsbedingungen ===\nAlles ist verboten"
--config.use_terms_html = ""

config.use_terms_checkboxes = {
  {
    name = "nutzungsbedingungen_v1",
    html = "Ich akzeptiere die Bedingungen.",
    not_accepted_error = "Du musst die Bedingungen akzeptieren, um dich zu registrieren."
  }
}


config.member_image_content_type = "image/jpeg"
config.member_image_convert_func = {
  avatar = function(data) return os.pfilter(data, "convert", "jpeg:-", "-thumbnail",   "48x48", "jpeg:-") end,
  photo =  function(data) return os.pfilter(data, "convert", "jpeg:-", "-thumbnail", "240x240", "jpeg:-") end
}

config.member_image_default_file = {
  avatar = "avatar.jpg",
  photo = nil
}

config.formatting_engine_executeables = {
  rocketwiki= "/opt/rocketwiki-lqfb/rocketwiki-lqfb",
  compat = "/opt/rocketwiki-lqfb/rocketwiki-lqfb-compat"
}

config.default_lang = "de"

-- after how long is a user considered inactive and the trustee will see warning
-- notation is according to postgresql intervals
config.delegation_warning_time = '6 months'

config.mail_subject_prefix = "[LiquidFeedback] "
config.mail_from = { name = "lqfb.piraten-lsa.de", address = "noreply@lqfb.piraten-lsa.de" }

config.fastpath_url_func = function(member_id, image_type)
  return config.absolute_base_url .. "fastpath/getpic?" .. tostring(member_id) .. "+" .. tostring(image_type)
end

config.download_dir = nil

config.download_use_terms = "=== Nutzungsbedingungen ===\nAlles ist verboten"

config.public_access = false  -- Available options: "anonymous", "pseudonym"

config.api_enabled = true

config.feature_rss_enabled = false -- feature is broken

-- OpenID authentication is not fully implemented yet, DO NOT USE BEFORE THIS NOTICE HAS BEEN REMOVED!
config.auth_openid_enabled = false
config.auth_openid_https_as_default = true
config.auth_openid_identifier_check_func = function(uri) return false end

request.set_allowed_json_request_slots{ "title", "actions", "support", "default", "trace", "system_error" }


if request.get_json_request_slots() then
  request.force_absolute_baseurl()
end

request.set_404_route{ module = 'index', view = '404' }

-- uncomment the following two lines to use C implementations of chosen
-- functions and to disable garbage collection during the request, to
-- increase speed:
--
-- require 'webmcp_accelerator'
-- collectgarbage("stop")

-- open and set default database handle
db = assert(mondelefant.connect{
  engine='postgresql',
  dbname='liquid_feedback_' .. config.instance_prefix
})
at_exit(function() 
  db:close()
end)
function mondelefant.class_prototype:get_db_conn() return db end

-- enable output of SQL commands in trace system
function db:sql_tracer(command)
  return function(error_info)
    local error_info = error_info or {}
    trace.sql{ command = command, error_position = error_info.position }
  end
end

request.set_absolute_baseurl(config.absolute_base_url)



-- TODO abstraction
-- get record by id
function mondelefant.class_prototype:by_id(id)
  local selector = self:new_selector()
  selector:add_where{ 'id = ?', id }
  selector:optional_object_mode()
  return selector:exec()
end

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
      <td style=\"padding-left:1.4em;font-size: 90%;\">\
        <a href=\"/" .. config.instance_prefix .. "/index/usage_terms.html\">Nutzungsbedingungen</a>\
      </td>\
      <td style=\"padding-left:1.4em;font-size: 90%;\">\
        <a href=\"/" .. config.instance_prefix .. "/static/doc/pseudonyme.html\">Hinweise zum Umgang mit Pseudonymen</a>\
      </td>\
      <td align=\"center\" style=\"font-size: 90%;\">\
        <a href=\"" .. config.mitgliedwerden .. "\">Mitglied werden</a>\
      </td>\
      <td align=\"right\" style=\"padding-right:1.4em;font-size: 90%;\">\
        <a href=\"/" .. config.instance_prefix .. "/index/about.html\">Impressum</a>\
      </td>\
    </tr>\
  </tbody>\
</table>"
