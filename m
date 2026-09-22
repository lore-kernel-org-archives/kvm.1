Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF275540A9;
	Tue, 22 Sep 2026 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082964; cv=none; b=nLWlGfsaidT9XXWfqJESKLZp9jT927XbfT7JgBXBYJnDJoSM7G1iD8KpChJ2AkplaK16XHIImu8bJ+bMOTqHy20jh6XAjUh2refV+mkFGzmVEErfYQF5L+PKC+A3AHDjsoyyzXpVt2YlA/iHD8yMbam9b9dBIOyPqzdhrws1vfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082964; c=relaxed/simple;
	bh=xjxMj5fyJ8uRoxQUEePWAv5baer14/CnbPc2DvpEEm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cgHb9otxxysQgzh0om4A1168JHVQnMXVsiawXDrW0RsXMaXTcjZnFEpF9vHCwqqJf+GW1HJLfDm6brJF9nSaIdaCNxu/sUj4QRdsu62BoPRTM0D3JzvoEE5bAy0+tdmA5mnzxKFvqz7o6zfPEp91aQPSgou9ciY2cO3jXUxH5Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=pi+CCpbg; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="pi+CCpbg"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x90LI-0038Nt-5H; Tue, 22 Sep 2026 15:15:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=q577QjiF0mCARGW9xPaIu3zNyMU5NJhn62SphWcTBHI=; b=pi+CCpbgIJ6+RdP4k9VTlBvvtv
	rQ0zZ/L3wzyngCgE+lwfzBRiIv4EXgru6jqoHziFZ0qAk0lGRu4jZIsbMUD+A5obPGa7GGkkv7P7F
	fThqc6R/rpOpsugrOTY6DjafuV/hk0ahOzuhs6VZWzW5RDtfiuk90QclQokjhNTUN7Ntc1b90YGfj
	tiFCH9F2b76XNs/c2fkTce/WNMKaceYhqvJGUTt1hkl+z0eTRNoZFBRxl137oGa6mF9yu2GiRc3q3
	BYLKWob00+GTpntk47/eXBlGgR8fRvtl2+wNRASBWHCWPnY+Sgz353Q27itP9L0o44LN0d3BPkFTr
	EFCdNOjg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x90LC-0004lC-81; Tue, 22 Sep 2026 15:15:22 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x90L2-00FyKH-66;
	Tue, 22 Sep 2026 15:15:12 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 22 Sep 2026 15:14:58 +0200
Subject: [PATCH net v3 4/8] vsock: drop the re-assignment logic
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-vsock-connect-reset-closing-v3-4-78907b8200d4@rbox.co>
References: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
In-Reply-To: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

On a failed connect(), transport is de-assigned. Connected socket keeps
transport until close(). Hence, no more re-assigning.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 20181ddde114..5cecd1c9c6e5 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -604,6 +604,9 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 	__u8 remote_flags;
 	int ret;
 
+	if (WARN_ON_ONCE(vsk->transport || vsk->trans))
+		return -EINVAL;
+
 	/* If the packet is coming with the source and destination CIDs higher
 	 * than VMADDR_CID_HOST, then a vsock channel where all the packets are
 	 * forwarded to the host should be established. Then the host will
@@ -649,11 +652,6 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		goto err;
 	}
 
-	if (vsk->transport && vsk->transport == new_transport) {
-		ret = 0;
-		goto err;
-	}
-
 	/* We increase the module refcnt to prevent the transport unloading
 	 * while there are open sockets assigned to it.
 	 */
@@ -668,26 +666,6 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 	 */
 	mutex_unlock(&vsock_register_mutex);
 
-	if (vsk->transport) {
-		/* transport->release() must be called with sock lock acquired.
-		 * This path can only be taken during vsock_connect(), where we
-		 * have already held the sock lock. In the other cases, this
-		 * function is called on a new socket which is not assigned to
-		 * any transport.
-		 */
-		vsk->transport->release(vsk);
-		vsock_deassign_transport(vsk);
-
-		/* transport's release() and destruct() can touch some socket
-		 * state, since we are reassigning the socket to a new transport
-		 * during vsock_connect(), let's reset these fields to have a
-		 * clean state.
-		 */
-		sock_reset_flag(sk, SOCK_DONE);
-		sk->sk_state = TCP_CLOSE;
-		WRITE_ONCE(vsk->peer_shutdown, 0);
-	}
-
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
 		    !new_transport->seqpacket_allow(vsk, remote_cid)) {

-- 
2.55.0

