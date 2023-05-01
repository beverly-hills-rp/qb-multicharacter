local translations = {
    notifications = {
        ["char_deleted"] = "Personagem excluído!",
        ["deleted_other_char"] = "Você excluiu com sucesso o personagem com cidadão %{Citizenid}.",
        ["forgot_citizenid"] = "Você se esqueceu de inserir um ID do cidadão!",
    },

    commands = {
        -- /deletechar
        ["deletechar_description"] = "Exclui outro personagem de jogadores",
        ["citizenid"] = "ID do cidadão",
        ["citizenid_help"] = "O cidadão ID do personagem que você deseja excluir",

        -- /logout
        ["logout_description"] = "Logout do personagem (somente admin)",

        -- /closeNUI
        ["closeNUI_description"] = "Fechar multi nui",
    },

    misc = {
        ["droppedplayer"] = "Você foi desconectado do servidor",
    },

    ui = {
        -- Main
        characters_header = "Meus personagens",
        emptyslot = "Slot vazio",
        play_button = "Jogar",
        create_button = "Criar personagem",
        delete_button = "Excluir o personagem",

        -- Character Information
        charinfo_header = "Informações sobre o personagem",
        charinfo_description = "Selecione um slot de personagem para ver todas as informações sobre seu personagem.",
        name = "Nome",
        male = "Homem",
        female = "Mulher",
        firstname = "Primeiro nome",
        lastname = "Sobrenome",
        nationality = "Nacionalidade",
        gender = "Gênero",
        birthdate = "Data de nascimento",
        job = "Trabalho",
        jobgrade = "Grade de trabalho",
        cash = "Dinheiro",
        bank = "Banco",
        phonenumber = "Número de telefone",
        accountnumber = "Número de conta",

        chardel_header = "Registro de personagens",

        -- Delete character
        deletechar_header = "Excluir o personagem",
        deletechar_description = "Tem certeza de que deseja excluir seu personagem?",

        -- Buttons
        cancel = "Cancelar",
        confirm = "Confirmar",

        -- Loading Text
        retrieving_playerdata = "Recuperar dados do jogador",
        validating_playerdata = "Validando os dados do jogador",
        retrieving_characters = "Recuperando personagens",
        validating_characters = "Validando caracteres",

        -- Notifications
        ran_into_issue = "Nós encontramos um problema",
        profanity = "Parece que você está tentando usar algum tipo de palavrões / palavras ruins em seu nome ou nacionalidade!",
        forgotten_field = "Parece que você esqueceu de inserir um ou vários campos!",
    }
}

Messages = Locale:new({
    phrases = translations,
    warnOnMissing = true
})
