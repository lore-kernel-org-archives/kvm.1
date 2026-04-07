Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C64C25A2DD
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572326; cv=none; b=diHGZWFVOtJs72c+R05onTzc3s5MU1dbQHl39v+2HZjA8loLll2wOJBZGMhQ90pYoduxMj5aKlbvJiyKHKnQez2yhBqXRSsALqUwvbfZGOLUrUh4FDOdBdD4JNzb+bKnpH5V5+gZMvif43j6ox+7XZAtGqTxi2UKUa5s5I64cYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572326; c=relaxed/simple;
	bh=L/JCFvTPVv0HlOE0c8AmntduyQpe67fTxZL7BZ7I2Dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gyQNKsMUlVtdpgLrbbmgca3YzgotGqXebF8RDxjvGlG4PvYrNpmADggFJ7wrl5Nt+2YVADd3OnJOj4oZosqAczMZ2rjlificoKHFzCOD1DusvINnFfDXrXhQXcVHL0Fpwy1WhUIgHoIgxks+ijS++qwNAwztMZQaMONARq6+u/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RY9p1rGe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QdMsowRO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RY9p1rGe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QdMsowRO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775572324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wN4PMrlLhWPP7lFFAEz7bnVJ7qzQh0MFMJBBTUMTFgM=;
	b=RY9p1rGeo6R4Nng20Bgj5IEwILBDcUlz2h27QNmJbIYv94QVH1qfs7qXvVKzbB1KbyKJ9V
	eL+RSJiL95Zqmoz8bfNn+c1HtRmhtxdap8o6JIlPFIwGjgbXVSvdxERpnbZwxH4eDP2lCN
	rmVtsx4gEUqBp64dzb024fh0pecF7pw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-i8w6y9GnOq6hZsuVo7qmjA-1; Tue, 07 Apr 2026 10:32:03 -0400
X-MC-Unique: i8w6y9GnOq6hZsuVo7qmjA-1
X-Mimecast-MFC-AGG-ID: i8w6y9GnOq6hZsuVo7qmjA_1775572322
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488ac66236bso16704125e9.1
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 07:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775572321; x=1776177121; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wN4PMrlLhWPP7lFFAEz7bnVJ7qzQh0MFMJBBTUMTFgM=;
        b=QdMsowROYNoAk8Ar2eYrxwaau5weuVKtu7xQbxYxyhozlWgVxysgQi8NCegyd4NSl2
         3RQUt6TDUEf7me7f9qdiAVwF1UptmYG5fvxUwODi5xdF4P/kf1VLScKzpvRDrKCK/S6g
         2ZgFC1vqugfEdc5tLpQGwBY/1sokQkXxCXCpRGJzMi7xmq8Ag6rjmhCkzqwGT/1luFzd
         E+VveuDqF1g8iF9bLrB0qIoVlcij7SS5QvX3wGKEljv/YjZXzX8TMLFqu7YCO07U+DhG
         eTddPSeoicFgqRBSl67kwSqIGc/UifdAj1xXHMA+NIvDFPy8oETCgq15dR2MgM2omeyh
         LpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775572321; x=1776177121;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wN4PMrlLhWPP7lFFAEz7bnVJ7qzQh0MFMJBBTUMTFgM=;
        b=ejfoL3xiZU0MaymmptXP931ec8nZJ6cMhHBSJEmv+/9B/mBKCDVX8xciajJZdzbczn
         Euwmum1x+NWhsrMFYWURb4KAP8k0huAURD6m5LTTi9/U+z1Xcq/x46X9yOuNItsCQKhi
         TZnt3YvsJX629UvA5FGN6vzH6IOeJ7DZPKHxztFkoiSL6ue4xsSHafb6+IfXRVdTX/ut
         ZhWzFdJOpf5z5wDsuDHmw8kFoG2MjiqJyFQfvDEX65ZK0y1oO5ePyjfI6nLfhI1F3NK8
         1Xv4zbxC3Qq/1qGTKu5chYYqZbpTImjpguvjpbgWi7K2AyA8NwVT0TwKfmrEpzI8GaJ4
         V8TQ==
X-Gm-Message-State: AOJu0YyBgcibu/afkWnJ5QBQ9XrHSVQpc/TweW4V4uHLuQoeGC7xM5v5
	/ctymKHPhRZ2pqGq87tcQCIOF6wVpayuCHFgnwmMqWOvlrDAvEiarXitSnmvtbu8EZIHMQ1HPGg
	37oYu0MrSL7Oe3ET7oSoei/d7yTMc4wGklxCu9aLhnylWJQSFa+cHeLklxKanHYje
X-Gm-Gg: AeBDiesqMezrW4w/EY3yNUniXIoDn999f+npez9+olyJfDGEvmibU1FhW1seGhKeFeT
	70zmyIHMQn//XvX8Vqmo3PvdGzKAu7CDdigzJg2YLU1RFyWekAaKTDRW9DWrg91/YOI965446Xf
	JkDkcK6gkDJs26xCpTywv5lct6GL9IE6EsDzub694NfjE/UUlhPoW2H0WouNmMwaQvJN0X+hLcj
	41u8EWUE72Zckn89MO/kP3UascGZMq8w4DmoMNt492nOV7OZ7aDdCD0aodgCS8h/jEgMp0BwXlk
	PFj3/LXtfuCvf4Ah+A/XUSVLzv1pRL6d+APTL1f11BCm6rQy8/U4F6eo1YcyOyfib1xk/51ToZ+
	1RbOrK6gJ4KPh6fXhpzGW2a0xAgEFLHIZRb8y0+I5KpKIBLE2q/7gFOU7YiMn
X-Received: by 2002:a05:600c:45cf:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-4889945f8c3mr203346935e9.3.1775572321463;
        Tue, 07 Apr 2026 07:32:01 -0700 (PDT)
X-Received: by 2002:a05:600c:45cf:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-4889945f8c3mr203346525e9.3.1775572320964;
        Tue, 07 Apr 2026 07:32:00 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48897fdd2cesm146677635e9.4.2026.04.07.07.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:32:00 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 07 Apr 2026 16:31:56 +0200
Subject: [PATCH net-next] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAMAxF0a1IxhbiB0W3IiJFXzUDq6RFBHHvF
 odncO9DASoI1GcPKS4JcviEIs9o3qxfYWRJppLLhmtujWI/LkynVbsjQo1rCluh5tl1TCk7FU7
 ufzmQRzQed6TxfT/F+e0xbAAAAA==
X-Change-ID: 20260407-remove_parameter-f61a3e40cf90
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3

`virtio_transport_send_pkt_info` gets all the transport information
from the parameter `t_ops`. There is no need to call
`virtio_transport_get_ops()`.

Remove it.

Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
I marked this as net-next material, but honsetly I'm not sure if I
should have targeted net. It's not a bug after all, it's just a cleanup.
---
 net/vmw_vsock/virtio_transport_common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 8a9fb23c6e85..a152a9e208d0 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -60,8 +60,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
 		return false;
 
 	/* Check that transport can send data in zerocopy mode. */
-	t_ops = virtio_transport_get_ops(info->vsk);
-
 	if (t_ops->can_msgzerocopy) {
 		int pages_to_send = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
 

---
base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
change-id: 20260407-remove_parameter-f61a3e40cf90

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>

