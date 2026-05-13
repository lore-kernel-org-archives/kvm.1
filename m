Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE623909B8
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669673; cv=none; b=lgFEbTxIpIMyn8yjPWbOKcTxL3bnOOdu4ri5nfKASkx8oQvM5/MkvaQn8kHN9Ta/O0urMgC1eQmiQ/q7pDlzg6rQll6TytAPDO5jDpF7mh1xD3ZpngMS16UHwitZohiRC/8CE2euH5fnQudcqxtLmllyEqQadNv3vI/5HYrWzjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669673; c=relaxed/simple;
	bh=ttq2nGPLIE/1il8H5a57hLhcGZjBjCwtRxosBU4xsEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYN8M0dhqYr+zhbHt5h2PAXD3F14QawGKqvws0TLctWRK0WN9jys5k1ZkAoMBrhrDAaSTZeJDfVJELklKngIeYWA4B623Xi/72U4WkuU7CYoysxaZ6OdwZuHcpKCK6TFKHtzIQBo1L54v92rvz/rVdUkD/U4MUAREYsk7sRqKus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ud1+8sjU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K02HUe/r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ud1+8sjU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K02HUe/r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778669669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAFSeIkpvfQYT7wQ2CerCQBM43nlr6dVNS3iNHBRyXI=;
	b=Ud1+8sjUbcrIvoooo+Y3ZgevTHIGjElv/dQ7RmiBAFFm6gzyMDKQaXCN6Kb2eTNlIiqy/E
	wjGaNLL/BPyK1AkLCLGHYAM2dJFbNp9MMsIQeYuQhTwl/7fbWLnz43+piNxUj28UAD/lWK
	3whU0Q37LfY1g15XgTLgfgyGetrvEms=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-TeuTsvhuNWejZZEM5ebLmg-1; Wed, 13 May 2026 06:54:27 -0400
X-MC-Unique: TeuTsvhuNWejZZEM5ebLmg-1
X-Mimecast-MFC-AGG-ID: TeuTsvhuNWejZZEM5ebLmg_1778669667
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48d0677b5f7so37603725e9.1
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 03:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778669666; x=1779274466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAFSeIkpvfQYT7wQ2CerCQBM43nlr6dVNS3iNHBRyXI=;
        b=K02HUe/rsMpD/tQD06xhMtM7KoVrVMTQng7xwzABJNvIYhfV7UCCgzvH1z2leR0xNg
         fvPGRdDxbvXm0aHtapEcC5ghAATaYmeVwsnew3WYRyyeJBmtUjVFER3cui4KTaMoxmWS
         JgJDnHXoTA5a61GKJdp/Q5tUQjjYSBTnjHUiOHfHEG+Aef3iN5S0jAmXHBE7O9MJwl4j
         QAZl1jeDDcy80A50Ri3D8ziCx41LR0eZqNwypX+qV7660Re1kzRkbZsfM450eSM5f4sJ
         gLTOq6+piexZxApPH8fFXGQEdREGJctitviFYyG/0fpLmkrc9qQeJGlc92U3KzwDgh+u
         siaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778669666; x=1779274466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PAFSeIkpvfQYT7wQ2CerCQBM43nlr6dVNS3iNHBRyXI=;
        b=g2vpF1y317apCAwxF0SgXoAUmuS7+DVDthiGZgPbDSjU+1KVNPB3TM1304/eReA4a8
         xKVREyBUXf981e4/fReSFIlryhDxK6g/36KFslB/sT3goRrTopMKJCtlZJT/avNjFrfv
         cQUNg6zF/diVt1TckVs6jdlRwJ4CARkoInpoah21aolEpbAPCgm5k3E5yh6wNcTGR8Ow
         A9MNb/cBM4HAoxBpUIia39+XufGd3nk4hzvw1HE0SSdWLjwfH6SpPoZmsrIBIIuC+TQf
         nx/Seht6o26fxL/q3sy2LjyNs7hQydQM8xOEC+Mcz+wllgmCefoHhV5URYcXMG5yufvo
         4BHw==
X-Forwarded-Encrypted: i=1; AFNElJ867HlyrjEp9nc2cHdD/3ffk/kDY98fwHXSXcdMMwm5K0LRBLu6OaftkG4dOE/76t0RdOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKIGX9h2/b8QN9MVVDvYI4O9J/036taqGApAGjNMcg52iZvj3s
	IsZjBtK9mtEJgvfBNs1TNLh3pCclwbyQYYiKNc+wfMl9p3VcElh5XnETi9497iuimsl62tJjD4e
	oi5bAW+ccCWWaIi32HYAO8K59VkCAV+UUbB0rLAhT+Ls0hhTvk1V6wg==
X-Gm-Gg: Acq92OFTM2FlFv8lzrEmgw+jQ5CQ4lnyKUWCjaYksYWTg3Niad5y884jc5EzQe3LAAD
	L0jHuIE2P6B9a1uGJKQku7XSgtwe78nzkRRXOvmtWu8/CaRoXWsXQHpUedEUz/ACST+o0Pgc4EM
	14Ncaym55/Q6mFrgq10o+lnuYNfhp1Qrl1zqqUwIxzMx+zXoi9qqrRpTQ5YILuIhLxz8BbH7CX0
	h/OmHpcU6AlHV0n4u2rFiXgwbepA6XWjE67pGkbGshupFmBsk2YbBbCH3s9dE0f5L+B9RfuBMm7
	ZI/DKtdamY/JhGh80C+QgAXshm0pphLr50ufZj4mfltC1GJBVnc1UpT27t9YqiVMr3vUZylT5yr
	lKaSwGoB9iQeKkoZlQacNMDituBrejgSYhTVh8w62jak/uzWoEy7BbtcqcgKS
X-Received: by 2002:a05:600c:4f54:b0:488:ab1d:dcc5 with SMTP id 5b1f17b1804b1-48fc9a4b276mr40460265e9.27.1778669666586;
        Wed, 13 May 2026 03:54:26 -0700 (PDT)
X-Received: by 2002:a05:600c:4f54:b0:488:ab1d:dcc5 with SMTP id 5b1f17b1804b1-48fc9a4b276mr40459645e9.27.1778669666028;
        Wed, 13 May 2026 03:54:26 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d27d31sm106419235e9.8.2026.05.13.03.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:54:24 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH net v3 1/2] vsock/virtio: reset connection on receiving queue overflow
Date: Wed, 13 May 2026 12:54:16 +0200
Message-ID: <20260513105417.56761-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513105417.56761-1-sgarzare@redhat.com>
References: <20260513105417.56761-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

When there is no more space to queue an incoming packet, the packet is
silently dropped. This causes data loss without any notification to
either peer, since there is no retransmission.

Under normal circumstances, this should never happen. However, it could
happen if the other peer doesn't respect the credit, or if the skb
overhead, which we recently began to take into account with commit
059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
is too high.

Fix this by resetting the connection and setting the local socket error
to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
packet, so both peers are explicitly notified of the failure rather than
silently losing data.

Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 989cc252d3d3..4a4ac69d1ad1 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1350,7 +1350,7 @@ virtio_transport_recv_connecting(struct sock *sk,
 	return err;
 }
 
-static void
+static bool
 virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 			      struct sk_buff *skb)
 {
@@ -1365,10 +1365,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_lock_bh(&vvs->rx_lock);
 
 	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
-	if (!can_enqueue) {
-		free_pkt = true;
+	if (!can_enqueue)
 		goto out;
-	}
 
 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
 		vvs->msg_count++;
@@ -1408,6 +1406,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_unlock_bh(&vvs->rx_lock);
 	if (free_pkt)
 		kfree_skb(skb);
+
+	return can_enqueue;
 }
 
 static int
@@ -1420,7 +1420,16 @@ virtio_transport_recv_connected(struct sock *sk,
 
 	switch (le16_to_cpu(hdr->op)) {
 	case VIRTIO_VSOCK_OP_RW:
-		virtio_transport_recv_enqueue(vsk, skb);
+		if (!virtio_transport_recv_enqueue(vsk, skb)) {
+			/* There is no more space to queue the packet, so let's
+			 * close the connection; otherwise, we'll lose data.
+			 */
+			(void)virtio_transport_reset(vsk, skb);
+			sk->sk_state = TCP_CLOSE;
+			sk->sk_err = ENOBUFS;
+			sk_error_report(sk);
+			break;
+		}
 		vsock_data_ready(sk);
 		return err;
 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
-- 
2.54.0

