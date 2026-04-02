Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F287F3603D1
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775117891; cv=none; b=WVLJX3EAtjAuem01IMuCtc2Pu5x7Ut7GMghoMjZm7a750bK3sg1y1Ix4w5ZacreuAartgmH4BdxnLC1MWtEJua+BmvbC3Jkz5yyTU9AtCC9zMcscQCqVlDEPqb9n5Vnmb4QlKjpsL1KE3CsnOxkjjrVotVUo8hMxdok1iCtia7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775117891; c=relaxed/simple;
	bh=7RbGQyRVtd3iDjWPPVgXBB7W0hDbsWzu7x3oEX7DOMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OTGTnNaGorI9W5dLP3s7RW+KMu/dKqOGRKxwvzM/FmR0nOODewpuIUHXu6pxu1OzVJKI8y+x0BruDncSojyRVnX69yTHG6ik6ghKxizezeIW39EfIrvLpeYQ7pPnq9U/6i/eUfW046Hki/4rXpwe+NaEaOMyiMAWIjpxxkS0RqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VOyerYo9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTS0A9DG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOyerYo9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTS0A9DG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775117889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0i0CiAjjC2o5qhUUVNqS3NUjJfokP7K8K/WQ+tgiCw=;
	b=VOyerYo9wKku3Ph8yod++6v0SsbkPS5QctyMmR8Niz5oeWV6bLIGezNz0jfWboX5r89DWd
	fcJCirdY3zZvgLrTl0HR5NNkTtXeuhJm2S/uVnqZLRuXzWKLatiNLu6/j6GYcHINn5+Qy2
	48GnHKmSK4tMKea66Z5xo7RLph+/7Tw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-MrpWJrHsP26uxdH__xWUzA-1; Thu, 02 Apr 2026 04:18:07 -0400
X-MC-Unique: MrpWJrHsP26uxdH__xWUzA-1
X-Mimecast-MFC-AGG-ID: MrpWJrHsP26uxdH__xWUzA_1775117887
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48544725bdeso7095515e9.2
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775117886; x=1775722686; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0i0CiAjjC2o5qhUUVNqS3NUjJfokP7K8K/WQ+tgiCw=;
        b=UTS0A9DGW907JuebnvjMxotZsSld/elA95ZOox/vCYf26T+cRrVSubzNVAyE34Yw8B
         VxeKB/ki/u2+Dp1h+93G2AnqTrxroiHu4Dd+dIzVj/4p2aI0x71adTm3ztADn6gZ0xoA
         Njr62I3MV6xhHDkE1Ou6z53SbIy6FpQykb4PZ3XJFGJURA2AOvgFu1YlJrbEBsCvENK6
         7yHjlhxoLxI/gN1AlUitoSIbt7DzQeBkqNtUTPpGxLerTL4G1ZF045aPPvw5GTI8esGY
         WatySjBFNjyNbklu2vEuv15saSodFtftSQacDpaYmOpsPT1hwIh2tXM/JrFUase8WTRK
         g1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775117886; x=1775722686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O0i0CiAjjC2o5qhUUVNqS3NUjJfokP7K8K/WQ+tgiCw=;
        b=Nvoy9y7IrWX+Uk9czHVGXY4ed0H3Qi85TvHoaAlyjVv67JLW2Jp4/2gSMHAxZxZlpu
         bvaab0s2NXUMyyIXL5uGcMP/PMW4/R6fmprBpZrArEwSR1B3UVFzxvTPVc9o+dcgeFDG
         kX6d83+jwBEx99K9lHd/zGebPpJ45q2UpMz+SR1tL4nZPpf4MpmlDyTGotujBPiZb3uM
         IGPy8q5kfM6K9sHNNvYQOCOeJyTiMZEJDvhQJgql+MIIjeKe7BSMJBXsoqrKzd/hyAfp
         NJZeLOVlw6HrWU6pT3/9XZJ/I6tVE4a7ajXquFheFa5dNQVs6Td6Q9nHuYIRe8Kap7Im
         /opg==
X-Gm-Message-State: AOJu0YwrfmiceMgF+XsYZE8pz5ffhCOLeXOXQmHANe8NkYKw4qIhDi5b
	iBpdUhLhqFdhtmel2S+RqVfGh87unrEAB9b4SlEOvGflQ/Tyb1eHIz4FVPGMc1l6rVtwA6Hyoom
	/Od/ngaJ53nEACowvk7BN/qd6r7xQhjSQ9BO9rv9wBLeSp/Xw1Ux7fXCjnnJQGWnxuN96Wb3Xkv
	g7LArKkUqAQX15wHjyXeuBNRvkGhtbNlq81/Wbgv8b
X-Gm-Gg: ATEYQzxI/tLHqLiM2VIx3XIeUVBTHoAe+EZNyGnzr0Nn3OWlypjaNQ4C7r9OC2PkCLE
	x0shm8qvNFOh0brmktj2Hyf/sPvYn5RdlOD4WS676rOmkiL/j98ecqgrn5blwWbnpdfwwxn4ZNT
	JqyVWjQAaQraDf14vig4aCyhRBW94iaqj0ZnmPvvvzZ7shITfIq6pBE/+huQuQImfHJsGMyYNGx
	QTrKm+hGUI92AKSRmPSQfDq6p2vidk6zapVy+Guh55tFTrCCZqcn0nTkVWiOocDSlQ4T5rSWU7/
	4JCqNRiNuPob3pT8IkcB0v/ilKmKpJ6FZjW8yiMtO/7qeRtm4ZuYdlQ35VViCFvnn2u/ArqCro7
	bcpIkbuCBm0rjuT+w0H8Lm2C2LFAOijnN/8p4CD7QkAg+QyTQ9QdLImQ0ublr
X-Received: by 2002:a05:600c:b99:b0:485:3f1c:d8a4 with SMTP id 5b1f17b1804b1-4888b70fbdemr38341285e9.9.1775117886311;
        Thu, 02 Apr 2026 01:18:06 -0700 (PDT)
X-Received: by 2002:a05:600c:b99:b0:485:3f1c:d8a4 with SMTP id 5b1f17b1804b1-4888b70fbdemr38340675e9.9.1775117885762;
        Thu, 02 Apr 2026 01:18:05 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e735532sm214476005e9.0.2026.04.02.01.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:18:04 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Thu, 02 Apr 2026 10:18:01 +0200
Subject: [PATCH net 1/2] vsock/virtio: fix MSG_PEEK ignoring skb offset
 when calculating bytes to copy
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-fix_peek-v1-1-ad274fcef77b@redhat.com>
References: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
In-Reply-To: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
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
X-Mailer: b4 0.14.2

`virtio_transport_stream_do_peek()` does not account for the skb offset
when computing the number of bytes to copy.

This means that, after a partial recv() that advances the offset, a peek
requesting more bytes than are available in the sk_buff causes
`skb_copy_datagram_iter()` to go past the valid payload, resulting in a -EFAULT.

The dequeue path already handles this correctly.
Apply the same logic to the peek path.

Fixes: 0df7cd3c13e4 ("vsock/virtio/vhost: read data from non-linear skb")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 8a9fb23c6e853dfea0a24d3787f7d6eb351dd6c6..4b65bfe5d875111f115e0fc4c6727adb66f34830 100644
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

