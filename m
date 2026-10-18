Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440D835F8C5
	for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 04:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792298595; cv=pass; b=RALyJH76EuZfiJE/5UxeUfHoEODFC9VHkocZbQiaGlUK92Fp1K798COjpdTdAu00IJhCXt5zw904+uavZYoUzmev5jt0tG2B/lyfnB4JAnebHexcm12eqnS7wiJD95Po/OrJqWPBZPlNYGe5TJI1P98CbK9oznIF+Yon+Wp42LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792298595; c=relaxed/simple;
	bh=DHpt0emLBDEXhg01inCWP8u2BhRmbxlc7aC04HKyBeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWrHGQUO6400/UAsS6G1EuccB6CFQHhLZdbVdn7Rn3ItQogI7F8gGVDZniDPMBGnQS9Zra8gyEd5g8Tq2mmiHYNkJxQGq23b0kF94tgbr+qJ27F5eM4OTI8YG59U6bSYR+wtzJJWB9PdXFPNTHq7bBLAzBRtcnqqU/DQP7LfJtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QazQzvUt; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QazQzvUt"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91b83459526so14949096d6.2
        for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 21:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792298587; cv=none;
        d=google.com; s=arc-20260327;
        b=cCVE7gZYGa1y1DoytT9Cwk2Lc5E8uz9sta6IOuCmbbnibWn6VfkF9tRem2ik7quz/1
         8cLIhH0p27zuRGbQmoqXlHCHPfZD7MPsNhc++JsU5L1XgXrrtpPMCE+1XYI7iTvmDsRG
         FR5bMFcvIY8jBOdFJcFAck/pAdWS0+pUrD1Zhpd/4eZYddvSM2dMkO0A1b7WoJl9dXR+
         +TFTkrsC0fwuXcma0V+J4r4yPaIQjDFgnK3Awc9GGGdXAXsPtM1GV/k3E1prl2lTgkSt
         yxVGQ465CPsOdqDnKNv57olIcfTMLhLnLxCX7AOyDshbpbMcfZ0qkAjtpsaEP2A/ZySP
         7bRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TCd4vJVysPs+rmx1m3RvczNkQ2iSpfMjw8JApMQr1io=;
        fh=UjTnPElwcjggRKrvQoQtvZwZQBlsdeJqTDBcvVSmlYo=;
        b=FT0qPO6hyOgGplKkgbvnTc4IhZORLpgtdJeKeZyTLHrQw1ltl05+GQJez3vlWkXFS2
         8fn8QIF1ZauXAPrGQRQY7MQJRZy3SoIb8fP9gzVyfhYHCj9cxVRSJZ/eBNa4whYhgXlH
         VP+9Rbp5xbptKIcDHgbBesXbjHvuNLNxhUJxCyEH0zbJ3HyVe/2nGtb53trS9+e8h6l3
         +5+MHnB7jyvhj8ZhLB0SiGQOyqxXfENx0rnkXOnnQWLa26HUNCVn7FfJt1u3KE22y6i6
         ofNi7Muio/aRCGqhOirnbSjkBkFuUEZpk78HyA6QDe9GE2k9ZLlZS9ZNZngNjoiNMQzj
         yOGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792298587; x=1792903387; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TCd4vJVysPs+rmx1m3RvczNkQ2iSpfMjw8JApMQr1io=;
        b=QazQzvUtDkxjlnkXd7Dc4Q3ge6a0E9Pcu+129KI0o3/+btcboUKlA5M+F3R66tDPct
         vjIr5eHi8LF8GQC+EY2834iNwUJ04ZhqapiuflLdS+eFnWma9oSqPwY+Iti2pDrIqyeN
         p3Ukamag+aGoIHuVcKRjMS/DUi3d297CdwhomOiGoQ1gfZuYRO0KcpT+Yy1aH4WVjvK8
         +YfwXfy8LUOAGcZ/o11Kc15e261H2tcNh+LGf96etmOkUrUIJSf3ek5jYyHgSQxVvSYh
         Byq8qqDo/IT3s7Q8itFIdYR+G3VF9JMNCPIPBVEg+bN3EY7cx5rIRJ4xWSrHd78FzRNu
         R43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792298587; x=1792903387;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TCd4vJVysPs+rmx1m3RvczNkQ2iSpfMjw8JApMQr1io=;
        b=KpZGhvUF1uXdzE4mc92F9cVLUXH3h7R1Le1V103kDvEPLznCq63o9Kd2LNaYIqpd/G
         h76OsWW3OGbAhzARxXuxslMNjtAmBPySc9nTU1UeyA8XIWkZ7DE4n122OaUuU5vvyPL+
         Ch/daCp3XjNR194photpAyq3y18f0LKFyHM/oHaC21BsjEXm5hPqxQ506ndkRVKe3cOn
         RfRuFQ0tJlQ6SlNQouuujmjBmqlpfOWb95V9zqv31Go+5CJ4o+kR07ped2OGzw2W6Ts4
         sEaiw29ydg4L5HaIJbr/WOhVvAXCeciZpeh2x8x9OcvYCpd/1RIs/Y1ravBj/+riyhkT
         Itog==
X-Forwarded-Encrypted: i=1; AKwUvBxKYhrpdJGXgNeGDPqNJQdLSY32OAwLYPTC4NMtNON/gzWQMXY79VTSlMZXDeOtgwhqfNw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJXTokndOmqpHTJK83bdFLN/nY+oBGmuyxmxZcREaGv3UZTZmY
	9aUPHlzkSrDWOMh0s/9IINpXTe1YSuC4kZS+KTqow5yRbxxP2CvDVN/X4spstN8/nDspC39VNBT
	VuNhUf2mAHKzll8zfK9HsCPgO49W2RHE=
X-Gm-Gg: AYBFou0Xi0xPQdBdxbC/3zzZ22b85BAJ9XNLgV00bhCzlMvCUAeFRAuPbF7AdZs505I
	0dPmqSTi0KWwUMzzETGtqC+kvRV9Pjf+VNvwhEzmq0EkDAeOJkBaONrdwTHYBEqSZH41Ly6gwaX
	gGCUI3PhkkxpxBzkS/tum7p1caRHj5qph/VvxEQFpFtpur36/1xxn9qea8HCmJcvKPoDoi9Yytr
	9I21aYEDEnBmUQqdxKqj+/cYpNAt1cOckgzuMvqiaNnwnTF8haGWDgc5iKq47662RgIw1HWVRFF
	hOztExwMMVzrxW5W+AdOXO+vemaI0V2CMSlXbUbaTYmzt4YfO/6sbvE=
X-Received: by 2002:a05:620a:260a:b0:93c:b6db:8c with SMTP id
 af79cd13be357-93f299f3829mr676090985a.0.1792298586112; Sat, 17 Oct 2026
 21:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-2-physicalmtea@gmail.com> <atImp74JbTbEb0d_@sgarzare-redhat>
In-Reply-To: <atImp74JbTbEb0d_@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Sun, 18 Oct 2026 12:42:29 +0800
X-Gm-Features: AclHuK8Ob-l6fq4mltZ_vIa4jBsMb_PwAPuMxfSzbBTGRIF1RfJPYptCeSCMlpA
Message-ID: <CAJwVaML2F6vN5xGsmvd1PwD3ToLOeV_PfzJrArvan8gvbveKuA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/4] vsock/virtio: split socket lookup from
 locked RX processing
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bobbyeshleman@gmail.com
Content-Type: text/plain; charset="UTF-8"

>
> On Wed, Oct 14, 2026 at 07:56:37PM +0800, Jia Jia wrote:
> >Split virtio_transport_recv_pkt() so socket lookup is separate from
> >receive state machine processing under the socket lock. This prepares the
> >receive path to keep a looked-up socket across multiple packets in a later
> >change.
> >
> >Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
> >The locked helper obtains packet-specific addresses from the skb and uses
> >the matched socket namespace for reset replies. Preserve source validation
> >and failure handling.
> >
> >No functional change intended.
> >
> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >---
> > net/vmw_vsock/virtio_transport_common.c | 128 ++++++++++++++----------
> > 1 file changed, 75 insertions(+), 53 deletions(-)
> >
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >index f225f53ed4bab..61ee3bc205d5d 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -1774,81 +1774,60 @@ static bool virtio_transport_valid_type(u16 type)
> >              (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
> > }
> >
> >-/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> >- * lock.
> >- */
> >-void virtio_transport_recv_pkt(struct virtio_transport *t,
> >-                             struct sk_buff *skb, struct net *net)
> >+static struct sock *
> >+virtio_transport_find_socket(struct sk_buff *skb, struct sockaddr_vm *src,
> >+                           struct sockaddr_vm *dst, struct net *net)
> > {
> >       struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> >-      struct sockaddr_vm src, dst;
> >-      struct vsock_sock *vsk;
> >       struct sock *sk;
> >-      bool space_available;
> >-
> >-      vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> >-                      le32_to_cpu(hdr->src_port));
> >-      vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
> >-                      le32_to_cpu(hdr->dst_port));
> >-
> >-      trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
> >-                                      dst.svm_cid, dst.svm_port,
> >-                                      le32_to_cpu(hdr->len),
> >-                                      le16_to_cpu(hdr->type),
> >-                                      le16_to_cpu(hdr->op),
> >-                                      le32_to_cpu(hdr->flags),
> >-                                      le32_to_cpu(hdr->buf_alloc),
> >-                                      le32_to_cpu(hdr->fwd_cnt));
> >
> >-      if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
> >-              (void)virtio_transport_reset_no_sock(t, skb, net);
> >-              goto free_pkt;
> >-      }
> >+      if (!virtio_transport_valid_type(le16_to_cpu(hdr->type)))
> >+              return NULL;
> >
> >-      /* The socket must be in connected or bound table
> >-       * otherwise send reset back
> >-       */
> >-      sk = vsock_find_connected_socket_net(&src, &dst, net);
> >-      if (!sk) {
> >-              sk = vsock_find_bound_socket_net(&dst, net);
> >-              if (!sk) {
> >-                      (void)virtio_transport_reset_no_sock(t, skb, net);
> >-                      goto free_pkt;
> >-              }
> >-      }
> >+      sk = vsock_find_connected_socket_net(src, dst, net);
> >+      if (!sk)
> >+              sk = vsock_find_bound_socket_net(dst, net);
> >+      if (!sk)
> >+              return NULL;
> >
> >       if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
> >-              (void)virtio_transport_reset_no_sock(t, skb, net);
> >               sock_put(sk);
> >-              goto free_pkt;
> >+              return NULL;
> >       }
> >
> >-      if (!skb_set_owner_sk_safe(skb, sk)) {
> >-              WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> >-              goto free_pkt;
> >-      }
> >+      return sk;
> >+}
> >
> >-      vsk = vsock_sk(sk);
> >+/*
> >+ * The caller holds sk's socket lock and must free skb if this returns true.
>
> Why the skb must be freed by the caller and not by this function itself?
>

You're right, it doesn't have to be. I originally left the skb cleanup
to the caller so it could unwind either per-packet or batch state
while preserving
the existing error-path order (release_sock() -> drop the lookup
reference -> kfree_skb()).

However, that distinction does not require skb ownership to escape the
helper, and the resulting ownership contract is confusing since the
other paths
consume the skb internally. I'll make the helper consume it directly in v5.


> >+ */
> >+static bool
> >+virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >+                               struct sk_buff *skb, struct sock *sk)
> >+{
> >+      struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> >+      struct sockaddr_vm src;
> >+      struct vsock_sock *vsk = vsock_sk(sk);
> >+      bool space_available;
>
> Please, follow the netdev convection for ordering local variables:
> https://www.kernel.org/doc/html/v7.2/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs
>

Sorry about that. You had pointed me to this guideline before, and I
missed this during the final preparation. That's entirely my
oversight, and I will fix the declaration ordering throughout the
series in v5.


> >
> >-      lock_sock(sk);
> >+      vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> >+                      le32_to_cpu(hdr->src_port));
> >
> >-      /* Check if sk has been closed or assigned to another transport before
> >-       * lock_sock (note: listener sockets are not assigned to any transport)
> >+      /* Listener sockets accept packets from any source and are not assigned to
> >+       * a transport.
> >        */
>
> Why changing this comment in this commit?
>
> Oh because we moved out lock_sock, right?
>
> I think we should keep in some way the old info that was much more
> informative that the current comment that just say what the check is
> doing and not why.
>

Yes, I changed it because lock_sock() moved to the caller, so the old
wording no longer read clearly at that location. But I over-shortened
it and dropped the important reason for the recheck. I'll restore that
explanation:


> >       if (sock_flag(sk, SOCK_DONE) ||
> >           (sk->sk_state != TCP_LISTEN &&
> >            !vsock_check_source(vsk, &t->transport, &src))) {
> >-              (void)virtio_transport_reset_no_sock(t, skb, net);
> >-              release_sock(sk);
> >-              sock_put(sk);
> >-              goto free_pkt;
> >+              (void)virtio_transport_reset_no_sock(t, skb, sock_net(sk));
>
> We need to be careful here, IIRC Bobby used the net from the caller for
> a reason.
>
> Are you sure it's fine this change? Why not passing net as parameter and
> minimize changes?
>

I assumed sock_net(sk) was interchangeable with the caller's net after
a successful lookup, but I took that equivalence for granted. I'll
change this in v5.

> >+              return true;
> >       }
> >
> >       space_available = virtio_transport_space_update(sk, skb);
> >
> >       /* Update CID in case it has changed after a transport reset event */
> >       if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> >-              vsk->local_addr.svm_cid = dst.svm_cid;
> >+              vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
> >
> >       if (space_available)
> >               sk->sk_write_space(sk);
> >@@ -1870,17 +1849,60 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> >               kfree_skb(skb);
> >               break;
> >       default:
> >-              (void)virtio_transport_reset_no_sock(t, skb, net);
> >+              (void)virtio_transport_reset_no_sock(t, skb, sock_net(sk));
> >               kfree_skb(skb);
> >               break;
> >       }
> >
> >+      return false;
> >+}
> >+
> >+/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> >+ * lock.
> >+ */
> >+void virtio_transport_recv_pkt(struct virtio_transport *t,
> >+                             struct sk_buff *skb, struct net *net)
> >+{
> >+      struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> >+      struct sockaddr_vm src, dst;
> >+      struct sock *sk;
> >+      bool free_pkt;
> >+
> >+      vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> >+                      le32_to_cpu(hdr->src_port));
> >+      vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
> >+                      le32_to_cpu(hdr->dst_port));
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
> >+      sk = virtio_transport_find_socket(skb, &src, &dst, net);
> >+      if (!sk) {
> >+              (void)virtio_transport_reset_no_sock(t, skb, net);
> >+              goto free_pkt;
> >+      }
> >+
> >+      if (!skb_set_owner_sk_safe(skb, sk)) {
> >+              WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> >+              goto free_pkt;
> >+      }
> >+
> >+      lock_sock(sk);
> >+      free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk);
> >       release_sock(sk);
> >
> >       /* Release refcnt obtained when we fetched this socket out of the
> >        * bound or connected list.
> >        */
> >       sock_put(sk);
> >+      if (free_pkt)
> >+              kfree_skb(skb);
> >       return;
> >
> > free_pkt:
> >--
> >2.53.0
> >
>
