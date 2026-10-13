Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5049741441B
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 03:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862038; cv=pass; b=fBKpXlBe3S4MA7zAmvypNWNyoXnihJH0bDMQvKkfP8GSR1oPEV3XJfW4ceR4g1oyMmYx16hawyumlKQSqYXO0IEpVFTjqIbqSjkKV0filERP7v9n+gjVt7okZe5Q22SIyBzykYqtWxVC1rc42+/51zO5/B4o7NIsO99rdvqrrXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862038; c=relaxed/simple;
	bh=skfSan0+1XZB1gCLut2T846bBKf4wrfvYxze6DiUgyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrvMz0aWKfjj/HGQBUWBte19p/0uI2tS+85WNAUuAVXcQjPmoglMKYawC/F25FltwFftGVUuQKlj+tUXHyPyC8hs2wbpr0wRGEoRIzxghPt8yKtlRmwRzmEGTWe3LvXrUKjqRKK1baLw4eCsOM9nBEnSDad9sq1RFGdcnp/+rQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwjYvO38; arc=pass smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwjYvO38"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93e027da22eso170685785a.0
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 20:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791862036; cv=none;
        d=google.com; s=arc-20260327;
        b=VJagaMv7CRBxZ0x+UGnTqTkMmqklD6yfteq6UHcEDUQDhZ//r4Vy6D57I4fnvLn2ZG
         3unUQFn08mOpB44nZ8X5XUr7GP/CZghNh5XWNC1HCVj4hxkI9+aLCM7o+ZRFH0ytqYyo
         pwvD36zXku25QK42o4qlcj4CGFt/skrjyv5itRZn+S94WAyAtB0Advk0icM6T0TnMybn
         ngnleT8V7+YGhBCeZ/iG1kMNFCMpculLrSxkhjG14zvgcg9cyI9Kpd2W4x02ARJzOi+n
         0kV+rtqnwG6/jFGVUge0bUc5T+qeNxzsoU185hfpj1rytIkEmH1+QB/PyyaGLTU2KNTZ
         RZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GnoX8iRBAWCVauZf/sBd0GnSZBf0BiraG31WKJrHpzA=;
        fh=rB3W2/7iDcAPKmEXGh7OFmlLOuIiwZwW0ENMsNyb0hM=;
        b=CAWhkcOAtZebxxb0ph0Gy/WVkp/Wd8cdVc683CuXMoBxI87v9RqipbNmBp/7XSWadc
         KAHnW0opLARdp9sFgIPlF2vVRgAPHJYKgQ7rA4Mb14OuMxMTKMoMzBLJNsAtRvLgaDIl
         54RC73HMUAbE1m876YSw5hwLWcM/XfOiOcQfajycUrmAONdgIpzIFvrSgprxV1KlL2Vo
         xH6DzlHEBaNVt4OqPSzdx0kxqoE9fKoUA/GoCyRQOi5nHzbbespRUfKbbUb/NSctHnTd
         uD9PHw5BZfBCgsMZFE4Fz0q0uFRLap4vfiOk27DYparIoeDK6Po0qolVoi8L9dNhxdfB
         4D6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862036; x=1792466836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GnoX8iRBAWCVauZf/sBd0GnSZBf0BiraG31WKJrHpzA=;
        b=CwjYvO38fOqQHnicYM2mN6mt+w7UO33Rj+UogHeUu8SRJxqjI0DobRZjiKG9yIUhM1
         A2Gb3r1NimARynJC04G84Fses9uXheZD2h43631hjzfpd4Wti2Yrx6srFxOVK+U+B67z
         pJuUmTCFSFjsF/xk0Yhbdw4Ssfugk8Rbxb5GW7vcM7D40B0qVuqPgJd0WBz56I3GMyMl
         5/FhxdzlXZOBHxp6Qnk1kwSy/Efy/VJG4vqmQjXbiXFWNSdhWPdneZk/eF4oaQ71hfYb
         aKKMaJm35kSHWDwap4vhQzU5U61LPzJ3WI3urvY6Dc4Kx2rlS6FiMKu3h+KLHbd6M3IU
         GK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862036; x=1792466836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GnoX8iRBAWCVauZf/sBd0GnSZBf0BiraG31WKJrHpzA=;
        b=WhYsUB/MTQPpskPoldQmayBFrM9WJjCPfXpo0ZpE11nd5y5V/tXQqRWITSFPguYyiN
         vKEJCfO3lJSthoFLQcosvL90T5o5cAnO7gi5or0Bdu6nwHu4s72RONc8BZsa6HpddMaT
         hacycFN6A1WhBC7JQl70vcW6mTXMoBcPA7/0A5SkkL5NC5RJG0jol9LrNmGxVyIsLR3z
         Z6O1dJ9nKeikGFmuqAmG7bpv7CnkM3DhCZkIkHfZtdqbBy0S+IT4NRYfZjsIpOBYnDme
         8KmLs452lK025//1PXEmwQL8DmX5CcJnBpJU8q4N5aj+RpDFqQ80QGfPMEarPyo+nERG
         geVw==
X-Forwarded-Encrypted: i=1; AKwUvBykI9gVxHyxGdCkftkXWRFj9OMT+2pfUdC12+9WAY54mXx5APUTQX7pnE8657uemYUISQc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIvUzpQV/xS64rJrIT+5GhvuNIU+OdEcDKb21LjSuhAjge+j13
	eDmQm06la9yQlGnIljybG6wf2H87JwOVGRJuJduUVcM5QAMO2Dc9RrCYTQ+GeLBW4FfVFter4Xh
	B88780lIH6eQHmuzZDC1x5+oydXxe/ds=
X-Gm-Gg: AYBFou2+qwoFtawevIbdmZrCwlKF1JydO0/5AZnbK5/B/N7UQ6WqOqtzJCDdD1srOyj
	h1AgCAAzmQ3PsFFZQgXXKU8TqAQxU2rHJrl8tL1sGfp2Ygc24F/jejnPMXhcGf0muKdxOjddsea
	vBZ+310jwDttNoqdFEPHUjWdPdcGfTu9gFK9d3WsawY+zQvth0oGrSMmckxAw7rMYIY5JfuoXyl
	5mYTQm9SFzc00KKSvEa+atyFI8BFy98q0vyxRnqUutoF7rWPPmUc1dRk/nxz/lCv0hY1vf8YYBm
	QcTEcuIaqRDro1LTHVm2dhFTHJCTdMnR6yw872JNq/PqtVuykywKGr4=
X-Received: by 2002:a05:620a:19a2:b0:934:ab73:ac53 with SMTP id
 af79cd13be357-93ebcc1186emr1807392585a.0.1791862035540; Mon, 12 Oct 2026
 20:27:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-2-physicalmtea@gmail.com> <as1ZCkbya2jn72ip@devvm29614.prn0.facebook.com>
In-Reply-To: <as1ZCkbya2jn72ip@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Tue, 13 Oct 2026 11:26:38 +0800
X-Gm-Features: AclHuK-0Vr6L1DTitDJsFP7Cyfe2EIaVm5DyDLTJkZtt76nbyfmG1WpYEm38C3s
Message-ID: <CAJwVaMJL4FFYLq523VY014oa4u7RWD0WUY0+seP1xh3GY5peiQ@mail.gmail.com>
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
> On Sat, Oct 10, 2026 at 10:22:43PM +0800, Jia Jia wrote:
> > Split virtio_transport_recv_pkt() so socket lookup is separate from the
> > receive state machine that runs under the socket lock.
> >
> > Keep virtio_transport_recv_pkt() on its existing per-packet locking pat=
h.
> > Pass the source and destination addresses used for lookup to the locked
> > receive path so they are decoded only once.
> >
> > Pass the network namespace and decoded address tuple through a packet
> > context to the locked receive path.
> >
> > Preserve source validation and failure handling. Keep the lookup refere=
nce
> > separate from the skb owner reference so the locked receive path can ma=
nage
> > the two lifetimes independently.
> >
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  net/vmw_vsock/virtio_transport_common.c | 139 ++++++++++++++++--------
> >  1 file changed, 96 insertions(+), 43 deletions(-)
> >
>
> [...]
>
> > +/*
> > + * The caller holds sk's socket lock and must free skb if this returns=
 true.
> > + */
> > +static bool
> > +virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > +                              struct sk_buff *skb, struct sock *sk,
> > +                              const struct virtio_transport_rx_pkt_ctx=
 *ctx)
> > +{
> > +     const struct sockaddr_vm *src =3D ctx->src;
> > +     const struct sockaddr_vm *dst =3D ctx->dst;
> > +     struct vsock_sock *vsk =3D vsock_sk(sk);
> > +     struct net *net =3D ctx->net;
> > +     bool space_available;
> >
> > -     /* Check if sk has been closed or assigned to another transport b=
efore
> > -      * lock_sock (note: listener sockets are not assigned to any tran=
sport)
> > +     /* Check after acquiring the socket lock. Listener sockets accept=
 packets
> > +      * from any source and are not assigned to a transport.
> >        */
> >       if (sock_flag(sk, SOCK_DONE) ||
> >           (sk->sk_state !=3D TCP_LISTEN &&
> > -          !vsock_check_source(vsk, &t->transport, &src))) {
> > +          !vsock_check_source(vsk, &t->transport, src))) {
> >               (void)virtio_transport_reset_no_sock(t, skb, net);
> > -             release_sock(sk);
> > -             sock_put(sk);
> > -             goto free_pkt;
> > +             return true;
> >       }
> >
> >       space_available =3D virtio_transport_space_update(sk, skb);
> >
> >       /* Update CID in case it has changed after a transport reset even=
t */
> >       if (vsk->local_addr.svm_cid !=3D VMADDR_CID_ANY)
> > -             vsk->local_addr.svm_cid =3D dst.svm_cid;
> > +             vsk->local_addr.svm_cid =3D dst->svm_cid;
> >
> >       if (space_available)
> >               sk->sk_write_space(sk);
> > @@ -1875,12 +1891,49 @@ void virtio_transport_recv_pkt(struct virtio_tr=
ansport *t,
> >               break;
> >       }
> >
> > +     return false;
> > +}
> > +
> > +/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq-=
>mutex
> > + * lock.
> > + */
> > +void virtio_transport_recv_pkt(struct virtio_transport *t,
> > +                            struct sk_buff *skb, struct net *net)
> > +{
> > +     struct virtio_transport_rx_pkt_ctx ctx;
> > +     struct sockaddr_vm src, dst;
> > +     struct sock *sk;
> > +     bool free_pkt;
> > +
> > +     virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> > +     virtio_transport_trace_recv_pkt(skb, &src, &dst);
> > +
> > +     sk =3D virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net=
);
> > +     if (!sk) {
> > +             (void)virtio_transport_reset_no_sock(t, skb, net);
> > +             goto free_pkt;
> > +     }
> > +
> > +     if (!skb_set_owner_sk_safe(skb, sk)) {
> > +             WARN_ONCE(1, "receiving vsock socket has sk_refcnt =3D=3D=
 0\n");
> > +             goto free_pkt;
> > +     }
> > +
> > +     lock_sock(sk);
> > +     ctx =3D (struct virtio_transport_rx_pkt_ctx) {
> > +             .net =3D net,
> > +             .src =3D &src,
> > +             .dst =3D &dst,
> > +     };
> > +     free_pkt =3D virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
>
> At this point the socket lookup succeeded with src/dst/net, why not just
> pass sk which already has all of them?
>

If I understand this correctly, a successful lookup is not enough to
recover all of this from sk. The lookup may fall back from the
connected table to the bound
table, so the packet source must still be validated under the socket
lock; otherwise that check would become ineffective. The packet
destination is also needed after
a transport reset, and the RX namespace used for a reset reply is not
necessarily sock_net(sk) in global mode. I=E2=80=99ll remove the context
struct and pass src, dst, and
net directly.

> Best,
> Bobby
