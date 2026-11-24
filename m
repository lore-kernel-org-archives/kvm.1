Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562582;
	b=DiftF/LexdQfEWiqupodaIrNrtbd/v/FWWXWF4F35emGs5+UeMGeSu5IlX/5LzA3ooHd
	 85qtrzbWpZ4HpmV7uN0jt1pJ5NhjYdMNmNRwKld3GLKBZZYy2gjIzPo2fUx9dNh82GMiz
	 QLDIMGaEAnqXKqf1mPusW3fvHETmNWHDuXsgBm9WxottLpwpjJ/Q5u7aH9qwrJjD0yIXV
	 EmxQD0DohLqqpsZPOxWeW7PJ6rab8zPOAqGyt7bW1Aariwk+m+8MOOP5E9ZhX/cBXrsHr
	 whBY/Cr/PZsVLt//q5ouKqfBMPUpVfvmJR8ywV3lmO3y0fYo2ha9xTgVfK3uVBZY8VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562582;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=gbvkt3Oepuml/pNsje0Ov8dVS+0VaVrs1jH1HkxnPHs=;
	b=gPqheMDMFxVgS/eyZvltGQav3bpbZsqqSAyXq/30knkNlglcIFwOXltpnIefTzfnC0Gp
	 1GmgvaIWhJLZVt46pdvIdZMICjXN+bvFG1dtyw/vdU9btdnNiE9+Bb9su8hySsttJrWiQ
	 fiiSJw8+tzgfI/hoEViy1uHr0sj/EYmGrTRhmvCttb2CFK50qyA6+ZE+7LezVSevwrSIP
	 LhVsP3ekaEm9iGiOnxyiHFavqdP6Xg1hEE9LToHYlpcTo9UhF+ZwWqveDThrmCJgFM8Ih
	 SE3MuRsapIs2MUB+mPR5uI3GMoCRURg6OsD2CWGPxJLYF4hZKRupLlcC28CwS+4P50w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=VPk73umi;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46A3606A689
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E46A3606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=VPk73umi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gbvkt3Oepuml/pNsje0Ov8dVS+0VaVrs1jH1HkxnPHs=; b=VPk73umiR5GJfJ0+T5UgE0U/qR
	bxw0kmsInIOWwFvbNRbHlZrBUjf9MrApQnrjgNpwnPjQOJ0HlpL3fr8+kxCfVZFvFk0iEbzUD7+vM
	0eXgnyVzz1Kzv1qM60QzxxlM7bqKcNQZ3PqLQ4j1nkzCrFUrqkqw2LHTMWBqJf8V4aRMyHYgbkQCz
	yzEIwLngfM1EKNQJMmf6YHDg4OSGXAhg7Kh7ViV3HkKDtFLJDKrjE0q7vrlYYfwHOpe9+D4ixI4mt
	wVPTi6Wa93HNEkrA3hlJI6flMHTFaKYM7OTi6AbThyUAWX0ORQAWD4HEGDqkZVtkvxTQr9TelykRY
	wtS41DXw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVzqc-00000004eV4-1kK2;
	Tue, 24 Nov 2026 23:22:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xVzqZ-0000000062c-2RFz;
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
Subject: [PATCH v1 13/21] hw/char/xen_console: Fix buffer trim when size exceeds twice the limit
Date: Tue, 24 Nov 2026 23:22:39 +0000
Message-ID: <20261124232247.23169-14-dwmw2@infradead.org>
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

In buffer_append() we handle a full buffer by discarding bytes from the
*middle*, preserving the oldest and the newest data. When the overflow
exceeded the max capacity (a limit set by the guest), the memmove()
destination was miscalculated and ended up before the start of the
buffer. In that case there is no older data worth preserving anyway;
just keep the newest max_capacity bytes.

Fixes: CVE-2026-123071
Fixes: e57dd20bb706 ("xen: add console backend driver.")
Reported-by: Giovanni Vignone <https://gitlab.com/gio24>
Reported-by: Hui Peng <benquike@gmail.com>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4191
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/char/xen_console.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index df6a708494d..849a93a8178 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -89,17 +89,25 @@ static bool buffer_append(XenConsole *con)
 
     if (buffer->max_capacity &&
         buffer->size > buffer->max_capacity) {
-        /* Discard the middle of the data. */
-
+        /*
+         * Discard the middle of the data: keep the head of the buffer
+         * up to where the overflowing data will be moved down to end
+         * at max_capacity, and the newest 'keep' bytes. If the buffer
+         * has grown to more than twice max_capacity (the frontend may
+         * set an arbitrarily small 'limit'), there is no head to keep
+         * and the newest max_capacity bytes alone remain.
+         */
         size_t over = buffer->size - buffer->max_capacity;
-        uint8_t *maxpos = buffer->data + buffer->max_capacity;
+        size_t keep = MIN(over, buffer->max_capacity);
 
-        memmove(maxpos - over, maxpos, over);
+        memmove(buffer->data + buffer->max_capacity - keep,
+                buffer->data + buffer->size - keep, keep);
         buffer->data = g_realloc(buffer->data, buffer->max_capacity);
         buffer->size = buffer->capacity = buffer->max_capacity;
 
-        if (buffer->consumed > buffer->max_capacity - over)
-            buffer->consumed = buffer->max_capacity - over;
+        if (buffer->consumed > buffer->max_capacity - keep) {
+            buffer->consumed = buffer->max_capacity - keep;
+        }
     }
     return true;
 }
-- 
2.43.0

