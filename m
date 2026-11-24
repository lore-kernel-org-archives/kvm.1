Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562582;
	b=TIizZaPKHWbOtshxGBjdn9WCufsagXnRisFqsVh528iiv+8tRYShx7QjpjvEeWhAbsKo
	 xjJuUFi77hUQdEW1Y0pzgPttrzMBjprRO4ni7x90b7AEat+e2UyLUpAeA7rZqk7aKR7ji
	 YrW0vYVrSDXlkAnl+kg8gprOk0cKBCsAbc4bFZpxuvTrt+fNBbX7SWVJ0iHkCI/kNpmd6
	 Z4yj+PRNrW51UL024LGpkudj50wrEZV/tOCAu6dPgZTSXxgmIkyOlu32RgrnA/bSvSWbJ
	 +oF0HUCuXGGxscumMQF0/kQ67V6mievaaS9sS7ip5Zli1UbK0knVRXYjXzIpK1y/mLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562582;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=ru4a8UM9O3xCvIpKu2plhw/a8+vAtA+xiCf/OELsEVY=;
	b=zRQypEksK8EabbQSv2ADIXlShsv4PDZ2TZb7ARmPqzp9x8ok86wqAaw4Lelg2wRuVLdc
	 6XHToWeLA/21gaAtzXCt9B4utjnjAHhwKx5YVy0mbUNSAZIjDRpcsHcaIP/KmJDuVPuyg
	 QFGOJ2CGsyLU1o7e/zCc3UFKPw95tw13d5C5fdsxdweRFlf/6QCMsseW3SgAxlyVY/Cvf
	 XBS1Fzh/kXVk01Szg0Btik/mv0HnDXc++c32vljcsa8uYj+FCOsmyENQlGBFOTGYJSuyy
	 spseIdlJDRMg4rcpj0cX0AGRR+iWlruG0Ltep2a3bsYtK6cehnrgbgWTFWc7bpvGIMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=WRHaMACr;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3971606A681
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3971606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=WRHaMACr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ru4a8UM9O3xCvIpKu2plhw/a8+vAtA+xiCf/OELsEVY=; b=WRHaMACr7U547v9WsamrbQoawa
	fPF/kHI27grJEbdrnlIBH7N29jbWjnv+JfB7onyE9iPhQbUREJcwMWuM6vIHflMHMB1L7jIIyZs4f
	kcaFoK4GVkf7AJGpChTsP/9mne7aTYIroB4kGlo5ylsq92Id+x+cvsO13bR3/PlIiQrxjLOkvBxNW
	UMW9ANbOiPoPgglDCvH5Rl1or6RXkMCJpfVXn4EHvp3IusB5rAxM9TBvxAKuHTT77DVUiuDi1y0ue
	fiBe1ifeYtHBgOaf0NVIy8dPf0GGmyqMtxGj16/Z1LIv2CVHjWjqldYF+ps2Gyw/yNKlbNkOy+kG4
	sIt/Y2ww==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVzqc-00000004eV7-1qji;
	Tue, 24 Nov 2026 23:22:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xVzqZ-00000000630-33i9;
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
Subject: [PATCH v1 19/21] hw/xen: Bound the rep count of PIO and MMIO ioreqs
Date: Tue, 24 Nov 2026 23:22:45 +0000
Message-ID: <20261124232247.23169-20-dwmw2@infradead.org>
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

cpu_ioreq_pio() and cpu_ioreq_move() iterated req->count times with no
upper bound, so a count of UINT32_MAX kept the vCPU handler thread
spinning through four billion iterations. Xen's instruction emulator
clips a rep batch to at most 4096 repetitions (hvmemul_virtual_to_linear()
and hvmemul_linear_to_phys() both apply that bound before an ioreq is
sent), so reject larger counts as malformed, and reject a zero size, as
the other framing checks here already do.

Fixes: 9ce94e7c8a99 ("xen: Initialize event channels and io rings")
Reported-by: Feifan Qian <bea1e@proton.me>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3756
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/xen/xen-hvm-common.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 62d88804c43..48ce655448b 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -321,10 +321,20 @@ void cpu_ioreq_pio(ioreq_t *req)
     trace_cpu_ioreq_pio(req, req->dir, req->df, req->data_is_ptr, req->addr,
                          req->data, req->count, req->size);
 
-    if (req->size > sizeof(uint32_t)) {
+    if (req->size == 0 || req->size > sizeof(uint32_t)) {
         hw_error("PIO: bad size (%u)", req->size);
     }
 
+    /*
+     * Xen's instruction emulator clips a rep batch to at most 4096
+     * repetitions (hvmemul_virtual_to_linear(), hvmemul_linear_to_phys()),
+     * so the count of a well-formed ioreq is bounded. Don't spin for
+     * 2^32 iterations on a corrupted one.
+     */
+    if (req->data_is_ptr && req->count > 4096) {
+        hw_error("PIO: bad count (%u)", req->count);
+    }
+
     if (req->dir == IOREQ_READ) {
         if (!req->data_is_ptr) {
             req->data = do_inp(req->addr, req->size);
@@ -361,10 +371,15 @@ static void cpu_ioreq_move(ioreq_t *req)
     trace_cpu_ioreq_move(req, req->dir, req->df, req->data_is_ptr, req->addr,
                          req->data, req->count, req->size);
 
-    if (req->size > sizeof(req->data)) {
+    if (req->size == 0 || req->size > sizeof(req->data)) {
         hw_error("MMIO: bad size (%u)", req->size);
     }
 
+    /* As for PIO: Xen clips a rep batch to at most 4096 repetitions. */
+    if (req->count > 4096) {
+        hw_error("MMIO: bad count (%u)", req->count);
+    }
+
     if (!req->data_is_ptr) {
         if (req->dir == IOREQ_READ) {
             for (i = 0; i < req->count; i++) {
-- 
2.43.0

