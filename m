Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8862E06EF
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 03:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862173; cv=pass; b=fCH4KwQw0PQATMfvKFIWw6ybz3kDxLbdp2nRaS7F4iRrf+Cl50pw9ksvdXvYDWAof1B2Wui8OgD31Z5qrOq0+DOl/sKkFuzJv0H1UKWjYc8hiR1OgTYj+ugra+1quPmGeWUfEbdQOEJL8vdEbbZvNq1uyg5otIVp3FpReIEkpEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862173; c=relaxed/simple;
	bh=+tf5KT/LBLH9dUzbsqRGcwYkkoel0brUJOereQ+cnFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgskVzoBAwC7ypa5gqUrlSOfgEXs20J3ObdybqVw0m0py83VOjOb9QVGECEi8RSKLRl4lurdZ8ol2ZXoglhZGgVpIdzc3nZEOyCLlReFgVpdKS3Xc9yHwSWwzJrpbk+85GDntq0Y/6DXksFogOM465CGuLc1V5BhCUMPaKkzoA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6SfeQAs; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6SfeQAs"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-917a9f42283so29898736d6.0
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 20:29:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791862170; cv=none;
        d=google.com; s=arc-20260327;
        b=ABGlwEzFuR5doCH4riXv3HLmRHcUjOVgdBaLm9M0QNigvw8nu2WkdR1U8Ug76GW8M1
         y3e3tfB/xKqsKqivKNj50cknyQxPOsQGaBBxnHGNXbtwncVXoD449GVLWD7NE+tvSYJR
         op5jLJHplwBQze4jIUQToMH5ldxZ4Vfb1lH9ZFqMogk1d7yd2kvPNHJXIzQ6IKQojdcX
         X9Mt2ozV347KJHNz2Y0SA9tlSIzI+3Ap12c56cARHNCDtiTDHirqoo4gDARkoP2p4l3u
         Jl3sChcQtAEUnAR416gd4hSvKMfb+NW+9CONMlsj9OhG5+WKQcgcpWhDSljSXz3HdDIg
         cGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pjpZB2jPs3cIEERlTXUY/rEvSbEEM3b+tieI1aC2ttk=;
        fh=3KloNeUtYnLoW8/xfGcd+ltJgElgUWSCmZNtlga6EGw=;
        b=o/4xc3JtKasUcq2PmOqplnKGs3G7wk8RZviBjahhdaGImWaR/NbUDJ7u8POQwz27GK
         JIINfELKUncEaj1BcA0zu4cgFbnrIRumlqV+Z5SyofEg2w9yqwjs4lY9yIUhZGx8LC8f
         bJ/SoFXsoASlViZo33fcELMY6ludzbe0Z5P30Dn+9vhWJv1ngJEawbSEO/2AhbYf26Y2
         PvPtYNz1qVn80HWJrqTXn+RxA6TQB7lGx6yO2WOXyRXB4Uir9QbStukvSFVju+97f74Z
         VMZOf4+tm5n01pbDuQpp89hZwo5ccQ1XwOO5kb8/Stag/ahd/PQzko8TjlB5bGvixZh8
         VIyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862170; x=1792466970; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pjpZB2jPs3cIEERlTXUY/rEvSbEEM3b+tieI1aC2ttk=;
        b=S6SfeQAsRznvcTlaSmLaDbAYbgy2VgLgpsPLtljYWnDF2AP58kABPuIl7OFfs1+iF7
         SDxRSCifT94U68SzRAvy8o84DMAsbtM/fSbs+V1reKM+rWZVoKXj+anwn8RLr8ph/Vvb
         dX1x/lmM9xW686hGWpH992rqzr2/ltfd3Cg7UO/ZDJ+Jo9EdDPPAcc2QCA7eD1DJ8GYR
         cJ+57wdFxJBUANOSov77Fsqz+OSoe+r8vHSRWMuR505wRRrrpXP8AE5VYQl5s6XoY7cg
         oqpDih5n0AcZysiR2PQJwQFNJD6qOs1FQpb+YVmEbiVDdzjItJuqXTQowHeE8+hSZjmE
         bfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862170; x=1792466970;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pjpZB2jPs3cIEERlTXUY/rEvSbEEM3b+tieI1aC2ttk=;
        b=qujuIFbV8/6NwVy/oTHvyc2wGoJlsseDTPC00L8MRRhKwdrZlYisG+vgVIRuhpeBNm
         6xJUZtCwUmcadjD5fJZtTOBsA9cFduhLNkEYicnC/P06iE3vlp1lE52PEW91iVc74y75
         HAO6U39+brlGEof7BJ3QHAsYcKLrjPjhOjInbIUEYduFfFemUTPiajXnnNEZ3ctBv0ht
         5bRINsI68UMZe/BwZyFX6bZ5/d2OhGpQ3IuaIC7MIyuBcp+/CC9Lb8Q+bQ4b7Qdb5yNu
         eyVfKd4MbXNBN8r//CcrPrLF0RYu/lElA+8VuGj6IWQASaqWr6+zJ7zhNAoVSAcQhvWY
         VlVw==
X-Forwarded-Encrypted: i=1; AKwUvBw8LBF0Z/zbNpkVxhgy2TpjPj1bPLD5uhzN0NmvMMDGWigEu0GvE8eP+8rsx06md3X8/U4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrR/BGJN0Z86Sz0QZ2ubkC0ofgt2GhNd5I5SUF9AvYevJpnVsO
	l6JE8U0ZwsHn+bTf0oy3SAqPxIMTrOY5boygawaXjSZ2MFojQ2M9Qt1X0Q00ygusKGTyIuMcEo9
	uoQB6PntxpmtqJkxYTZ8s+3l8XddsokQ=
X-Gm-Gg: AYBFou1H2yzt/PY/wLmnE7mFCiwRqR/pevihFcfYp8FRl23NC1YMWn8E6AirEfa/DSx
	AR7VSOdzBNiKQ26bEyg/1qqa1rztHrNap1HaW1w0rUgJI5tRQRI7NasRDQf/aRjfbpaF3v6vvDt
	dJ6gzFrHD9Rpw6+G8JHApL095pTmyVmST4w/2juRRakMGBrSxzDsKV094zQtkMU+rBTGGq66b8o
	3Mrsz5XMg+ONr2OdDafFBftIDmicCClKfbU/6qe8QIqvwgT2wWvreHDqU9hY+hCiEbgF1zGcPAX
	WJP6fbhzPgHCZLXFXi8qnKVNJiGU3g+7I/3ErHkk1ADr2ahczhSzCiM=
X-Received: by 2002:a05:620a:2591:b0:93b:d7a3:45d4 with SMTP id
 af79cd13be357-93ebd29c0bcmr1838496485a.61.1791862169689; Mon, 12 Oct 2026
 20:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-3-physicalmtea@gmail.com> <as1b8+vIy8K8J5cN@devvm29614.prn0.facebook.com>
In-Reply-To: <as1b8+vIy8K8J5cN@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Tue, 13 Oct 2026 11:28:53 +0800
X-Gm-Features: AclHuK8y1cO0AT-SrEL4DpgMypGTtpHkPFcgXXXujBQ_ReOHft-UeQLoN7blnMU
Message-ID: <CAJwVaM+Mht=DiODUJHzokkpGMjcBW9caHh6+Em1+-J-C-_25Yw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/5] vsock/virtio: amortize RX socket locking
 for stream packets
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Sat, Oct 10, 2026 at 10:22:44PM +0800, Jia Jia wrote:
> > The virtio-vsock RX worker currently acquires and releases the socket lock
> > for every received packet. Keep the lock held while processing a bounded
> > run of packets that belongs to the same socket.
> >
> > Only ordinary RW packets for an established STREAM socket whose transport
> > and protocol remain unchanged are eligible. Control packets, SEQPACKET
> > traffic, state or transport changes, malformed packets, and sockets whose
> > protocol has been replaced end the active batch and retain their existing
> > handling.
> >
> > Serialize the initial eligibility check with sk_callback_lock because
> > sockmap removal restores the protocol without taking the socket lock.
> >
> > Limit each batch to 64 packets or 64KB of payload, bounding the work under
> > one socket lock. Keep the lookup reference until the batch finishes.
> >
> > Keep a batch only while another skb metadata charge fits in the receive
> > buffer. Share this predicate with virtio_transport_inc_rx_pkt(). When an
> > enqueued skb consumes the final metadata slot, finish the batch and release
> > the socket lock before processing another packet, restoring the reader's
> > scheduling opportunity from the per-packet path.
> >
> > The virtqueue callback remains a queue_work() callback. Batching runs only
> > in the process-context RX worker.
> >
> > Introduce virtio_transport_rx_batch_finish() to tear down the batch and
> > release the socket lock and lookup reference.
> >
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  include/linux/virtio_vsock.h            |  11 ++
> >  net/vmw_vsock/virtio_transport.c        |  29 ++++-
> >  net/vmw_vsock/virtio_transport_common.c | 147 +++++++++++++++++++++++-
> >  3 files changed, 183 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > index f91704731057..26dde6909c4e 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -282,6 +282,17 @@ void virtio_transport_destruct(struct vsock_sock *vsk);
> >
> >  void virtio_transport_recv_pkt(struct virtio_transport *t,
> >                              struct sk_buff *skb, struct net *net);
> > +
> > +struct virtio_transport_rx_batch {
> > +     struct sock *sk;
> > +     unsigned int pkts;
> > +     size_t bytes;
> > +};
> > +
> > +void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> > +                                  struct sk_buff *skb, struct net *net,
> > +                                  struct virtio_transport_rx_batch *batch);
> > +void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch);
> >  void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
> >  u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
> >  void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
> > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > index 4f9aa9c4c3aa..ef076732158d 100644
> > --- a/net/vmw_vsock/virtio_transport.c
> > +++ b/net/vmw_vsock/virtio_transport.c
> > @@ -629,8 +629,16 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
> >       return seqpacket_allow;
> >  }
> >
> > +/*
> > + * Keep a bounded run of packets for one socket under a single socket lock.
> > + * Limit packet count and payload size to bound the work done while locked.
> > + */
> > +#define VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS   64
> > +#define VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES  (64 * 1024)
>
> Why both? Seems like MAX_PKTS would sufficiently bound the lock hold
> time.
>
> > +
> >  static void virtio_transport_rx_work(struct work_struct *work)
> >  {
> > +     struct virtio_transport_rx_batch batch = {};
> >       struct virtio_vsock *vsock =
> >               container_of(work, struct virtio_vsock, rx_work);
> >       struct virtqueue *vq;
> > @@ -666,6 +674,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> >                       /* Drop short/long packets */
> >                       if (unlikely(len < sizeof(*hdr) ||
> >                                    len > virtio_vsock_skb_len(skb))) {
> > +                             virtio_transport_rx_batch_finish(&batch);
> >                               kfree_skb(skb);
> >                               continue;
> >                       }
> > @@ -673,6 +682,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> >                       hdr = virtio_vsock_hdr(skb);
> >                       payload_len = le32_to_cpu(hdr->len);
> >                       if (unlikely(payload_len > len - sizeof(*hdr))) {
> > +                             virtio_transport_rx_batch_finish(&batch);
> >                               kfree_skb(skb);
> >                               continue;
> >                       }
> > @@ -680,16 +690,33 @@ static void virtio_transport_rx_work(struct work_struct *work)
> >                       if (payload_len)
> >                               virtio_vsock_skb_put(skb, payload_len);
> >
> > +                     if (batch.sk &&
> > +                         payload_len > VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES -
> > +                                       batch.bytes) {
> > +                             virtio_transport_rx_batch_finish(&batch);
> > +                     }
> > +
> >                       virtio_transport_deliver_tap_pkt(skb);
> >
> >                       /* Force virtio-transport into global mode since it
> >                        * does not yet support local-mode namespacing.
> >                        */
> > -                     virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
> > +                     virtio_transport_recv_pkt_batch(&virtio_transport, skb, NULL,
> > +                                                     &batch);
> > +
> > +                     if (batch.sk) {
> > +                             batch.pkts++;
> > +                             batch.bytes += payload_len;
> > +                             if (batch.pkts >= VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS ||
> > +                                 batch.bytes >= VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES) {
> > +                                     virtio_transport_rx_batch_finish(&batch);
>
> I'm not fundamentally opposed to the batch struct, but I wonder if its
> needed?

With the byte limit retained, the batch still needs to carry the
socket and both counters across calls. A batch may also be finished
inside the receive helper, so
keeping that state together avoids having the worker maintain a
separate counter that can get out of sync. The later notification
patches add their pending state to the
same object as well, so I would prefer to keep the batch struct.

> If we can get rid of BATCH_MAX_BYTES, then we only need to do
> pkts++ in a local var, and can pass an &sk ptr-ptr to
> virtio_transport_recv_pkt_batch()?
>

My thinking was that the two limits bound different things. The
64-packet limit bounds per-packet work for small packets, while the
64K limit bounds how much data can
be queued while the reader cannot acquire the socket lock. A single
packet can carry up to 64K, so a packet-only limit could let one batch
cover as much as 4M. Since
the receive buffer can be enlarged, I do not think the default 256K
buffer is a substitute for the byte limit. I would prefer to keep
both.

> Best,
> Bobby
>
> > +                             }
> > +                     }
> >               }
> >       } while (!virtqueue_enable_cb(vq));
> >
> >  out:
> > +     virtio_transport_rx_batch_finish(&batch);
> >       if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> >               virtio_vsock_rx_fill(vsock);
> >  out_nofill:
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index e3e75e59896f..a73e37b3fa62 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -576,10 +576,16 @@ virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,
> >       skb_queue_splice(&new_queue, &vvs->rx_queue);
> >  }
> >
> > +static bool
> > +virtio_transport_rx_skb_has_headroom(struct virtio_vsock_sock *vvs)
> > +{
> > +     return (u64)(skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0) <=
> > +             vvs->buf_alloc;
> > +}
> > +
> >  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> >                                       u32 len)
> >  {
> > -     u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> >
> >       /* Allow at most buf_alloc * 2 total budget (payload + overhead),
> >        * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
> > @@ -588,7 +594,7 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> >        * queue growth.
> >        */
> >       if ((u64)vvs->buf_used + len > vvs->buf_alloc ||
> > -         skb_overhead > vvs->buf_alloc)
> > +         !virtio_transport_rx_skb_has_headroom(vvs))
> >               return false;
> >
> >       vvs->rx_bytes += len;
> > @@ -1834,10 +1840,28 @@ struct virtio_transport_rx_pkt_ctx {
> >       struct net *net;
> >       const struct sockaddr_vm *src;
> >       const struct sockaddr_vm *dst;
> > +     bool *batchable;
> >  };
> >
> > +static bool
> > +virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
> > +                                 struct sock *sk)
> > +{
> > +     struct vsock_sock *vsk = vsock_sk(sk);
> > +     struct virtio_vsock_sock *vvs = vsk->trans;
> > +
> > +     return sk->sk_state == TCP_ESTABLISHED &&
> > +            sk->sk_type == SOCK_STREAM &&
> > +            READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
> > +            !sock_flag(sk, SOCK_DONE) &&
> > +            vsk->transport == &t->transport &&
> > +            vvs && virtio_transport_rx_skb_has_headroom(vvs);
> > +}
> > +
> >  /*
> > - * The caller holds sk's socket lock and must free skb if this returns true.
> > + * The caller holds sk's socket lock.  Set @batchable if the socket can remain
> > + * locked for another ordinary STREAM/RW packet.  Return true if the caller
> > + * must free @skb.
> >   */
> >  static bool
> >  virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > @@ -1850,6 +1874,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >       struct net *net = ctx->net;
> >       bool space_available;
> >
> > +     if (ctx->batchable)
> > +             *ctx->batchable = false;
> > +
> >       /* Check after acquiring the socket lock. Listener sockets accept packets
> >        * from any source and are not assigned to a transport.
> >        */
> > @@ -1891,6 +1918,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >               break;
> >       }
> >
> > +     if (ctx->batchable)
> > +             *ctx->batchable = virtio_transport_recv_pkt_batchable(t, sk);
> > +
> >       return false;
> >  }
> >
> > @@ -1941,6 +1971,117 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
> >
> > +/*
> > + * Finish the RX batch.
> > + * For a non-empty batch, the caller must hold the socket lock acquired with
> > + * lock_sock(). This function releases the lock and the batch's lookup
> > + * reference.
> > + * An empty batch is a no-op.
> > + */
> > +void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
> > +{
> > +     struct sock *sk = batch->sk;
> > +
> > +     batch->sk = NULL;
> > +     batch->pkts = 0;
> > +     batch->bytes = 0;
> > +
> > +     if (!sk)
> > +             return;
> > +
> > +     release_sock(sk);
> > +     sock_put(sk);
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_transport_rx_batch_finish);
> > +
> > +void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> > +                                  struct sk_buff *skb, struct net *net,
> > +                                  struct virtio_transport_rx_batch *batch)
> > +{
> > +     struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > +     struct virtio_transport_rx_pkt_ctx ctx;
> > +     struct sockaddr_vm src, dst;
> > +     bool batchable, start_batch;
> > +     struct sock *sk;
> > +     bool free_pkt;
> > +
> > +     /* Only STREAM/RW packets can share a socket lock. */
> > +     if (le16_to_cpu(hdr->type) != VIRTIO_VSOCK_TYPE_STREAM ||
> > +         le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_RW) {
> > +             virtio_transport_rx_batch_finish(batch);
> > +             virtio_transport_recv_pkt(t, skb, net);
> > +             return;
> > +     }
> > +
> > +     virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> > +     virtio_transport_trace_recv_pkt(skb, &src, &dst);
> > +
> > +     sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
> > +     if (!sk) {
> > +             virtio_transport_rx_batch_finish(batch);
> > +             (void)virtio_transport_reset_no_sock(t, skb, net);
> > +             kfree_skb(skb);
> > +             return;
> > +     }
> > +
> > +     if (!skb_set_owner_sk_safe(skb, sk)) {
> > +             WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > +             virtio_transport_rx_batch_finish(batch);
> > +             kfree_skb(skb);
> > +             return;
> > +     }
> > +
> > +     if (batch->sk && batch->sk != sk) {
> > +             /* Never acquire a second socket lock. */
> > +             virtio_transport_rx_batch_finish(batch);
> > +     }
> > +
> > +     if (batch->sk == sk) {
> > +             /* Keep the batch reference; drop this packet's lookup reference. */
> > +             sock_put(sk);
> > +             ctx = (struct virtio_transport_rx_pkt_ctx) {
> > +                     .net = net,
> > +                     .src = &src,
> > +                     .dst = &dst,
> > +                     .batchable = &batchable,
> > +             };
> > +             free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> > +             if (!batchable)
> > +                     virtio_transport_rx_batch_finish(batch);
> > +             if (free_pkt)
> > +                     kfree_skb(skb);
> > +             return;
> > +     }
> > +
> > +     lock_sock(sk);
> > +     /*
> > +      * Sockmap removal restores the native protocol under sk_callback_lock.
> > +      * Serialize this initial eligibility check with that update.
> > +      */
> > +     read_lock_bh(&sk->sk_callback_lock);
> > +     start_batch = virtio_transport_recv_pkt_batchable(t, sk);
> > +     read_unlock_bh(&sk->sk_callback_lock);
> > +
> > +     ctx = (struct virtio_transport_rx_pkt_ctx) {
> > +             .net = net,
> > +             .src = &src,
> > +             .dst = &dst,
> > +             .batchable = start_batch ? &batchable : NULL,
> > +     };
> > +     free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> > +     if (start_batch && batchable) {
> > +             /* Keep the lookup reference until the batch is released. */
> > +             batch->sk = sk;
> > +             return;
> > +     }
> > +
> > +     release_sock(sk);
> > +     sock_put(sk);
> > +     if (free_pkt)
> > +             kfree_skb(skb);
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt_batch);
> > +
> >  /* Remove skbs found in a queue that have a vsk that matches.
> >   *
> >   * Each skb is freed.
> > --
> > 2.34.1
