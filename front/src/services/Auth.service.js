import axios from "axios"
import API_CONFIG from "../config/api.config"
import axiosInstance from "../config/axios.config"

class AuthService {

    static URL = `${API_CONFIG.PROD_BASE_URL}/auth`

    static signIn(username, password) {

        const form = new FormData()

        form.append('username', username)
        form.append('password', password)

        const url = `${this.URL}/signin`

        let config = {
            method: 'post',
            url,
            data: form
        };

        return axiosInstance.request(config)

    }

    static register(username, password) {

        const url = `${this.URL}/signup`

        let config = {
            method: 'post',
            url,
            data: {
                email: username,
                password
            }
        };

        return axiosInstance.request(config)

    }

}

export default AuthService

