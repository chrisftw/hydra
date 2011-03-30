
Hydra::Application.config.middleware.use "GatherSite", "Gather Site Information"
Hydra::Application.config.middleware.use "PublicSiteData", "Site Specific Public Directory"
