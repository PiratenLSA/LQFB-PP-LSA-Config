config.instance_name = "Piratenpartei Sachsen-Anhalt"
config.instance_prefix = "lsa"

config.mitgliedwerden = "https://www.piraten-lsa.de/mitglied-werden"

execute.config("default")

config.use_terms = "=== Nutzungsbedingungen ===\nFür die Nutzung von LiquidFeedback, nachfolgend System genannt, unter der Domain lqfb.piraten-lsa.de gelten die Nutzungsbedingungen des Landesverbandes Sachsen-Anhalt der Piratenpartei Deutschland. Jedem Pirat, der das System nutzt, sind diese bekannt; er erklärt sich durch Login in das System unter vorgenannter Domain mit ihnen einverstanden.\n\n# Jeder LSA-Pirat, Nutzer genannt, erhält einen Zugang zum System. \n# Jeder Nutzer wird hiermit ausdrücklich darauf hingewiesen, dass alle Einträge und Einstellungen, die er vornimmt, aus Gründen der Nachvollziehbarkeit (Transparenz) für unbegrenzte Zeit im System erhalten bleiben und auch veröffentlicht werden können. Dies gilt auch im Fall des Parteiaustritts.\n# Der Nutzer kann eine Pseudonymisierung seiner Einträge durch Verwendung eines Pseudonyms erreichen.\n# Eine Anonymisierung ist prinzipiell nicht möglich.\n# Dem Nutzer ist bekannt, dass jeder Nutzer die Datenbankinhalte zum Zwecke der Nachvollziehbarkeit herunterladen kann. Eine nachträgliche Pseudonymisierung dieser Daten ist daher nicht möglich.\n# Es ist dem Nutzer aus Gründen des Datenschutzes nicht gestattet, Datenbankinhalte, ganz oder teilweise, Dritten zugänglich zu machen. Ausgenommen hiervon ist eine Weitergabe an Mitglieder der Piratenpartei Deutschland, die diesen Nutzungsbedingungen zustimmen.\n# Der Nutzer darf seine Zugangsdaten nicht an Dritte, auch nicht an andere Piraten, weitergeben. Er darf das System nur selbst persönlich nutzen. Vollmacht zur Stimmübertragung darf ausschließlich systemintern als Delegation erfolgen. Nutzer, die aus persönlichen Gründen das System nicht uneingeschränkt nutzen können, können Ausnahmen beim Vorstand beantragen."

config.mail_subject_prefix = "[LQFB LSA] "

config.public_access = "anonymous"

config.delegation_warning_time = '3 months'

-- after which time a user is advised (_soft) or forced (_hard) to check
-- unit and area delegations. default: no check at all
-- ------------------------------------------------------------------------
-- config.check_delegations_interval_hard = "6 months"
-- config.check_delegations_interval_soft = "3 months"

-- default option when checking delegations
-- available options: "confirm", "revoke" and "none", default: "confirm"
-- ------------------------------------------------------------------------
-- config.check_delegations_default = "confirm"

config.issue_discussion_url_func = function(issue)
  return "http://piratenpad.de/" .. string.upper(config.instance_prefix) .. ":LiquidFeedback_Themendiskussion_" .. issue.id
end

-- config.motd_public = ""

-- config.motd_intern = config.motd_public

config.download_dir = "/opt/anondumps/"
