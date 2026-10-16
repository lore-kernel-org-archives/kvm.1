Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCA6384243
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161236; cv=none; b=cCGCupXCHnAlxVg6rbx/nvjMFRQjTVz3XEnc8Dxh11N0LmPNDvLxHcriPGsK1U9rSffNpwAFAcIkZIIKuVBJbJcMaARNdIVg0LfN1xZb33wj+7DN6cbC0nuKb76wPlyg/AtCIpQ2ja4aldkoETn/IiUnQdcpTZBHWWl6j06f4o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161236; c=relaxed/simple;
	bh=4BbGYtATqak/z/B2iKA89awHxYdxKL6Ayqf2LXOqIrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaHGlr6xYx2S+t+QOi7BxDOFLOfK88m/NQ1oHeEH43Jnr/A7jTMDVUNqkkMfegMF6uAKaBgTL9rIzSk++hbWYXnQyD+VBUq9qmPkWl0qc8KC4YeEdHwhJgm5DgcYdMv7qxjKsdHfCV50S5KEKO/WKSb/MFjDTGHqE78T9zrow+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QrlG7sqd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJBydt4z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrlG7sqd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJBydt4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792161233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HrgO4b0vx/4osiDDjAIrXnoFHpH7h1KXasvR5fBBxI8=;
	b=QrlG7sqdHisj7hXIAI9Mt9/3CKxXfKKZ5jJuj9mR4MeEjTsXt0bwAG/0wgySBwX3mJx9Mq
	5ogyj9mBf4z4HNZDNLDhRCEf1nHLW8fzt11GQuDzt1AcyIUJ67/bSJLrluJEbwr3KCUPau
	8jaZYu5IKsC9pc81i4OavYPcAYAV+n8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-B420oeuBPJCovvdKODfWfg-1; Fri, 16 Oct 2026 14:33:52 +0000
X-MC-Unique: B420oeuBPJCovvdKODfWfg-1
X-Mimecast-MFC-AGG-ID: B420oeuBPJCovvdKODfWfg_1792161231
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48dfdc0f491so400607f8f.1
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 07:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792161231; x=1792766031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HrgO4b0vx/4osiDDjAIrXnoFHpH7h1KXasvR5fBBxI8=;
        b=fJBydt4zGTF5kFE53FgmIhmcvYTAWV5zYB6bnUIOE5twOvAPp/uC4uPOunZs2Sd79y
         cn9gWaOIZDodNqFlcbmbUZAoVl0Up0x05LhZH9Y1kFhXuLqwKYqKSMX8RLMvQIan44vS
         dIC1hPEqub+MkQ3dmY4TfCRQCWm3zY56yMu4FJa06ooljBiQ/KJfIig4hMx+b1Eywbst
         XhyPTpnXHz1vVK/P5pUEcEAQi1GoTI5G03PUnk8isrWPS1WuEjqPODPFsoVgAQ+MglDz
         eRyMv4ud2PY4sPdKezeDHnG5G/XgC3J+XGhyCfKr9qfza/pPOQotAwJ8dVrBisYHCN/g
         Gztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161231; x=1792766031;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HrgO4b0vx/4osiDDjAIrXnoFHpH7h1KXasvR5fBBxI8=;
        b=YOllEcLVD6kYIpd2L4CAaruwNwk/53JmbDtMlu6ao+xOJ43OfDZBOJJ7eqBt1Kh42K
         wedPuLJWASFtaXsJtpvW4pVbZGBwVHN8wRszD+balV3G99/OpIp34H7idr1wH8W7yfzh
         WOlvHzBsWNL4ON5rYiC2ZQ8VagyVPac3VeezT+HFoET4tz0iKMludztngl6bFY5g2gH2
         N1SiXLwt7iLnLlg2CXPVhwqTr5mArBeFkRGIxsMi2RlJ+aEzBZFRhYVDcmsPGXCB94ZG
         3VH4dS2P5kiBSzyRkBvk/kzEMCEq2FqG0ONqwtnDdPM8gF+901ggSyAYQTjB3wpG066Y
         wkHw==
X-Forwarded-Encrypted: i=1; AKwUvBwBrskWZzEK36XV/8ZOTdl7ncCWUvWa6B7UVhbCfIrkaFrDlbnv5EI9kgAG75rYFuCXYBo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/+oKkTDwRhOJi15/6zjlASpLm90TE+OIZEDFWVVWo/fNdW6uX
	72c2dG+WycWUaDtB2gENySbtt3WIZkpZYv4JIkDTMywW5oMJdrH26m5ih5DU+/zps8JOw7dirLd
	I0bX/z0iS961bU9jCWagrELsz+MI2YDjyghwM5Tt6P/lolTBn6RE+pA==
X-Gm-Gg: AYBFou0R0doywX70jBHfB3J0QzY5srJJxEMJpRArBMI/yOs19FJJR+yxEMkPbHv1ch/
	OxJuW27dNisO74VqhK9gfU/jgb74OzYoIiB2mqRHRfIONCJLaDCzp8XMjEdq4sNBBTsjAlQcTPJ
	EhZouSz1EZhPcXQ70YhwyrHJ/dquzHcp5C783NPT+QEhzk1chEefJEPsrnvXRI+027LPjcmNWEc
	XnxYx7/BhbPbvaLs8p03lJvtXrEdtvhj4NOBqtwmJ6qIigN9g8O2CEGoU8yI/shAyOteM7J8lT3
	6Bc+jrYAxbXc2PE2IeHsDtTZ+CKGFdkfW6O2VEl6neRSUXdJuC3Qs7tj0Bqy9nfAyOltPu3bplW
	NuDeb
X-Received: by 2002:a05:6000:22c8:b0:48c:6a50:cb9a with SMTP id ffacd0b85a97d-48dbacf56a0mr43768081f8f.51.1792161229290;
        Fri, 16 Oct 2026 07:33:49 -0700 (PDT)
X-Received: by 2002:a05:6000:22c8:b0:48c:6a50:cb9a with SMTP id ffacd0b85a97d-48dbacf56a0mr43767947f8f.51.1792161227853;
        Fri, 16 Oct 2026 07:33:47 -0700 (PDT)
Received: from sgarzare-redhat ([80.116.137.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd503d78sm5208905f8f.50.2026.10.16.07.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:33:47 -0700 (PDT)
Date: Fri, 16 Oct 2026 16:33:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v4 2/4] vsock/virtio: amortize RX socket locking
 for stream packets
Message-ID: <atIrLeH8uOCHxsbv@sgarzare-redhat>
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-3-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261014115640.184286-3-physicalmtea@gmail.com>

On Wed, Oct 14, 2026 at 07:56:38PM +0800, Jia Jia wrote:
>The virtio-vsock RX worker currently looks up the socket and takes its
>lock for every packet. Keep the socket lock and lookup reference across a
>bounded run of STREAM/RW packets for the same established socket.
>
>Reuse the locked socket while packets continue to match the same flow.
>End the batch for a different flow, non-RW traffic, malformed packets, or
>a change in socket state, transport, protocol, or receive-buffer headroom.
>A connected-table miss uses the existing receive path.
>
>The reused path still traces every packet, takes an skb owner reference,
>validates the source and transport, updates credit, and runs the existing
>receive state machine.
>
>Sockmap can replace the protocol without taking the socket lock. Check the
>psock marker at each packet boundary and serialize initial admission with
>sk_callback_lock, so a concurrent attach ends batching at the next packet.
>
>Cap a batch at 64 packets and 64K of payload. The packet limit bounds

Why this cap?

>per-packet work, while the byte limit bounds how much data can queue before
>a reader acquires the socket lock. Batching remains in the process-context
>RX worker.

IMHO this patch should carry performance results.

>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> include/linux/virtio_vsock.h            |  11 ++
> net/vmw_vsock/virtio_transport.c        |  29 +++-

Why no changes in vhost-vsock or vsock_loopback?

I'm not asking to do that, I'd like to understand why only in the 
driver.

> net/vmw_vsock/virtio_transport_common.c | 183 +++++++++++++++++++++++-
> 3 files changed, 216 insertions(+), 7 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index f91704731057e..26dde6909c4ed 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -282,6 +282,17 @@ void virtio_transport_destruct(struct vsock_sock *vsk);
>
> void virtio_transport_recv_pkt(struct virtio_transport *t,
> 			       struct sk_buff *skb, struct net *net);
>+
>+struct virtio_transport_rx_batch {
>+	struct sock *sk;
>+	unsigned int pkts;
>+	size_t bytes;
>+};
>+
>+void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>+				     struct sk_buff *skb, struct net *net,
>+				     struct virtio_transport_rx_batch *batch);
>+void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch);
> void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
> u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
> void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 4f9aa9c4c3aa5..ef076732158d4 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -629,8 +629,16 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
> 	return seqpacket_allow;
> }
>
>+/*
>+ * Keep a bounded run of packets for one socket under a single socket lock.
>+ * Limit packet count and payload size to bound the work done while locked.

Here we should explain why we choose these values.

>+ */
>+#define VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS	64
>+#define VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES	(64 * 1024)
>+
> static void virtio_transport_rx_work(struct work_struct *work)
> {
>+	struct virtio_transport_rx_batch batch = {};
> 	struct virtio_vsock *vsock =
> 		container_of(work, struct virtio_vsock, rx_work);
> 	struct virtqueue *vq;
>@@ -666,6 +674,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 			/* Drop short/long packets */
> 			if (unlikely(len < sizeof(*hdr) ||
> 				     len > virtio_vsock_skb_len(skb))) {
>+				virtio_transport_rx_batch_finish(&batch);
> 				kfree_skb(skb);
> 				continue;
> 			}
>@@ -673,6 +682,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 			hdr = virtio_vsock_hdr(skb);
> 			payload_len = le32_to_cpu(hdr->len);
> 			if (unlikely(payload_len > len - sizeof(*hdr))) {
>+				virtio_transport_rx_batch_finish(&batch);
> 				kfree_skb(skb);
> 				continue;
> 			}
>@@ -680,16 +690,33 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 			if (payload_len)
> 				virtio_vsock_skb_put(skb, payload_len);
>
>+			if (batch.sk &&
>+			    payload_len > VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES -
>+					  batch.bytes) {

Why this?


>+				virtio_transport_rx_batch_finish(&batch);
>+			}
>+
> 			virtio_transport_deliver_tap_pkt(skb);
>
> 			/* Force virtio-transport into global mode since it
> 			 * does not yet support local-mode namespacing.
> 			 */
>-			virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
>+			virtio_transport_recv_pkt_batch(&virtio_transport, skb, NULL,
>+							&batch);
>+
>+			if (batch.sk) {
>+				batch.pkts++;
>+				batch.bytes += payload_len;
>+				if (batch.pkts >= VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS ||
>+				    batch.bytes >= VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES) {
>+					virtio_transport_rx_batch_finish(&batch);
>+				}
>+			}

Why this is not in the common part?

> 		}
> 	} while (!virtqueue_enable_cb(vq));
>
> out:
>+	virtio_transport_rx_batch_finish(&batch);
> 	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> 		virtio_vsock_rx_fill(vsock);
> out_nofill:
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 61ee3bc205d5d..ff74e805527a5 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -576,11 +576,16 @@ virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,
> 	skb_queue_splice(&new_queue, &vvs->rx_queue);
> }
>
>+static bool
>+virtio_transport_rx_skb_has_headroom(struct virtio_vsock_sock *vvs)
>+{
>+	return (u64)(skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0) <=
>+		vvs->buf_alloc;
>+}

Please move this change in a separate patch.

skb_has_headroom() is confusing IMO, maybe 
virtio_transport_rx_buf_full(), but reversing the return value, so 
keeping the same check as before.

>+
> static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> 					u32 len)
> {
>-	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>-
> 	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
> 	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
> 	 * metadata. Check payload against buf_alloc to be sure the other
>@@ -588,7 +593,7 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> 	 * queue growth.
> 	 */
> 	if ((u64)vvs->buf_used + len > vvs->buf_alloc ||
>-	    skb_overhead > vvs->buf_alloc)
>+	    !virtio_transport_rx_skb_has_headroom(vvs))
> 		return false;
>
> 	vvs->rx_bytes += len;
>@@ -1798,12 +1803,38 @@ virtio_transport_find_socket(struct sk_buff *skb, struct sockaddr_vm *src,
> 	return sk;
> }
>
>+static bool
>+virtio_transport_sock_has_psock(const struct sock *sk)
>+{
>+	return (uintptr_t)rcu_access_pointer(__sk_user_data(sk)) &
>+	       SK_USER_DATA_PSOCK;
>+}
>+
>+static bool
>+virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
>+				    struct sock *sk)
>+{
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+	struct virtio_vsock_sock *vvs = vsk->trans;
>+

A comment here to explain why some checks like...

>+	return sk->sk_state == TCP_ESTABLISHED &&
>+	       sk->sk_type == SOCK_STREAM &&
>+	       READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
... this       ^

I mean in general to explain better these conditions (I mean not a 
description of what we are doing, but why we are doing these checks).

>+	       !sock_flag(sk, SOCK_DONE) &&
>+	       vsk->transport == &t->transport &&
>+	       vvs && virtio_transport_rx_skb_has_headroom(vvs) &&
>+	       !virtio_transport_sock_has_psock(sk);
>+}
>+
> /*
>- * The caller holds sk's socket lock and must free skb if this returns true.
>+ * The caller holds sk's socket lock.  Set @batchable if the socket can remain
>+ * locked for another ordinary STREAM/RW packet.  Return true if the caller
>+ * must free @skb.
>  */
> static bool
> virtio_transport_recv_pkt_locked(struct virtio_transport *t,
>-				 struct sk_buff *skb, struct sock *sk)
>+				 struct sk_buff *skb, struct sock *sk,
>+				 bool *batchable)
> {
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> 	struct sockaddr_vm src;
>@@ -1813,6 +1844,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> 	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> 			le32_to_cpu(hdr->src_port));
>
>+	if (batchable)
>+		*batchable = false;
>+
> 	/* Listener sockets accept packets from any source and are not assigned to
> 	 * a transport.
> 	 */
>@@ -1854,6 +1888,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> 		break;
> 	}
>
>+	if (batchable)
>+		*batchable = virtio_transport_recv_pkt_batchable(t, sk);
>+
> 	return false;
> }
>
>@@ -1894,7 +1931,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 	}
>
> 	lock_sock(sk);
>-	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk);
>+	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, NULL);
> 	release_sock(sk);
>
> 	/* Release refcnt obtained when we fetched this socket out of the
>@@ -1910,6 +1947,140 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> }
> EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
>
>+/*
>+ * Finish the RX batch.
>+ * For a non-empty batch, the caller must hold the socket lock acquired with
>+ * lock_sock(). This function releases the lock and the batch's lookup
>+ * reference.
>+ * An empty batch is a no-op.

What empty batch means, I mean how the caller can understand that a 
batch is empty?

Maybe we should provide a function for that...

>+ */
>+void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
>+{
>+	struct sock *sk = batch->sk;
>+
>+	batch->sk = NULL;
>+	batch->pkts = 0;
>+	batch->bytes = 0;
>+
>+	if (!sk)
>+		return;
>+
>+	release_sock(sk);
>+	sock_put(sk);
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_rx_batch_finish);
>+
>+void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>+				     struct sk_buff *skb, struct net *net,
>+				     struct virtio_transport_rx_batch *batch)
>+{
>+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>+	struct sockaddr_vm src, dst;
>+	struct vsock_sock *vsk;
>+	bool batchable, start_batch;

Ditto about declarations order, please check in the entire series.

>+	struct sock *sk;
>+	bool free_pkt;
>+
>+	/* Only STREAM/RW packets can share a socket lock. */

Why?

Should the caller holds the lock for the entire batch?
Should this be documented?

>+	if (le16_to_cpu(hdr->type) != VIRTIO_VSOCK_TYPE_STREAM ||
>+	    le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_RW) {
>+		virtio_transport_rx_batch_finish(batch);
>+		virtio_transport_recv_pkt(t, skb, net);
>+		return;
>+	}
>+
>+	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
>+			le32_to_cpu(hdr->src_port));
>+	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
>+			le32_to_cpu(hdr->dst_port));
>+
>+	if (batch->sk) {
>+		vsk = vsock_sk(batch->sk);
>+		if (vsock_addr_equals_addr(&src, &vsk->remote_addr) &&
>+		    dst.svm_port == vsk->local_addr.svm_port &&
>+		    vsock_net_check_mode(sock_net(batch->sk), net) &&
>+		    virtio_transport_recv_pkt_batchable(t, batch->sk)) {
>+			sk = batch->sk;
>+			trace_virtio_transport_recv_pkt(src.svm_cid,
>+							src.svm_port,
>+							dst.svm_cid,
>+							dst.svm_port,
>+							le32_to_cpu(hdr->len),
>+							le16_to_cpu(hdr->type),
>+							le16_to_cpu(hdr->op),
>+							le32_to_cpu(hdr->flags),
>+							le32_to_cpu(hdr->buf_alloc),
>+							le32_to_cpu(hdr->fwd_cnt));
>+			if (!skb_set_owner_sk_safe(skb, sk)) {
>+				WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
>+				virtio_transport_rx_batch_finish(batch);
>+				kfree_skb(skb);
>+				return;
>+			}
>+

This code is unreadable TBH, there isn't a blank line till here...
and too much nested blocks.

Maybe you should move this in a function, and use a bit more blank lines.


>+			free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk,
>+								    &batchable);
>+			if (!batchable)
>+				virtio_transport_rx_batch_finish(batch);
>+			if (free_pkt)
>+				kfree_skb(skb);
>+			return;
>+		}
>+
>+		virtio_transport_rx_batch_finish(batch);
>+	}
>+
>+	sk = vsock_find_connected_socket_net(&src, &dst, net);
>+	if (!sk) {
>+		virtio_transport_recv_pkt(t, skb, net);

Why this?

>+		return;
>+	}
>+
>+	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
>+		sock_put(sk);
>+		virtio_transport_recv_pkt(t, skb, net);
>+		return;
>+	}
>+
>+	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
>+					dst.svm_cid, dst.svm_port,
>+					le32_to_cpu(hdr->len),
>+					le16_to_cpu(hdr->type),
>+					le16_to_cpu(hdr->op),
>+					le32_to_cpu(hdr->flags),
>+					le32_to_cpu(hdr->buf_alloc),
>+					le32_to_cpu(hdr->fwd_cnt));
>+
>+	if (!skb_set_owner_sk_safe(skb, sk)) {
>+		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
>+		kfree_skb(skb);
>+		return;
>+	}

We have this code duplicated in several place now, can this be avoided?

>+
>+	lock_sock(sk);
>+	/*
>+	 * Sockmap removal restores the native protocol under sk_callback_lock.
>+	 * Serialize this initial eligibility check with that update.
>+	 */
>+	read_lock_bh(&sk->sk_callback_lock);
>+	start_batch = virtio_transport_recv_pkt_batchable(t, sk);
>+	read_unlock_bh(&sk->sk_callback_lock);
>+
>+	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk,
>+						    start_batch ? &batchable : NULL);
>+	if (start_batch && batchable) {
>+		/* Keep the lookup reference until the batch is released. */
>+		batch->sk = sk;
>+		return;
>+	}

Ah, this is for the first run, when the batch is empty, right?

Can you merge in some way both branches?

BTW please add some more useful comments (explaining why)

>+
>+	release_sock(sk);
>+	sock_put(sk);
>+	if (free_pkt)
>+		kfree_skb(skb);
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt_batch);
>+
> /* Remove skbs found in a queue that have a vsk that matches.
>  *
>  * Each skb is freed.
>-- 
>2.53.0
>

