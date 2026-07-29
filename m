Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE19C3B27D4
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352653; cv=none; b=Nh6V0oFHvUAb1NJIWQk9krDhy0GnxGylaB44NSGIYIA0zhH5HYNng8wDqN9nfrRA6jrwjxQ4vLl0NC4cJ5uuXPokuVcFEfi86UQo05b0tKs37gYlgrqqEG53wrRa66jkc6euRjlZx6t9ld9REzw45QhWOjOtOKSA2OZv4u8qMWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352653; c=relaxed/simple;
	bh=LINqEAjhBd1g3ddyfQvwFEgKvXuCbYGwNsK5S7WkpgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuwTpuOvLagODm6SrWPduSQgZKFGdFtP1XIOMqyc18lFt2nK1dxhFFVpqjjZuKZa9Bs3IOmUChE3Q6Mc+1mxPwrUnjHhx64IOUUc8ir8ne2ZX7EV36q66wEQk8hcz2pMyVpp2L4TZVzgumOMXAvxg3hahlPEcKJm1jbebmQ0HEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fML5nRua; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fML5nRua"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1278221a91.2
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 12:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785352650; x=1785957450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o0V32/dXsc54OzyFlhNUR5QdyRJlD72q6lujfqiekg8=;
        b=fML5nRuaAysa5wKWhZc6KuGRNDU70tugqgeFlIhBRO//duA5bLbfOlBNnVFgI62mEd
         CZvNM9Ehxsv4jpKpnuYNBeNxpGoP4e9ULXZyQzZ19qIjoHpLunDUm/rnplIxDW75A4eW
         Y82DypjsB+oSjh0GNTkSYivd6FiIKXtBVkFF4SQAwaquk3T8BqNCY7o+YPlAp6UrArw5
         wMC+U9glTL38tJoStqFWX41fBsAQlfZFd34GN3t+s6C1rv2Q42HW+zSRNKjR8ib1uaiK
         6bBhAhcdkroK2cL+letE/q74cQvnfGtYf7Thf7ElCHKogQKUjij8sU1hS8JWWce3h8w5
         dL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785352650; x=1785957450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o0V32/dXsc54OzyFlhNUR5QdyRJlD72q6lujfqiekg8=;
        b=WaIPd0zHtCTsrK+jBbK+XdR1mXJjIovZXXGWJZMNDYkbhvMjl//VaRBMe+gUOypkBM
         NsZf7fMjnMRGa9WlkMr6iwhnuTCkLdP8MJfTtcEfzPe1zwoepdjAcdFnkwI29WiltIWi
         HlrjQzsDZlc5XOWFJ74Lvw8DC6rz42xb2VoGDyOvQzTc6p1TpPDk4id91TuPbZMrPja9
         tjLfPA+i/fps3TY/ltjFP5OoetPLJe8vS6famvyFwWzci5713KAPRYESEXY1Z5p6/poT
         e1xRubdscCoT8ZQk1XIb3ad/S09+qLm2H+GpbLXt/DGJsMdFnIvczj3PeHHsUhX20qVx
         0Neg==
X-Forwarded-Encrypted: i=1; AHgh+Rqg2TXYer+SF1VWlqmISsbnrN4PUSmQoHBjIdiLW84TTENLnSZznLnbJ9IPi+9BgGXPda8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwynUzZfsU+0XaL0QDUzbWVBgt4oNRJjwEdwh65y+xklQyZ6KUT
	8kh+44mZ96NP2qYqj/JPEJJrYL/F5EaS6B/zN2ADP2oYN/c0bZKSNKxf
X-Gm-Gg: AR+sD13umYPFkkNnVIEOFmej2YktW8h6UW2g0X/fLdQB93+D98zIhD4BAjll+pQeab4
	ABmRFV0qx2rOvlaYmUjqkOLbfuEr68t8FOBTlJMhsBMJM6CDr3EOgMp0lTxdKohSdtArTFzGyH+
	IGHmsGcTKo65ZY86jxHz3/TrDaD9ci2sN+ZlJCXco20PtmTcAEbkt8Zc9iF8SyBoRaYqqGJGGgV
	MqwR8Hlk/O1fspUQyKxuWHm+xoPUiQXQpXpR4sIUjM/u+Mdoi4opTn3t2vdRmMyUphFxyGpYv9c
	4YsCe1kbiuQu/1Mk0gaIiGMwpW3eWBy1UZdo+Tc7Tc5T+LvLMTG4gfSexCVDsUVCKZO594vAmbI
	q5SJ/Twxym0dpH53LjgL/kIUsoCiS1qN6hhrKH06gRcbmFrH8Oe3ChjKxpjHxj8PMdMMfynKekW
	bOEMjpP+6RXCtfPeiU9Xrf55ulI7fAoKJ/2a0VY4Peqn+uLTDzbWZbX6xeH1hkPugSAY3f
X-Received: by 2002:a17:90b:37c7:b0:37f:f4ae:5f25 with SMTP id 98e67ed59e1d1-38f99253d52mr124443a91.20.1785352650000;
        Wed, 29 Jul 2026 12:17:30 -0700 (PDT)
Received: from bogon ([2408:8207:1832:1b44::c6b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f81543abfsm833349a91.4.2026.07.29.12.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:17:28 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH v3 1/2] vsock/virtio: read virtqueues under worker locks
Date: Wed, 29 Jul 2026 12:16:54 -0700
Message-ID: <e79f68ad9284c983364fc3ac46904b6d9ef50231.1785352330.git.bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785352330.git.bestswngs@gmail.com>
References: <20260729185831.3247971-1-bestswngs@gmail.com> <cover.1785352330.git.bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit bd50c5dc182b ("vsock/virtio: add support for device
suspend/resume") made the *_run flags transition from false to true when
restore installs replacement virtqueues.  The RX, TX and event workers
read their virtqueue before locking and checking the corresponding flag,
so a worker delayed across freeze and restore can observe the replacement
queue's running state while retaining a pointer to the deleted queue.

Read each virtqueue under its mutex after checking the run flag, keeping
the pointer and state in the same queue generation.

Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Link: https://lore.kernel.org/r/20260727035804.1860862-1-bestswngs@gmail.com
Assisted-by: OpenAI-Codex:gpt-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/vmw_vsock/virtio_transport.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 57f2d6ec3ffc..a8e1dd95ba8c 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct work_struct *work)
 	struct virtqueue *vq;
 	bool added = false;
 
-	vq = vsock->vqs[VSOCK_VQ_TX];
 	mutex_lock(&vsock->tx_lock);
 
 	if (!vsock->tx_run)
 		goto out;
 
+	vq = vsock->vqs[VSOCK_VQ_TX];
+
 	do {
 		struct sk_buff *skb;
 		unsigned int len;
@@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct work_struct *work)
 		container_of(work, struct virtio_vsock, event_work);
 	struct virtqueue *vq;
 
-	vq = vsock->vqs[VSOCK_VQ_EVENT];
-
 	mutex_lock(&vsock->event_lock);
 
 	if (!vsock->event_run)
 		goto out;
 
+	vq = vsock->vqs[VSOCK_VQ_EVENT];
+
 	do {
 		struct virtio_vsock_event *event;
 		unsigned int len;
@@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
 		container_of(work, struct virtio_vsock, rx_work);
 	struct virtqueue *vq;
 
-	vq = vsock->vqs[VSOCK_VQ_RX];
-
 	mutex_lock(&vsock->rx_lock);
 
 	if (!vsock->rx_run)
 		goto out;
 
+	vq = vsock->vqs[VSOCK_VQ_RX];
+
 	do {
 		virtqueue_disable_cb(vq);
 		for (;;) {
-- 
2.55.0

