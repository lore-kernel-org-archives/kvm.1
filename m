Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FCA382F05
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901872; cv=none; b=kZp5PFHkT4GVMaSNPyZjbX4ZNkFcCrZhAvui65D8xLb/FerC/eepAI+pWa+HFsOz+HRSDEmB274zeSL4u1Us584x54fOWUtfDOqoPZUM3xVAjzaNAGrbFvnpV2YsFspeOAytnYvOGBINmk2OpR92yYFURmhnbOOm2jTH3u7+J70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901872; c=relaxed/simple;
	bh=Y9H0GY6k4T9clxSJ4yaRMplKa33pAMEcbXdMFf6KU6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ffNrXvWFBZoyRjJ+izYuL75qPe43OtCq2w8ULFAW5DwJLXe/jYQoiaHYEZfZG3R81yVMIUUm5ubKH5ojDNVAimtfqXZDtrejDxnoKNn+X5eziNoUHQIUzj7veiFjtAegco/LB4fR5iqErSmLSVhV9hAajCbMejv6eHGdlx75oxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J9u/2OdO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cEU/hSam; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9u/2OdO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEU/hSam"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779901865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1yn5UxI8QEgnLkFElBqvhz3nwZebD8rthNLyz5wiHFs=;
	b=J9u/2OdOer2R8kZkA/AqIS+Ez6NtIObPNeHiX++y7qYAEUhIqjNoaGMAc6ChrpYa1ARe2Y
	JPwYSHTPL2BX30J8gXdzWDTGak0sZNNODZ3auUhe3VrQXK0ieZz6fXohozyLcJsCHt3kv0
	9n4lolugreuAxD9E/4vYQkeqWsAlkYY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-wODC3cYfMqm4onkwI5_rrA-1; Wed, 27 May 2026 13:10:53 -0400
X-MC-Unique: wODC3cYfMqm4onkwI5_rrA-1
X-Mimecast-MFC-AGG-ID: wODC3cYfMqm4onkwI5_rrA_1779901851
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48fe6894f3fso73187095e9.2
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779901851; x=1780506651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1yn5UxI8QEgnLkFElBqvhz3nwZebD8rthNLyz5wiHFs=;
        b=cEU/hSam9VUD2VtmoNRQcDnEQgkJFC5q5GsCkutgzOaIkpHMqK07PAl+3oldB2fV9D
         rOOb5UeYM01Di7kvN7DD5+6NYxO2VFygXSVNPKiUVvo29BFvYOf6hOY/K/648ZBLx/5i
         B+JqYiE4ipVBogl/VWZFKYAw3nbpSiGIMopmGyxwdBvpUadXiM7UyoJMWvX1uuMIPkAG
         MDuu9asx3uYkkeNjQNnG3u1zwrss2EhZrhawPMhbVy3XhoUsfY5WKrnB2JbnKsN3Oibw
         +ydcxpRsk5gWO0bwvNcsM98HQz6f2fJsvK72Vrbb46DEsLgBBMuJDkuCMlVD2ANj3JwL
         xk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901851; x=1780506651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yn5UxI8QEgnLkFElBqvhz3nwZebD8rthNLyz5wiHFs=;
        b=Hx12pBgwHyfUeeyuZk1dLmeYTPnJWTieHhEzMJsTvywsWtlJJts36WG1U88+K/8OHW
         m21AXQP2wwOoy9pUL458YmWaZ+KdStKSQ2kN8FKaVtWZ3IbaRaK6VT2yLSa36mYh5DHv
         fzQjG0HTt8j9aEmT1fnnjTieBJaoUipNBKC7s5hrJ9CzeRUG1db7Gqq2s6izia7f1Z6M
         di7iGCW0ZOp+0F1Nr640vG7TBlEYgEflG3DnqndaTD1ApDkjyA9hD/6X6X682wYDTL9J
         Wh8KlSE1j1QNNcees88jfgvZLARxa/nLtNgQy8SnijaTQ+CNzEmqWWv8NqlHP2PUPULF
         hKrw==
X-Forwarded-Encrypted: i=1; AFNElJ9Ml2nVqN6x7A5hABs9hX9/NWV3tidmU1q2EjDptQT5e60NFBpXf/WwBx/miuF2X/ehnIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFahTzXUAM9fw+axk5a/v+vKZxrQ4ftR9CppOKY7MI/9YqmcRX
	jd2NyYmd8zUQpyHiHp3IO800GiRkeCbheLkuKLzEYfz5trmtc6RGsbO8/wC/BDv2gyGSOnDS5Fn
	uiYbAoxt6oRE0DehBKgCDJGit77ehKalXYGToGoVxuCvEIQ+XY2Svxg==
X-Gm-Gg: Acq92OHK2CCwcy1k5CE0bePQd8GuR5uj3LRuZGzpbAtMQcUInh3wIzwRlMum2iruosU
	PaCxtBiLPK6c5B50efNTqPmHxraL72SSic+ydO55cqbEN1Tzqcwb/i/o7jO1Y9cpY1wIMtzNYYA
	UpMqxbm7qV/8Ae96kYTZmT/iKevNv+bnY3T8QbMSxIMJAyji+5HLlZ7X0Ncux32rSsFBFFP2vGZ
	KD6ypYFk5+UzWJsONC3sGFwYx7xK8Uy2Dx8bcFolBHntBtcl9HVDr5AM3krNxi7QuyTs9Tv7XJP
	W+dFuwK1VFTAv4Bx84Rgg8B9+HjcO9PUgKQ57ywEOwm5tLz8HeW+D3jgNllpwiOPy/g6T0EtNq+
	tFJsnEOkAmtjEL0c0zpxRvy+5YifReaKMS24NzgvAYOCMedsvEcj9FhsiRg==
X-Received: by 2002:a05:600c:35c8:b0:48f:f7cc:f703 with SMTP id 5b1f17b1804b1-490428e2d58mr447180095e9.30.1779901851350;
        Wed, 27 May 2026 10:10:51 -0700 (PDT)
X-Received: by 2002:a05:600c:35c8:b0:48f:f7cc:f703 with SMTP id 5b1f17b1804b1-490428e2d58mr447179465e9.30.1779901850888;
        Wed, 27 May 2026 10:10:50 -0700 (PDT)
Received: from stex1 (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908097a320sm30225605e9.3.2026.05.27.10.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:10:48 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH RESEND net] Revert "vsock/virtio: fix skb overhead overflow on 32-bit builds"
Date: Wed, 27 May 2026 19:10:46 +0200
Message-ID: <20260527171046.130211-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

This reverts commit 4157501b9a8f ("vsock/virtio: fix skb overhead
overflow on 32-bit builds"). The fix was semantically correct (although
it would have been better to use mul_u32_u32(), as David pointed out),
but in practice we are estimating the memory used to allocate the SKBs,
and this will never cause a 32-bit variable to overflow on a 32-bit
system, since the memory would have run out long before that. On 64-bit,
SKB_TRUESIZE() already evaluates to size_t, so the multiplication is
already in 64-bit arithmetic without the cast.

Let's revert this to avoid unnecessary 64-bit multiplies on the
per-packet receive path on 32-bit systems.

Reported-by: David Laight <david.laight.linux@gmail.com>
Closes: https://lore.kernel.org/netdev/20260523173557.5cc4f4f6@pumpkin
Suggested-by: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index b143290a311d..d4d26fba9e37 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -417,7 +417,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	u64 skb_overhead = ((u64)skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
+	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
 	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
 	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
-- 
2.54.0

