Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793968110;
	b=5EEh9GUxJVtmVrXGCCNcmLJrsoa0n+zjKlmAC5OCDfNdusgy909Qqsuc+Gc3GCiClq0F
	 GzWsED8tDl4fZyy1pL4v1BP71g5EflYwpTydwOatIX6WKZKiTT7M/Qm5FnOgIW6RwhiE2
	 gbLbtUeaLSt0rVir1lXq6tgK4YwACSdPpzAmj9tdnXL80O2fGSzg1+dbHO/jWZXz4dCbk
	 YZV0xHrZpR/L1S4NdCRWlBTyluRRY+rGGEnZR6CE6wb9AjF7Frsyh5AqX2mQTBtkxw6gz
	 svcRYV5Gfqc/84OAmRHRyaWmS8wR+UW3s0v6V6KmyZ8DQU8iVCzMz8jqj67jzfWP4dQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=G+0ms3CCi0RJxuwsfHX0exDk9GT+MKyGLVXhxhpUOco=;
	b=L9Sz0dGVd2wT2c7QAzDsk2Xe+CHNvio7eWi2FQtLAyXoCPksjnmYoiOW+0L78xrbEbHL
	 cVvPdVu0y6xoaNoTl3l22RrGaTwZecRBXnkMOIOv1BpBPjPzJDJJlK4+i1U03deag2R1/
	 dzn9Eboqd21YOim2jZhXhkk2RPQDi0aMxHIfxHHqWHXG+lhg49XuDb9mTiBExDKCxnWGP
	 M0fLzTebxy8Gz2CzzxmSL2h3hHZVh7eijeI5lkbMAPx6xtvhSJ2IFxdiCZFFyk3xC/+P+
	 rL8Y4hAsf16jVaicJ4DUdZINIJWNHPfCg9kn94o3ITnT5mqHMmo5Di0zQAys4fJdcPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PwyxB0Lf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AA0606A32C
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 12:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0AA0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PwyxB0Lf
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91c6ce60697so8025606d6.3
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 04:28:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793968109; cv=none;
        d=google.com; s=arc-20260327;
        b=W6zAJA1FUK/PLPH5QIB1cd+B7WeBcJIgks+mdj5OhOJTAKIuRkhoqNl2mYO8d2Ihig
         Gb7Wo0VkpUy0rmAqFTvJohu0pF5A3+JUOkUy0tQuQZ5M01aOf7iWZwxwZjNSoURp8OM2
         Gt6eSftknbYWFD69zWupsmKcaQj8jQ8VP8rysjwWWGdJZvotxVUZj/gVet7pogbQePPU
         czrASmt4QS1XyqmGBLB5k9I9tJeDhsqHQ5iJTdFFJsrvOK7H3VtF7I5M4MKgI6w7a7Hn
         cJGGbeXJzBc+LleIOpzsE2uPrOn6g++GAyZKydE6n8C0ZBXUnNWp/4YGuW8gVSRUsaZa
         5etg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=G+0ms3CCi0RJxuwsfHX0exDk9GT+MKyGLVXhxhpUOco=;
        fh=z35RjYjkjTKY6hGx0Ed25cpDxtlvtUYpdKkNUpzORY0=;
        b=qc3NK6aGgv0j9XlyZo6yIvxxD5rWGgmAuUHE27f81rPhHqIpoTFmN62oJLQ7HzFvHd
         T/te+pEchzTrYY3ty1uopeYJeHJ75Q7tzHPcVls9DWFL35MHwibfhCYvRUKPU2blkTPj
         v8OMYySI8vcxx3m4tGQXf2NI3feBA3hbHJMfYwDJwh9SLOz8l+1u4v2+Rpx2ooQZ119T
         jsFLrIXbgs2SQ2DeylTXVRL9PlA/y5c/ZLjmSCpqBb2fYObF9nEdBY/Z5AdvOLnCNCih
         DZMj+BOXjmx3oP/1J3ZYDVDKf7lwON28zDoXKfuWZb/xLW59LpRI1ID1yu9tLnT97Dns
         qC/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793968109; x=1794572909; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G+0ms3CCi0RJxuwsfHX0exDk9GT+MKyGLVXhxhpUOco=;
        b=PwyxB0LfKyLWWR3EYehQ9OP4kJXptCar7Cs5UNfAr79HyLIFyrWFuzamm02y6kZx+S
         uwyIV4vYIE1ojIjybaKZ2MMIn/t7kUnPFacc3wRDHKJyHOoQiIzZD0zelW9bmjbGHQt0
         QX+j6z2mRN/PcHOKOzJmsejSWTUkIysZkAblYDTtFm9194FCFQ1NdNPqdy6E4Vgwhcyf
         +116Jej4dt5+SGL50RccRXZdRLTUFYKK4rRmnG7eY9jZDW9LIJLW9RapQHvq16EIgF6n
         LbGybDD6Y0WomB0trmY3Kqw5W49GrGsdDf4Vh32AIObMDoPx46he7qfMZhDxuIv+UFwZ
         zUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793968109; x=1794572909;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G+0ms3CCi0RJxuwsfHX0exDk9GT+MKyGLVXhxhpUOco=;
        b=TB9q7UZ7cWnYwEEr4K/QhPLt8qdm5asZXqAicAtU/HPEgF2uWvv09ar31lJ5ApJ5Qg
         ioiSS0pu76WtTvK35W/JMiGJaCAy5gIW6CPLwkrCgdjLw8JjIxjbzFlm5co+Z3K9iS69
         xyNVSf+42tYNYA+sarCmQOMjQP6GyERVKosUiMY85yK/I27eg7GPcQSXNzvI5jmEzq4+
         pLyPuIEbrvb6Xiwabodmx34nAKCPDS5CHHC6Qatp4iMg1JUcQXHVwBoUeyGSrt83raxZ
         GH51x9Ux9Ty7jt5OyehDT9NiYttu16ShMTC9cOE/50OE7/hxhgZpt5/I2F77QHOim2Hs
         QAXA==
X-Forwarded-Encrypted: i=1; AKwUvByjxCmXvuk0m8rFhGCANVPWL102QDnXEgJuHRctHUCsQ8/bGxm/bwNWXjEn/RrTTX1pMb4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GEhAQAKsrRaw5miov73ANnWOA5NnCCQvu8McxHOHJX6DAwBI1
	JncNCCu0npzJVjgWwuAF76y//E3Bs8GBsnhg4SWXcrIS1BCz/Zk+VBgJDdOxt5TKifVJ5OwMt+8
	w721wH0thDUq0AOaV0TOSWlUhEO+SHDU=
X-Gm-Gg: AYBFou3BXqd5I7AVqeTuyqJVvNBgW0aTGc22oSeVMvi8o/meZqGa7z7LLxjYPXiF3eD
	l0H66PAiGeb5/LKY2CAdgofp3eHDlUtpbDKF3S6thxt3QP5oT+AYpBWsi9mkQTg641kEPW7qRog
	0EVwithg5ummtAQaO22n8I9hsH6SYSBRo/263rtR6JOjxSROAHKFTrUI+em2FL7LcHa2dMXe+vx
	cah2tGVGVYN/5lg3RgiI42rlEPxruiT+Ji52i1Hc9OMLq6x+17STrZsrTqcLynVKdvNIN93M8qj
	+61IigD6N61RUNibzTLaHHRg9NF2FG8toHyzvWJBHFtMXz/89n9zvadSr0hN+3BAcw0aydvjwDV
	UQ78lPatmkgB5RMz8XI2JgyaVIlpuUN+gUe+wOjzmgI5ghUY3XDhLiOydm2VOVX7c8NMapEvtJK
	ZWGDgEn6Js8WH6RPYz
X-Received: by 2002:ac8:64ce:0:b0:536:702c:f8e3 with SMTP id
 d75a77b69052e-54e14970663mr29100121cf.41.1793968108023; Fri, 06 Nov 2026
 04:28:28 -0800 (PST)
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
 <20261103041134.33310-4-physicalmtea@gmail.com> <auxDWISLHB8Ln1x7@sgarzare-redhat>
In-Reply-To: <auxDWISLHB8Ln1x7@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Fri, 6 Nov 2026 20:27:51 +0800
X-Gm-Features: AclHuK9oc5v_bVnYihZo4p2y5_WglZkyJ9G05JxgpoCuT3GUMrql56DBRWnOvrU
Message-ID: <CAJwVaMJbzzK8Sj8DvLjiAyqS8TNgRQ3tjRpGcBNC+anQECg5yw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/5] vsock/virtio: amortize RX socket locking
 for stream packets
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, bobbyeshleman@gmail.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Tue, Nov 03, 2026 at 12:11:32PM +0800, Jia Jia wrote:
> >The virtio-vsock RX worker looks up a socket and takes its lock for every
> >packet. Retain the connected lookup reference and socket lock across a
> >bounded run of STREAM/RW packets for one established native socket.
> >
> >Reuse the locked socket while packets match the same flow. Finish the
> >batch on a malformed packet, flow change, non-RW traffic, or a change to
> >the socket state, transport, protocol, sockmap state, or receive buffer
> >limits. A connected lookup miss falls back to the existing receive path,
> >which can still find a bound socket.
> >
> >Limit an uninterrupted socket-lock ownership interval to 64 packets and
> >64 KiB of payload. The payload limit is one
> >VIRTIO_VSOCK_MAX_PKT_BUF_SIZE. Small or zero-length packets still incur
> >per-packet work, so an independent packet limit is needed. The 64-packet
> >limit uses VHOST_NET_BATCH as a reference; it is a policy choice rather
> >than a protocol limit.
> >
> >Beyond these limits, a larger batch would only further amortize socket
> >lookup and lock/unlock operations, while virtqueue work, validation,
> >tracing, skb ownership, credit update, and queueing remain per-packet. I
> >therefore expect diminishing returns while the uninterrupted socket-lock
> >interval continues to grow, but I have not measured larger limits yet.
> >
> >Only the guest virtio RX worker is changed. The benchmark exercises the
> >host-sender-to-guest-receiver direction, where this worker is on the
> >receive path. I have not measured the corresponding worker and socket-lock
> >overhead in vhost-vsock or vsock_loopback, and they use different worker
> >and locking models. Leave those paths unchanged pending separate policy
> >and validation. I plan to evaluate vhost-vsock separately as follow-up
> >work.
> >
> >Performance:
> >
> >These results cover P1-P3, before the notification changes in P4 and P5.
> >
> >Tested on a single-stream vsock connection (one Guest receiver thread on
> >CPU0, virtio-vsock IRQ on Guest CPU1, fresh QEMU Guest per state). The host
> >uses vhost-vsock.
> >
> >For throughput, vsock_perf runs on the host as the
> >sender, with a custom single-threaded Guest receiver pinned to Guest CPU0
> >using blocking recv(). The fixed-64K table uses a 64K buffer; the matched
> >table uses the sender's request size. The virtio-vsock IRQ/RX worker is
> >pinned to Guest CPU1. To normalize run times across payloads into a
> >bounded, deterministic window and avoid long runs being skewed by host
> >background noise or virtualization scheduling jitter, transfer sizes scale
> >proportionally with the request size (64B/64M, 256B/256M, etc.), capped at
> >2G for 4K-64K. The custom receiver keeps the recv() size and count
> >explicit; vsock_perf's receiver uses poll()+read().
> >
> >End-to-end RX throughput (fixed-64K receiver; Gbit/s):
> >
> >  payload  baseline RX  PATCH RX  throughput change (95% CI)
> >           (Gbit/s)      (Gbit/s)
> >  64B        0.1285       0.2462    +91.59% [+79.74%, +104.22%]
> >  256B       0.5909       0.9666    +63.59% [+61.03%, +66.19%]
> >  512B       1.1817       1.8350    +55.29% [+46.76%, +64.32%]
> >  1K         2.3252       3.3600    +44.50% [+38.93%, +50.30%]
> >  4K         3.8436       5.5661    +44.82% [+40.30%, +49.47%]
> >  8K         4.6609       5.4115    +16.10% [ +8.91%, +23.77%]
> >  16K        5.1196       5.6399    +10.16% [ +4.07%, +16.61%]
> >  64K        5.6095       5.7062     +1.72% [-3.19%, +6.89%]
> >
> >Fixed-syscall stress test (receiver recv() size = sender write size;
> >no perf; Gbit/s):
> >
> >  payload  baseline RX  PATCH RX  throughput change (95% CI)
> >  64B        0.1446       0.2540   +75.71% [+63.67%, +88.62%]
> >       recv() calls (baseline/PATCH): 1048577/1048577
> >  256B       0.4211       0.9061  +115.18% [+72.13%, +169.00%]
> >       recv() calls (baseline/PATCH): 1048577/1048577
> >  512B       0.7980       1.6112  +101.90% [+95.30%, +108.72%]
> >       recv() calls (baseline/PATCH): 1048577/1048577
> >  1K         1.4965       2.6986   +80.33% [+68.93%, +92.49%]
> >       recv() calls (baseline/PATCH): 1048577/1048577
> >  4K         2.9384       4.8590   +65.36% [+60.17%, +70.72%]
> >       recv() calls (baseline/PATCH): 539544/524982
> >  8K         3.8170       5.1887   +35.94% [+27.66%, +44.75%]
> >       recv() calls (baseline/PATCH): 274857/262991
> >  16K        4.6856       5.5996   +19.51% [+15.36%, +23.81%]
> >       recv() calls (baseline/PATCH): 147518/131351
> >  64K        5.5182       5.8800    +6.56% [-0.83%, +14.49%]
> >       recv() calls (baseline/PATCH): 48492/32910
> >
> >Guest CPU1 aggregate cycles per received byte
> >(fixed 64K receiver, with perf):
> >
> >  Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
> >  64B        66.728    61.220  -8.25% [-18.99%, +3.91%]
> >  256B       14.363    14.515  +1.06% [ -4.22%, +6.64%]
> >  512B        7.792     7.578  -2.74% [ -6.55%, +1.23%]
> >  1K          3.988     4.032  +1.09% [ -1.64%, +3.88%]
> >  4K          2.063     1.973  -4.38% [ -8.23%, -0.37%]
> >  8K          1.702     1.667  -2.06% [ -7.99%, +4.25%]
> >  16K         1.473     1.475  +0.17% [ -5.06%, +5.68%]
> >  64K         1.385     1.358  -1.96% [-10.61%, +7.53%]
> >
> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >---
> > include/linux/virtio_vsock.h            |  23 ++
> > net/vmw_vsock/virtio_transport.c        |   7 +-
> > net/vmw_vsock/virtio_transport_common.c | 303 ++++++++++++++++++++++--
> > 3 files changed, 318 insertions(+), 15 deletions(-)
> >
> >diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> >index f91704731057e..748633aa0cc81 100644
> >--- a/include/linux/virtio_vsock.h
> >+++ b/include/linux/virtio_vsock.h
> >@@ -282,6 +282,29 @@ void virtio_transport_destruct(struct vsock_sock *vsk);
> >
> > void virtio_transport_recv_pkt(struct virtio_transport *t,
> >                              struct sk_buff *skb, struct net *net);
> >+
> >+/*
> >+ * Initialize a batch to zero before use. A non-empty batch owns @sk's socket
> >+ * lock and the reference returned by vsock_find_connected_socket_net(). The
> >+ * caller retains both until it calls virtio_transport_rx_batch_finish(). An
> >+ * empty batch owns neither.
> >+ */
> >+struct virtio_transport_rx_batch {
> >+      struct sock *sk;
> >+      unsigned int pkts;
> >+      size_t bytes;
> >+};
> >+
> >+static inline bool
> >+virtio_transport_rx_batch_empty(const struct virtio_transport_rx_batch *batch)
> >+{
> >+      return !batch->sk;
> >+}
> >+
> >+void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> >+                                   struct sk_buff *skb, struct net *net,
> >+                                   struct virtio_transport_rx_batch *batch);
> >+void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch);
> > void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
> > u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
> > void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
> >diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> >index 4f9aa9c4c3aa5..9af85712bd387 100644
> >--- a/net/vmw_vsock/virtio_transport.c
> >+++ b/net/vmw_vsock/virtio_transport.c
> >@@ -631,6 +631,7 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
> >
> > static void virtio_transport_rx_work(struct work_struct *work)
> > {
> >       struct virtio_vsock *vsock =
> >               container_of(work, struct virtio_vsock, rx_work);
> >+      struct virtio_transport_rx_batch batch = {};
> >       struct virtqueue *vq;
> >@@ -666,6 +667,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> >                       /* Drop short/long packets */
> >                       if (unlikely(len < sizeof(*hdr) ||
> >                                    len > virtio_vsock_skb_len(skb))) {
> >+                              virtio_transport_rx_batch_finish(&batch);
> >                               kfree_skb(skb);
> >                               continue;
> >                       }
> >@@ -673,6 +675,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> >                       hdr = virtio_vsock_hdr(skb);
> >                       payload_len = le32_to_cpu(hdr->len);
> >                       if (unlikely(payload_len > len - sizeof(*hdr))) {
> >+                              virtio_transport_rx_batch_finish(&batch);
> >                               kfree_skb(skb);
> >                               continue;
> >                       }
> >@@ -685,11 +688,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
> >                       /* Force virtio-transport into global mode since it
> >                        * does not yet support local-mode namespacing.
> >                        */
> >-                      virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
> >+                      virtio_transport_recv_pkt_batch(&virtio_transport, skb,
> >+                                                      NULL, &batch);
> >               }
> >       } while (!virtqueue_enable_cb(vq));
> >
> > out:
> >+      virtio_transport_rx_batch_finish(&batch);
> >       if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> >               virtio_vsock_rx_fill(vsock);
> > out_nofill:
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >index 2a9cfed085515..f83e5b2edce35 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -33,6 +33,15 @@
> > #define MAX_COLLAPSE_LEN \
> >       SKB_MAX_ORDER(VIRTIO_VSOCK_SKB_HEADROOM, PAGE_ALLOC_COSTLY_ORDER)
> >
> >+/*
> >+ * Bound the interval that an RX worker owns a socket lock. One maximum packet
> >+ * buffer (64 KiB) bounds payload in one uninterrupted ownership interval.
> >+ * Small and zero-length packets need a packet limit to bound per-packet work;
> >+ * the 64-packet policy uses VHOST_NET_BATCH as a reference.
> >+ */
> >+#define VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS    64
> >+#define VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES   VIRTIO_VSOCK_MAX_PKT_BUF_SIZE
> >+
> > static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
> >                                              bool cancel_timeout);
> > static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs);
> >@@ -1793,13 +1802,94 @@ virtio_transport_find_socket(struct sockaddr_vm *src,
> >       return sk;
> > }
> >
> >+static void
> >+virtio_transport_trace_recv_pkt(const struct virtio_vsock_hdr *hdr,
> >+                              const struct sockaddr_vm *src,
> >+                              const struct sockaddr_vm *dst)
> >+{
> >+      trace_virtio_transport_recv_pkt(src->svm_cid, src->svm_port,
> >+                                      dst->svm_cid, dst->svm_port,
> >+                                      le32_to_cpu(hdr->len),
> >+                                      le16_to_cpu(hdr->type),
> >+                                      le16_to_cpu(hdr->op),
> >+                                      le32_to_cpu(hdr->flags),
> >+                                      le32_to_cpu(hdr->buf_alloc),
> >+                                      le32_to_cpu(hdr->fwd_cnt));
> >+}
> >+
> >+static bool
> >+virtio_transport_recv_pkt_set_owner(struct sk_buff *skb, struct sock *sk)
> >+{
> >+      if (skb_set_owner_sk_safe(skb, sk))
> >+              return true;
> >+
> >+      WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> >+      return false;
> >+}
> >+
> >+static bool
> >+virtio_transport_sock_has_psock(const struct sock *sk)
> >+{
> >+      return (uintptr_t)rcu_access_pointer(__sk_user_data(sk)) &
> >+             SK_USER_DATA_PSOCK;
> >+}
> >+
> >+/* The caller holds sk's socket lock. */
> >+static bool
> >+virtio_transport_rx_batch_can_continue(struct virtio_transport *t,
> >+                                     struct sock *sk, u32 len)
> >+{
> >+      struct virtio_vsock_sock *vvs;
> >+      struct vsock_sock *vsk;
> >+
> >+      vsk = vsock_sk(sk);
> >+      vvs = vsk->trans;
> >+
> >+      /*
> >+       * Keep a connected lookup reference only for the native, established
> >+       * STREAM path. Sockets outside ESTABLISHED can change table membership;
> >+       * a completed or reassigned socket must resume the per-packet path.
> >+       */
> >+      if (sk->sk_state != TCP_ESTABLISHED ||
> >+          sk->sk_type != SOCK_STREAM ||
> >+          sock_flag(sk, SOCK_DONE) ||
> >+          vsk->transport != &t->transport || !vvs)
> >+              return false;
> >+
> >+      /*
> >+       * Do not admit a packet that would hit an existing RX limit while the
> >+       * worker owns the socket lock. The caller holds that lock, so no reader can
> >+       * dequeue until the batch is released.
> >+       */
> >+      return (u64)vvs->buf_used + len <= vvs->buf_alloc &&
> >+             !virtio_transport_rx_buf_full(vvs);
>

Hi Stefano,

> I don't understand this. We recently introduce the collapse, so when we
> will call virtio_transport_recv_enqueue(), all the queue will be
> collapsed, including packets in the batch.
>
> Or am I missing something?
>

Yes, collapse operates on the same receive queue, which also contains
skbs queued earlier in the current batch.

The rx_buf_full() check is not intended to bypass collapse. It prevents
the batch from retaining the socket lock while processing a packet when
there is no metadata room for another skb. Collapse is best effort:
some skbs cannot be merged, and allocation of a replacement skb can
fail. If the packet remained in the batch and collapse did not make
enough room, virtio_transport_inc_rx_pkt() would fail and
virtio_transport_recv_connected() would reset the socket with ENOBUFS
while a waiting reader was still unable to drain the queue.

When the check makes can_continue() return false before the current
packet has been handled, the caller releases the socket lock and passes
the packet to virtio_transport_recv_pkt(). This gives a waiting reader a
chance to make progress. If the queue is still at the metadata limit,
the normal enqueue path attempts collapse. If that still cannot make
enough room, the existing ENOBUFS reset occurs.

Thanks,
Jia

> Thanks,
> Stefano
>
