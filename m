Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562572;
	b=bJwH94TZkpudX0/I9O1DADyECKifOAYCrDEJjIdnADgV5mJgL8lL4UY7dveEn+VQEHdq
	 D87b8EkVxjiT83ibyWv4RlPw7syuv1TN1+GRN60jfSlZmvBFvPZ8RR/ADXDZxyAKcSGSF
	 kR4GL2kOOLkFE5b1XE3nxNnwirKgGbg9qPlvQ9e1e6Dehp7ZIlPC9CNfa34lT/Qjggkde
	 bO1gCBNk58u48/YJ8EeOWgH+T0lAmn/AeH8s2TOgWaiMV17kxwF3xSYCtmzD+BBvh+2B5
	 T29n7fNz+OtKCvHMlev7pieMVv2phOcDFqyQxjomObhf05mFJOy4XD3v7bvePyK+6vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562572;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=hdyfm7GpJ9FLtKxanRFDOcqZILwEpUm9W0rWeuqixlE=;
	b=z2/oVa9ItJ2BZ0cdNi15zS6cXAjMKX15ynNXJ0iohKqJ5ZXnlbgxvHa7rjuco8QYX/0I
	 d5nirzJdl1rrql0H7evSprmXc5dc4ZiQ/lAUxyfDIu1fGZOPkYtUUOaGEBh1DxvD0e2Pm
	 ME8F9dnwFtSrsFYlfH72N0KkuWmX7sKxGMJrf1vc8h/IceZ55adOsQClEMFte1hxLs564
	 cFPgR1QvUklkp0/XJuLK8DHMq9jR6PcwPAjeDqn8ibV6XHk4TJiH8vHPyvRcQW8M+kfdC
	 MDq3LoVl6YtK8epDeh5E/9t621uP5c4vDUbBpsVucTljxXOC3hkkpNoRjs8dix29C3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=F0Nol9H4;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95A2606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E95A2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=F0Nol9H4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hdyfm7GpJ9FLtKxanRFDOcqZILwEpUm9W0rWeuqixlE=; b=F0Nol9H4CEqNAfhv45Miss1ani
	XYN56Xrq1FtjpWaI+0gypS+mw7nIwd42pCP5rcyfVh4xuGfpKPgSLOH2uZsFlXKv1tQ/F+oxOI5CK
	Kj5H0gbwqBHB7QSo1N566xQmUml0PTsrsM1rU6jCnMLrmNln1ejFCepPXGFtDoxg3iLhD/jLBqxvg
	vYhuHo5DB734c1HXV6N7p/BKnfe2M65z8yq4F0Od8T3n/kWa37KO5yWGtAXXDEPhkOjAXLFyyqrhn
	wAbc+SNxGqvJPLVYcD7ySaztLDqj7iw3PM1gqCwYQik1oHclEgkEjdcaYiZ+in+mfTTVw7w/Hnwh+
	vYlx3IGw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVzqa-0000000Gdi3-0ZNx;
	Tue, 24 Nov 2026 23:22:48 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xVzqZ-0000000062w-2xwb;
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
Subject: [PATCH v1 18/21] hw/net/xen_nic: Bound the TX and RX rings' producer index
Date: Tue, 24 Nov 2026 23:22:44 +0000
Message-ID: <20261124232247.23169-19-dwmw2@infradead.org>
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

net_tx_packets() consumed requests until req_cons caught up with the
raw req_prod from the shared ring. A bogus req_prod made the loop
process up to 2^32 stale slots while holding the BQL. Check
RING_REQUEST_PROD_OVERFLOW on both rings, as xen-block already does.

Fixes: e613b064a88a ("xen: add net backend driver.")
Reported-by: Hui Peng <benquike@gmail.com>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4515
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/net/xen_nic.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index e615303da6a..4de2464376f 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -138,6 +138,12 @@ static bool net_tx_packets(struct XenNetDev *netdev)
         rp = netdev->tx_ring.sring->req_prod;
         xen_rmb(); /* Ensure we see queued requests up to 'rp'. */
 
+        if (RING_REQUEST_PROD_OVERFLOW(&netdev->tx_ring, rp)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "vif%u: bad req_prod %u\n",
+                          netdev->dev, rp);
+            break;
+        }
+
         while ((rc != rp)) {
             if (RING_REQUEST_CONS_OVERFLOW(&netdev->tx_ring, rc)) {
                 break;
@@ -268,7 +274,8 @@ static ssize_t net_rx_packet(NetClientState *nc, const uint8_t *buf, size_t size
     rp = netdev->rx_ring.sring->req_prod;
     xen_rmb(); /* Ensure we see queued requests up to 'rp'. */
 
-    if (rc == rp || RING_REQUEST_CONS_OVERFLOW(&netdev->rx_ring, rc)) {
+    if (rc == rp || RING_REQUEST_PROD_OVERFLOW(&netdev->rx_ring, rp) ||
+        RING_REQUEST_CONS_OVERFLOW(&netdev->rx_ring, rc)) {
         return 0;
     }
     if (size > XEN_PAGE_SIZE - NET_IP_ALIGN) {
-- 
2.43.0

