Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE4838B148
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235608; cv=none; b=NdYMVNgWG/an32nzr6bIdnfRk8jHF9uUEJgNe1rMgbRPhaUf7TYLkF48+1jsE+SHeTAhW4HXlOFDtD45joeepxKyvBR/gxprmfzW/BcMqiAtPye+cTNCduHpqrynYq/UZ1IOlXgrru484gviT3BX8PH8tPoNrV+5MPN0EeewWN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235608; c=relaxed/simple;
	bh=rip9uRV7z1MrHq44c9P9AtUk8yQpQ+kZiXRL/p9vnmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CutssQvcknTLOfm1rZSNUQX1RzXaThqvCGoMXRqSlj9JacinXe2wjAN7SbKN6TYqVVC7odwGLf0j1V83MvbkoF8gDGDTZ19zf6SOotDjUT90PVbONdSXZdjI0gIp3w/NUK55wKHggWDZ7axvey72CCszGxlEhGLIDT0EDB2VuGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMHkL/cB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RWtN+S3w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMHkL/cB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWtN+S3w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782235606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lVPkNP6BJkSGxsw8Xm+oSCJFyrrNmnKR4VG6pNKWuqE=;
	b=UMHkL/cBt9u4LU5O9Ozvgx4IZp1j7yLBffa2cpF18SDH9hmeWTZi6O5GC7Rq73z+C2a+MT
	yHQY2ZI3EtM6J/qvuFBc5xjxnZ7hDafE4MqeLBvHb/Bvp0p/wmMDhUFtuS1q4TquQRxc+c
	s7WbtS1iVZiM5zn0GHVfciHrMEirlq8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-rNqCsGLJOUSKlWRz-O231g-1; Tue, 23 Jun 2026 13:26:45 -0400
X-MC-Unique: rNqCsGLJOUSKlWRz-O231g-1
X-Mimecast-MFC-AGG-ID: rNqCsGLJOUSKlWRz-O231g_1782235604
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-463aaa77ffeso68635f8f.3
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 10:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782235604; x=1782840404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lVPkNP6BJkSGxsw8Xm+oSCJFyrrNmnKR4VG6pNKWuqE=;
        b=RWtN+S3w5nUnDU9qN4AoM9hgBMTiCfuemcvk1UVk3ycFf04W1NwFhoIT/S8taijT6n
         +TSL5al3pOADiNNudozhS9kKueRxCMGUJJoW2tMLlAkZpnuWkxFfl19j6VVo5Z7KI3YL
         XL7jA1wsIi7tfbeHVmtXXdmRVJS2eIXw+R+JO1XQzzRdV6I7DG25K5wZMdF2hWS/1VOf
         +RObMIf6tfT4LxmDIjcFwvMjOwDs7IJEZLR+YZwPphF/fDxJ9NnDVEx69qxs15zDgH/v
         FDimkDQYi8zSebcreC8GXjd6wHWXCgpUKtwjNNFRDIQVmDaEJCED/JOhAoqHh32UEizf
         HjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235604; x=1782840404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVPkNP6BJkSGxsw8Xm+oSCJFyrrNmnKR4VG6pNKWuqE=;
        b=ZU/dKwIK53cevnLVXaPIwwdIVAa+rX+QFfZSeVh9GoivIH2AxVw9APtldBfFEIUWNF
         2MHs41IPv3ci3mOZwlyZx75OFyJ2XUb9KGk5EIUMvgG4Px2RSzxRoUd8ru44/SGZw9K0
         lFhFUQcdDFK5dc7uCHgkEYtRECmnCSRTTSBgo/9LBvd80RQP9ayCtO8yUkfTNggCQ8Rb
         dwsAltN1TVh76R91vRIpagYbgYJUAaRULQEbPzCbrfVmk0uT/YSd5JVWhUZNXwjcduNU
         FC/gVnh7GBcSdn4m+xGh8I2cumM+Vh0GAtJbL1mITWtHkw0HVqYysMjCW+8THKDlBaBs
         Is5g==
X-Forwarded-Encrypted: i=1; AFNElJ8HkUTPvwHA7gkxeUdloab2JXJaghECfPSbg1ixpY5vb75fmPxd40sE0Y/sSfOi6xw+qbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG0N+ETTu8tsmwunQpnMTisswJzj3Ow0HaoEzpzlRiqvHk0vxB
	4OEPHrm8f831hiaf/duK3BuCrrQqewKV/5UedQBZSGUd9RNUb03WLu6Um3FZvZgbOrEEOrOXrd0
	iFMYo7HjtVSRPvJEv98FP6htNursY4bKVCz0EkpTzKYjk1az2d/HJKQ==
X-Gm-Gg: AfdE7cnjL9gXVA8JgtZ4LuyLq9EmEtSjuv8S+cNdhqBhHuPNpqiK8yLFcYjmBsIPWZ5
	OMkBczWRtK4PjSASCLtXDHFKdbdumYoVTf66H8aktEs0HumLIKmsPniME4d/tCSDqeuAYXGiD2l
	NF+Jjd79Ixf8eQ2WIC6lQ9PrSRidICHr9cpkbxBzKgIVCtznSZadvjuAMeFBzdtvxXRSsXpwFRY
	r1wNA0olFWq2G+PcWKxB008Je+wkbuErdHiU/qS83fiA28CupUr1amGwrdmriXc4FVu836KE3Si
	FD4CSUxe3fvto7T7fJYtk9Va9iYTRxvHm1V+ycSgLphEN0UxKgPaEZBd3q4MacHfxzNertt7C2k
	4Y/0jcOEktfkNFFeaCCaK/EiqLcMGGJ2U
X-Received: by 2002:a05:600c:d4:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-49240e20de0mr257222805e9.5.1782235603239;
        Tue, 23 Jun 2026 10:26:43 -0700 (PDT)
X-Received: by 2002:a05:600c:d4:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-49240e20de0mr257222385e9.5.1782235602685;
        Tue, 23 Jun 2026 10:26:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd15535sm425803415e9.3.2026.06.23.10.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:26:41 -0700 (PDT)
Date: Tue, 23 Jun 2026 13:26:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, oxffffaa@gmail.com,
	rulkc@linuxtesting.org
Subject: Re: [PATCH net-next v3] vsock/virtio: rewrite MSG_ZEROCOPY flag
 handling
Message-ID: <20260623132014-mutt-send-email-mst@kernel.org>
References: <20260623153819.697635-1-avkrasnov@rulkc.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623153819.697635-1-avkrasnov@rulkc.org>

On Tue, Jun 23, 2026 at 06:38:19PM +0300, Arseniy Krasnov wrote:
> Logically it was based on TCP implementation, so to make further support
> easier, rewrite it in the TCP way (like in 'tcp_sendmsg_locked()'). This
> patch only rewrites flag handling (e.g. it doesn't change logic).
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>


It seems to change logic though:

> ---
>  Changelog v1->v2:
>  * Rebase on last 'net-next'. Don't need 'skb_zcopy_set()' now - it was
>    already added.
>  Changelog v2->v3:
>  * Update commit message.
>  * Remove one empty line.
> 
>  net/vmw_vsock/virtio_transport_common.c | 47 ++++++++++++-------------
>  1 file changed, 22 insertions(+), 25 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 09475007165b..41c2a0b82a8e 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -328,38 +328,35 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
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

So previously without SOCK_ZEROCOPY, MSG_ZEROCOPY was always ignored...


> +		if (info->msg->msg_ubuf) {
> +			uarg = info->msg->msg_ubuf;
> +			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);

now it's not in this case?


Maybe the right call, but saying "does not change logic" seems wrong.


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
> +			if (!can_zcopy)
> +				uarg_to_msgzc(uarg)->zerocopy = 0;
>  
> +			have_uref = true;
> +		}
> +
> +		/* 'can_zcopy' means that this transmission will be
> +		 * in zerocopy way (e.g. using 'frags' array).
> +		 */
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
> -- 
> 2.25.1

