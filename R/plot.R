library(tidyverse)
library(tantastic)

slack_messages <- readRDS("data/tan_slack_messages.rds")

slack_messages %>%
  mutate(message_type = fct_reorder(message_type, n) %>% fct_relevel("other", after = 0)) %>%
  ggplot(aes(x = ym, y = n, fill = message_type)) +
  geom_col(color = "white") +
  annotate("text", x = "2020-02", y = 100, label = "Joined \nR4DS", hjust = 0.5) +
  annotate("curve", x = 1.3, xend = 1.35, y = 100, yend = 40, curvature = -0.2,
           arrow = arrow(angle = 20,length = unit(6,"points"),type = "closed"), color = "white") +
  annotate("text", x = 2.75, y = 350, label = "Advanced R Book Club", hjust = 1) +
  annotate("curve", x = 2.75, xend = 3, y = 330, yend = 225, curvature = -0.2,
           arrow = arrow(angle = 20,length = unit(6,"points"),type = "closed"), color = "white") +
  annotate("curve", x = 2.75, xend = 3, y = 330, yend = 225, curvature = -0.2,
           arrow = arrow(angle = 20,length = unit(6,"points"),type = "closed"), color = "white") +
  annotate("curve", x = 3, xend = 5, y = 350, yend = 325, curvature = -0.2,
           arrow = arrow(angle = 20,length = unit(6,"points"),type = "closed"), color = "white") +
  annotate("text", x = 8.5, y = 500, label = "Released\nffscrapr v1.0.0\nto CRAN", hjust = 0) +
  annotate("curve", x = 8.25, xend = 7.5, y = 500, yend = 450, curvature = 0.2,
           arrow = arrow(angle = 20,length = unit(6,"points"),type = "closed"), color = "white") +
  annotate("text", x = 8.2, y = 350, label = "R Packages \n Book Club", hjust = 0.5) +
  annotate("curve", x = 8.25, xend = 8.4, y = 320, yend = 250, curvature = -0.2,
           arrow = arrow(angle = 20,length = unit(6,"points"),type = "closed"), color = "white") +
  annotate("text", x = 11, y = 400, label = "Advent of Code", hjust = 0) +
  annotate("curve", x = 10.9, xend = 10.6, y = 390, yend = 320, curvature = 0.2,
           arrow = arrow(angle = 20,length = unit(6,"points"),type = "closed"), color = "white") +
  annotate("text", x = 14.5, y = 350, label = "Started Twitch \nStreaming", hjust = 0.5) +
  annotate("curve", x = 14, xend = 13.45, y = 340, yend = 280, curvature = 0.2,
           arrow = arrow(angle = 20,length = unit(6,"points"),type = "closed"), color = "white") +
  annotate("text", x = 15.5, y = 200, label = "Lockdown \ndepression", hjust = 0.5) +
  annotate("text", x = 17, y = 400, label = "Released\nffsimulator v1.0.0 \nto CRAN", hjust = 0.5) +
  annotate("curve", x = 17.25, xend = 17.85, y = 360, yend = 200, curvature = -0.2,
           arrow = arrow(angle = 20,length = unit(6,"points"),type = "closed"), color = "white") +
  scale_x_discrete(guide = guide_axis(check.overlap = TRUE)) +
  scale_fill_brewer(palette = "Dark2", direction = -1, guide = guide_legend(title = "Channel Type", reverse = TRUE)) +
  theme_tantastic() +
  labs(
    title = "Tan's R4DS Slack Community Messages Per Month",
    subtitle = "also an accidental story of my pandemic",
    caption = "@_TanHo | R4DS Online Learning Slack Community"
  ) +
  theme(
    legend.position = c(0,0),
    legend.justification = c("left","top"),
    legend.direction = "horizontal",
    legend.margin = margin(30,0,10,6),
    plot.caption = element_text(margin = margin(25)),
    axis.title.x = element_blank(),
    axis.title.y = element_blank()
  )

ggsave("tan_slack_messages.png",width = 16, height = 9)
