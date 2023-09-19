import API_CONFIG from "../config/api.config"
import axiosInstance from "../config/axios.config";
import JWTService from "./JWT.service"

class StoreService {

    static URL = `${API_CONFIG.PROD_BASE_URL}/stores`

    static getStores() {
        const url = `${this.URL}/all`

        let config = {
            method: 'get',
            url
        };

        return axiosInstance.request(config)
    }

    static getProductsByStoreID(id) {

        const url = `${this.URL}/products/all?store_id=${id}`

        let config = {
            method: 'get',
            url
        };

        return axiosInstance.request(config)

    }

    static getProductbyId(id) {

        const url = `${this.URL}/products/by_product_id?product_id=${id}`

        let config = {
            method: 'get',
            url
        };

        return axiosInstance.request(config)
    }

    static getFeedbackbyProductId(id) {
        const url = `${this.URL}/products/feedbacks/by_product_id?product_id=${id}`

        let config = {
            method: 'get',
            url
        }

        return axiosInstance.request(config)
    }

    static getProductsByTag(tag_id) {

        const url = `${this.URL}/products/all?tag_ids=${tag_id}`

        let config = {
            method: 'get',
            url
        };

        return axiosInstance.request(config)

    }

    static buyItemFromBusket(id) {

        const url = `${this.URL}/products/items/buy_from_basket?basket_id=${id}`

        let config = {
            method: 'delete',
            url
        };

        return axiosInstance.request(config)

    }

}

export default StoreService