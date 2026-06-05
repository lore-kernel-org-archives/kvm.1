Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21D43CF21D
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687192; cv=none; b=fyPojXfpk+5Hx7U/vjc9lA1LOtoA+KG3VsWMMQoUjrWnJOctCQWFhknRVv1i1fIKsLg2KazyhpkTte9p9bOs4mR+Qo7xnSugI/p+Dy0DFiVZgecNWU5Lyd/G5icMAwwuBcqpkyG6IAghh/TiUCS6xzElA6v2N8IzwtDLdxGYlv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687192; c=relaxed/simple;
	bh=lQyeoEHvPDcTd8UBfI28l1PrKOeUuXwWGO6rNePL3aM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fQYuOI3d0pU922V0id3oLpHsYlqUJXcit864abWfmjBqo2lsxj3MuYQ0rOFKPUcyENM6HzE2SFVznoToanOZTjJCBgy86LufLIpIJqU9MfMbR6t9gxCblCgumufCXHJY88jNgpikNu2a43ob3i/AJZ0EcLjnFsshYOLP56/M5Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=eCcGzrJ4; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="eCcGzrJ4"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36b7b802299so291016a91.1
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 12:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1780687184; x=1781291984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0vJH8NNd0RF41K/4FCBtez2ytaf4nIFe3x4aSA4G5w=;
        b=eCcGzrJ4DDhZBO/s4Ntwd+hvBl/td6H2K4Kz8xGIIvcHauLoogijSjsyweD7TG1jZK
         A2RmBx2Xkz8DtAhduy5k2tPwehKJki2ZV1RfRiYlEEVWG3lYihK/rxbHmjRoCWYr0UPD
         Syj9Qv0wW2Sy9yKSfEQ3F0NQMg3esKIhBp2GmmgTgInWW/9dBiG9155fivTKff9bn9y5
         AtYVksSDXPWAowQNxjP0Yd1Un6Onp4O10g1C6liujsxCho+Hf7VJVpgmJxr0KzFmHEfN
         TPcKdaOZ68pVbgbeQpH/LIkUSr2UFKuUQEa/EvwIXE+bCB5fVkE3Jpe1Y5IuMCU26pXC
         0O2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780687184; x=1781291984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0vJH8NNd0RF41K/4FCBtez2ytaf4nIFe3x4aSA4G5w=;
        b=sZNLVk9ioFPaMtdX2RVmN7OmjJPlkE1PGKA1zY/dmBIFRKtDl6IUO1evWu1XUY5fee
         MkD2N9vNTUX6teHAfB34mR//fSb3chZmFGnQONMXa1q3Ieaj8SwEokeaRM+TppSFc1au
         3ZybmEw7CVnUPiN86+X/oCYE0l8r2kLSR2+bjI2TwiDTRm7vz3AcCr0w5kDbF6ArdCUr
         gORjZ+KenbUO2WKsVkpDns8klHgNev+pyF8uhynsw6xbUaG75S2WJkSnl+n6jzdctYsP
         QgFupr2ZCf1vJZ0CNJnvWpuHJ6WEK8mpAKBu4a9Pfor/I1HdMMDNBFD4ME7lsztpbpX1
         8Bhw==
X-Forwarded-Encrypted: i=1; AFNElJ/NqVASlu5RzLz8neZFwYhta0E6A2EmCIcZ0/EpQTReYziMXpXvGe4zVK6M/EXvwjuCf+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyACqEzEnhvXlLdNiLGhXWv0rnim2SlirrsrrSPJNv6x36KG8G3
	AtxDCtsZbgSenFZozqFiNUroCgSuBgqe/XGIFqHuxaFl+YCbEp9mgb+rlywEgjHRpg==
X-Gm-Gg: Acq92OHO9BA6m2cLf2Mv+BXQ4+L0C+UwRNDVuxxsfKUqMkdHmyLL8g4e8eEOABRvKz3
	2A8IhRzXGF8UzNOSPdaqRwokrYQgtNEMDEh/JzKGIs65YGmiya/SMcMSmCr+QJ0z4kkohj/+Eaa
	LcqZdfNUae3zBJkL30wp3lFUogfiDXQd46gIBnxzJf7GdNWGgc29iLFPW0G0UujydcSXE7pf89c
	MD0kF7VPNYyBGFKA2UwUUBg7jItyJVr855lgwiyB/lg36uIjiYXQos4ceL5ON4OiB462fw0ya4t
	bHTX33uwLnD/EnpGfoHCiF//XWGsKt13DX98Z4GNDUPIfRyVKj+e+cSx3nKX8+/DADFAK3CD4Mb
	35cRZl1Ws2W3WwzLFUV3VU4oS7OrXS3PAXAmA5YJCkLqiTfCJxVBEKZvqz3/W1nyXhqgPPrR0Dz
	d/cepLwuSPGpzGXynb0zZp6cCvBM1e2cIroGKvtjLZRn4jBfDo6/aGQ7xplBSaxQ==
X-Received: by 2002:a17:90b:3dcf:b0:36b:3ecd:88d7 with SMTP id 98e67ed59e1d1-370ef0f50ffmr2677491a91.2.1780687183832;
        Fri, 05 Jun 2026 12:19:43 -0700 (PDT)
Received: from localhost.localdomain ([106.51.195.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842820e8e6asm9757737b3a.0.2026.06.05.12.19.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Jun 2026 12:19:43 -0700 (PDT)
From: Divya Mankani <divyakm@cs.unc.edu>
X-Google-Original-From: Divya Mankani <divyakm@unc.edu>
To: kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
	Divya Mankani <divyakm@unc.edu>
Subject: [PATCH] vsock/virtio: fix memory leak in virtio_transport_recv_listen
Date: Sat,  6 Jun 2026 00:49:22 +0530
Message-ID: <20260605191922.12720-1-divyakm@unc.edu>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a memory leak inside virtio_transport_recv_listen
caused by a race condition when the parent listener socket shuts down
while an incoming packet is being enqueued.

Fix this by locking the parent socket and verifying its shutdown
state under the lock before executing vsock_enqueue_accept().

Fixes: a478546a782a ("vsock/virtio: add support for listen sockets")
Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
Signed-off-by: Divya Mankani <divyakm@unc.edu>
---
 net/vmw_vsock/virtio_transport_common.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 3b294164b..8006a13bb 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1571,15 +1571,20 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	vsock_addr_init(&vchild->remote_addr, le64_to_cpu(hdr->src_cid),
 			le32_to_cpu(hdr->src_port));
 
-	ret = vsock_assign_transport(vchild, vsk);
-	/* Transport assigned (looking at remote_addr) must be the same
-	 * where we received the request.
+	/* Lock the parent listener socket to synchronize with a potential
+	 * simultaneous shutdown thread running __vsock_release().
 	 */
-	if (ret || vchild->transport != &t->transport) {
+	lock_sock(sk);
+
+	/* Check if the listener socket was shut down while we were
+	 * creating and configuring the child socket.
+	 */
+	if (sk->sk_shutdown == SHUTDOWN_MASK) {
+		release_sock(sk);
 		release_sock(child);
 		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
 		sock_put(child);
-		return ret;
+		return -ESHUTDOWN;
 	}
 
 	sk_acceptq_added(sk);
@@ -1590,6 +1595,8 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	vsock_enqueue_accept(sk, child);
 	virtio_transport_send_response(vchild, skb);
 
+	/* Safely release both locked objects */
+	release_sock(sk);
 	release_sock(child);
 
 	sk->sk_data_ready(sk);
-- 
2.50.1 (Apple Git-155)

