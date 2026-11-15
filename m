Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794705398;
	b=CtfFUwgWVO7jl/b30WBKTHvzi0fdUGcfEDXcqVXYOvYHUGw6PFylo7lE65ezllsquOjO
	 MjK5LXRHWLgT3YY81S6T0Bu7PYvxl8Tmev00lJzmf4hY55DEJImpbpa3e2G6mMwQN3Hmw
	 a4y7Fmix3d5Z5zPbksh6EjvlMW7voi3V1lrIUYcgEKFNXYba9gYtiyzBgYSOOUfLnhWGB
	 KeBef6orxlpaYLxcFefpGtk79il7Ub1Oto6CV+FjB7DGQ5BGQwjtPF85oWo0y+mqiqnWj
	 J8pB+E2X04jh0AFRTCl6ZteKb8hloZ3PIzVIP5EBXQ6SdtJdCf02aHKZ+VIMRJmBTqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794705398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=F8dpUgzOoxPx+Jh3a8nIBQMmsbWct5uSooKKOFeDY9U=;
	b=XLL5zARxRHRWCnur8X+F9vlrdwkt6UkT8dUtxlH6JFi7TwyIwfURlpSPooWv6qe8z4by
	 V/CrYAr3QBIm8aCRWl5F/vEsqW7XeAq1PIlb/x3EvPyoTsrKFAzlI8nybnmRA/icsbtrp
	 jZYY/XVvKNCQT7UQv6uwtXxuglboCH2ZPtHTzZbpew2tjjvCGIMmvjpx0Om7XZuNGAUqg
	 F0A+rnq9nxDQBp/mPSzWAL47cPhixzWObFaxtBMoyI8pVrmjn1Zm9VZLqABvXR+hELs6S
	 sUfTPzyOt4PGWNGey39vWbnuXw+TST6nRo2LJGQBRBnvhhrsgl4dn16lEX5BdqvdcBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JQznWoGM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EC6606A329
	for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 01:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2EC6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JQznWoGM
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-94961b68685so104643285a.3
        for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 17:16:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794705397; cv=none;
        d=google.com; s=arc-20260327;
        b=IZtImhrFz882QKCDCOFAwE5Qjbyxw4Z3ScTIAgGfjRk3PnzsUqVJ7g1kfl6ztqxW7g
         8fJQjHXuJ+BOswL1UflsydrEeZ/jzdxlx+TcixG4DkMmV2E2l1Xh+1CgK9z/eWFJ+ElD
         W6Oxc1DQllBHhpubds9OnmMk3rh0Qjc/n9X3bMRg6kvQtUJ7LYNbJhbx4mNujTzl65FX
         tONxLISpMnKwZIAnklNcJyZpKYSbbZ9eRDJHfC1s08o3mkKVB5kqkgLCbqx3hCOpdZgv
         4loh5Jzrk8+L8yXlrxkcjFVlV2XsqRqr7O0jJ169eG+mmQ5gflMJY4qdKiotziHLSadp
         y5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=F8dpUgzOoxPx+Jh3a8nIBQMmsbWct5uSooKKOFeDY9U=;
        fh=cBjcmFkgefdC44aKOfOr8Dn+kJs7vXYITVHeJ2SvR4s=;
        b=qEHxhqJzzExUoxUx6h2ywQeV6Ur/hdtjGJojPynTEFUz1g2+WYWC5he2RvdHjn8v9c
         FEU2Ghrm94qHlVDYuHIXmW6N9drtWjlRx0KWlU9FhHZHar4HBSkvSmdvzgOAJSo9QuMA
         r1pxQaL5YvmqacP7bpYGrQ3qXzi8k38ZzL6O5hitKS0jAo7CPA8/o75hhe0E/vng2LSP
         pahYwrrzqQUfdG2aOTisx+D/PYtMMY7+tcxTqN1/mhlhn1pyMveBex40Pnx2FHuLdb74
         l3mbnysDeVN4CKZYAn2tlfAQa2dVGBmKeQoe1U4l/EyFTTq77sxwjd70kipQkl7SS16h
         Rj2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794705397; x=1795310197; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F8dpUgzOoxPx+Jh3a8nIBQMmsbWct5uSooKKOFeDY9U=;
        b=JQznWoGMMEvrXiC5W/x5Co6h5tvsVl7HknKCyg50kuuVMWqNOT6wFRtq/r3URx6fR7
         ZWomhYnJdg8WAb1J6zVX7mbftIrAXLv21D0+y5l2IyGvS63uHEs5nkmsisg6183Df1ev
         vPt9VvVUG+4tLMuHvo7sNk6RWDWPmidtc3ylEG0NcPgwsrENxnlF9R3QyntH4yxdW0DY
         MvXSLG2i/F64cL19/I60RXqVP6M85jvxzCwrHvfoogBhThjPLHfBTnJM5eE8CnPclH6H
         //rTTrv9Qkcrn69s9RYeQrVaG+4/AHb/wc5haby/HFg4IoIyO8kdyS29tFwau37xuN/a
         p3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794705397; x=1795310197;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F8dpUgzOoxPx+Jh3a8nIBQMmsbWct5uSooKKOFeDY9U=;
        b=I8R4x55SFXo9TRU+zsGgE+jpVIV7Cm1CPBc/tgXNXneB6IB5BWMfqVR9Zb4gIVcwq2
         NtKUvCB0Cthx6ekdckvBuAkZYcWQOjJvuhjbIVGtGAt33Cw+8bcXT/3sbVR1xVdIHs6d
         gLs3mlyGE2dUtnLKAQQDi5iLiZSi0Sd5mdYBhNe1befQN+GsapHQ1FWDdgq0y5xUDlKx
         nfbuUdw/J4krEwlgoVGO76vKj8S13XthZAQCmCouF4dzZ4eV9hTfVNsmurenyl4quuWB
         fyVBC1VDoSZL8R+LQEde/AEGKJ+LAYUvRmZ4tkn56BPbP/S1E2xFaIPH+Hd/jCp3dPRa
         X6bQ==
X-Forwarded-Encrypted: i=1; AL+hErGl3SIb3hdxINvRa7oYEEmWNyXUvsMO5/r0L8qrl8r688ueE0r0sUezydtO3mTEGy2MhOg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8EXGaRjKWNpVJ/Ohn1ggv21aoHQBdpXWIWWTnl1lnmRSeYY+DW
	oJtdOnEU/1JbCUU7ziPntYs2omfYtgkvkg7cSC3ixIgfIZtAsQV51qD1MGuUNRasZ+FAAxJMcMt
	8/2YMEg9TeKaS3PC2mfI8Kp5qwDgQ9Es=
X-Gm-Gg: AYBFou1qEwiB3x5/zJc8jxCf5eTsuRTBQmD3tCOLafpewrfgF+0YT1G1hpsxO2/U358
	udGj3djKcZRG7/SiD7IMEzNeI6AHZ0vcwXbNlSFs+r6ts9dr39zPfAaNivG+2QE2F24SFBWM7BP
	JVoFyvRsfItTvI7eNJiSCGhbiEiLxXWkRDYilrZD5m2SLYhpMxWdNdlHxMRp16UGRlnsGTr9Dyb
	2eCdQptt8MQQbojPK/kUBWmZDNK2P3uA0G6gJP3jIKskW3Bu64+3veU1JFstkhk8Ne3ZPsf7Gee
	8dJ0UFi3Fe3g4ZTAzSY4EkkcP/kWG4jghii/8E3ztG7P+Y7kKfk5AjB+3qff/B3U5C1WFmTFt01
	G1HLUY5wGnAfyj/VaYtJwwjAnZgrrznEqKPWrfoT/45hldh5APqqyi4AWAdf3Sw8RREJjix8=
X-Received: by 2002:a05:620a:3194:b0:93f:1e3c:4a31 with SMTP id
 af79cd13be357-9494bc489cemr1205984085a.61.1794705396536; Sat, 14 Nov 2026
 17:16:36 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103041134.33310-1-physicalmtea@gmail.com>
 <20261103041134.33310-5-physicalmtea@gmail.com> <auxHe77Kv3tS4hjJ@sgarzare-redhat>
 <CAJwVaMK6UpxOmCbuzGK15h+DhN5H6cj6cy-=gCHtSxoVbLfzwA@mail.gmail.com> <avX1+7zxl9OWGUGI@devvm29614.prn0.facebook.com>
In-Reply-To: <avX1+7zxl9OWGUGI@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Sun, 15 Nov 2026 09:15:58 +0800
X-Gm-Features: AclHuK-T0MEDdJ39kG7QgYlQtmmMpMQfQ5G4jecRDwhf-cJbDIFNw63bcWzZktY
Message-ID: <CAJwVaMK8_HxMjCVQwmwet+sphKHSM-L0eCogdzu1tZfLqCukSA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 4/5] vsock/virtio: coalesce native RX
 write-space notifications
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org, stefanha@redhat.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Fri, Nov 06, 2026 at 08:49:17PM +0800, Jia Jia wrote:
> > >
> > > On Tue, Nov 03, 2026 at 12:11:33PM +0800, Jia Jia wrote:
> > > >Each received packet can update peer credit and call sk_write_space(). A
> > > >writer cannot consume that credit while the virtio RX worker retains the
> > > >socket lock, so repeated native write-space notifications in one RX batch
> > > >are unnecessary.
> > > >
> > > >This patch coalesces write-space notifications on the native AF_VSOCK path;
> > > >data-ready remains per-packet here.
> > > >
> > > >The batching patch establishes batch ownership before its first packet.
> > > >This lets this patch record a pending notification for that packet and
> > > >flush it even if the packet immediately ends the batch. Deliver it while
> > > >holding the socket lock to preserve the callback context of the existing
> > > >receive path. A following patch changes that timing together with
> > > >data-ready handling.
> > >
> > > Can you report performance data related to this patch also here?
> > >
> > > IIUC this is not giving a lot of advantage, so my question is if this
> > > more complexity really add a value for us.
> > >
> >
> > Sure. The performance tests currently cover patches 4 and 5 together,
> > so I will include those results here.
> >
> > They do not add another broad throughput improvement. I kept the
> > combined notification change because of the cycles/byte results.
> >
> > With P1-P3 only, against baseline:
> >
> >   Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
> >   64B        66.728    61.220  -8.25% [-18.99%, +3.91%]
> >   256B       14.363    14.515  +1.06% [ -4.22%, +6.64%]
> >   512B        7.792     7.578  -2.74% [ -6.55%, +1.23%]
> >   1K          3.988     4.032  +1.09% [ -1.64%, +3.88%]
> >   4K          2.063     1.973  -4.38% [ -8.23%, -0.37%]
> >   8K          1.702     1.667  -2.06% [ -7.99%, +4.25%]
> >   16K         1.473     1.475  +0.17% [ -5.06%, +5.68%]
> >   64K         1.385     1.358  -1.96% [-10.61%, +7.53%]
> >
> > Only the 4K interval excluded zero. With the full series, against
> > baseline:
> >
> >   Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
> >   64B        65.282    57.843  -11.40% [-13.77%, -8.95%]
> >   256B       14.710    13.813   -6.10% [ -7.89%, -4.28%]
> >   512B        7.709     7.188   -6.75% [ -8.79%, -4.66%]
> >   1K          4.075     3.862   -5.23% [ -6.80%, -3.63%]
> >   4K          2.034     1.887   -7.21% [ -8.67%, -5.72%]
> >   8K          1.664     1.568   -5.78% [ -7.83%, -3.69%]
> >   16K         1.450     1.385   -4.48% [ -6.08%, -2.86%]
> >   64K         1.338     1.317   -1.51% [ -3.21%, +0.22%]
> >
> > From 64B through 16K those intervals stay below zero. 64B through 1K
> > did not show that in the P1-P3 run.
> >
> > This is also why I spent the time making this work with sockmap.
> >
> > The value I see is lower RX CPU cost, not another large throughput
> > gain. I am still unsure the extra code is worth it, and I would like
> > your opinion.
> >
> > Thanks,
> > Jia
> >
> > > >
> > > >Capture the native write-space callback before socket publication and
> > > >access it through AF_VSOCK helpers. Sockmap can change the protocol,
> > > >write-space callback, and psock marker without the socket lock. Serialize
> > > >each batch eligibility check with sk_callback_lock; if a packet boundary
> > > >observes a replacement, finish the batch and use the regular per-packet
> > > >path.
> > > >
> > > >Packets admitted on the native path use the saved native callback at batch
> > > >finish. Reloading a current sockmap callback would not synchronize its
> > > >invocation with teardown; a wrapper seen before teardown need not forward
> > > >the native wakeup after its psock is gone.
> > >
> > > I really don't understand the goal of this patch, and why we need to
> > > store the "native" sk_write_space.
> > >
> >
> > Actually, I kept this as a separate patch so the two notification changes
> > could be tested separately. This patch provides a complete intermediate
> > state: it coalesces native sk_write_space() notifications while keeping the
> > callback invocation under the socket lock. Patch 5 then coalesces
> > sk_data_ready() and moves both deferred callbacks after release_sock().
> >
> > The coalescing is limited to packets for which can_receive() sees
> > sk_write_space still set to the native callback. That callback wakes waiters.
> > The sockmap wrapper can also schedule psock work before forwarding
> > the saved callback, so I do not coalesce it.
> >
> > Batch finish also needs the saved pointer if the callback changes before
> > the batch ends. If another packet arrives, can_receive() detects the
> > replacement
> > and its caller finishes the batch. A write-space notification already
> > recorded for
> > the batch still uses the native callback.
> >
> > Reloading sk->sk_write_space at finish could capture the sockmap wrapper just
> > before teardown. If teardown removes the psock before the callback is invoked,
> > the wrapper no longer forwards the native wakeup.
>
> I'm not sure I understand the bug avoided by saving sk_write_space.
>
> If it changes mid-batch to the psock callback, the work that gets
> scheduled by sockmap will eventually acquire the socket lock via
> sock_sendmsg(), so the present batch will become owned in whole by the
> new socket anyway.
>
> I think that is perfectly acceptable semantics (when you redirect with
> sockmap, any current or later batch will be owned by the new sender). I
> don't think we need pkt redirection to be exactly in sync with
> installing the socket into sockmap at the exact pkt boundary if at least
> the batch boundary is in sync. The batch would just be "eventually
> consistent" with the new sockmap state.
>
> WDYT?
>
> I understand the sk_data_ready is a different matter because of the
> per-skb ->read_skb callback.
>
> My suggestion, if it works, would be to just do one sk_write_space call
> per batch, whichever cb it happens to be when the batch processing is
> done.
>

Thanks for the suggestion. I'll look into it.

The pointer is there because sk_psock_write_space() forwards its saved
callback only when it still finds a psock. With no psock it returns, and the
writer is not woken. sk_psock_drop() restores sk_write_space and clears
the psock under the write side of sk_callback_lock, without the socket lock.
If finish loads the current callback and calls it outside that lock, RX can load
the wrapper, drop can clear the psock, and the wrapper then finds nothing
to forward.

What I can see so far is that, without the saved pointer, that call would
need to run under read_lock_bh(&sk->sk_callback_lock). drop takes the
write side, so it cannot enter between the load and the call. The saved
pointer would then have nothing left to do. I'll check that.

Thanks

> >
> > > >
> > > >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > > >---
> > > > include/linux/virtio_vsock.h            |  4 +-
> > > > include/net/af_vsock.h                  |  7 +++
> > > > net/vmw_vsock/af_vsock.c                | 16 +++++
> > > > net/vmw_vsock/virtio_transport_common.c | 78 +++++++++++++++++--------
> > > > 4 files changed, 81 insertions(+), 24 deletions(-)
> > > >
> > > >diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > > >index 748633aa0cc81..bf28e8e32e280 100644
> > > >--- a/include/linux/virtio_vsock.h
> > > >+++ b/include/linux/virtio_vsock.h
> > > >@@ -287,12 +287,14 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> > > >  * Initialize a batch to zero before use. A non-empty batch owns @sk's socket
> > > >  * lock and the reference returned by vsock_find_connected_socket_net(). The
> > > >  * caller retains both until it calls virtio_transport_rx_batch_finish(). An
> > > >- * empty batch owns neither.
> > > >+ * empty batch owns neither. A pending native write-space notification belongs
> > > >+ * to the lock holder and is delivered by virtio_transport_rx_batch_finish().
> > > >  */
> > > > struct virtio_transport_rx_batch {
> > > >       struct sock *sk;
> > > >       unsigned int pkts;
> > > >       size_t bytes;
> > > >+      bool write_space_pending;
> > > > };
> > > >
> > > > static inline bool
> > > >diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> > > >index 5549298c1ec6b..b76ab565ea58b 100644
> > > >--- a/include/net/af_vsock.h
> > > >+++ b/include/net/af_vsock.h
> > > >@@ -63,6 +63,11 @@ struct vsock_sock {
> > > >       u32 peer_shutdown;
> > > >       bool sent_request;
> > > >       bool ignore_connecting_rst;
> > > >+      /*
> > > >+       * Captured before the socket is published. This identifies AF_VSOCK's
> > > >+       * native write-space callback after a consumer has replaced it.
> > > >+       */
> > > >+      void (*native_write_space)(struct sock *sk);
> > > >
> > > >       /* Protected by lock_sock(sk) */
> > > >       u64 buffer_size;
> > > >@@ -78,6 +83,8 @@ s64 vsock_stream_has_data(struct vsock_sock *vsk);
> > > > s64 vsock_stream_has_space(struct vsock_sock *vsk);
> > > > struct sock *vsock_create_connected(struct sock *parent);
> > > > void vsock_data_ready(struct sock *sk);
> > > >+bool vsock_write_space_is_native(const struct sock *sk);
> > > >+void vsock_call_native_write_space(struct sock *sk);
> > > >
> > > > /**** TRANSPORT ****/
> > > >
> > > >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > > >index 44cee74519555..e39567990539f 100644
> > > >--- a/net/vmw_vsock/af_vsock.c
> > > >+++ b/net/vmw_vsock/af_vsock.c
> > > >@@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
> > > >               sk->sk_type = type;
> > > >
> > > >       vsk = vsock_sk(sk);
> > > >+      vsk->native_write_space = sk->sk_write_space;
> > > >       vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
> > > >       vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
> > > >
> > > >@@ -1122,6 +1123,21 @@ void vsock_data_ready(struct sock *sk)
> > > > }
> > > > EXPORT_SYMBOL_GPL(vsock_data_ready);
> > > >
> > > >+bool vsock_write_space_is_native(const struct sock *sk)
> > > >+{
> > > >+      const struct vsock_sock *vsk = vsock_sk(sk);
> > > >+
> > > >+      return READ_ONCE(sk->sk_write_space) ==
> > > >+             READ_ONCE(vsk->native_write_space);
> > > >+}
> > > >+EXPORT_SYMBOL_GPL(vsock_write_space_is_native);
> > > >+
> > > >+void vsock_call_native_write_space(struct sock *sk)
> > > >+{
> > > >+      vsock_sk(sk)->native_write_space(sk);
> > > >+}
> > > >+EXPORT_SYMBOL_GPL(vsock_call_native_write_space);
> > > >+
> > > > /* Dummy callback required by sockmap.
> > > >  * See unconditional call of saved_close() in sock_map_close().
> > > >  */
> > > >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > >index f83e5b2edce35..af26344678e41 100644
> > > >--- a/net/vmw_vsock/virtio_transport_common.c
> > > >+++ b/net/vmw_vsock/virtio_transport_common.c
> > > >@@ -1865,31 +1865,55 @@ virtio_transport_rx_batch_can_continue(struct virtio_transport *t,
> > > >              !virtio_transport_rx_buf_full(vvs);
> > > > }
> > > >
> > > >-/* The caller holds sk's socket lock. */
> > > >+/* The caller holds sk's socket and callback locks. */
> > > > static bool
> > > >-virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
> > > >-                                    struct sock *sk, u32 len)
> > > >+__virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
> > > >+                                      struct sock *sk, u32 len)
> > > > {
> > > >       if (!virtio_transport_rx_batch_can_continue(t, sk, len))
> > > >               return false;
> > > >
> > > >       /*
> > > >-       * Sockmap can replace sk_prot and publish a psock without the socket lock.
> > > >-       * Check both at each packet boundary; a boundary that sees a replacement
> > > >-       * returns to the existing per-packet path.
> > > >+       * Sockmap can replace sk_prot or sk_write_space, and publish a psock,
> > > >+       * without the socket lock. Coalescing is safe only for the native
> > > >+       * write-space callback, so a boundary that sees a replacement returns to
> > > >+       * the existing per-packet path.
> > > >        */
> > > >       return READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
> > > >+             vsock_write_space_is_native(sk) &&
> > >
> > > I'm confused, why for sk_prot we are doing the check here, while for
> > > sk_write_space we need a new API?
> > >
> >
> > sk_prot can be compared with sk_prot_creator. sk_write_space
> > has no field like that, and sock_def_write_space() is static.
> > I save the callback in __vsock_create(), after the socket is
> > initialized and before it is published. The helpers compare
> > against that pointer and call it.
> >
> > > >              !virtio_transport_sock_has_psock(sk);
> > > > }
> > > >
> > > >+/*
> > > >+ * Sockmap teardown restores the native protocol and write-space callback
> > > >+ * under sk_callback_lock. Serialize each packet admission check with those
> > > >+ * updates.
> > > >+ */
> > > >+static bool
> > > >+virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
> > > >+                                    struct sock *sk, u32 len)
> > > >+{
> > > >+      bool batchable;
> > > >+
> > > >+      read_lock_bh(&sk->sk_callback_lock);
> > > >+      batchable = __virtio_transport_rx_batch_can_receive(t, sk, len);
> > > >+      read_unlock_bh(&sk->sk_callback_lock);
> > > >+
> > > >+      return batchable;
> > > >+}
> > > >+
> > > > /*
> > > >  * The caller holds sk's socket lock. If @batchable is non-NULL, update it
> > > >  * after processing @skb to say whether a native STREAM/RW batch can continue.
> > > >+ * When @batch is non-NULL, record a native write-space notification for batch
> > > >+ * finish. A writer cannot consume the updated credit until this lock is
> > > >+ * released.
> > > >  */
> > > > static void
> > > > virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > > >                                struct sk_buff *skb, struct sock *sk,
> > > >-                               struct net *net, bool *batchable)
> > > >+                               struct net *net, bool *batchable,
> > > >+                               struct virtio_transport_rx_batch *batch)
> > >
> > > Do we really need bot batchable and batch ?
> > >
> >
> > Agreed, we don't. I'll clean that up in the next version. Thanks
> >
> > > > {
> > > >       struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > > >       struct vsock_sock *vsk = vsock_sk(sk);
> > > >@@ -1921,8 +1945,12 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > > >       if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> > > >               vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
> > > >
> > > >-      if (space_available)
> > > >-              sk->sk_write_space(sk);
> > > >+      if (space_available) {
> > > >+              if (batch)
> > > >+                      batch->write_space_pending = true;
> > > >+              else
> > > >+                      sk->sk_write_space(sk);
> > > >+      }
> > > >
> > > >       switch (sk->sk_state) {
> > > >       case TCP_LISTEN:
> > > >@@ -1947,7 +1975,7 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > > >       }
> > > >
> > > >       if (batchable)
> > > >-              *batchable = virtio_transport_rx_batch_can_receive(t, sk, 0);
> > > >+              *batchable = virtio_transport_rx_batch_can_continue(t, sk, 0);
> > >
> > > Why this change?
> > >
> >
> > This runs after the packet has been handled. can_receive() decides
> > whether a packet may be processed in the batch, so I do not call it
> > again here. can_continue() checks whether the socket state, type,
> > transport, and RX limits still allow the batch to remain active. If it
> > returns false, the caller releases the socket lock and drops the
> > connected reference.
> >
> > A change to sk_prot, sk_write_space, or the psock is seen by
> > can_receive() before the next packet is processed, and that packet takes
> > the regular path.
>
> I think squashing would avoid the churn.
>

Sure, understood. Thanks.

> >
> > > > }
> > > >
> > > > /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> > > >@@ -1991,7 +2019,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> > > >               goto free_pkt;
> > > >
> > > >       lock_sock(sk);
> > > >-      virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL);
> > > >+      virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL, NULL);
> > > >
> > > >       release_sock(sk);
> > > >
> > > >@@ -2008,20 +2036,31 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
> > > >
> > > > /*
> > > >  * Release an active RX batch. A non-empty batch holds the socket lock and the
> > > >- * reference returned by vsock_find_connected_socket_net(). An empty batch
> > > >- * holds neither.
> > > >+ * reference returned by vsock_find_connected_socket_net(). Deliver any
> > > >+ * deferred native write-space notification while holding the lock, preserving
> > > >+ * the callback context of the regular receive path. An empty batch holds
> > > >+ * neither.
> > > >  */
> > > > void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
> > > > {
> > > >+      bool write_space_pending = batch->write_space_pending;
> > > >       struct sock *sk = batch->sk;
> > > >
> > > >       batch->sk = NULL;
> > > >       batch->pkts = 0;
> > > >       batch->bytes = 0;
> > > >+      batch->write_space_pending = false;
> > > >
> > > >       if (!sk)
> > > >               return;
> > > >
> > > >+      /*
> > > >+       * The packet was admitted with the native callback. Do not reload a current
> > > >+       * callback here: sockmap can replace or remove its wrapper independently.
> > > >+       */
> > > >+      if (write_space_pending)
> > > >+              vsock_call_native_write_space(sk);
> > > >+
> > > >       release_sock(sk);
> > > >       sock_put(sk);
> > > > }
> > > >@@ -2080,7 +2119,8 @@ virtio_transport_rx_batch_process(struct virtio_transport *t,
> > > >               return;
> > > >       }
> > > >
> > > >-      virtio_transport_recv_pkt_locked(t, skb, batch->sk, net, &batchable);
> > > >+      virtio_transport_recv_pkt_locked(t, skb, batch->sk, net, &batchable,
> > > >+                                       batch);
> > > >       if (!batchable) {
> > > >               virtio_transport_rx_batch_finish(batch);
> > > >               return;
> > > >@@ -2158,16 +2198,8 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> > > >       }
> > > >
> > > >       lock_sock(sk);
> > > >-      /*
> > > >-       * Serialize initial admission with sockmap's callback updates. Later
> > > >-       * packet boundaries recheck native state and end a batch when they
> > > >-       * observe a replacement.
> > > >-       */
> > > >-      read_lock_bh(&sk->sk_callback_lock);
> > > >       batchable = virtio_transport_rx_batch_can_receive(t, sk, len);
> > > >-      read_unlock_bh(&sk->sk_callback_lock);
> > >
> > > Can we avoid this change and do this in the previous patch?
> > >
> > > Please avoid as much as you can change code introduced in the same series.
> > >
> >
> > Sure, understood.
> >
> > > >       if (!batchable) {
> > > >-              /* State or receive-buffer failures keep the regular lookup path. */
> > >
> > > Why removing this comment just added by previous patch?
> > >
> >
> > This patch adds a replaced sk_write_space as another reason for
> > can_receive() to return false, and that case does not take the regular
> > lookup path. I removed the old comment because it no longer
> > described the distinction completely, but I forgot to add the replacement.
> > Sorry about that, and thanks for catching it.
> >
> > > >               if (!virtio_transport_rx_batch_can_continue(t, sk, len)) {
> > > >                       release_sock(sk);
> > > >                       sock_put(sk);
> > > >@@ -2176,7 +2208,7 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> > > >
> > > >               virtio_transport_trace_recv_pkt(hdr, &src, &dst);
> > > >               if (virtio_transport_recv_pkt_set_owner(skb, sk))
> > > >-                      virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL);
> > > >+                      virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL, NULL);
> > > >               else
> > > >                       kfree_skb(skb);
> > > >
> > > >--
> > > >2.53.0
> > > >
> > >
>
>
> Thanks,
> Bobby
