# Scatterplot con eruptions en el eje x y la variable waiting en el eje y 
ggplot(data = faithful, mapping = aes(x = eruptions, y = waiting)) + 
  geom_point()

# Colorear todos los puntos de color darkviolet
ggplot(faithful) + 
  geom_point(aes(x = eruptions, y = waiting),
             colour = 'steelblue')

# Colorear para en función de si su erupción es menor o mayor o igual que 3 minutos
ggplot(faithful) + 
  geom_point(aes(x = eruptions, y = waiting, colour = eruptions < 3))




# Separar con una línea horizontal los puntos con duración mayor y menor que 3.2 minutos
ggplot(faithful, aes(x = eruptions, y = waiting)) + 
  geom_point() +
  geom_vline(xintercept = 3.2) 

# Crear un histograma de las erupciones
ggplot(faithful) + 
  geom_histogram(aes(x = eruptions))

# Utilizar triángulos en vez de círculos y un tamaño de 3 para todos los puntos

ggplot(faithful, aes(x = eruptions, y = waiting)) + 
  geom_point(shape = 17, size = 3)


# colorear el histograma si la erupcion fue mayor o menos que 3.2 min
ggplot(faithful) + 
  geom_histogram(aes(x = eruptions, fill = eruptions < 3.2))


# colorear el histograma dependiendo si esperaro más o menos de un minuto
  ggplot(faithful) + 
    geom_histogram(aes(x = eruptions, fill = waiting < 60))
  
# colorear el histograma dependiendo si esperaro más o menos de un minuto
# añade un borde de color negro al plot anterior
  ggplot(faithful, aes(x = eruptions, fill = waiting < 60)) + 
    geom_histogram(color = "black")
  
# cambia las posiciones para que no se solapen
  ggplot(faithful, aes(x = eruptions, fill = waiting < 60)) + 
    geom_histogram(color = "black", position = "dodge")


######## Utilizando mpg
 
# Cuenta el numero de cada clase 
data("mpg")
ggplot(mpg) + 
  geom_bar(aes(x = class))





```{r}
ggplot(mpg) + 
  geom_jitter(aes(x = class, y = hwy), width = 0.2)
```

Hint: You will need to change the default geom of `stat_summary()`

### Scales
Scales define how the mapping you specify inside `aes()` should happen. All 
mappings have an associated scale even if not specified.

```{r}
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy, colour = class))
```

take control by adding one explicitly. All scales follow the same naming 
conventions.

```{r}
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy, colour = class)) + 
  scale_colour_brewer(type = 'qual')
```

Positional mappings (x and y) also have associated scales.

```{r}
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) + 
  scale_x_continuous(breaks = c(3, 5, 6)) + 
  scale_y_continuous(trans = 'log10')
```

#### Exercises
Use `RColorBrewer::display.brewer.all()` to see all the different palettes from
Color Brewer and pick your favourite. Modify the code below to use it

```{r}
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy, colour = class)) + 
  scale_colour_brewer(type = 'qual')
```

* * *

Modify the code below to create a bubble chart (scatterplot with size mapped to
a continuous variable) showing `cyl` with size. Make sure that only the present 
amount of cylinders (4, 5, 6, and 8) are present in the legend.

```{r}
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy, colour = class)) + 
  scale_colour_brewer(type = 'qual')
```

Hint: The `breaks` argument in the scale is used to control which values are
present in the legend.

Explore the different types of size scales available in ggplot2. Is the default
the most appropriate here?

* * *

Modify the code below so that colour is no longer mapped to the discrete `class`
variable, but to the continuous `cty` variable. What happens to the guide?

```{r}
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy, colour = class, size = cty))
```

* * *

The type of guide can be controlled with the `guide` argument in the scale, or 
with the `guides()` function. Continuous colours have a gradient colour bar by 
default, but setting it to `legend` will turn it back to the standard look. What 
happens when multiple aesthetics are mapped to the same variable and uses the 
guide type?

```{r}
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy, colour = cty, size = cty))
```

### Facets
The facet defines how data is split among panels. The default facet 
(`facet_null()`) puts all the data in a single panel, while `facet_wrap()` and
`facet_grid()` allows you to specify different types of small multiples

```{r}
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) + 
  facet_wrap(~ class)
```

```{r}
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) + 
  facet_grid(year ~ drv)
```

#### Exercises
One of the great things about facets is that they share the axes between the 
different panels. Sometimes this is undiserable though, and the behaviour can
be changed with the `scales` argument. Experiment with the different possible
settings in the plot below:

```{r}
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) + 
  facet_wrap(~ drv)
```

* * *

Usually the space occupied by each panel is equal. This can create problems when
different scales are used. Modify the code below so that the y scale differs 
between the panels in the plot. What happens?

```{r}
ggplot(mpg) + 
  geom_bar(aes(y = manufacturer)) + 
  facet_grid(class ~ .)
```

Use the `space` argument in `facet_grid()` to change the plot above so each bar 
has the same width again.

* * *

Facets can be based on multiple variables by adding them together. Try to 
recreate the same panels present in the plot below by using `facet_wrap()`

```{r}
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) + 
  facet_grid(year ~ drv)
```

### Coordinates
The coordinate system is the fabric you draw your layers on in the end. The 
default `coord_cartesion provides the standard rectangular x-y coordinate 
system. Changing the coordinate system can have dramatic effects
```{r}
ggplot(mpg) + 
  geom_bar(aes(x = class)) + 
  coord_polar()
```

```{r}
ggplot(mpg) + 
  geom_bar(aes(x = class)) + 
  coord_polar(theta = 'y') + 
  expand_limits(y = 70)
```

You can zoom both on the scale...

```{r}
ggplot(mpg) + 
  geom_bar(aes(x = class)) + 
  scale_y_continuous(limits = c(0, 40))
```

and in the coord. You usually want the latter as it avoids changing the plottet
data

```{r}
ggplot(mpg) + 
  geom_bar(aes(x = class)) + 
  coord_cartesian(ylim = c(0, 40))
```

#### Exercises
In the same way as limits can be set in both the positional scale and the coord,
so can transformations, using `coord_trans()`. Modify the code below to apply a
log transformation to the y axis; first using `scale_y_continuous()`, 
and then using `coord_trans()`. Compare the results — how do they differ?

```{r}
ggplot(mpg) + 
  geom_point(aes(x = hwy, y = displ))
```

* * *

Coordinate systems are particularly important in cartography. While we will not 
spend a lot of time with it in this workshop, spatial plotting is well supported
in ggplot2 with `geom_sf()` and `coord_sf()` (which interfaces with the sf 
package). The code below produces a world map. Try changing the `crs` argument 
in `coord_sf()` to be `'+proj=robin'` (This means using the Robinson projection). 

```{r}
# Get the borders of all countries
world <- sf::st_as_sf(maps::map('world', plot = FALSE, fill = TRUE))
world <- sf::st_wrap_dateline(world, 
                              options = c("WRAPDATELINE=YES", "DATELINEOFFSET=180"),
                              quiet = TRUE)
# Plot code
ggplot(world) + 
  geom_sf() + 
  coord_sf(crs = "+proj=moll")
```

Maps are a huge area in data visualisation and simply too big to cover in this 
workshop. If you want to explore further I advice you to explore the 
[r-spatial wbsite](https://www.r-spatial.org) as well as the website for the
[sf package](https://r-spatial.github.io/sf)

### Theme
Theming defines the feel and look of your final visualisation and is something
you will normally defer to the final polishing of the plot. It is very easy to 
change looks with a prebuild theme

```{r}
ggplot(mpg) + 
  geom_bar(aes(y = class)) + 
  facet_wrap(~year) + 
  theme_minimal()
```

Further adjustments can be done in the end to get exactly the look you want

```{r}
ggplot(mpg) + 
  geom_bar(aes(y = class)) + 
  facet_wrap(~year) + 
  labs(title = "Number of car models per class",
       caption = "source: http://fueleconomy.gov",
       x = NULL,
       y = NULL) +
  scale_x_continuous(expand = c(0, NA)) + 
  theme_minimal() + 
  theme(
    text = element_text('Avenir Next Condensed'),
    strip.text = element_text(face = 'bold', hjust = 0),
    plot.caption = element_text(face = 'italic'),
    panel.grid.major = element_line('white', size = 0.5),
    panel.grid.minor = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.ontop = TRUE
  )
```

#### Exercises
Themes can be overwhelming, especially as you often try to optimise for beauty 
while you learn. To remove the last part of the equation, the exercise is to 
take the plot given below and make it as hideous as possible using the theme
function. Go absolutely crazy, but take note of the effect as you change 
different settings.

```{r}
ggplot(mpg) + 
  geom_bar(aes(y = class, fill = drv)) + 
  facet_wrap(~year) + 
  labs(title = "Number of car models per class",
       caption = "source: http://fueleconomy.gov",
       x = 'Number of cars',
       y = NULL)
```

## Extensions
While ggplot2 comes with a lot of batteries included, the extension ecosystem 
provides priceless additinal features

### Plot composition
We start by creating 3 separate plots
```{r}
p1 <- ggplot(msleep) + 
  geom_boxplot(aes(x = sleep_total, y = vore, fill = vore))
p1
```

```{r}
p2 <- ggplot(msleep) + 
  geom_bar(aes(y = vore, fill = vore))
p2
```

```{r}
p3 <- ggplot(msleep) + 
  geom_point(aes(x = bodywt, y = sleep_total, colour = vore)) + 
  scale_x_log10()
p3
```

Combining them with patchwork is a breeze using the different operators

```{r}
library(patchwork)
p1 + p2 + p3
(p1 | p2) / 
   p3
p_all <- (p1 | p2) / 
            p3
p_all + plot_layout(guides = 'collect')
p_all & theme(legend.position = 'none')
p_all <- p_all & theme(legend.position = 'none')
p_all + plot_annotation(
  title = 'Mammalian sleep patterns',
  tag_levels = 'A'
)
```

#### Excercises
Patchwork will assign the same amount of space to each plot by default, but this
can be controlled with the `widths` and `heights` argument in `plot_layout()`. 
This can take a numeric vector giving their relative sizes (e.g. `c(2, 1)` will 
make the first plot twice as big as the second). Modify the code below so that
the middle plot takes up half of the total space:

```{r}
p <- ggplot(mtcars) + 
  geom_point(aes(x = disp, y = mpg))
p + p + p
```

* * *

The `&` operator can be used with any type of ggplot2 object, not just themes.
Modify the code below so the two plots share the same y-axis (same limits)

```{r}
p1 <- ggplot(mtcars[mtcars$gear == 3,]) + 
  geom_point(aes(x = disp, y = mpg))
p2 <- ggplot(mtcars[mtcars$gear == 4,]) + 
  geom_point(aes(x = disp, y = mpg))
p1 + p2
```

* * *

Patchwork contains many features for fine tuning the layout and annotation. Very
complex layouts can be obtained by providing a design specification to the 
`design` argument in `plot_layout()`. The design can be defined as a textual 
representation of the cells. Use the layout given below. How should the textual 
representation be undertood.

```{r}
p1 <- ggplot(mtcars) + 
  geom_point(aes(x = disp, y = mpg))
p2 <- ggplot(mtcars) + 
  geom_bar(aes(x = factor(gear)))
p3 <- ggplot(mtcars) + 
  geom_boxplot(aes(x = factor(gear), y = mpg))
layout <- '
AA#
#BB
C##
'
p1 + p2 + p3 + plot_layout(design = layout)
```

### Animation
ggplot2 is usually focused on static plots, but gganimate extends the API and
grammar to describe animations. As such it feels like a very natural extension
of using ggplot2

```{r}
ggplot(economics) + 
  geom_line(aes(x = date, y = unemploy))
library(gganimate)
ggplot(economics) + 
  geom_line(aes(x = date, y = unemploy)) + 
  transition_reveal(along = date)
```

There are many different transitions that control how data is interpreted for
animation, as well as a range of other animation specific features

```{r}
ggplot(mpg) + 
  geom_bar(aes(x = factor(cyl)))
ggplot(mpg) + 
  geom_bar(aes(x = factor(cyl))) + 
  labs(title = 'Number of cars in {closest_state} by number of cylinders') + 
  transition_states(states = year) + 
  enter_grow() + 
  exit_fade()
```

#### Exercises
The animation below will animate between points showing cars with different 
cylinders.

```{r}
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) + 
  ggtitle("Cars with {closest_state} cylinders") + 
  transition_states(factor(cyl))
```

gganimate uses the `group` aesthetic to match observations between states. By 
default the group aesthetic is set to the same value, so observations are 
matched by their position (first row of 4 cyl is matched to first row of 5 cyl 
etc.). This is clearly wrong here (why?). Add a mapping to the `group` aesthetic
to ensure that points do not move between the different states.

* * *

In the presence of discrete aesthetic mappings (`colour` below), the group is
deduced if not given. The default behaviour of objects that appear and disappear
during the animation is to simply pop in and out of existance. `enter_*()` and
`exit_*()` functions can be used to control this behaviour. Experiment with the
different enter and exit functions provided by gganimate below. What happens if 
you add multiple enter or exit functions to the same animation?

```{r}
ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy, colour = factor(cyl))) + 
  ggtitle("Cars with {closest_state} cylinders") + 
  transition_states(factor(cyl))
```

* * *

In the animation below (as in all the other animations) the changes happens at
constant speed. How values change during an animation is called easing and can
be controlled using the `ease_aes()` function. Read the documentation for 
`ease_aes()` and experiment with different easings in the animation.

```{r}
mpg2 <- tidyr::pivot_longer(mpg, c(cty,hwy))
ggplot(mpg2) + 
  geom_point(aes(x = displ, y = value)) + 
  ggtitle("{if (closest_state == 'cty') 'Efficiency in city' else 'Efficiency on highway'}") + 
  transition_states(name)
```

### Annotation
Text is a huge part of storytelling with your visualisation. Historically, 
textual annotations has not been the best part of ggplot2 but new extensions 
make up for that.

Standard geom_text will often result in overlaping labels
```{r}
ggplot(mtcars, aes(x = disp, y = mpg)) + 
  geom_point() + 
  geom_text(aes(label = row.names(mtcars)))
```

ggrepel takes care of that

```{r}
library(ggrepel)
ggplot(mtcars, aes(x = disp, y = mpg)) + 
  geom_point() + 
  geom_text_repel(aes(label = row.names(mtcars)))
```

If you want to highlight certain parts of your data and describe it, the 
`geom_mark_*()` family of geoms have your back

```{r}
library(ggforce)
ggplot(mtcars, aes(x = disp, y = mpg)) +
  geom_point() + 
  geom_mark_ellipse(aes(filter = gear == 4,
                        label = '4 gear cars',
                        description = 'Cars with fewer gears tend to both have higher yield and lower displacement'))
```

#### Exercises
ggrepel has a tonne of settings for controlling how text labels move. Often, 
though, the most effective is simply to not label everything. There are two
strategies for that: Either only use a subset of the data for the repel layer,
or setting the label to `""` for those you don't want to plot. Try both in the 
plot below where you only label 10 random points.

```{r}
mtcars2 <- mtcars
mtcars2$label <- rownames(mtcars2)
points_to_label <- sample(nrow(mtcars), 10)
ggplot(mtcars2, aes(x = disp, y = mpg)) + 
  geom_point() + 
  geom_text_repel(aes(label = label))
```

* * *
  
  Explore the documentation for `geom_text_repel`. Find a way to ensure that the 
labels in the plot below only repels in the vertical direction

```{r}
mtcars2$label <- ""
mtcars2$label[1:10] <- rownames(mtcars2)[1:10]
ggplot(mtcars2, aes(x = disp, y = mpg)) + 
  geom_point() + 
  geom_text_repel(aes(label = label))
```

* * *
  
  ggforce comes with 4 different types of mark geoms. Try them all out in the code
below:
  
  ```{r}
ggplot(mtcars, aes(x = disp, y = mpg)) +
  geom_point() + 
  geom_mark_ellipse(aes(filter = gear == 4,
                        label = '4 gear cars'))
```

### Networks
ggplot2 has been focused on tabular data. Network data in any shape and form is
handled by ggraph

```{r}
library(ggraph)
library(tidygraph)
graph <- create_notable('zachary') %>% 
  mutate(clique = as.factor(group_infomap()))
ggraph(graph) + 
  geom_mark_hull(aes(x, y, fill = clique)) + 
  geom_edge_link() + 
  geom_node_point(size = 2)
```

dendrograms are just a specific type of network

```{r}
iris_clust <- hclust(dist(iris[, 1:4]))
ggraph(iris_clust) + 
  geom_edge_bend() + 
  geom_node_point(aes(filter = leaf))
```

#### Exercies
Most network plots are defined by a layout algorithm, which takes the network 
structure and calculate a position for each node. The layout algorithm is 
global and set in the `ggraph()`. The default `auto` layout will inspect the
network object and try to choose a sensible layout for it (e.g. dendrogram for a
                                                           hierarchical clustering as above). There is, however no optimal layout and it is
often a good idea to try out different layouts. Try out different layouts in the
graph below. See the [the website](https://ggraph.data-imaginist.com/reference/index.html)
for an overview of the different layouts.

```{r}
ggraph(graph) + 
  geom_edge_link() + 
  geom_node_point(aes(colour = clique), size = 3)
```

* * *
  
  There are many different ways to draw edges. Try to use `geom_edge_parallel()` 
in the graph below to show the presence of multiple edges

```{r}
highschool_gr <- as_tbl_graph(highschool)
ggraph(highschool_gr) + 
  geom_edge_link() + 
  geom_node_point()
```

Faceting works in ggraph as it does in ggplot2, but you must choose to facet by
either nodes or edges. Modify the graph below to facet the edges by the `year` 
variable (using `facet_edges()`)

```{r}
ggraph(highschool_gr) + 
  geom_edge_fan() + 
  geom_node_point()
```

### Looks
Many people have already desgned beautiful (and horrible) themes for you. Use
them as a base

```{r}
p <- ggplot(mtcars, aes(mpg, wt)) +
  geom_point(aes(color = factor(carb))) +
  labs(
    x = 'Fuel efficiency (mpg)', 
    y = 'Weight (tons)',
    title = 'Seminal ggplot2 example',
    subtitle = 'A plot to show off different themes',
    caption = 'Source: It’s mtcars — everyone uses it'
  )
library(hrbrthemes)
p + 
  scale_colour_ipsum() + 
  theme_ipsum()
```

```{r}
library(ggthemes)
p + 
  scale_colour_excel() + 
  theme_excel()
```

## Drawing anything

```{r}
states <- c(
  'eaten', "eaten but said you didn\'t", 'cat took it', 'for tonight',
  'will decompose slowly'
)
pie <- data.frame(
  state = factor(states, levels = states),
  amount = c(4, 3, 1, 1.5, 6),
  stringsAsFactors = FALSE
)
ggplot(pie) + 
  geom_col(aes(x = 0, y = amount, fill = state))
```

```{r}
ggplot(pie) + 
  geom_col(aes(x = 0, y = amount, fill = state)) + 
  coord_polar(theta = 'y')
```

```{r}
ggplot(pie) + 
  geom_col(aes(x = 0, y = amount, fill = state)) + 
  coord_polar(theta = 'y') + 
  scale_fill_tableau(name = NULL,
                     guide = guide_legend(ncol = 2)) + 
  theme_void() + 
  theme(legend.position = 'top', 
        legend.justification = 'left')
```

```{r}
ggplot(pie) + 
  geom_arc_bar(aes(x0 = 0, y0 = 0, r0 = 0, r = 1, amount = amount, fill = state), stat = 'pie') + 
  coord_fixed()
```

```{r}
ggplot(pie) + 
  geom_arc_bar(aes(x0 = 0, y0 = 0, r0 = 0, r = 1, amount = amount, fill = state), stat = 'pie') + 
  coord_fixed() + 
  scale_fill_tableau(name = NULL,
                     guide = guide_legend(ncol = 2)) + 
  theme_void() + 
  theme(legend.position = 'top', 
        legend.justification = 'left')
```

```{r}
ggplot(mpg) + 
  # geom_bar(aes(x = hwy), stat = 'bin')
  geom_histogram(aes(x = hwy))
```

```{r}
ggplot(mpg) + 
  geom_bar(aes(x = hwy)) + 
  scale_x_binned(n.breaks = 30, guide = guide_axis(n.dodge = 2))
```