Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562572;
	b=CQUxUFMzu0Yz/+ed6YLWO62l+vyxj5qYIAwxrqgeox45k/fHS/9Pa/d3HvB1keDQ4j26
	 hQK7eYzIsoGDfZnycKV1vd7NnB5Iaxt1LPro9EOwb5VwP/oJA/If+dyVwjGSC7eS8mUsY
	 pFrv7XZHIjpbt+T1oKCWar1sJ3I1EfK54b6a2qS4nb/nZ+2/GrwEVraSyW9UFrfyi/rLy
	 a+n5mNje9HKC0MS1ySo0t+HTHu3OvIe/TKsROwl2g3A1F8WqNow/XWoCvhZvNHKhlDyUP
	 tt3vhhLez/DAS29Evp0AHIMwrNJV7c6xyMPPXtes/EWr9AxQ+2qloyZKmhc/WusMBnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562572;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=fkwzsM5yfLakW/iXmvswEvcJGfL3/kGIv/KQzG4phgQ=;
	b=XxFKAN3D/BzQJUMUE6X7s0AwZZDW2nyXuVmpP8jDe3CgY7N/1KaeRrxVRU16h7M8idlJ
	 WhQNDURsJMbouEAetEX+h3xA9BqpWceAqiQj4ubC2dMONMVHQBQE0D+qv72E8LZGRQ15T
	 8aElQlOByJ2rGickNooAg4KdMTGeCSj30yBB68FDkK7eADQ5RBeu31DKwRqnHyZjS3QtF
	 ce8PudsX71onogfkA3wjqSvMSZRYrh8MdKtxDGVzwIYNVXUb2f/Orcxp5n86IeKBZuNql
	 DAwdv1brNqnwp3ctg1Tu71BWBmw1uk24Z6a6T4gPhFFOMOl7hV3LVILZgOVsuV+rg9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=TneVavzo;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9770606A329
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9770606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=TneVavzo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fkwzsM5yfLakW/iXmvswEvcJGfL3/kGIv/KQzG4phgQ=; b=TneVavzootORhVDT/3U9C9AZmk
	cv8rA0ENLPJ/vNuh8K/CdF8cqSWoI0niqz0MMcY4sXMef80sFwj0BHCzcX657lmFlwP0otGngA7Vl
	QLBDd/YEXZpU9XTxI3OJZ+3xmCWlGjhI5QLq77ea9gydurBgLiNgtIH+0VPx16OKYnu2nLBqvGCLy
	VNySvX8yZesdoaRjXRqTPTD/ZhHWTgfbRl4EFDFQVMjHPQ4VVetFqajaIGxONLXmqMuYpq52xkYGO
	lk1bV0yRtX5bRDeYjpGCORlnmC3pSV7HfouWL/Y+ZzE34zEPDW67ZQTyp0ndYmkWaJSFKtJOtKnJV
	6O1xrWFA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVzqZ-0000000Gdhy-3iq1;
	Tue, 24 Nov 2026 23:22:48 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xVzqZ-0000000062I-1rPA;
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
Subject: [PATCH v1 08/21] hw/i386/kvm/xen_evtchn: Fix off-by-one in do_remove_pci_vector()
Date: Tue, 24 Nov 2026 23:22:34 +0000
Message-ID: <20261124232247.23169-9-dwmw2@infradead.org>
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

The empty-word optimisation advanced pirq by 64 on top of the loop
increment, so the first PIRQ of the following word was never examined
and could retain a stale device binding after the device was removed.

Fixes: 6096cf7877bc ("hw/xen: Support MSI mapping to PIRQ")
Reported-by: Hui Peng <benquike@gmail.com>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_evtchn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 3aff01b5d6c..d0807f5fece 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -1701,7 +1701,7 @@ static void do_remove_pci_vector(XenEvtchnState *s, PCIDevice *dev, int vector,
          * and cache lines).
          */
         if (!(pirq & 63) && !(pirq_inuse_word(s, pirq))) {
-            pirq += 64;
+            pirq += 63;
             continue;
         }
         if (except_pirq && pirq == except_pirq) {
-- 
2.43.0

