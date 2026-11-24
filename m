Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562572;
	b=z5dmHVDFM1/m9DXYIXTrdACavzwZbJVSXYaV87UwCyqmANaiElzps6UurrwMCUNYCUDV
	 XXqGtPes8YZqRlgmZCwJf0kMbKpRqV/j85rzZUD1cGlwdaC0WYBjeV0EK427u5AzdssZD
	 assTqPZ9BAL5hHyfXIKiZdSDHRM7OTZjIA4tbau/jYokUhDQGQL9PbYhdSxS2Mgzm5Wvn
	 vGnu1X/91jkCaZDLJtXCN0VYp+F/7w+wJQNyS7l25UFTDd6mPdgB64Mfmhz9N2bmgDHlG
	 wxOZSsBYdP34ctkYH6U0pMJCBbC+yATZtLfk/HOER/EwehXPtLUnsLMD1wen/lKQfgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562572;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=mShxXaZv6TY0Zli6pFAQOFKuPFGFrSk9kLHIUrN7Ut8=;
	b=wnB6fWhWh6o1BbR7pLZZX7rCb9fDDFmgNW6zIj3z6igGr3PNh8TLryIBxr+ApEQtk3K8
	 8Z7ADLNn6Ex4eUbb7++VBWFsbMe/L18ek0ds2Sm6+/CUFRzuFo9DzZpin0hAxeGR6GizS
	 wmk3Urz1tyAIG2E1HnjhyuSZQebewV6HhRN/774TNA5wrATNnuPY917O8/QO5eX/XA3zL
	 F677RVnJgaVXns6+0bGgDyq8Vj8j3QS1NHMhh0lKjw+XUGSa70bPTv675wX2MuQZ3giia
	 OAxkDPwLGOgJqdFrTrRJxrtm3mRTDVTcr7pHkO4XwlFDsbpBZ0V0TXZVW1E/EJA8nqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=uMvqhYcU;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E964E606A321
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E964E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=uMvqhYcU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mShxXaZv6TY0Zli6pFAQOFKuPFGFrSk9kLHIUrN7Ut8=; b=uMvqhYcUlLku2c+q0NhmFreiZL
	TXqO78fEulJkymZMHBv8tmwLdtaQ3Rcskf8g6WHxqeBONoGsdnS5w0MtUe02gohddf/vzkGUQhnB8
	V6URimHadQK9fN5WMBerum0CbF5wwZmBYuUbej5eCu5OJR7XYac2D+134ru0r65BHmnvunVLRcv5s
	GWYqKwmlyZYTV3RDkXA4cguPMfbkWZ8PsuPV8O5TMBsd2GABaKtJZA5li7GdyfqX6d3sp3P2FjYoV
	QbOU9l/pHVf2+6Lt9m0GCTHVjj6O7eLgfmvTg+X4UO/izy/cvY2T331EUUSh5PyOMXnJWQSQ0beph
	xPcPKP5g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVzqa-0000000Gdi2-12sA;
	Tue, 24 Nov 2026 23:22:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xVzqZ-0000000062s-2sK5;
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
Subject: [PATCH v1 17/21] hw/9pfs/xen-9p-backend: Close event channel handle on disconnect
Date: Tue, 24 Nov 2026 23:22:43 +0000
Message-ID: <20261124232247.23169-18-dwmw2@infradead.org>
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

Disconnect only unbound the port, then dropped the pointer, leaking the
handle and its file descriptor on every disconnect/reconnect cycle.
Close the handle; closing also unbinds.

Fixes: b37eeb020123 ("xen/9pfs: introduce Xen 9pfs backend")
Reported-by: Hui Peng <benquike@gmail.com>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4523
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/9pfs/xen-9p-backend.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 6e26a445a09..612f19c45c8 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -392,8 +392,7 @@ static void xen_9pfs_disconnect(struct XenLegacyDevice *xendev)
         if (xen_9pdev->rings[i].evtchndev != NULL) {
             qemu_set_fd_handler(qemu_xen_evtchn_fd(xen_9pdev->rings[i].evtchndev),
                                 NULL, NULL, NULL);
-            qemu_xen_evtchn_unbind(xen_9pdev->rings[i].evtchndev,
-                                   xen_9pdev->rings[i].local_port);
+            qemu_xen_evtchn_close(xen_9pdev->rings[i].evtchndev);
             xen_9pdev->rings[i].evtchndev = NULL;
         }
         if (xen_9pdev->rings[i].data != NULL) {
-- 
2.43.0

