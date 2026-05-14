Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829C842846E
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770650; cv=none; b=RIm7FWNI6QafhjF7INrNyNBGk8FDbSxt0cHlFI11GruVC6lhp7tRveabURjie73PpMc7lw/SWx/23gNx8MwJk1EHAbl4az6O6TSIo8tgS6tyhkXaCiBbfVCVv1B4BbPB0+Kk59GvVxDZOoXnWUHTm/siKtBfTV0oGrd1YrB9hsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770650; c=relaxed/simple;
	bh=nLXZoA7D/cDYw43SD85/ZPvjSgooaZlgPDLded852xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDul9Aza2etgj3cmGFcTmPqTSpLJ60PLfoVt6nQWJWVVseCoXRWrqkAbn9tnkDzOEl7vxo+Be3SDl2ftKiWjOQrvEy3QRqs14ljnHNWi44gzOrVsMmgbtYUwXgykv+XEq1FEMD+6F9ggosfXyVJeSeI/4ia/8+Ir+85wrPVfP7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aHn1xgRM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iDVuhKSM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHn1xgRM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDVuhKSM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778770648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bmItK0Q0jR1/wvpM4sGWwy0Jc78483wKM/DFC7tKXoQ=;
	b=aHn1xgRMqkHy0TFJzaUkXA9Tu/UGtyKdlTO+N2jo9nk9uFj4RcZU+ex9ogxXUSWC0wU/gC
	i2upyMaoQPPBag7Quh1cHAbJ+ZupEMHAXjydn4Qj9Uysj0gOC7LBBv6Rpk3I0sibHjxgwy
	XRIZbHs0LAa2zvUZ4iY8dVrWBHk4MCg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-ZD3J9FZAN52jW8iKwrPwqw-1; Thu, 14 May 2026 10:57:25 -0400
X-MC-Unique: ZD3J9FZAN52jW8iKwrPwqw-1
X-Mimecast-MFC-AGG-ID: ZD3J9FZAN52jW8iKwrPwqw_1778770644
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fd233d1e2so15293765e9.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778770644; x=1779375444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bmItK0Q0jR1/wvpM4sGWwy0Jc78483wKM/DFC7tKXoQ=;
        b=iDVuhKSM9t5MgrSgxZi+p2hWSo7fsdgj6B1hoHDHxuw9CRMIPC/muKehai7nM+OPHe
         FTM4Xva8X2gfTuCj9PPMvSOnf2ttzvBMsHOfqMCorpQ5zbCOphjA7p2KnWepZJGKFdr6
         Pi5PO9Q94eOrUqpHwO+eTRPv2bYw13VH83V8raZnBekj8kpWG/6Kxoi+5VGxzvI6NB0v
         Feo9jiTMWVwqMcbg3lYo1+8DSy7fBdw60E26XJVme2WpW/+jCf42LYShRW19IMyIV/j0
         mTjURLxh3ApRHG/wkB3zfaD0tNkQ3ZH4YOiy8YC2Ddcq4R6aQnCjwX9SvVjWa6tl7r+5
         F0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778770644; x=1779375444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmItK0Q0jR1/wvpM4sGWwy0Jc78483wKM/DFC7tKXoQ=;
        b=n9w0IUUQVk05LiJ8r3kZTqhS+bSFaRbwrz1/h1smaKAgA3JpVlhc6dJTxqLOn3B5Tn
         PTGvvP8aZKWy4jxXKFAvGNnN2NZK2GEboz7jyJO2mQ59XEmgaIzoAcokjqn9SIJJT7uY
         r9t6/tUdeqIXz/K5oJpNB/zuvqIQkBgS61PZX54hjacaa7DNZu6QrrwMBRxbhm1k26i5
         fYCM7DBHanVxzU/GRYreTPdYLokjHd22TcRD+7EHdW7KptLEPPCNstCR587dCJAjNqo0
         PJO1hQbMKgrh950x6FtEaqaCZyIJSJMfYWDYKo6HuP3CoqK3COdOLaQRwzfklUmP7JY0
         qKjw==
X-Forwarded-Encrypted: i=1; AFNElJ+/tWOHSzk7XFt/PlIp2DQ2rdD/5bQgbbW2BzAV39o+0FIsXWWlnr3BkUOk+SSYygmw7D0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwobMoMjTFwrvvG7w/LrILcgud5mxJ7Xvk56MedRBkHWx21yvly
	BCXXhO87IQ6IKLsnW5oL4MROOe5oCjJ02hit35Yh/Ngmn751u9k8IF4Np/CK0xyTc9JJYsgt1Mn
	IBQQp1ruTMo2KLUlLLVMkPOZJ0vpOgM4/HylpgbDDxosF5Ny7Kqh0LA==
X-Gm-Gg: Acq92OG5yTiGwOTxZ+JBGWlpoXA4k73YltXQGlnX9Xw7USox0Twt9L1sgACHecn1/Uv
	XUZAbHjm/8ARx9z/lhX5wKcvlZO85rgya2WzVDQX0WwanSZJtgGTx/kgrjrOhImtF7i+Mik6zud
	c+I+AP1hwpYldTPCFS5D1kTlumkH+v3xwAHo/mhhvdX6IBtr7EenmVDBEDoWLOeiiwQGayrsc3S
	zlrXmfAU1h4Vne1p72yjtbeh2fXE2mMeN5JBKxq91tYqxnQ1LMOMvn3zURZvPJ2RV22Gw4s3fWz
	BquizHTkmudGmfHdI7j4ifwvafkHOlPMqn4AvYjzidUtbWS2deoGOlbxVLBH1tQxXoK/KYbE0OM
	SndEPCg4Wi9oEbixj+E8HNKKORwZqBSkEL3cZZQslBIJK9RSnXX/vIcrokoeDfpJnej2S6ukJ+Q
	==
X-Received: by 2002:a05:600c:4e0d:b0:48a:5c23:cab with SMTP id 5b1f17b1804b1-48fc9a3abb0mr125552815e9.19.1778770643881;
        Thu, 14 May 2026 07:57:23 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0d:b0:48a:5c23:cab with SMTP id 5b1f17b1804b1-48fc9a3abb0mr125552375e9.19.1778770643409;
        Thu, 14 May 2026 07:57:23 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4657f3fsm3313895e9.6.2026.05.14.07.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:57:22 -0700 (PDT)
Date: Thu, 14 May 2026 16:57:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v3 1/2] vsock/virtio: reset connection on receiving
 queue overflow
Message-ID: <agXh36gUe1K6__Bk@sgarzare-redhat>
References: <20260513105417.56761-1-sgarzare@redhat.com>
 <20260513105417.56761-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260513105417.56761-2-sgarzare@redhat.com>

On Wed, May 13, 2026 at 12:54:16PM +0200, Stefano Garzarella wrote:
>From: Stefano Garzarella <sgarzare@redhat.com>
>
>When there is no more space to queue an incoming packet, the packet is
>silently dropped. This causes data loss without any notification to
>either peer, since there is no retransmission.
>
>Under normal circumstances, this should never happen. However, it could
>happen if the other peer doesn't respect the credit, or if the skb
>overhead, which we recently began to take into account with commit
>059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
>is too high.
>
>Fix this by resetting the connection and setting the local socket error
>to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
>packet, so both peers are explicitly notified of the failure rather than
>silently losing data.
>
>Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 19 ++++++++++++++-----
> 1 file changed, 14 insertions(+), 5 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 989cc252d3d3..4a4ac69d1ad1 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1350,7 +1350,7 @@ virtio_transport_recv_connecting(struct sock *sk,
> 	return err;
> }
>
>-static void
>+static bool
> virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> 			      struct sk_buff *skb)
> {
>@@ -1365,10 +1365,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> 	spin_lock_bh(&vvs->rx_lock);
>
> 	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
>-	if (!can_enqueue) {
>-		free_pkt = true;
>+	if (!can_enqueue)
> 		goto out;
>-	}
>
> 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
> 		vvs->msg_count++;
>@@ -1408,6 +1406,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> 	spin_unlock_bh(&vvs->rx_lock);
> 	if (free_pkt)
> 		kfree_skb(skb);
>+
>+	return can_enqueue;
> }
>
> static int
>@@ -1420,7 +1420,16 @@ virtio_transport_recv_connected(struct sock *sk,
>
> 	switch (le16_to_cpu(hdr->op)) {
> 	case VIRTIO_VSOCK_OP_RW:
>-		virtio_transport_recv_enqueue(vsk, skb);
>+		if (!virtio_transport_recv_enqueue(vsk, skb)) {
>+			/* There is no more space to queue the packet, so let's
>+			 * close the connection; otherwise, we'll lose data.
>+			 */
>+			(void)virtio_transport_reset(vsk, skb);
>+			sk->sk_state = TCP_CLOSE;
>+			sk->sk_err = ENOBUFS;
>+			sk_error_report(sk);

sashiko reported some issues related to setting TCP_CLOSE state and not 
removing the socket from the connect table:
https://sashiko.dev/#/patchset/20260513105417.56761-1-sgarzare%40redhat.com

I'll change this by calling virtio_transport_do_close() and 
vsock_remove_sock() in the next version.

Stefano

>+			break;
>+		}
> 		vsock_data_ready(sk);
> 		return err;
> 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
>-- 
>2.54.0
>

