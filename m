Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE1E3B7B6B
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672140; cv=none; b=H7RCfCfpHJt/0n30/S9fcD2KM/PASNjICWa6XV9UiNnjMZmaJNu5FuAEzWzUCoDkykOPUmernNXMsQegruZNZSwoRkp2woWt2gNI/a7N16gISTEPtPAEFWgqiXM2SjnQ8X50wEhYZ42RgbArFOkVXbF0SHoV0/KjEEUl3y1TA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672140; c=relaxed/simple;
	bh=HtxAlA0bpzrKu0Tr9l4oqmpPC0VovkQ79lbq7PZ+w0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKOf32zQT/QJ5RZ3gJgKUE1emzvKOTRr/lmsGbD5S1eGO19k0X9/Qf3An4kuPGvwbaQyZACh7WOXIAXMllsEHW7eQF3z3mxoyOOgf+eKd7GULk/r86tSFTxzAX2DLcQDAkHrNSpAJFk4ChS173JVDD1KxbOoFCvnm5T6Cm0YSlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5BrtvbM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5BrtvbM"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so1949194f8f.1
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780672137; x=1781276937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgCzrE/kcx5xV+VBfBM1xmyxfRLG6AWjmyf9O3n0QS0=;
        b=d5BrtvbMXEDCgZvCQNMkXEn5ncEoQFAE+6s9Uyu8L88v59qY6BebWcFhmu+TOxtilj
         JvMQiLvjTaNwMM6O60kXDlHIoIfJBtSZ5rcFyPj9I8fSD3zsQNA8wIG5ET/xKCX+YEGr
         9OL82xz9iSOPVy/1v16IEmF+TmvSZTgwg8v6gGUWJ/0Zubs5XTaqzZwyGAWDBisrwSho
         d0WFTPJaK+YRA/YhNHa03QIaTfKnUq8koKcOh7nxi5V8CM3Q5SWniZ2sgW0RwGhfd2WV
         SNQQJt+3bD9MyF61Cd6k0XT7MlSF1XQdUUHm0hcUmjNMjNaoN1Ahrve9VTkVEf/0vO+k
         1znA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780672137; x=1781276937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HgCzrE/kcx5xV+VBfBM1xmyxfRLG6AWjmyf9O3n0QS0=;
        b=mBsaEtD9fKKkGJ1psmr75VqF23roOVGZoUNiHwvQtZgmE6AQKQErfi+UFSLcIdGYSH
         jVQ8cAwoaBNhPUCZrieM35L2b/MJyKVAC6UimyNTufwJbNFU94LilBGoBbjRIpT/di7b
         c4to+2Tnhv/Mz87ClOB0CJsBW+pIAubZv8nkxJ+V8Azu7SE3EviKo1YoIkzRomwIbeo2
         8ooV0EeZQWVsqh669JCBZJmfeFt1HIVW39beyC5Budk8ikgGG5tfG0cS/ZiWfFAcCF8b
         3+BKyJ8JVBm3O+gN0RxvV391wBNwUIqBtZ3yG8zP4p2NxAeYe6EORfBwfPG2ME59v24H
         nZJw==
X-Forwarded-Encrypted: i=1; AFNElJ9sKfTvt4z7JWXUzwnkhadQmaVXtYAg+eBHswUOmC9a2tTWi49k800x6ZykOLLD6X8wx34=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuyRpEj3TfQRWcpL6pYZqkmdRFlaPDkm4Lj+0damiWuddnL9BC
	85TkFRS+rLcL+tCRwe0KIRIoOdulTA6YrXc9tK0uZAwF+3avy+UUEgaK
X-Gm-Gg: Acq92OHFpYNqExKfF+ncxCELHzYCMgI0DfcM0L2KG9Ph4Tx5haVwB5wsdxQIX6VMJBv
	qgvKQKeqp8UBcnzVCa7XFYnsp/lty6VX3bwXkHtM+L8bz/U2xNXpj9jzn8RNGLiKbWiHy4jGo9i
	YwBsIajFg5+h21qhHAQGbyPMIDchgT9aPsqbuJzXdtQcSfnUvUlKyGLuwRy7LQQg7jaC1Z3fsRn
	De73X3BkMQwevNWKO+IgNKGftLFoJQBGHgga3KKqIn+fuiXlLo4H/sZQUHOsiNT/Kg8gwYQ37Bq
	OFAbdWo+teezlqD59FeICWSvxX6hBXIJVrIa8t1tqAXJHliQUIFFBkrzbSHvNtUegEQtXGs6HWL
	i00b1F1uZ+OndCW2dwtLwT2oncPVo5V3woK/kHDzm2VrP+W7c2Ko4WJV4XQpa9zFp5cBHDJkySO
	IsvPtliYK2hBA8H1BHP8A75cvQHJHpxcnoCJAeoaoei08mMbMtya7mbLmN2Plxi/yssOEoRvHSN
	LEhU+99cA==
X-Received: by 2002:a5d:64e5:0:b0:45a:5392:3a19 with SMTP id ffacd0b85a97d-46032da19dfmr5307301f8f.16.1780672137010;
        Fri, 05 Jun 2026 08:08:57 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm44178439f8f.27.2026.06.05.08.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 08:08:56 -0700 (PDT)
Date: Fri, 5 Jun 2026 16:08:51 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Simon Horman <horms@kernel.org>,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, oxffffaa@gmail.com,
 rulkc@linuxtesting.org
Subject: Re: [PATCH v1] vsock/virtio: rework MSG_ZEROCOPY flag handling
Message-ID: <20260605160851.3ddbd2ed@pumpkin>
In-Reply-To: <20260605115314.552321-1-avkrasnov@rulkc.org>
References: <20260605115314.552321-1-avkrasnov@rulkc.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jun 2026 14:53:14 +0300
Arseniy Krasnov <avkrasnov@rulkc.org> wrote:

> Logically it was based on TCP implementation, so to make further
> support easier, rewrite it in the TCP way.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 64 ++++++++++++-------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 2fd9eaaf5ca6..00caeeaa5590 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -73,10 +73,13 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>  static int virtio_transport_fill_skb(struct sk_buff *skb,
>  				     struct virtio_vsock_pkt_info *info,
>  				     size_t len,
> -				     bool zcopy)
> +				     bool zcopy, struct ubuf_info *uarg)
>  {
>  	struct msghdr *msg = info->msg;
>  
> +	/* We have completion - attach it to 'skb'. */
> +	skb_zcopy_set(skb, uarg, NULL);
> +
>  	if (zcopy)
>  		return __zerocopy_sg_from_iter(msg, NULL, skb,
>  					       &msg->msg_iter, len, NULL);
> @@ -208,7 +211,8 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
>  						  u32 src_cid,
>  						  u32 src_port,
>  						  u32 dst_cid,
> -						  u32 dst_port)
> +						  u32 dst_port,
> +						  struct ubuf_info *uarg)
>  {
>  	struct vsock_sock *vsk;
>  	struct sk_buff *skb;
> @@ -245,7 +249,7 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
>  	if (info->msg && payload_len > 0) {
>  		int err;
>  
> -		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy);
> +		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy, uarg);
>  		if (err)
>  			goto out;
>  
> @@ -321,38 +325,36 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
>  		return pkt_len;
>  
> -	if (info->msg) {
> -		/* If zerocopy is not enabled by 'setsockopt()', we behave as
> -		 * there is no MSG_ZEROCOPY flag set.
> +	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
> +		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
> +		 * 'MSG_ZEROCOPY' flag handling here is based on the same flag
> +		 * handling from 'tcp_sendmsg_locked()'.
>  		 */
> -		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
> -			info->msg->msg_flags &= ~MSG_ZEROCOPY;
> +		if (info->msg->msg_ubuf) {
> +			uarg = info->msg->msg_ubuf;
> +			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
> +		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
> +			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
> +						    NULL, false);
> +			if (!uarg) {
> +				virtio_transport_put_credit(vvs, pkt_len);
> +				return -ENOMEM;
> +			}
>  
> -		if (info->msg->msg_flags & MSG_ZEROCOPY)
>  			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>  
> +			if (!can_zcopy)
> +				uarg_to_msgzc(uarg)->zerocopy = 0;
> +
> +			have_uref = true;
> +		}
> +
> +		/* 'can_zcopy' means that this transmission will be
> +		 * in zerocopy way (e.g. using 'frags' array).
> +		 */

I've not looked at the tcp code, but the above doesn't look right.
I don't see why msg->msg_ubuf might be non-NULL without SOCK_ZEROCOPY set.
That would give the outer code a callback when the last skb is freed but
still copy the data.

I also don't see the point of calling msg_zerocopy_realloc() to get a
callback when the last skb is freed and then setting
	uarg_to_msgzc(uarg)->zerocopy = 0;
so that the callback doesn't actually do anything.
It isn't as though you 'find out' later on that you can't actually do
zerocopy.

>  		if (can_zcopy)
>  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>  					    (MAX_SKB_FRAGS * PAGE_SIZE));
> -
> -		if (info->msg->msg_flags & MSG_ZEROCOPY &&
> -		    info->op == VIRTIO_VSOCK_OP_RW) {
> -			uarg = info->msg->msg_ubuf;
> -
> -			if (!uarg) {
> -				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> -							    pkt_len, NULL, false);
> -				if (!uarg) {
> -					virtio_transport_put_credit(vvs, pkt_len);
> -					return -ENOMEM;
> -				}
> -
> -				if (!can_zcopy)
> -					uarg_to_msgzc(uarg)->zerocopy = 0;
> -
> -				have_uref = true;
> -			}
> -		}
>  	}
>  
>  	rest_len = pkt_len;
> @@ -365,14 +367,12 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  
>  		skb = virtio_transport_alloc_skb(info, skb_len, can_zcopy,
>  						 src_cid, src_port,
> -						 dst_cid, dst_port);
> +						 dst_cid, dst_port, uarg);
>  		if (!skb) {
>  			ret = -ENOMEM;
>  			break;
>  		}
>  
> -		skb_zcopy_set(skb, uarg, NULL);

Aren't you passing uarg through two function calls instead of doing it here.
Doesn't even make it clearer what is going on.

-- David

> -
>  		virtio_transport_inc_tx_pkt(vvs, skb);
>  
>  		ret = t_ops->send_pkt(skb, info->net);
> @@ -1178,7 +1178,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
>  					   le64_to_cpu(hdr->dst_cid),
>  					   le32_to_cpu(hdr->dst_port),
>  					   le64_to_cpu(hdr->src_cid),
> -					   le32_to_cpu(hdr->src_port));
> +					   le32_to_cpu(hdr->src_port), NULL);
>  	if (!reply)
>  		return -ENOMEM;
>  

