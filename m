Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562572;
	b=rCJF9oo4UTdLCXFtdLvGlP/jkLJt9hPbQ2T9z88wHYIR7Uja0vzIVRcEn4JHr6AGbzDB
	 HJezWQW7EqqyXGkPl3QENxvX4rwAlI0NzT7Us3byIZRTAykggVvzoD1vxj961CVKIjglz
	 WYyWofHMSZxc/HU6jeVLwZdR0Vc8RwqVjBXyGqHOsIaPaGHDV/yAF4vxZvwnLek0QYWkA
	 xoIcDc7Nfr7zsYr4OVLFpCxgVdYuPGAnNJZ2HPXgL20lEmvXguex5rnBQbJSnldatDeKM
	 NKadGU6UHRhfr2QMjn4Ky/X+7sjJB8C2UWmdAbsZq7XdLQC8qv3XQeEc6AeSoGyQtkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562572;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=7Q8vcK6pp8jnVnCjyRjbmOniJ69JnrySfnqcCaHpuRg=;
	b=1SEg4qY98hJtPHB2N3pnjlrcNQhWZpsPa4HmD6eKh8pHqCwjCw4FT9OksxDSG8ax66Q2
	 MXcSV4R9nQDOfgpuA2snA5kn55JkuPyFjFIr9LM+Jz54PcNlPolr4+r+mk7H/qXmnvMeS
	 DRSmlCSOKCUcDHVECLqj3qWbctNFc//31RQ1tg2VM9jiRBg14k/80nB/4oaGBZ3kokI9a
	 ost4w5iJnbrGsgRzSY+pESH4G41OL2rSHMsNTdKfpUNi6/msxlZimTlCbvteZMvHJYskF
	 0K65cfaFE62yFfezOxhxbv23gys0mcNho+fZ1ALniAt0Ybnf+ftvtAPmQmbKZpuGt9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ByYwvkFg;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98A1606A32C
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E98A1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ByYwvkFg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7Q8vcK6pp8jnVnCjyRjbmOniJ69JnrySfnqcCaHpuRg=; b=ByYwvkFgRf+NraRIKwg2fC4EDw
	CmOLguurIyG6OgQEEKm1F6mB3yG70Z8RMXbB5UsF9zwGU+4Di0mNG2JjIuOoD7RMpDzEKKpgAvxRn
	1z/ITJftIVEb3OKUXxcjYpBdrBlzT4kpDiXsbHwf+2LcESWmbnUMMDN2czKFZnVX9/zkVLZ6rZ6gM
	QWG0EmDqE6X3Fu1wgM5JXuaM3KUgJlEyhauqf0kiFxoqQzGaGfo/2htOB02X7L4eXi0BYPukwEuKK
	Hbb8xYQ3TxJ2jXbnctaD8vkMILe43Adp+suaI2YGl+aGUOxJQJb9QRjD371JRAyDGKpqsfs5UaWIL
	pkueEdZA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVzqZ-0000000Gdhz-45hv;
	Tue, 24 Nov 2026 23:22:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xVzqZ-0000000062U-2B62;
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
Subject: [PATCH v1 11/21] hw/i386/kvm/xen: Don't leak gnttab handle on reset
Date: Tue, 24 Nov 2026 23:22:37 +0000
Message-ID: <20261124232247.23169-12-dwmw2@infradead.org>
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

xen_xenstore_reset() and xen_primary_console_reset() open a new gnttab
handle without closing the previous one, leaking it and its mappings on
each guest soft reset. Close the old handle first; closing unmaps any
remaining refs.

Fixes: d05864d23b1a ("hw/xen: Map guest XENSTORE_PFN grant in emulated Xenstore")
Fixes: a72ccc7fc449 ("hw/xen: add support for Xen primary console in emulated mode")
Reported-by: Hui Peng <benquike@gmail.com>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_primary_console.c | 3 +++
 hw/i386/kvm/xen_xenstore.c        | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/hw/i386/kvm/xen_primary_console.c b/hw/i386/kvm/xen_primary_console.c
index bf61f6235be..0a2a6de3ecb 100644
--- a/hw/i386/kvm/xen_primary_console.c
+++ b/hw/i386/kvm/xen_primary_console.c
@@ -184,6 +184,9 @@ int xen_primary_console_reset(void)
 
     trace_xen_primary_console_reset(s->guest_port);
 
+    if (s->gt) {
+        qemu_xen_gnttab_close(s->gt);
+    }
     s->gt = qemu_xen_gnttab_open();
     uint32_t xs_gntref = GNTTAB_RESERVED_CONSOLE;
     s->granted_xs = qemu_xen_gnttab_map_refs(s->gt, 1, xen_domid, &xs_gntref,
diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
index 7d6d6d5cbb7..ff0dfb1bff8 100644
--- a/hw/i386/kvm/xen_xenstore.c
+++ b/hw/i386/kvm/xen_xenstore.c
@@ -1490,6 +1490,9 @@ int xen_xenstore_reset(void)
      * first place. Map the grant anyway, mostly for cosmetic purposes so
      * it *looks* like it's in use in the guest-visible grant table.
      */
+    if (s->gt) {
+        qemu_xen_gnttab_close(s->gt);
+    }
     s->gt = qemu_xen_gnttab_open();
     uint32_t xs_gntref = GNTTAB_RESERVED_XENSTORE;
     s->granted_xs = qemu_xen_gnttab_map_refs(s->gt, 1, xen_domid, &xs_gntref,
-- 
2.43.0

