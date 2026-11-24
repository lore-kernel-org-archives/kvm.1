Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522900;
	b=G5t7c7TlCrhbv1zBr+H42ZGh60f4vZX1jr2p8kn49fyewvnm78+/sscdy79F16DeowII
	 ZBXudImgaI4R35wYQ7YfxsjATjYWPqz6FtzF/BgXvemkEngNlwyToj3eY/OSsASLwTCBN
	 QZvio8Mhqvp9NWIHCy3sHe3bQLFqSx/LBqBKaP/v9+TZPoaV75osgMMZkUGkTvnLREwJJ
	 ODwoV+CFc77A6VURdxTMn6+QISeeMreQRcjafBgGw+chWB8AHDwxbCpkQSbt56LhjZ49J
	 ADsRVZ7VASqAjSkeLSdMnAs9KJcQ0OnLDEKDT/PLifUhrLkbkaesYy4sthZ2h6J9NtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522900;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
	b=DJL8OQgUTzaHoXlLXTKPdNiDrlgu9pqD66WqTShRLwwMR7rjuTQXfwQwoJjieSzE1Msr
	 S8nkubCpt2O5gazDNETBK2fyERmiOrugmCN6y54UMFxkAyCowNPd/bWBIzPgt9qntX/LM
	 bbyBlv8ojDHYNwDdLypTcsCildmyn//pIUCgo0fyuwTPFJxsSBN51vjGGDHWUQYz627v0
	 Sk8IFWu6NGytn9T72Mn7UubbQHG4RE3/cp7iBGfjuxu+W1Y8bDtu7RodBNuaSosag0SIB
	 w6wpik6ijwWchnmjIlM51f8B9Xbk6iaEwSGrJu/MrNgwONDFKGNqoJKvEgGAxkwByRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rm0cXtLN;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="H8V/jAko";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E3C606A68E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 12:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64E3C606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rm0cXtLN;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=H8V/jAko
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795522898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
	b=Rm0cXtLN1MpqBh5FEF1xF1yDA+4n6qaTJZXmKm8rGKeHi3PM3msGSDwaNxjEtid+JriI8f
	qqXLprD3Bc4OFjTFK0cfIBdp5CYBS1Q0ZGAHUtNOrrsROdpWNWnhxLNXJIoYZIrRMet56j
	AGy3Lo/8NXNpP1+kZrN+8QrSCGCB9XE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-QnuVNVZAOtmbcQaoc3quhg-1; Tue, 24 Nov 2026 12:21:37 +0000
X-MC-Unique: QnuVNVZAOtmbcQaoc3quhg-1
X-Mimecast-MFC-AGG-ID: QnuVNVZAOtmbcQaoc3quhg_1795522896
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4a9be7586ccso2262753f8f.0
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 04:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795522896; x=1796127696; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
        b=H8V/jAkoh9Shjj6NPLmvFlrMxocRT1dn2vScjn6RxzmrcX0d+E248Xa6rQm3j5mFNW
         h36cMd1/cbladxc0dBlKRtiK57PGWgRpyfTFQds0KBEUJ101kAF5i2/36W9n9ba5nEu2
         xDsBPs3XYj5hQV5bNIEbgY5SPv3V1CVW5l6tO+nnDAJnAXNssvOfFBXJ36pgFt9HwEiY
         id5fCMaeGb4Fhr1mgVlK6PPGgCYa6u9DI9LTne5UsBUxyB+4us4slsdai5U49TpSyzv9
         7EH7/NNNBjfwGObxSJOttYeVR4CfAMFHo9TTWm0oPdbhWZWzQijNVbAPLMyUI82f2pcH
         3H+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522896; x=1796127696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TzwipR1LCMAEarIzxU+ebA22tLIFqbxvhpauSxtFZxw=;
        b=P1EAHWq8Jj6VKkNiUxF3UgkZgeu2FZXZ5jrdFgP3BdrZHqwJfaKWJ1PdA8TZ9ZVnJR
         dOIivAPiqVQJn9yzJgl0qdrpuzCZ72HDH0B6fFdOrvqJSzVycw2ESn01rOUviVYZkREi
         YjwwAe0IzdSblY0vxZWTdggh38eeElarDwCWsAp92ZiSXrTvrpkvy6ERKc/cAQf1VGdr
         SZJMsCTRruieP/uHe0n4E9cX05cp8D9dv5vc0xzgdFG4nyA/rT8N0Ffba5GpuRWvjDMg
         vOJ5BFcrX5RlTc9rnA1Z7qyKfdb0MfpBPzfwfCdICbvD45cpHhZ5f17GL2aWjT+5W39Q
         +G1Q==
X-Forwarded-Encrypted: i=1; AL+hErE1QXZYT6j1iI5nTxm+mSpa1TisJvvXNSyCFQoTjFwQI9NnVK/Edh9waivre+6NmIe/638=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lz4/501DSu8K6KAZOtmHftjYmeFnvZku0gjaT8DBisKPX/HCV
	Jxd66PUv9A7YciuJxg538GGuA4smCwlrwdB+dE32DEq7+xUMQnDV8eQhL3C4HExk80EoXpp95as
	0ysh2eyw+lpWzNaQxd4+9Dc283Y1bggD+9p5UQx+5UgYwayGQnscYOQ==
X-Gm-Gg: AZFdTZd3LYV0NUgYpbmwx/SevNM8q+Zu1sU3L2xxIMMkCw2wfbzLvblnv6+tmJmPqkY
	KYJXxmaDTgjfDBOp6cmAT1P4utOY77qzloyL6nv8w0lM28sip6DoIH3lWvO/aMi1+vnKbmnXUge
	ilgvMw3hHoBxW9K96T0wYXvrkXFXRahlz0OgLdAu8H1uTozdf04imF7IWEDqIsW6alnoBKQMDya
	EG8YoyNPVopFsUMGPJxYf+ddOs6ivScXDzGz3S4+b1HrIIvXmKqrMQ5Nyv24Cc6/48sK2aeLK5U
	+qngD7aF6Mvbv/wLKqGvsGuLqXX9g0lKlhqCOLsnLxMll15sKvoyzl7XsaiLOAjrw8v1IjgL1AY
	zTwce3VFwv+luwvWk9u3ORt45+Yzzrm/MneBk8J9wgU7sorVm3JQcIcDBdS/0xQSgxqQkXer2Ad
	ixD7FBVVAa8lk=
X-Received: by 2002:adf:e00c:0:10b0:4a9:6c58:1794 with SMTP id ffacd0b85a97d-4abb0b66bfbmr20062058f8f.10.1795522895777;
        Tue, 24 Nov 2026 04:21:35 -0800 (PST)
X-Received: by 2002:adf:e00c:0:10b0:4a9:6c58:1794 with SMTP id ffacd0b85a97d-4abb0b66bfbmr20061998f8f.10.1795522895343;
        Tue, 24 Nov 2026 04:21:35 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110ba3sm22753198f8f.35.2026.11.24.04.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:21:34 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Tue, 24 Nov 2026 13:20:20 +0100
Subject: [PATCH RFC v4 2/8] vsock: report datagram receive and send queue
 state
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-vsock-dgram-support-v4-2-3607484e85e8@redhat.com>
References: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
In-Reply-To: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 linux-doc@vger.kernel.org, Sashiko AI bot <sashiko-bot@kernel.org>, 
 Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4270; i=slp@redhat.com;
 h=from:subject:message-id; bh=DAGnzS4beIxvhBc5LWV62Y4RCwEPeEYebUU+gVLqZ9Q=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBrBYFDM0alN2qcB2uN4zvRdHQFPo6uBvEPQ9IoP
 7IXAHpQ1uGJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCawWBQwAKCRD0aSeNLwwC
 NWJyD/44s7CCvnIfT0+tJ3gDVvgHW2kGx/HIvC6vIhUFdUwaB4b7MkZLyBshjtahlGFOlshLTuY
 ow/X1/NpwQcGM4B8xChp9k6ohdYWRBFVtq7B338KPsfiiTo+6PELxlOXjGUmpQr+AmMQACmCiFa
 xXBT0v2dGfywk/SU42+Uy+ErfSkNh0z2BKMwQyfcNbD+bOV2UY97+Hk1EGbmKZj1/2TfU8a5xBX
 iamcB1oTr3FJtt9LIYrgJeuszuq3ZFy3zlFk3VSatzgaSEEpV1d/ULS5jjLgPDDCXagO9F3Y7hS
 G1vXj7H7QZ7mSs4b37bgPMcrsv5jkMCp5adznc+DLkOTrN0oGL3FuyPPJeB5To1I9C907U8YZAO
 j/8+TRIEITbFARS31o5OLIShXeSS0I9Ckzgagv/ykEYWOdR53sy+upqVpP2svj0zP4UXJTmMbzP
 ec/lvuViSv0xOnR/kgyVDT5ngLpYw+eTYFR9M2nfpveZD7NY67T8IteY11MhinqubZzQKYLw+I8
 1H8SiRk2kvi6D6tjEFEplZcdR4041IDA7C5kIWrwB20+8wMTnJwBnkICA6nxrZC8+/sqbsV7fZj
 BxN6w8I1EYQxYkQ7TTBNoJE65G8BPvDgVKNx7cE7MB2HLMieKCo+h+sD4u8CHDVBjbSAzaLgTdI
 f7oadBmJ3O/SWsQ==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Datagram receive queues hold whole messages, and transports may charge
queued datagrams to the socket send buffer. Report the size of the
next datagram payload for SIOCINQ under the receive-queue lock, so
concurrent recvmsg() cannot free the skb during the query. Let
transports override the length calculation to exclude headers such as
VMCI's.

Report datagram write readiness only while the send buffer has space.
Set the asynchronous no-space flag when it is full so freeing pending
send buffers can wake poll waiters.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 include/net/af_vsock.h         |  2 ++
 net/vmw_vsock/af_vsock.c       | 32 ++++++++++++++++++++++++--------
 net/vmw_vsock/vmci_transport.c |  9 +++++++++
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index ac061115ed30..e4fbea3b0e46 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -124,6 +124,8 @@ struct vsock_transport {
 	int (*dgram_enqueue)(struct vsock_sock *, struct sockaddr_vm *,
 			     struct msghdr *, size_t len);
 	bool (*dgram_allow)(struct vsock_sock *vsk, u32 cid, u32 port);
+	/* Optional payload length override, called with the receive queue locked. */
+	size_t (*dgram_payload_len)(const struct sk_buff *skb);
 
 	/* STREAM. */
 	/* TODO: stream_bind() */
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d5cf240d4ece..8a271eb66860 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1359,16 +1359,20 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 		mask |= vsock_poll_shutdown(sk, peer_shutdown);
 
 		/* For datagram sockets we can read if there is something in
-		 * the queue and write as long as the socket isn't shutdown for
-		 * sending.
+		 * the queue and write if the send buffer has space and the
+		 * socket isn't shutdown for sending.
 		 */
 		if (!skb_queue_empty_lockless(&sk->sk_receive_queue) ||
 		    (sk->sk_shutdown & RCV_SHUTDOWN)) {
 			mask |= EPOLLIN | EPOLLRDNORM;
 		}
 
-		if (!(sk->sk_shutdown & SEND_SHUTDOWN))
-			mask |= EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND;
+		if (!(sk->sk_shutdown & SEND_SHUTDOWN)) {
+			if (sock_writeable(sk))
+				mask |= EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND;
+			else
+				sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
+		}
 
 	} else if (sock_type_connectible(sk->sk_type)) {
 		const struct vsock_transport *transport;
@@ -1632,10 +1636,22 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
 			break;
 		}
 
-		n_bytes = vsock_stream_has_data(vsk);
-		if (n_bytes < 0) {
-			ret = n_bytes;
-			break;
+		if (sk->sk_type == SOCK_DGRAM) {
+			struct sk_buff *skb;
+
+			spin_lock_bh(&sk->sk_receive_queue.lock);
+			skb = skb_peek(&sk->sk_receive_queue);
+			if (skb && vsk->transport->dgram_payload_len)
+				n_bytes = vsk->transport->dgram_payload_len(skb);
+			else
+				n_bytes = skb ? skb->len : 0;
+			spin_unlock_bh(&sk->sk_receive_queue.lock);
+		} else {
+			n_bytes = vsock_stream_has_data(vsk);
+			if (n_bytes < 0) {
+				ret = n_bytes;
+				break;
+			}
 		}
 		ret = put_user(n_bytes, arg);
 		break;
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 1f186e8f8364..2b9493e987d1 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1761,6 +1761,14 @@ static int vmci_transport_dgram_enqueue(
 	return err - sizeof(*dg);
 }
 
+static size_t vmci_transport_dgram_payload_len(const struct sk_buff *skb)
+{
+	if (skb->len < sizeof(struct vmci_datagram))
+		return 0;
+
+	return skb->len - sizeof(struct vmci_datagram);
+}
+
 static int vmci_transport_dgram_dequeue(struct vsock_sock *vsk,
 					struct msghdr *msg, size_t len,
 					int flags)
@@ -2075,6 +2083,7 @@ static struct vsock_transport vmci_transport = {
 	.connect = vmci_transport_connect,
 	.dgram_bind = vmci_transport_dgram_bind,
 	.dgram_dequeue = vmci_transport_dgram_dequeue,
+	.dgram_payload_len = vmci_transport_dgram_payload_len,
 	.dgram_enqueue = vmci_transport_dgram_enqueue,
 	.dgram_allow = vmci_transport_dgram_allow,
 	.stream_dequeue = vmci_transport_stream_dequeue,

-- 
2.56.0

