Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562582;
	b=0GjKtmBvGIFyJwbBKw16uIRI3WLuN2eEraTZYtr77IZJNfcq+aocbX+QxGAk5CnuASGa
	 Nuo08LheB9GfnHd+Hf0g66Ty5AItFbSqstSMP30Y7u2c1oUAw8CKfM5S7kvA6PzohVa6f
	 BDbJHjgQ8LQYihkCw5P9RwCqUlJaITnvNZMyC0UzVuPHcsi1rjJ5r4y+K3Y6/eHaaW1Pj
	 ufBxlzYLP1MC0k+jyWMHuBWxYeTul8KuU8LbysRdHm9rRz0ujshyCh4HW9iy+8HisjVe1
	 HhlETRBEhT+UUSin47MPgS4wl1vCabpxGSYtoFcOlrjM9qrKmQaZtqpUxYwCKBOa4/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562582;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=KXxedB2pK6pXvErwQ2DMjcN5CVWCsn8Q2L2nKaNMhso=;
	b=VApJ1GtW25Pyk4uyDeB3Lue9Y3ScrdBN2xOc4Azq4LvT0zsvW7ziB9U8P3j0HfmTJr9m
	 +XxbuqsWQqj7oiQ5u0nuiqNRRqxV4lUvUSpXfba4Div0W/eysmWmEJsfvaC1MYS5rUoJ2
	 E+G2NGSuvU9lBNsYzRovyVEpkRmXAngV25BLodpn8Xhk5Zn/nxl21qYkZEObqg0UhkvMg
	 Cb3G7rIHVLihx+osustu9ZJhCwMfPMBU6IWwvY5YUSKawQLvU5BX7cXoanvHmNGCN9Qs0
	 qzBSVePntyM4+nfKiY/czTGt15fv9wxcD/acI4S0LwH4RfnRVkCve5AwPQhAboBl9AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=IBzxmwof;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39CD606A688
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E39CD606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=IBzxmwof
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KXxedB2pK6pXvErwQ2DMjcN5CVWCsn8Q2L2nKaNMhso=; b=IBzxmwofTwZI485wtJH6dOx8RK
	O/CR8Q/7G8CvgmT675huSFzRGjm4+j5Pk3pldINu8LFSpINN3m+ANLHBINx32FID6NOvrnpGoAMOT
	j90FspoZlnbR5CYJayzDYOJ45NxXE97LS/Nd8Wstv7ANgOyP/OZZiT0iZP4s0SGFexwiYD+gQaj1+
	84SpzleCzHxHZmZtTsNkyb5Q3sTYmkFkgKxAOfMmLZ2xH9IVYnlao/ExcbX2JHWEPzj96VhMOC+PZ
	FnUkQwTEGjXt77pNf98NndWpKQHIMlixCx3bItruRQ0j1f7/regg1WNNDQCm/Cv/5e2gZbtvZzsbF
	0b8g2YMg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVzqc-00000004eV9-1k12;
	Tue, 24 Nov 2026 23:22:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xVzqZ-00000000638-3F7z;
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
Subject: [PATCH v1 21/21] hw/i386/kvm/xen_evtchn: Allow unmapping an emulated MSI PIRQ
Date: Tue, 24 Nov 2026 23:22:47 +0000
Message-ID: <20261124232247.23169-22-dwmw2@infradead.org>
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

The "unmap GSI PIRQs only" check rejected every negative gsi, which
includes IRQ_MSI_EMU, so the later IRQ_MSI_EMU branch that flushes the
KVM MSI routes was unreachable and guests could never unmap an MSI
PIRQ. Xen permits it: physdev_unmap_pirq() on a domain with HVM pirqs
routes emulated-IRQ pirqs through unmap_domain_pirq_emuirq(), which
succeeds for MSI emuirqs. Let IRQ_MSI_EMU through; the existing
unreachable branch then does the route flush as originally intended.

Resolves: Coverity CID 1507603
Fixes: 6096cf7877bc ("hw/xen: Support MSI mapping to PIRQ")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_evtchn.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index cfe735219bf..5a986c1e2a4 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -1925,13 +1925,15 @@ int xen_physdev_unmap_pirq(struct physdev_unmap_pirq *unmap)
 
     gsi = s->pirq[pirq].gsi;
 
-    /* We can only unmap GSI PIRQs */
-    if (gsi < 0) {
+    /* We can only unmap GSI PIRQs and emulated MSIs */
+    if (gsi < 0 && gsi != IRQ_MSI_EMU) {
         qemu_mutex_unlock(&s->port_lock);
         return -EINVAL;
     }
 
-    s->gsi_pirq[gsi] = 0;
+    if (gsi >= 0) {
+        s->gsi_pirq[gsi] = 0;
+    }
     s->pirq[pirq].gsi = IRQ_UNBOUND; /* Doesn't actually matter because: */
     pirq_inuse_word(s, pirq) &= ~pirq_inuse_bit(pirq);
 
-- 
2.43.0

