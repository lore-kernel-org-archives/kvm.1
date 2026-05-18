Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE583E168E
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095225; cv=none; b=pDSOGTPdTGwW6VUm9vocNmx/q0WWIDm6gGpPBsB7hfYSysZFcmraIPU0fSIvvaGbIRrAV03KXgqZybbSNPHxSjGTiEt7A9LgbvfXP2WzllCvYhy9SSkW1ebQD4ioLjCnp58az5VFi60seB0kmsbdtxofnAkWuQUJfruTtSuOYX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095225; c=relaxed/simple;
	bh=4Jgas6XMDUNHabFy3gLOXXGPd/CXV5aZuFt6IpzE+ME=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tr7ctLswftxUKQJNMbVG+LfpdeqZKzNji9VkiOVxyRRKOFcFBwN1ss23RHzPzyukukI7r0V1/WOIYGnnWBL0Qvh07vvUG/NOYAn0nnuvNCiWh3Gp93xdgZFsDGBbgImiBwQA93Tz1S4tAnm6x3klatqZREBgxX19jY9mb2oq4g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C3I7nypt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NW93tZzJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3I7nypt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NW93tZzJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779095222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WVr+ozlWbMHYAfpi/swl/ldM7Por8GhrxE5XtzjKwI0=;
	b=C3I7nypt0CqHtwM4x6/+buG5pneBPdx7dxPyjAH8sUT6icPpIQD/952T9ZtAg0O5RLL8op
	t6vnHBCctI6KI7LSuIjAHeJ/jZuDwIiMQ9tbOZ5HHxXqWV1HHkcRmG2w1SHiGRY8gPRivP
	YBHbm8rm+eTxYSK4lE2xRjSfYojjGQM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-HRrPclq5PC6Myf424x1MIg-1; Mon, 18 May 2026 05:07:00 -0400
X-MC-Unique: HRrPclq5PC6Myf424x1MIg-1
X-Mimecast-MFC-AGG-ID: HRrPclq5PC6Myf424x1MIg_1779095219
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48fd2b502e2so15164515e9.2
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 02:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779095219; x=1779700019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVr+ozlWbMHYAfpi/swl/ldM7Por8GhrxE5XtzjKwI0=;
        b=NW93tZzJ0TMy1f/345XjJDPEgfL1iOqk8JawoVks3FSzoQoW19IN+gmDRowBVBM1Mg
         OC9l9TilTHki3qhS40JGpYugXmvcYMWd0Jf8yvm2Sob4x4xYHTAKuUCiC6zb8uw9DXHp
         gwvMoZDB1Y/2Nq+QQuKdkLW3qTfSV6gIAy2UTB+EGtsCUvAMTLIF+RdaoJ3fw56mnaLq
         7ctK6HFNwqNr7f9wLnqUbKWCZbrDFlvY66bTSoWshOt7HtTQJcPUa9gEy11C8dKY0dBO
         Fyf7A7BUQiSidt/Fy9/mV/NH94LJ2trrcWGH9Lhx4USWR03W845OziA28erEUmm+pnEA
         FfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095219; x=1779700019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVr+ozlWbMHYAfpi/swl/ldM7Por8GhrxE5XtzjKwI0=;
        b=dwKxeed+mcZbbtTpJXyYr4H3c0GHe5vp47CJ9lbG7Md3JkraByObUaXbi7tWOD4Fsn
         FIWGOUaJbi9tZO8i0FR9o0ua9KmRDorQvXQXBf2E2KepdAKn2nh8pk1/Bf9iVaBSzxwm
         5bZGyskXp50ZftotK58m/QMc3EyiapFfDM5Op0u1ru4agzlNzynUv7i6ikhrty7uDfTu
         1aS9hD/sscYFTxD4foCh/gfyR+bKNysZb7B2rqcVJI5iIOdaXyjTl5xWpRqGYdDB7UW1
         rom03ZxPa6BjmMeOcCg4x9MUNj0GtPDKt4tiioQYTZswiEWpxZ+fbEckJsv3oGrDDE85
         AiFw==
X-Forwarded-Encrypted: i=1; AFNElJ+KEOOHpGmYKlsG3LyBA7z7TaD5st/dCoQ748IYtGDlskqxGXu36uewCxZmLGha54OLTnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiah12FjWq/Zb4+z9iDeowJxWdisAF9DJWkPNCHihLAM99NcqO
	ZSggwPCM0Jv7b6nD97RUcnGifIC9uxb9194hiRrOnpZjJ7MCQ8BnVRnKslkPENU52THJhtQYumf
	Ljup6TqEYjG7fFZyeXk5/XXCR6jF41hfhCecoFVmPcUtWF6z8FtmD3A==
X-Gm-Gg: Acq92OG+cudBumvx4gx/13YMje9dvQcK2jJMEUjauB2GbkFA/CWUA4aKnyZFtvzbTV5
	VGS+blHedEEDYZOUoLhdV/DArbaSNiNVIfVjERtVwYgv9uSuA17CaKcj3izpB3VuMaIR7XqJjDN
	4PKyItAVjolwavFRq7GJ8qm1lNGNOD/0nhSbHAOWzJ5RDC9CHseCwVgblzC7zPD+2xgEUufDqNs
	AIEl5nIM1m2G+gaCfVsGmjLGpLl9oFQpHxx+dcVHJA+zCn3MaiFiGDhDR0hcqROHWQGEkSNhGIu
	tYm+KpVO7leOa9xoFxkcH5QHC3nokfP068sXh1xVGzGo5hgzAxf3Z98J2YWHg9aFmxoKgG2Hdff
	NiiJs268e5YQ1rrPhZ1aYiXEF+TQ+8L9sJXRfjyObNf82wZrQUqeLtZU64Uci
X-Received: by 2002:a05:600c:8184:b0:489:1c1f:35f1 with SMTP id 5b1f17b1804b1-48fe60e1451mr214884145e9.4.1779095219300;
        Mon, 18 May 2026 02:06:59 -0700 (PDT)
X-Received: by 2002:a05:600c:8184:b0:489:1c1f:35f1 with SMTP id 5b1f17b1804b1-48fe60e1451mr214883165e9.4.1779095218657;
        Mon, 18 May 2026 02:06:58 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5e9d5d9sm279478545e9.15.2026.05.18.02.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:06:58 -0700 (PDT)
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
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH net v4 0/2] vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
Date: Mon, 18 May 2026 11:06:54 +0200
Message-ID: <20260518090656.134588-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 resets the connection when we can no longer queue packets,
this prevents silent data loss, and both peers are notified.

Patch 2 increases the total budget to `buf_alloc * 2` for payload
plus skb overhead similar to how SO_RCVBUF is doubled to reserve
space for sk_buff metadata. This preserves the full buf_alloc for
payload under normal operation, while still bounding the skb queue
growth.

In the future, we plan to improve how we handle the merging of packets
to minimize overhead and avoid closing connections.

v4:
- Split the buf_alloc check to be sure the credit is still respected and
  to avoid overflow of buf_used [sashiko]
- call virtio_transport_do_close() and vsock_remove_sock() to properly
  close the connection and remove the socket from the connect table
  [sashiko]

v3: https://lore.kernel.org/netdev/20260513105417.56761-1-sgarzare@redhat.com/
- Split in 2 patches [MST]

v2: https://lore.kernel.org/netdev/20260512080737.36787-1-sgarzare@redhat.com/
- Close the connection when we can no longer queue new packets instead
  of losing data.
- No longer announce the reduced buf_alloc to avoid violating the
  spec. [MST]

v1: https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/

Stefano Garzarella (2):
  vsock/virtio: reset connection on receiving queue overflow
  vsock/virtio: fix skb overhead accounting to preserve full buf_alloc

 net/vmw_vsock/virtio_transport_common.c | 29 ++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 6 deletions(-)

-- 
2.54.0

