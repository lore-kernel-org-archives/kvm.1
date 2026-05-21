Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4AA3D9DA7
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383634; cv=none; b=CpCzeZL+HlCS5js+c1h6/m9+QnbU4YmfHKTqmPvq92xLZL6Nzk8rcvDS207sJMDRuwSh4zTcIlxWxWb1PjZSaqyzhJtwiRaZ6tb3U3qaKOcBlwxEmpjZHiAA6lA9P4f4Xf/XhELFKt8yBWoR6DfKcS9WnZJDpKHFsIRGiGIRD5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383634; c=relaxed/simple;
	bh=X9MG1kwNUf8O8KAK/Sm8SuGe/dZdaTwPaR1MzEF3AHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfm+5uXyxTs5kxwB67VZogrKqLk1W+7sTpP2zkbDFDtL23283x605ma0x6vaESpf1tsm1n8nlWGoxFqZGB1NfFT70g1XTIk31rKdcL9I1fCWaPGlm9sg+4f8bfnUojIxhR2Vrv4QIKcr0awYnrmuii7vUldN/igJKBTFW5Lo/V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nzBH2mki; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzBH2mki"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso62715275e9.3
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 10:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779383631; x=1779988431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIuChPU1JlP7AlPyeu7nnCYpBOhiwGUpJRXAIqjmuvM=;
        b=nzBH2mkicctXAN/292q5htBM8uJbtgNpVclJmeiZKdI2qZBJzQP7W0t8OkfXqX86a+
         U9FNJkbdGMFuH1WuT5mjjd+aXL57+dA3HUPOPJrdtueEf8H/PeHL0dfOiBJdv5ZdbUEc
         DEEd6F5mW+px4Cqdq3Z4sWqqWrHweRIdrrYt8k6W735dfAkvHALNt/obFyNQnGDjTwam
         DKE5qj2VWkcmqngZnzjza3NOZoIjJHPK5GDe/CQnpCNJJJ9h6JdmWI67EqhKVibqNKPT
         Z0100IzuYtrGo5eGLQMg7cgIc46ZruFAZAvLfMipIL0nLAsXeq8fTQRgHMTfwqNE6MMu
         bkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779383631; x=1779988431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zIuChPU1JlP7AlPyeu7nnCYpBOhiwGUpJRXAIqjmuvM=;
        b=WdpwMvAMiWpDnkqNKqLwXxaVEgMjvUQ2LDQkkq+g0LVL7KI6oI7JqE0KDqKqChv7oR
         tQd0IlrhcnmbdKT7qXY/MHKXXQAhubcLLBlqd4gYXzaIZ9VoyTQFDuOZUgjTIi5dSn1O
         nVGaX11GXi5Si1wwPTaImjjliiKRblBq7QIV7ub8iLlvmgLd4EELYx/7TdIEaTH5sBH2
         z8ZKwd9DFyowExXM9OJAD2yAYgujreYNhfhrO/j4cf7QJwWvTptlGPA9nvWB+4utCqKd
         JQxT6AenLko5JeDjiTKWscSc25RyKRX/khRVSlE+hLf2FtkaM54eal7gk/xF8XpIt5eM
         hGPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/GI0PgikHFCr8MWgc5CnoEIIvZNOnDlCFSIyCwjsAo8oTaWU3H+WTe5QPVdVny0t1dhpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu9icZFB/GQDT9elKHnxj+3UwdIh2MoYkLVK482kTzgp3e+Zhn
	3KAD6fSHxx/lNW9f9mfr856EBrmPnZBpQfUQwvibYbe0sPPpSoG4PFyD
X-Gm-Gg: Acq92OGUGc24SiF3Q/2E24iZ2XkEFe4VsxUYN3peskSuYk2E8+GYyWLSy/8NQGph2gx
	BxVdEs2T0qjAHOMwQO6++KQbBONhB7fJoXWjA6W06tlDYApNSrcVT7EpUmXhMTjzyACNPgb/kZX
	ZbiAR4iUr1LW++2lEakZDMYnu6Z6NPNYUOMaEJjFOJLMshNguygmvkvLSYUQCUzCBsVn15sbNJn
	pJXHkI3UOv/WqMdGW2G3mdsVqxebpLzjXNbHqqM/0CkZhoQA66PRRzaL4wTSj53nUkj51DiJj7a
	a43K9MiiYev8C0ADYJiw0oxxxXqGS8E9PuMsfo+c9c54ghSJu5ARagjkOVvKCmoEZxSWF74JImE
	mUKTFsHbd5B0kFNp5hd6ClGcvirAKn6FiFapASD+W/7M51+FroHmimGpajwcKfXkWrCiKEbRFVe
	o21AutVMQVOIqTMag0KVJBwENyd864qyf/PObTIM78FinCzUYmqXDlOPIXGduIq6mI
X-Received: by 2002:a05:600c:828c:b0:485:4eaf:eb53 with SMTP id 5b1f17b1804b1-4903606b5b2mr58827015e9.19.1779383630691;
        Thu, 21 May 2026 10:13:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa7cf23bsm4086708f8f.5.2026.05.21.10.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 10:13:50 -0700 (PDT)
Date: Thu, 21 May 2026 18:13:48 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Simon
 Horman <horms@kernel.org>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Dumazet <edumazet@google.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <20260521181348.3d61858e@pumpkin>
In-Reply-To: <20260521124732.125771-1-sgarzare@redhat.com>
References: <20260521124732.125771-1-sgarzare@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 14:47:32 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

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

I was thinking this should use mul_u32_u32().
But that is all moot.
'skb_overhead' is a memory size in bytes, 'unsigned long' it more than big enough.
No need for 64bit maths on 32bit.

-- David

>  
>  	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
>  	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff

