Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203513;
	b=dlGF1ko3jxON3yRYrkSccSkBcx5tJy6RsMas3DbeE+lwnHil1bwaTdwabmCnBQpujEl7
	 tYn7EIXdWCq4KRmZW1HBVoydu42lgKl3vsHldHc1+gid8IVQLzzCJ0BAJGSEsz1p1AK6p
	 WGminutJz6GhePr1xJnaldZnAlA1VhRSgppVt7p5igGWYbgtfzjloFGi7scJ9sJCRHT3o
	 sXOvCK9E2/GaLSjEtiUuocHUTx40iIm7DnGsL6Ojto2W1OedeQWpqeIAGW0dgkJJGjPP5
	 FMykVRTH90oaQTrDtWvcUia3X364hAhAUputf8JsF+vErqhgX4XTnZsLSMiG8e9IR6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203513;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=AZyhQ2EKcKoGBoxWXfD2v11oINYwMY59baAB9VBA9Og=;
	b=KQEIUMiLj2E8ge1eC157fWI4UJEJJBy9yaHJT/SMO0S1Hcv3AO9Pl/Wq5wFNWGBNdwWM
	 Phlj39xFGLB+xjZD1TR/Mg8RLmvhGB6cS4s2D7k1rpX6dfJXDQbrMfQfSg6tctZpjmHqP
	 r+Y2kwVpv7Zqr5eD5wPbfoGE8EQSj3+6kI5aJqAYFvrwRozlqaaWnpGuWoVOqnEAzLPED
	 0e4fW+m6XA4/DzxApPATOEPsKvNX32Ql8LE2PZHHvIlqlIR6OrQdvcnATtufJ85/Etq0h
	 9LYYNLVpIP+w3U3WtBPE5jXm582PjnXN7TfYVfROMbOb99h2M5BzDgJrSIh6KzVyY6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=at20S5IL;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="KA/pfdBg";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED4460A6F79
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 16:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ED4460A6F79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=at20S5IL;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KA/pfdBg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793203512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZyhQ2EKcKoGBoxWXfD2v11oINYwMY59baAB9VBA9Og=;
	b=at20S5ILdFpXIgSEkI70OKsR3wDI7swmppr27DCMxKosGWmPKBjx/aLirpiplw00pBpByB
	Rl7ElsnPzSGMW+dAaMMXZ4hjzb9zVjdT3fuftEG1mOnfvoc6bHNjF40tai2is1PyZUDtZI
	4/QZgdlf22xJchgmcDMnKuyAhNlTPUw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-OZ0nMnvuOMGH94casZPjIg-1; Wed, 28 Oct 2026 12:05:05 -0400
X-MC-Unique: OZ0nMnvuOMGH94casZPjIg-1
X-Mimecast-MFC-AGG-ID: OZ0nMnvuOMGH94casZPjIg_1793203504
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c46582442so748571f8f.0
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 09:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793203504; x=1793808304; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AZyhQ2EKcKoGBoxWXfD2v11oINYwMY59baAB9VBA9Og=;
        b=KA/pfdBgrPaFKhmBB8Ztp62DZUKCSsV8kLkjs8tOMUw6b0okfNqTL+7ibG5o+1ak9J
         MzGqfy8oQ+0rCtpx9McZflckf1/JMrOIbxulre4S08js+KufDtf7vEyub1nNFbUMYzCO
         vpXA7JmpYGfsKps61SzdTbc6fANvyZV2R26Ay3iyzLZyB+EJDUhXGGMGldbiMjaVVmi3
         zX2w9hsMh5NWAzyhcpiZ0Lk92pQzp1q4ChiGwEePhP4G7e27QlHgTJySYt/KvKpoPk93
         WHxdCPPacSy94iSnFJFggqG6p/dTYsXmq+0IkjTDYdxu+0BGN81TZpZb/9boMbShMjX2
         GFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203504; x=1793808304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AZyhQ2EKcKoGBoxWXfD2v11oINYwMY59baAB9VBA9Og=;
        b=zjIzQvB0sHZObCEXCaJ+6jtyy1iz8wT/GQZaZNLAYQEhOeAdHmVrJtmcMVFcU9kUk2
         M/+C7S9yV0sIHuBsXIRHSlsYgBRLJt9O3afgLq6L2bkYv1K9raJL78ZuKsg8vfXt7uZY
         Iy/+UwZJJE/MIsi/oErgZ1XEMeUDP7rbJ0A763uCc6/IuRe2HB8o/Sb3W4ImOULomY31
         DK5FmLDyj1nPSEXSaZpFGqXCc1kNRu6fhfwWnW0oimSv1qMx1hr/lbHaikn/7KJcnCjo
         QehKFEhGLJescEPvx8mczLJyCamGrUQZR9sFjvNi3ggkYUQSKFem+i9lX7Mv9jpcBp0m
         KZhw==
X-Forwarded-Encrypted: i=1; AKwUvBwytl78KjEbRf35JCUcPGrUstlBNsrQ9d/gktHEEOZyQuICMxv6GTCUlq2OStT6noyRXyY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfPRO4c2/R8CfvIC+MlLrCn3L1SjhMaOQwoPUc2cTmGd6FlgFw
	eKFRAQXBBPxiubwM+BYMVN+eA4mSJhv0qi2FwOxUOl+7FkvhnwFDHMBxRVAkmkk3x2ZTw6xM2a4
	u7O9cMd/dT5HAWZLtKrEZfodom2LopVAHQja2PFLn/2ZohLWrQSUoHg==
X-Gm-Gg: AYBFou1KjiOqdVDXTSuCitEUF0txC1/xWfVJ7B5BmemoXb4PiTKDM/edIu3Y5RfPqt1
	DGncXaa8uPj+oEF387tt5iv2FmVZXFUcwRmaHgcFqmxkCAlhT9gwtqMz7sohEtu666T83pKbl+Y
	UjGnI2rKckNmU2p+SDP43/GHxZ4SIVM+iqMXJ1W/EaybzV38jag0nphwKoFVYrRgFsXZuWghLkc
	DM2CUHiKQOetkaMmP6BkQYSAGGUQt1/2gATUjp7/6WXkamKZ6sml4wB3bLwFl3yUeQOOmzgHRX9
	PwNEwlfRVq7be1isl5dRYximf7X1lvxqQrTmOubbE9SRl39jlGCq8jgWRZ8/qE2oPwSFdKasbx5
	54LdMlX55GXkJZnYLGOH+EkMdBatLHXZpYnTVVMvlYhDbMrcbqp5AL4elB/BKx6j5t9mN7SbNOm
	zI6hp73JAF8vc=
X-Received: by 2002:a05:6000:98d:b0:48d:dec7:974c with SMTP id ffacd0b85a97d-48e5d567ed1mr7017682f8f.7.1793203503978;
        Wed, 28 Oct 2026 09:05:03 -0700 (PDT)
X-Received: by 2002:a05:6000:98d:b0:48d:dec7:974c with SMTP id ffacd0b85a97d-48e5d567ed1mr7017631f8f.7.1793203503646;
        Wed, 28 Oct 2026 09:05:03 -0700 (PDT)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm31898410f8f.32.2026.10.28.09.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:05:02 -0700 (PDT)
From: Sergio Lopez <slp@redhat.com>
Date: Wed, 28 Oct 2026 17:04:34 +0100
Subject: [PATCH RFC 5/8] vhost/vsock: negotiate datagram support with
 guests
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
Message-Id: <20261028-vsock-dgram-support-v1-5-e457cf7cee78@sinrega.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3464; i=slp@sinrega.org;
 h=from:subject:message-id; bh=S/4WwL5dbPWCiZa0zeuBb6RBsuWeJgQfZUwqCMWgNGg=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq4h0e97Xa4zjSMJH/xL6mXhEFJLr5iP+9ch7tW
 39VyLppJZSJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCauIdHgAKCRD0aSeNLwwC
 NRheD/402018X9FBIyAMMgECnQa6yDcTR5QuwyzPlGz5FU3Usm0YdBiY4B7W9pjUCrlUNUDsPBh
 ksIdh4bV9svFPsQ9oCZgZRwfFoY3hSJNnyvTN3tE7MYRPA0uZZpTQACnKw0FrTz2+luenFHGnF/
 ycD0KQ0ejq5Uje3XgSzl9vNFIaNQZjgV1ii62A+qKzTOoLDxcYTHcYKzkpE0O731ZH0P9qRLpME
 OLusu+MT47wAqaWVvGA7v+F7q+NIO65WdytU4jx7KxqIdFFuI5B5zqBReSNOcW0u17DiMcUuWhJ
 87+N4tt2foVeHlcNtLGyi8A//zJuvc0zmEuuVi39QStNZyDYyhF4xq2T168g6Jw79ok+wCfHZFp
 XtXcmIp6Z0Uso6z5/fU7AnJvgCHAaJv4qAj5FB5nkuI/NQwo80oDApKvKRWoyB4B/WkuPwbZWVo
 y6dGBTrEINxRHOqywyEEEvvz6rYZe3WY5naK0fpnr+HNHVfBiO6ias62HtsrGO36MnE2s+sHJC/
 cpYz0guHd7QByD6nTn7TJJJTjUk0Q1+7sFkxIBBTryZ5PxAT/aVB4hmF7eBeQFTBqvY34ccn4cP
 CqzmK8OoKeB1Fshdqvito+Go6gpfCtRrXApVO13D0UFAnSn2qxBp1TzjcJDhAl48UAEETZHxUHB
 fV584fy3LMal/ew==
X-Developer-Key: i=slp@sinrega.org; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Expose VIRTIO_VSOCK_F_DGRAM in the vhost feature bitmap and retain the
negotiated value for each guest.  Keep datagrams disabled until the
feature is negotiated.

Use a vhost-specific datagram destination check to look up the guest
in the socket's network namespace and require its negotiated datagram
feature. The common virtio implementation supplies the bind and
message operations; destination validation remains in connect() and
sendmsg(), where the remote CID is available.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/vhost/vsock.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 0cb87971d749..eb2fbdb721aa 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -32,7 +32,8 @@
 static const int vhost_vsock_bits[] = {
 	VHOST_FEATURES,
 	VIRTIO_F_ACCESS_PLATFORM,
-	VIRTIO_VSOCK_F_SEQPACKET
+	VIRTIO_VSOCK_F_SEQPACKET,
+	VIRTIO_VSOCK_F_DGRAM,
 };
 
 #define VHOST_VSOCK_FEATURES VHOST_FEATURES_U64(vhost_vsock_bits, 0)
@@ -62,6 +63,7 @@ struct vhost_vsock {
 	u32 guest_cid;
 	bool seqpacket_allow;
 	bool ever_started; /* set on first SET_RUNNING(1); never cleared */
+	bool dgram_allow;
 };
 
 static u32 vhost_transport_get_local_cid(void)
@@ -436,6 +438,8 @@ static bool vhost_transport_msgzerocopy_allow(void)
 
 static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
 					    u32 remote_cid);
+static bool vhost_transport_dgram_allow(struct vsock_sock *vsk,
+					u32 cid, u32 port);
 
 static bool
 vhost_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
@@ -460,7 +464,7 @@ static struct virtio_transport vhost_transport = {
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
 		.dgram_dequeue            = virtio_transport_dgram_dequeue,
 		.dgram_bind               = virtio_transport_dgram_bind,
-		.dgram_allow              = virtio_transport_dgram_allow,
+		.dgram_allow              = vhost_transport_dgram_allow,
 
 		.stream_enqueue           = virtio_transport_stream_enqueue,
 		.stream_dequeue           = virtio_transport_stream_dequeue,
@@ -516,6 +520,24 @@ static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
 	return seqpacket_allow;
 }
 
+static bool vhost_transport_dgram_allow(struct vsock_sock *vsk,
+					u32 cid, u32 port)
+{
+	struct net *net = sock_net(sk_vsock(vsk));
+	struct vhost_vsock *vsock;
+	bool dgram_allow = false;
+
+	rcu_read_lock();
+	vsock = vhost_vsock_get(cid, net);
+
+	if (vsock)
+		dgram_allow = vsock->dgram_allow;
+
+	rcu_read_unlock();
+
+	return dgram_allow;
+}
+
 static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 {
 	struct vhost_virtqueue *vq = container_of(work, struct vhost_virtqueue,
@@ -737,6 +759,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
 	vsock->ever_started = false;
+	vsock->dgram_allow = false;
 
 	atomic_set(&vsock->queued_replies, 0);
 
@@ -890,6 +913,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	}
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
+	vsock->dgram_allow = features & (1ULL << VIRTIO_VSOCK_F_DGRAM);
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		vq = &vsock->vqs[i];

-- 
2.56.0

