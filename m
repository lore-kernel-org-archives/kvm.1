Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799044EBAC8;
	Fri, 16 Oct 2026 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162620; cv=none; b=JmbvKImgIaeB8zAGH1YFF7Ln/4f5t4gsMVsPmKK0UqHpKhTRHABUL0dioxB3dvFUHsOUMv6uQP3sh7ZPuVhI9/KVqBEeFR/oFbU+kfeIdeYO1GqKdwuUQzVJ8+cPfiu53swHLIrfltk/BB6H2s8u8bTVr0suPcNMm7o6VgmN3Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162620; c=relaxed/simple;
	bh=jdGNxbHHhF/6fdAGZaaomlxeX+vyF6KNZj7stzlAGj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nzefm5tvyHSRagy2j6OU0ctt3+ATk4D9eLMYUIkZtXCV6LEkcObM74LSUPO57Cc56KE5Fn5M/nHWQ84GDOm+JmuElTSWXV6zv5o/amJOMfxNH2UbwQHCszytmOMc38DZ3a4Q3k5FV1e5BEaUmOBMIFPgA0D6mldBLglSy0p2304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XJtaHO5l; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XJtaHO5l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=/VD9EG2KiE5OItNAh1xRhZZwJ3NvkM7B3uEI0rjcQOU=; b=XJtaHO5l688FEBDVgl5htcXsRr
	Km1t0BU5bTwTJ1ie+QZYlt+h0aSggVB8gnrRYm8xN46pES98LR5Aw3jyfWUHbWmvkntTcwJV8XSud
	K0dP35rI0KuopdUrk99ro1oVWL8k9W5pDXHDnRrnctiQt9O51+bq4AYaOoBrfA2vHoNsa7tNxH9U5
	mja55qS/spPzMEJjYhT0aubHXB0y2yDHsFgR34TRntbXfH6UdV9mi+t0aow35aDEdQ0otZd4Mu3MG
	uxPLYS3H9Q2VjFJtM3wlH2Al8gvJyFC3k09WSRYbL84MGVMlEVctcf8Af7KeTIcILXEMzfjVBxgmM
	NfjGhsXw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHjMX-00000001dOX-1wmo;
	Fri, 16 Oct 2026 14:56:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHjMU-00000002Qiq-2Mvb;
	Fri, 16 Oct 2026 15:56:46 +0100
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
Subject: [PATCH v3 01/11] KVM: pfncache: Return -EAGAIN for a lookup which hits an invalid memslot
Date: Fri, 16 Oct 2026 15:56:35 +0100
Message-ID: <20261016145646.579369-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016145646.579369-1-dwmw2@infradead.org>
References: <20261016145646.579369-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

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

