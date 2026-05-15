Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7962423A8E
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835473; cv=none; b=iCqlSkwMak12Mt9RQnwdfcyrPLZuCGTilyoHDG7QzlY4Qi/rIX35BKZTM6kXA774N74HnzJdrLX8Bm4Jxz5dXanLmzBSroFWCsDtZwOk5JBV9xegrvbm+CIV1VALlSwCioV9mT1RiDmvCdJZRNCllxP6tXLAKoa43QzeAlCF540=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835473; c=relaxed/simple;
	bh=yiJc4Nt7lDDJQvZBzjmQQRrY7ovUUA6spxCpoO5M6TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHzFCTCtt9jSfEArs31vjUO8NApQYu8SxfiHRE9sQ1n7OkrwAlf+NWi6v3f+qeue1VDi+P+DkInWJ+AoSpWlKmM78mpKFAQuUYx14PJ0sryexa04Gpzn++56qVoRlH8hMzoeaeQcOxbSHlC6CW3j8BlcqtCQvbJYrL0Wkir24M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gygJ0w/V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BjwrBKlT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gygJ0w/V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjwrBKlT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778835470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=76MGKo7laS3q15QwVBANhPivXoLiqDoqFX8CsnX+SSM=;
	b=gygJ0w/VovbCONG2uFPuk6JAGNPdXV8sInFrQbAX830aWP047npaj276JK8r734ehqROx5
	8cJj9FoijFfy6KMbllFwkY1pMQUGXLwe2qZDD3qWAXn+VvcdcS3f5c5L68kmdBlNrm0YZx
	GR3UVFNn4CmPClhjSQgsTFnrF/Cw9gw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-ZULngBWOPMaeAvlfjZZV8g-1; Fri, 15 May 2026 04:57:47 -0400
X-MC-Unique: ZULngBWOPMaeAvlfjZZV8g-1
X-Mimecast-MFC-AGG-ID: ZULngBWOPMaeAvlfjZZV8g_1778835466
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44f56d5523eso7335702f8f.1
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 01:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778835466; x=1779440266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=76MGKo7laS3q15QwVBANhPivXoLiqDoqFX8CsnX+SSM=;
        b=BjwrBKlTCxL/58XE00cE1fkaBhtzGi2Rz11zf70pMP7pjafnMH5e5CdJXhw2Ug5+He
         Ngsb9jHf2Bs3e95c7lcaKcK3rgA9D5GnL/p+kxCoC7RjEVJcjNcJE+Un2RihsCldWSNG
         QzGfqzGGE6xprpsnk0bR5+NRzDIpJt+JrwXyGwLjewuJmq3uNEc2WnfFT2x55OF+oCWU
         EHRS/cLo3wusti1PAunCkr2Prc3oM5zMNofWdGkPvcd7dZZCT/osGLxB6mQF5pdpC2pU
         oU7K62+TfHdgonHUH96Zf6pOUmP6W/pK3oCxJCDcV9TCvvTbQEcAk5OWWyDKGHGab++F
         gzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835466; x=1779440266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76MGKo7laS3q15QwVBANhPivXoLiqDoqFX8CsnX+SSM=;
        b=tZdiCNNdMoG7mOkAKtItLOyzPnvt4vH9uSdmb2vgKp49tfQHh7KeTT5Hc1D4w8ZKOd
         TM/8RWsJtBvyEm17rucRxbpV0KeYJJ2ug52oEryEJ1oaGhp5/7/Bh9FoQqm6D+FWgcjx
         sshqwxhxgsWkoohpmUHid1Idf24JiqkmXulVcpyyQ0JzrS87oi+NYWQ1Kp1E14rriau8
         SFM+GhEA7+n4H9gbxGci3OyWGxNhFZ5hothK1/CDDnBmozF24RnoBqWNoy7Go3Od5WYA
         8E/E5eg6N4DchyffQNkRsXgHuVQwuPKIYrI6kau6S+5D5fnTtAXo1o5JeVBsEHc/ZuLp
         9fxA==
X-Forwarded-Encrypted: i=1; AFNElJ9GMkIitsrvKz15BeQXvvcTwBb5OhLbgVq9tdhwE5AcE3rlml/Xkh+dqHU7QCmUFK72B84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPLfvRS6u8xZT2seKv//MgAi08tJf2opL1IgLUGKR0Vamt8IiQ
	36nYe+n13XKYdv7ciiqWBqTm7EZjhQowth66EuOnbyWIJAwveEF86AkcVMa+I0CVafrzUrqr/6Q
	0oMHiWVGbw+uj5QXAZCcOuO0iHL3MjcNZavVmvEKvwXuo4YFiSQMuKw==
X-Gm-Gg: Acq92OELnzyuUhtEiaEsDE6q5rwPD2dDh8Y5hba+DWYlXpZZf4BwUvwtDhaDXk94/Cm
	wwWn2pIrOzeAq/dFEoMIdvJfWLTXNVvw/izvuCNdMRLMukPSjd2VhvhtuihqYqGjzTnqFLgWaib
	x5d/S78neILSu8D9MJ00xVd9Kqz7sfI6oLUmFU0fdfxhHYp1AywC9Rp1HY11pnwuBkiZXHsc/X0
	WxhiLHeHzmv1aMpBspQTaO1Whl9VZyhGZL9bTJ14GtQzY+qIm2U80I1F0QLeUSEvvDmedo/amcR
	tY+VXrv+RWNgNj37Ir4Sy2+vtszVrt727MTuAJn8Gxlfg4Xbs4SWVSJm77QCY7lFGV3C9mPCBhe
	w8MkDRZALU3x8
X-Received: by 2002:a05:6000:240b:b0:43c:f1a5:56f6 with SMTP id ffacd0b85a97d-45e5c5a8dc8mr4021854f8f.43.1778835465831;
        Fri, 15 May 2026 01:57:45 -0700 (PDT)
X-Received: by 2002:a05:6000:240b:b0:43c:f1a5:56f6 with SMTP id ffacd0b85a97d-45e5c5a8dc8mr4021803f8f.43.1778835465227;
        Fri, 15 May 2026 01:57:45 -0700 (PDT)
Received: from redhat.com ([31.187.78.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3ac86sm13294048f8f.14.2026.05.15.01.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:57:44 -0700 (PDT)
Date: Fri, 15 May 2026 04:57:41 -0400
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
Message-ID: <20260515043940-mutt-send-email-mst@kernel.org>
References: <20260513105417.56761-1-sgarzare@redhat.com>
 <20260513105417.56761-2-sgarzare@redhat.com>
 <agXh36gUe1K6__Bk@sgarzare-redhat>
 <20260514111513-mutt-send-email-mst@kernel.org>
 <CAGxU2F4qWcQTmXnH74V8xZKADLiEMUmCc0+ktW5fZOXdTP4Bdw@mail.gmail.com>
 <20260514134347-mutt-send-email-mst@kernel.org>
 <agbWNqhzvEHVBvC2@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agbWNqhzvEHVBvC2@sgarzare-redhat>

On Fri, May 15, 2026 at 10:29:55AM +0200, Stefano Garzarella wrote:
> On Thu, May 14, 2026 at 01:44:53PM -0400, Michael S. Tsirkin wrote:
> > On Thu, May 14, 2026 at 06:45:00PM +0200, Stefano Garzarella wrote:
> > > On Thu, 14 May 2026 at 17:16, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, May 14, 2026 at 04:57:16PM +0200, Stefano Garzarella wrote:
> > > > > On Wed, May 13, 2026 at 12:54:16PM +0200, Stefano Garzarella wrote:
> > > > > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > > > >
> > > > > > When there is no more space to queue an incoming packet, the packet is
> > > > > > silently dropped. This causes data loss without any notification to
> > > > > > either peer, since there is no retransmission.
> > > > > >
> > > > > > Under normal circumstances, this should never happen. However, it could
> > > > > > happen if the other peer doesn't respect the credit, or if the skb
> > > > > > overhead, which we recently began to take into account with commit
> > > > > > 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
> > > > > > is too high.
> > > > > >
> > > > > > Fix this by resetting the connection and setting the local socket error
> > > > > > to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
> > > > > > packet, so both peers are explicitly notified of the failure rather than
> > > > > > silently losing data.
> > > > > >
> > > > > > Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
> > > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > > > ---
> > > > > > net/vmw_vsock/virtio_transport_common.c | 19 ++++++++++++++-----
> > > > > > 1 file changed, 14 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > > > > index 989cc252d3d3..4a4ac69d1ad1 100644
> > > > > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > > > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > > > > @@ -1350,7 +1350,7 @@ virtio_transport_recv_connecting(struct sock *sk,
> > > > > >     return err;
> > > > > > }
> > > > > >
> > > > > > -static void
> > > > > > +static bool
> > > > > > virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > > > > >                           struct sk_buff *skb)
> > > > > > {
> > > > > > @@ -1365,10 +1365,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > > > > >     spin_lock_bh(&vvs->rx_lock);
> > > > > >
> > > > > >     can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
> > > > > > -   if (!can_enqueue) {
> > > > > > -           free_pkt = true;
> > > > > > +   if (!can_enqueue)
> > > > > >             goto out;
> > > > > > -   }
> > > > > >
> > > > > >     if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
> > > > > >             vvs->msg_count++;
> > > > > > @@ -1408,6 +1406,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > > > > >     spin_unlock_bh(&vvs->rx_lock);
> > > > > >     if (free_pkt)
> > > > > >             kfree_skb(skb);
> > > > > > +
> > > > > > +   return can_enqueue;
> > > > > > }
> > > > > >
> > > > > > static int
> > > > > > @@ -1420,7 +1420,16 @@ virtio_transport_recv_connected(struct sock *sk,
> > > > > >
> > > > > >     switch (le16_to_cpu(hdr->op)) {
> > > > > >     case VIRTIO_VSOCK_OP_RW:
> > > > > > -           virtio_transport_recv_enqueue(vsk, skb);
> > > > > > +           if (!virtio_transport_recv_enqueue(vsk, skb)) {
> > > > > > +                   /* There is no more space to queue the packet, so let's
> > > > > > +                    * close the connection; otherwise, we'll lose data.
> > > > > > +                    */
> > > > > > +                   (void)virtio_transport_reset(vsk, skb);
> > > > > > +                   sk->sk_state = TCP_CLOSE;
> > > > > > +                   sk->sk_err = ENOBUFS;
> > > > > > +                   sk_error_report(sk);
> > > > >
> > > > > sashiko reported some issues related to setting TCP_CLOSE state and not
> > > > > removing the socket from the connect table:
> > > > > https://sashiko.dev/#/patchset/20260513105417.56761-1-sgarzare%40redhat.com
> > > > >
> > > > > I'll change this by calling virtio_transport_do_close() and
> > > > > vsock_remove_sock() in the next version.
> > > > >
> > > > > Stefano
> > > > >
> > > > > > +                   break;
> > > > > > +           }
> > > > > >             vsock_data_ready(sk);
> > > > > >             return err;
> > > > > >     case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
> > > > > > --
> > > > > > 2.54.0
> > > > > >
> > > >
> > > >
> > > > And so the bag of hacks grows. I feel this is energy not well spent.
> > > > Please, let us fix this properly *first*. And then worry about how to
> > > > backport.  Maybe it will not be so terrible to backport after all.
> > > >
> > > 
> > > TBH I don't think this is an hack, but an issue we should fix in any case.
> > > Regarding the second patch, I see your point, but it's a big change
> > > that worries me. I'd like some more time to fix it properly without
> > > rushing. Staying calm without realizing that userspace is broken like
> > > we are now without this series :-(
> > > 
> > > That said, evaluating further, I think we have a similar issue also
> > > with STREAM on the host side where the skb usually doesn't free space,
> > > so we need a merge strategy also there.
> > > 
> > > So, I'd like to have time to fix both definitely. If you have time and
> > > want to go ahead, please do.
> > > 
> > > Thanks,
> > > Stefano
> > 
> > Well my patch was a start, we just need a strategy how to avoid copying
> > everything, right?
> 
> Yep, and then there's the question of how to handle EOM without a payload,
> but I think that's a special case. In theory, we don't support sending it,
> but I'm not sure if POSIX allows it or not.

It seems to, but given we didn't allow it in the past, we probably
should not start now without a good solution.
Really we should add a feature bit for EOM to steal a byte from
buf_alloc. Or several bytes)

> That said, is it okay if I send a v4 of this series?
> 
> (I'm not sure if I'll be able to work on the merging next week)
> 
> Stefano


I do worry we are piling up hacks and we'll end up with races
for all our troubles. That said, up to you.

