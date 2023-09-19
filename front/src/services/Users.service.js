import API_CONFIG from "../config/api.config"
import axiosInstance from "../config/axios.config";
import JWTService from "./JWT.service"

class UsersService {

    static URL = `${API_CONFIG.PROD_BASE_URL}/users`

    static getPersonalProfile() {

        const url = `${this.URL}/profile/by_id`

        let config = {
            method: 'get',
            url
        };

        return axiosInstance.request(config)

    }

    static getProfileByID(id) {

        const url = `${this.URL}/profile/by_id?id=${id}`

        let config = {
            method: 'get',
            url
        };

        return axiosInstance.request(config)

    }

    static getTags() {


        const url = `${API_CONFIG.PROD_BASE_URL}/tags/all?limit=100&offset=0`

        let config = {
            method: 'get',
            url
        };

        return axiosInstance.request(config)

    }

    static getFriends() {

        const url = `${this.URL}/friends/all`

        let config = {
            method: 'get',
            url
        };

        return axiosInstance.request(config)

    }

    static getBasket() {

        const url = `${this.URL}/baskets/my`

        let config = {
            method: 'get',
            url
        };

        return axiosInstance.request(config)

    }

    static getFavourites() {

        const url = `${this.URL}/favourites/by_user_id?limit=100&offset=0`

        let config = {
            method: 'get',
            url
        };

        return axiosInstance.request(config)

    }

    static getFriendsRecommends() {

        const url = `${this.URL}/recommend_by_relative`

        let config = {
            method: 'get',
            url
        };

        return axiosInstance.request(config)

    }

    static deleteFavourites(item_id) {

        console.log(item_id)

        const url = `${this.URL}/favourites?item_id=${item_id}`

        let config = {
            method: 'delete',
            url
        };

        return axiosInstance.request(config)

    }

    static addItemToBasket(product_item_id, count) {

        const url = `${this.URL}/baskets`

        let config = {
            method: 'post',
            url,
            data: {
                product_item_id,
                count
            }
        };

        return axiosInstance.request(config)

    }

    static addItemToFavourites(product_item_id) {

        const url = `${this.URL}/favourites`

        let config = {
            method: 'post',
            url,
            data: {
                product_item_id
            }
        };

        return axiosInstance.request(config)

    }

    static deleteItemFromBasket(item_id) {

        const url = `${this.URL}/baskets?basket_item_id=${item_id}`

        let config = {
            method: 'delete',
            url
        };

        return axiosInstance.request(config)

    }

    static updateUserProfile(userInfo) {

        const url = `${this.URL}/profile`

        let config = {
            method: 'put',
            url,
            data: userInfo
        };

        return axiosInstance.request(config)

        // {lastname, firstname, patronymic, gender, birthdate}

    }

    static addBudget(cost){
        const url = `${this.URL}/profile/money_on_cash?money=${cost}`

        let config = {
            method: 'put',
            url,
            data: cost
        };

        return axiosInstance.request(config)
    }

    static addBooking(user_id,description,time,details){
        const url = `${this.URL}/events`

        let config = {
            method: 'post',
            url,
            data: {
                user_id,
                description,
                time,
                details
            }
        };

        return axiosInstance.request(config)
    }

}

export default UsersService