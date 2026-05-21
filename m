Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E16348C7B
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368984; cv=none; b=JHUFaOgqFG/phhgTfzOvurf6V60FtQyDHVb+OIBZ2S0zdZvKHLTH1r4sQSDGre3oHvKmUrukeDamOBmaLDg5nR3Au0teAuHA633KX+9mjM4cWEaLfCiGBpMfdVEDzbsqQk0huUr8sD1A86BroLbyfdhsbgIij9Vhhad5a9nbzGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368984; c=relaxed/simple;
	bh=Jdm389GpaXuX2GWxlZhF6BpB83Vj3ksApFOhdPl2pZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kc8SaKtnr1skk8aX1lUe27vjtrqwFohqyjkOKbCxZiyYweIYDNOlR/idNacyjhaXkC/5ChB90sr9BWHy5zYFhDpO8ik/zM36+7f2d4YSyq/elHz55g3MOWdaKEtSmKn9wpNq/FkyyfUhgxba61oXpvVYnsIk0b21Ed4CtJj7ASY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hp9Onfmr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4X/xMFF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hp9Onfmr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4X/xMFF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779368982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E1vW/XPFrOLYW0lggR7O8cskrXPHeM9SnYmkXYtZE2U=;
	b=Hp9Onfmr4co3Z1tM6KvJHsVQVZ7vBjWtmjylwdxytepEyCgEZI8mZr5EnTWU+DTS45y8/g
	Tra1Jr8dIF6dQa3STF0QK0/ftTPuUFOelZ5NSvp7WwpAs4LI/ZtSLAsE1QNxk8Y6sKJHxd
	1AOc+cSF0BY5s7g+Z2bfBw+PZrlBhHY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-raMveXdYMESjoA0q4LVUSQ-1; Thu, 21 May 2026 09:09:41 -0400
X-MC-Unique: raMveXdYMESjoA0q4LVUSQ-1
X-Mimecast-MFC-AGG-ID: raMveXdYMESjoA0q4LVUSQ_1779368980
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44a71109b94so4565630f8f.3
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 06:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779368980; x=1779973780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E1vW/XPFrOLYW0lggR7O8cskrXPHeM9SnYmkXYtZE2U=;
        b=b4X/xMFFZttp08qPNHcmkFQDc7r6M/ngjsoJrDvrEOyjG2U7fS0RYnicqkerprarhW
         q0U14oR6QeTdFHN1YV+bi0HEK7/Ky0vQ/LtCZXvAbwAi5/t4W3jORZtF6I8P5lZmzWAR
         hVM01mviwb8kLjBySXPGDwlcB14AexHBJYHtvYQbO9On8I1QH8SC+NhYikzquqaAY9xd
         DHlCz6/diie3V/Ugjtb9ja2M8sSLVwBH1pZB6uHA3VLjN2U5kyjo+cH7nK6ggU08Ttkn
         b3S/7lIm5qvP3YyyaHVeGjolSUPi8kKSvCIAvR8UzyiS8i06NdU8tA4W6PEM3gif1Tcp
         MTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368980; x=1779973780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1vW/XPFrOLYW0lggR7O8cskrXPHeM9SnYmkXYtZE2U=;
        b=POjRmoOP5Uvky3pFkerAuEJR1zzWkuKUnF/Oi/ubhMffyzSMlzBbL3cuSKAfAk8mfQ
         FbXpNKuTkQm4jEmmbSbE45ATWtZzFtT0s72KS/rdPkSfid+flbjD+h+hBu4fKG5pAkg4
         K7pHvB0zcjZU9SFnVBTdeoB0npwLfaDhh3mnJBd1bEdg3RHwwkwHiX+GOUoS8PUOad5h
         Q1URNNEvVdDILggLmyq+P008utAI1s+orDVG+/J0t8Wo2JiNWgJUqa1H3lAbBbb+6R/h
         Nn1tZ14SizKEi9dSL4AolmDOVkMqw0aMBGEWWD5LxQp9AiDXfXzx3ht+Ym+TLWkomZU0
         ANyg==
X-Forwarded-Encrypted: i=1; AFNElJ89iolxF1nQNJg0RBvdxLKn+PmZccERSEPew2lneATBshdksTUmpnqHvB+TFyodO5pvTUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyIjGRO0+/IOLpvokieXASh4Y9lIFptPesWJa+98FBnp2SuJXw
	2QxcwjiHKEJ+K07FNhIPWyfwCanEE2IMCoiVscE6ZMFe2cn7qT+m2fco322t4cc9xxHLfLiY4Hx
	4uLQXE0VfZZj4SznyPwhPOgSFgBPQMze1mNbLXvnJmIEdxBpPG377Ig==
X-Gm-Gg: Acq92OGYtqSV5A9UUoSgLCRj9di2N4qEnKtqCHkEKQ+VH0cXBpzA/zkD6b+KAA1GwlC
	cISQruexVYPmZeAvuNsX7YQ82RCa6tIVtZDz9YXXPHl4mS6p4ZYU+NbM7NkLlLuQvHzjkzBGw3p
	+7agQWXE9Rv5mLjNyngoLdD+mQwLp9brImHckFT5nhRKhTakzrzId5TpxT2Ou3HecAvTHmzzxdy
	87xFyGQxLjmweKgwM5ZoUj1fl57kfJmMxx94FKDsqGu8y3YsV+3NpQbbUP60O+0MJMj0bEydq8D
	7npgY74891mLPK1bofE1DtaUJ9dTBFrM+hAJUcf0hSRYDVVlsPGjkEytRBTNTyEZWntoQ0F/CL0
	FPudYcb2MBDRueTnHO3D63+PA2B9uLZMP/AZLjJjtOX0=
X-Received: by 2002:a05:600c:a15:b0:490:3cef:bd90 with SMTP id 5b1f17b1804b1-4903cefbe6emr23446965e9.26.1779368979429;
        Thu, 21 May 2026 06:09:39 -0700 (PDT)
X-Received: by 2002:a05:600c:a15:b0:490:3cef:bd90 with SMTP id 5b1f17b1804b1-4903cefbe6emr23445975e9.26.1779368978717;
        Thu, 21 May 2026 06:09:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035edd7cfsm15236405e9.27.2026.05.21.06.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:09:38 -0700 (PDT)
Date: Thu, 21 May 2026 09:09:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <20260521090927-mutt-send-email-mst@kernel.org>
References: <20260521124732.125771-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521124732.125771-1-sgarzare@redhat.com>

On Thu, May 21, 2026 at 02:47:32PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
> to 32-bit values. The multiplication can overflow before being assigned to
> the u64 skb_overhead variable, making the skb overhead check ineffective.
> 
> Cast skb_queue_len() to u64 so the multiplication is always performed in
> 64-bit arithmetic.
> 
> This issue was reported by Sashiko while reviewing another patch.
> 
> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> Closes: https://sashiko.dev/#/patchset/20260518090656.134588-1-sgarzare%40redhat.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  net/vmw_vsock/virtio_transport_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index df3b418e0392..71198bf23fc4 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -417,7 +417,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  					u32 len)
>  {
> -	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> +	u64 skb_overhead = ((u64)skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>  
>  	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
>  	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
> -- 
> 2.54.0

