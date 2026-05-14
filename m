Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3702C3DFC78
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771793; cv=none; b=kjc9JVxK2bZdbqlTPswzCSJZz/hCSupowKN/9TkTZUwE5/HcGDEOy4Lc96p3BdfdNmFfNoH8tT5yAyi1Wv6KWeXpoKJonH5olTrqJlal8eCvosYzciHl+w7AGbRLoDycGLTa9eB/TXALA+sNUU/WD9AiSwID86JJgBM2Y1jsjIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771793; c=relaxed/simple;
	bh=q7uNPrD0eUP4HNkAIIdlYAOXifDzpyw/ZOQANdgddGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUmHPpTkeN/AR7qPFDNfiAyHWvA5h53lGp1YW7chjfb4d/eXBlYzwD1Z0V5WsQyIONV6SjkqaQbgXvv01xehbQonWZXuARNweawtL+pLYqC3SKwzSJs3Gmwoy3x/095sW+Xkt3VSkJ37Lzj45TjcypKLVIivBAiWEakE4rPdEBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAVRkAaS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JaFolo8M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAVRkAaS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaFolo8M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778771790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s6SqjJFaYe/G8HVu0q1mvVzTnaE1hb029hYuoyhIe+M=;
	b=GAVRkAaShD1YrlSwka6pg5vvD0Rl9ve68a1ulF/VEsCHsSbAbC8xC85u2MvaQzQHaEgGxo
	tpDAGFqv95otJcIU06UOSKS85SmOZ+j2i0BFcD0zwua4B4d9mCvsNVtELtD8Pf7gMz+/Ma
	WOjqqYGUER4gU6/qjpNfC0Sm3oq9BGM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-gmwriGYJOO6kmBDz8qugrg-1; Thu, 14 May 2026 11:16:29 -0400
X-MC-Unique: gmwriGYJOO6kmBDz8qugrg-1
X-Mimecast-MFC-AGG-ID: gmwriGYJOO6kmBDz8qugrg_1778771788
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45dbbbf8d57so1144200f8f.3
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 08:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778771788; x=1779376588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s6SqjJFaYe/G8HVu0q1mvVzTnaE1hb029hYuoyhIe+M=;
        b=JaFolo8Mw5acZPfyjJ5G9nQAzD+fxbL3mi2d5yC42AhHsAh6bqKogALDZVXaUg5pQH
         2c2HtqXqCORsrw8xvZLMRPj/LyHq47xj/bU5xjsjdJoPpaR5lUvBQDqSNZ1w1u7/1OuQ
         ETDA1Olf6DVVWu/dUqqpUDOqTsdlBM9QoXogtM89MlH81eHthSvWwklBznvaLV8yyO0K
         dKftkVsXkiHhFcapYVLwleCWe8CvVEQ35YL8nhmeGrl/nNw683ogk579Q2uoiWJEjOnn
         INpJS1EMJDpoGQ5M85Z+j5WCXLHiIg5olfyytoKIaJEklEfo/iGKfYBy+bCefhLVDCgd
         lzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778771788; x=1779376588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6SqjJFaYe/G8HVu0q1mvVzTnaE1hb029hYuoyhIe+M=;
        b=gVI1BhinoeYdpU1v7cUILQQ5BI0BFczItfs2Te3ZmXLgeKQzE1a79gT53IgSQO3e8N
         pNS8Wcnrvc1JNc1tHRbiMzJCB0JHyPAwxJriwvZz8lVTVPihmg3WQvTWed6OOg3EPJe8
         3Xc6a8WX5uaUtkTsWJLm8ObOfj05nmQEWUGJuaYtsc9gQvFPbTRwFIpTS2GfX82RsWFg
         N474NVbueuyjVRllCKb1PchDRZHrxa50JWKT/YxJdM8CIBY5+X9aPDT/Cm9ODDXA6Nii
         HNOjOiZ87DUlasDkrIqbrJ/h5/WOrnX1+wgx1XONRxNgIKAJcP3mMCZw+qqzTNLSLSXS
         xpTg==
X-Forwarded-Encrypted: i=1; AFNElJ9VASf7I4rgCb8cl2AVDdR/m6EtUNX9R7knOwadgRrZyQzcUn6+hDAEs/Gcjujjr1+ITg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn5JuH+9zzn3UGuF/9f6Rc8bIoDq3ZgH1NiLIj6Mhj2oBp91dC
	ylE7WPIwuO75zjdCD0yW45YZu/f9xWNl+K94fssEqDeiXeDjLsm4adY0qeRd+DKHRUWbvwUsOAI
	isqALt7qZvfbmhQTxo/s2UfCkZvhN9WUPiyIeFYE8G5RGtLI8X2UKrn7LlI5Ufngi
X-Gm-Gg: Acq92OG9Dkh79QFC7cJyAhCiJE9vc5v2E7Vvmz6B/bxzJKIRwMTG323YofP5W3Iu+Oj
	O+PnMmYf/iVTiLppjjqSjbtGZftlLvB4AUo1jXftic0R3QsLfa5SgObddbqv4rn6s+mkxhX3OTX
	JjLmTQxJVLBhIhRfZfXu1d9O7erepltKdVVgW1BjbGKx7SXxpqbNLGztYWVBh9fY15aBjn0BaZK
	hi9bQxTHgukVTrJmcE5O4PtICHLjvSwV+P2DKpGmSBdP/7t6xQ/4FFr+1dLwKIX7hpY1G9bEiwF
	O4l3iCmPmVYpBOVniurbol1bu6+BKGoeAGB/pYS4v5ekoieAWLIn20uLPw5wAeOMhANzh88/dbe
	mBVJbaU16St95MW7fSfNMBS5gt6LOTBCPpPDkIgZ2
X-Received: by 2002:a05:600c:4fc9:b0:489:1c1f:35f1 with SMTP id 5b1f17b1804b1-48fc9a030eemr107778325e9.4.1778771787738;
        Thu, 14 May 2026 08:16:27 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc9:b0:489:1c1f:35f1 with SMTP id 5b1f17b1804b1-48fc9a030eemr107777655e9.4.1778771787145;
        Thu, 14 May 2026 08:16:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767d0bsm6761145f8f.3.2026.05.14.08.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 08:16:26 -0700 (PDT)
Date: Thu, 14 May 2026 11:16:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v3 1/2] vsock/virtio: reset connection on receiving
 queue overflow
Message-ID: <20260514111513-mutt-send-email-mst@kernel.org>
References: <20260513105417.56761-1-sgarzare@redhat.com>
 <20260513105417.56761-2-sgarzare@redhat.com>
 <agXh36gUe1K6__Bk@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agXh36gUe1K6__Bk@sgarzare-redhat>

On Thu, May 14, 2026 at 04:57:16PM +0200, Stefano Garzarella wrote:
> On Wed, May 13, 2026 at 12:54:16PM +0200, Stefano Garzarella wrote:
> > From: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > When there is no more space to queue an incoming packet, the packet is
> > silently dropped. This causes data loss without any notification to
> > either peer, since there is no retransmission.
> > 
> > Under normal circumstances, this should never happen. However, it could
> > happen if the other peer doesn't respect the credit, or if the skb
> > overhead, which we recently began to take into account with commit
> > 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
> > is too high.
> > 
> > Fix this by resetting the connection and setting the local socket error
> > to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
> > packet, so both peers are explicitly notified of the failure rather than
> > silently losing data.
> > 
> > Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > net/vmw_vsock/virtio_transport_common.c | 19 ++++++++++++++-----
> > 1 file changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index 989cc252d3d3..4a4ac69d1ad1 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -1350,7 +1350,7 @@ virtio_transport_recv_connecting(struct sock *sk,
> > 	return err;
> > }
> > 
> > -static void
> > +static bool
> > virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > 			      struct sk_buff *skb)
> > {
> > @@ -1365,10 +1365,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > 	spin_lock_bh(&vvs->rx_lock);
> > 
> > 	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
> > -	if (!can_enqueue) {
> > -		free_pkt = true;
> > +	if (!can_enqueue)
> > 		goto out;
> > -	}
> > 
> > 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
> > 		vvs->msg_count++;
> > @@ -1408,6 +1406,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > 	spin_unlock_bh(&vvs->rx_lock);
> > 	if (free_pkt)
> > 		kfree_skb(skb);
> > +
> > +	return can_enqueue;
> > }
> > 
> > static int
> > @@ -1420,7 +1420,16 @@ virtio_transport_recv_connected(struct sock *sk,
> > 
> > 	switch (le16_to_cpu(hdr->op)) {
> > 	case VIRTIO_VSOCK_OP_RW:
> > -		virtio_transport_recv_enqueue(vsk, skb);
> > +		if (!virtio_transport_recv_enqueue(vsk, skb)) {
> > +			/* There is no more space to queue the packet, so let's
> > +			 * close the connection; otherwise, we'll lose data.
> > +			 */
> > +			(void)virtio_transport_reset(vsk, skb);
> > +			sk->sk_state = TCP_CLOSE;
> > +			sk->sk_err = ENOBUFS;
> > +			sk_error_report(sk);
> 
> sashiko reported some issues related to setting TCP_CLOSE state and not
> removing the socket from the connect table:
> https://sashiko.dev/#/patchset/20260513105417.56761-1-sgarzare%40redhat.com
> 
> I'll change this by calling virtio_transport_do_close() and
> vsock_remove_sock() in the next version.
> 
> Stefano
> 
> > +			break;
> > +		}
> > 		vsock_data_ready(sk);
> > 		return err;
> > 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
> > -- 
> > 2.54.0
> > 


And so the bag of hacks grows. I feel this is energy not well spent.
Please, let us fix this properly *first*. And then worry about how to
backport.  Maybe it will not be so terrible to backport after all.

