Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5693B27C9;
	Fri,  5 Jun 2026 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669849; cv=none; b=P+wHSP1IRnpLYiumoTg/kw25rC1oD0n2oWLAXKkDjCNmPA2p/+8DOriPRj4kQh5eIMPfpAH1YOV/Hkktzf43vjSV0rPjPDDNcdzEzrtfDvYxGdh2/e8MVaW7QhmBi8XF5eFQil6Ty72Go5E1TVzbPn5D9fltIxEwsZ2Nn17fFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669849; c=relaxed/simple;
	bh=nQwTxl/c6hNyrtiK3GLaUFGTWu1Pq98jPNhLZoIJG3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGyD9Ryjkue+zFMM2uYIajRBWCvvMyASRKzSQp8OKQnrToOBm7Ro+rooGiGG0PQuStYQkdT98up9DjPQUvwa3eoKk0fWfsqPrPoGr7hWheeWNuy1VGOMhmGCbFi/lLy6pOdfTcLW6B28mWBN4lAxmvLF+uwuWwBwCUb4ocF/FYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g5feNJgw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g5feNJgw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=R6m97oGyXM5wXsX6tvDVPhETAHa89nqtaU5+VWjI5uc=; b=g5feNJgwhDGuG2kuNZGDeoTN2W
	GKj6+bDAnZd7rNxG85FV9je8QVi/iJrEBnNhjJWLX7aEPdcm7NcdVAuLU2n3N8ubqqB1X08X8S8T7
	c/UUVNSMS5fyq1ilpXuuSt3yatJuPLyPI5BmEgtW8le2Eb7RRA1aDcUGB6FJibrTqnGfT2SNMdlS6
	6j1CuaXNeMoJzL6WvD//KM6ZPRhsjceHJ931CkQTS+I/A+6vVZ2J7bM4gXohOj9LMIWb1LVFCblRq
	d08Gydt6+OCfyI1RGJFX9OJjh+Ec1Wv+y85TWGhyECLRLzeMGlFPw6IRs88b4kRZmSc2LRkoybCvf
	d+KXStVQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVVZE-0000000848Z-2367;
	Fri, 05 Jun 2026 14:30:37 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVVZE-0000000013k-2Ath;
	Fri, 05 Jun 2026 15:30:36 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paul Durrant <paul@xen.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] KVM: x86/xen: Use 32-bit locked bts for vcpu_info evtchn_pending_sel
Date: Fri,  5 Jun 2026 15:17:32 +0100
Message-ID: <20260605143034.3603-8-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605143034.3603-1-dwmw2@infradead.org>
References: <20260605143034.3603-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Replace test_and_set_bit() on vcpu_info->evtchn_pending_sel with an
explicit 'lock btsl' in kvm_xen_set_evtchn_fast(). The generic
test_and_set_bit() uses a 64-bit locked operation ('lock btsq') on
x86-64, which requires 8-byte alignment to avoid split-lock #AC
exceptions.

Since evtchn_pending_sel is at most 64 bits wide and port_word_bit
ranges 0-63, a 32-bit 'lock btsl' suffices for both native and compat
vcpu_info layouts, and only requires the 4-byte alignment that is
already guaranteed by the registration path.

This also eliminates the bogus cast of compat_vcpu_info's 32-bit
evtchn_pending_sel to 'unsigned long *' which was the original source
of the split-lock hazard.

Fixes: 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and event channel delivery")
Reported-by: sashiko-bot@kernel.org
Assisted-by: Kiro:claude-opus-4.6-1m
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index ae0713718367..24e939ef5d64 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1811,7 +1811,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 {
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
 	bool has_64bit_shinfo = kvm_xen_has_64bit_shinfo(kvm);
-	unsigned long *pending_bits, *mask_bits;
+	unsigned long *pending_bits, *mask_bits, vi_pending_sel_ofs;
 	struct kvm_vcpu *vcpu;
 	unsigned long flags;
 	int port_word_bit;
@@ -1844,11 +1844,18 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
 		mask_bits = (unsigned long *)&shinfo->evtchn_mask;
 		port_word_bit = xe->port / 64;
+
+		vi_pending_sel_ofs = offsetof(struct vcpu_info, evtchn_pending_sel);
 	} else {
 		struct compat_shared_info *shinfo = gpc->khva;
 		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
 		mask_bits = (unsigned long *)&shinfo->evtchn_mask;
 		port_word_bit = xe->port / 32;
+
+		vi_pending_sel_ofs = offsetof(struct compat_vcpu_info, evtchn_pending_sel);
+
+		/* test_and_set_bit() needs 64-bit alignment, but that's OK */
+		BUILD_BUG_ON(offsetof(struct compat_shared_info, evtchn_pending) & 7);
 	}
 
 	/*
@@ -1864,6 +1871,8 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		rc = -ENOTCONN; /* Masked */
 		kvm_xen_check_poller(vcpu, xe->port);
 	} else {
+		bool old;
+
 		rc = 1; /* Delivered to the bitmap in shared_info. */
 		/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
 		read_unlock_irqrestore(&gpc->lock, flags);
@@ -1880,19 +1889,24 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 			goto out_rcu;
 		}
 
-		if (has_64bit_shinfo) {
-			struct vcpu_info *vcpu_info = gpc->khva;
-			if (!test_and_set_bit(port_word_bit, &vcpu_info->evtchn_pending_sel)) {
-				WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
-				kick_vcpu = true;
-			}
-		} else {
-			struct compat_vcpu_info *vcpu_info = gpc->khva;
-			if (!test_and_set_bit(port_word_bit,
-					      (unsigned long *)&vcpu_info->evtchn_pending_sel)) {
-				WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
-				kick_vcpu = true;
-			}
+		/*
+		 * Explicitly use btsl instead of test_and_set_bit() because
+		 * a 32-bit guest is not required to align to 64 bits, and
+		 * that might cause splitlock exceptions.
+		 */
+		asm volatile(LOCK_PREFIX "btsl %[bit], %[sel]"
+			     : [sel] "+m" (*(u32 *)(gpc->khva + vi_pending_sel_ofs)),
+			       "=@ccc" (old)
+			     : [bit] "Ir" (port_word_bit) : "memory");
+		if (!old) {
+			struct vcpu_info *vi = gpc->khva;
+
+			/* No need for compat handling */
+			BUILD_BUG_ON(offsetof(struct vcpu_info, evtchn_upcall_pending) !=
+				     offsetof(struct compat_vcpu_info, evtchn_upcall_pending));
+
+			WRITE_ONCE(vi->evtchn_upcall_pending, 1);
+			kick_vcpu = true;
 		}
 
 		/* For the per-vCPU lapic vector, deliver it as MSI. */
-- 
2.54.0

