package com.team08.todolist.controller;

import com.team08.todolist.dto.CardDto;
import com.team08.todolist.service.CardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/cards")
public class ApiCardController {

    private final CardService cardService;

    @Autowired
    public ApiCardController(CardService cardService) {
        this.cardService = cardService;
    }

    @PostMapping
    public CardDto create(CardDto cardToCreate) {
        return cardToCreate;
    }

    @PutMapping("/{cardId}")
    public CardDto update(@PathVariable Long cardId, CardDto cardToUpdate) {
        return cardToUpdate;
    }

    @DeleteMapping("/{cardId}")
    public String delete(@PathVariable Long cardId) {
        return cardId + " card is deleted";
    }
}
