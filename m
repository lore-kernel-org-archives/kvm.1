Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EAB39C621
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553249; cv=none; b=aGgP613wu84+QaP2pBDDZN/3/aMQkCl1BSU6JCuE3XUfthmy6q6DNPn+YB3/XtFNOhLNjSLHa1dvzi2tPZnnhJ9j2gTUJVRVnczJ0Qt8Xdy3sWgKkKzlkUb5CtXFZZb4Q9q1V7ZTGaAl0iyI5nHE66MjSM5fFXya/t3SLFnBCEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553249; c=relaxed/simple;
	bh=gb7Ruua+gJ5a6hrcK6PHPahbGnBvVqCiLHNSA4MS8gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F4YOFC7RA5WxbHS7IVeMlVWUyjFZiZhBRLGC2zIh0dz0ndl9Pk55qEqSMHJlYNUogTHaKzuy6HNAipVNS5FCBrvUwI4fgbw8ReScgXX9IjFPmChLgsKcObfVfOyBicHiuxjCY94h5q4vKAWp8a1vZ+w7rgvPv2wPoMzYI7P3wjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H05eHFns; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GsH2L7bX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H05eHFns";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsH2L7bX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775553245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nou53lLTv7UEsO0o7KVxM0MjcDicbnJfC8/ClZPwZgg=;
	b=H05eHFns/1u+5NE7pmAf1gWjhnJg/nIrQMl4mEQ4BxlUAQ2pbCuEshM6QwUWDfuQdwuLzN
	oRqlyyuKPxTIec8jEzrPP+PQhdyvljRgg5d1VyE/26zaAb7T39/2NBlsromGBKzIl+ZgMv
	4ZZHlJms/DY8qXGU26RQ3jccZLHQ3QQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-0AcJiIJ3PMu1sg0nlau2DQ-1; Tue, 07 Apr 2026 05:14:04 -0400
X-MC-Unique: 0AcJiIJ3PMu1sg0nlau2DQ-1
X-Mimecast-MFC-AGG-ID: 0AcJiIJ3PMu1sg0nlau2DQ_1775553243
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d121c4271so3332970f8f.3
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 02:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775553243; x=1776158043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nou53lLTv7UEsO0o7KVxM0MjcDicbnJfC8/ClZPwZgg=;
        b=GsH2L7bXkM6pI34lvmuFuLM7tSOXqGUQ12Q/qt/E8EKv8SQ0OzvOpHZgNV7g9Byk3G
         k+P/xWGGaalrwZfA2firuxNlGHG1N7MA1vS/y9L2+Gj9RjPHuxYN6J66QmjpClS1Vn0g
         oKR5qCZVIuFYag9p3O0CThtALRQtgOjdGf781IPI8oE/C762GBvdoECZS1l/v1TQ9Zn0
         Q78a6utaxjE4CUXQxiwDriFUBdXUY4SQFyAmJNnrDABZCJNyYWqAXRm+frGtkvwL8N87
         QNEsL98sPTWAiosVriPlaSl0dkICMZvmoNPYxST1q7LiDGnWpMppoXfmqoHA1FTeSi7M
         EVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775553243; x=1776158043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nou53lLTv7UEsO0o7KVxM0MjcDicbnJfC8/ClZPwZgg=;
        b=W/rHmscKiry2/BkvmdHxcyUz5zn1elUMRNRCHm0kbGJEuHcgkhQXIL+8bfCkesiFqE
         9QyizKmCx7uaCKH9otVjOZvHPB8rXMbVVaT5Xfej8UzoSugPUdvN96jeEfvyWlbejKDh
         xgXyYMB8obd/eO0POiKQJx2Y5pz4Zb2WpFlxggM0KHmALFfXSSopz8a7amrxO7/VTK7G
         17LIsavwNlsrdfk01CKEBS5k86cWpocC6ysUzAZzXu/QD1uddc/oUX4RUM7APDjUumhU
         UCTgmDlMvwtOhzCSa8knrSzA8JDD/C2T517Ej8JKP4c0TnYkwL292fHGC6xinYU2OwYS
         DK7g==
X-Gm-Message-State: AOJu0YxiHgQmeCasslXKJ25GV18WiDw0JGD3An5dnvtnxyRqSJqbLqf7
	Voi2RwDNfxvGWtEvDkGBPrRj+E6wcGO2x148Qwr1wTlDbwDy8SwO9ose2xiK8dwlOFrancKGybx
	rurJNHM8Cvxv5YEleT8G2yI96/rAw1BOVA6JNvJFoGayEsbIgG8S3bg==
X-Gm-Gg: AeBDievG81YGIT+F1Jy083L8c2U3JHOVGYzsa1ceaf4Tuyt7PNpG+tbuhG0Ed1LFOvz
	BIY1Bhux/81SN8Rl3xQeTflXOeJJhlgAqIwRsMuBCsKXoqExzhzQPohRX+XveDkCZcKDpLugtlK
	8G3mlraj0a3g7r1wSH80B7lQ8xMd1apsuC+nnchZs/UG2xkI8525YlA1f5XKpkyve8ctux3AYe/
	/Jp0Z5Sgkz0MS6aRUEBEY5xZ1gvho/PYibrgDH4b2E4zNOc+44jTp0CCpk+3L1qQyeXKJAQEsm3
	ydE3UNYuXp0Sk+km1MpO+l05gFzXN4LBkzVP9niNE40QCy+jlYW3E+JBud27Tmm4VgkL92dqRx6
	MgkIlQDS2SPmRafzEkDebnV8dnB7lxn2SUv05816rm9CTEmyNZaFtuNhzw5FH
X-Received: by 2002:a05:600c:8216:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-488ac017468mr111080315e9.21.1775553242807;
        Tue, 07 Apr 2026 02:14:02 -0700 (PDT)
X-Received: by 2002:a05:600c:8216:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-488ac017468mr111079805e9.21.1775553242317;
        Tue, 07 Apr 2026 02:14:02 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48895e19c10sm342892015e9.8.2026.04.07.02.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 02:14:01 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 07 Apr 2026 11:13:55 +0200
Subject: [PATCH net v2 1/3] vsock/virtio: fix MSG_PEEK ignoring skb offset
 when calculating bytes to copy
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-fix_peek-v2-1-2e2581dc8b7c@redhat.com>
References: <20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com>
In-Reply-To: <20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3

`virtio_transport_stream_do_peek()` does not account for the skb offset
when computing the number of bytes to copy.

This means that, after a partial recv() that advances the offset, a peek
requesting more bytes than are available in the sk_buff causes
`skb_copy_datagram_iter()` to go past the valid payload, resulting in
a -EFAULT.

The dequeue path already handles this correctly.
Apply the same logic to the peek path.

Fixes: 0df7cd3c13e4 ("vsock/virtio/vhost: read data from non-linear skb")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 net/vmw_vsock/virtio_transport_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 8a9fb23c6e85..4b65bfe5d875 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -547,9 +547,8 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
 	skb_queue_walk(&vvs->rx_queue, skb) {
 		size_t bytes;
 
-		bytes = len - total;
-		if (bytes > skb->len)
-			bytes = skb->len;
+		bytes = min_t(size_t, len - total,
+			      skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset);
 
 		spin_unlock_bh(&vvs->rx_lock);
 

-- 
2.53.0

