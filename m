Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38EA39FCDD
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 04:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791951482; cv=pass; b=BDdco9Il96UT+t4kR5JLG13kbpWFcsAE4Ts3NMkGAmwhOzTPyV70okDAZgGU+Lz9xYqaczZ2/J83fAuUZZHEvJ/IaIIWi8+hWmqaYNGtQClnKUtkjA8Wsz7ht66dKGc3RAENVbNi5hEP+4omxSPz1s6jm4ezVAd41jbvM2Wxu3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791951482; c=relaxed/simple;
	bh=FCFoyOy4qvXMnUzHelNH4AHBinUUgJXQyV47QXx+bBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sS2D3ai0YLiG4goMMHBqY0HKR7ehGNkqJACMmuWGkSo+g2B8ZTuodmpijj3jsdHbxNBUL642GJ3KJhZBfP1AmcQheBEDfDGFg8XfJ5n4olofO4OMQhSjOM4k1h9djkhp/OeBL7k6NdOeOzb8Q05fvuD/r9ysCRTKnOoZRlaromU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdI2p6LC; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdI2p6LC"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91791ec1b83so30908406d6.1
        for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 21:18:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791951479; cv=none;
        d=google.com; s=arc-20260327;
        b=pOA0tk/huFVF7SYJub69Ow8lTJXoiT/woJfUzNKhuaTvenunauUqnLGjD40bmoO4b9
         btfSnGFXn15ows1LSEQgiEnfNpGdKtifJWhWbB2D/Cg60hPl3VvmL4EewIodGSrKamha
         rnUH1R3lR2dOGcRO2dJMnI2ORnrQ+43y58td8iNFwZmMCZotxP7/PoevN9+iij44zPCY
         nj5BXYfCLuHhYtekjZAdP/Jjuh44/1KafGoKZ4laXkQPmsqE9xZduLjb6zaBBw5H0BOF
         JpJ7CmONZQa6W5mMBso1mjCYbK4qjXXIqtdTLKl0z3B/1d/jv9UUXs7UiJFAK4vdh9Np
         tmKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5ZCjIb9MTs997peH+Jf+AEs7X4vp3T30edvZQYk3nBA=;
        fh=oLvcvXCut8qTwflHLc/HqXyp/4i6X1KHRoA/Qrkt1Vc=;
        b=kgWK0GauzxvWdKipPRmAYNjB/1jPGskorP/rpAxnv62QGYR+BAjsbaeT+iQVm1HqHm
         svjiJKEkelIkZngu1sF4fcBi3JHN9a2KgIKyI/SqN5SMvfZtt6+d8fPaBFYqPERGeYlv
         4L0yJwQA27G3oeDOpGAs1f8f1TixU2+TewOOzBwoj62i6GZs55WuXkkVTBIhosShZwEq
         uRZEdO/qdd+GhL02X7agpDswuHBy9aoiqtZEG4yX9LcaihAdmIAXxQrjhhndUkZPOZma
         KLm4uZC9ESZ+6FAMRGpdAYVyFGu1vsgAecQdIupEVWV8/adWSYDdeClMkhuSADOscqQ4
         h8hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791951479; x=1792556279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5ZCjIb9MTs997peH+Jf+AEs7X4vp3T30edvZQYk3nBA=;
        b=SdI2p6LCQ4aWaQPT6dillp92RI21bwsURrLkqh9CawHgTGt5ayFDz9YWLEYw+caXN6
         bTiaZhpDOG9II7LcivZaGyhxCF/Thd/6I9z7+R5vOPKcGAcXtZ0fPJLAslYG+p1tZXR7
         +NGiiP+A0bMWJtThoWCsVUpB5vveeEB9YM1RTB0tFMq8FNHvDwuZRywH8etLN1VzuD6a
         +AAaaORC27I23AXDgY9K+YNqlS4hRoUX7d90LU1GugjnmvZgbpjQzo0dCTDnxgPSQ9m9
         w9S3M9EAYyAkRCchj1URaqUEbYehTc7s/YnKtgT/DNv3RMfBcFcRTlu+9OQeV5DEAOnt
         UaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791951479; x=1792556279;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ZCjIb9MTs997peH+Jf+AEs7X4vp3T30edvZQYk3nBA=;
        b=JpMWNKFCJP+gf1SB2aYL3lRpOl1RG9pQcFHLfojjXxv3UtXyfxitbrMijduh7DRjbT
         BxcZCIVRBC79Xi74luW+tJShUTZwHxyl2rZrzQsj7PElM93tgTzZZbL6ffhVUt6d/QJ8
         os5d0d4wbQ9maa9kg1RFwo3axjvAiA/nYCdtaErB3Aq32h+JEW8/Mk3JsiOIHgtKgjjv
         E6XF/NKC3F2m9uTSX0qRjk2mqZjaTTgdsMaJ32xo3Xc52+W0N7pcvTxQ9s8OWjTk9lQs
         DQR4A33QX/legZACuW8ZPwcY/K1kOQ41lRdWWFAOnugkuI0oDq5JATkQWhFS9OrEPz2P
         /85w==
X-Forwarded-Encrypted: i=1; AKwUvByU3a8DwPiirkFgVl/1a7m6YQ5hcqZDGruTSoEJcM07COgqsgGUANIPFeWVMaJD84X60nY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwzP8lofTPWr5LFs0cYHLyZTSz63wedJxEblc1cBnpn3bMiGMi
	OKi/IGx/9bclJ8oQllzUxTE6HHL/lW+7bXP0vmg3y0GVMMOpOvaGEEQLW9q/px7dTluYtErf8ou
	/lS+S/mO51gsQPZdjkvVHo4/o1i038og=
X-Gm-Gg: AYBFou1zgouWB2d7k/LjXf83Oe6RvDwUKfZRdd71DidQiQth8gPSGMrLcPKiRWQDTvC
	9+YWsf1kaP9gWOLp7eGQ58OOdB61GfhIhf5vWlBrNQ4b14gty+vCK+vZ2QFHtItFTC24V519jgE
	2FoLsuufbtggqEaA2SrlJ0tiS/lD3Pwk6FUz+yB+Qv+Bx2gmThGS9QgzZnsEOGnybkp8FxYXQVa
	wqc8qN/EEVKjTbryor7Bo+q5J8zcIxmkwtqYFyxqoa4HkyUwse7d9LEKuz+VIx7fVl2BIFClf9N
	ODksOc5CytyJBrwlohBChjG70Q0Zjbx+wupr+H0Pe8hnM/Dd+d587eM=
X-Received: by 2002:a05:620a:4449:b0:93b:e9db:1bab with SMTP id
 af79cd13be357-93ebd27cc75mr2258515585a.56.1791951478672; Tue, 13 Oct 2026
 21:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-2-physicalmtea@gmail.com> <as1ZCkbya2jn72ip@devvm29614.prn0.facebook.com>
 <CAJwVaMJL4FFYLq523VY014oa4u7RWD0WUY0+seP1xh3GY5peiQ@mail.gmail.com> <as5nfI0qfqD64dc1@devvm29614.prn0.facebook.com>
In-Reply-To: <as5nfI0qfqD64dc1@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Wed, 14 Oct 2026 12:17:22 +0800
X-Gm-Features: AclHuK-Tjj0vL8jiV-17JnHCHultMYwdnuqEsTpaVilZ25EnMCMFZNG1gR08W4M
Message-ID: <CAJwVaM+SHuidjUeKD8-MX2ErbkaBUKE8cPYH2fzNJR+jH-oWZw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/5] vsock/virtio: split socket lookup from
 locked RX processing
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On Tue, Oct 13, 2026 at 11:26:38AM +0800, Jia Jia wrote:
> > >
> > > On Sat, Oct 10, 2026 at 10:22:43PM +0800, Jia Jia wrote:
> > > > Split virtio_transport_recv_pkt() so socket lookup is separate from=
 the
> > > > receive state machine that runs under the socket lock.
> > > >
> > > > Keep virtio_transport_recv_pkt() on its existing per-packet locking=
 path.
> > > > Pass the source and destination addresses used for lookup to the lo=
cked
> > > > receive path so they are decoded only once.
> > > >
> > > > Pass the network namespace and decoded address tuple through a pack=
et
> > > > context to the locked receive path.
> > > >
> > > > Preserve source validation and failure handling. Keep the lookup re=
ference
> > > > separate from the skb owner reference so the locked receive path ca=
n manage
> > > > the two lifetimes independently.
> > > >
> > > > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > > > ---
> > > >  net/vmw_vsock/virtio_transport_common.c | 139 ++++++++++++++++----=
----
> > > >  1 file changed, 96 insertions(+), 43 deletions(-)
> > > >
> > >
> > > [...]
> > >
> > > > +/*
> > > > + * The caller holds sk's socket lock and must free skb if this ret=
urns true.
> > > > + */
> > > > +static bool
> > > > +virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > > > +                              struct sk_buff *skb, struct sock *sk=
,
> > > > +                              const struct virtio_transport_rx_pkt=
_ctx *ctx)
> > > > +{
> > > > +     const struct sockaddr_vm *src =3D ctx->src;
> > > > +     const struct sockaddr_vm *dst =3D ctx->dst;
> > > > +     struct vsock_sock *vsk =3D vsock_sk(sk);
> > > > +     struct net *net =3D ctx->net;
> > > > +     bool space_available;
> > > >
> > > > -     /* Check if sk has been closed or assigned to another transpo=
rt before
> > > > -      * lock_sock (note: listener sockets are not assigned to any =
transport)
> > > > +     /* Check after acquiring the socket lock. Listener sockets ac=
cept packets
> > > > +      * from any source and are not assigned to a transport.
> > > >        */
> > > >       if (sock_flag(sk, SOCK_DONE) ||
> > > >           (sk->sk_state !=3D TCP_LISTEN &&
> > > > -          !vsock_check_source(vsk, &t->transport, &src))) {
> > > > +          !vsock_check_source(vsk, &t->transport, src))) {
> > > >               (void)virtio_transport_reset_no_sock(t, skb, net);
> > > > -             release_sock(sk);
> > > > -             sock_put(sk);
> > > > -             goto free_pkt;
> > > > +             return true;
> > > >       }
> > > >
> > > >       space_available =3D virtio_transport_space_update(sk, skb);
> > > >
> > > >       /* Update CID in case it has changed after a transport reset =
event */
> > > >       if (vsk->local_addr.svm_cid !=3D VMADDR_CID_ANY)
> > > > -             vsk->local_addr.svm_cid =3D dst.svm_cid;
> > > > +             vsk->local_addr.svm_cid =3D dst->svm_cid;
> > > >
> > > >       if (space_available)
> > > >               sk->sk_write_space(sk);
> > > > @@ -1875,12 +1891,49 @@ void virtio_transport_recv_pkt(struct virti=
o_transport *t,
> > > >               break;
> > > >       }
> > > >
> > > > +     return false;
> > > > +}
> > > > +
> > > > +/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's=
 vq->mutex
> > > > + * lock.
> > > > + */
> > > > +void virtio_transport_recv_pkt(struct virtio_transport *t,
> > > > +                            struct sk_buff *skb, struct net *net)
> > > > +{
> > > > +     struct virtio_transport_rx_pkt_ctx ctx;
> > > > +     struct sockaddr_vm src, dst;
> > > > +     struct sock *sk;
> > > > +     bool free_pkt;
> > > > +
> > > > +     virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> > > > +     virtio_transport_trace_recv_pkt(skb, &src, &dst);
> > > > +
> > > > +     sk =3D virtio_transport_recv_pkt_find_socket(skb, &src, &dst,=
 net);
> > > > +     if (!sk) {
> > > > +             (void)virtio_transport_reset_no_sock(t, skb, net);
> > > > +             goto free_pkt;
> > > > +     }
> > > > +
> > > > +     if (!skb_set_owner_sk_safe(skb, sk)) {
> > > > +             WARN_ONCE(1, "receiving vsock socket has sk_refcnt =
=3D=3D 0\n");
> > > > +             goto free_pkt;
> > > > +     }
> > > > +
> > > > +     lock_sock(sk);
> > > > +     ctx =3D (struct virtio_transport_rx_pkt_ctx) {
> > > > +             .net =3D net,
> > > > +             .src =3D &src,
> > > > +             .dst =3D &dst,
> > > > +     };
> > > > +     free_pkt =3D virtio_transport_recv_pkt_locked(t, skb, sk, &ct=
x);
> > >
> > > At this point the socket lookup succeeded with src/dst/net, why not j=
ust
> > > pass sk which already has all of them?
> > >
> >
> > If I understand this correctly, a successful lookup is not enough to
> > recover all of this from sk. The lookup may fall back from the
> > connected table to the bound
> > table, so the packet source must still be validated under the socket
> > lock; otherwise that check would become ineffective. The packet
> > destination is also needed after
> > a transport reset, and the RX namespace used for a reset reply is not
> > necessarily sock_net(sk) in global mode. I=E2=80=99ll remove the contex=
t
> > struct and pass src, dst, and
> > net directly.
>
> True that the lookup may fallback to the bound table, but this begs the
> question, why bother with the bound table here? If a socket hasn't
> landed in the connected table yet, then OP_RW is -EINVAL and we respond
> with RST anyway... so I'd guess we shouldn't even be trying to batch for
> those sockets.
>
> For connected sockets, the sk has the destination (vsk->remote_addr)
> needed by the reset. And yes, sock_net(sk) does not necessarily equal
> the net ptr used for a reset reply in global mode, but we don't really
> expect that for global mode in vsock, we only expect that
> vsock_net_check_mode() rules are followed. In this case where
> !net_eq(n0, n1), the RST reply will be routed correctly across
> namespaces following global mode rules.
>
> I could certainly be missing something and happy to be pointed to an
> instance of sk being insufficient here. In general, I think its nice to
> avoid new data structures if possible.
>

You're right. Although virtio_transport_recv_pkt_batchable() requires
TCP_ESTABLISHED and excludes other states from batching, the
bound-table fallback is
unnecessary there; batch admission can use only the connected lookup
and leave a miss to the normal path.

I also overlooked what the existing vsock_net_check_mode(sock_net(sk),
net) check guarantees. If the namespaces differ and the lookup
succeeds, both are
in global mode, so sock_net(sk) is sufficient for routing the RST. The
extra context is therefore unnecessary. Thanks for pointing this out.

I'll update this in the next version.

> Best,
> Bobby
