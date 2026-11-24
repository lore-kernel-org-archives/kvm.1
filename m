Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562572;
	b=EV1wK0ItBOLu/2UExcL94B8R3AKwFaloW1wu3DMVq70ayvPMp3PLXxcP59eAXGcgrJMH
	 nwNwepQXaNTv/44QO18ZujXzn72QS0moZ1W+Llu4XXc5wsea80U2jrKGB/uCyPbCr59vN
	 ZQWQYPcAS8zBV3xfusHXWopwLJSCLOcwFNrA6kO10uNaxDVnM8+hSbIq33S+ehi9PV0+8
	 JJCxsQx7s41V4kodSyFN/Zfm0B9Yxq7OtaK1S0v8QGOxUcyX5NDIbXbHjWhF43qvOh83/
	 +K0tLHOlNlVvNCTkY0pe0megxPgDc7sqYm4Dyb0n4RPzPyklaWDobdHTBcTfPrdodnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562572;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=NEdqkVW780b7/EBwy88Eid9pGH6VB8HPHsnSsQzF1WE=;
	b=e1oqbnAYPVuTORilt5HpZ//DjQwmBLg6q4Jo8shaPG3bfXLUt/uAYbgEmcwzfe9e9iwi
	 89x4uJH61P/60DJxsu/vhby7qUE45acQQbmuLLTUEsEJv9Kc9WPQn/rClIfg8/rFS8KQl
	 yNdkdN3AbXKUhHb2cqHZjru53FgdqfjwGynbUuf0sBJTMhGUyEaPHanhUVzoQVxBuMPhZ
	 Sk/u5TREcke+Tf9DIHBY+UF/Ncde7vrT3pxa4OzXXiFsutqcQRKZBASwziCqTOISW6dC+
	 rfqyycCsLfxcyhs9ZLbCmjM3pqEV2x8qGFAflAGzx3W4/8uGRhfxAHm96JEGh49EWiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=iCplaFGm;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9837606A32A
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9837606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=iCplaFGm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NEdqkVW780b7/EBwy88Eid9pGH6VB8HPHsnSsQzF1WE=; b=iCplaFGmsblW2SJV3FvmC0xSrM
	1ye/eDTy0ssR0z1yr6RrPrKcPewXtbFqAjBTDsYxMSEvQeP+eWMc1kUZ7GlBZS90mpES1iL+qJt5s
	M/gQ5wEkx9PldAlvVG8Ly6la0vGtAJ+rWHDBTtUEtIL6n8MkPP7cib8lUgM4uHbcPWz5remxh1Rjr
	Gl7FsPgzW5RaeBH0k9xnbSycOBTIPyaIn3pmdq8I+Tl05mTKpPoz70qYH5wTbJnah/E2A87oXfLch
	hnHGE7ThgUKrALONFtfo7xKgkXBMV8QZKfzTo0VsBKaxseUwgvcWicSAYcJUgxZX842AjlLxZmHxp
	UyxYhBsQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVzqZ-0000000Gdhx-3FY9;
	Tue, 24 Nov 2026 23:22:48 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xVzqZ-00000000625-1eYh;
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
Subject: [PATCH v1 06/21] hw/xen: Validate grant copy segments against the page size
Date: Tue, 24 Nov 2026 23:22:32 +0000
Message-ID: <20261124232247.23169-7-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Reject a grant copy segment whose offset and length reach beyond the
granted page, matching Xen's GNTST_bad_copy_arg behaviour, in both the
emulated gnttab backend and the libxengnttab fallback. The only current
caller, xen-block, already bounds its segments to a single page.

Fixes: b08d88e30f06 ("hw/xen: Add emulated implementation of grant table operations")
Fixes: c412ba47b2ec ("hw/xen: Add gnttab operations to allow redirection to internal emulation")
Reported-by: Hui Peng <benquike@gmail.com>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_gnttab.c | 10 ++++++++++
 hw/xen/xen-operations.c  | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/hw/i386/kvm/xen_gnttab.c b/hw/i386/kvm/xen_gnttab.c
index 26d1febac4d..6e0038b22ff 100644
--- a/hw/i386/kvm/xen_gnttab.c
+++ b/hw/i386/kvm/xen_gnttab.c
@@ -473,6 +473,16 @@ static int xen_be_gnttab_copy(struct xengntdev_handle *xgt, bool to_domain,
         void *page;
         uint32_t ref = to_domain ? seg->dest.foreign.ref :
             seg->source.foreign.ref;
+        off_t offset = to_domain ? seg->dest.foreign.offset :
+            seg->source.foreign.offset;
+
+        if (offset < 0 || offset > XEN_PAGE_SIZE ||
+            seg->len > XEN_PAGE_SIZE - offset) {
+            if (errp) {
+                error_setg(errp, "grant copy segment out of page bounds");
+            }
+            return -EINVAL;
+        }
 
         page = xen_be_gnttab_map_refs(xgt, 1, domid, &ref, prot);
         if (!page) {
diff --git a/hw/xen/xen-operations.c b/hw/xen/xen-operations.c
index e00983ec447..bf0ec040bcf 100644
--- a/hw/xen/xen-operations.c
+++ b/hw/xen/xen-operations.c
@@ -50,6 +50,17 @@ static int libxengnttab_fallback_grant_copy(xengnttab_handle *xgt,
 
     for (i = 0; i < nr_segs; i++) {
         XenGrantCopySegment *seg = &segs[i];
+        off_t offset = to_domain ? seg->dest.foreign.offset :
+            seg->source.foreign.offset;
+
+        if (offset < 0 || offset > XEN_PAGE_SIZE ||
+            seg->len > XEN_PAGE_SIZE - offset) {
+            if (errp) {
+                error_setg(errp, "grant copy segment out of page bounds");
+            }
+            rc = -EINVAL;
+            goto done;
+        }
 
         refs[i] = to_domain ? seg->dest.foreign.ref :
             seg->source.foreign.ref;
-- 
2.43.0

