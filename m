Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522903;
	b=WzZ9/baLBlCjhkAONwptel6AKMvTn437sMm9cP04t8GvTem/wnwHrC5BBcevK5U9ad+z
	 Bo+2e5dD2/0qYgVNWJJvfe3gxFVE5rJOguSrp/DVauatgDwsRr6RmqsAx8yTvOgZxb705
	 vEicnfvkCco5PQsUBNwVOu/ZmlgQDH/Ax+nXhqwp/a3EfMjEhrZBCasAtV3C+AzIKFmNz
	 Dugq1crtOpWOg+1yO6M0BQbqIaF89aPE/ZToF4PO4jcao1ShJpRbVnuoTQCzkhn5D8E/H
	 alK0jo6ynWyeV5hyAGTqp2nd26SG3XfNJmbh12JkPr79IyPZlisaPbB/5VUKIX65SlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522903;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
	b=r7y3QLMCtS8SNBfBlFoXR3eGCYp6bSuZW/MSZ+vipiOeSxNH7t11WlSFYFsd+a+7QZCx
	 2mLbj/uGiDLYhWvtLv7f/Oc/10kfdLxYPFocLRagC253cs4NMb0Ol75zGtrM/Fh3SU+Xo
	 U9SiXlOAynziNl+xOooVKhJ91hhUP3SF7CHPqb89l3vC4a6cKgHdd1azNw06MB26SxvDG
	 S3CRz5ieaRPp/Jd9v1zT+cIb9YW8jZejM7ogycia7oWuSFojih3RIuqzPidkKvFTgucHV
	 AQNH9Dk8wPMdkKPbIUR3Y07QFgKcQ7cErUXhLtaJoslbGiNDfJbkctyzzz0Iq6oUc7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LAE3OTZJ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IGGOKaGg;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5412D60A262A
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 12:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5412D60A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LAE3OTZJ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IGGOKaGg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795522902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
	b=LAE3OTZJ94O9zADbvv78EnaJe8hSRtPzqrVWOuKLuospb0p7Ee/QaRtyC3ci4W1EFYT7fV
	PMYAM5/Rp17YDJXfHuvR5vpxH3Pa/RZXRlQBe6kQtGq44WIkdv+1ezPj59Z6CUjg+DHSfX
	UcT5mfeOGl5i5AZayIPJmCRAWg6zp6w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-NF01yG8NNmuiR4-C1fPVIw-1; Tue, 24 Nov 2026 12:21:40 +0000
X-MC-Unique: NF01yG8NNmuiR4-C1fPVIw-1
X-Mimecast-MFC-AGG-ID: NF01yG8NNmuiR4-C1fPVIw_1795522899
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48df02b91f9so2869742f8f.1
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 04:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795522899; x=1796127699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
        b=IGGOKaGgnYTZC6uMNFphgEaAiBl+z7Ib/AzDlnlGJ/DneRYZzlK3fk9JXe+54ZSCdE
         KgaQ8QrsY3sctpasdziJODIS0SXAZqfY9wIHBPVwoB/40+5r8nJYemWV51OgiqsCCU/9
         epJDChCCnpOkqpuzXRQ5E+xKM4FwXGPWD0L1TCxO/12cUNR3qfHfogbIEO2h8nYin5fO
         5iazUkzKhxBkJvxNBtg5Je+Dt/9x8JGT75HmJUtNK5qdZFeEYcTIr/P6cf0pL6Me03sm
         gbHgYJyqtOOCLpEyPePrsmV6si1lQWN57cA20LZs9dwTIuqjUeT0TF26LEi4dXJmqT1V
         VaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522899; x=1796127699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
        b=r4B4gz/oiOTnCz0AizWu8I/vaOsiTbR6dQB3mZABeAPcl77Tay3LQM9rFFpUrNWd5s
         3kB07+y/b1T9xwoSuILITq61XRskyJzqMidhmo/rfp/4suDrPOzIIkSEbPIeJPp6U//0
         vbO9BKFm+8DlES0uP8ZyUT+qxCToS86nbmAoGglZ1QdPrz+fpwtE8UxcxglWJDfzE8to
         O43R+3i9/EjOjZnW+0hxuTZW3k8gl4it/MVb9DAwbTkiZDBPxcsmAVtwBWnopVA9xs8Q
         g/rMbcR2fsAyqlSKWiQb9JiC+xCXR1CX0jjl6ReaSaQS9q33r9mWcBtJdG8vIg+6NA7S
         fUBg==
X-Forwarded-Encrypted: i=1; AL+hErGAiBD1RFdMdIgewX2hLK56rkCJNdeLXFSi7BCCNd2ivfMBqWxnV8Ig4V0Yqey80Bt8EUg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hfCpbj8vAODXpHhcIArMEN2vgpsU6hJKGLUMSPkSo0PQB9iiD
	ouW/uV/XZm4N35janIhyqS2BzD0qXvemadUIR8WqdA0wC6EOkGVbif6cPWeXOSXLd28YKvyRH3u
	ll+tmvqzDVwn2wHOcEz63OwwRao7d94WTIdes7lFYjMRDZqcvf57V0w==
X-Gm-Gg: AZFdTZdLs+e0XgXipqIAiMUfftaLz03By2OMWsY23KqgS5ONLnzht+Ij+VthNZertxU
	Yudaa+8vg3Ns4DxEMYIs4gs9Ee0pktpQIUDzc8FJUn1JiuJJXNVBn+ikyp0R3uOs8yi0/RA5bld
	AFzyjDjNQD08cEz9O/0eRnlHy9afaRI51xxhhw5B05asYiT/EQEeH7lCLt0BPPFM2iHXjAihFfj
	8z8wIAxXL13TZ7acmHsLEPX1FOlwlt+zOpY6vGjUrSAoPCz61BINZmWCMyuPGpq5spMdg1hel+i
	eC2awi34Sf7IZNK7MTqLTljkM4Wn0bmyYeTb3PQzTR2z+uoXybNz9bF/I8f14ImKYez2NK5zIwF
	rFwHliGiFPnIzbN2iesAL39UcHFkffYeJ/OgTMkV5A3zUo7FM20LP1FZzWtEOCUC2kzN+jJxIaK
	NL5ZX4hYNnTrc=
X-Received: by 2002:a05:6000:2383:b0:492:aff5:da4d with SMTP id ffacd0b85a97d-4aa545e244fmr41056234f8f.7.1795522899271;
        Tue, 24 Nov 2026 04:21:39 -0800 (PST)
X-Received: by 2002:a05:6000:2383:b0:492:aff5:da4d with SMTP id ffacd0b85a97d-4aa545e244fmr41056186f8f.7.1795522898891;
        Tue, 24 Nov 2026 04:21:38 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110ba3sm22753198f8f.35.2026.11.24.04.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:21:38 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Tue, 24 Nov 2026 13:20:22 +0100
Subject: [PATCH RFC v4 4/8] vsock/virtio: negotiate datagram support on the
 guest
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
Message-Id: <20261124-vsock-dgram-support-v4-4-3607484e85e8@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4746; i=slp@redhat.com;
 h=from:subject:message-id; bh=iq6ep5+lpyNre87c+82+rRsIkGG2RBevg46oczOnz0k=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBrBYFF7IkOixcD6aeU8YwF6+Ac+NjB8ZTAX9VUt
 vhkX1UCGMOJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCawWBRQAKCRD0aSeNLwwC
 NQa7EACBjEJGAIQIYFtCJEK+zt/cuIT5TjQ0MPJoTh1Ut5YPjvEyOVH4wsLUDlJOSnOTMNi+1YC
 6JSXPs6dnaGdvBXQsAQiv28mRH9A7hX70dkt8B2Ni7fF2kFTvhpe1DM1S0JC+NSiGfGKv21EBAg
 cWYYLfw0I6bVFdD0DklYSAiDdbku6E1nUOCX4deyoGGqEERiquYKXorpSscKU3Pd+wzR4849Pxg
 GB0oJlSKQqC/eORSnlWttDW6D5ENxOkLKus5H6Avboc0UhbmMFHWtM/n5uJ/zBQT3LC+S6ew4zr
 e+hlUn+H/nR5blYN4QVotAr1n/EwwS7cSLVknfA7YxmCU6cNJA7sK2ms53f30hC5WmdrrwLiQrE
 vzRshVc0FHL5uOhh5GKsP8QWeuwQrTdQoEhU5S9L5GvhlBQCjUEA9+b2JLzW+uSsYyToaNDrTIS
 wyXQoML8Es651DUqrprc+4B7uMrUK5DDLUSBjidEo+ASDGfLpd2mU1CtBuyAZQx1kki8HrosAAD
 y8xF2UIX7cU4mZpDS/0P1tTWIuRsguaorUBhWGRKUCuSds+z3wLOk7vdf7CedmPDo2sbB7xYBUV
 IXSViTFKl6Wsz3KHWnDk7I5kRj+Lembhk1vZw0RG2hNYsY/TqTZVePZNKOrlX50a8FpumTjzj8I
 W57PdNgz/yXJ4kw==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Advertise VIRTIO_VSOCK_F_DGRAM and record whether the device
negotiated it. Gate datagram socket initialization and destination
checks on the negotiated feature and the transport's supported network
namespace mode.

Perform device capability checks at socket creation without requiring
a remote address, which is not yet known for an unconnected datagram
socket. The common virtio implementation provides the datagram data
path.

Discard received datagrams when the device has not negotiated support,
including when a socket was initialized through another transport.
Reject packets addressed to a different CID using the full 64-bit wire
value before bound-socket lookup narrows it or matches a wildcard.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 50 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f9aa9c4c3aa..fd10f20d7611 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -57,6 +57,7 @@ struct virtio_vsock {
 
 	u32 guest_cid;
 	bool seqpacket_allow;
+	bool dgram_allow;
 
 	/* These fields are used only in tx path in function
 	 * 'virtio_transport_send_pkt_work()', so to save
@@ -547,6 +548,18 @@ bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
 
 static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
 					     u32 remote_cid);
+static bool virtio_transport_dgram_allow_check(struct vsock_sock *vsk,
+					       u32 cid, u32 port);
+
+static int virtio_transport_socket_init(struct vsock_sock *vsk,
+					struct vsock_sock *psk)
+{
+	if (sk_vsock(vsk)->sk_type == SOCK_DGRAM &&
+	    !virtio_transport_dgram_allow_check(vsk, 0, 0))
+		return -ESOCKTNOSUPPORT;
+
+	return virtio_transport_do_socket_init(vsk, psk);
+}
 
 static bool virtio_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
 {
@@ -561,7 +574,7 @@ static struct virtio_transport virtio_transport = {
 		.get_local_cid            = virtio_transport_get_local_cid,
 		.has_remote_cid           = virtio_transport_has_remote_cid,
 
-		.init                     = virtio_transport_do_socket_init,
+		.init                     = virtio_transport_socket_init,
 		.destruct                 = virtio_transport_destruct,
 		.release                  = virtio_transport_release,
 		.connect                  = virtio_transport_connect,
@@ -571,7 +584,7 @@ static struct virtio_transport virtio_transport = {
 		.dgram_bind               = virtio_transport_dgram_bind,
 		.dgram_dequeue            = virtio_transport_dgram_dequeue,
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
-		.dgram_allow              = virtio_transport_dgram_allow,
+		.dgram_allow              = virtio_transport_dgram_allow_check,
 
 		.stream_dequeue           = virtio_transport_stream_dequeue,
 		.stream_enqueue           = virtio_transport_stream_enqueue,
@@ -629,6 +642,25 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 	return seqpacket_allow;
 }
 
+static bool
+virtio_transport_dgram_allow_check(struct vsock_sock *vsk, u32 cid, u32 port)
+{
+	struct virtio_vsock *vsock;
+	bool dgram_allow;
+
+	if (!vsock_net_mode_global(vsk))
+		return false;
+
+	dgram_allow = false;
+	rcu_read_lock();
+	vsock = rcu_dereference(the_virtio_vsock);
+	if (vsock)
+		dgram_allow = vsock->dgram_allow;
+	rcu_read_unlock();
+
+	return dgram_allow;
+}
+
 static void virtio_transport_rx_work(struct work_struct *work)
 {
 	struct virtio_vsock *vsock =
@@ -677,6 +709,14 @@ static void virtio_transport_rx_work(struct work_struct *work)
 				continue;
 			}
 
+			/* Check the full wire CID before socket lookup truncates it. */
+			if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM &&
+			    (!vsock->dgram_allow ||
+			     le64_to_cpu(hdr->dst_cid) != vsock->guest_cid)) {
+				kfree_skb(skb);
+				continue;
+			}
+
 			if (payload_len)
 				virtio_vsock_skb_put(skb, payload_len);
 
@@ -835,6 +875,9 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
 		vsock->seqpacket_allow = true;
 
+	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_DGRAM))
+		vsock->dgram_allow = true;
+
 	vdev->priv = vsock;
 
 	ret = virtio_vsock_vqs_init(vsock);
@@ -932,7 +975,8 @@ static struct virtio_device_id id_table[] = {
 };
 
 static unsigned int features[] = {
-	VIRTIO_VSOCK_F_SEQPACKET
+	VIRTIO_VSOCK_F_SEQPACKET,
+	VIRTIO_VSOCK_F_DGRAM,
 };
 
 static struct virtio_driver virtio_vsock_driver = {

-- 
2.56.0

