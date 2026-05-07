Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146B53EC2FB
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154320; cv=none; b=G1/O5qOuOPEt3b1OWzYB6vvhzgtPHiNNEAsYkgDTuTYo66LLNx3JTUWEbfjp8w96lwNAPOdcvaYxfEMvpTClUcU2Tamzzzy9Q1xU88rA9KzXQdusX7pYQrnkiVGyROE86U4+P6QivZL/2il3B+8bQ/aRY6OVQr1OqBP4x+hROzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154320; c=relaxed/simple;
	bh=lvuRrcMHuxAF9URp6OhLBiPGZ+f4f+w8cDaxKKzlWH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uus5JQr1Co8kWL5sBB/f8Vw4fEeO6Llt/6NKlAnRI4Gvl9Rj/7b8Gx5lqejfGosgvhkVP+f39aJ+jUP2/I69pMMahdhsEkl9sdQUCbcxmb8KwBmtc2bZItq2xt1xoFucjFEfD7dhhuvjVE/tzuChXFooMucNvSiF0dkSV76Hf8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZQx4yV1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MNhdAlWq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZQx4yV1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNhdAlWq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778154317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XB8uKgfriwIOrN1HH+uQzFZrRsNz6/XjSTKr5IkjkA=;
	b=FZQx4yV136ErWXBMphVuMnmmz2E0L1GV/EMfDriYtktNq/ZCWwk1tLb44tsglO9X7Csbce
	rJgnq87MQ4fZj/huVKpRJkdxHOCGH5doyVPU3Gw06SBNhBaCBfohW2cD2IF76V+dXxz+2W
	4hDAyiZwjshMTbejf1RBMO+wEMFM6RI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-pb3DcDMYO9-aNDClWgwjxw-1; Thu, 07 May 2026 07:45:16 -0400
X-MC-Unique: pb3DcDMYO9-aNDClWgwjxw-1
X-Mimecast-MFC-AGG-ID: pb3DcDMYO9-aNDClWgwjxw_1778154315
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44f65835b77so430429f8f.2
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 04:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778154315; x=1778759115; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3XB8uKgfriwIOrN1HH+uQzFZrRsNz6/XjSTKr5IkjkA=;
        b=MNhdAlWqr/A9z8eNgbbotqQHpSYXSAwOKVmAZFEJl6n7MJ8HA0JfURdrImmJqiJM4B
         WHnDI7MUySwIPt++D05HvpDmW+tBiDpqL67h9eAutI5m4zVJFj07hsaiQTfLUdMTy/Jh
         UoJG/FcAKmBIwveKbk3T/gdoGBTzKv1eiyyjkz7HPuKxWmj/X5Y3kauS/RE/wc9Op6kF
         Bup+csZIgeiJIN6ly/Yj2zfrty7ojbTHZ48AAuHNm+wtyQDOZAQ5SVnunJWy6hCz00nq
         IGaLP0opY27jZe787tTAnonpNMSMEv71mfuLjo6Xq2aLfF6tbx8rnPgG0BcEphjdoEvU
         1fHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778154315; x=1778759115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3XB8uKgfriwIOrN1HH+uQzFZrRsNz6/XjSTKr5IkjkA=;
        b=gsZJjrjkvGZfRdd5Vg6hQgOLzygYFCNfMoq7dfN3s0ipXvcnNtts8WRG+yY3OEgJQv
         hLY30LIfvOBUDvyzlcCAihTavaDGBv7feRnAUpQoQfQvSpef+GiOYVTPOpCEHnpBGbDh
         fMC4ZqOOsJX4bwR4vHZiF7Bx150kj8VqBu78i6VanVZ2JCMo+TyqPfq4J+BT/0w52tQS
         lq9GLO/Zya8Cl55V57LXJXqlcVvtl61r31HNE1w3eCE8OH/sRahRJ4aAY1zGBPsyWFmI
         iozK8wZSVBQU3g9KMYpECi8Z7HSZXu6kugtKJcuernXEGedA75nN0ve3tMoZGaGcRBk2
         wiyA==
X-Forwarded-Encrypted: i=1; AFNElJ/jPhMaH6hIXI2kw+V+uibjLZbocjIIi3ASRx1XdJqLt6k3qNJBJ5AKRSyhh0lV2z2i+iI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4mZE9ZyJgWuj7ZtP0U52fue8822w6x4uCSY9P/SOzkAmBf+lp
	5Rqe2AbYC6tB2HupX7zppWxX2Fpq2ZGkjNH5H6Na7iOUcmawnbvGjllbgN558e9dMPZP4A/7ETM
	VLJm8qUUs/CVSfthUXIufjFHptHUmjeJDsfNtCMHSEvDsYGtBBqKI2w==
X-Gm-Gg: AeBDiesNkDtlAiPDp+pzd7LQA+nBR4UNWl2+TmLKelE3wjmkWJ7X+FGcRMFVqkaHzl9
	JtQo/FIZZEA+JR40cFjFAPdLNp7Ut1yrWlKagr4GoXSLAchy/MT6EboTlVCu5pL81Jlr5O7foc/
	wH328Ihrfk931O5JmhWg4xF1mExkG8HaXUOvcJrujdJvlE0kfOYUY3Vcjjhk5aNPJBZR6ep5vpF
	horklS2g3brLO/RkJJV38XFNjmn3Jf7RYJzkrBCBkY4BYBi6NLtDOXuE5XYoF3scyXYO27rlm4e
	FC/9z/jvMD7vNl2r5eJ9Nl2BiPanHUuPBjOXirSBr1J9bNq42tRxWRgLozdUAD6lVgqsGyEni39
	3nrnhLa03KkwXhjS2BLVqGoq5XG0eG8V1KZrPWkCLnF41TRjoFZ4=
X-Received: by 2002:a05:6000:200b:b0:43d:7b85:6c95 with SMTP id ffacd0b85a97d-4515d5c567emr12448723f8f.33.1778154315133;
        Thu, 07 May 2026 04:45:15 -0700 (PDT)
X-Received: by 2002:a05:6000:200b:b0:43d:7b85:6c95 with SMTP id ffacd0b85a97d-4515d5c567emr12448641f8f.33.1778154314419;
        Thu, 07 May 2026 04:45:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960fd6sm20870119f8f.31.2026.05.07.04.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 04:45:13 -0700 (PDT)
Date: Thu, 7 May 2026 07:45:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <20260507074113-mutt-send-email-mst@kernel.org>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afxVH2So9BbZ3Gta@sgarzare-redhat>

On Thu, May 07, 2026 at 11:09:47AM +0200, Stefano Garzarella wrote:
> On Wed, May 06, 2026 at 11:37:45AM -0400, Michael S. Tsirkin wrote:
> > On Tue, May 05, 2026 at 06:11:13PM +0200, Stefano Garzarella wrote:
> > > On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
> > > > On Tue, May 5, 2026 at 6:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > > >
> > > > > On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
> > > > > >virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
> > > > > >
> > > > > >virtio_transport_recv_enqueue() skips coalescing for packets
> > > > > >with VIRTIO_VSOCK_SEQ_EOM.
> > > > > >
> > > > > >If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
> > > > > >a very large number of packets can be queued
> > > > > >because vvs->rx_bytes stays at 0.
> > > > > >
> > > > > >Fix this by estimating the skb metadata size:
> > > > > >
> > > > > >       (Number of skbs in the queue) * SKB_TRUESIZE(0)
> > > > > >
> > > > > >Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
> > > > > >Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > >Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> > > > > >Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > >Cc: Stefano Garzarella <sgarzare@redhat.com>
> > > > > >Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > > >Cc: Jason Wang <jasowang@redhat.com>
> > > > > >Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > >Cc: "Eugenio Pérez" <eperezma@redhat.com>
> > > > > >Cc: kvm@vger.kernel.org
> > > > > >Cc: virtualization@lists.linux.dev
> > > > > >---
> > > > > > net/vmw_vsock/virtio_transport_common.c | 4 +++-
> > > > > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > >
> > > > > >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > > > >index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
> > > > > >--- a/net/vmw_vsock/virtio_transport_common.c
> > > > > >+++ b/net/vmw_vsock/virtio_transport_common.c
> > > > > >@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > > > > > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> > > > > >                                       u32 len)
> > > > > > {
> > > > > >-      if (vvs->buf_used + len > vvs->buf_alloc)
> > > > > >+      u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> > > > > >+
> > > > > >+      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
> > > > > >               return false;
> > > > >
> > > > > I'm not sure about this fix, I mean that maybe this is incomplete.
> > > > > In virtio-vsock, there is a credit mechanism between the two peers:
> > > > > https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003
> > > > >
> > > > > This takes only the payload into account, so it’s true that this problem
> > > > > exists; however, perhaps we should also inform the other peer of a lower
> > > > > credit balance, otherwise the other peer will believe it has much more
> > > > > credit than it actually does, send a large payload, and then the packet
> > > > > will be discarded and the data lost (there are no retransmissions,
> > > > > etc.).
> > > >
> > > > I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
> > > > state to account credit")
> > > > and find a better fix then?
> > > 
> > > IIRC the same issue was there before the commit fixed by that one (commit
> > > 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")), so
> > > not sure about reverting it TBH.
> > > 
> > > CCing Arseniy and Bobby.
> > > 
> > > >
> > > > There is always a discrepancy between skb->len and skb->truesize.
> > > > You will not be able to announce a 1MB window, and accept one milliion
> > > > skb of 1-byte each.
> > > >
> > > > This kind of contract is broken.
> > > >
> > > 
> > > Yep, I agree, but before we start discarding data (and losing it), IMHO we
> > > should at least inform the other peer that we're out of space.
> > > 
> > > @Stefan, @Michael, do you think we can do something in the spec to avoid
> > > this issue and in some way take into account also the metadata in the
> > > credit. I mean to avoid the 1-byte packets flooding.
> > > 
> > > Thanks,
> > > Stefano
> > 
> > Why do we need the metadata? Just don't keep it around if you begin
> > running low on memory.
> 
> I don't think removing the skuffs will be easy; we added them for ebpf,
> zero-copy, and seqpacket as well.

You do not need to remove them completely.

> For now, we're already doing something:
> merging the skuffs if they don't have EOM set.


Right that's good. You could go further and merge with EOM too
if you stick the info about message boundaries somewhere else.

> As a quick fix, I'm thinking of reducing the `buf_alloc` value to account
> for the overhead and notifying the other peer, at least until we find a
> better solution.
> 
> Stefano

well if you want to support pathological cases such as 1 byte messages
that would mean like 100x reduction no?

