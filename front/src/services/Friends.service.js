import API_CONFIG from "../config/api.config"
import axiosInstance from "../config/axios.config";

class FriendsService {

    static URL = `${API_CONFIG.PROD_AI_URL}/users`

    static getAllFriends() {

        const url = `${this.URL}/friends/all?limit=100&offset=0`



        let config = {
            method: 'get',
            url,
        };



        return axiosInstance.request(config)

    }
    static getAllLikeFriend(id) {
        const url = `${this.URL}/friends/all?limit=100&offset=0`



        let config = {
            method: 'get',
            url,
        };



        return axiosInstance.request(config)
    }

}

export default FriendsService