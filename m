Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572940;
	b=x+NdFJgfTiLPuGEuS5cjpY7gLOTDU47YA0Ie2TlbZ4A6TXZlGqIE1E+Od4Rm6JabbMMM
	 7K0tRdYI2/PLmLDfG+ScV3aUEhjlGSRMC5R3bj9pgqUSjiYQ5cRk/25TWssE+GKI3g/3x
	 nENUy2BuxCYWaRCbdIyI3qA25fm5LYnfP9L9t/9tV7UbJsQp6ZqL17SG5Y07svtHgqJa6
	 +GIYndenvt3mx45c9hCirzXlk1h5vLXrm5S/7h3IL08IPkECwupgwL6mLP4mI0vO5UMp2
	 EvR0VPbsLovFYq0SQtIasLTlOMJSscoLzHCRziCKv4YjAu3mb8E6dBYV4LrFwYzHD9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZlzMMtlOMt0j7sxnZGkr7qkygcFA8MGAgcH9bAVX7Kk=;
	b=wIz8UeaCQcjUbL17stO3i99ZVogpNFhtwhYKcUD+VlHlFfYir+v/wKalHX/DMZpJuY6/
	 Aj23aUqNMxPL0CB8kVYk7ZKU2arkDSqUYHA49hArfSINqBuMUukXi/xLV1sOSakKH8v8d
	 I00VdIdC59gsdFGUl5xU2Ylg2twcQnGbgSusQDC39ln/KcTc9NzMERarmrrcuk9gTeGpi
	 qgo40LErWcBdTuGPqVvCAic7BjXGtfPOJphDOXpuYvJrMhElpdq8KdUG02Upsj2pD+wzc
	 AoetWWRFDxgxmu84hns4ELeRBRjerswhi4zVjyGbt1SgcUACS5DnuJPw7uc+IfwiswQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q63ZWMYw;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BA3606A31C
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 08:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3BA3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q63ZWMYw
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso305140a91.3
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 01:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792572939; x=1793177739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZlzMMtlOMt0j7sxnZGkr7qkygcFA8MGAgcH9bAVX7Kk=;
        b=Q63ZWMYwY2xiEcGgxNT+yzrIlSaw9gGr5WmMgDxgjgm7sxXVG3yzck52PqI5GprMdC
         0YqC8fY/9VYDsWb6Mw+YnkSo0Q5zzMuwZTqwk99O1vHcqh4zIyKbb13+fHmmKwH2O1bT
         TjC06GLD1Bf2MvZiPAj0Yb4RkP468nRt4HZtclmCnhYNMF/XcJXxaC/d3cGHUvx3U1Uf
         phMYsUrcDAVSoLAs5Yp2Av74cYiwVpLJzASoz3MHKVTzRKP+5wqpnvI4sAPOGZRpzV/z
         ZBdICmaDUU+/c0Wx8a+ojZ9sm+P+Z5cjrFzRe9YC726WzvQgEIgmpAPgKlO+mvbbj7Qt
         2UjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792572939; x=1793177739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZlzMMtlOMt0j7sxnZGkr7qkygcFA8MGAgcH9bAVX7Kk=;
        b=mqrjNY/q/Iy5DqYP5LN1WIuHjqIMyMjVhCcplQVJe+8xJI8gW9ymNCtPWpt30iHl4z
         5SDqCk2kZoV5jQ7W1fdEtLrjKKtwo3mrUS91Mgzn5NtemlSItubuZkRU7XfqnuFvNARu
         0AItZ0Puaf7pVsiwq2M45hFCJOLYscW6Ki65GWSO4z/6pbS1dWkkMcxd3IRUv/GVGzP0
         gQ+S/7upnr9fb9J0flUdgz2tSWZmvbs09tv32tJQp2ww7P72vexo+0aGPa58YvZOKAdY
         XCE8DkwbzU7ufP4sLD0Iqz80KKtSWNDljrEdewSTXUSeotdAHDqX7eG2ctR/kVJfX5Fy
         OJKw==
X-Forwarded-Encrypted: i=1; AKwUvBzmXWF18IDnkDfcLx5b81jtlHFk759Ev8wmAKB4R2tvYZDQXS9wnO79EdWGOlJF8QPHAP8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYKv0A3nRNigcAFIDcaoiezM4iQZFinB+Iym2Ql0u5edcP9vbm
	//ESCiLb291fMLNPCLIOYXIVUUNXn9CN49spH9f4QlAPClT8AVoXTpi3
X-Gm-Gg: AYBFou1wNtNYq2WT61pPFn0J5DNgkGTOVLHjHJdZwyyHUW//yhdH7ClwgEG21DzFPAi
	yyFvjBkkXWxI0M/mftq4mjxTXORMQHNONSQOnlT3mAICFf96yIKkpxpDvmHqvJLn4bOKGEQTQzc
	NIfAUA0cVQMgoLaiAYjO5sfRGlXkQ9KSYfo1JvtyK1OjcEpBbKAhYoOBAxk5DDOqfIIoQIFKRat
	wr+q+UyGMAtS5k3c+quMIawqIHJ/bJgJmYc5g/0LYLH7YfywvEIkBt7vtjB19IP3IKGW2v/XZ8c
	3s+gF4ZD7KTvIbxJ/+WallAxIWOiulRbH+qGCnEOH6i60Jvgb7ga/o4Sx0YAticInV/hEw2Op9r
	m/Z0QXIjiNhjyIMEJP3HhIwRo7E2mgrzfb0Dnto+4oyhscrhpWyaknAExSC20D29EE48EIJWv2y
	pkm/VWiW5uD9jD8yO+W/J6KBOSZAo+oU7Ck9CoeRz3OTsq4qFrXYevfF/eD4qK5K0LTmk2wifxx
	uczrH4ZNrnxxwD5V0cVDxs/zZ6mqwXfeCznDLKgkdBwrL3CDOheWGY=
X-Received: by 2002:a17:90b:2f8b:b0:3ad:6781:da66 with SMTP id 98e67ed59e1d1-3ad86c79915mr1116703a91.23.1792572938794;
        Wed, 21 Oct 2026 01:55:38 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad85f56b03sm1398207a91.3.2026.10.21.01.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:55:38 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost-scsi: fix page reference leak in misaligned I/O fallback
Date: Wed, 21 Oct 2026 16:54:58 +0800
Message-Id: <20261021085458.196742-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iov_iter_get_pages2() returns a byte count that excludes the offset
into the first page, but also returns a reference to that page in
pages[].

On the misaligned-I/O fallback,
vhost_scsi_revert_map_iov_to_sgl() puts pages already added to the SG
list.  The cleanup loop starts at pages[npages], but accounts for its
first page as PAGE_SIZE bytes rather than PAGE_SIZE - offset.  If the
remaining data starts at a non-zero offset, it can finish one page
early and leave a page reference behind.

Use PAGE_SIZE - offset for the first remaining page and clear offset
for later pages, as in the mapping loop.  Without this, each affected
request leaks one page reference.

Fixes: bca939d5bcd0 ("vhost-scsi: Dynamically allocate scatterlists")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
Testing:

- Four fileio vhost-scsi test instances repeatedly issued affected
  writes using recycled backing pages.  After about 1.33 million
  requests, MemAvailable fell from 5.3 GB to 13 MB and swap was nearly
  exhausted.

The affected fallback is reachable from guest-issued virtio-scsi I/O.

 drivers/vhost/scsi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 4f8c0260bc9e..b7e41c0a91d4 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -883,11 +883,16 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
 	vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg);
 
 	iov_iter_revert(iter, bytes);
+	/*
+	 * pages[npages] is the first page not added to the SG list.  The
+	 * remaining data starts at offset in that page.
+	 */
 	while (bytes) {
-		n = min_t(unsigned int, PAGE_SIZE, bytes);
+		n = min_t(unsigned int, PAGE_SIZE - offset, bytes);
 
 		put_page(pages[npages++]);
 		bytes -= n;
+		offset = 0;
 	}
 
 	return -EINVAL;
-- 
2.47.0
