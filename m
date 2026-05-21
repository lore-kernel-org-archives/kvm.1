Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DBD3DA7C3
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367661; cv=none; b=oyty6XRx4SjMQQITcL4IGKWh++vqt7XY8yDm03c8PdbDFnIOzdDc15BRu5GCWyg4IIQKtsAwPcHfZUFGDQ7toVdp95akk2p/sJwqnKTOgYeZJa9mTkhtqLfAz4jgayHMtIBzMI0X/dV/4gVVbgbPh4g4vn+ERCzEtpc8GCMEZlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367661; c=relaxed/simple;
	bh=Dn6P2bkc/bzBUKXTydPjxy5n5j2Gvoyaa6sXWWpGFqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZnZMr6vTcj4lmQrh7e3vZuD3CZT1isw4/DvaCV3JWvW7ICyumZHZWcsnrf4iQUAIxvWG3HOaZz5tXlo/yofeolk1UnqNfq/EamZ19cPHJRNUIdnx4NG6HZWTW4IbCdv6kuW3ZKRj4+E6SOyHkaNlg0FRIryc+vKytptqNbes7eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IK5tFPJH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xp0hxeWX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IK5tFPJH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xp0hxeWX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779367659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HUBSvYNIEeXrti7M5Q7uqS37K22xV9FH6FOTxmrZ3+g=;
	b=IK5tFPJHANImzfh6EaQoIA1DASpYTghNxa7TgWgkZO2AjN7Cm1pcdnIyZpCyj7lQe3z5gN
	Et91mUW49/a8u5YK8XSsvmp0fTS+sVPkZbb/tU3jdUzX0a7GBzvuYUGWAv9dBNQGQUGkV6
	3+nmcQZP6X8KELEwhEky8lTqdT73RxI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-Yiq-TVKGPg-k2L6MInjz_g-1; Thu, 21 May 2026 08:47:37 -0400
X-MC-Unique: Yiq-TVKGPg-k2L6MInjz_g-1
X-Mimecast-MFC-AGG-ID: Yiq-TVKGPg-k2L6MInjz_g_1779367656
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45e55c44ac1so4995065f8f.0
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 05:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779367656; x=1779972456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HUBSvYNIEeXrti7M5Q7uqS37K22xV9FH6FOTxmrZ3+g=;
        b=Xp0hxeWXTzkG+JHiiHIITTe2WKU43nP0bHUf05TxV1HgTZ6xQpVzHIoO1qlYNHdur9
         fQeWw0tV/vFZMHGFpadBy0tHwJ2LYbI4NCGFVKfmCCydVOGXqaWd7OMce8ymgTD1lPfV
         LTYAEEq6WkMFwCpZhK4KlRaM+Q1UmEH4XrWWo0qLwqLe6a1I7P9pekWJs/NkqTNmHikY
         u777LeE3eaYJjRIfG/bL7TjdsjjTk8mxkqEJS1MgTmvzdQplVQ0IPAnXwprE9PftTvgp
         ZfWh7fbnE7rJhqKcJvBL47iVTUSrTtzfKpve8p+Pws5oCE6j3pw0QJH1DrPl4z+uBTc0
         mYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779367656; x=1779972456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUBSvYNIEeXrti7M5Q7uqS37K22xV9FH6FOTxmrZ3+g=;
        b=FNUyvwbOIORX/QTyA2rXbRqCxSLkxclawjX9IvyJMDVDY2YxZL+tkmuNDJyv4elunC
         m4yOC488DdQTkK7y6M1safN2Tc94Lq+7FsddtdROnJ/q6q/Me5hMOxkwV9QuBWfzwJfP
         E5rfT8oNQz4zAyPQ1uaSZ02x4MxiifWMyB1PPyd6BQIv7zGtfdW71slIwlgsZSduLvRh
         p9ETfa/cHaKdeSj69G203/FJsm7cKE8nUNRTL2lkv2vFoAm+hENkJj/Saq1VHyN/42K5
         aDCkE3PT94s3SOCFoXusMuuEaXIxxTMHTK71U/LpSldIpi0sYbkuWjh7pRRjy2GbOOP3
         l3WA==
X-Forwarded-Encrypted: i=1; AFNElJ/stlJWkBH7zB/hrjRlv725jT3qMm9wNIrshiJDkpFAsmgyNuMJ/a2UOqPYSIonlV6fgRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBQD2yR3o2dFH/nPoPfXIn3qyHjE4ZRQD6w5F40ty70LYUrCva
	qAjUqtC2LwMCpI1BkYVHYtsQb3+xoZ0waXqCpK2wmd44P4JFcmw8dNXnN1ggFY7jW6hI1YjUT3l
	NuZUxsBbV7JHOMYZ/OEcyezKrwtohqzsM7tWHvS34zY/qrlSBpTO5jQ==
X-Gm-Gg: Acq92OGYjpAVxmlatENOYhKuad+3xXjbuxZwcnx+K1vZfgda9lXCw2dN7IpPQ1EErpb
	+oIrzx0la8Zvb15ZESnlMkKQXYSAgbdYRIjQC8GKK0XNUHT8wzBYYdff7yvgL1qE5jT/BRqI6c0
	P1Re4s4wRWmTeU+PY0ZZiL1NAGVIYxL9PheFSvfCWi8//eav8OxGLEPQFsSZuJGZ36CPjohE9Yl
	jEC8rre49+QKt8xwJpKY0fPun6/0jVXSyctpz3C1nqe3PaXPs+HpKO0DqA3eE5VhlQmClvTPGYa
	fJyQKXxhHILN32EOaYh4xuEgCZrR8QZChXaknpNcibuR4f2DhN8o4oMCNolUxNA0MnGQv9oYi3t
	s2QN9hPoAXNz1h5B+fSHctlayrWmq+YOj7+GMCDqSXGlLT76Ry8TGRL/nElLx+PNir26Hzuxn84
	gwWBBXziCrIFc=
X-Received: by 2002:a05:600c:3513:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-490360cce5fmr38604555e9.29.1779367655724;
        Thu, 21 May 2026 05:47:35 -0700 (PDT)
X-Received: by 2002:a05:600c:3513:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-490360cce5fmr38603965e9.29.1779367655227;
        Thu, 21 May 2026 05:47:35 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d52c8bsm69391315e9.8.2026.05.21.05.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 05:47:34 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	stable@vger.kernel.org
Subject: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit builds
Date: Thu, 21 May 2026 14:47:32 +0200
Message-ID: <20260521124732.125771-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
to 32-bit values. The multiplication can overflow before being assigned to
the u64 skb_overhead variable, making the skb overhead check ineffective.

Cast skb_queue_len() to u64 so the multiplication is always performed in
64-bit arithmetic.

This issue was reported by Sashiko while reviewing another patch.

Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
Closes: https://sashiko.dev/#/patchset/20260518090656.134588-1-sgarzare%40redhat.com
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index df3b418e0392..71198bf23fc4 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -417,7 +417,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
+	u64 skb_overhead = ((u64)skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
 	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
 	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
-- 
2.54.0

