Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EBF388E56
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780703; cv=none; b=GniLjcbrBfQz6CDROvksjcQyq+yLNISJrJ+s4RfDFx9Q2hztywOH7fSpZXdfmCDdiUg3LgpcmumF7TnLO6qSA+k+ZRHR3mnD6oMpS6P9m8W6y3zpWEe1FuRcfiZuTMstIMc7WqsWkaGRaYPubENL93+TIrvows1jbs+l2wjaTzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780703; c=relaxed/simple;
	bh=uJrp/dJwg6Cte7WCz5lnrjz8/PKP0QJL6LfVLtK5AD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxNdGQp8dUzhRg/11IcBnRWzfPo+YGobuZksdV+ce8rGEegyuLXK2FcC0nvUUzG9IjcagUmi6lDbjKMg+tHUo3njQnEIA9KvbRqloXwwzhwGFb0LLUn4UcVx7btYzYVsMNei42tkGqUg6Ao8Mq3VfwnFB/UZu+7YqnqB+kqlT/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eBUUyPRM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VO89xbW8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBUUyPRM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VO89xbW8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778780700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LPVhEx3/fFkcUjpHActlkwEdsBsjACMHfijDZCZaQ6s=;
	b=eBUUyPRMby8oor1MZV5A4B2xuQkyXOjwmvPGtjEvttmgq8sizXDu4BbEOkk+XNujYAmLCW
	6G+yp+/XMOlU2KpwDZQURcMdpr7eIntUBnnG6enDPbSiVOF+aLpYKDDtEEbE5YkYgcqvpO
	Jrn5BYqkhvI6j1UEv3WK4CN9cPCv2aI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-hW4lSrKKM6OGtrNasn1hLQ-1; Thu, 14 May 2026 13:44:59 -0400
X-MC-Unique: hW4lSrKKM6OGtrNasn1hLQ-1
X-Mimecast-MFC-AGG-ID: hW4lSrKKM6OGtrNasn1hLQ_1778780698
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fd64c32e8so10001555e9.3
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 10:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778780698; x=1779385498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LPVhEx3/fFkcUjpHActlkwEdsBsjACMHfijDZCZaQ6s=;
        b=VO89xbW8e3c1EcgbPNmYawB5CnMrYb3fr4mfaJ9dKdmdIIz87gjzabYtsgttHFVHVn
         CtnWAX6qCocgvNSVWx52FA02MyYr/ZE9jTg4qgxasuVFiJAk3KwJ50d6TFx9Oyd+NLgB
         4OIYLjrhx9peuEJ6Ztb1I3OaEgbwSqeUaWpi5NaSqCP7SuvpcexpRTingR+2JczV+1p/
         48bPIheG6thItK5p38SFmg7OQ9kEAkxU0xYehVDubVUKvtI+SAS8IDJBUDG53n7pqCsJ
         2cdPG0wCWdUh8irm7433wP8EnnZcV1/h2ZVGETTXJ8eO15U729fJ0PmtCqTEsGU0aZL7
         N4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780698; x=1779385498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPVhEx3/fFkcUjpHActlkwEdsBsjACMHfijDZCZaQ6s=;
        b=UYH5kmqMrBCQen6inFCWUWl9Iiq4BarSz255of0563kIAgB+bvvYqYLcLPfS9tLfQf
         sZQ3zthXoMP/eozHGLlkVI9x8H+GTeqVHIYWr4ErcKVFhJbeY3UZe17pFe5efNRB21QA
         HkTM3MwzVc1SgZ4fc4C/Hl0bDwgcWy0gHF/WuAZZGZN4lA/qEQ46sYbOgW6CeAnG7N9Q
         XAyJj927to/Dtn489HK+ERt9epK4zbu6beESwl4rkzLeGkTOBfZoh7W2CP2PA2GuAGuL
         Pzfch2wcx9RfnN0fQFzoDOIraQYOPCTXHM+Gus6VHlGNrkAXRPfnqoCqV+Bll27NQRKV
         RfeQ==
X-Forwarded-Encrypted: i=1; AFNElJ989f1VPaWctg9RPplgkN+cgohXfpRfX/UUebbyk2lNj7R7UUr8BmyrZ/ATcPTlm7fR84s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN6nNGcHpL+G4jPBOMN/932rPqTBjcg89tSvEu9NemDNscVqVD
	Qq15mQ65EqUOlKIZaJbruPtnajJkizFeHxOQU8PRKlt2h9eU7RjnSHqV0bDcrI3OXoW6qqlLMv0
	aMU5K3qjyCiVgY3iS6hy/oOv55qNLEFDXKhGIrUXke0TM9CbAI4LwOA==
X-Gm-Gg: Acq92OHQkq8LaZlvZP/YsShsk4UYDwJ9cfqw6VHIH6Di0QgwIqO2WizdBuw0Wej7VQi
	1yFgrhXBph0s/Fk9zxzgie/0v/zK5aE27gPKtkfldhc1uuRhFSCxM9V2BA3n9BRnc5/CiCnlhvI
	Pi5PLff2MqMVAd+AxYeqQBfiDsJNFfnwL/iXrZu2R89lgLkehnSW6WpyRkHZawUuLJ0MxNGi7mP
	I8qAwvd2x7zY+HGPL/ZV6zY/sGSo+QQWbgc9nvCx5rKU71fgsxJp9Xse5RwAbk6PtPgBwzipPNt
	ShCdg+bf2fGJMfa5Yg9qF0dh/kj2rMgy4/4Qrpgntu3wFGCsVtatoJTJkQEmg+od14wUnsK7Yg5
	vVvkE7zvOUIzl5PVGq4unFxgACorc7b8tbwmz1OdW
X-Received: by 2002:a05:600c:4e47:b0:48f:e1ac:c94f with SMTP id 5b1f17b1804b1-48fe60eb0ebmr5879525e9.10.1778780698025;
        Thu, 14 May 2026 10:44:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4e47:b0:48f:e1ac:c94f with SMTP id 5b1f17b1804b1-48fe60eb0ebmr5879125e9.10.1778780697532;
        Thu, 14 May 2026 10:44:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd768f75asm22669135e9.29.2026.05.14.10.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:44:56 -0700 (PDT)
Date: Thu, 14 May 2026 13:44:53 -0400
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
Message-ID: <20260514134347-mutt-send-email-mst@kernel.org>
References: <20260513105417.56761-1-sgarzare@redhat.com>
 <20260513105417.56761-2-sgarzare@redhat.com>
 <agXh36gUe1K6__Bk@sgarzare-redhat>
 <20260514111513-mutt-send-email-mst@kernel.org>
 <CAGxU2F4qWcQTmXnH74V8xZKADLiEMUmCc0+ktW5fZOXdTP4Bdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F4qWcQTmXnH74V8xZKADLiEMUmCc0+ktW5fZOXdTP4Bdw@mail.gmail.com>

On Thu, May 14, 2026 at 06:45:00PM +0200, Stefano Garzarella wrote:
> On Thu, 14 May 2026 at 17:16, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, May 14, 2026 at 04:57:16PM +0200, Stefano Garzarella wrote:
> > > On Wed, May 13, 2026 at 12:54:16PM +0200, Stefano Garzarella wrote:
> > > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > >
> > > > When there is no more space to queue an incoming packet, the packet is
> > > > silently dropped. This causes data loss without any notification to
> > > > either peer, since there is no retransmission.
> > > >
> > > > Under normal circumstances, this should never happen. However, it could
> > > > happen if the other peer doesn't respect the credit, or if the skb
> > > > overhead, which we recently began to take into account with commit
> > > > 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
> > > > is too high.
> > > >
> > > > Fix this by resetting the connection and setting the local socket error
> > > > to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
> > > > packet, so both peers are explicitly notified of the failure rather than
> > > > silently losing data.
> > > >
> > > > Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > ---
> > > > net/vmw_vsock/virtio_transport_common.c | 19 ++++++++++++++-----
> > > > 1 file changed, 14 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > > index 989cc252d3d3..4a4ac69d1ad1 100644
> > > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > > @@ -1350,7 +1350,7 @@ virtio_transport_recv_connecting(struct sock *sk,
> > > >     return err;
> > > > }
> > > >
> > > > -static void
> > > > +static bool
> > > > virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > > >                           struct sk_buff *skb)
> > > > {
> > > > @@ -1365,10 +1365,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > > >     spin_lock_bh(&vvs->rx_lock);
> > > >
> > > >     can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
> > > > -   if (!can_enqueue) {
> > > > -           free_pkt = true;
> > > > +   if (!can_enqueue)
> > > >             goto out;
> > > > -   }
> > > >
> > > >     if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
> > > >             vvs->msg_count++;
> > > > @@ -1408,6 +1406,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > > >     spin_unlock_bh(&vvs->rx_lock);
> > > >     if (free_pkt)
> > > >             kfree_skb(skb);
> > > > +
> > > > +   return can_enqueue;
> > > > }
> > > >
> > > > static int
> > > > @@ -1420,7 +1420,16 @@ virtio_transport_recv_connected(struct sock *sk,
> > > >
> > > >     switch (le16_to_cpu(hdr->op)) {
> > > >     case VIRTIO_VSOCK_OP_RW:
> > > > -           virtio_transport_recv_enqueue(vsk, skb);
> > > > +           if (!virtio_transport_recv_enqueue(vsk, skb)) {
> > > > +                   /* There is no more space to queue the packet, so let's
> > > > +                    * close the connection; otherwise, we'll lose data.
> > > > +                    */
> > > > +                   (void)virtio_transport_reset(vsk, skb);
> > > > +                   sk->sk_state = TCP_CLOSE;
> > > > +                   sk->sk_err = ENOBUFS;
> > > > +                   sk_error_report(sk);
> > >
> > > sashiko reported some issues related to setting TCP_CLOSE state and not
> > > removing the socket from the connect table:
> > > https://sashiko.dev/#/patchset/20260513105417.56761-1-sgarzare%40redhat.com
> > >
> > > I'll change this by calling virtio_transport_do_close() and
> > > vsock_remove_sock() in the next version.
> > >
> > > Stefano
> > >
> > > > +                   break;
> > > > +           }
> > > >             vsock_data_ready(sk);
> > > >             return err;
> > > >     case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
> > > > --
> > > > 2.54.0
> > > >
> >
> >
> > And so the bag of hacks grows. I feel this is energy not well spent.
> > Please, let us fix this properly *first*. And then worry about how to
> > backport.  Maybe it will not be so terrible to backport after all.
> >
> 
> TBH I don't think this is an hack, but an issue we should fix in any case.
> Regarding the second patch, I see your point, but it's a big change
> that worries me. I'd like some more time to fix it properly without
> rushing. Staying calm without realizing that userspace is broken like
> we are now without this series :-(
> 
> That said, evaluating further, I think we have a similar issue also
> with STREAM on the host side where the skb usually doesn't free space,
> so we need a merge strategy also there.
> 
> So, I'd like to have time to fix both definitely. If you have time and
> want to go ahead, please do.
> 
> Thanks,
> Stefano

Well my patch was a start, we just need a strategy how to avoid copying
everything, right?

-- 
MST

