Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203500;
	b=uX5RNYwtCl9PPP4OxBKTg63hus6e+zQDrsLtuMXbuvJTcd8gGYMsxU8A12DvWLoiRj06
	 4Jdyrg+wzT4LRvo6d0OlAB55FOc4UTI9/iqq5L73z+XbCvC2Bms8WfNVjreSGQqjAHJ5d
	 TrvN0YWt/QeJCE+OlxDoriN70QB+vv3c2kFSfT5T/+WIW/jyqRT+27oA36WQ9axBsCsAt
	 VuLosaNHm+Yh/rlLHgC+4DQBo3j1RaJ2Mvu0sDGzXzLhW8IT5Ly37CA51k94i2EDIZGo4
	 rBQXSz2BBg3L97z2azd2SSGm2BhOUEpVUZlTRzdrgWhDFq8mBEXXMRN/72NQjkBtYbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203500;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=SSkPhi8dGQVlMB+aYtf/PbRbQYkLH9iaxEtJasH6Snw=;
	b=3OOal01dWdKG8a+drsmd44zJ7v8emubid5JAO82HEFkL70I6yk2cK5slmwWOK3HMfjqW
	 MLHsLdir+lgmPHRJWYL6JPew589hJUpqXY5B9AHoqhvsQl1DOGJkvXRy6O6fOj2j91CmS
	 Hw4JkGt2+IeuSngPAzJaKe7g37Y+A7Ufz+AqTPMRBCzlGld9AODjrqr7QJwqxSuYmhICm
	 rlheVIXhCCAsG1Xxzl6jrEEzjVTq4RA+2S+bxTklhuCxWVnxGhPavDStn9yIJ8qJCMtkL
	 F7ADbYyAlqCx+B9BTOASOYwFRWjuBqS4IYS9tMhceXUCTF18dkOeAZUpoh+qQF6XDaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zb8L6sNC;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hwD5caHw;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81008606A332
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 16:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81008606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zb8L6sNC;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hwD5caHw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793203498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSkPhi8dGQVlMB+aYtf/PbRbQYkLH9iaxEtJasH6Snw=;
	b=Zb8L6sNCGZ8l3RnNYaGNV6Uyjrq7wLfFdlBr1esAzSJhK6K+KPZnvfBG6aqBF/oIT3sqRI
	vbmoy7TvIlsOo2hyW7QxhcbjMOyfZevOyV+RfaOQgxM6GvWSAEt/I+o9P5HHpDOMjlUnP1
	Z8YptAo8FyT+d+ECNWf+ME+OSMBqRig=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-8KGdfdA_Ny-qF8oJtaERoQ-1; Wed, 28 Oct 2026 12:04:57 -0400
X-MC-Unique: 8KGdfdA_Ny-qF8oJtaERoQ-1
X-Mimecast-MFC-AGG-ID: 8KGdfdA_Ny-qF8oJtaERoQ_1793203496
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e0389d6f9so709243f8f.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 09:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793203496; x=1793808296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SSkPhi8dGQVlMB+aYtf/PbRbQYkLH9iaxEtJasH6Snw=;
        b=hwD5caHwuUr0GO1phfZ0LJcjVKjwpESSfecSxSZ1FuiCxF948RqAoik6FStbxEvy+t
         i5Hb3LNJhxTNqbGHhf8Xr3gxBX6VS+Ii1s1po+gXQXNB7M2ebQHI0oJ2FdAHo/Llc4Fu
         swJPfBIpJpqOaRTQOMpeL/sMc63UMFNHkr8kamga4K4zoIkoV7Wm14Pz65/hu2HjY89h
         UEyXStjjVUkJ4I8uIOzYkdVn5nofhCvTeqV40zDbNLIzBt2J35iqMHKxuWunOkGj/6S8
         H8PQJpwtp1CQcWTaL71Bme9BF92TZLR1y7XYuUEFnnH9NbPAGGmg52ET4phdDjX/bdpX
         KBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203496; x=1793808296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SSkPhi8dGQVlMB+aYtf/PbRbQYkLH9iaxEtJasH6Snw=;
        b=xp4bLNI37oBazo6rg8F+N/iE+Y5PTMO+a77R0eN0HopIOBjS8VsOlgTKNZ1X0FR44T
         69jL1PLLSkeKyyQRmYkbxO5JPsC6yaOX51OCzJD/vf7wO3UbTIInAd1VXABJe2+1biHB
         14wvawH4mE8YHz/mQwYVqSvkaa4hYqnbU1gdqzN7NbonlKVPY5QESg83vR+XcTQFutP3
         rTXcDA6mKRjB6XH2vtH0dg/rtHTSdvQWrWDfF11J20hm1DEk44DGM3h0iMSyX1QZDHuF
         kFa6/Y6hrOw7albouqkI0fiuHmgSyP0/yoMtWaufvZuc5+WWe9zF23dEM7/iweoQEcOd
         nhiQ==
X-Forwarded-Encrypted: i=1; AKwUvBxs77exq4OFK5+lQIloq3Jpb7WF3AxfXfoFiEvhq64VdyGghrD39jK2AGpaF3+lgnq7hws=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiEnz06auUX3MuKM24/pj3OSrTElado6Y7ySduAGPJA6Go1CxG
	AJJMR3G58VIdFoF8bRWAMTgLlkiOW+Ti+ob9W5xR0w6JxXgCU8C+WeGp9668fjIkBMPt6B1SsOu
	Tcw7Hir4cxHByy743FDqsSNLKey1kH3bKp+ajh5r0ejWgeZuDGtrW7A==
X-Gm-Gg: AYBFou3ePrXD5CY8gHDYN6Ngl0ArwIzKjEjUxMB/JuR3If+uVQmzgAyZfCTW6tVBfz4
	VZH/9oDmSFyTNbY0j3fAu51EzVf7wl9ojlZFDpUS4SGcvXSVOeyIs9R0P63GvLaqlSsM2sA4zms
	lOrMUjZsdiZdhO47OuZLRdJr0mZFewKvR54b0NN4eqyChw1Ok/W233rMssUGmfaAF4HPgMqtVW8
	7A4B0ofkDD/8EYVJZqQaldzgnLe/Bt08t8IYmbeuRCJri0vTTzvbm78a+CaC9NrWWqldi0KCGFd
	n6Z6XhSxMIyenoHeOZtnZlCkRcHYiwT4Ae73PLOX8gzPML5DqFvoD8nCu8v4yy1NvAL7RMNYAJz
	SlhqwmQACKfU2FZ8JIxfJJ5EfMFDj8/LqNgIsC4CvZHvru8zcY6vuo37bGkk8HVNagf7y8Vv86V
	zCBgfH+feFoyI=
X-Received: by 2002:a05:6000:716:b0:48b:a21:87f7 with SMTP id ffacd0b85a97d-48e5d5c9c95mr6585806f8f.44.1793203496208;
        Wed, 28 Oct 2026 09:04:56 -0700 (PDT)
X-Received: by 2002:a05:6000:716:b0:48b:a21:87f7 with SMTP id ffacd0b85a97d-48e5d5c9c95mr6585714f8f.44.1793203495734;
        Wed, 28 Oct 2026 09:04:55 -0700 (PDT)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm31898410f8f.32.2026.10.28.09.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:04:53 -0700 (PDT)
From: Sergio Lopez <slp@redhat.com>
Date: Wed, 28 Oct 2026 17:04:30 +0100
Subject: [PATCH RFC 1/8] vsock: expose the core port allocator to
 transports
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
Message-Id: <20261028-vsock-dgram-support-v1-1-e457cf7cee78@sinrega.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3348; i=slp@sinrega.org;
 h=from:subject:message-id; bh=ZVfitmWvovEVraPH2yKqVmQ45Xs6izvUaaK6WM4R6S4=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq4h0bLdtFFdUt+9phG13qqSnimHyJCpaDLG0Z5
 DiYDKILoSGJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCauIdGwAKCRD0aSeNLwwC
 NTUUD/99aty+2+zABLMczLqyMyImvg9HHzvlVIclUDMBbDktLeL2OztcC/MZksZsXkAUEdFBdWK
 0BtutrnOl4mzj1rWPhwYG/pp41y+h5TmCbAfxbjRR8bXOWxBQU0wVrc2quDODDzfHZDHyAXR7wo
 3LZp7Ay9NvGAntY+DzJHDPdxeP+1+E7iqHQfDreVxQ0hyIKjec54U2qQENi0azxnYEwFw+uKT0d
 jjEcHq/8a1TKE/SejNJym7lat/wuTdr8V2Mwq7Z7LRvmLEKcQyUQv30oqZhX2KEqMQ873sSlW+g
 RXXpvHL9YwnTslLEaIEs436kjS7UOp2CQTYhP+GF6uoXGSk/cnjMmganPiFHLq0fZc5ofSXVrkh
 zTliYit2e2PxL3pylrdaGx2W57aMdQyGp2hgue/bzqD85ThvXa9D2LrH+fRuyQ5PjAFHapqRM2R
 TzevKHS7x98iO81NnlokdPUspNroi1b1AA2+t8IehSSVQmylHeKHx6LWyRt9NzeFHEF24kn1LMq
 NMeH1GtWIHj/hdoL46Sbu2xRLhhmVq9HIis3035qr6iV1I5G6PXYrDmsaUzvPQvA2aWn+FqICqX
 D5RR9CLCgbWQ8Yng0ceht3SCEu9YwI7kqptm8uKFZsXke0qLkASugHYjkMc7UbQZUGx96jTXpSf
 jhAW+SoluQExiRg==
X-Developer-Key: i=slp@sinrega.org; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

The core port allocator is currently private to connection-oriented
sockets. Virtio datagrams need the same bound-socket lookup tables and
port allocation, while VMCI datagrams must keep their own endpoint
creation and port namespace.

Export vsock_bind_common() with the bound-table locking inside the
helper, and use it for stream and SEQPACKET binds. Keep datagram binds
delegated to the transport so a transport can opt into the core
allocator without changing other transports' binding behavior.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 include/net/af_vsock.h   |  1 +
 net/vmw_vsock/af_vsock.c | 31 ++++++++++++++++++++++---------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index e8481f12312e..19bd9c1c3e5b 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -220,6 +220,7 @@ void vsock_remove_pending(struct sock *listener, struct sock *pending);
 void vsock_enqueue_accept(struct sock *listener, struct sock *connected);
 void vsock_pending_to_accept(struct sock *listener, struct sock *pending);
 void vsock_insert_connected(struct vsock_sock *vsk);
+int vsock_bind_common(struct vsock_sock *vsk, struct sockaddr_vm *addr);
 void vsock_remove_bound(struct vsock_sock *vsk);
 void vsock_remove_connected(struct vsock_sock *vsk);
 struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d0508887a2fb..5d1d85e5f519 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -832,8 +832,8 @@ static void vsock_pending_work(struct work_struct *work)
 
 /**** SOCKET OPERATIONS ****/
 
-static int __vsock_bind_connectible(struct vsock_sock *vsk,
-				    struct sockaddr_vm *addr)
+static int __vsock_bind_common(struct vsock_sock *vsk,
+			       struct sockaddr_vm *addr)
 {
 	struct net *net = sock_net(sk_vsock(vsk));
 	struct sockaddr_vm new_addr;
@@ -888,11 +888,26 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 	return 0;
 }
 
-static int __vsock_bind_dgram(struct vsock_sock *vsk,
-			      struct sockaddr_vm *addr)
+/**
+ * vsock_bind_common - bind a socket using the core port allocator
+ * @vsk: socket to bind
+ * @addr: local address to bind to
+ *
+ * The caller must hold the socket lock.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int vsock_bind_common(struct vsock_sock *vsk, struct sockaddr_vm *addr)
 {
-	return vsk->transport->dgram_bind(vsk, addr);
+	int ret;
+
+	spin_lock_bh(&vsock_table_lock);
+	ret = __vsock_bind_common(vsk, addr);
+	spin_unlock_bh(&vsock_table_lock);
+
+	return ret;
 }
+EXPORT_SYMBOL_GPL(vsock_bind_common);
 
 static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
 {
@@ -914,13 +929,11 @@ static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
 	switch (sk->sk_socket->type) {
 	case SOCK_STREAM:
 	case SOCK_SEQPACKET:
-		spin_lock_bh(&vsock_table_lock);
-		retval = __vsock_bind_connectible(vsk, addr);
-		spin_unlock_bh(&vsock_table_lock);
+		retval = vsock_bind_common(vsk, addr);
 		break;
 
 	case SOCK_DGRAM:
-		retval = __vsock_bind_dgram(vsk, addr);
+		retval = vsk->transport->dgram_bind(vsk, addr);
 		break;
 
 	default:

-- 
2.56.0

