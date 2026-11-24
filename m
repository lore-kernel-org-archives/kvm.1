Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562582;
	b=seA+2mGT4Cfe1/ofsS6LgU5rs7C1jO2lwS48FCAeLmHEQMxZPd7ZWixIJKdRsI7NIN6M
	 5vvdySo+lrb2ruvmHRcBGLbUnyRcTsR0N4/OnwQbEy+cXpQwJ9m98UkkpDjwshFs7+TwG
	 Lvvn+uuBjMMtnDaMFdL/DamKxn7rUL522MSrwwJw6XTQQTXvAYlQ+71oahkKq4swzc1mX
	 u1Tlnt0P84bompUQyY3HrpKwmxwheb9J5uWMPZZ5tLhQ2H4RJoOKTCtUxVMq2qkjhVlGG
	 n8J7f9KQZrEUhC4wr/K6GVltuRrCDzXcKRq92v9Q4FvdYQm2ktO3Cgw8hTUPBt5DZow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562582;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=eWmMCd/JSNzWTHLZ2DwBQEQk4USo+wekbnZqkbZHiB8=;
	b=xIfYA4N6TBnLG+75Lq+BMuhrMeeZRA/tpf0hljnGpg4GYzzdNq7rwL49061nUhxZ9vFx
	 OXp+O1COS6ct4ELonrtVq+5lxmcdjQtrrYyzABTjUTDmrelpv7xL9O7uVogi3sC9oI+l/
	 CviVMMhkZutlYQdLGxtTzS1i947U0seA+Cye2M1+tnb+WJ1D+Y8SknR8ghMVatUxc287M
	 EGLEwCjat5nAuFGTKhFJZwA6Iaq6ZD6/Zpdk4BVtkofHlcyiTKdb60UxHjTqZrglaVYAr
	 wF8ZYdi4vEyXauAaIexBUpuSlTLtNxJN5j0MuO/W6AfkDoEo7ejeHdQ32M+7HAXKYew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Dc8e1wMq;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E702A606A6A0
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E702A606A6A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Dc8e1wMq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=eWmMCd/JSNzWTHLZ2DwBQEQk4USo+wekbnZqkbZHiB8=; b=Dc8e1wMq+eood4AKEV1xw6kGal
	oPMghXtG3cQqdiqp74emYFfBSTIYlBUYio2t7Nko1Sy0JUnu/Zzn1v5uzRr7G5WWbLd6VUd9E1jCK
	hSkJP3i/00ZA0AoNBHkcuhsLL/JoTnDjwThDCURXb88cpCDY7nvPDgy22KL6yA/YdZVV91icp/arU
	9j9RI7AGzTeRp/IbRHWtcqtCLkb0wUjtwSv70w9jXzL/+4tyi+UP2h3W13Ljybon/JtsfDOWG90VM
	8VpwSTQiDGcRz5Di2vtlCGuLDZX3reF4sR/D9SizddoPifIJTdO29fEqspEo0SJ3h1w2BnQ60dYkN
	tFEVBbeg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVzqc-00000004eV0-1kl8;
	Tue, 24 Nov 2026 23:22:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xVzqZ-00000000628-1kty;
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
Subject: [PATCH v1 07/21] hw/i386/kvm/xen_evtchn: Validate PIRQ numbers in physdev operations
Date: Tue, 24 Nov 2026 23:22:33 +0000
Message-ID: <20261124232247.23169-8-dwmw2@infradead.org>
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

xen_physdev_eoi_pirq() and xen_physdev_query_pirq() used the given PIRQ
number to index the PIRQ tables without checking it against nr_pirqs.
Reject out-of-range values, and reject PIRQ 0 in bind_pirq and
map_pirq. PIRQs 0-15 are reserved for the initial domain's identity
claims of the legacy ISA IRQs — the allocators, Xen's and ours alike,
never hand them out — and an HVM guest has no such claim. QEMU's
gsi_pirq[] and MSI target lookups both treat 0 as "no PIRQ", so a
guest-mapped pirq 0 could never deliver anything; better to refuse it
than to create a silently dead mapping.

Fixes: CVE-2026-123070
Fixes: 799c23548f0d ("i386/xen: Implement HYPERVISOR_physdev_op")
Reported-by: bubblehuntr <https://gitlab.com/bubblehuntr>
Reported-by: Hui Peng <benquike@gmail.com>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3639
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_evtchn.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 9379383e532..3aff01b5d6c 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -1283,7 +1283,7 @@ int xen_evtchn_bind_pirq_op(struct evtchn_bind_pirq *pirq)
         return -ENOTSUP;
     }
 
-    if (pirq->pirq >= s->nr_pirqs) {
+    if (!pirq->pirq || pirq->pirq >= s->nr_pirqs) {
         return -EINVAL;
     }
 
@@ -1877,7 +1877,7 @@ int xen_physdev_map_pirq(struct physdev_map_pirq *map)
             return pirq;
         }
         map->pirq = pirq;
-    } else if (pirq >= s->nr_pirqs) {
+    } else if (!pirq || pirq >= s->nr_pirqs) {
         return -EINVAL;
     } else {
         /*
@@ -1958,6 +1958,10 @@ int xen_physdev_eoi_pirq(struct physdev_eoi *eoi)
         return -ENOTSUP;
     }
 
+    if (pirq < 0 || pirq >= s->nr_pirqs) {
+        return -EINVAL;
+    }
+
     BQL_LOCK_GUARD();
     QEMU_LOCK_GUARD(&s->port_lock);
 
@@ -1990,6 +1994,10 @@ int xen_physdev_query_pirq(struct physdev_irq_status_query *query)
         return -ENOTSUP;
     }
 
+    if (pirq < 0 || pirq >= s->nr_pirqs) {
+        return -EINVAL;
+    }
+
     BQL_LOCK_GUARD();
     QEMU_LOCK_GUARD(&s->port_lock);
 
-- 
2.43.0

