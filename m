Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DD639EF3F
	for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 04:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792299196; cv=pass; b=DTl269yHhF9lGghQYTSbmDlwVe8ZROexA+nrVAZ4UE6X+nXxLS6urYx+U2UaFBoalgQm1Ttq2T59eAVAn1Jtfm2wWq2tHcS7Hakb4IYBFCrC74l72nw+EHhEiErulQ9DrG0XIrk6JwkOZK4Snsk4TxHMaII/ljXRWYf6qApyHUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792299196; c=relaxed/simple;
	bh=fxKh9iRYIjg5hOH0YPley58hencHMl77nnj6AFGHG2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfAksTe7FJNBx0jqrp5KUfiLuKt6BDBSGsYUxByc3Hm1XERsQheR2C2cWNYw1+fTmqwu7a2/BNyxLv/ajtF9B94Vm3a9kMlUsvPa5g6/fUCa79uIUCkuSqZYMYvaqUeT6KgenUBNN0HE5sycrEFILE0wau2oblWV+l5JE5b4/2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYaiMDi4; arc=pass smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYaiMDi4"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f2ed2541aso69993385a.0
        for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 21:53:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792299194; cv=none;
        d=google.com; s=arc-20260327;
        b=gv6wxUdzGazMcf96fKsYLWHoO4w0dTcc7lEKgIvawIOIdDvWrViF1zuucTbS5iZV0I
         yIdCkpu9U2iJdidgGcN+6lB+niM2i5ni3xIPyKlrr0C2pgBaT8DxYWRChZ/2GF5zpkAF
         IL2c3dP7PCKAeELtUInWIvoLwkgJCUoPP8maG+E9J1j3QajAHtjdtOZbPOFtot+uQC5V
         NXpzfa/jWXKQhfe7ToclrKYrN8O8RbKyLWuXRZRCpaOtO6eJzF31MHJQj0hs8OI6c6z4
         2tL15Iy/cbxTJTWLt/3ixh7s+EgoT7P/zwvFRqKpFJy0Zla/bs3ngy5yb507VhRVZR2h
         OT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qrO4duGPAc/tD1WFHTWuLBqHn5xfmNbJbvEpSmCkQPo=;
        fh=9QppJGrfonRlGExXy5wVAMGx9H5Y6BY366f2oE1brD4=;
        b=qhzHeqm8Pg1To7Gphx4f1SyMZwwSNTTFyHJlPJkHJVHoTnAcQV3+3OXHk7qXV4oSKr
         r9ZGzuDrabebnzub+JWNgdlquDcDI1LnOutxYZ0MW5U8EhIR9ux31Zzo8sgsyebvclIZ
         UNEI55J7NVQFrPfEfP+uJZyeKPR1KWs/8CfqV3qknNkHSYhPCtI1gXRzOAjfgS/Z+frs
         DHAo1vkfsXnwZWS9qWbMzm7FXLWlomQKoCigSIciTC/JTbqv9LiYTrRK11g/aHjMRCL9
         rBc8/1ZWL3PXTqNvu5bzhNOIZpH5WJyCwZPL0TY0ZHx2YTqBWw2YzXiahLnMBV9dTnFR
         S+DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792299194; x=1792903994; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qrO4duGPAc/tD1WFHTWuLBqHn5xfmNbJbvEpSmCkQPo=;
        b=TYaiMDi4RHEDKcn9MEfg59+BJVpOkFyc/V4w1O1SxcyBG+eKJ8wbS9/AyZ6B0p1EY1
         wsJNzW+yesyuXf36yAJ31DTKzFLv1/U+R57tX7C6vUslHTLfPiETMs4IWsxG3+pLqXXi
         hOGmMDKHh5wzMhDFjVA+df7dRt76E8oPcyXzXsI1IFzCxMgD32voUoJfDDbX1eNvcsBr
         UMdWMs03MiRhi+IjYnFWGqR8TZEqlWXz5DO8RdWAaYUfhKVjjUjYdNl+iYtHRAn7yyDW
         NT5GWgCaypeP9JAm0Kli7bbLmQzMJldzJpzMs51mK+PPO2EaLyvSQyfBwdNp644UC9vg
         wkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792299194; x=1792903994;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qrO4duGPAc/tD1WFHTWuLBqHn5xfmNbJbvEpSmCkQPo=;
        b=1t2+y5z5p1ofPR1Ih2mUuzT//lI2g9izbTf+p3fzsD9ciTiu/RjGXffuYkAsk+ZpRk
         7SLLOoLAvsOLtk0fwciNuQQUM2K+JLMj76tPTCb1lFyUEE/BDhQpos8O0Jv/RxY1muV8
         kLsDAB8ivoVk4Ap3iUyAA8oMCCFUlu/EJYhQRcNm+dB2D6NY+7pagm363VpgbDpKAldu
         tNbTHk4VH+6cinzheZilpswQkkdsZ/2jyDn00FnhUL1/W7EUMf7d8JakAqext/wsiOiy
         1qPuVgT+fXgpjbbpbjvaIjAKW0bBx3tij52xbQnBe/9h5CLR/qq5/kWRMv7IHGhVjdQY
         UCQg==
X-Forwarded-Encrypted: i=1; AKwUvBwLzNZrUca/6+3jt2RJ9SEjK1nyIDx/DHMEBw24iB7RUCIR4plr6R585fFTSPxuTzBKK7E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrs2DyoZ5EU5g4MXQON7jTuxc5BzSdKvapOpn1wLA4jEaVQaEz
	o0GOubyF9gBme3c9OSi1kDAw7s/dapVkTFm6HYhqXznADufAK6ONgbd3e5SPSZ4vCLPwHsP6D8Y
	adwpiRXSnTXHZj8UINHZhNTqVUc9bkMI=
X-Gm-Gg: AYBFou36qcIdytwUrV8I+VdO4A8JHVaskOkcNNxn9sv5/n8zMWwkVN4ArThdywJjh6d
	ESVAkZbFuzrUeJOLNsfwc9ALnijWb81aylvBXdu7TA0SkyFrurg1Dtm7kQA7pzFFSt6RwS9gow/
	AAjTKGa10YMKEXghpfSNExesCdWSJuw3QXJ8c/QYuqrxc+QzSLyAKTBMiD/xh01zX9d6+gUnZCo
	qnlu3YeWPr7rZlzp1LX5GqzK86Lf8hp5iHhv9cMIH40mQqVF9A9hRaAIkgEeXN5jk/KOPf+Z7rk
	zBfQ/S80yN7agfVHdm3yE6OwRLYWB3VX4fOZNSKXM8CY+/vLCFB8/F8=
X-Received: by 2002:a05:620a:1720:b0:93e:c173:f68d with SMTP id
 af79cd13be357-93f29d6cd52mr688939385a.33.1792299192782; Sat, 17 Oct 2026
 21:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-3-physicalmtea@gmail.com> <atIrLeH8uOCHxsbv@sgarzare-redhat>
In-Reply-To: <atIrLeH8uOCHxsbv@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Sun, 18 Oct 2026 12:52:36 +0800
X-Gm-Features: AclHuK_zKuZWLCNm5oTWLnrv1U5ZpQwQUlQXO3pg3MKjQRWyp6O9i0WbPsCftWM
Message-ID: <CAJwVaMJsBKZSVwaJqTEU_GCFrc2q7dEghMTykR5Jgrj+dv45=w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/4] vsock/virtio: amortize RX socket locking
 for stream packets
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bobbyeshleman@gmail.com
Content-Type: text/plain; charset="UTF-8"

>
> On Wed, Oct 14, 2026 at 07:56:38PM +0800, Jia Jia wrote:
> >The virtio-vsock RX worker currently looks up the socket and takes its
> >lock for every packet. Keep the socket lock and lookup reference across a
> >bounded run of STREAM/RW packets for the same established socket.
> >
> >Reuse the locked socket while packets continue to match the same flow.
> >End the batch for a different flow, non-RW traffic, malformed packets, or
> >a change in socket state, transport, protocol, or receive-buffer headroom.
> >A connected-table miss uses the existing receive path.
> >
> >The reused path still traces every packet, takes an skb owner reference,
> >validates the source and transport, updates credit, and runs the existing
> >receive state machine.
> >
> >Sockmap can replace the protocol without taking the socket lock. Check the
> >psock marker at each packet boundary and serialize initial admission with
> >sk_callback_lock, so a concurrent attach ends batching at the next packet.
> >
> >Cap a batch at 64 packets and 64K of payload. The packet limit bounds
>
> Why this cap?
>

The 64 KiB limit was chosen to bound one uninterrupted socket-lock
ownership interval to one VIRTIO_VSOCK_MAX_PKT_BUF_SIZE worth of
payload. For small or zero-length packets, the byte limit alone would
not bound the per-packet work, so a separate packet limit is needed. I
chose 64 packets as an initial batch size, using VHOST_NET_BATCH as a
reference. It is a policy choice rather than a protocol requirement.

Beyond these limits, a larger batch would only further amortize the
socket lookup and lock/unlock operations, while the virtqueue,
validation, tracing, skb ownership, credit update, and queueing work
remains per-packet. I therefore expect diminishing returns while the
uninterrupted socket-lock interval continues to grow, but I have not
measured larger limits yet.

> >per-packet work, while the byte limit bounds how much data can queue before
> >a reader acquires the socket lock. Batching remains in the process-context
> >RX worker.
>
> IMHO this patch should carry performance results.
>

Sure, I'll include the relevant Patch 1 - Patch 2 cumulative
performance results in this commit message in v5.

> >
> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >---
> > include/linux/virtio_vsock.h            |  11 ++
> > net/vmw_vsock/virtio_transport.c        |  29 +++-
>
> Why no changes in vhost-vsock or vsock_loopback?
>
> I'm not asking to do that, I'd like to understand why only in the
> driver.
>

I have not yet measured the corresponding worker and socket-lock
overhead in vhost-vsock or vsock_loopback, and they have different
worker and locking models, so I left those paths unchanged. I plan to
evaluate vhost-vsock separately as follow-up work.


> > net/vmw_vsock/virtio_transport_common.c | 183 +++++++++++++++++++++++-
> > 3 files changed, 216 insertions(+), 7 deletions(-)
> >
> >diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> >index f91704731057e..26dde6909c4ed 100644
> >--- a/include/linux/virtio_vsock.h
> >+++ b/include/linux/virtio_vsock.h
> >@@ -282,6 +282,17 @@ void virtio_transport_destruct(struct vsock_sock *vsk);
> >
> > void virtio_transport_recv_pkt(struct virtio_transport *t,
> >                              struct sk_buff *skb, struct net *net);
> >+
> >+struct virtio_transport_rx_batch {
> >+      struct sock *sk;
> >+      unsigned int pkts;
> >+      size_t bytes;
> >+};
> >+
> >+void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> >+                                   struct sk_buff *skb, struct net *net,
> >+                                   struct virtio_transport_rx_batch *batch);
> >+void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch);
> > void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
> > u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
> > void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
> >diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> >index 4f9aa9c4c3aa5..ef076732158d4 100644
> >--- a/net/vmw_vsock/virtio_transport.c
> >+++ b/net/vmw_vsock/virtio_transport.c
> >@@ -629,8 +629,16 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
> >       return seqpacket_allow;
> > }
> >
> >+/*
> >+ * Keep a bounded run of packets for one socket under a single socket lock.
> >+ * Limit packet count and payload size to bound the work done while locked.
>
> Here we should explain why we choose these values.
>

I'll update the comment here in v5 to explain why the 64-packet and 64
KiB thresholds were chosen.

> >+ */
> >+#define VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS    64
> >+#define VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES   (64 * 1024)
> >+
> > static void virtio_transport_rx_work(struct work_struct *work)
> > {
> >+      struct virtio_transport_rx_batch batch = {};
> >       struct virtio_vsock *vsock =
> >               container_of(work, struct virtio_vsock, rx_work);
> >       struct virtqueue *vq;
> >@@ -666,6 +674,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> >                       /* Drop short/long packets */
> >                       if (unlikely(len < sizeof(*hdr) ||
> >                                    len > virtio_vsock_skb_len(skb))) {
> >+                              virtio_transport_rx_batch_finish(&batch);
> >                               kfree_skb(skb);
> >                               continue;
> >                       }
> >@@ -673,6 +682,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> >                       hdr = virtio_vsock_hdr(skb);
> >                       payload_len = le32_to_cpu(hdr->len);
> >                       if (unlikely(payload_len > len - sizeof(*hdr))) {
> >+                              virtio_transport_rx_batch_finish(&batch);
> >                               kfree_skb(skb);
> >                               continue;
> >                       }
> >@@ -680,16 +690,33 @@ static void virtio_transport_rx_work(struct work_struct *work)
> >                       if (payload_len)
> >                               virtio_vsock_skb_put(skb, payload_len);
> >
> >+                      if (batch.sk &&
> >+                          payload_len > VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES -
> >+                                        batch.bytes) {
>
> Why this?
>
>

This pre-check ends the current batch before admitting a packet whose
payload would push it past the byte limit. The post-processing check
can end the
batch only after that packet has already been processed, so it cannot
enforce the limit by itself. I'll encapsulate and document this in the
common
batching code.

> >+                              virtio_transport_rx_batch_finish(&batch);
> >+                      }
> >+
> >                       virtio_transport_deliver_tap_pkt(skb);
> >
> >                       /* Force virtio-transport into global mode since it
> >                        * does not yet support local-mode namespacing.
> >                        */
> >-                      virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
> >+                      virtio_transport_recv_pkt_batch(&virtio_transport, skb, NULL,
> >+                                                      &batch);
> >+
> >+                      if (batch.sk) {
> >+                              batch.pkts++;
> >+                              batch.bytes += payload_len;
> >+                              if (batch.pkts >= VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS ||
> >+                                  batch.bytes >= VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES) {
> >+                                      virtio_transport_rx_batch_finish(&batch);
> >+                              }
> >+                      }
>
> Why this is not in the common part?
>

I put this in the driver because it owns the RX loop and its work
budget. But I agree that having the caller manipulate the batch
counters and active
state makes the interface harder to follow. I'll move the accounting
and limit checks into the common batching code in v5.

> >               }
> >       } while (!virtqueue_enable_cb(vq));
> >
> > out:
> >+      virtio_transport_rx_batch_finish(&batch);
> >       if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> >               virtio_vsock_rx_fill(vsock);
> > out_nofill:
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >index 61ee3bc205d5d..ff74e805527a5 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -576,11 +576,16 @@ virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,
> >       skb_queue_splice(&new_queue, &vvs->rx_queue);
> > }
> >
> >+static bool
> >+virtio_transport_rx_skb_has_headroom(struct virtio_vsock_sock *vvs)
> >+{
> >+      return (u64)(skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0) <=
> >+              vvs->buf_alloc;
> >+}
>
> Please move this change in a separate patch.
>
> skb_has_headroom() is confusing IMO, maybe
> virtio_transport_rx_buf_full(), but reversing the return value, so
> keeping the same check as before.
>

Sure, I'll move this into a separate preparatory patch

> >+
> > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> >                                       u32 len)
> > {
> >-      u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> >-
> >       /* Allow at most buf_alloc * 2 total budget (payload + overhead),
> >        * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
> >        * metadata. Check payload against buf_alloc to be sure the other
> >@@ -588,7 +593,7 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> >        * queue growth.
> >        */
> >       if ((u64)vvs->buf_used + len > vvs->buf_alloc ||
> >-          skb_overhead > vvs->buf_alloc)
> >+          !virtio_transport_rx_skb_has_headroom(vvs))
> >               return false;
> >
> >       vvs->rx_bytes += len;
> >@@ -1798,12 +1803,38 @@ virtio_transport_find_socket(struct sk_buff *skb, struct sockaddr_vm *src,
> >       return sk;
> > }
> >
> >+static bool
> >+virtio_transport_sock_has_psock(const struct sock *sk)
> >+{
> >+      return (uintptr_t)rcu_access_pointer(__sk_user_data(sk)) &
> >+             SK_USER_DATA_PSOCK;
> >+}
> >+
> >+static bool
> >+virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
> >+                                  struct sock *sk)
> >+{
> >+      struct vsock_sock *vsk = vsock_sk(sk);
> >+      struct virtio_vsock_sock *vvs = vsk->trans;
> >+
>
> A comment here to explain why some checks like...
>

I'll add why-focused comments for the condition groups in v5.

> >+      return sk->sk_state == TCP_ESTABLISHED &&
> >+             sk->sk_type == SOCK_STREAM &&
> >+             READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
> ... this       ^
>
> I mean in general to explain better these conditions (I mean not a
> description of what we are doing, but why we are doing these checks).
>

I'll add comments explaining these reasons.

> >+             !sock_flag(sk, SOCK_DONE) &&
> >+             vsk->transport == &t->transport &&
> >+             vvs && virtio_transport_rx_skb_has_headroom(vvs) &&
> >+             !virtio_transport_sock_has_psock(sk);
> >+}
> >+
> > /*
> >- * The caller holds sk's socket lock and must free skb if this returns true.
> >+ * The caller holds sk's socket lock.  Set @batchable if the socket can remain
> >+ * locked for another ordinary STREAM/RW packet.  Return true if the caller
> >+ * must free @skb.
> >  */
> > static bool
> > virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >-                               struct sk_buff *skb, struct sock *sk)
> >+                               struct sk_buff *skb, struct sock *sk,
> >+                               bool *batchable)
> > {
> >       struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> >       struct sockaddr_vm src;
> >@@ -1813,6 +1844,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >       vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> >                       le32_to_cpu(hdr->src_port));
> >
> >+      if (batchable)
> >+              *batchable = false;
> >+
> >       /* Listener sockets accept packets from any source and are not assigned to
> >        * a transport.
> >        */
> >@@ -1854,6 +1888,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >               break;
> >       }
> >
> >+      if (batchable)
> >+              *batchable = virtio_transport_recv_pkt_batchable(t, sk);
> >+
> >       return false;
> > }
> >
> >@@ -1894,7 +1931,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> >       }
> >
> >       lock_sock(sk);
> >-      free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk);
> >+      free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, NULL);
> >       release_sock(sk);
> >
> >       /* Release refcnt obtained when we fetched this socket out of the
> >@@ -1910,6 +1947,140 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> > }
> > EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
> >
> >+/*
> >+ * Finish the RX batch.
> >+ * For a non-empty batch, the caller must hold the socket lock acquired with
> >+ * lock_sock(). This function releases the lock and the batch's lookup
> >+ * reference.
> >+ * An empty batch is a no-op.
>
> What empty batch means, I mean how the caller can understand that a
> batch is empty?
>
> Maybe we should provide a function for that...
>

I'll add virtio_transport_rx_batch_empty() and document the
associated socket-lock and lookup-reference ownership.

> >+ */
> >+void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
> >+{
> >+      struct sock *sk = batch->sk;
> >+
> >+      batch->sk = NULL;
> >+      batch->pkts = 0;
> >+      batch->bytes = 0;
> >+
> >+      if (!sk)
> >+              return;
> >+
> >+      release_sock(sk);
> >+      sock_put(sk);
> >+}
> >+EXPORT_SYMBOL_GPL(virtio_transport_rx_batch_finish);
> >+
> >+void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> >+                                   struct sk_buff *skb, struct net *net,
> >+                                   struct virtio_transport_rx_batch *batch)
> >+{
> >+      struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> >+      struct sockaddr_vm src, dst;
> >+      struct vsock_sock *vsk;
> >+      bool batchable, start_batch;
>
> Ditto about declarations order, please check in the entire series.
>

Right, I missed this one too. I'll check and fix the declaration
ordering throughout the entire series in v5.

> >+      struct sock *sk;
> >+      bool free_pkt;
> >+
> >+      /* Only STREAM/RW packets can share a socket lock. */
>
> Why?
>
> Should the caller holds the lock for the entire batch?
> Should this be documented?
>

Yes. Once a batch is started, the receive helper returns with the
socket lock and lookup reference held, and the same caller retains
them until it calls the finish helper. That ownership contract is not
clear enough in the current interface, and I'll document it in the
public API in v5.


> >+      if (le16_to_cpu(hdr->type) != VIRTIO_VSOCK_TYPE_STREAM ||
> >+          le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_RW) {
> >+              virtio_transport_rx_batch_finish(batch);
> >+              virtio_transport_recv_pkt(t, skb, net);
> >+              return;
> >+      }
> >+
> >+      vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> >+                      le32_to_cpu(hdr->src_port));
> >+      vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
> >+                      le32_to_cpu(hdr->dst_port));
> >+
> >+      if (batch->sk) {
> >+              vsk = vsock_sk(batch->sk);
> >+              if (vsock_addr_equals_addr(&src, &vsk->remote_addr) &&
> >+                  dst.svm_port == vsk->local_addr.svm_port &&
> >+                  vsock_net_check_mode(sock_net(batch->sk), net) &&
> >+                  virtio_transport_recv_pkt_batchable(t, batch->sk)) {
> >+                      sk = batch->sk;
> >+                      trace_virtio_transport_recv_pkt(src.svm_cid,
> >+                                                      src.svm_port,
> >+                                                      dst.svm_cid,
> >+                                                      dst.svm_port,
> >+                                                      le32_to_cpu(hdr->len),
> >+                                                      le16_to_cpu(hdr->type),
> >+                                                      le16_to_cpu(hdr->op),
> >+                                                      le32_to_cpu(hdr->flags),
> >+                                                      le32_to_cpu(hdr->buf_alloc),
> >+                                                      le32_to_cpu(hdr->fwd_cnt));
> >+                      if (!skb_set_owner_sk_safe(skb, sk)) {
> >+                              WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> >+                              virtio_transport_rx_batch_finish(batch);
> >+                              kfree_skb(skb);
> >+                              return;
> >+                      }
> >+
>
> This code is unreadable TBH, there isn't a blank line till here...
> and too much nested blocks.
>
> Maybe you should move this in a function, and use a bit more blank lines.
>
>

I'll move the active-batch path into a helper, reduce the nesting with
early returns, and add blank lines between the logical steps.


> >+                      free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk,
> >+                                                                  &batchable);
> >+                      if (!batchable)
> >+                              virtio_transport_rx_batch_finish(batch);
> >+                      if (free_pkt)
> >+                              kfree_skb(skb);
> >+                      return;
> >+              }
> >+
> >+              virtio_transport_rx_batch_finish(batch);
> >+      }
> >+
> >+      sk = vsock_find_connected_socket_net(&src, &dst, net);
> >+      if (!sk) {
> >+              virtio_transport_recv_pkt(t, skb, net);
>
> Why this?
>

If you mean the fallback to virtio_transport_recv_pkt(), my
understanding of the lookup semantics is that it is needed because the
batching fast path only
looks in the connected table, as only an established connected socket
is eligible for batching. A miss there can still match a bound socket,
so the packet
must follow the existing receive path rather than being treated as
having no socket. Please correct me if I have misunderstood this.

> >+              return;
> >+      }
> >+
> >+      if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
> >+              sock_put(sk);
> >+              virtio_transport_recv_pkt(t, skb, net);
> >+              return;
> >+      }
> >+
> >+      trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
> >+                                      dst.svm_cid, dst.svm_port,
> >+                                      le32_to_cpu(hdr->len),
> >+                                      le16_to_cpu(hdr->type),
> >+                                      le16_to_cpu(hdr->op),
> >+                                      le32_to_cpu(hdr->flags),
> >+                                      le32_to_cpu(hdr->buf_alloc),
> >+                                      le32_to_cpu(hdr->fwd_cnt));
> >+
> >+      if (!skb_set_owner_sk_safe(skb, sk)) {
> >+              WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> >+              kfree_skb(skb);
> >+              return;
> >+      }
>
> We have this code duplicated in several place now, can this be avoided?
>

Yes. I'll extract the trace and skb owner setup into a small shared helper.

> >+
> >+      lock_sock(sk);
> >+      /*
> >+       * Sockmap removal restores the native protocol under sk_callback_lock.
> >+       * Serialize this initial eligibility check with that update.
> >+       */
> >+      read_lock_bh(&sk->sk_callback_lock);
> >+      start_batch = virtio_transport_recv_pkt_batchable(t, sk);
> >+      read_unlock_bh(&sk->sk_callback_lock);
> >+
> >+      free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk,
> >+                                                  start_batch ? &batchable : NULL);
> >+      if (start_batch && batchable) {
> >+              /* Keep the lookup reference until the batch is released. */
> >+              batch->sk = sk;
> >+              return;
> >+      }
>
> Ah, this is for the first run, when the batch is empty, right?
>
> Can you merge in some way both branches?
>
> BTW please add some more useful comments (explaining why)
>

Yes. I'll merge the common parts of the two paths and add comments
explaining the remaining differences and why they are necessary.


> >+
> >+      release_sock(sk);
> >+      sock_put(sk);
> >+      if (free_pkt)
> >+              kfree_skb(skb);
> >+}
> >+EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt_batch);
> >+
> > /* Remove skbs found in a queue that have a vsk that matches.
> >  *
> >  * Each skb is freed.
> >--
> >2.53.0
> >
>
