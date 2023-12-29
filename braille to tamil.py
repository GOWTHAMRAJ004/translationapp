import PIL
import easyocr
from gtts import gTTS
import pygame

# Braille map for Tamil
braille_map = {
    'அ': '⠁',
    'ஆ': '⠜',
    'இ': '⠊',
    'ஈ': '⠔',
    'உ': '⠥',
    'ஊ': '⠳',
    'எ': '⠢',
    'ஏ': '⠑',
    'ஐ': '⠌',
    'ஒ': '⠭',
    'ஓ': '⠕',
    'ஔ': '⠪',
    'க': '⠅',
    'ங': '⠬',
    'ச': '⠉',
    'ஞ': '⠒',
    'ட': '⠾',
    'ண': '⠼',
    'த': '⠞',
    'ந': '⠝',
    'ப': '⠏',
    'ம': '⠍',
    'ய': '⠽',
    'ர': '⠗',
    'ல': '⠇',
    'வ': '⠧',
    'ழ': '⠷',
    'ள': '⠸',
    'ற': '⠻',
    'ன': '⠰',
    'ஜ': '⠚',
    'ஷ': '⠯',
    'ஸ': '⠎',
    'ஹ': '⠓',
    '்': '⠈',
    'ஃ': '⠠',
    'ா': '⠜',
    'ி': '⠊',
    'ீ': '⠔',
    'ு': '⠥',
    'ூ': '⠳',
    'ெ': '⠢',
    'ே': '⠑',
    'ை': '⠌',
    'ொ': '⠭',
    'ோ': '⠪',
    'ௌ': '⠪',
    ' ': ' ',
    ',': '⠂',
    ';': '⠆',
    ':': '⠒',
    '!': '⠖',
    '?': '⠦',
    '.': '⠲'
}

# Num map for Braille
num_map = {
    '0': '⠚',
    '1': '⠁',
    '2': '⠃',
    '3': '⠉',
    '4': '⠙',
    '5': '⠑',
    '6': '⠋',
    '7': '⠛',
    '8': '⠓',
    '9': '⠊'
}

def tamil_to_braille(text):
    braille = ""
    for letter in text:
        braille += braille_map.get(letter, letter)
    return braille

def braille_to_tamil(text):
    tamil_vowels = ['அ', 'ஆ', 'இ', 'ஈ', 'உ', 'ஊ', 'எ', 'ஏ', 'ஐ', 'ஒ', 'ஓ', 'ஔ']
    tamil = ""
    for i in range(len(text)):
        letter = text[i]
        if letter == "⠼":
            i += 1
            letter = text[i]
            for k, v in num_map.items():
                if v == letter:
                    tamil += k
                    break
            continue
        for k, v in braille_map.items():
            if v == letter:
                if k in tamil_vowels:
                    if i == 0 or text[i-1] == ' ':
                        tamil += k
                        break
                else:
                    tamil += k
                    break
    return tamil



def main():
    user_input = input("Enter a Tamil sentence: ")
    braille = tamil_to_braille(user_input)
    print(f"Braille: {braille}\n")

    tamil = braille_to_tamil(braille)
    print(f"Tamil: {tamil}\n")


if __name__ == "__main__":
    main()
