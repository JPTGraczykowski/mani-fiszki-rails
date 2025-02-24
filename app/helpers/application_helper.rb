module ApplicationHelper
  def render_turbo_stream_flash_messages
    turbo_stream.prepend "flash", partial: "layouts/flash"
  end

  def preferred_language
    session[:preferred_language] || "english"
  end

  def hover_classes
    "hover:cursor-pointer hover:opacity-70"
  end

  def back_button_classes
    "w-18 rounded-lg border shadow-md border-gray-300 bg-lime-200 px-1 text-lg #{hover_classes}"
  end

  def input_classes
    "block rounded-lg border shadow-md border-gray-300 focus:outline-gray-600 px-3 py-2 w-full bg-white"
  end

  def submit_button_classes
    "rounded-md px-3.5 py-2 bg-lime-200 inline-block font-medium cursor-pointer border shadow-md border-gray-300 text-center #{hover_classes}"
  end

  def secondary_button_classes
    "rounded-md px-3.5 py-2 bg-white inline-block font-medium cursor-pointer border shadow-md border-gray-300 text-center #{hover_classes}"
  end
end
