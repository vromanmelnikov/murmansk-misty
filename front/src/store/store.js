import { configureStore } from "@reduxjs/toolkit";

import modalReducer from "./modalSlice";
import usersReducer from "./usersSlice";


export const store = configureStore({
    reducer: {
        modal: modalReducer,
        users: usersReducer
    },
})