Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562572;
	b=2PV0K6O+cnw2+XTzpZYOHXPg42Uyw7thIJZIoOR88lZrWzgFdH+AZa1IOda60tH3k96z
	 /gUPb1QqAatNiVtFTczRcIJqFNK2c1I0Ad37iLOKFJw+6WaStpYlCgVPA004bRjoP1mH5
	 ElNdfy/AUEpRAWYY0LZioCv9e0Dw0eUqSUJLuFY/qELOv85PGHXzNjZNPwJzbNoyrWQ19
	 9IDcawuaOKGrVgnADacbsaJi1ANu+8Apat/WDbzH63L5tzwpBYElNymRvTsaOJRVfUj58
	 DbEhJpiNVo+6GdaE312bH39WZcZchHDsVTfNWWuk0D1C0IqDtjrJZeMNMje3q409Fpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562572;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=omSfQRir3NOjvaxuaNmQVmaf9UjouyCVezkBBc8wqZc=;
	b=4bYESb7tzJJV8St98igvLTErqcrTWpbdGG4Gg4LI+Jk3SlI3Ob1uwHMYeEUyPh8k/L43
	 CPGl1D8OynD07NqVcYhpmGO4gyVStoG9gLitlkpJBr7RsjYLA30YZap1G9pWtY8fJjE9F
	 vBp1sjkKmYtqUmmvEr/TtGpMYlokncmvuyngcBHiO6ah6z29V/fKrWBj0vehI8rWD6X03
	 IwXEFA0EkeyLvf9uxxH+qfEtcGWqRruaaUCex4P4azs3L0kxQjlaS1rLTXjy/sjMK+FAo
	 RKajQ6FdQoL3nPaoLVE7yj71KAFgri49xuaGAQaPx/OMQhTsfcnNXtbo5OQIWaGa2nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=DDIp988r;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9738606A327
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9738606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=DDIp988r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=omSfQRir3NOjvaxuaNmQVmaf9UjouyCVezkBBc8wqZc=; b=DDIp988rHTV7Y/YJBbUl8MtY+f
	OSqNgMp//dwiaqlE3WGUaJXxYnmYB/NT/ba1puqnp8cX9ie0PYqlb9T+KM0U6hx5GGut/gkATWMH9
	yP3Amt8TaJ3JOtwSmKg8N2zr/679L3/Rrv9kUFzfXVpbQXhGOdbkFebtVmzeorfbDYfOhvMCUYFUh
	fcFMf8pLi9VAcogUdNbm4F1RVTCi7dY7TYoqSa11A2fXVoxW/ffIOIq+B+qD13h04kIj+5Et+uxcE
	dZE11z2cqqphjDPQmPI1zJEE03phi+Dhnq5nY2/my1iWWGPTEcTWfK64JlzqroPoJHw16J1abaUHH
	RR18poDw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVzqZ-0000000Gdhv-3Fud;
	Tue, 24 Nov 2026 23:22:48 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xVzqZ-0000000061z-1Qql;
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
Subject: [PATCH v1 04/21] hw/xen: Publish backend features before setting state to InitWait
Date: Tue, 24 Nov 2026 23:22:30 +0000
Message-ID: <20261124232247.23169-5-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The XenbusStateInitWait transition tells the frontend that the
backend's parameters are readable, but xen_device_realize() set it
before calling the implementation's realize method — which is what
writes the feature nodes ('max-ring-page-order' et al. for xen-block,
'feature-rx-copy' for xen-net).

Linux blkfront reads 'max-ring-page-order' with xenbus_read_unsigned():
no wait, no retry, default 0. Lose the race and it silently negotiates
a single-page ring — 32 request slots instead of 256. A device
hot-plugged into a running guest loses essentially every time; at boot
the frontend doesn't come looking until long after realize finished.
Netfront reads its feature nodes the same way.

Commit 240cc11369fc ("hw/xen: Avoid crash when backend watch fires too
early") introduced this by moving the realize call after the block of
code which both populates the initial xenstore nodes *and* sets
InitWait. The crash it fixed was real — xen-block's realize processes
watch events via blkconf_geometry()'s aio_poll(), and the handlers fell
over when the nodes didn't yet exist — but only the node population
needed to come first.

So keep the node population and the 'online' write before realize, and
move only the InitWait transition after it. A watch event during
realize now finds the frontend in Initialising and no backend 'state'
node, which the handlers tolerate; none of the three realize
implementations reads the backend state. Verified against the original
2023 crash reproducer as well as the ring-order negotiation.

Fixes: 240cc11369fc ("hw/xen: Avoid crash when backend watch fires too early")
Reported-by: Mark Syms <mark.syms@citrix.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/xen/xen-bus.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 17bbbe2ea71..b75ce7f0957 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -1082,7 +1082,6 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
     xen_device_backend_printf(xendev, "hotplug-status", "connected");
 
     xen_device_backend_set_online(xendev, true);
-    xen_device_backend_set_state(xendev, XenbusStateInitWait);
 
     if (!xen_device_frontend_exists(xendev)) {
         xen_device_frontend_printf(xendev, "backend", "%s",
@@ -1093,6 +1092,19 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
         xen_device_frontend_set_state(xendev, XenbusStateInitialising, true);
     }
 
+    /*
+     * The implementation's realize method may write feature nodes to
+     * the backend area (e.g. 'max-ring-page-order' for xen-block,
+     * 'feature-rx-copy' for xen-net). It must be called after the
+     * backend and frontend areas are populated, because it can invoke
+     * aio_poll() (e.g. through blkconf_geometry()) and thus process
+     * watch events which need to read the 'state' nodes. But it must
+     * be called *before* the backend state is set to InitWait below,
+     * because InitWait is the frontend's cue that the backend's
+     * feature nodes can be read; a frontend which reads them promptly
+     * (as Linux blkfront and netfront do, without waiting or retrying)
+     * must not find them missing.
+     */
     if (xendev_class->realize) {
         xendev_class->realize(xendev, errp);
         if (*errp) {
@@ -1100,6 +1112,8 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    xen_device_backend_set_state(xendev, XenbusStateInitWait);
+
     xendev->exit.notify = xen_device_exit;
     qemu_add_exit_notifier(&xendev->exit);
     return;
-- 
2.43.0

