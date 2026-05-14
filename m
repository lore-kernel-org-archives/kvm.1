Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72833344DB1
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777117; cv=pass; b=hP2hsWutaVRf7C/36SeGHOhvnfLfKJQcMfhl3yhN5Y+gjB1YO1vM9hYnk3zctW8kD5L74a8mlDI01HP8snOmyD4EjjqQcYUG5jHbiGRiJDMQdOYBHZwlPAEJzh8VHboAKTmZF1rsoRH6U+A6BGLPfRu/zEdlAmWtIeu7/OLyOr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777117; c=relaxed/simple;
	bh=zZzMMRJMHDj4bAdx59InN/qWYOHXeVGUIGiGQSI5A2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAKARlRotIbrN163mzVEoIqkv0B4DMcoeE9G45sN6YSagefCC5b9jesp6Hl+eSnOCYxKHPnEEKt/9y+xurCjUHv8RzfiT01YGqg5mpIBt7AIuO0wPqOwcVzq4wy2057yex2qfrE774gS8pXkrYy+8+C01SnR0qLGMAYfxa8RnyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9Y7mUmi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=elvNK8dw; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9Y7mUmi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="elvNK8dw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778777115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GE7Sq5sTYAoJOxhLn6zS0szJk7y05mcClLoUpAWwPBg=;
	b=I9Y7mUmi7VZpRRrL3l0hW4yoyJhdKKgtw6HNRWP4kwz1R+DcijcU905d3sKzaUoJR8Fyz+
	RXtMI37WvA7iPctz9MNb13REWSPhBirnmQEhIUc6mNE2V/EoaRDNlK66lmkYEGS1R4OPuX
	hnyb5FMeKJfr/rKf/C+QJEFS0nlSjWE=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-Ycyt6KyQMgCVOgzirbc7sw-1; Thu, 14 May 2026 12:45:13 -0400
X-MC-Unique: Ycyt6KyQMgCVOgzirbc7sw-1
X-Mimecast-MFC-AGG-ID: Ycyt6KyQMgCVOgzirbc7sw_1778777113
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-836cfd84728so14531b3a.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 09:45:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778777113; cv=none;
        d=google.com; s=arc-20240605;
        b=Jel2k+fcoMBevQ2PA+NNtMUFW1VWMs9//URDyqodHSyeL3XnmADvGYa3IIba+BFii4
         k0TrBnr1jcOlVRHH+jNnwYxTMN2rWz3XLTbPfQw2qNRbbONiGPcxdla8HqPfsSAfZvTm
         A43ywGX/DlCRSI3eHWDTCNX+0qvxSqLZbKf377sqoMogvSHjq8KyWx/WAj6bJlI/NVTn
         nnP921PKZ0FYjar6KNxKlJmsGC0Cri04lUmMdaqUXZtL5ylPRrvKZAiGwWTOrxAsuKzF
         KGtRYl2iDvtDiSYxqE7x8kL1VD4jDir7GGMXtXGqdhqGzqcnZmPaA3ynsTHyJ75FlcjL
         0syw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GE7Sq5sTYAoJOxhLn6zS0szJk7y05mcClLoUpAWwPBg=;
        fh=KaUEjDSGdY69hAWjHIv51pUHUByfsQKg0rPi3Cg6V4U=;
        b=c+XDcHx4TXly15JkPDBkoGhebMet+qofjPUCsM5UymuWy8yHYIDQ17V5+0DkuiaWfn
         YOxRg55A7+VIvI3e0DgGZ+ro78S9gEfph9D3y1GTmET/bxzRNAdfxnJHK4uk7MWagdWt
         a/Q1ap1gpDm7nZt3jjvWyJHY+Im/dtzfmPZC+ebAgZlI9FrOHDGBN59yP2VTe+xtJnrr
         Ewn6ZOooy61Gyp1FEYfHLJ81rMbewuCt+ez3Rx/zsFZ3hoKSG9NHR5wliZCieG4fskwS
         CJvHK9cfdMjmPDbng7SuFuH1eJliLalKm0vt3pGlrWeeZDDJMSsYFPUzzOHbVTRhlsno
         CQwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778777113; x=1779381913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GE7Sq5sTYAoJOxhLn6zS0szJk7y05mcClLoUpAWwPBg=;
        b=elvNK8dwPFPa8bd/SvwkKvoDRKTMlQAvh1I+gty71xBaKnk6/D2aAoY+gXBJIO7z7h
         yrjbG954ar8YEVSBWPhqSKsDkCrC8BsgBPDDsM+kBH/p0Wea289or3c8XiUJT5hynh42
         3tvbs2I/ftgPqcDXbOeSIiCdnma5FANn+P7hfx4i5stTECDYYOM/ZxeYi1SoamSPu2Z4
         WbzGC1pV2Ut6emSGHhi0thWMKgYjNgMrPNVz3A/D8d1qjWaM0Q1hF0Y2l/QxHWfiFFbK
         SO+AJDtREFVuu2pFnRJ7MbvusO9avSLAQgaAf3NX7mcn7LPA5pWiW3ZogYZ2xx/gtspV
         69eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777113; x=1779381913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GE7Sq5sTYAoJOxhLn6zS0szJk7y05mcClLoUpAWwPBg=;
        b=qAqLlzgE9h2gCRslQY8qi1TyyFcVKv73u/W5a1Stces7zi8ryxp2Ony6r8dMXqFNVx
         Ppd/DxhHzWggzxoOvr2m0ixN3x55EXHDzOZsi6awlQDKH6k7FXrltBU07e9kGRLoIeGL
         PKTscNXg25y6I6MynOnxVAP2DPY7UhiL65TdZubcIn14Q0lU+xwGbd5rK3+Nw5rQRIjA
         CWbe+A0ynuznwkrzVUhzOhlYuxbILioj2URZMKFZMA4i+yp1OZUn2hEElNGhzFrzZCyp
         pCq6zefp6FyL8AzXwxLDSpuJDAf5jMgGUPYImHi2WG0aJm95FSerUBFv07Eb+bQS4uWQ
         8VvQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qV6lZW/YHBe7qwUjFGYbdvcgiEKv5/6pumhPMVMEQhA5hEfig3OOCpk084s9iqylVdGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9CKIfDRpgU86RTWIlv8rpI450xl7kNHLgO4HdeNXFw6R5vDEF
	3YH1OumSTW5v6nvfwD/6ch/bI95yZc01xw6l6YVJRSax4RkELriePERi0pHM8X4hS8xD6Tj46EK
	nAcShbHIAG43hAx4MNAaEsk3IwmmMYTlS2YaOEKoyc6NGrdgUW6W6gOKWPL69C2UvJhMiuCoP8F
	ms1YZ8rJ+jifW/GLz7CGy9yJJTh7q1
X-Gm-Gg: Acq92OEz6vR/S/r0pATm0M0Js6uLWEAbvu/L2ldLouDWa83rHe1wqHi/ONfBP7KeeTb
	DI/ohTeTdG3JPpuBrTkJzNkIis0YoDfIAbjJ4LiT6r0kVJfqg8w2feu/RXJ9L2bwvEFjHqSL88y
	2etlf/ZJVctYyMXsGI7BGkdgBhJCy2R4z9Dgtu8f8IK97RRr1DoL3zR1VoswFY0c2zOfbnNLDpP
	BuDnw==
X-Received: by 2002:a05:6a00:bc93:b0:837:8a0c:8f70 with SMTP id d2e1a72fcca58-83f18ec2d11mr4217045b3a.28.1778777112672;
        Thu, 14 May 2026 09:45:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:bc93:b0:837:8a0c:8f70 with SMTP id
 d2e1a72fcca58-83f18ec2d11mr4217000b3a.28.1778777112018; Thu, 14 May 2026
 09:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513105417.56761-1-sgarzare@redhat.com> <20260513105417.56761-2-sgarzare@redhat.com>
 <agXh36gUe1K6__Bk@sgarzare-redhat> <20260514111513-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260514111513-mutt-send-email-mst@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 14 May 2026 18:45:00 +0200
X-Gm-Features: AVHnY4I_HyzF3GHdZFExrbox_xrkjrz-SlkZ9VT6btL5CcXjAJ3lI9yS4iPlqv8
Message-ID: <CAGxU2F4qWcQTmXnH74V8xZKADLiEMUmCc0+ktW5fZOXdTP4Bdw@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] vsock/virtio: reset connection on receiving
 queue overflow
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 May 2026 at 17:16, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, May 14, 2026 at 04:57:16PM +0200, Stefano Garzarella wrote:
> > On Wed, May 13, 2026 at 12:54:16PM +0200, Stefano Garzarella wrote:
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > >
> > > When there is no more space to queue an incoming packet, the packet is
> > > silently dropped. This causes data loss without any notification to
> > > either peer, since there is no retransmission.
> > >
> > > Under normal circumstances, this should never happen. However, it could
> > > happen if the other peer doesn't respect the credit, or if the skb
> > > overhead, which we recently began to take into account with commit
> > > 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
> > > is too high.
> > >
> > > Fix this by resetting the connection and setting the local socket error
> > > to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
> > > packet, so both peers are explicitly notified of the failure rather than
> > > silently losing data.
> > >
> > > Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > > net/vmw_vsock/virtio_transport_common.c | 19 ++++++++++++++-----
> > > 1 file changed, 14 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > index 989cc252d3d3..4a4ac69d1ad1 100644
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -1350,7 +1350,7 @@ virtio_transport_recv_connecting(struct sock *sk,
> > >     return err;
> > > }
> > >
> > > -static void
> > > +static bool
> > > virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > >                           struct sk_buff *skb)
> > > {
> > > @@ -1365,10 +1365,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > >     spin_lock_bh(&vvs->rx_lock);
> > >
> > >     can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
> > > -   if (!can_enqueue) {
> > > -           free_pkt = true;
> > > +   if (!can_enqueue)
> > >             goto out;
> > > -   }
> > >
> > >     if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
> > >             vvs->msg_count++;
> > > @@ -1408,6 +1406,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > >     spin_unlock_bh(&vvs->rx_lock);
> > >     if (free_pkt)
> > >             kfree_skb(skb);
> > > +
> > > +   return can_enqueue;
> > > }
> > >
> > > static int
> > > @@ -1420,7 +1420,16 @@ virtio_transport_recv_connected(struct sock *sk,
> > >
> > >     switch (le16_to_cpu(hdr->op)) {
> > >     case VIRTIO_VSOCK_OP_RW:
> > > -           virtio_transport_recv_enqueue(vsk, skb);
> > > +           if (!virtio_transport_recv_enqueue(vsk, skb)) {
> > > +                   /* There is no more space to queue the packet, so let's
> > > +                    * close the connection; otherwise, we'll lose data.
> > > +                    */
> > > +                   (void)virtio_transport_reset(vsk, skb);
> > > +                   sk->sk_state = TCP_CLOSE;
> > > +                   sk->sk_err = ENOBUFS;
> > > +                   sk_error_report(sk);
> >
> > sashiko reported some issues related to setting TCP_CLOSE state and not
> > removing the socket from the connect table:
> > https://sashiko.dev/#/patchset/20260513105417.56761-1-sgarzare%40redhat.com
> >
> > I'll change this by calling virtio_transport_do_close() and
> > vsock_remove_sock() in the next version.
> >
> > Stefano
> >
> > > +                   break;
> > > +           }
> > >             vsock_data_ready(sk);
> > >             return err;
> > >     case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
> > > --
> > > 2.54.0
> > >
>
>
> And so the bag of hacks grows. I feel this is energy not well spent.
> Please, let us fix this properly *first*. And then worry about how to
> backport.  Maybe it will not be so terrible to backport after all.
>

TBH I don't think this is an hack, but an issue we should fix in any case.
Regarding the second patch, I see your point, but it's a big change
that worries me. I'd like some more time to fix it properly without
rushing. Staying calm without realizing that userspace is broken like
we are now without this series :-(

That said, evaluating further, I think we have a similar issue also
with STREAM on the host side where the skb usually doesn't free space,
so we need a merge strategy also there.

So, I'd like to have time to fix both definitely. If you have time and
want to go ahead, please do.

Thanks,
Stefano

