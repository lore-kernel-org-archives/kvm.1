Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03DC418A46
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 03:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791861922; cv=pass; b=RW5iqzQXe3zEwDaz5gOiWQzCLdKDHyTaBsbWmEdmOW8ZkYEsFl0b1BO3Jc5mU36JhHGG5jvd67Og/bOQMVxSPmPysmyLkc88Q94hVOdZimMYZDMhxZ6vQDjg+dgMT8YV1mMz6Qt54hugNDrHpxT9om3zxJgmFtBM+w1CX+fSvYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791861922; c=relaxed/simple;
	bh=0b7OaC4HUufUZhIweIEW73CTwJE8jbl1XyGAQdeamgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoNQaAduRKuLL83Vfx6RtmVY2POLDFsmOu5jJ0i0dwBXdwOo4K0Gt0Y3gDDczGi2X2Njr+IhLIYJJ1O+z7XYkoTzQX0IZaqL6+pb9IYsMeZSp6wMEwysKx7VFHHxVHuhzS7OsjLlMJmsntQjQz/InVYKBzOjuix523HV5+keJnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jM/MMwV+; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM/MMwV+"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93e64d52949so230873485a.1
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 20:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791861920; cv=none;
        d=google.com; s=arc-20260327;
        b=fuPgoyVZhaDP9zlenx6c0ZV0vbYEpgSTQFhf5tg3oHx42ZPgsIIWNysNdGqZ/0FUyz
         JeK2vQYAcNEDIGaLj7g2fAIgWBbgY55XbhC/gJR5dSaWA8n9taOfuZiiHyFo36y4N++e
         QDRkTVadWaVix/vu97LvSkWmbk27aYwKiqtmosNQ0jODleqTB4mKLDPA8eiJCe6Omda2
         IEFenpz94SeIplNh1B7zX9/uh0Iea2+U2xwpMYrny8RBAvPA0EpHJyKtCIOjkhoZLLtC
         3bREisdHk0gZzHXjeNbkMjF99Lh9Y2ytDjFSGeEyrq2tB23S6m0y6Yd0iEVkhMKWkXP/
         wwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8btU5rJ+Pel0WPP/jtsdEEDxh2u3x4YA62OOuosbpv4=;
        fh=nxWkKdYjgtdY9nTPOk0dYsNLEQh++UqOPeMKOC+vxck=;
        b=O+d0lGm3C0p7KH8eHdmx0jhqKawznjP6is3wIWOTbHfW+W1naphByG25BwFixUT7qO
         XuKHLn1TVQIs60iL5prsVx99ose9V5naM0sao3plmRGqiKKJ+tkfP0rO/aIRnw0LuSpm
         s26SOwmNXLnbGyo3d31mPAfw8+hNzU1k5nC+E6bMrpc4cM2PejB2XmZq4icX+TDjObUo
         aO52PJ2N7gv0zAgV/oWF5FLqE885zcu6X8SSDrW1eECh5gzwSPdEPm64zkm898XURwIL
         zyglRQn4+8k4NG/VKWggsEPkQijvjeIksjyY64Rfn46LTF0Y1xzE3cA/4iCm9yNEq0e/
         LD1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791861920; x=1792466720; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8btU5rJ+Pel0WPP/jtsdEEDxh2u3x4YA62OOuosbpv4=;
        b=jM/MMwV+spQdqLF4vVT1GKlzN7FtZ//7yship3FuXnn54P8A/8P7vr9MIsUglGAD2y
         pYTS2NZhZJsEQ2AnkMGK7gz5jtsYT7iy4cCtuc8yvjovpeCu+ftRYMgPpybgipk+G7eq
         ucZ5xgLF6wtocjvfwyHPjOcor9k9y5gKb4CkXkN4zlsf1mPSmEZNeqCLktGNaDUTmuff
         fy479+R8dLkcNw5QmA3t7eiWPugrSi2uneh1RDXeoBwji1OzO26AyK8mA8oUckiRnr8B
         Raw8qZqxyup1mJiYOzzwHvtYkXjOT74KtTkHNlRm9G86jpc6D+B0D59u201SmzW9kGfF
         S9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791861920; x=1792466720;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8btU5rJ+Pel0WPP/jtsdEEDxh2u3x4YA62OOuosbpv4=;
        b=z6gqV3ggLlRUHMZuCnwzrs17bShtCTnegqz2oVt6P0HE8DO9zHNHAOQq8EBbsdmy24
         lhZqSW5CxJ9YgdrSpfac/r+umduUzVG8ekogfoxC9BRLbM2a+gAPkPbjs610+WDkoRZr
         qq0zwSAos0liNb/42gbaSeXRxiM/VkqXACn498Y8V/eLXN/51OUZ/zD6uEIwCiQLqwR8
         +tXyFCR4a8B4CfWmcWcDD91ioBJNlWhzMwWpt0e38n+p0orEkyEWwstq2LTh7mvb4o4M
         Mn/HCjliGYm0fcq2Xl4pGvpbi7RQG8ZI3Xslpp5WhYL9v4gKiCL3UPDtBDR2ku+y48Le
         h1BA==
X-Forwarded-Encrypted: i=1; AKwUvBxMf8SXmjMNVdsmKXA6WEKV+JSRek6BlsCJELOdYzkN8wXH48X1D84QLTNmZnWm6b+aPgo=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8R2A1Dza0SbrxryHb1QUrEQwnfO6xD2YClXql2QwGJsGi/PJl
	31mEA9wR2zGxxqS7QsQFd3xEwdIgT04C+v7qNkFV62ZZj+eboH4nYqkokIUfn+dUxHLDvnOHNrJ
	BEnO1z/SWRErtaBZv1dE0NIZ1SfPFUMA=
X-Gm-Gg: AYBFou2JJb0XO8eZy0o78G5YdWbyp2kF+SqkrH711kSEUvJFP5n5A2ovjTVOdQIOxXk
	ui8oU6g3URMYm9h3u7drN2XaT3LXkLlSeuwd5VziwrMqtXMFTVIslfrILdKuVosQiRPWr2O1Dfk
	vVVXlNtiDyIbVu3y/+vL9TjEs4mrqt/8TDNrO4KBMIHlFSXRGoEwlCmkXgAq4QEdKL9T3Gtf0mr
	Z1N9K/R+fqwYKkGnjLmIoly/RUFKd73pgUo9aWS4KgOW88EKyMp3YTOKg1oIE+AbBhkmehOckxW
	LgM57cHicPXxjQtmD9PqNOx/NVNEUaI67a170H2ULYIW2SPnOSL82iaJGlVlHSLPSA==
X-Received: by 2002:a05:620a:1981:b0:93c:c7ee:8087 with SMTP id
 af79cd13be357-93ebd262586mr2063648385a.41.1791861918719; Mon, 12 Oct 2026
 20:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-2-physicalmtea@gmail.com> <as1SWsJw2dSrPYcL@devvm29614.prn0.facebook.com>
In-Reply-To: <as1SWsJw2dSrPYcL@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Tue, 13 Oct 2026 11:24:42 +0800
X-Gm-Features: AclHuK8ArxSs8AN-w9MzUrVu9R026x9r6uOWM8JmPA66VFn2x0Xfdd31Fer7qUg
Message-ID: <CAJwVaMJsQs61+sCun6oJ7bW-Ob76AjdHVxLd+T1EVHvOR5e7Xw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/5] vsock/virtio: split socket lookup from
 locked RX processing
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Sat, Oct 10, 2026 at 10:22:43PM +0800, Jia Jia wrote:
> > Split virtio_transport_recv_pkt() so socket lookup is separate from the
> > receive state machine that runs under the socket lock.
> >
> > Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
> > Pass the source and destination addresses used for lookup to the locked
> > receive path so they are decoded only once.
> >
> > Pass the network namespace and decoded address tuple through a packet
> > context to the locked receive path.
> >
> > Preserve source validation and failure handling. Keep the lookup reference
> > separate from the skb owner reference so the locked receive path can manage
> > the two lifetimes independently.
> >
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  net/vmw_vsock/virtio_transport_common.c | 139 ++++++++++++++++--------
> >  1 file changed, 96 insertions(+), 43 deletions(-)
> >
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index f225f53..e3e75e5 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -1774,81 +1774,97 @@ static bool virtio_transport_valid_type(u16 type)
> >              (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
> >  }
> >
> > -/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> > - * lock.
> > - */
> > -void virtio_transport_recv_pkt(struct virtio_transport *t,
> > -                            struct sk_buff *skb, struct net *net)
> > +static void
> > +virtio_transport_recv_pkt_init_addrs(struct sk_buff *skb,
> > +                                  struct sockaddr_vm *src,
> > +                                  struct sockaddr_vm *dst)
>
> I'd prefer these calls stay inline, there is nothing complex enough here
> to justify abstracting IMHO.
>
> Could we move things around so that we don't have the arbitrary move of
> virtio_transport_recv_pkt()? It tends to create noise and makes it
> harder to focus on the more important parts of the patch.
>

Sure, I'll update this in the next version.

> >  {
> >       struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > -     struct sockaddr_vm src, dst;
> > -     struct vsock_sock *vsk;
> > -     struct sock *sk;
> > -     bool space_available;
> >
> > -     vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> > +     vsock_addr_init(src, le64_to_cpu(hdr->src_cid),
> >                       le32_to_cpu(hdr->src_port));
> > -     vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
> > +     vsock_addr_init(dst, le64_to_cpu(hdr->dst_cid),
> >                       le32_to_cpu(hdr->dst_port));
> > +}
> > +
> > +static void
> > +virtio_transport_trace_recv_pkt(struct sk_buff *skb,
> > +                             const struct sockaddr_vm *src,
> > +                             const struct sockaddr_vm *dst)
> > +{
> > +     struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> >
> > -     trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
> > -                                     dst.svm_cid, dst.svm_port,
> > +     trace_virtio_transport_recv_pkt(src->svm_cid, src->svm_port,
> > +                                     dst->svm_cid, dst->svm_port,
> >                                       le32_to_cpu(hdr->len),
> >                                       le16_to_cpu(hdr->type),
> >                                       le16_to_cpu(hdr->op),
> >                                       le32_to_cpu(hdr->flags),
> >                                       le32_to_cpu(hdr->buf_alloc),
> >                                       le32_to_cpu(hdr->fwd_cnt));
> > +}
>
> Any chance we can get rid of this wrapper and just call
> trace_virtio_transport_recv_pkt() directly? Even from multiple call
> sites I don't think this is a big simplification win.
>

Sure, I'll update this in the next version.

> >
> > -     if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
> > -             (void)virtio_transport_reset_no_sock(t, skb, net);
> > -             goto free_pkt;
> > -     }
> > +static struct sock *
> > +virtio_transport_recv_pkt_find_socket(struct sk_buff *skb,
> > +                                   struct sockaddr_vm *src,
> > +                                   struct sockaddr_vm *dst,
> > +                                   struct net *net)
> > +{
> > +     struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > +     struct sock *sk;
> >
> > -     /* The socket must be in connected or bound table
> > -      * otherwise send reset back
> > -      */
> > -     sk = vsock_find_connected_socket_net(&src, &dst, net);
> > -     if (!sk) {
> > -             sk = vsock_find_bound_socket_net(&dst, net);
> > -             if (!sk) {
> > -                     (void)virtio_transport_reset_no_sock(t, skb, net);
> > -                     goto free_pkt;
> > -             }
> > -     }
> > +     if (!virtio_transport_valid_type(le16_to_cpu(hdr->type)))
> > +             return NULL;
> > +
> > +     sk = vsock_find_connected_socket_net(src, dst, net);
> > +     if (!sk)
> > +             sk = vsock_find_bound_socket_net(dst, net);
> > +     if (!sk)
> > +             return NULL;
> >
> >       if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
> > -             (void)virtio_transport_reset_no_sock(t, skb, net);
> >               sock_put(sk);
> > -             goto free_pkt;
> > +             return NULL;
> >       }
> >
> > -     if (!skb_set_owner_sk_safe(skb, sk)) {
> > -             WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > -             goto free_pkt;
> > -     }
> > +     return sk;
> > +}
>
> Similarly here, the unrelated functions blending makes for a harder
> read. Maybe worth moving things around or trying a different diff
> algorithm?
>

Sure, I'll update this in the next version

> nit: maybe we could just call this virtio_transport_find_socket()? AFAIK
> the tx side doesn't need a socket lookup since we already have the
> socket there, so we can omit the disambiguation if it lends a nicer
> name.
>

Sure, I'll update this in the next version

> >
> > -     vsk = vsock_sk(sk);
> > +struct virtio_transport_rx_pkt_ctx {
> > +     struct net *net;
> > +     const struct sockaddr_vm *src;
> > +     const struct sockaddr_vm *dst;
> > +};
>
> Let's just pass these directly too...
>

Sure, I'll update this in the next version.

> >
> > -     lock_sock(sk);
> > +/*
> > + * The caller holds sk's socket lock and must free skb if this returns true.
> > + */
> > +static bool
> > +virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > +                              struct sk_buff *skb, struct sock *sk,
> > +                              const struct virtio_transport_rx_pkt_ctx *ctx)
> > +{
> > +     const struct sockaddr_vm *src = ctx->src;
> > +     const struct sockaddr_vm *dst = ctx->dst;
> > +     struct vsock_sock *vsk = vsock_sk(sk);
> > +     struct net *net = ctx->net;
> > +     bool space_available;
> >
> > -     /* Check if sk has been closed or assigned to another transport before
> > -      * lock_sock (note: listener sockets are not assigned to any transport)
> > +     /* Check after acquiring the socket lock. Listener sockets accept packets
> > +      * from any source and are not assigned to a transport.
>
> We can probably remove the first sentence since the function-level
> comment already declares we are holding the socket lock.
>

Sure, I'll update this in the next version.

> Best,
> Bobby
>
> >        */
> >       if (sock_flag(sk, SOCK_DONE) ||
> >           (sk->sk_state != TCP_LISTEN &&
> > -          !vsock_check_source(vsk, &t->transport, &src))) {
> > +          !vsock_check_source(vsk, &t->transport, src))) {
> >               (void)virtio_transport_reset_no_sock(t, skb, net);
> > -             release_sock(sk);
> > -             sock_put(sk);
> > -             goto free_pkt;
> > +             return true;
> >       }
> >
> >       space_available = virtio_transport_space_update(sk, skb);
> >
> >       /* Update CID in case it has changed after a transport reset event */
> >       if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> > -             vsk->local_addr.svm_cid = dst.svm_cid;
> > +             vsk->local_addr.svm_cid = dst->svm_cid;
> >
> >       if (space_available)
> >               sk->sk_write_space(sk);
> > @@ -1875,12 +1891,49 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> >               break;
> >       }
> >
> > +     return false;
> > +}
> > +
> > +/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
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
> > +     sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
> > +     if (!sk) {
> > +             (void)virtio_transport_reset_no_sock(t, skb, net);
> > +             goto free_pkt;
> > +     }
> > +
> > +     if (!skb_set_owner_sk_safe(skb, sk)) {
> > +             WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > +             goto free_pkt;
> > +     }
> > +
> > +     lock_sock(sk);
> > +     ctx = (struct virtio_transport_rx_pkt_ctx) {
> > +             .net = net,
> > +             .src = &src,
> > +             .dst = &dst,
> > +     }
> > +     free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> >       release_sock(sk);
> >
> >       /* Release refcnt obtained when we fetched this socket out of the
> >        * bound or connected list.
> >        */
> >       sock_put(sk);
> > +     if (free_pkt)
> > +             kfree_skb(skb);
> >       return;
> >
> >  free_pkt:
> > --
> > 2.34.1
> >
