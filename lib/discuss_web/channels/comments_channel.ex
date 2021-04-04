defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel
  alias Discuss.Topics

  def join("comments:" <> topic_id, _auth_message, socket) do
    case Topics.find_topic_with_comments_by_id(String.to_integer(topic_id)) do
      {:error, :not_found} -> {:error, :not_found}
      {:ok, topic} -> {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
    end
  end

  def handle_in(
        "comments:add",
        %{"content" => content},
        %{assigns: %{topic: topic, user_id: user_id}} = socket
      ) do
    comment_params = %{topic_id: topic.id, user_id: user_id, content: content}

    case Topics.create_comment(comment_params) do
      {:error, reason} ->
        {:reply, {:error, reason}, socket}

      {:ok, comment} ->
        broadcast!(socket, "comments:#{topic.id}:new", %{comment: comment})
        {:reply, :ok, socket}
    end
  end
end
