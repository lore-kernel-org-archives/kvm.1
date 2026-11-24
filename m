Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562582;
	b=2YAKDFzhV8lZ/E1s6i/UKsUFHtZxjs0Yyz0R8Lm/Rs3bjCsoiyb+P1Ru/hQHjKLjoue5
	 ORY7CJ/VB9JavYPQCM8UaPUptedwgkZ0vAiBnI6eMQgf/vOjqlZ1hh2MG1OOZhnZ0wR8C
	 Dj+dHU0ea1ZbOxE1nBdBIc2l1CrzHaI0g3mfvdVzcyIVgUyX+wxgUG8tT911PrXSBOOJZ
	 /5vCGWL1pbxJOatabgy5XJInA2wQzs+dkBB51TEb51lxDQTMPSG+Ili3ukl1LTbCu58Xm
	 SyXEGZHmtdB5uDDrybT/ECEu00fKHSJ3+tZ4ioVi0qzCoeBWrXhstRS8c2W3pzj4wKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562582;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=ik79pPafOlsmEIxdCKJuF0t0ouBbOJcNq4lchRAKKII=;
	b=S3To7M/6GVc3rHw6WV4BFnVPlenrFdpXEyLydtw0XIYjvalizhBQgjBOynvaeBj7FhfH
	 9w8CjrIBHI9U2M4GJMkzHapYXGqT+MwLrsL7FYqizNN11G2OCW4x1r1CVD0TqeMiu5cjb
	 Zy57ego0sxleJ1DlS5Qcwjc1THNNRRtFq8XDzomk3rs/h5aZIzx1g0FlWRcsteI80CNQ+
	 UbAHgktLg8kkhvd2VD3bgKyJWzmnaCB7NO6BGaWimMwiqEWjFlH3sBTXdbuRZRJC6F1Hq
	 kfNNxRS9tR48TDwWmCUCMve+laJ+UIVLZ+TU9mgcNXmt+pKZQSGgsNzqpxBZ5A6gvtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=QhjGViLk;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51C3606A692
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E51C3606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=QhjGViLk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ik79pPafOlsmEIxdCKJuF0t0ouBbOJcNq4lchRAKKII=; b=QhjGViLkiYG22fvjKr9HGpi46Z
	JriGCgqO0yPR36mLxKyfJnbU+UroM5TUpgI4NwZIjTz+VlEldiO0Y3ZM1fNwoqIy01kM8Lakkn6OT
	sJX2Eku6voMijBMigxGnCNR8BJO2ILMZETmcc14VVu45zzBdlztWa/75YwiJ+Ye2MmK3I2d3FKSS5
	TGfGpIhE0kisqLbFkofQTD5GPjRinpISLN8vGRNg6kC4reGg+PX7YwnKuarFmPb7EGG0Pm3+aVyQF
	MScrmGwl873ca7Xn+7Ak8sG0MswIRGto6nqAVOtYjb3LuENHZhwCHxo9x40srLEJMclod4NYjDvlY
	QyR4KRsg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVzqc-00000004eUw-1qfw;
	Tue, 24 Nov 2026 23:22:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xVzqZ-0000000061q-10xa;
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
Subject: [PATCH v1 01/21] hw/xen: Fix partial request header handling in emulated XenStore
Date: Tue, 24 Nov 2026 23:22:27 +0000
Message-ID: <20261124232247.23169-2-dwmw2@infradead.org>
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

When a XenStore request header is only partially received, QEMU copies
XENSTORE_HEADER_SIZE bytes instead of only the remaining header bytes.

Fix the length calculation to copy only the missing part of the header.

Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3644
Fixes: f3341e7b915 ("hw/xen: Add basic ring handling to xenstore")
Fixes: CVE-2026-61403
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_xenstore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
index 0dc0edf3bfd..7d6d6d5cbb7 100644
--- a/hw/i386/kvm/xen_xenstore.c
+++ b/hw/i386/kvm/xen_xenstore.c
@@ -1218,7 +1218,7 @@ static unsigned int get_req(XenXenstoreState *s)
 
     if (s->req_offset < XENSTORE_HEADER_SIZE) {
         void *ptr = s->req_data + s->req_offset;
-        unsigned int len = XENSTORE_HEADER_SIZE;
+        unsigned int len = XENSTORE_HEADER_SIZE - s->req_offset;
         unsigned int copylen = copy_from_ring(s, ptr, len);
 
         copied += copylen;
-- 
2.43.0

