import axios from "axios";
import JWTService from "../services/JWT.service";

const axiosInstance = axios.create()

axiosInstance.interceptors.request.use(

    (config) => {

        const tokens = JWTService.getTokens()

        if (tokens !== null) {

            config.headers['Authorization'] = `Bearer ${tokens.access_token}`

        }

        return config
    }
)

axiosInstance.interceptors.response.use(
    (response) => response,
    async (error) => {

        console.log(error)

        if (error.response.status !== 401) {
            return Promise.reject(error)
        }

        const tokens = JWTService.getTokens()

        const url = `${JWTService.REFRESH_URL}`

        let config = {
            method: 'post',
            url,
            headers: {
                'Authorization': `Bearer ${tokens.refresh_token}`
            }
        };

        return axios.request(config).then(
            res => {

                const data = res.data
                JWTService.setTokens(data)

                error.response.config.headers['Authorization'] = `Bearer ${data.access_token}`

                return axios(error.response.config)
            }
        )
        .catch(
            error => {
                console.log(error)
                // window.location.href = 'http://localhost:3000/auth/login'
            }
        )

    }

)

export default axiosInstance