Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427097;
	b=pfbcJXE5F6p7YfOpv6jvXfac9WqBuUYUuY9CigJgIVAcuNaJnDS52NvMy1H0pqDl6IK2
	 P2kyLOFjhZXyLADEVGrMX8D+SF8Cxw5y9HVOxyZxJaxSBrs9ho/DGlZEaOthzCGRFcmE6
	 5srySuAaz9FUOTiqYdRgWzS1pq4wZo9FYcDYbmTlAhGUzL/9Fq0T1sF1BwX+8fc9xrtO6
	 cFpyMX44fQPTo9+tAfe28toYshFAdjqEmcOc1YtEpLTH0RSs9YbxzH5kPy3GeOI9xEDGu
	 PnoVm7zjV+vjLz0WbsBgpSk2htzI1b4h2nXv6fTwH/1hjrht6KK441Mbhef8yZNy9uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427097;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=/VD9EG2KiE5OItNAh1xRhZZwJ3NvkM7B3uEI0rjcQOU=;
	b=juRX4iqGIG0v4vAvEFZiQu6mopm/wD07xfz2g9l6JZWsehlNlg6BpfTCi3NJaj9tP511
	 XVwD4WruwVmenrxsjjrbqZ/igf+0PYYZBIAcLjaPT/mSqPacwkIqiYmQx5DV6sMM9AMj6
	 x0b8q4hcTUIyXdc35+QS48dbVux1hS3cpWbpJ0sLj5kX1/WPL7n1XPbQDXsBkFFDeSLwX
	 YsA1fUf4EEB+Vshu9oqXwIKIoL4G4FB+XDPcTPQg7lR6mRPTOSDaqkJWsy7fOUUZUcZN5
	 lglj2XCw5+nTlwv1xA4lTuU408kDr6CR/dkqTqfiPLIvrRECKyF8Lo9FXuVKQo2RCMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=WVOW95rb;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED24606A31F;
	Mon, 19 Oct 2026 16:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ED24606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=WVOW95rb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=/VD9EG2KiE5OItNAh1xRhZZwJ3NvkM7B3uEI0rjcQOU=; b=WVOW95rbqjl78HyTifdRtCP1aH
	NG8MvbDO9XfMXxeGYNRyZSvZUr69XApWv07FW4z+5paWkIqQcu3kY0RwWCYQj3Jojivt5W9Be9p48
	Am15D75sC7sdDq1lHo9jFAqN2WLOghZpYzJpsMh/id1rv1Ia2VMGkzJW4CthQBSNsRjio3r92w38/
	uU8+DDp2RRgWBbs3No2MhhFQF8ytYpkaDXuO0zL+5SFcxGAW6SDXe4DhcwHB5vfTkjjM7SED3N7gE
	OypVyFaZL2gAUg+pDIcD5+mk11+h2POhOe015qsDJiHq08HbM4mA1xiUzjLQHUE6VpkSuhYKPyz4b
	VHS+mhZg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIqAH-00000009VGL-3PBP;
	Mon, 19 Oct 2026 16:24:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIqAH-000000009ga-0tUO;
	Mon, 19 Oct 2026 17:24:45 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v4 02/12] KVM: pfncache: Return -EAGAIN for a lookup which hits an invalid memslot
Date: Mon, 19 Oct 2026 17:24:33 +0100
Message-ID: <20261019162445.37219-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019162445.37219-1-dwmw2@infradead.org>
References: <20261019162445.37219-1-dwmw2@infradead.org>
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

A memslot being deleted or moved is present in the active array but
flagged KVM_MEMSLOT_INVALID — a transient state which exists only
within a single KVM_SET_USER_MEMORY_REGION call and is announced by
a further generation bump when it resolves. gfn_to_hva_memslot()
collapses that case and a genuinely unbacked gfn into one error, and
the pfncache refresh reported both as -EFAULT.

Distinguish them: return -EAGAIN when the slot exists but is
invalid, mirroring what RET_PF_RETRY does for ordinary guest faults
on an invalid slot. Existing users don't *need* to change; most
will simply resolve again at the next refresh. But the distinct
error code *allows* a caller to retry.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 virt/kvm/pfncache.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 3659686b97c2..17aaebd76db8 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -304,7 +304,22 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 			gpc->uhva = gfn_to_hva_memslot(gpc->memslot, gfn);
 
 			if (kvm_is_error_hva(gpc->uhva)) {
-				ret = -EFAULT;
+				/*
+				 * A slot being deleted or moved is present
+				 * but flagged invalid; the lookup failure is
+				 * transient, resolved when the update
+				 * completes (or reverts) and announced by a
+				 * new memslot generation. Distinguish that
+				 * from a genuinely unbacked gfn so that the
+				 * caller may retry rather than report an
+				 * error, as RET_PF_RETRY does for ordinary
+				 * guest faults.
+				 */
+				if (gpc->memslot &&
+				    (gpc->memslot->flags & KVM_MEMSLOT_INVALID))
+					ret = -EAGAIN;
+				else
+					ret = -EFAULT;
 				goto out;
 			}
 
-- 
2.43.0

