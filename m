Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794557427;
	b=a4WOKg7QxOIIapsiOIZZRflglzJThzpK1mzsQ6Vw3jakrAhYs6IJUu5zgLfrWLgr6dDw
	 ixnNkzojhryOh5uCCOHCmKjw7k04PG7if3Kdu9kLMu0ICRencjUo93YqExsue77zUiMBT
	 UyYfXEZOrnhTCMaPW0BrUA/V7ABnPg5ommjvfLZQ8o54N8ZsKaykz+orHSk9mymtH/frk
	 WP5ey9SIqNNjmnMY8U8bIp5/4v1eOcy6YkC/Aj17OC6I7yG5Yp8yTI8c/v1W1uwgiVoPy
	 0ysmooYrg10x0mxQ8Ri8lo6zKkqnPqT2YVNHXCaM+a3xPUXNAVCRojaIpunZejLksDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794557427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=NU5rjEqsFLdnO9gwXx9gvchvka3TzTBe32wItugjiAY=;
	b=Ms6t5tSY+TPLaGF7UGnIy8xsJbrrjNUvK+5Zl3XY6rqTHRL+3AkYPZdh7xYQDzpT9Iks
	 yuYirbA8957ufRbBokV6C2QcyIl+XcqfAykQhYcqhSw+ObQEz+9GF6Xj6Bah3pux3Pouy
	 fq/wZtklANLHKduJf+imkol+Gg89AwIyMepLvU5iBVWbjLhwxbo2bQATqT/Si3gYgTBG8
	 lnwvn5x1X76dwhg997W4HrAddlaTsXlrTVZW83utK/kTV6JWaM2zOYOLzmKL57cDX5yeu
	 4bbzk0XRfoL8pn8oOe5EDDStKC3Ic2utXOxg09ggV4tevyRFZPvqR7T3ONrupeyPm0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Smn5E4hm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80FF606A321
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 08:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C80FF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Smn5E4hm
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53669f7b518so12534951cf.2
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 00:10:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794557426; cv=none;
        d=google.com; s=arc-20260327;
        b=HHvJwULDCJG7BZV44+q3u9TwoGfvdbKl92PpAdNfaXUxjh4MIQVswwUmzVcCMinPRR
         RlC6AzL/18RmL6uYKGEvBcU/anSP5hRJRdIF8JSy1lrMwwx+Er339nqvbrdA8XS84xN1
         2kalk+HwfHi7w2sD0VjzJsactOcx0uSD5ZQ5qo0LPTUiUPuPbi+PdarzDRW0H++aYkS2
         aAEEgIf1HEtsMnjvoA7/ynyqcXyI4juwYBfJLfuhDThbcV/B+CoXfoZnr3b0UA9ui5nr
         fe7L21oYxeYcEGpSRJKG/0jVoE++s8yNLcvmmsJb6XOsQShuozjyy8cBo210Bk1Zh0xU
         nxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NU5rjEqsFLdnO9gwXx9gvchvka3TzTBe32wItugjiAY=;
        fh=cb9Pp9Vzh7F7T2Av6niHWtvtubToZ2VI3LsDriJZCyA=;
        b=U1BDDdu9wII10yaZJl6vuRtMO7mZQ5njBns/UYD4Qw1vEDYOP3005u4bWqNpUZhZ2e
         E86vfbZxV10Cl4CtUxXRx2V1aasdlTolP0W5DmVPzz9sJwGStkQHjAOhGek7tsta96Ex
         kZQoQTvR3Vq78a/tmZqjWvQf6V7Tl4uHq9v2/v6q5xlFE5qIoFGH+GGs6MNf/YpcXxL2
         BDydareR3C/juuw2xsc+2uwDRR8oCiiTrL9mxIPlX1w9y1sSAoUVMAVdkWzTUtUbYEgd
         0B+7HbhCkAZXQaYIODJvTMu7VaLaSaMTyEliES0kHvklYjZ4BRFyhiJk7NZXIC4PJFBu
         42Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794557426; x=1795162226; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NU5rjEqsFLdnO9gwXx9gvchvka3TzTBe32wItugjiAY=;
        b=Smn5E4hmKUUocUPgAj3AYLKlebA15vTqdPnzbLy2wPnn52PbmbAb3s2om6tGEdx25g
         CUUZm4EQc8u+GIGP/Usj+89FVVataDqnbaw7BItsghPL8o2sLN6jj9dUDbFRtUpLUW9d
         PTOyjEYO/rVJeN4SFaGci9/V65ilTdJ7/TKkuyJ+R9uHG4TkNLd6U9RjdxolNNvphpDk
         2IRrtMesc270aJ4psIbDNhKielbc16LpB6oQiaNTfRvqbl9fa7e2SlSCMPZdl7UEuiEv
         4VZLz/UZwwgbcU6mxctsmpxWxtBQpaNpiRrNTJ7D+AglswYK2qMErKYW58WjCdcRl2Yw
         Cr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794557426; x=1795162226;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NU5rjEqsFLdnO9gwXx9gvchvka3TzTBe32wItugjiAY=;
        b=OLWi+8bOUf88zdO+iGMHc+cdDLT3JxsVHcwUFSEIScaKVckWdoUgkCoxZ4Ro7Qf9vt
         e70wq41Zn2axqQ+tmKKBG3IGW1bQyc2DbZqiA6KDfESOO9Ip5rxT2yH/ClIN3+ct89bT
         v57LCUAnFfcm2Ux77/NXaJt9uz3ytggM0warW5EAHbZhEKiIoQfi3DUhh8Pe8XX2ASYs
         z3ez6TUqe3nDx7fn4tZ8oHLaQsgK/gBei2/nlySOxOvMlCAoUCooXggcfTXWYuwREH1r
         UJRGdGHG3YnnAs1E90PbCdolklwtnCdc4i77mH3wtYW/04yryQe2V2NOBpFYiMhojexd
         p8lg==
X-Forwarded-Encrypted: i=1; AL+hErEeMEjcISCtSpHE4Bk2BZhAMGvhvIM3KVUu4dbUOBaToAOXBnLYebXhuEzgYnmQoib2NcE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dG2C90sgTvUxiRyZw20p2wVqN8LOIIlw9QuOkcAuMxnl69NIk
	OCQ805VTGSfIgIFhSmr5talodc6KDL0I8HHgU4OdqfsCCdR2iQKLxc73JM4uY8CrpnFK3e7aFYU
	00YjbKE2+bgBlb72tM4YAZkCWiR69iWE=
X-Gm-Gg: AYBFou1MIG51nC05Sv5AcqRVv2XndPx36joxnOulmB9YbjgLfASjfbN17w2BqXm/3U+
	/yVGJIMe8dblV9hO985m/uwwNZ6YJyBwptVBnj9REFtR6nh5v8hGo8up4PCPQ932r/Zz85kR8M2
	eQJvnYAX1gOCgSp3T9zhxoMnW5gD4J8R2f1s5a7mvRm6l/b4VOJZm/6S6j5OQpPtALHEvmKwu1o
	N+/HGnLYLNax3+Sj2bpsUBDSQaZAORSjJ7KNmop80VsjiRtSa1j+1p6w3rB/FIS6kLAB49adjkW
	BNIizp+ILLt8lFZV60Epc3XDEOP75pEnWmVsYkK+SQf1/P2Adm1/22AY1AHixw04/uY892CIQ9J
	SxGFd11EfdPF+nubRVNJuqyoNAVUSNzqhNQ+0nfkFQuEmRSY8mLFsg/nHkNQNvCaWtLaJLdNW9i
	1Z3G6gNoD+Zesc8H0=
X-Received: by 2002:a05:622a:529a:b0:535:f20:c828 with SMTP id
 d75a77b69052e-55ac6d75d9amr28406561cf.24.1794557424566; Fri, 13 Nov 2026
 00:10:24 -0800 (PST)
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
 <CAJwVaMJbzzK8Sj8DvLjiAyqS8TNgRQ3tjRpGcBNC+anQECg5yw@mail.gmail.com> <avXn6E8y5OPtdikQ@sgarzare-redhat>
In-Reply-To: <avXn6E8y5OPtdikQ@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Fri, 13 Nov 2026 16:09:48 +0800
X-Gm-Features: AclHuK88cun5Xe7O-1EZo0223PFjZcV9_p9Gw6r73HoYKOhqaIPRKLoFK9_JsYA
Message-ID: <CAJwVaM+SEhbFtORYgVYNayiQED63sCLO5ibwgkcjBRVvMd=KsA@mail.gmail.com>
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
> On Fri, Nov 06, 2026 at 08:27:51PM +0800, Jia Jia wrote:
> >>
> >> On Tue, Nov 03, 2026 at 12:11:32PM +0800, Jia Jia wrote:
> >> >The virtio-vsock RX worker looks up a socket and takes its lock for every
> >> >packet. Retain the connected lookup reference and socket lock across a
> >> >bounded run of STREAM/RW packets for one established native socket.
> >> >
> >> >Reuse the locked socket while packets match the same flow. Finish the
> >> >batch on a malformed packet, flow change, non-RW traffic, or a change to
> >> >the socket state, transport, protocol, sockmap state, or receive buffer
> >> >limits. A connected lookup miss falls back to the existing receive path,
> >> >which can still find a bound socket.
> >> >
> >> >Limit an uninterrupted socket-lock ownership interval to 64 packets and
> >> >64 KiB of payload. The payload limit is one
> >> >VIRTIO_VSOCK_MAX_PKT_BUF_SIZE. Small or zero-length packets still incur
> >> >per-packet work, so an independent packet limit is needed. The 64-packet
> >> >limit uses VHOST_NET_BATCH as a reference; it is a policy choice rather
> >> >than a protocol limit.
> >> >
> >> >Beyond these limits, a larger batch would only further amortize socket
> >> >lookup and lock/unlock operations, while virtqueue work, validation,
> >> >tracing, skb ownership, credit update, and queueing remain per-packet. I
> >> >therefore expect diminishing returns while the uninterrupted socket-lock
> >> >interval continues to grow, but I have not measured larger limits yet.
> >> >
> >> >Only the guest virtio RX worker is changed. The benchmark exercises the
> >> >host-sender-to-guest-receiver direction, where this worker is on the
> >> >receive path. I have not measured the corresponding worker and socket-lock
> >> >overhead in vhost-vsock or vsock_loopback, and they use different worker
> >> >and locking models. Leave those paths unchanged pending separate policy
> >> >and validation. I plan to evaluate vhost-vsock separately as follow-up
> >> >work.
> >> >
> >> >Performance:
> >> >
> >> >These results cover P1-P3, before the notification changes in P4 and P5.
> >> >
> >> >Tested on a single-stream vsock connection (one Guest receiver thread on
> >> >CPU0, virtio-vsock IRQ on Guest CPU1, fresh QEMU Guest per state). The host
> >> >uses vhost-vsock.
> >> >
> >> >For throughput, vsock_perf runs on the host as the
> >> >sender, with a custom single-threaded Guest receiver pinned to Guest CPU0
> >> >using blocking recv(). The fixed-64K table uses a 64K buffer; the matched
> >> >table uses the sender's request size. The virtio-vsock IRQ/RX worker is
> >> >pinned to Guest CPU1. To normalize run times across payloads into a
> >> >bounded, deterministic window and avoid long runs being skewed by host
> >> >background noise or virtualization scheduling jitter, transfer sizes scale
> >> >proportionally with the request size (64B/64M, 256B/256M, etc.), capped at
> >> >2G for 4K-64K. The custom receiver keeps the recv() size and count
> >> >explicit; vsock_perf's receiver uses poll()+read().
> >> >
> >> >End-to-end RX throughput (fixed-64K receiver; Gbit/s):
> >> >
> >> >  payload  baseline RX  PATCH RX  throughput change (95% CI)
> >> >           (Gbit/s)      (Gbit/s)
> >> >  64B        0.1285       0.2462    +91.59% [+79.74%, +104.22%]
> >> >  256B       0.5909       0.9666    +63.59% [+61.03%, +66.19%]
> >> >  512B       1.1817       1.8350    +55.29% [+46.76%, +64.32%]
> >> >  1K         2.3252       3.3600    +44.50% [+38.93%, +50.30%]
> >> >  4K         3.8436       5.5661    +44.82% [+40.30%, +49.47%]
> >> >  8K         4.6609       5.4115    +16.10% [ +8.91%, +23.77%]
> >> >  16K        5.1196       5.6399    +10.16% [ +4.07%, +16.61%]
> >> >  64K        5.6095       5.7062     +1.72% [-3.19%, +6.89%]
> >> >
> >> >Fixed-syscall stress test (receiver recv() size = sender write size;
> >> >no perf; Gbit/s):
> >> >
> >> >  payload  baseline RX  PATCH RX  throughput change (95% CI)
> >> >  64B        0.1446       0.2540   +75.71% [+63.67%, +88.62%]
> >> >       recv() calls (baseline/PATCH): 1048577/1048577
> >> >  256B       0.4211       0.9061  +115.18% [+72.13%, +169.00%]
> >> >       recv() calls (baseline/PATCH): 1048577/1048577
> >> >  512B       0.7980       1.6112  +101.90% [+95.30%, +108.72%]
> >> >       recv() calls (baseline/PATCH): 1048577/1048577
> >> >  1K         1.4965       2.6986   +80.33% [+68.93%, +92.49%]
> >> >       recv() calls (baseline/PATCH): 1048577/1048577
> >> >  4K         2.9384       4.8590   +65.36% [+60.17%, +70.72%]
> >> >       recv() calls (baseline/PATCH): 539544/524982
> >> >  8K         3.8170       5.1887   +35.94% [+27.66%, +44.75%]
> >> >       recv() calls (baseline/PATCH): 274857/262991
> >> >  16K        4.6856       5.5996   +19.51% [+15.36%, +23.81%]
> >> >       recv() calls (baseline/PATCH): 147518/131351
> >> >  64K        5.5182       5.8800    +6.56% [-0.83%, +14.49%]
> >> >       recv() calls (baseline/PATCH): 48492/32910
> >> >
> >> >Guest CPU1 aggregate cycles per received byte
> >> >(fixed 64K receiver, with perf):
> >> >
> >> >  Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
> >> >  64B        66.728    61.220  -8.25% [-18.99%, +3.91%]
> >> >  256B       14.363    14.515  +1.06% [ -4.22%, +6.64%]
> >> >  512B        7.792     7.578  -2.74% [ -6.55%, +1.23%]
> >> >  1K          3.988     4.032  +1.09% [ -1.64%, +3.88%]
> >> >  4K          2.063     1.973  -4.38% [ -8.23%, -0.37%]
> >> >  8K          1.702     1.667  -2.06% [ -7.99%, +4.25%]
> >> >  16K         1.473     1.475  +0.17% [ -5.06%, +5.68%]
> >> >  64K         1.385     1.358  -1.96% [-10.61%, +7.53%]
> >> >
> >> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >> >---
> >> > include/linux/virtio_vsock.h            |  23 ++
> >> > net/vmw_vsock/virtio_transport.c        |   7 +-
> >> > net/vmw_vsock/virtio_transport_common.c | 303 ++++++++++++++++++++++--
> >> > 3 files changed, 318 insertions(+), 15 deletions(-)
> >> >
> >> >diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> >> >index f91704731057e..748633aa0cc81 100644
> >> >--- a/include/linux/virtio_vsock.h
> >> >+++ b/include/linux/virtio_vsock.h
> >> >@@ -282,6 +282,29 @@ void virtio_transport_destruct(struct vsock_sock *vsk);
> >> >
> >> > void virtio_transport_recv_pkt(struct virtio_transport *t,
> >> >                              struct sk_buff *skb, struct net *net);
> >> >+
> >> >+/*
> >> >+ * Initialize a batch to zero before use. A non-empty batch owns @sk's socket
> >> >+ * lock and the reference returned by vsock_find_connected_socket_net(). The
> >> >+ * caller retains both until it calls virtio_transport_rx_batch_finish(). An
> >> >+ * empty batch owns neither.
> >> >+ */
> >> >+struct virtio_transport_rx_batch {
> >> >+      struct sock *sk;
> >> >+      unsigned int pkts;
> >> >+      size_t bytes;
> >> >+};
> >> >+
> >> >+static inline bool
> >> >+virtio_transport_rx_batch_empty(const struct virtio_transport_rx_batch *batch)
> >> >+{
> >> >+      return !batch->sk;
> >> >+}
> >> >+
> >> >+void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> >> >+                                   struct sk_buff *skb, struct net *net,
> >> >+                                   struct virtio_transport_rx_batch *batch);
> >> >+void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch);
> >> > void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
> >> > u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
> >> > void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
> >> >diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> >> >index 4f9aa9c4c3aa5..9af85712bd387 100644
> >> >--- a/net/vmw_vsock/virtio_transport.c
> >> >+++ b/net/vmw_vsock/virtio_transport.c
> >> >@@ -631,6 +631,7 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
> >> >
> >> > static void virtio_transport_rx_work(struct work_struct *work)
> >> > {
> >> >       struct virtio_vsock *vsock =
> >> >               container_of(work, struct virtio_vsock, rx_work);
> >> >+      struct virtio_transport_rx_batch batch = {};
> >> >       struct virtqueue *vq;
> >> >@@ -666,6 +667,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> >> >                       /* Drop short/long packets */
> >> >                       if (unlikely(len < sizeof(*hdr) ||
> >> >                                    len > virtio_vsock_skb_len(skb))) {
> >> >+                              virtio_transport_rx_batch_finish(&batch);
> >> >                               kfree_skb(skb);
> >> >                               continue;
> >> >                       }
> >> >@@ -673,6 +675,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> >> >                       hdr = virtio_vsock_hdr(skb);
> >> >                       payload_len = le32_to_cpu(hdr->len);
> >> >                       if (unlikely(payload_len > len - sizeof(*hdr))) {
> >> >+                              virtio_transport_rx_batch_finish(&batch);
> >> >                               kfree_skb(skb);
> >> >                               continue;
> >> >                       }
> >> >@@ -685,11 +688,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
> >> >                       /* Force virtio-transport into global mode since it
> >> >                        * does not yet support local-mode namespacing.
> >> >                        */
> >> >-                      virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
> >> >+                      virtio_transport_recv_pkt_batch(&virtio_transport, skb,
> >> >+                                                      NULL, &batch);
> >> >               }
> >> >       } while (!virtqueue_enable_cb(vq));
> >> >
> >> > out:
> >> >+      virtio_transport_rx_batch_finish(&batch);
> >> >       if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> >> >               virtio_vsock_rx_fill(vsock);
> >> > out_nofill:
> >> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >> >index 2a9cfed085515..f83e5b2edce35 100644
> >> >--- a/net/vmw_vsock/virtio_transport_common.c
> >> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >> >@@ -33,6 +33,15 @@
> >> > #define MAX_COLLAPSE_LEN \
> >> >       SKB_MAX_ORDER(VIRTIO_VSOCK_SKB_HEADROOM, PAGE_ALLOC_COSTLY_ORDER)
> >> >
> >> >+/*
> >> >+ * Bound the interval that an RX worker owns a socket lock. One maximum packet
> >> >+ * buffer (64 KiB) bounds payload in one uninterrupted ownership interval.
> >> >+ * Small and zero-length packets need a packet limit to bound per-packet work;
> >> >+ * the 64-packet policy uses VHOST_NET_BATCH as a reference.
> >> >+ */
> >> >+#define VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS    64
> >> >+#define VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES   VIRTIO_VSOCK_MAX_PKT_BUF_SIZE
> >> >+
> >> > static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
> >> >                                              bool cancel_timeout);
> >> > static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs);
> >> >@@ -1793,13 +1802,94 @@ virtio_transport_find_socket(struct sockaddr_vm *src,
> >> >       return sk;
> >> > }
> >> >
> >> >+static void
> >> >+virtio_transport_trace_recv_pkt(const struct virtio_vsock_hdr *hdr,
> >> >+                              const struct sockaddr_vm *src,
> >> >+                              const struct sockaddr_vm *dst)
> >> >+{
> >> >+      trace_virtio_transport_recv_pkt(src->svm_cid, src->svm_port,
> >> >+                                      dst->svm_cid, dst->svm_port,
> >> >+                                      le32_to_cpu(hdr->len),
> >> >+                                      le16_to_cpu(hdr->type),
> >> >+                                      le16_to_cpu(hdr->op),
> >> >+                                      le32_to_cpu(hdr->flags),
> >> >+                                      le32_to_cpu(hdr->buf_alloc),
> >> >+                                      le32_to_cpu(hdr->fwd_cnt));
> >> >+}
> >> >+
> >> >+static bool
> >> >+virtio_transport_recv_pkt_set_owner(struct sk_buff *skb, struct sock *sk)
> >> >+{
> >> >+      if (skb_set_owner_sk_safe(skb, sk))
> >> >+              return true;
> >> >+
> >> >+      WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> >> >+      return false;
> >> >+}
> >> >+
> >> >+static bool
> >> >+virtio_transport_sock_has_psock(const struct sock *sk)
> >> >+{
> >> >+      return (uintptr_t)rcu_access_pointer(__sk_user_data(sk)) &
> >> >+             SK_USER_DATA_PSOCK;
> >> >+}
> >> >+
> >> >+/* The caller holds sk's socket lock. */
> >> >+static bool
> >> >+virtio_transport_rx_batch_can_continue(struct virtio_transport *t,
> >> >+                                     struct sock *sk, u32 len)
> >> >+{
> >> >+      struct virtio_vsock_sock *vvs;
> >> >+      struct vsock_sock *vsk;
> >> >+
> >> >+      vsk = vsock_sk(sk);
> >> >+      vvs = vsk->trans;
> >> >+
> >> >+      /*
> >> >+       * Keep a connected lookup reference only for the native, established
> >> >+       * STREAM path. Sockets outside ESTABLISHED can change table membership;
> >> >+       * a completed or reassigned socket must resume the per-packet path.
> >> >+       */
> >> >+      if (sk->sk_state != TCP_ESTABLISHED ||
> >> >+          sk->sk_type != SOCK_STREAM ||
> >> >+          sock_flag(sk, SOCK_DONE) ||
> >> >+          vsk->transport != &t->transport || !vvs)
> >> >+              return false;
> >> >+
> >> >+      /*
> >> >+       * Do not admit a packet that would hit an existing RX limit while the
> >> >+       * worker owns the socket lock. The caller holds that lock, so no reader can
> >> >+       * dequeue until the batch is released.
> >> >+       */
> >> >+      return (u64)vvs->buf_used + len <= vvs->buf_alloc &&
> >> >+             !virtio_transport_rx_buf_full(vvs);
> >>
> >
> >Hi Stefano,
> >
> >> I don't understand this. We recently introduce the collapse, so when we
> >> will call virtio_transport_recv_enqueue(), all the queue will be
> >> collapsed, including packets in the batch.
> >>
> >> Or am I missing something?
> >>
> >
> >Yes, collapse operates on the same receive queue, which also contains
> >skbs queued earlier in the current batch.
> >
> >The rx_buf_full() check is not intended to bypass collapse. It prevents
> >the batch from retaining the socket lock while processing a packet when
> >there is no metadata room for another skb. Collapse is best effort:
> >some skbs cannot be merged, and allocation of a replacement skb can
>
> IIUC batches are enabled only for SOCK_STREAM, so, which skbs can't be
> merged?

My wording in the previous reply may not have been precise. What I meant
is that collapse is not guaranteed to free the skb slot needed for the
incoming packet for every valid receive-buffer configuration.

With the default 256K receive buffer, a queue of small STREAM skbs will
normally contain multiple collapse candidates by the time it reaches
the metadata limit, so collapse will normally make room.

However, SO_VM_SOCKETS_BUFFER_SIZE is configurable through setsockopt().
A sufficiently small but valid receive buffer can make queue_max equal
to one. After the first small packet has been queued, that skb is
eligible for collapse, but there is no adjacent skb to merge it with.
virtio_transport_collapse_size() therefore returns only that skb's own
length, and the skb is kept unchanged.

The incoming second skb is not in rx_queue yet. Provided that the two
packets combined payload still fits within buf_alloc, the payload check
passes, but virtio_transport_inc_rx_pkt() rejects the second packet on
the metadata check. This happens before the later tail-copy optimization
is reached.

Therefore, this case does not require an ineligible STREAM skb or an
allocation failure. Collapse simply cannot reduce a one-element queue.

If my understanding is wrong, please correct me. Thanks.

>
> If allocation fails, I guess we have other issues, no?
>

Yes. I thought about that again, and allocation failure is not the
reason for this check. Thanks

> >fail. If the packet remained in the batch and collapse did not make
> >enough room, virtio_transport_inc_rx_pkt() would fail and
> >virtio_transport_recv_connected() would reset the socket with ENOBUFS
> >while a waiting reader was still unable to drain the queue.
> >
> >When the check makes can_continue() return false before the current
> >packet has been handled, the caller releases the socket lock and passes
> >the packet to virtio_transport_recv_pkt(). This gives a waiting reader a
> >chance to make progress. If the queue is still at the metadata limit,
> >the normal enqueue path attempts collapse. If that still cannot make
> >enough room, the existing ENOBUFS reset occurs.
>
> I really don't see the difference without batching :-(
>
> I may be missing something.
>

The difference is the release_sock() boundary between packets.

In the regular per-packet path, the socket lock is released after the
first packet. A reader woken by that packet can compete for the lock and
fully dequeue the only skb before RX locks the socket for the second
packet. If it succeeds, the second packet can be accepted. If it does
not acquire the lock in time, or only partially consumes the skb, the
queue length remains one and the regular path can still reach the
existing ENOBUFS reset.

Without the rx_buf_full() check, two same-flow packets processed in the
same active batch remain under one uninterrupted socket-lock ownership
interval. Once the first packet leaves the only skb in the queue, the
reader cannot dequeue it before the second packet is processed.
Collapse cannot reduce that one-element queue, so the second packet
fails the metadata check and resets the connection.

The check detects this metadata boundary after the first packet and
finishes the batch. It therefore restores the lock-release opportunity
that the regular per-packet path had at the same point. It does not
guarantee that the reader acquires the lock first; it preserves the
original opportunity to do so.

Without this check, batching would remove a successful interleaving
available to the regular path. For this valid receive-buffer
configuration, when both packets are processed in the same uninterrupted
batch, an otherwise avoidable reset would become unavoidable. That
would be a functional regression introduced by batching.

Thanks,
Jia

> Thanks,
> Stefano
>
