export function getAccessTokenFromCookie() {
    const cookie = document.cookie
        .split('; ')
        .find(row => row.startsWith('access_token='));

    if (cookie) {
        const [, value] = cookie.split('=');
        return value;
    }

    return cookie;
}
