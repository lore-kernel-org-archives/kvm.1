Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793968174;
	b=CQHi73uebs8JfrK3foPr5aroRYA2+D5ot/gEZNcXXDCGFEuiCiOeCuantimPuAq1FRvY
	 c88EqA8u9QK4IkfC1at7n3jbsqoxQxOcL96FhcnHuW16DsNZLj1yEY+9CcFk5TNThGRxU
	 AwrHQYjrCHj4sWMRFKfyqE8KElNropb3QUNoNvPPIj2m7lbjWXHgECivbwvnN4uWRuuwJ
	 dysm45aGUSeath0Bp5oLO96vovqwK2ORf1pY9KGoDkiZ5I1bfCJlrGR/aBnrjOUNh/oXy
	 ddg/SmAfEeFRJV4kqWLv6PmQNd3zHpsSxUr66s1x77MP8BQgiLjlAfQLO1QX7Ov2UHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=gH1mJSj/kyZPh+4tLVnw5BdMCKvmnBAyYQhJaAhQgzo=;
	b=IEVQY3lai0NlczBnOKKunpkNnqTW7P2U5Dcin8HN5V8e/G0aLR71ErX8tx7r8aiEoqyB
	 kiuwr0eSJlfc9EhtiX7BEmtml9T7c+z5VhYA6nfR/0SlgtSUxWvezqouaUaBSjN4U4xzY
	 uUXbNPa4xa6yF7SD6TKtVgwCnhQ2yDDnBdKOO/BIIaIoy2uW4QQgCfnq0kbfa4NqwxHWO
	 kutPq38K8KJeezj+/mFKIr5Pdz1vRwkBRHGw1ckft056N1d/wMmlOVA3jB9FtOQP6jQtJ
	 +wk6FPIqPST8fawsMLAbGIfnwvCBb0oxcmKMxPfgArEfjW9qLjEPYy2Ee33DXfgdGFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="CmPnMt/+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA38B606A32E
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 12:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA38B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CmPnMt/+
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-945e6d9ceeaso55970285a.0
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 04:29:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793968173; cv=none;
        d=google.com; s=arc-20260327;
        b=Y2syLpz3Ya8z39LsXZK34BJcKSwy3bl7Hhe523WI+iKH7Fc/vSZBBIGDFOS5oFxODC
         oI5k0Vetq6J0CY8I2a90c5YLqu76W4R1Q5E3+q3VMmE2MV4AY6GacD5NyetK+8+KQGRm
         hrhZrjB9OtGAl8FGcbFYZfSPs6Hhoit273DYpsXZkd3c7aCYUTkfVRM3nALJVQ+2rw3g
         xOd2wZ5pLFcrR5IZvVbRuMkrn4j0Fv6L/3RHafXXPv3bCbuWjmUoWId045XakgWNd5mS
         LpX6g6ObiGafgIprQIZoRpN5qlt55sx+T9zQjioljHHvQPWSOpIKy123bXVDlAIguCA9
         wziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gH1mJSj/kyZPh+4tLVnw5BdMCKvmnBAyYQhJaAhQgzo=;
        fh=GDCzYGrTfYl0OumJdKaS4CBePoEjDBdVYbDmoeL0rvo=;
        b=XtL6VFpDnqVTacVgEaQ6OshoL/KoTGqUrUq6C+gtpfZ8qycZMFJSn/s7+tK76PQ8Ap
         9TPofvPAjH+mZDEd6e5nzSTNz56/qbe2vRX5NinFDwGGGNRs4CcZ89xcFlU6NUR8gxc1
         JrD1o3u8JPGpoST9S2Po+tg+Tu1EVNU4iCLC2GfNS6zya2ITqgBOu9110W3uqY0SZIMV
         jIyNu6G250omCijx5dQx02FQtwEYgr7VnAkgn6K3ZXqZf1PbcIofEov7JHMmLOwDRFyx
         S4uaEaIjNlwtOCEzZSjGtxFk6mR5jbzVQ4I37QAD+laDdS26sfbUcgs4GXF+FFmbe4xo
         HghA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793968173; x=1794572973; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gH1mJSj/kyZPh+4tLVnw5BdMCKvmnBAyYQhJaAhQgzo=;
        b=CmPnMt/+L+pcGEx8o8xV4PJnt+gAVP8+SO9XVfHNPDIU+jEa0+KSEbY/rbEYIk/cZe
         8LFT/xraPsCHng2diNi8SAQlnIKziq4K/t83l+1XhI4ryTqfau9iGgEDpkAacevs5Kyt
         JANBZDjyqPaRCYZVCf1nENMjltlVE73FT5fiTFqZ+iVJOwWBCns2AOmpa0a41ssSnNWa
         hYWe+TBpi7oputXl9AqwchOWtqMheb1lyOSrLxebE7d66+Ad568H6MfM5tKWWsJWwmsR
         ixeYLc0MbyP/0IvMwD3y0yHHULVOmVwMGd6bD/q6RP88BlgX84USg4mvQrwxQCJy/FZM
         EvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793968173; x=1794572973;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gH1mJSj/kyZPh+4tLVnw5BdMCKvmnBAyYQhJaAhQgzo=;
        b=EKqr0g8kzZTIPNkTi9Tj7sQ5kPO/BbyUestdFNRWMTkwsS/Z84YwK1kii29DPyvisE
         4b/E4XNsUlTNeV2N6dVSKNAIua3Bxi5fC6P9rbyXI70ox3plyHxWiXvHfNSa85pS1MJz
         v2IHe6rGcVKxlVqOHApQeD63BFjxZeFWp5hFia2dSTREAIchstL/bNI+JN46ENlLXa/s
         0eJFFspvqPHDu0aZ247NfYZoVsreMg4N6epDKISRFFzi660FoLkw8BHshl99ek6CP4gE
         iDCITm3pSpg8oZoLLLkM9ikP0gUfYrn8ruDU8XQXcjQWTmXs6hXOm0sW+/ZrOn+VlpJ0
         o7Ag==
X-Forwarded-Encrypted: i=1; AKwUvBya0ldSvRdiXziWCaJhOYhFfjTl87cc2dzNClbt3BnG4fFXcdpQuUFKsJnXJCAs6k+Zgzs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+u4hSiMgwYl64Z5zEubPZGbHvYD9hLXq7jHUJ2dFg84o8U5ikH
	1D1OIh9xw00YFoMhSfDPXjRLnnE/CYk6BIhrTWpdo1pSMOmjiFt5+HXsLkf2HCqQy/RFuvKSyTx
	hEQ8WknGoQQi4l+2kor0e9vp1FLELGTk=
X-Gm-Gg: AYBFou359oMF0T5bAaHcUIS6/OuN4Diz9y3G+zqwuFL/tquZWJabPwoPButV0YVUt2s
	9nIC39z27hIFnAyw2NsknV0nsgPqMWvX3tRSqnL9B6W9R25wpzJjWdaOzUZ++A2nZQpb1VNNOyD
	04st/wjZyA1Xq5OL/mlKxs+xZFu40FvsNTQAsiqtP4mKUqjCFHz4MzK5H2jOH3ZIoaeHxw0gWCv
	3t3AuMeWbt6g43w4v4Ywgal6uujPb3fraBHdLys0SQR2dtBa4igMi7piI+Rym37NJmJTMG9ad+5
	qjj2gg6Q7D1ZmRRyxcOG2+ypJ2ezah7CL2bvrxrkwWMYG0R52GpSap+e0e2FKZaIOAFRSt8NkfP
	Gm25SoXYX492Ng4gM3Et9Pu6A1S+yPK1LivZ8fvT2IXXvpZGhWuNLu3jXeu+NpnfH+Ws1OQo=
X-Received: by 2002:a05:620a:2794:b0:945:f28f:ce92 with SMTP id
 af79cd13be357-945f34b9241mr264204285a.40.1793968171614; Fri, 06 Nov 2026
 04:29:31 -0800 (PST)
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
 <20261103041134.33310-3-physicalmtea@gmail.com> <auxFXGVwY5IxlP5L@sgarzare-redhat>
In-Reply-To: <auxFXGVwY5IxlP5L@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Fri, 6 Nov 2026 20:28:55 +0800
X-Gm-Features: AclHuK8WSWZqF0YhOcKmUqT_DW8bT4U1CLlE79rQgfWA3WujjgxC2J69k28qsgw
Message-ID: <CAJwVaMLa2kNAtQvJkE-2aVX7M=pA4eNOTTHeixdZ919DbKu5Nw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/5] vsock/virtio: factor RX skb metadata
 budget check
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, bobbyeshleman@gmail.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Tue, Nov 03, 2026 at 12:11:31PM +0800, Jia Jia wrote:
> >Extract the skb metadata budget check from virtio_transport_inc_rx_pkt()
> >into virtio_transport_rx_buf_full().
> >
> >The helper retains the existing condition and will be reused by a
> >following RX batching change.
> >
> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >---
> > net/vmw_vsock/virtio_transport_common.c | 12 +++++++++---
> > 1 file changed, 9 insertions(+), 3 deletions(-)
> >
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >index 43325d7aebbb1..2a9cfed085515 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -576,11 +576,17 @@ virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,
> >       skb_queue_splice(&new_queue, &vvs->rx_queue);
> > }
> >
> >-static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> >-                                      u32 len)
> >+static bool
> >+virtio_transport_rx_buf_full(struct virtio_vsock_sock *vvs)
> > {
> >       u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> >
> >+      return skb_overhead > vvs->buf_alloc;
> >+}
>
> As I pointed out in patch 3, I'm not sure we need this.
> After we introduced the collapse, SOCK_STREAM should collapse rx_queue
> before hitting this, so not sure we really need this function.
>
> Thanks,
> Stefano
>

This patch only factors out the existing metadata check from
virtio_transport_inc_rx_pkt() into virtio_transport_rx_buf_full() so
can_continue() in patch 3 can reuse it.

virtio_transport_recv_enqueue() attempts collapse when the queue is
already at this limit, and then inc_rx_pkt() runs the check again.
Collapse may not free enough slots: some skbs cannot be merged, and
allocation of a replacement skb can fail. As explained in the patch 3
reply, when virtio_transport_rx_buf_full() is true before the packet is
handled, the caller releases the socket lock. A waiting reader then has
a chance to drain before that packet reaches
virtio_transport_recv_enqueue().

> >+
> >+static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> >+                                      u32 len)
> >+{
> >       /* Allow at most buf_alloc * 2 total budget (payload + overhead),
> >        * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
> >        * metadata. Check payload against buf_alloc to be sure the other
> >@@ -588,7 +594,7 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> >        * queue growth.
> >        */
> >       if ((u64)vvs->buf_used + len > vvs->buf_alloc ||
> >-          skb_overhead > vvs->buf_alloc)
> >+          virtio_transport_rx_buf_full(vvs))
> >               return false;
> >
> >       vvs->rx_bytes += len;
> >--
> >2.53.0
> >
>
