Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE1E3CD8AA
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661671; cv=none; b=uc8ZRF9DnXMj9YdbCr0edNCf1yS/AczxHSDE2qYDsnX2CTmJJ+Cs4I1g5AGLQXhGAIK+yPeJyeWeca1Vs8mIAewsiiRje20Q9YBlPU0w55hWL3dUd/i+X06SFCn8ZosjftcRv0w4Y7x9VJ0MeSJzgzestUuCrBEdiJyLsgsuHHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661671; c=relaxed/simple;
	bh=JWryo19XSS+EbbXgCTnUDuve7zD+psGcWk4bJFoTzeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L6X7r0YgCIf2FktuK+h2zcxapsYTKghA54gjuA7BXdYYhwcs0lIcBzExse2J1xYK85Ugh0/ROTyy/Kj6MUJxY+JSeTfWXFBaErYdpMDSXbdwV9bu9JKfF++WwYGPFXQzXXbFFfRgNRY0NfNlK3rkWKLsgpX/oVoCmU/af2qo1o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzIKz+QW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJ1yLHIM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzIKz+QW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJ1yLHIM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775661669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bxgs/94flkc5gzjvGkdrpP39nvy7O6M4eR7c4f7iyik=;
	b=HzIKz+QWBdxilopFnr1QrpaVCWSqPDa4MCap4iekECc5TMbIcU13B984iKn7mmqjO+xYl7
	B0FpJHPCJcftVj8vk20OG7jbdJw6gJF6f4eXzcS2f3NN98FvCPidG3QSE0GBvQkC91i/zf
	kl3dbhQZhF2ZjqxqwI10KKACg/v+zSA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-mEjFA0pIOW6A2j5M5BeAbg-1; Wed, 08 Apr 2026 11:21:08 -0400
X-MC-Unique: mEjFA0pIOW6A2j5M5BeAbg-1
X-Mimecast-MFC-AGG-ID: mEjFA0pIOW6A2j5M5BeAbg_1775661667
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d103e46c3so4488811f8f.3
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 08:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775661667; x=1776266467; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bxgs/94flkc5gzjvGkdrpP39nvy7O6M4eR7c4f7iyik=;
        b=TJ1yLHIMsDk1c48l1PvegTK7Jq3jTSgnOT9ssJdYUCXor1Kz6NDUcW8+0dHu6iCPJp
         7uFOIR82ecfIHG5czVgLxNo/ub/cihg9pqVxnb0oZS9hdE5ft1mlbtNIIgrR31xrJgXc
         zERdmheMC36wzhLBixaqrj6Hz7ov2auhCzEAj3u7eKh5SsWlkUg5rVFP1ouEnehJVPHp
         FvMX6BiY6gIFfx5ETTywZrCvR+RlYDhAE8dTu3JDJqsFiQzKiK11jOtfCTrMjWGc7U6m
         0x3yBCAyGrZH87XYfDpxBs3iVbU8cuscSAW9l+492/0OR+JT5hNz0pHRMnlt4jKio404
         MHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661667; x=1776266467;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bxgs/94flkc5gzjvGkdrpP39nvy7O6M4eR7c4f7iyik=;
        b=A0RHWD6ioNNY7sgQyvBHSLRmtthJjeTd9DZIinRvJmn0w47SBJgv7ee4Hl9rjobqlm
         DVW28qwwgeTOMwt+UH97kEm0m8HtiuOkzQasyVIreguqapCDVmS4J/4xQNykazhK3CHG
         VILcwhMhkrZyiFrN3wlobyOwRlc3gCnQhD9uznHZdyHi7fNPXBePgnGDCqjiByd56pgU
         Z5tg/cXV4U1sV3QdskrrzLi1XDzK6ngN5zELVFyrltlgFozJI+ptnhN14afWNZmb63Sv
         dG2IjP9qDtM0vrFeIeuvf+YlIJCuzowjADVQKVzHRWC15qlwndnpwlymC6zzRM+s0r5Z
         WV4g==
X-Gm-Message-State: AOJu0YyjbwRcSMpvYm7nZRh7lyBJC/o8m61k598W5lDTU/aqcXMLR6Ae
	8lPKkc+fxMTNDMQA9LKJy51FSY4Gp6HGJ20jk8FlV3vB4KMJAKsIACS9XQfMRgOL1LrwelsTY4g
	eWLPK1t2PqCVG7paaAeNZBIySd7XGyDbOxvbKDlG8eumAfFGl6Ctdyw==
X-Gm-Gg: AeBDieuW4pkYDrlkc8wZK2GvMO42lPGnGXfRdzf3dWlrYK/dLs7jziI1MOukflhdRmm
	jLoxFkAMwtjv94hLfNHAQ9Vgv0CXsz7ERyBee/L5epB6XRGWdIYdxUdp/5VNQ6OJVJ3bq4aJJaa
	aGVaSGSJOIfQVEVILEILeGA+nDcH58F/u8Zie4tCMVzYoyMOggMVaT4jY7MZtBfUEbKUP7Xxa/2
	AcFw6JWeAIiPbh6qPU7ZDfjDH31ww/XuLLHUnau5jhOAuAfgFy6iYpUJRSIstrtZZJI3jYVsZB/
	/vc+4Q3iQw4l0ZnWoBxApB9jfX9Gx//Cr838gEhS9XGu2Yp+akIHxz4sdI+ER0izfOzz3OSCwJO
	L/cG+Y8AwppW6/zBvFefsmsFc8+0DlRm485gQra12O7VHHgTkKlRBK1B+e3ZU
X-Received: by 2002:a05:6000:1842:b0:43c:f3c9:3815 with SMTP id ffacd0b85a97d-43d29277055mr30965424f8f.3.1775661666621;
        Wed, 08 Apr 2026 08:21:06 -0700 (PDT)
X-Received: by 2002:a05:6000:1842:b0:43c:f3c9:3815 with SMTP id ffacd0b85a97d-43d29277055mr30965363f8f.3.1775661666078;
        Wed, 08 Apr 2026 08:21:06 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d29bbsm60446899f8f.21.2026.04.08.08.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:21:04 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 08 Apr 2026 17:21:02 +0200
Subject: [PATCH net-next v2] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-remove_parameter-v2-1-e00f31cf7a17@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQqDMBQFryJ/3ZQkimJXvYdISfVZszCRnxAsk
 rs3uO9yGN68kwLYItCjOomRbLDeFdC3iqbVuA+EnQuTlrqVjewEY/MJr92w2RDBYmmVqdHIaek
 lldnOWOxxJQdyiMLhiDQWs9oQPX+vr6Qu/z+blFACfaf7upVGv/FkzKuJ98lvNOacfz4Fg2q7A
 AAA
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

Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v2:
- Removed Fixes tag.
- Picked up RoBs
- Rebased to latest net-next
- Link to v1: https://lore.kernel.org/r/20260407-remove_parameter-v1-1-e9729360a2be@redhat.com
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
base-commit: 4c2ffb3ea8a601bb3730754cfaa433e673037cda
change-id: 20260407-remove_parameter-f61a3e40cf90

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>

