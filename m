Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562582;
	b=Qq8zQ6UlW5ihXxiay1NBOlCUrziCnH14cv2Lmmkw5mAjxs0DHBnO1yltkuTMfsbPmKU2
	 6TeRNEZ8Ai3Bc52Zcyl4NtSa/r+lHb01gbo2MqE1APs1PQJZJExuw2KbAKexnZlSJDA24
	 GlYlv01WoYQjAATAZobRgU6N6B/dax0bCbxITWxpuo7bJUwumJbq0whW3AtzmFoE/sXVd
	 XvzjUBYY0QSxAMTAQQSVCCt1h3JAnkD/MWaPf6Liu8QNwsiyvi6dndhQtG/Ex6ocPDkwM
	 Fx0wP9dQjsVFELV850QsxSloNNAbzufB7UEe5SbT6yZAHQ3cO1EjwjZqqcYbkK/6pOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562582;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=g0SlkPOioN/IQzWDDzbZEsZOjV4lbvBOawbX12q9VDg=;
	b=ZDhAFZedYpj8AqHYepn88NP7xpytuOcFHGuCbWvaJTokb2HIwTYmvaDdeXlsOzyvi1bV
	 74xI2/wc0Gpx4yEeuMGveduwq/cTwcksK5c++q0FX8uVty2J1bmGVbIMRx41L8sYXRTxY
	 7FWle34sJC+LMGq6N4DWVSaf54NX5zlK0PBJrhICDgWSO7ZoP1ofPQsSpNw9UmE7iAcf+
	 OOvgULtW9G/RL2iMvRqGA5UYtB6fQPQJtrv0YpS/oK/NMTKyvO0LUlIjVhtsArOGNsb89
	 j5CxNRsGO9x6tpBk4vnxHEixWVZeMt8UdufDJgEoD7NdsjSImU6/SxGX+6EKCefzPMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=qW5Fg3iB;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3988606A682
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3988606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=qW5Fg3iB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=g0SlkPOioN/IQzWDDzbZEsZOjV4lbvBOawbX12q9VDg=; b=qW5Fg3iBgTbI+mNkwnsFDI+gCN
	8c+8hHLNMHsUcyVv7MN5Id3OhNMrzNLKA+r7QeZPSkUOkGaplpB6EI933zhzzliR+e4aF1mhJgArF
	7QqIBoJZkVSX6zDGEfxaYFxtu2dy0lS2lknLtc5+JnLXRIDYyaic56X32akytgegVtTKU8CGgxhG3
	S+YwZE7u6iptNB4Unh61IUJx0Tk4KFarmhtrEmfHkEFK0/TsLkr/SdslUBb/yQpG54M2V1J4HQKHA
	xRk0paEhHBQ6ebGgSjdcOvGjiXHqfYVdIQHvTw9UJrFfXAejI0nTxd7N0XTMwoHXmg54XS9E50Y2u
	LmeNrUJQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVzqc-00000004eV3-1kSi;
	Tue, 24 Nov 2026 23:22:58 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xVzqZ-0000000062Y-2KT8;
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
Subject: [PATCH v1 12/21] hw/i386/kvm/xen_xenstore: Apply offset before truncation in xs_append_strings()
Date: Tue, 24 Nov 2026 23:22:38 +0000
Message-ID: <20261124232247.23169-13-dwmw2@infradead.org>
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

Truncating a string to the remaining payload space before applying the
requested starting offset corrupts the offset accounting, so
XS_DIRECTORY_PART returned wrong data for non-zero offsets. Skip to the
offset first, then check what fits.

Fixes: 0254c4d19df3 ("hw/xen: Add xenstore wire implementation and implementation stubs")
Reported-by: Hui Peng <benquike@gmail.com>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_xenstore.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
index ff0dfb1bff8..7aa5d97e01a 100644
--- a/hw/i386/kvm/xen_xenstore.c
+++ b/hw/i386/kvm/xen_xenstore.c
@@ -614,6 +614,21 @@ static void xs_append_strings(XenXenstoreState *s, struct xsd_sockmsg *rsp,
         size_t len = strlen(l->data) + 1; /* Including the NUL termination */
         char *str = l->data;
 
+        /*
+         * Skip to the requested offset before checking what fits, so that
+         * truncation does not corrupt the offset accounting.
+         */
+        if (start) {
+            if (start >= len) {
+                start -= len;
+                continue;
+            }
+
+            str += start;
+            len -= start;
+            start = 0;
+        }
+
         if (rsp->len + len > XENSTORE_PAYLOAD_MAX) {
             if (truncate) {
                 len = XENSTORE_PAYLOAD_MAX - rsp->len;
@@ -626,17 +641,6 @@ static void xs_append_strings(XenXenstoreState *s, struct xsd_sockmsg *rsp,
             }
         }
 
-        if (start) {
-            if (start >= len) {
-                start -= len;
-                continue;
-            }
-
-            str += start;
-            len -= start;
-            start = 0;
-        }
-
         memcpy(&rsp_data[rsp->len], str, len);
         rsp->len += len;
     }
-- 
2.43.0

