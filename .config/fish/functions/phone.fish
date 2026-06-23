function phone --description 'Render a Ringo SIP profile from 1Password and start Ringo'
    # Forwards all arguments to the wrapper: `phone [profile] [ringo-args...]`.
    ~/.config/ringo/phone-wrapper.sh $argv
end
