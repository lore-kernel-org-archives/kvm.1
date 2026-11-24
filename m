Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562584;
	b=fW8qtgMaZjXFRTWb81SGcN1CeXbtqIXlgsbXmeJmyzgXsAAoynPVYCQU9Cb95Li16wNR
	 oGRTQ2g81WMYbrxQa5CkKWKZInAvrZeIOZEN+1d0vBRZxTFWwJcXlwHWgH9B8kt+uOzrI
	 ctF9dNPhqDHqITxvuv9KWvgjqoFnKgLSrqwulfb03KT87Ie8aHWtNLjGFRG/moNGBZeuA
	 GpemFLErLpVw7ks7TZpSlgWlvBh34Lwi+EpT54nSdA8FR9mCbfLxIjxWn+3a812yRj4yH
	 qGg0v5GqTJUdYZ/uU0Z5PhTvCwfSArsVopqHyhMod6RuHOuLfnOUP0pKtIqiEYBGPjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562584;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=i4B6bqyTVLsX4pdrr6Z2tGS5jrujsXnubmc2oU/AG+g=;
	b=gxvyCJ+Kq5+Q9jDezkBhfI+HAELtgwp2L7yjjGApyN2Nbh1J31S5T/G//dqa3YusKlHM
	 YUszPFYyH4U/fnBMTWq9G8XA4lp3EEE+/8u1EGoS/J2QgSAqlEVP+xhKmgWbIhzKZa3ab
	 Y2Llo0FKW1T+OlnXXMvwzPtatoSKBU0qIRqRNwVwWIobaoS6mNEMKuxulgr3MKLuUPPWI
	 oFt1zsxyWqQ+of9+sBYdWveNjDIFMaPQqsSL1FCfHt78dMaiQ3t91dl6zeZVVLHLrrRgU
	 g/WFG9pnPiwIIn3+AGc+DXvm/pXi4+p3+PO2+qfJLRKOpNYT16hY8mXzw0zAbfMamUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=rIrIBwsh;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8E6606A684
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F8E6606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=rIrIBwsh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=i4B6bqyTVLsX4pdrr6Z2tGS5jrujsXnubmc2oU/AG+g=; b=rIrIBwshFRXjX80qqkWQWRBXqq
	lQU9dpwGYR3lEvehHB9qQgedtr7BuNS/gZVAnHn1qPcBEtfoDeJ8KSjJstpQk2vSHumx7CcALNHN/
	5jKp8Sg8/XuU5V/Qh3cIjLKqg2QL5C9AuwIhnwDoBODqEjaiC7XD6w9PNn3vpHTNQ+IKLOEp9ZD30
	OKAi22XLiRXzwaWUKIO44rfp77bw95a0jrJelwc73g8zV3/4RuNT16TqR37qtqABuUMEAtRK2LxzF
	/CRV2cFAtGRo/5NiYpfXF2Dx4/29HRkMBLMG1L5Aht/fVnJtnh9nLPOwy7cKuuFs5+DivPkXHSXyQ
	n7YonpXw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVzqc-00000004eV8-1lDN;
	Tue, 24 Nov 2026 23:22:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xVzqZ-00000000634-39To;
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
Subject: [PATCH v1 20/21] hw/i386/kvm/xen_evtchn: Hold port_lock for whole of bind_pirq_op
Date: Tue, 24 Nov 2026 23:22:46 +0000
Message-ID: <20261124232247.23169-21-dwmw2@infradead.org>
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

The check for an existing binding read s->pirq[].port before taking
port_lock, and the allocation wrote it after. The BQL serialises the
writers in practice, but holding port_lock across the check and the
allocation is clearly correct and lets Coverity see it too.

The region now under the lock is pure port_table/pirq bookkeeping.
The MSI unmask and kvm_update_msi_routes_all() calls must remain
outside port_lock: they can re-enter via the MSI translate function,
which takes port_lock itself. The PIRQ→evtchn→GSI delivery paths have
further BQL/port_lock ordering constraints — see the comments in
xen_evtchn_set_callback_level() and xen_evtchn_set_gsi().

Resolves: Coverity CID 1527403
Fixes: 6096cf7877bc ("hw/xen: Support MSI mapping to PIRQ")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_evtchn.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index e2803cad0a8..cfe735219bf 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -1289,24 +1289,21 @@ int xen_evtchn_bind_pirq_op(struct evtchn_bind_pirq *pirq)
 
     BQL_LOCK_GUARD();
 
-    if (s->pirq[pirq->pirq].port) {
-        return -EBUSY;
-    }
+    WITH_QEMU_LOCK_GUARD(&s->port_lock) {
+        if (s->pirq[pirq->pirq].port) {
+            return -EBUSY;
+        }
 
-    qemu_mutex_lock(&s->port_lock);
+        ret = allocate_port(s, 0, EVTCHNSTAT_pirq, pirq->pirq,
+                            &pirq->port);
+        if (ret) {
+            return ret;
+        }
 
-    ret = allocate_port(s, 0, EVTCHNSTAT_pirq, pirq->pirq,
-                        &pirq->port);
-    if (ret) {
-        qemu_mutex_unlock(&s->port_lock);
-        return ret;
+        s->pirq[pirq->pirq].port = pirq->port;
+        trace_kvm_xen_bind_pirq(pirq->pirq, pirq->port);
     }
 
-    s->pirq[pirq->pirq].port = pirq->port;
-    trace_kvm_xen_bind_pirq(pirq->pirq, pirq->port);
-
-    qemu_mutex_unlock(&s->port_lock);
-
     /*
      * Need to do the unmask outside port_lock because it may call
      * back into the MSI translate function.
-- 
2.43.0

