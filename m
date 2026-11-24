Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562582;
	b=w9VUYRSnU8DqeOGf5SOovnLW010oaBA79ghOtPRrtDW+Lvt1EtY9LexRoWKcwFn5JPKf
	 B2sMV1HeLuLcLVBIuQyBwmG/TsmAJ2pukrym17iV0iYntYRXBHAdKQtpVPiGwkH4WiXb0
	 Zxy/gAI3OBDLN96++fKuoUVjJuYVrlcFqgbyIc8KyaQCY8Je58CATPemH08S84/jhHGyv
	 x6X/3+ld/UQNax3beAn1To4HiSWYPoWxUJgJdUHZTjc7n3nXiI3s8HXerVF1kQYvEPghl
	 7GRXCFGivYfc3QC8NCbHoamLwpkGgXp/SfnVu65onk3VHTfp3z0/rdxnfpYBeN1Gu4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562582;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=GX5FpFjvP4EEA1jVsu7PkqgqUubc1fokwnXjwzK+f/k=;
	b=nJCvQ3RwACoGhr+Nu7KYQFhvMqW7r9zZrTmU8jpEyp28tQw0G+Aau1lSiwUvLp4UFypA
	 3AvkhM3wXxZ2E257OIn3dG34eXgAN0VUJ35mxyJ1fRSj9plypSLqqXg/E3Ciu7HKJcjmC
	 4EDwWTQfUHf9XizcNvcu79nhBag0NH9+pF8mlxZq7JP3GOtptskLHPbQvr7eo7WHaEHQG
	 5dPYoO3bzE3DZbQ77oQJhFXd4hiicAcU5MMPyeIQ9C+bbGQTm3Qa7GRjqCyXBD1eW1PYT
	 Jz76e7C5mo58m0LyNXf2zKxy+jE1EKMYtAsWul6a4bgwxsi++MpTDNtTY3XmTx2LUsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=M+RiDqAr;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E394D606A680
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E394D606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=M+RiDqAr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GX5FpFjvP4EEA1jVsu7PkqgqUubc1fokwnXjwzK+f/k=; b=M+RiDqArijw/ZDCdN2rh9IC72T
	AnDLGo1bE94RvoISoRLfF4+La4xY3E1zNbwK9JYkmM7kQt1oXXtriVolHzXpCxkbp6c3oCDffMEIn
	30Z06j92HhyZcixxR69c3UdU8U3zQSXxPS1RE0fg7dKmaSmGChiWPrQPt1P0e6BaFU/36MLqqmyJ9
	ryxBxSC3GDO9/cKytp2TVuLfkdT5ed6xhDOzdj+H22Lm/OcDB7tNkVlIZ9I0Uj0TUGr/rt8TAT3mJ
	RgR1JMIAUf5SXpmDaZkB7UVh8Bbn7hu2fd6hlQgz6EmYGaS8+duV/kXmHEAy350ZUNXbf66J67Af2
	t5s2cHfA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVzqc-00000004eV6-1lWW;
	Tue, 24 Nov 2026 23:22:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xVzqZ-0000000062k-2dPl;
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
Subject: [PATCH v1 15/21] hw/9pfs/xen-9p-backend: Validate the request header size field
Date: Tue, 24 Nov 2026 23:22:41 +0000
Message-ID: <20261124232247.23169-16-dwmw2@infradead.org>
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

A request whose header declares a size smaller than the header itself
was accepted, submitting a zero-length PDU and advancing nothing, to be
re-processed on every ring kick. Reject it instead. Set inprogress only
once a request is accepted, so returning early on a half-arrived or
malformed request no longer wedges the ring until disconnect.

Fixes: 40a2389207fb ("xen/9pfs: implement in/out_iov_from_pdu and vmarshal/vunmarshal")
Reported-by: Hui Peng <benquike@gmail.com>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4523
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/9pfs/xen-9p-backend.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 22b2190b1b6..430de23fadb 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -314,7 +314,6 @@ static int xen_9pfs_receive(Xen9pfsRing *ring)
     if (queued < sizeof(h)) {
         return 0;
     }
-    ring->inprogress = true;
 
     masked_prod = xen_9pfs_mask(prod, XEN_FLEX_RING_SIZE(ring->ring_order));
     masked_cons = xen_9pfs_mask(cons, XEN_FLEX_RING_SIZE(ring->ring_order));
@@ -322,9 +321,18 @@ static int xen_9pfs_receive(Xen9pfsRing *ring)
     xen_9pfs_read_packet((uint8_t *) &h, ring->ring.out, sizeof(h),
                          masked_prod, &masked_cons,
                          XEN_FLEX_RING_SIZE(ring->ring_order));
-    if (queued < le32_to_cpu(h.size_le)) {
+    /*
+     * A size smaller than the header itself is malformed; returning
+     * with inprogress still clear means it is simply ignored until the
+     * guest fixes up the ring contents. Do not set inprogress before
+     * the request is accepted, or a half-arrived request would wedge
+     * the ring forever.
+     */
+    if (le32_to_cpu(h.size_le) < sizeof(h) ||
+        queued < le32_to_cpu(h.size_le)) {
         return 0;
     }
+    ring->inprogress = true;
 
     /* cannot fail, because we only handle one request per ring at a time */
     pdu = pdu_alloc(&ring->priv->state);
-- 
2.43.0

