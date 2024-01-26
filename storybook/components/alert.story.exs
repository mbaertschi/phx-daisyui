defmodule Storybook.Components.Alert do
  use PhoenixStorybook.Story, :component
  alias DaisyuiWeb.Components

  def function, do: &Components.Alert.alert/1

  def template do
    """
    <button type="button" class="btn btn-neutral" onclick="document.getElementById(':variation_id').showModal()" psb-code-hidden>
      Open alert
    </button>
    <.psb-variation/>
    """
  end

  def variations do
    [
      %Variation{
        id: :default
      },
      %Variation{
        id: :with_with_callbacks,
        attributes: %{
          on_cancel: JS.dispatch("storybook:console:log"),
          on_confirm: JS.dispatch("storybook:console:log")
        }
      },
      %Variation{
        id: :with_title,
        attributes: %{
          title: "This is an alert"
        }
      },
      %Variation{
        id: :with_text,
        attributes: %{
          text: "This is an alert"
        }
      },
      %Variation{
        id: :size_xs,
        attributes: %{
          size: "xs"
        }
      },
      %Variation{
        id: :size_sm,
        attributes: %{
          size: "sm"
        }
      },
      %Variation{
        id: :size_md,
        attributes: %{
          size: "md"
        }
      },
      %Variation{
        id: :size_lg,
        attributes: %{
          size: "lg"
        }
      },
      %Variation{
        id: :size_xl,
        attributes: %{
          size: "xl"
        }
      },
      %Variation{
        id: :size_2xl,
        attributes: %{
          size: "2xl"
        }
      },
      %Variation{
        id: :size_3xl,
        attributes: %{
          size: "3xl"
        }
      },
      %Variation{
        id: :size_4xl,
        attributes: %{
          size: "4xl"
        }
      },
      %Variation{
        id: :size_5xl,
        attributes: %{
          size: "5xl"
        }
      }
    ]
  end
end
