Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2602B394498
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 03:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862291; cv=pass; b=ZXg6tLawtnlILd56frtfW0pXN262m3MlX3wf747EihwkTe3+G8MRQkPQKfYQlRQyCOjub6KbY8oqp23+XO4cTV82nb20Ki1Z4RGb7WAGax9mHfhU6RCRM9zDQ+BgnVLY8QXh/6ZxHEPdohh5/rNyA89VROQIt32JRIPuWh+1Gkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862291; c=relaxed/simple;
	bh=zCSEKIAPKVwVSGY4GyE3kxLa1knCjzTA3Y/jvMzWxiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/+3+S4dpjQObX4UDjQcnAyYo3IOSKcdH67bPY1ReBzAogOcKI6tDmED8WNsdQFfTg8NRDKpaVhO3xeK+Q5jEoSI8npWUYIUBbwL9zkpc/10hUZ5h7ShtwB86cy7N6e7/8BnUB+/ZYOGXYDGf0MzhVnd9/haUhyfdnXvx0r4OsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNRyFkqW; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNRyFkqW"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-9144e8021d3so36875876d6.3
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 20:31:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791862288; cv=none;
        d=google.com; s=arc-20260327;
        b=s19mcdYL2i8Mn8C9JXSD39QFM1Yt2JrglrsIlK+M49zKuwSrZnCqiP2NnWZYyjAf8k
         xbUFG1butaOGwW605TD0612mlaqWYkhDShG1Y23zqSKeAqr9zHtDAH1ygtCIGKuWcoR0
         piN+1TFv7iXw0y/gIIkDml1iJvS9XGpLN0Txcu1YgkrydrDXMuARfTyPHKFmF9LUmaAs
         90SkZr5LJ1wMrPigjjhjMqHDkoBArZ1ZdIuDXDyhul5ENm7NImI7zjJj7cDqsyCcYGOz
         OnCVjbGWEV730BbOsKe3iKuZA/q7dgcfY3H4TjLphkk1lu3+N3q1MUPaR2fnFSesOLQG
         0fLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oKth/1jAUk8y73FB5cD2ux1SjiU3FjqeBdt11b7UR8k=;
        fh=3VBxu+mn5Kj3YN4D46vYx+nW2F+DE+sp+s9zhCpySX0=;
        b=G0qUVtrbrtn0WhJ4aEYQM3gSB3STUKevgZYH23BYxMZ0BkfE4KHIrvae+0h3U/XtlW
         7K0weoD3NJPqr0UlCmSCE46/nKxiKNtbLxgl77mKzWldRf7MdiUvdErAdxX/Xp37S1Gk
         W5TNKf4oPl5pWETgeeisZZokKtbOK1uE4+NfGu2m9wAFTzLgHSKBhax0Wvu1UZKExQd9
         WJ3OxeKRzeJVDP0U6T5T3DWek7xCjPamCNmDFinCyY2JSlfWQvFddxPEzk4Q6qVqnO/J
         AIMTMXtgyrk3lZN7oTR13zIKZfoJ2ZZdbQERXlHn9Lyv2m4Z934178Q280C3570jUBxC
         9zZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862288; x=1792467088; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oKth/1jAUk8y73FB5cD2ux1SjiU3FjqeBdt11b7UR8k=;
        b=CNRyFkqWvkphXy4611cQxfWd3tluQ2Ap+aZpYQtlP56Wvf2uIOZtIBNT32f9l64lCL
         HdERnSWoEgkR/I2ykgmwW9MosDd36LVBYLu6FgpxJZ8CfziAMvs+159cn0FEnD3Wk8vs
         owf5QJpZW1rBUtUGwT8vcnB3pYZ53gcu4humkw3zPvllA3/lNcsYd9DuB+3stYgwMh0x
         WzsNiT7bE58HHyvxKNhB6gyxAw17LkLNfWXXnhSE0WUgxAQ5MbNsa9RRuytAk3T19QiY
         g6OGGZcFuYXaRsFoYjuxyt3UAtI2t/HA/7ciI0OrbqE1t8NO/gP65CGhRi7fSe90KWxZ
         f/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862288; x=1792467088;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oKth/1jAUk8y73FB5cD2ux1SjiU3FjqeBdt11b7UR8k=;
        b=oc9uO4dUgHSrxqnuoalsqQKq/0fmSYkoCbGBNNPyGevdPHMWBoWWSAVNg8datmHG4y
         9BjZAn9DIMoHIa5Yqlb7Uo3dipKSzoOPYokW4HZ+NXv8qyLqEoD1iL5KQ/XMTTmvM+a1
         4Ecl4ZfjWo5LrQ9XmSGtBj7+hlUkpKyoZ1sOFFpxxxolvatxgqHaw2MySKq+9G6solAc
         ynMVWYbipjZ0qVrFPQ1VFqQ9f4iP1/3G94CgDjfCnzSgmYPrlwNw5vbhy4xEAPvqsboI
         FWnOWhWmUVPo/wPp1n450ddXoFzWEkqzRn3ZgFbKSGYlCjOJwMbuIp7YvbGGFn6j+uUP
         +Fiw==
X-Forwarded-Encrypted: i=1; AKwUvBwTbBDS7uP02BJEP2qINxplOQ6zawoObUeCFMnbfrk2trJMV7dLVphr4DJ51N+Dv5gvo48=@vger.kernel.org
X-Gm-Message-State: AFq9FYLa17q3KXElW2iX9AC4v7AiyLNmzwBxpMt9c42k8/tJXpM4U5pi
	kQIi+4xOR0PSSfe9Yv/ja/ChU1nibedWTdisf4K9pqaS4QmjpiTRyP43S8ologZDEiQz598gVyK
	e1hfhEoeQYPR3FRBlItVVoMkJUydJ+CQ=
X-Gm-Gg: AYBFou3ykv7eqZf6EB4KYrUKGZpU0THYk6vvcSCqtrlYWzhDB0ghU1U2u+/efWvPUrD
	CJTdMHKj5DXlpu2wW1tWq9GKYiyh4WQN1AIgOLC+ouVB0sosnnROZEXBMOjOenG0ZSVL0J7BIbq
	0/6Y33KTnV217SeizxI+jS5FcCGlyashcYMTVHT7qO85nRMGQJuuAP33ZvKWR4rP/F6qBqFosBL
	gzQIjvHaaNoIZ58pfWJ3RisFtiX7mIZqrlZLQ4Ms1ZII1soNmUQaM7TS8FE+a8gJ6bFaFr8B5VD
	n9LHfeU2WmL5rc+t0eprjak2qjbwM/Je6mpMaU4kHI4d7oHi2kpPjSQ=
X-Received: by 2002:a05:620a:44c8:b0:939:1222:b9f1 with SMTP id
 af79cd13be357-93ebcd2b3d1mr1818738285a.0.1791862287366; Mon, 12 Oct 2026
 20:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-4-physicalmtea@gmail.com> <as1ciTHT2O40E/Uq@devvm29614.prn0.facebook.com>
In-Reply-To: <as1ciTHT2O40E/Uq@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Tue, 13 Oct 2026 11:30:51 +0800
X-Gm-Features: AclHuK82x5TMJTU3P4uV1cGGZ695rdTmYCG-meYcWlEm97kH4rrDUYXGHuCS2tM
Message-ID: <CAJwVaMJxgjbEXk8LW+wYbmfPYA2anNcRtitB=G1=kNv-WXm4TQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/5] vsock/virtio: reuse same-flow socket
 lookup in RX batches
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Sat, Oct 10, 2026 at 10:22:45PM +0800, Jia Jia wrote:
> > An RX lock batch still looks up the socket for every packet and takes a
> > temporary lookup reference, even though the batch already holds a reference
> > to the locked socket.
> >
> > Record the network namespace and packet address tuple when a batch starts.
> > Reuse the batch socket for later STREAM/RW packets with the same tuple, and
> > release the batch before looking up a different flow.
> >
> > The cached path still traces every packet, takes an skb owner reference,
> > validates socket state, source and transport, updates credit, and runs the
> > receive state machine. Only the socket table lookup and its temporary
> > reference are skipped.
> >
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  include/linux/virtio_vsock.h            |  3 ++
> >  net/vmw_vsock/virtio_transport_common.c | 58 +++++++++++++++----------
> >  2 files changed, 38 insertions(+), 23 deletions(-)
> >
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > index 26dde6909c4e..d6528681e052 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -287,6 +287,9 @@ struct virtio_transport_rx_batch {
> >       struct sock *sk;
> >       unsigned int pkts;
> >       size_t bytes;
> > +     struct net *net;
> > +     struct sockaddr_vm src;
> > +     struct sockaddr_vm dst;
> >  };
> >
> >  void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index e67dfcaa279c..73e5c7dfe8b4 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -1977,6 +1977,7 @@ void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
> >       batch->sk = NULL;
> >       batch->pkts = 0;
> >       batch->bytes = 0;
> > +     batch->net = NULL;
> >
> >       if (!sk)
> >               return;
> > @@ -2008,6 +2009,37 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> >       virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> >       virtio_transport_trace_recv_pkt(skb, &src, &dst);
> >
> > +     if (batch->sk) {
> > +             if (batch->net == net &&
> > +                 vsock_addr_equals_addr(&batch->src, &src) &&
> > +                 vsock_addr_equals_addr(&batch->dst, &dst) &&
> > +                 virtio_transport_recv_pkt_batchable(t, batch->sk)) {
> > +                     sk = batch->sk;
> > +                     if (!skb_set_owner_sk_safe(skb, sk)) {
> > +                             WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > +                             virtio_transport_rx_batch_finish(batch);
> > +                             kfree_skb(skb);
> > +                             return;
> > +                     }
> > +
> > +                     ctx = (struct virtio_transport_rx_pkt_ctx) {
> > +                             .net = net,
> > +                             .src = &src,
> > +                             .dst = &dst,
> > +                             .batchable = &batchable,
> > +                     };
> > +                     free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> > +
> > +                     if (!batchable)
> > +                             virtio_transport_rx_batch_finish(batch);
> > +                     if (free_pkt)
> > +                             kfree_skb(skb);
> > +                     return;
> > +             }
> > +
> > +             virtio_transport_rx_batch_finish(batch);
> > +     }
> > +
> >       sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
> >       if (!sk) {
> >               virtio_transport_rx_batch_finish(batch);
> > @@ -2018,33 +2050,10 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> >
> >       if (!skb_set_owner_sk_safe(skb, sk)) {
> >               WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > -             virtio_transport_rx_batch_finish(batch);
> >               kfree_skb(skb);
> >               return;
> >       }
> >
> > -     if (batch->sk && batch->sk != sk) {
> > -             /* Never acquire a second socket lock. */
> > -             virtio_transport_rx_batch_finish(batch);
> > -     }
> > -
> > -     if (batch->sk == sk) {
> > -             /* Keep the batch reference; drop this packet's lookup reference. */
> > -             sock_put(sk);
> > -             ctx = (struct virtio_transport_rx_pkt_ctx) {
> > -                     .net = net,
> > -                     .src = &src,
> > -                     .dst = &dst,
> > -                     .batchable = &batchable,
> > -             };
> > -             free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> > -             if (!batchable)
> > -                     virtio_transport_rx_batch_finish(batch);
> > -             if (free_pkt)
> > -                     kfree_skb(skb);
> > -             return;
> > -     }
> > -
>
> Not sure I love adding code and then removing it in the same series.
> Seems like these are asking to be squashed?
>

I'll fold patch 3 into patch 2 so batching is introduced with
same-flow lookup reuse from the start.

> >       lock_sock(sk);
> >       /*
> >        * Sockmap removal restores the native protocol under sk_callback_lock.
> > @@ -2063,6 +2072,9 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> >       free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> >       if (start_batch && batchable) {
> >               /* Keep the lookup reference until the batch is released. */
> > +             batch->net = net;
> > +             batch->src = src;
> > +             batch->dst = dst;
>
> Similar to my comment in the other patch, seems these are all in sk
> already?
>

For the batch cache, yes. I'll use the locked socket state for the
same-flow check. The packet values still need to be passed to the
locked receive path for source validation and reset handling.

> Best,
> Bobby
