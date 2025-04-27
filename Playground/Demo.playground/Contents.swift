import BoxedContent

// Just a silly ascii box - I use when logs get to crowded

func sample() {
    Boxed.ascii("Hello\nASCII Box!\nCentered First Line")
    Boxed.emoji("Hello\nEmoji Box! 🎉\nWith Multiple Lines", width: 120)
}
sample()
