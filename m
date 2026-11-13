Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574200;
	b=dVFb2dUka8fWV48CDpmdXr9gFYN1lIP/3D5AehRv7ScMVQp/JrMNuArmBYaAPAF62Fog
	 RX3kogDDhSPRoskEBNu+y0jFAe9lB8H30TXwGya6uxCmzU1/yGoizEZRir5AEI9MOlrWf
	 73m26N7EN3BD6A0hMAY2Qn9gWLg9h6TcAl5/JgybQ88CnnGp3cRruBuS3LXRRDDL6g4im
	 9Pj3tStCbQkkAlX7x0WN6ksMT2C2HTmaO6RGg4scKQX3iHX+GvpSYX1oucHccokcsDvcY
	 QvYxb4wC+65Oe7NChv+dgIy7MehnTiWG7FfkU/uBc6jFnSO0QqIds/ePk2K8F4b3lVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574200;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=42m2T+OgUE+WzNUCZPiDLGv4wYEY//5j6O7a88xsAPc=;
	b=gt39BP2PcUvHDexfKPbkfgbbipRX0K57zjc2ewyE09XRCutyULpu5uFHqQgufI2pLD0u
	 flMQMyzR6OgLApWVeA28otb54AL5uvRASOCOVtLWn4mbB4hFmWR81TWJ0mA0qx1xVZJLu
	 hkt9zgmZOdG+OEpWYe2Xi8A0qXkonWYDe1jXkPza+3A+UaQKzdxuPv4QHD9yOiopJ793+
	 Fle/DflnsPo64r0ZBkn4nm+bBq0P9LzUMIqbgrzfkR0iXMGOuB4rkfsWE8v+ZGA4LjBhE
	 aC+TjxihSlTSEduYj1k8n1+EFCE1ml2P75QKQkyYhJKIYLxyNvbmVaiohDNM3Zl6QNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dzzhFIJd;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=oG9OhnCE;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD8B60A5BC0
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 12:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FD8B60A5BC0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dzzhFIJd;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=oG9OhnCE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794574199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42m2T+OgUE+WzNUCZPiDLGv4wYEY//5j6O7a88xsAPc=;
	b=dzzhFIJdDsrRL2aev9RIOKOSSSont4Z5oA4SY6lEs5vX7IKINGfXtK9b4EpnnVFH6InNwf
	J1v5n0gtJZPXO+ouJW/vhVa/Mt0LEIctcT2Bi35mhFygppBpMq5ro7shY2z4iAa7F/ys+X
	qlzQSmQtw8vBEiY+RifX+M1rzw2uunQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-VrwzHvgfOLy9nAnPRgYkHg-1; Fri, 13 Nov 2026 07:49:57 -0500
X-MC-Unique: VrwzHvgfOLy9nAnPRgYkHg-1
X-Mimecast-MFC-AGG-ID: VrwzHvgfOLy9nAnPRgYkHg_1794574197
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so5588355e9.2
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 04:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794574196; x=1795178996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=42m2T+OgUE+WzNUCZPiDLGv4wYEY//5j6O7a88xsAPc=;
        b=oG9OhnCECpiUxFpOU+vcSfvCzTBIGh3g8CsKJ41WLgzHDvyYmZHVcwmkDZX2fEE+pL
         Xyu1v5In8P1ynsb82Ye1jNJbW+vKOfbtHRtynzVwhS/Nojr5GPk5ggrpEzoUv7ChBZMD
         c5C/65l8YBKefscfztffH/nvlO2YjL+yHG7gGBlp/6GhNklrru/66AEy0vFYC7JpgQEs
         IufrV366iKyjrXynvQfDz2gwgPOQqpAhAZiVvFm3jL3Oj7bsL8N+zsmtzb05iO88Ybi/
         HD79I+63AC7ILhyuAQ2sKZJI/Vza3Gk1+o+E6mqNp0/iO1i6ebPTo4GPiVtnoyjkN1i7
         diBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574196; x=1795178996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=42m2T+OgUE+WzNUCZPiDLGv4wYEY//5j6O7a88xsAPc=;
        b=x3qvgUirmIZX43OqWcEM35kn1QWWdsocSlkgqeQXBgMllii9cnDRGkrOonU2b6EwF+
         5GiDZAAYK5BBT2b9AGNyh4RO6TfajuSHB3i0BxtnTgTIuoEGH95v5kWf1OS+DEdi8kCl
         doHR7+46eEz3pLJCPkeLW647mIjZcYxWsziyj/p655Dl9Il0hSZ976WX60Lf2Caug5S6
         YjOf7xjp+Xgzb/l5ByAmgLyUxaGVXpqsyhcSkkM+ehIn3j5t92BURVsau2vv8qaCYvJS
         BEi0LsfWh8FbsPFgGYGGxJ6u+VNs4m8ncRlR6qlAxH+NbKk1Pl4FnPbIqWlHADIMVmbI
         tRHw==
X-Forwarded-Encrypted: i=1; AL+hErGLexki88Rh4XPArp2aw7bAr+4IQbtsjSCqGPcucZEEfqImLakD/kG463ruGuXnLWCPnnQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ga0h4a85zlY2i/bl+IHoJtNOs0gaNcJwxDBi/lMm04tIGG8ms
	QTZFUq8HGIEDoW9128FRh4dNeer6h6Bz3wcfjZTsgsGAWFEg5ypSNRYwcKKSxOaSaZaoK6FM11e
	Il91kPezOhRqWLBVErs7nI6rD3CqQqSFXsNFU1B/aYz2bcRn2U933hg==
X-Gm-Gg: AYBFou1m2v1R3TDHXQHWJWXQItgNawXz1F9c4/1qVPg08eRzyvziZcMg8SADrpqUGwO
	pVzUpF+BM4SWga2dou3FBXcWCeoobuvFJibSkxDxVzD2crzhU6osqwkGobdf0UfsTYwM3rJr7uD
	T7gIz5k/H/pwZ1RrJSk6GJUuB8UtE/xCyf9s7jEltaBoN9qun7Br74fXgy9hxXl1XgNBuJBa0VO
	eDnHL9DGZpEdZjzLyvY55qoo/hJvEpSe8yDyEE3Q4GNkuBLgQUB1QPbKsxdM42EmsVtBtZROoGx
	tiBjjSKtucEtbkOjhjbkh6B5QqXAi0A6mMQDxe5WRoIZiICJhspC8pnnGoKvbkQX28/HKEoD1Uz
	eUH2Ojar6PXNh/1klLA3BM6sbZshjRcp/ptnUsE925HqlQGxXXugTJSj88ke3D1NWVoMDGvV84h
	ZjQph9fPrZJ8A=
X-Received: by 2002:a05:600c:8b66:b0:4a4:7a8d:c436 with SMTP id 5b1f17b1804b1-4bb55c5f567mr49391875e9.11.1794574196568;
        Fri, 13 Nov 2026 04:49:56 -0800 (PST)
X-Received: by 2002:a05:600c:8b66:b0:4a4:7a8d:c436 with SMTP id 5b1f17b1804b1-4bb55c5f567mr49391085e9.11.1794574196086;
        Fri, 13 Nov 2026 04:49:56 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm151135805e9.15.2026.11.13.04.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:49:55 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 13 Nov 2026 13:47:38 +0100
Subject: [PATCH RFC v2 5/8] vhost/vsock: negotiate datagram support with
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
Message-Id: <20261113-vsock-dgram-support-v2-5-bacfc85b71ce@redhat.com>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
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
 linux-doc@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4280; i=slp@redhat.com;
 h=from:subject:message-id; bh=YKxLSTvJb7wfOxlVHWx31lkfYp2fx1FL4beUkGwefCU=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq9wdekDq1LWUUZmlpHsi/2uTpspdGC00wTmHdR
 C74XVInssqJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCavcHXgAKCRD0aSeNLwwC
 NcQRD/oCkwJdczjWxOlegLrWMfsgXLy+V0/1R7NmFksI//jyPSk9YMpRyELAWexBgUFH6e/6cwq
 wCpDig808i1oIfrWd+VcA9VzYzHMBMyBGe2nMcVH78vvr/+vrx5aJ0a/UJZYU2NKMFhZU7LiTGH
 todeOUCByOFykeDwMmlJICI6Sh9YB+0SORMvycciFaKarQ2GIOM/ZzxaHKTOc+PFARga2CRndQY
 GQEA5RI3gvA5aGYlUL46dBqhxkNHZ69ptOgMKTzMqyn85I+D9bcPFl7VI5jPmJ2s884j2sN8qaq
 eTjBbLEBWe0ceznjHqMcz2RGlJiJqqfZfihL7lBCgw502W45iPpRrE/ltW5ViWCHyM/DXtqmrZq
 IhIHiN/Z/yAC2Bcf+4k663O0K3vWiQmv8Q+A5IZPvFTcHGxGCa4CsJ9yf5PPYvNq5436WEzOBp9
 +mg9VP68oy0bPzSJDxY8DWzx/wqMwHOd/ohSkXzY7u0iaTnb9XLmVyyMI/21QSTwgXqaLc5mwHY
 A/BmH9a/IkTHwCZhRsW540/LF1LOxW3kmf84PvmTv52ANmVCsTG1XNwhk4lxmkWu6Uk1pJB4i7Q
 jgnXk791oLvMg3wTFjr8sOu/rr03w3dAMFWeqzbO8M/qSbx3iZGDph63hPbEHYg+ct58Z+GeRNj
 9glEhJOQxCGeJOw==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Expose VIRTIO_VSOCK_F_DGRAM in the vhost feature bitmap and retain the
negotiated value for each guest.  Keep datagrams disabled until the
feature is negotiated.

Use a vhost-specific datagram destination check to look up the guest
in the socket's network namespace and require its negotiated datagram
feature. The common virtio implementation supplies the bind and
message operations; destination validation remains in connect() and
sendmsg(), where the remote CID is available.

Reject guest datagrams on ingress unless the receiving virtqueue
acknowledged the feature. Complete rejected descriptors normally so the
queue can continue processing subsequent traffic.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/vhost/vsock.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 0cb87971d749..7971f6f0b6a2 100644
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
@@ -573,10 +595,12 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 
 		hdr = virtio_vsock_hdr(skb);
 
-		/* Only accept correctly addressed packets */
+		/* Check addressing and datagram feature negotiation. */
 		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
 		    le64_to_cpu(hdr->dst_cid) ==
-		    vhost_transport_get_local_cid())
+		    vhost_transport_get_local_cid() &&
+		    (le16_to_cpu(hdr->type) != VIRTIO_VSOCK_TYPE_DGRAM ||
+		     vhost_has_feature(vq, VIRTIO_VSOCK_F_DGRAM)))
 			virtio_transport_recv_pkt(&vhost_transport, skb,
 						  vsock->net);
 		else
@@ -737,6 +761,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
 	vsock->ever_started = false;
+	vsock->dgram_allow = false;
 
 	atomic_set(&vsock->queued_replies, 0);
 
@@ -890,6 +915,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	}
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
+	vsock->dgram_allow = features & (1ULL << VIRTIO_VSOCK_F_DGRAM);
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		vq = &vsock->vqs[i];

-- 
2.56.0

