Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203501;
	b=QDz+GjmpHTMNmm2DRaKFr/hgXVnUSVtxNH/XNuaocVuIW8vZBWszSFXnis3LUk+KHLmN
	 IStx2AGaxljscnWzgtL07Z544RmZ8rAlc6Xcnay3hFXy+FAFsCkJKHTRHYKMpH2jJwFwJ
	 c3X7LpwtE76qUyjBScKEOdg26MByUVmcxJ48bVlnVnsNgEMWrBlRlsPL0ZCsEFBnIaw6t
	 3T+NAVWcmpc4KswV0DuRdw3EHFn2cu+OhIeNqaykkhjWfgaJJABdgLy6N+DoT2c9EPneK
	 Mzo09Ss/BDNxbByUNjLH2YxZCgUh18MPUhxXV9J6ZA/sUtwhPxIlLe6iH+jk4bevt9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203501;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=VToKcD9exB05u0wmkPQ4zmuhJE5oZK966jaJjguWNd0=;
	b=OpjC55K9ojkLNIikbTzm1t6iLvpQVn15JJUTJkPPQ37FD5nDE4gU9h95MMC3tl878Ao7
	 wHZ0OT4Wjt0q6OLV1QAE2fDSbDcG4Ny9xURhBVNzZCFBiVLeKBun7GeX7APR2/Q8AQ9Xx
	 AdEOUYuDTUoz94N2faYfOhoTJVCHPAuLgiJQjDPcIi+1A8JEIqf35wCp6+IfQ1OUawdRd
	 xaqIINp0fUlhWIVpNa1cf2cbLZ8TnIp7axL1tF1nLyV4rBDjQrx0BN4DSfm8aRdE5sCy+
	 mM4WbRYUgZ6IoD9W7adKPPq/Jd9yO5nLE/NQJdLmDR9gsW4OxMuArthKln+9rNpgYfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MhQ9bZSm;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KGBYMdmx;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A560A261F
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 16:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A7A560A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MhQ9bZSm;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KGBYMdmx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793203500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VToKcD9exB05u0wmkPQ4zmuhJE5oZK966jaJjguWNd0=;
	b=MhQ9bZSmE67o3+Uj403RkIxRj8Ir5+xiC+v/j3r7WvXl7ll3V3h1jZ82JGqGpG/abjvfML
	KgCD7EbFnrGPUYKO3L3jdEXUphlq7O8Y3mrJky4a+Dnq7v2tC3KuPBJPTVOYNGdWCiipwP
	F1tB8R2oUV7xrJZzogZQ4H35djisCOk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-T0iiPkT3NTqXnVDGsMp_lg-1; Wed, 28 Oct 2026 12:04:59 -0400
X-MC-Unique: T0iiPkT3NTqXnVDGsMp_lg-1
X-Mimecast-MFC-AGG-ID: T0iiPkT3NTqXnVDGsMp_lg_1793203498
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e011829easo817951f8f.3
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 09:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793203498; x=1793808298; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VToKcD9exB05u0wmkPQ4zmuhJE5oZK966jaJjguWNd0=;
        b=KGBYMdmxhv3EqxbXktxNIdkArmnwISyMDQxoruJgvHU6VgrO4du2OBescQyPzbKaeb
         GvGozz0IxqBjSfjTncuLdEdrXkD2iDaeq2g01prhvGxmb7rbem1/9Y4853A5X41jmXqw
         Ugn5AsoYx6tA21gCfECe4sji6vUbkcI3+Vuy5VqAG4L7k/15/bTO9TsBS7a7gvf+Zv3p
         Zjmz/uZJa8CjDwlnVJjYXgqv+x9xa+vMtFzQZXrdB5Ry3p+yQvJYXYEP5HTuAz+Imj/2
         p+nUmb79aVDpY4/L6mEaMwOuIr4Ic0om/Lyla6m2fyh94+ssvWio7/pEhQP+nu5lEzfA
         QNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203498; x=1793808298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VToKcD9exB05u0wmkPQ4zmuhJE5oZK966jaJjguWNd0=;
        b=k14OnRCfMLKpeDUhxxggWcnnjhxg5fUDWOaLXkFJ3caOI4ZmyVzNJdx2IS6gEECPWq
         fPGWjbvcesX3fpl5jyOkaEtXi1DJMfsr1T81Ajqk1GnKEU96q/cDL3KH94C0rArLzgnO
         5FHADyYttLYUu1JihAXPueaTxLQReulOmRzepPI7n3ka+QBxeUmLIqkBGKqOZj975uEI
         qg8tTihVmKRy4VynuJ4/QQXWyIZ1iid/Ybk16JQ9HPPi6+Fnt8VqUN9vu4WHlS/WPIUN
         Cb7N76ZHW52k2qYLg/wKiPGEwzkEEFj9N258YLbf7PLOREnT+CzbuVOgImYY2wb4LqmW
         1ULw==
X-Forwarded-Encrypted: i=1; AKwUvBx/g+yYhnOv0+Yg4jsV2Ygs+TWJ7X/e8hnte2I6hN5NjuZlJuGJlk4p+9JhIac/djV1VJA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6km9gA58WD0JzR6zvTgBIYDBdCq59IqO4W/68xbnVYKuWycbX
	MO8PWfYJkZRZy9QxFHjeb9SabBipBDpOPCdql6rveR08MNRriKOg9Z1XNKwttkzHkdWWrWTvT2Y
	gMx4PXTbzTiWt1ghG+pw/qhBiA3mPJluX7BeOfJeaDRW2D+q4HZLlQQ==
X-Gm-Gg: AYBFou3cUfeC7NsDUe4TJYRIha5IRx2K7F+fHgOy65J4BxTV2df72VHoYZ2JcjmSLgS
	v2eRTaTqqnSAVoEHdEKJMJ2r+BRXBK1ylSVK0W9/e+FCpey9H2JyU7DPFDWSAzWjGRvUCkcp1Ay
	Lu9A3Oj9VDv2WLETIJQjng/u6Vb6uvocG+h68uW4c1PiJN/KgxhIR5yqJ69GU3Cd46oF1YxtAxh
	LpQ0seA3u1xEHcHRQrq7gWLL22H2pXugBKs1L7dG+EP/y8nXZOxPiRkY/YzNe2iUF2TiTRrI/15
	uw0GcLJpLJ9dA1f31C9QpuiH+G0N/TJrif2FuTr5ADXltyK9/KRGE2iXORbhO9EdYA0DTjVKToX
	xNspMgiBWGYgWjnPMZnkYNLaGC2NRGRhIJyl5MCLchm1LegzF/Y78N83pA6QATIFdx/s5xuD44w
	L7CppbHPNSR5E=
X-Received: by 2002:a5d:6f0b:0:b0:48d:f0e4:27a4 with SMTP id ffacd0b85a97d-48e5d5c6fe4mr6785786f8f.24.1793203497833;
        Wed, 28 Oct 2026 09:04:57 -0700 (PDT)
X-Received: by 2002:a5d:6f0b:0:b0:48d:f0e4:27a4 with SMTP id ffacd0b85a97d-48e5d5c6fe4mr6785713f8f.24.1793203497394;
        Wed, 28 Oct 2026 09:04:57 -0700 (PDT)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm31898410f8f.32.2026.10.28.09.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:04:56 -0700 (PDT)
From: Sergio Lopez <slp@redhat.com>
Date: Wed, 28 Oct 2026 17:04:31 +0100
Subject: [PATCH RFC 2/8] vsock: report datagram receive and send queue
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
Message-Id: <20261028-vsock-dgram-support-v1-2-e457cf7cee78@sinrega.org>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
In-Reply-To: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
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
 Dexuan Cui <decui@microsoft.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4270; i=slp@sinrega.org;
 h=from:subject:message-id; bh=WVlKgJMoA9cer/yRiYHMwmDZxpTADMU0XzrISzF2HDw=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq4h0cCC2WdG4G+W0eDlbVWxWN7XHmMk8djieLa
 ArqExYppPiJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCauIdHAAKCRD0aSeNLwwC
 NYrOEACfPbC9AhTS1tqaaVJrhHYajwVLLx0wyc/uD3GQKasz9wtW04pgfy2dv4m8p9B8HJkP1hM
 dEwEHnk2w/Pqc0q97k/cID1zq/pWkHH4EpvuJQjS6V4JncEe82siIv9QgoI22BLX+MWgx0s14qX
 tSFNbpnlhZILA1Gr7WOIUT56+fDuEtthBjzM38ovfgJsJqSLyYJuycyfAX4KpqrQUb+wIr8cYx3
 n4XPwfehB8+oyo13u4DRagj2echrQ6ISu2lMk+vBgXXrecINXvsy+t/qdjKbjGGN/eV+a35fegP
 NJ9VXSdLxLAuQzbYDQUDoA5wde/Wo11Ju0GDwN5m3tTfGSwCZshHkBIhAVk7FxQ44qmGzKt4I5/
 VJughrbHN1Otuvdcru0r3uX1nvijOM/58er0L5eKNM41fpPhsADirw2UNIwfZoFnZHfKIsd1jwP
 ipSyaJJKRCM60ptwlRfsUxvikHpUIMfrF5F5LWPBSDJYR6qC5bTOxuPG9BpllDal/1KY35pwTdA
 ofneAOt6DSuWd3GVEPJ2Rt07x3NJCnhcZz4GBfCcFTo6FRvfAEZ0EVmj5vJSX6n2ymPluJydcEc
 NMaDx98F9tslw0FyCUNtuc25G8b/B2TtARI5JLLt8Fv97FGQb1PPDoudl83Nk5GQ6oAcD/LiQLt
 otlGbIjCgvO9Gtw==
X-Developer-Key: i=slp@sinrega.org; a=openpgp;
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
index 19bd9c1c3e5b..0c8b8a815b04 100644
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
index 5d1d85e5f519..dc1add2d2e89 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1344,16 +1344,20 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
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
@@ -1617,10 +1621,22 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
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

