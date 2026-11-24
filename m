Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562582;
	b=B7WdIL/DsertYONHoZ1t5otob4GGw2+sbLdS5bmwBc3Cb0lBadWLRdUC2dV2OiWFalRL
	 d+Z6OaZQgxAtv8EFYucrYDULBBQQ5a+OAlyv/SYyL+nMP/k+KY1c/LtQPmJXRLzqLhICo
	 e5bC5FcNaiecSAaQso78tEHRfLYQDjOLPizItqwYnCry5kUtvVIiNc6nlhxmli9Sjk3Eg
	 BKgRc/W4kly3CLSsT8LuRGL0IoqbIqA5vmGuEen/u8j8Qz7aBfloJiyPmlKUCMZe5LhrH
	 p/MmCwHpHhaQELsmNB75vqrGURcUZ/3Htfl30zntTwKlVUQY0Tgkl5DZzALWeAxFWJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562582;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=DwSIl3YjsuOZ09uV3T3X5vCjJ3huKi3Xcf0yWKrN1pw=;
	b=WnXzpGJe5mo7NSe6Rib1zOoZyudHs1AP8ngJ86NZipzMxv/PEgy1/JtJ7aOp0Rao2Skq
	 BW5Mox0CP/SlzSHNi57/ZSbtE6YottFwFyJ1oO9mptpRDgiwev7YUNoxrhxDKdi+GaOeS
	 KA7VUZjIUUUug9Vd8APzK3kWXsfYTohXB084xa2uhcFbwq5sXqpZE6iPdTco0QGc17LEu
	 v7BHmdJ7IFCHWcjoCkKTX4WGSBrp2LPvUKoPhyHfOcvdgy6xfJeAmDYDSHtUStODH5UKk
	 ym91lPqxlCzR5CBetcec44ZdXxLJbm3nq2Voxr5hAkdcoWEn2GBceMJu9ATc1pDRQkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=kGl8PcHH;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3931606A332
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3931606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=kGl8PcHH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DwSIl3YjsuOZ09uV3T3X5vCjJ3huKi3Xcf0yWKrN1pw=; b=kGl8PcHHViYt2K1voQ4sTXfXqn
	CpRywx944KOHnJDx5JoW02cyU+m3ejXVFJJQiHdDV8rh1F97bHkwrEtfOVkHmtdFwWlYQCMDOHjgK
	h7S9qttzUGqtl/A+WcIbXI55+v+Jk2ZPCWvBW6caH8sqPVN+Zb7q28JD1eyAP/zF/C3o+YlgK6Ifq
	o/tPtagB4ZTWDkv3QxAGZaCD2o+MdN9mnLCm3SEv5Y3lSwVZtjcxWQOKaUxcyfuJBEfzc3hWGja5Q
	BrYoI6ZBzoMR/g2m2HqYg0iI9aWeTm8icM4HbwzIyDm+axrIUc/vy9rVTdeNudlk82xRC/lFNpGyK
	V4dMRhpA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVzqc-00000004eV5-1kcJ;
	Tue, 24 Nov 2026 23:22:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xVzqZ-0000000062g-2Xfp;
	Tue, 24 Nov 2026 23:22:47 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
	kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paul Durrant <paul@xen.org>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Anthony PERARD <anthony@xenproject.org>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Hui Peng <benquike@gmail.com>,
	Mark Syms <mark.syms@citrix.com>,
	Feifan Qian <bea1e@proton.me>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v1 14/21] hw/9pfs/xen-9p-backend: Use validated snapshot for request iovecs
Date: Tue, 24 Nov 2026 23:22:40 +0000
Message-ID: <20261124232247.23169-15-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232247.23169-1-dwmw2@infradead.org>
References: <20261124232247.23169-1-dwmw2@infradead.org>
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
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

xen_9pfs_out_sg() re-read the consumer index from the shared ring page
when building the request iovecs, so with an index the validation in
xen_9pfs_receive() never saw, the iovecs can reach past the end of the
ring mapping. Reconstruct the index from the out_cons/out_size snapshot
taken at validation time, and split the iovecs purely against the ring
size.

Fixes: CVE-2026-123072
Fixes: 40a2389207fb ("xen/9pfs: implement in/out_iov_from_pdu and vmarshal/vunmarshal")
Reported-by: Hui Peng <benquike@gmail.com>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4523
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/9pfs/xen-9p-backend.c | 43 ++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 06709d54084..22b2190b1b6 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -105,34 +105,29 @@ static void xen_9pfs_out_sg(Xen9pfsRing *ring,
                             int *num,
                             uint32_t idx)
 {
-    RING_IDX cons, prod, masked_prod, masked_cons;
-
-    cons = ring->intf->out_cons;
-    prod = ring->intf->out_prod;
-    xen_rmb();
-    masked_prod = xen_9pfs_mask(prod, XEN_FLEX_RING_SIZE(ring->ring_order));
-    masked_cons = xen_9pfs_mask(cons, XEN_FLEX_RING_SIZE(ring->ring_order));
-
-    if (masked_cons < masked_prod) {
+    RING_IDX cons, masked_cons;
+    RING_IDX ring_size = XEN_FLEX_RING_SIZE(ring->ring_order);
+
+    /*
+     * Use the consumer index and request size snapshotted when the
+     * request was validated in xen_9pfs_receive(). Do not re-read the
+     * index from the shared page: the guest may have changed it since
+     * validation, and out_size (bounded by the ring size at validation
+     * time) could then reach past the end of the ring mapping.
+     */
+    cons = ring->out_cons - ring->out_size;
+    masked_cons = xen_9pfs_mask(cons, ring_size);
+
+    if (ring->out_size <= ring_size - masked_cons) {
         out_sg[0].iov_base = ring->ring.out + masked_cons;
         out_sg[0].iov_len = ring->out_size;
         *num = 1;
     } else {
-        if (ring->out_size >
-            (XEN_FLEX_RING_SIZE(ring->ring_order) - masked_cons)) {
-            out_sg[0].iov_base = ring->ring.out + masked_cons;
-            out_sg[0].iov_len = XEN_FLEX_RING_SIZE(ring->ring_order) -
-                                masked_cons;
-            out_sg[1].iov_base = ring->ring.out;
-            out_sg[1].iov_len = ring->out_size -
-                                (XEN_FLEX_RING_SIZE(ring->ring_order) -
-                                 masked_cons);
-            *num = 2;
-        } else {
-            out_sg[0].iov_base = ring->ring.out + masked_cons;
-            out_sg[0].iov_len = ring->out_size;
-            *num = 1;
-        }
+        out_sg[0].iov_base = ring->ring.out + masked_cons;
+        out_sg[0].iov_len = ring_size - masked_cons;
+        out_sg[1].iov_base = ring->ring.out;
+        out_sg[1].iov_len = ring->out_size - (ring_size - masked_cons);
+        *num = 2;
     }
 }
 
-- 
2.43.0

