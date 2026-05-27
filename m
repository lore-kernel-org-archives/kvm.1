Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530CD4534A2
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905372; cv=none; b=EBTB2tqxRYOvHw6OryUocO0eGFUaccXV3TREMx25RQFOZzYGLm2MLiY1oJxkRUVPiQuAGn84b87LCNoMWgat+pfRVPRW6JszpPFktJ9yz7Wz9hVxlZW4ifKYeg+3uMwsLB3emGtWpBZH0l2TkgjdaiKUJy+V5cYrprI+N9RGiNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905372; c=relaxed/simple;
	bh=htlmsUpxEnizeUP3B6xI1XKO3j5rovXUVkrwa4G5o5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/YeydqHmJxhudOD6RHM0jHxnLcn4hqBA7uOQBUfYBS1KucG+6AP+ai8OQJUzGf5VEmHZOwdgaYrMLg98SwftX1fn0socZWEC6GlIiXZAauPp6xgzLF82SDEhw9ehfjq0/PkJ+cVsNIGarBGOyVQ0VYjGUY1+NsCc4GcQfUqGQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5Yn8NdN; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5Yn8NdN"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4585a116a4aso10018106f8f.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779905369; x=1780510169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pkyf7riAoZs+kZFhuxOcxmnZXgTl46iuUo4KIhOjOqA=;
        b=F5Yn8NdNL9c4NbDDRW5PZl20wXG3n3jyg0nkznUa8TAGyHolFlWmsExFaafP3VfDZl
         yNGYsB/u+4eAHMVSk6/HJKadwiUL40EJJLSCElu4i7HILGjdebPN/r6OVfN3fzyv1O9/
         Y0Gx6Z2bUnRwif8Dgsza4mqX8SSL8+eG5QlyspygG+nsNKOgylrTPrXTC9OB9phhZZY2
         d4X6ZxBgguZNpfATgF2rEPQkqEwtxptm1el7s73vJVBSXUwI06FFgq6X2A9eKvsEy2dC
         9u+l4JDfSNmmvBn7PFSBh5fOYEh9INedHcR2/caTc/3ExznQqJ6pfsgdCH95UqYK4gm0
         O6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905369; x=1780510169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pkyf7riAoZs+kZFhuxOcxmnZXgTl46iuUo4KIhOjOqA=;
        b=cx0YcvxoJ8ZVJ2vlUuSuyRm6Jb72CWbTcNPVVtK3cyqp8Fp7BwFA4Kd5N6SA0HelCh
         K8yQ1O2bvTzxZxi/KITDTfXrD+YQuzYP6QFsbOYN4XC213dtdm/sx7HAOZMWVhwUWDeA
         gmJIxCKt7Qxk4eaWPLq9WIZz1A/j844ZjpLsdX7cbR90MciTCE7XcTx1KDl2rR7vvOH+
         +kDOT5mRieNfVEk4Bf7ASpHia4ynygSgF0JoFmKAx8xguaYMt2NUYgAXg2hRAMPRIot8
         iI7FA0za5r6JS6GbCig1aIYnwwYbXFA25L/QrgwFNnHm7sY6QksDCFqwEvQFyggvL4VU
         USfQ==
X-Forwarded-Encrypted: i=1; AFNElJ8wx74UEG2riUZ8W0AL63uezXSXfO30LNtxFBmTXCvD/Imgw6EXWQ9JjDnCA73OLO2qA90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAhiCVD+IT0PeU5NlhDrnJMSDnvYIvLdnjpbaf9BAb1voP1L/4
	rUNC0Fcot70CkePxt9o66gjwRtCVf56axFXtOeaHaQA2x7b1jhGp9LL7
X-Gm-Gg: Acq92OG5yN1f51dkNLmKaJs19sqw/ejH41zkZLb4jO4ZVuyeb8ZaziFhIPOIHylp+ei
	sQkuuOEF+wIEda40U9IAOIZKxRQmyDoA8BTltg1Chw/i1lUBdMV6mBfAGPdwBoz1lirVDI4Hqje
	uNIuYe/5Yuo7EiS+ycUmcP713LdX/Lr390LSWtN5FUG7pfLLtNg6nnOvUuZX5inMyPJW20ttN6a
	bIgjgVlFgb87Lo7a56d54yx1PwMGBoV8jNKKSkIlG5nlczMsvJtdDOaq1brsfVWxM+M2UpAKgXi
	cSbo5uriltzC2ALnuIB0vwE0oZPtFTbRt3Z6L3JmyuKa/ZsFqFBVX97My4Mb7gbjzyH3fo2AZ7a
	U2ccgfxjJea4W/dlwBccfm+Es515ujSmExglBIMWBi2x4ZD7h9KWpaNVW5j5RBOXMNGBhQYexY5
	DEa7C9UG2TDh4IjW0ftRR5nm2AUFDiU590w8562TBekB7XEuEhsP2Fido9SSKB9l0N
X-Received: by 2002:a05:6000:461a:b0:441:1c06:17e4 with SMTP id ffacd0b85a97d-45eb38a8032mr33753535f8f.39.1779905368393;
        Wed, 27 May 2026 11:09:28 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb558449sm7086121f8f.13.2026.05.27.11.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 11:09:28 -0700 (PDT)
Date: Wed, 27 May 2026 19:09:26 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, virtualization@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Simon Horman <horms@kernel.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH RESEND net] Revert "vsock/virtio: fix skb overhead
 overflow on 32-bit builds"
Message-ID: <20260527190926.1a2d6095@pumpkin>
In-Reply-To: <20260527171046.130211-1-sgarzare@redhat.com>
References: <20260527171046.130211-1-sgarzare@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 19:10:46 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> This reverts commit 4157501b9a8f ("vsock/virtio: fix skb overhead
> overflow on 32-bit builds"). The fix was semantically correct (although
> it would have been better to use mul_u32_u32(), as David pointed out),
> but in practice we are estimating the memory used to allocate the SKBs,
> and this will never cause a 32-bit variable to overflow on a 32-bit
> system, since the memory would have run out long before that. On 64-bit,
> SKB_TRUESIZE() already evaluates to size_t, so the multiplication is
> already in 64-bit arithmetic without the cast.
> 
> Let's revert this to avoid unnecessary 64-bit multiplies on the
> per-packet receive path on 32-bit systems.
> 
> Reported-by: David Laight <david.laight.linux@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260523173557.5cc4f4f6@pumpkin
> Suggested-by: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

FWIW:

Reviewed-by: David Laight <david.laight.linux@gmail.com>

> ---
>  net/vmw_vsock/virtio_transport_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index b143290a311d..d4d26fba9e37 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -417,7 +417,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  					u32 len)
>  {
> -	u64 skb_overhead = ((u64)skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> +	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>  
>  	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
>  	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff

