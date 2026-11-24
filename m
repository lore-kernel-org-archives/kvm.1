Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562582;
	b=SPN78rypewJPGGDggBfPegXD01skp5x7wR03lFe5vvJGV4iJ2Te76kaFDuYw8ZHvYh9C
	 8e8Wvt6q9sE13d0+WKI29PeDm0NIUTUQWUqEuZo0nOpq+O1Y1RmFt9nlGaQgChzMnseeZ
	 pFxrdv4cLEPp7xAgPyO4VLpJUplyLRetEabiUCQgVSpDZPXe2CCmNOMGnnge4yzZWmxCg
	 GhgA/4Ee7q2A6+1Wbm7KSaVaBxZxvv1ThI6qQdYDJbgag73k964l/AQryeqMtzV/hIS5T
	 r1nAz7cbVXlov4VCfko1PHd60mTGrf4ljzyD9DzOiQhx3ND93tXMjd+a5VekE0/Arwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562582;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=CuCNOHrw3g5kpN0eJlwQJDa3PSDtkFSPqrd1YVfbUH4=;
	b=DDaEiGEl31r907WwKJSBlpxeJl9wq/1eMNdHeSPrNlXPgmNa86ubEjJUPXBF0n6CQwsu
	 cnGKKHMvrDHEjHC22U3YWzhkozJS/EL0pfzdC04vqDCm9Ezvl9tpVySeFgr+4bHbcXOPq
	 scDdUfVgex/Vye7HgkX+Sc92DL/0p9na5/BYGNcZ+kyGhpmxeSsYIwPfDXV3/LI2v9zgB
	 YcgdPuXV/6WNkvnw0wSaseWW6RxTWrTGGxWQQTFJBakoflBSyJNf+TnUGupP1ixRlAI4t
	 6X5xIzYSrHjSatERHzgDlEgIyp0ADiUuKGzOXnnVwKL8lWqVbw+KBYjwjGOekhPpMDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b="TwVely/1";
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39AB606A686
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E39AB606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=TwVely/1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=CuCNOHrw3g5kpN0eJlwQJDa3PSDtkFSPqrd1YVfbUH4=; b=TwVely/1oU3dXIXs/wYs9bg3V7
	v9Nr5aM4ZZiTZw6SLi74DnVzy7ZBLWoznl+XKvXaln4y2FdYnT0A/ILwNp339CIgT4I9CXALgwjqr
	RmjtdBRxqB8aHygJAbNoXA6G/wDDL31jtfoJVbbHAXaI1pRLBnqN61POd36Gsowg6z3q8bqh1Ig2m
	sTO3i7pWZyUfcogkMXBaC7pZIGcqziE/qAUQMWr8gYJcBXXwm+1hPKpHx6TTSD3Ly12Abn0Ykl4lu
	vz/j8JhOcbDhaphlqd+SmhmMpa0l7TWz3MUd5V9g6H3d+NIIQn34Vt8a/F6vyXfAkEUOPTIzQ8kHp
	Yhgu418Q==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVzqc-00000004eUx-1kJG;
	Tue, 24 Nov 2026 23:22:58 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xVzqZ-00000000622-1Xjf;
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
Subject: [PATCH v1 05/21] hw/i386/kvm/xen_gnttab: Fix error handling in xen_be_gnttab_map_refs()
Date: Tue, 24 Nov 2026 23:22:31 +0000
Message-ID: <20261124232247.23169-6-dwmw2@infradead.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

When the grant's target page cannot be mapped, the failure path calls
gnt_unref(), which asserts that the map_track[] refcount is non-zero —
but the refcount was only incremented after a successful mapping. Take
the reference as soon as gnt_ref() succeeds, so the failure path stays
balanced.

Refuse writable mappings, including a write upgrade of an existing
mapping, when the underlying memory region is read-only, and set errno
when the upgrade fails.

Fixes: b08d88e30f06 ("hw/xen: Add emulated implementation of grant table operations")
Reported-by: Hui Peng <benquike@gmail.com>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_gnttab.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/i386/kvm/xen_gnttab.c b/hw/i386/kvm/xen_gnttab.c
index 85b324e62d0..26d1febac4d 100644
--- a/hw/i386/kvm/xen_gnttab.c
+++ b/hw/i386/kvm/xen_gnttab.c
@@ -363,7 +363,9 @@ static void *xen_be_gnttab_map_refs(struct xengntdev_handle *xgt,
     act = g_hash_table_lookup(xgt->active_maps, GINT_TO_POINTER(refs[0]));
     if (act) {
         if ((prot & PROT_WRITE) && !(act->prot & PROT_WRITE)) {
-            if (gnt_ref(s, refs[0], prot) == INVALID_GPA) {
+            if (act->mrs.readonly ||
+                gnt_ref(s, refs[0], prot) == INVALID_GPA) {
+                errno = EINVAL;
                 return NULL;
             }
             act->prot |= PROT_WRITE;
@@ -376,12 +378,19 @@ static void *xen_be_gnttab_map_refs(struct xengntdev_handle *xgt,
             return NULL;
         }
 
+        /*
+         * Keep the map_track[] count balanced with the gnt_unref() in the
+         * failure path below, which asserts that it never underflows.
+         */
+        s->map_track[refs[0]]++;
+
         act = g_new0(struct active_ref, 1);
         act->prot = prot;
         act->refcnt = 1;
         act->mrs = memory_region_find(get_system_memory(), gpa, XEN_PAGE_SIZE);
 
         if (act->mrs.mr &&
+            !(act->mrs.readonly && (prot & PROT_WRITE)) &&
             !int128_lt(act->mrs.size, int128_make64(XEN_PAGE_SIZE)) &&
             memory_region_get_ram_addr(act->mrs.mr) != RAM_ADDR_INVALID) {
             act->virtaddr = qemu_map_ram_ptr(act->mrs.mr->ram_block,
@@ -394,7 +403,6 @@ static void *xen_be_gnttab_map_refs(struct xengntdev_handle *xgt,
             return NULL;
         }
 
-        s->map_track[refs[0]]++;
         g_hash_table_insert(xgt->active_maps, GINT_TO_POINTER(refs[0]), act);
     }
 
-- 
2.43.0

