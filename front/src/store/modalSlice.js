import { createSlice } from "@reduxjs/toolkit"

const initialState = {
    editProfile: false,
    addStore: false,
    addFriend: false,
    budget: false,
    addBook: false
}

export const modalSlice = createSlice({
    name: 'modal',
    initialState,
    reducers: {
        changeEditProfile: (state) => {
            state.editProfile = !state.editProfile
        },
        changeAddStore: (state) => {
            state.addStore = !state.addStore
        },
        changeAddFriend: (state) => {
            state.addFriend = !state.addFriend
        },
        changeBudget: (state) => {
            state.budget = !state.budget
        },
        changeAddBook: (state) => {
            state.addBook = !state.addBook
        }



    }
})

export const { changeEditProfile, changeAddStore, changeAddFriend, changeBudget, changeAddBook } = modalSlice.actions

export default modalSlice.reducer