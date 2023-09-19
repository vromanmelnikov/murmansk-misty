import { createSlice } from "@reduxjs/toolkit"

const initialState = {
    userTags: {
        static: [],
        dinamic: []
    },
    user: {}
}

export const usersSlice = createSlice({
    name: 'users',
    initialState,
    reducers: {
        setTags: (state, actions) => {

            state.userTags = structuredClone(actions.payload)

        },
        setUser: (state, action) => {
            state.user = structuredClone(action.payload)
        }
    }
})

export const { setTags, setUser } = usersSlice.actions

export default usersSlice.reducer