Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562572;
	b=NpEdHyWyZ2nwSm3RhbduVHVX7VpocARxqehz/Q0SJQlH7ljrlTZ/gIcr5e2scpT/trTI
	 niU5tYNc61RBMvi1s8qu9BZHd/pJxW7e5no2jL0AhZtyTS5cFL3mrujQN7GC/kmFFjXeb
	 QqR7rYdzWFG54LlrKs9DNmWCph1s3Dr5jucaAJsN2bctXOEvWYm4LkzzXGwd4ix0jjOkg
	 RLlqCCLgCnxvBQTHtqJZHpCPt4cAxp3YR1YMLJl4Cm8WPpfVcz7LNFlMPvnuQN/1uOZO8
	 jJ1OhxEotcnq108buB9RbDZfPyJAKzwt3WsPPM9PWuxSh8ROGHS8GTPen5Knc73aNDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562572;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=5WG4S0K3NHI6X23ICM3IYdv9KdvM8ykx9fz0jk2Hl2Y=;
	b=lowvZ55dbbPrtGWX8WCc9P5cv59e2Fg3jPyFCR3psxNiIQP7Fjbqd6SfUS0bnWzA9TkC
	 JNS9XS3ph1l7ETQ0rHo6Ewk9Cy3QPEjfucEQLFmjRiYuKDGFC+AMk4LfAfMzOnT3Rb6lf
	 ytX2z31qrjUM6MNOmdNzbyE1AiNcGFXN1HsMT0VJ8FvCeHLUqzjIlNsejdmw12M9hdhYc
	 05ITa6WmgoyaDgM9L2ao3Dja7qFPEkWSkJLi4DnwVbiGEckdOgRRFj/cEIZ1U/vFnb1lO
	 nk7sKYOyE6DpfHLfnoNfTqf+JG2vQ2Kk8b9eKiMIH/4Ch7S7oij9Rv5AWwzf28CgDPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b="oKVgq/v7";
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E970F606A326
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E970F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=oKVgq/v7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5WG4S0K3NHI6X23ICM3IYdv9KdvM8ykx9fz0jk2Hl2Y=; b=oKVgq/v7xRwthHGs2qU9jbE8kY
	z2+k7lmSD1GGxaaJxhDRIhY6TqcVs5CWX/9En7iFBfdVCUfMh1oIC2iHTJAdnUm4D9lrey9pg2e7A
	4S8F+vwmzOF8Kmni8Iu9TJssNPonsfGn7qKC4NXJvMGq7n9QFMCPKfiJjY7WMxXmF2mmAcIyKBula
	5Jfu2ew+RqqvwrHV1KG/2+wTflXaPotx6zHnGt/HFz9sTR12U4cYBYDTK9B5jro6VDPUVS7wUO7gG
	Vm5hLMeZr23U85I3j5l9uBmrlx8/ATDvDB2jAG43sEysC7GM1ni5iw0RYkl28z5G6CuPTA+0Fdbgv
	nFC4yTqA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVzqa-0000000Gdi0-0OiI;
	Tue, 24 Nov 2026 23:22:48 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xVzqZ-0000000062o-2meR;
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
Subject: [PATCH v1 16/21] hw/9pfs/xen-9p-backend: Validate frontend-supplied connect parameters
Date: Tue, 24 Nov 2026 23:22:42 +0000
Message-ID: <20261124232247.23169-17-dwmw2@infradead.org>
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

The ring order is read from the guest-shared interface page into a
signed int, so a large value became negative and bypassed the
MAX_RING_ORDER check, leading to an undefined shift. Keep it unsigned.
Treat any negative return from the event channel bind as failure, not
just -1, and fail the connect if the frontend provides no 'tag' key
rather than passing NULL into the fsdev layer.

Fixes: b37eeb020123 ("xen/9pfs: introduce Xen 9pfs backend")
Reported-by: Hui Peng <benquike@gmail.com>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4523
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/9pfs/xen-9p-backend.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 430de23fadb..6e26a445a09 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -453,7 +453,7 @@ static int xen_9pfs_connect(struct XenLegacyDevice *xendev)
     xen_9pdev->rings = g_new0(Xen9pfsRing, xen_9pdev->num_rings);
     for (i = 0; i < xen_9pdev->num_rings; i++) {
         char *str;
-        int ring_order;
+        uint32_t ring_order;
 
         xen_9pdev->rings[i].priv = xen_9pdev;
         xen_9pdev->rings[i].evtchn = -1;
@@ -515,7 +515,7 @@ static int xen_9pfs_connect(struct XenLegacyDevice *xendev)
                                             (xen_9pdev->rings[i].evtchndev,
                                              xendev->dom,
                                              xen_9pdev->rings[i].evtchn);
-        if (xen_9pdev->rings[i].local_port == -1) {
+        if (xen_9pdev->rings[i].local_port < 0) {
             xen_pv_printf(xendev, 0,
                           "xenevtchn_bind_interdomain failed port=%d\n",
                           xen_9pdev->rings[i].evtchn);
@@ -531,6 +531,9 @@ static int xen_9pfs_connect(struct XenLegacyDevice *xendev)
     xen_9pdev->id = s->fsconf.fsdev_id =
         g_strdup_printf("xen9p%d", xendev->dev);
     xen_9pdev->tag = s->fsconf.tag = xenstore_read_fe_str(xendev, "tag");
+    if (!xen_9pdev->tag) {
+        goto out;
+    }
     fsdev = qemu_opts_create(qemu_find_opts("fsdev"),
             s->fsconf.tag,
             1, NULL);
-- 
2.43.0

