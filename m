Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738791AA7A6
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043024; cv=none; b=cRIWBP0kzGnesoH9DPI71m1Eer5H8gRikahTRgjqGtWcR5Yr+GW9fApPtVJs7rpIrrnx11dIumC8lv9qZ2Txvf/5zocXuahAFBijvMp6sNJ+oJNWRUjLEIirIgSJZ8nrAa6flnNOiEQ8bNPCN8uXpZDqlkV6P+EGZGxRZJOjTwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043024; c=relaxed/simple;
	bh=sam5CzX7hUFWo2rSuIUY9jL5rVRI1ZwRvCUUTaLpc/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YYWXTzcbUJ06AFn4ZzK2kIyUZoIy0BdBWPtQtWhjgoyRN3VCtb5jaEpbtBOj5jBZKI/d3S3b1yvyPx8kJgvZSn6vVWNtxJNEN0mPC+wNC36WuRDpnVHUPpLeSq9I/olfyQA/w8UNKc/E/jOpFtFNPmckcfjk5ctBHxwNFuScl7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ea9yJbyH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea9yJbyH"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b0afa0210bso36752115ad.2
        for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777043023; x=1777647823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gdnOmdvYkq1xF25fAEazaVF6DIg+bGDl6V2EYI1zKDU=;
        b=Ea9yJbyHQe82ThmrdwNs9z9RSGsQMh08rJfRXjLI0A/EKGyvxSHOcseDdXM8enl6aw
         ZTTE4RgSUOgs28it5Xj47AdbqXFfnfjxTjCqoSLHoLDWCLF/gzepeIxoT0C1I4ew68i2
         C7W1+PsA1CdnUczpB3Ux94tUjJNRv9qFeQUP+lRHljHIuAH9dwb8jrIZa7sIOoOsTAEB
         l5QVAHuVcUimynAFtMPqEnNnaUiWDQSj3tYB9gw4UYAVW7nwpuWLJ9fJyZ6U938PL4aj
         gkheKpepmyTGJ2zQulMx4AkRR1XobfJbzNnYZOPr0m5KLLgIlst2xk2VxRuZdQ9GoIn1
         9M8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777043023; x=1777647823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdnOmdvYkq1xF25fAEazaVF6DIg+bGDl6V2EYI1zKDU=;
        b=GQqSGNCaKd4y7SpCabKe2dYbJrj/0YXwxIwPIux66w5mbmokYftEGYUxnA7OzwJZdH
         yFSBNspxlAkhhYZH0RmPkZyejR/7IimqiBs0/O/DXgVWA3IsmHhoxF11q3RTOGZguGJj
         wZh/F955P46gpknIQSpw7Y2ie4TcsY33IhSYz4MmlFSVHTCdYYraeqh2pnbF+G7zbZMB
         xn+uo/QRGpYFQw2Ah3XEZfHuPevZtYWO85kHKCAKUuzrtHVNXOZwIqTbf3Jof9+YetOO
         RChCdmqtWKKu3Y8B1fl272Co5eOnd7loOTinjZsdoBIZo2AsSGGH5xSD7mheWEKEMfIc
         lJTQ==
X-Forwarded-Encrypted: i=1; AFNElJ/h27x8lqWz9Io8FkzPWN2Gen78oHl6kz27rOCZG9ECp+XWmJGqczRFTlLBQJN2yp96g4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF/cvBZh6O6nwdIQNx3cIhiDUy3p2BUDABEGwHF72I7ehpLaq+
	Xznck4NHr366BoJX07rMLt61015/39fux4XmiZAlk7sklGmIf08Wovy4
X-Gm-Gg: AeBDiespMuOdV6qjjVpnv/JVm78YDEDKblqVdQn/BTp//km1zoCQ5HROlioMhjO9mPv
	JhtQFK7Drm1UKfV1+Rz/4p8/zvh9o59U5o6f4XFxdpLBLN+AE47zSFEmoa1G987sVmm1hwi/b3o
	Epw0fK5bcYcgeKq2EF+JjOXqJYsTgLg4BNfdzNzRvrAzlV9G88GXIeSh0pPLjH86ZDiiKjQcnzb
	Wmgp7YfmDMsgfqH1/GrPTX1s05Yy9gy9UDIyo4qiLcfi403HmwPpML4DE6WK5nFdSwYEuTGQ8WA
	gGZfTVzaerM6Wr9gUIt7maszu94kZWrAK/nAlv1AqL4ClUiLx1/OUN0LHwfHxOrx/y5+8YBf7YV
	iewa1u3ix1hy+ezsC1isefY8vQJT8cs6pEJFyQlfUbr10Wos71eRWA2x4/7GW7OGrrxkTqang3/
	RH5ImxZ2JGCfu/epxFcAv4/xz+KkyyJ+qVDIWhH/WUT3yx8F/PZ7W7DWEiOIxuFQG9wUu+gzgWA
	W6jQJOiJLFKm7Nc
X-Received: by 2002:a17:903:286:b0:2b2:680c:2193 with SMTP id d9443c01a7336-2b5f9f64affmr349377755ad.31.1777043022350;
        Fri, 24 Apr 2026 08:03:42 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:ba99:851:d885:8271])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab4cc47sm233257465ad.82.2026.04.24.08.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 08:03:41 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Subject: [PATCH] vsock/virtio: fix memory leak in virtio_transport_recv_listen()
Date: Fri, 24 Apr 2026 20:33:10 +0530
Message-ID: <20260424150310.57228-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two bugs exist in virtio_transport_recv_listen():

1. On the transport assignment error path, sk_acceptq_added() is called
   but sk_acceptq_removed() is never called when vsock_assign_transport()
   fails or assigns a different transport than expected. This causes the
   parent listener's accept backlog counter to be permanently inflated,
   eventually causing sk_acceptq_is_full() to reject legitimate incoming
   connections.

2. There is a race between __vsock_release() and vsock_enqueue_accept().
   __vsock_release() sets sk->sk_shutdown to SHUTDOWN_MASK and flushes
   the accept queue under the parent socket lock. However,
   virtio_transport_recv_listen() checks sk_shutdown and subsequently
   calls vsock_enqueue_accept() without holding the parent socket lock.
   This means a child socket can be enqueued after __vsock_release() has
   already flushed the queue, causing the child socket and its associated
   resources to leak
   permanently. The existing comment in the code hints at this race but
   the fix was never implemented.

Fix both issues: add sk_acceptq_removed() on the transport error path,
and re-check sk->sk_shutdown under the parent socket lock before calling
vsock_enqueue_accept() to close the race window. The child socket lock
is released before acquiring the parent socket lock to maintain correct
lock ordering (parent before child).

Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
Tested-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 416d533f493d..fad5fa4a4296 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1578,6 +1578,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	 */
 	if (ret || vchild->transport != &t->transport) {
 		release_sock(child);
+		sk_acceptq_removed(sk);
 		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
 		sock_put(child);
 		return ret;
@@ -1588,11 +1589,19 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 		child->sk_write_space(child);
 
 	vsock_insert_connected(vchild);
+	release_sock(child);
+	lock_sock(sk);
+	if (sk->sk_shutdown == SHUTDOWN_MASK) {
+		release_sock(sk);
+		sk_acceptq_removed(sk);
+		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
+		sock_put(child);
+		return -ESHUTDOWN;
+	}
 	vsock_enqueue_accept(sk, child);
+	release_sock(sk);
 	virtio_transport_send_response(vchild, skb);
 
-	release_sock(child);
-
 	sk->sk_data_ready(sk);
 	return 0;
 }
-- 
2.43.0

