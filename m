Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9803C3FB7FA
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669676; cv=none; b=AdQJZYXzpsCfNK4qu/iM+vhGkNiEDSX0vv9S7NSCbgqPwWcmdcwBdJIIrXdc08Kmx7dV5kDBKDrLV4OL/Ze61faJ4yZy/6ebGsh7hj5+KfhO09b8zWH5DfnyaZ4p35vnuZp/W/kSgt9XKyyqUA74SNPn+Mox88RmhEFR8+VMJwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669676; c=relaxed/simple;
	bh=IvdEZvwln3zcfx+cvlKQindvsy3EmR5EckwkcdVQXFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHpWrcA4Si2FNxoI2u30T3ScH6WjgA/ElGR198VEOJ7LTPjOuOOLDRzvdCQO9Katb2tofw4WVEyAF2vE9BV2VxZLEqzClYhHJFFXNekfhOoyYZ/M+gqeQgkJCB4cDSFxq+6C/ERehDqSb4OnWJT+b8ce8ezrU8GrzSYYrST2EoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXcAco1F; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=juwA71bu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXcAco1F";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="juwA71bu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778669673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aGSDbvLykcv2buTIXBcK0yd8xK4cY9P0ZJuiRfh0cTI=;
	b=VXcAco1FPQATQIBfMJUIYOUU0DKWvk/VXKWjBHqPkTiLZwhqZWI/1+E6U5d8TenW3GszP+
	cxK/m+e1fDrStXaoLR9JwFkewqLASsQLXJ8F8u7KGNsqTG6AuefQhuDDeIyH+akGgEcg0g
	L8370jTIbbtc+hUsiPT7rkpGjPEekx4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-1LCKcHRjPpuDxa67F6vWDA-1; Wed, 13 May 2026 06:54:32 -0400
X-MC-Unique: 1LCKcHRjPpuDxa67F6vWDA-1
X-Mimecast-MFC-AGG-ID: 1LCKcHRjPpuDxa67F6vWDA_1778669671
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-441243ba35fso5228875f8f.0
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 03:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778669671; x=1779274471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGSDbvLykcv2buTIXBcK0yd8xK4cY9P0ZJuiRfh0cTI=;
        b=juwA71bu3+DpWVxkvtaiE8MriHnjhdawBICKnY8HPizQRezQBhtVv40XfPXy8NrZ/b
         2EQZtv5O8frk3ZtOqBqC/KPEa+TiW5OPpqpFPRzhaUGTj6VS4NtN7pedKVzJUlFWZI6q
         GYayXwyqIN3Ll062TTyrHI7K39rmaWS37KK6m4WgRjWv6yTyZIMGVRtHolI1j1xAjUD0
         rEQw4hqIjShs3YjNGoUZ5PzPRKLT5yVU4GFaId5CGi1VnaUUFklq5QFPUa7EVLgc+uB0
         3BingDRsYYl3AFV+zLmhdUi936ixDnhgMcJx049m0eT+cEJg/mzCKUi05pRgkhsNzJz/
         tP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778669671; x=1779274471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aGSDbvLykcv2buTIXBcK0yd8xK4cY9P0ZJuiRfh0cTI=;
        b=b97BqyHux5ibfR7A/r80Pso/nj8oyBFA/aTP2q/pIFG/ImPH7WGd5PE+n/4AePHyps
         G2x496AT59ladUZa/tuz4nybQobdUGghhrkyVdIrC9muYbytfv6utUsZ/Q0XgBenqxoB
         +I5g9Oxhj/xzSTdM3zjZBDU+gCk6P0EDnYmZTbzDDUtAEq4sGqyoaMupBfuMq9IX5ew3
         6H5F4JPr2ntuS5Th55KE+wZ4HbQWGRAp0glFXxqO/mK4v8kryJ1DW5ZUz2YfwnQnRBGK
         xaGPnFNGQ/P2W9026jzyAqwRnoxurg/fd2bcv0epd0Sd6YNDS1NQHrW4pcinRhZ6QbS7
         VfqQ==
X-Forwarded-Encrypted: i=1; AFNElJ90ALZWL8/uM75GIEIdlt8PGHyycfu3VvTYnpUENjWoadpVJnaO0M3nrMvXo1gTtj9+434=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXgACtqUwcfZTjfD9NmadccuHMIeSwGrNeIaOvcK+3pldRSN9j
	QEh7ouNWxrfgULrK7qLkH0el1dKSiTdA5yCEga5sSXDjMIFIzVXeuM8sjeoJJQUu8gsc1QRXnaM
	FLnxBgoXsoViXFbyXLVXcVgMaTGpUtVvawKyxLaX9f8LF3GhEDtOwS6QOBI7v4w==
X-Gm-Gg: Acq92OF9Brj9gxYqzjWzsT5rUN1a4gIWq6rD5IS82u1HW2Nje2BSIPgS/SbGdbuqiJX
	AvrwzR8f46sxZ2RKytQXO54aj6pdEyuqGfnavqiilHokSVv2B9VSDGZ23IwhdwPPE3UWzRtoch0
	th8YepF56OPZ1LvToHLsyAgopu2kZ7a4gaXo70d7OGnb4NGIv+fPKq75ofRoEgM4y8s7DdEWp2x
	I+5s3NfHLVVoEh7BBMyoGoXOVAQAx38cQVpm0Lq5RcRCixHj0JJanHROr/0bR51DBSaTSD7gtb1
	OrM6rm40VVLPGSbSaZWjTE+Qm158GF7Eitn1ci40XhRLxWDBzzoG7ysQ0uNk6AbmDkAi7KdjLJP
	OfMaQAasdHhcVsXeswBC8oP1rTWJSlyKgoWmbMHqDDSHNh7866opiiS5+i1bs
X-Received: by 2002:a5d:64c7:0:b0:43d:68ad:3b7f with SMTP id ffacd0b85a97d-45c59228b05mr4395322f8f.21.1778669670749;
        Wed, 13 May 2026 03:54:30 -0700 (PDT)
X-Received: by 2002:a5d:64c7:0:b0:43d:68ad:3b7f with SMTP id ffacd0b85a97d-45c59228b05mr4395279f8f.21.1778669670260;
        Wed, 13 May 2026 03:54:30 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454917d57aesm40237869f8f.26.2026.05.13.03.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:54:29 -0700 (PDT)
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
Subject: [PATCH net v3 2/2] vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
Date: Wed, 13 May 2026 12:54:17 +0200
Message-ID: <20260513105417.56761-3-sgarzare@redhat.com>
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

After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
buf_alloc when checking whether a new packet fits. This reduces the
effective receive buffer below what the user configured via
SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
silently dropped and applications that rely on the full buffer size
to deadlock.

Also, the reduced space is not communicated to the remote peer, so
its credit calculation accounts more credit than the receiver will
actually accept, causing data loss (there is no retransmission).

With this approach we currently have failures in
tools/testing/vsock/vsock_test.c. Test 18 sometimes fails, while
test 22 always fails in this way:
    18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch

    22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
    Resource temporarily unavailable

Fix this by using `buf_alloc * 2` as the total budget for payload plus
skb overhead in virtio_transport_inc_rx_pkt(), similar to how SO_RCVBUF
is doubled to reserve space for sk_buff metadata. This preserves the
full buf_alloc for payload under normal operation, while still bounding
the skb queue growth.

With this patch, all tests in tools/testing/vsock/vsock_test.c are
now passing again.

Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 4a4ac69d1ad1..e22117bf5dcd 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -434,7 +434,10 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 {
 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
-	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
+	/* Use buf_alloc * 2 as total budget (payload + overhead), similar to
+	 * how SO_RCVBUF is doubled to reserve space for sk_buff metadata.
+	 */
+	if (skb_overhead + vvs->buf_used + len > (u64)vvs->buf_alloc * 2)
 		return false;
 
 	vvs->rx_bytes += len;
-- 
2.54.0

