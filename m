Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A143E63BD
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095233; cv=none; b=MPWJNyqRGZXQb39D0oEJPml+8Wk+b8rKzsgKj7XCLsEEP19MbltfGZsRcTd0j1/bDwxUMKdrHEXTqJy9+l+t2cPcg75MNllM4pBGNPwnCEN3LEJnJbJHIlyk86Qo+lUX5WC6GH+twbY9frxc9f9/ISdGrbPRT0IVFl46SNH83ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095233; c=relaxed/simple;
	bh=eYAsyzlcZhIaTkBbynj1OR7+7bApP1e2I2Pa+c+c3J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbObvaEIXjZVpaOIq1ZlDhE2N0K6KY35+QuDGG+omFJRpqgeMJgL4Zih9bkb6NpdEVsX8CpK3uRBB39IJf2WR3snrWstbcACg+J2xcUt6CE0vxVA57+TYTIez1avqTcoibGBccSXP+pG/J+zd2SJP6PzbqGZYoXOssbXIj0l0Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cV0Mjq7h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q0WqA1yB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cV0Mjq7h";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q0WqA1yB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779095231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsBo8SZnL+tIoKyB10yuoDT3WWwlz7J8lfIk8OOzpIc=;
	b=cV0Mjq7h4udO/IE8ULNaDpfN78BaEqHzpoBJGvbUwQYt4qHmLqNy1R0XlV3MGp+juN48C5
	w0b1YSlzAVdB5Yuw1oncQ4OSOAGnVar35K2HMegAvSfYUoFVfKiHhWreWJGXwjeOGo0YIi
	MS2GqlQpEmORBorrV8zxpvK3gB0+zro=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-km-L2sGkN16Tkxh_YHSQyQ-1; Mon, 18 May 2026 05:07:09 -0400
X-MC-Unique: km-L2sGkN16Tkxh_YHSQyQ-1
X-Mimecast-MFC-AGG-ID: km-L2sGkN16Tkxh_YHSQyQ_1779095228
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44696b11265so3163516f8f.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 02:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779095228; x=1779700028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsBo8SZnL+tIoKyB10yuoDT3WWwlz7J8lfIk8OOzpIc=;
        b=q0WqA1yBuKqudkMDVa9gbdGVzMuIsrVVXNRSwdw3bjgtKnlxMLvJDWrMYDVPEUDhj9
         0QvedwBtRKqNr2F1FrzlxHjJIDmlaHNTkjOmFKFwsewObfVeXX9z/j5l0LsA+LurGglO
         C+aHH7ig9mUcgvF37isjI/JUvEGBJHCyMacgjX7fVv3Cikju5hbhhdzNY9MJNsmfKCXC
         TvvuMtEd7rfvBcZdRbjvQDJrtxVYVcMnoW2RPb+r9/O/atMX0gSuu+aBKebuGAWQAb48
         xlb6ZaThvvV5Fwn67avpYSW3LgKF2Uv/xlmpcz0ykEMEEAXQJOFlRd8ijkcQQGqcYFtc
         PEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095228; x=1779700028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dsBo8SZnL+tIoKyB10yuoDT3WWwlz7J8lfIk8OOzpIc=;
        b=Br80JehVnST48Ig7Tct9pcv9EY/0YI0IPPO2XS11zT/a753JYSWqAa51Ak5X0sKmYa
         IpZx8fEHfOaHnTf6UKEdo2MBALzsbR4B/Wx0pRLSbMLEf4+MbsfKh6iudxm8wn/g7nus
         cbsz51n2tbtBeHVDG+MNV9lqIiV8YmkN6F0EJRBmqnvUp9KAciF54hTDkUeSP1SyEiqL
         e6dWVSRgzevu4o+aRxdwnaIEFyLUenKXmc1NuTqTr461xrAQRuUpPIhGuShMW4Mlgfgq
         1cAzsI3d0pfJ1fkPz8berOtt1LCRkC6dAWrMNbRr1FDinuIcWrK47vo/x1XfMopvjXBt
         WX5A==
X-Forwarded-Encrypted: i=1; AFNElJ8nZORi4EM9G0vGh63akoxPZu0be8CTM8kvRwuaPOSTqjTjr81jMTwk07H1YnWEkd/Yat4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyacWdelW0DlrU5cS0ZNb+GTvGRcyW8m0/FTjXpZxNQ1rqaZBRa
	O9wbYph2EcVZ5d8FIkwGVQTS32gydCcHljMzXTKFcr0F/8vk85lDOlZNGhBO5c8z9xRhYKC55+G
	zz6Bn5zkZENY6qxca8M/hMiDztOuF4aMOxw73NrLTVbCHkrkDmF59ug==
X-Gm-Gg: Acq92OH9egImDrjEqTVJXCwawsHRa9ULACsKg9fw89TCArFc+3EuEvxRKvPzS/+gzin
	A+e2mWiIg4tDyIQWYGPyxqAgdjEpg0foSSDU9secBjWEh3YeG75KqbNhPrXRw6AFNBeBRxmEqi7
	A5azqFPfo44mYDy2M675/tU9b7E/VF0gIuZY3kdonj/JbNU4y7Tja00n23QoWRRQJ9CQHdw1B5B
	lvcOVxd0MXykjRAFGiShQPg6dZFi+VhXSMXf2HG7e3SwH90FtYG8TbQzyzrNIspSvoJmHtQ+eMz
	Ws/to9jOsK6xtrqtkAtJEU8L65zh6XsFAqkR7ZHMZokpflNmBGl5S+M+FrWIzSZd+0gP59SUBt2
	4VdUxgV0DjX7Uph1KFc9gVtsO8+PJkpSP7xYtRTUP6rs/rVOzk0f3fsUq7od1edvQLtXPCs4=
X-Received: by 2002:adf:e681:0:b0:45e:633e:a7cc with SMTP id ffacd0b85a97d-45e633eb4e9mr14807941f8f.24.1779095228409;
        Mon, 18 May 2026 02:07:08 -0700 (PDT)
X-Received: by 2002:adf:e681:0:b0:45e:633e:a7cc with SMTP id ffacd0b85a97d-45e633eb4e9mr14807870f8f.24.1779095227874;
        Mon, 18 May 2026 02:07:07 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm35104134f8f.5.2026.05.18.02.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:07:07 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 2/2] vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
Date: Mon, 18 May 2026 11:06:56 +0200
Message-ID: <20260518090656.134588-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518090656.134588-1-sgarzare@redhat.com>
References: <20260518090656.134588-1-sgarzare@redhat.com>
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

Fix by allowing at most `buf_alloc * 2` as the total budget for payload
plus skb overhead in virtio_transport_inc_rx_pkt(), similar to how
SO_RCVBUF is doubled to reserve space for sk_buff metadata.
This preserves the full buf_alloc for payload under normal operation,
while still bounding the skb queue growth.

With this patch, all tests in tools/testing/vsock/vsock_test.c are
now passing again.

Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 5028ff534888..df3b418e0392 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -419,7 +419,14 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 {
 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
-	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
+	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
+	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
+	 * metadata. Check payload against buf_alloc to be sure the other
+	 * peer is respecting the credit, and sk_buff overhead to bound
+	 * queue growth.
+	 */
+	if ((u64)vvs->buf_used + len > vvs->buf_alloc ||
+	    skb_overhead > vvs->buf_alloc)
 		return false;
 
 	vvs->rx_bytes += len;
-- 
2.54.0

