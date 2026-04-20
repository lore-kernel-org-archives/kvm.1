Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108E43B0AF3
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776710070; cv=none; b=MUv0uLXgLB20xp0qbU/7UFh7N2+SdtYgGZ/q8xpcUTl7niohozQV54qTbR7zl/27GIKBIefWjMJiun/ajQLO7dtp3H5ddsOu+oGhcdU8uyHHwBGKQBCbAYf18UWu4lqjHdB/qtlyXnh/Q7646C5he9uqBR7aIfiIXZpFtKmp994=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776710070; c=relaxed/simple;
	bh=ienUfESzt6vNzLdl8pNwfDx7dxAyw+aVjIBPr3f4Yec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6M1Qol3Qy2T2wD0LbdYJVN3tmD6QDJezEAI8LyUCSeFqmCqWBeI0k84SMgXG580eLME5dnC1b/dysOwXMzxsbrcIHq2xSf7im3m8oR3UiyO0I44ygBBD8Tz1UknHTGrsvH81sBuKe3rZPQJKkpvkMSRd1dhCKFgls7jawhyJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUKROWVE; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUKROWVE"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82f946efa38so1602758b3a.0
        for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 11:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776710068; x=1777314868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kqExjaso/aiD1XgkyqsZ6VooUNyCznnnKYPwy1DQRPE=;
        b=FUKROWVE9PkJqNZ8v1dPScvL7r2iebaRXT+GE74V3ahoVdLcfcDee2F++rXyxPAtKh
         VU9Xg11PdM7iw+Iy78jZNcs90e275ZiWfC6Hd5QSzUbCdCYmvDXw43lB1bPw1ZzTpPzb
         2ySX1d4ouMRlX7qlbC72iBJT4c5i9fsYyYY6wUtBidGZI43Ehw8CzLSf9skn+demJaXH
         rrzKz75HXJ5DLRwbt2KgyuiEIEtisslfwzzz16QKHdRwToNP0gTp7dKVzVQGFg2lN7b9
         ezm6yxsnwIoKqbKofe4soZDGT4T88Bdsz+Kw7LaGczIw5GdmPWU4Nq9y7mVW9AZQsQB/
         muGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776710068; x=1777314868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqExjaso/aiD1XgkyqsZ6VooUNyCznnnKYPwy1DQRPE=;
        b=bnZ8OdZPyPEIhmfZg6a/c8ZGsvRFXg+iBFISSxsQ95GsbARdog/w5iVIwJ0mykZmxk
         ObUkEYXDHrrPf5yr+9FG+8oowJAFoDbCn4tHcSc/yyZMxTvmMK0s5t/+B1ffg5EGCzrR
         ppr6mVz3576sRWQlL831QCzEkwhhINdBJuFbDAeA/vyQilDduErVL63f3mXEuCXtnhgX
         S804L9tYmVnZOk46nEMR508rAQ26aL2zZnLbZoGURc7eN2OA60fxYvnzTgiLskXPJ+Wa
         B+rHcwE7tmPdA9uutsQDYpjaW/HGG+4wzzS2UgHppuHYuLQ38/cDZp1hyb7YTo3VCXoi
         9/XQ==
X-Forwarded-Encrypted: i=1; AFNElJ8zjqY0lTe6zEaE7cKY/kYmO3SLJWbEO7HKkQKOz6lkMRD9eSFr68hzVU2lALWm5qEbF0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUff7g8K4gDrtXixckaGYYzGv5VsBJaV2GZ86jBG4nVYIeLU1t
	NqKrExD6QtWu115bTsi+xvapTO3CwQkst6UPZ3eNplauJ6hltxyVGm9O
X-Gm-Gg: AeBDiet1FgQb/3K+zbY6utEd2CcoN5XODj/IIugMWmhd8f8n1tHO25EiQBjgCo5wIFv
	HEFwJ/dq7r3HH7tR2TVZYKsvF9FH4ZhY6RRGbjOf6a2vApPn79xcOlfjQHbFEuH0xV3cy9eqnOz
	CF14JbcecEYmBndkp0o9WgjT1hd0pM1D5k3uehSSgMpQZ31mj3Lvb7nuuiv9RZTIzwa/T/blv5h
	omsrqPFJT/kXxtTIQHXI7kxZol3mQi+LdfsysUPjWYXrnM7j/OPM+SfWu3aMZl3AHnZaK4wn31v
	BqP9avYkIU3VLcRW60uEVrRPR3HuknF9nfXIu78X4OnZ6JNxdJwmJsWAC5whReHLRPgNEIr2cGz
	G8w12iDVB+7qO8U4AZddIXD0ajEZ1fVcYNmTQ2eXfN0W/p3fVI+F/QZMs6JjKXWuL6ujnq5pUCP
	61GYoyZ0owcApuS1PIoaaFeRt7yhYJwW5EEADpA/6xra+5OaLA/QKnpg==
X-Received: by 2002:a05:6a00:4c82:b0:82f:7cb7:63c7 with SMTP id d2e1a72fcca58-82f8b384f1amr11355701b3a.11.1776710068332;
        Mon, 20 Apr 2026 11:34:28 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d35acsm11798580b3a.15.2026.04.20.11.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 11:34:27 -0700 (PDT)
Date: Mon, 20 Apr 2026 11:34:25 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, kvm@vger.kernel.org,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Yiming Qian <yimingqian591@gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix MSG_ZEROCOPY pinned-pages
 accounting
Message-ID: <aeZxscYXyE6BE0tY@devvm29614.prn0.facebook.com>
References: <20260420132051.217589-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420132051.217589-1-sgarzare@redhat.com>

On Mon, Apr 20, 2026 at 03:20:51PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> virtio_transport_init_zcopy_skb() uses iter->count as the size argument
> for msg_zerocopy_realloc(), which in turn passes it to
> mm_account_pinned_pages() for RLIMIT_MEMLOCK accounting. However, this
> function is called after virtio_transport_fill_skb() has already consumed
> the iterator via __zerocopy_sg_from_iter(), so on the last skb, iter->count
> will be 0, skipping the RLIMIT_MEMLOCK enforcement.
> 
> Pass pkt_len (the total bytes being sent) as an explicit parameter to
> virtio_transport_init_zcopy_skb() instead of reading the already-consumed
> iter->count.
> 
> This matches TCP and UDP, which both call msg_zerocopy_realloc() with
> the original message size.
> 
> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 0742091beae7..416d533f493d 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -73,6 +73,7 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>  static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
>  					   struct sk_buff *skb,
>  					   struct msghdr *msg,
> +					   size_t pkt_len,
>  					   bool zerocopy)
>  {
>  	struct ubuf_info *uarg;
> @@ -81,12 +82,10 @@ static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
>  		uarg = msg->msg_ubuf;
>  		net_zcopy_get(uarg);
>  	} else {
> -		struct iov_iter *iter = &msg->msg_iter;
>  		struct ubuf_info_msgzc *uarg_zc;
>  
>  		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> -					    iter->count,
> -					    NULL, false);
> +					    pkt_len, NULL, false);
>  		if (!uarg)
>  			return -1;
>  
> @@ -398,11 +397,17 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  		 * each iteration. If this is last skb for this buffer
>  		 * and MSG_ZEROCOPY mode is in use - we must allocate
>  		 * completion for the current syscall.
> +		 *
> +		 * Pass pkt_len because msg iter is already consumed
> +		 * by virtio_transport_fill_skb(), so iter->count
> +		 * can not be used for RLIMIT_MEMLOCK pinned-pages
> +		 * accounting done by msg_zerocopy_realloc().
>  		 */
>  		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
>  		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
>  			if (virtio_transport_init_zcopy_skb(vsk, skb,
>  							    info->msg,
> +							    pkt_len,
>  							    can_zcopy)) {
>  				kfree_skb(skb);
>  				ret = -ENOMEM;
> -- 
> 2.53.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
