Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCF824DD15;
	Sun, 14 Jun 2026 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.212.184.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781459305; cv=none; b=jC0F/VXGTf9VOJ7yXDWoHJ6tkQ7Czd1JAtwZ8fzJ8GnUBQWrZidFACtU2sm1r7SMUq/zxi4XrK4xvgLUqSo6bJ8oeFKZJCaHbhLSEzuNU3K3L7CkhsqsFijPnMMUKqjiCqTSHf4e8EG1x7C2Mb/Jb571b4bjFgchD+O8pF0LZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781459305; c=relaxed/simple;
	bh=cV9X6iCjeGCGGaKnmc9UIteri4enJNH7S++iuTX7mBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXq9OLuzcJLtpMt21DFgZkmn+kG5HmKEC48e5ksRmV0g/H8GqkxjnuxCqFCPfBghG0o55aPqnD9H598cdeF6P/7OTDk06H+vza0ncKpre0pDAsmfBH05CHq5xjk862qc3JddC4pi4mY6TAsZsP73WjJeVl4Jc5CvPTv2YP26Ask=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org; spf=pass smtp.mailfrom=rulkc.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=PBGgk4Ny; arc=none smtp.client-ip=155.212.184.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rulkc.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b="PBGgk4Ny"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 013341009EF;
	Sun, 14 Jun 2026 20:48:03 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1781459293; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=qbU7FTOSPWekRxEa6SP3qr2Gku8x/AVx3Rh/8yrUUPA=;
	b=PBGgk4NyA5KZFn0TglHZbVh4O6NdVI6L/LTJmst0TsjZClYaJGEcef5laOZdUeRTgJsnwZ
	Q3YWxYUFaUHxkrUmlfSF9mlFJScSOZOX17yMQKu+gw+36iWYIG7h5R6ZTi2ZhyqZR1uwDU
	YtzfWkp0yXFNiDLXRlWuKPJUJM7veyMyMgr2ZZ7SjZwt9g3cZ98+XUcqWLBYAN6H/0oCsw
	rV581gno9JxOOZlEBUq8xI8l9mntQ6Zod461a92ppO/UhYTBRmAnNqy+N9XVd3/nhHoqE3
	dQYgUvoaBok8yBXBzg7DJ8Ev1njL7YbkCOuKAps7v4dG2qEU3Qyosj+ZtV3+IQ==
From: Arseniy Krasnov <avkrasnov@rulkc.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oxffffaa@gmail.com,
	rulkc@linuxtesting.org,
	Arseniy Krasnov <avkrasnov@rulkc.org>
Subject: [PATCH v2] vsock/virtio: rework MSG_ZEROCOPY flag handling
Date: Sun, 14 Jun 2026 20:47:56 +0300
Message-ID: <20260614174756.170631-1-avkrasnov@rulkc.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Logically it was based on TCP implementation, so make further support
easier, rewrite it in the TCP way.

Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
---
 Changelog v1->v2:
 * Rebase on last 'net-next'. Don't need 'skb_zcopy_set()' now - it was
   already added.

 net/vmw_vsock/virtio_transport_common.c | 48 ++++++++++++-------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 09475007165b..787524b8cb44 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -328,38 +328,36 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
 		return pkt_len;
 
-	if (info->msg) {
-		/* If zerocopy is not enabled by 'setsockopt()', we behave as
-		 * there is no MSG_ZEROCOPY flag set.
+	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
+		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
+		 * 'MSG_ZEROCOPY' flag handling here is based on the same flag
+		 * handling from 'tcp_sendmsg_locked()'.
 		 */
-		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
-			info->msg->msg_flags &= ~MSG_ZEROCOPY;
+		if (info->msg->msg_ubuf) {
+			uarg = info->msg->msg_ubuf;
+			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
+		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
+			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
+						    NULL, false);
+			if (!uarg) {
+				virtio_transport_put_credit(vvs, pkt_len);
+				return -ENOMEM;
+			}
 
-		if (info->msg->msg_flags & MSG_ZEROCOPY)
 			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
 
+			if (!can_zcopy)
+				uarg_to_msgzc(uarg)->zerocopy = 0;
+
+			have_uref = true;
+		}
+
+		/* 'can_zcopy' means that this transmission will be
+		 * in zerocopy way (e.g. using 'frags' array).
+		 */
 		if (can_zcopy)
 			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
 					    (MAX_SKB_FRAGS * PAGE_SIZE));
-
-		if (info->msg->msg_flags & MSG_ZEROCOPY &&
-		    info->op == VIRTIO_VSOCK_OP_RW) {
-			uarg = info->msg->msg_ubuf;
-
-			if (!uarg) {
-				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
-							    pkt_len, NULL, false);
-				if (!uarg) {
-					virtio_transport_put_credit(vvs, pkt_len);
-					return -ENOMEM;
-				}
-
-				if (!can_zcopy)
-					uarg_to_msgzc(uarg)->zerocopy = 0;
-
-				have_uref = true;
-			}
-		}
 	}
 
 	rest_len = pkt_len;
-- 
2.25.1

