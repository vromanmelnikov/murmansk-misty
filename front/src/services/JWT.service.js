import API_CONFIG from "../config/api.config"

class JWTService {

    static REFRESH_URL = `${API_CONFIG.PROD_BASE_URL}/auth/refresh_token`

    static setTokens({ access_token, refresh_token, token_type }) {
        window.localStorage.setItem('access_token', access_token)
        window.localStorage.setItem('refresh_token', refresh_token)
        window.localStorage.setItem('token_type', token_type)
    }

    static clearTokens() {
        window.localStorage.removeItem('access_token')
        window.localStorage.removeItem('refresh_token')
        window.localStorage.removeItem('token_type')
    }

    static getTokens() {

        const tokens = { 
            access_token: window.localStorage.getItem('access_token'), 
            refresh_token: window.localStorage.getItem('refresh_token'), 
            token_type: window.localStorage.getItem('token_type') 
        }

        if (!tokens.access_token || !tokens.refresh_token || !tokens.token_type ) {
            return null
        }
        else {
            return tokens
        }

    }

}

export default JWTService