Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C8043C7AF;
	Tue, 11 Aug 2026 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445394; cv=none; b=UQixLVHRuIQmIu/d7WE2Oru6InHbDVWyvFvIGndRt5By2xWWSxVmYojbnw7k6HvVSIizi2JFUHuV+PwfutQltuANf749z+yv7tcU3sX0KHAOhgV3Cf/jCz8E3pou2lKZpHeVnNTgT+YSi89/YFBRntwbuaBOdGhIhvz/xhVZUyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445394; c=relaxed/simple;
	bh=zNx/aPeeZXaFykth++2z0CyLQZNAxDNzR9EDXDIYP3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9Ii+/1oBWJ+qeOf6ASMi/ML1e+1Iczk2ZVCyp2MPR/2iQxPWAC6o9c9LqYP8TfO21z40BpIyGfj5mPIb3BV1yD1RsrNdoegyxtjOgnjbOgTB3G9jFGW6Biqf4IkGb0lMhdrrQfMScyg7jalfRykCPKWYok79PbdD6wgjjK+3HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KGjixxVe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KGjixxVe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cFOix9MEHzEkHL6OuSiUhv0LJF9jrpcWzI6x+Cu6k5w=; b=KGjixxVeU0LwoKhoerTjXMFvis
	SGQEEF8qjgHBlMQoIViBtJNCqqf+Pk+KgH1vt5o8qdpV9XCWXB0YdZud8EsgYj5e6jZrx/scb5ubj
	Smm/qOAGvgfos3flDPiHfyipYCB2Ok8cFZObOkqO5/3VUGVhmaZLsdFF5vziROLSbRNB8zAcqEsLr
	wkjR1zFBs1L2vudTdsPYN9AbEPtY1sGnBOcFG6X8CmlRRByB8iy0oIHOAKhVQ7hIcpr6pTmI6XFPe
	TF9+lWPDYZUjXPGCFckaiYz2mwOGdfKIDJ/FH3GQJoDkrOllEJetSSmkrXZnv+19v0celP8Mxj/Ju
	xgZKtMGw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtj60-0000000GFnZ-1Szg;
	Tue, 11 Aug 2026 09:48:41 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1wtj5z-00000000PjS-3gDp;
	Tue, 11 Aug 2026 10:48:31 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: dwmw@amazon.co.uk,
	paul@xen.org,
	joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com,
	ankur.a.arora@oracle.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	x86@kernel.org,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	suryasaimadhu369@gmail.com,
	lkp@intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/11] KVM: x86/xen: Use 32-bit locked bts for vcpu_info evtchn_pending_sel
Date: Tue, 11 Aug 2026 10:37:09 +0100
Message-ID: <20260811094829.98794-8-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811094829.98794-1-dwmw2@infradead.org>
References: <20260811094829.98794-1-dwmw2@infradead.org>
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
x86-64, and the address of the per-vCPU info is guest-controlled and
only required to be 32-bit aligned, so an 8-byte access can generate a
split-lock #AC exception.

Since evtchn_pending_sel is at most 64 bits wide and port_word_bit
ranges 0-63, a 32-bit 'lock btsl' suffices for both native and compat
vcpu_info layouts, and only requires the 4-byte alignment that is
already guaranteed by the registration path.

This also eliminates the bogus cast of compat_vcpu_info's 32-bit
evtchn_pending_sel to 'unsigned long *' which was the original source
of the split-lock hazard.

Note, KVM reuses the local gpc. The atomic accesses to pending_bits is
on the page-aligned per-VM shared_info structure, i.e. doesn't need the
same treatment as the access is guaranteed to be 64-bit aligned.

Fixes: 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and event channel delivery")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260604193554.1BA311F00893@smtp.kernel.org
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
---
 arch/x86/kvm/xen.c | 47 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 959d79eef0ce..c935651906ec 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1815,7 +1815,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 {
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
 	bool has_64bit_shinfo = kvm_xen_has_64bit_shinfo(kvm);
-	unsigned long *pending_bits, *mask_bits;
+	unsigned long *pending_bits, *mask_bits, vi_pending_sel_ofs;
 	struct kvm_vcpu *vcpu;
 	unsigned long flags;
 	int port_word_bit;
@@ -1848,11 +1848,18 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
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
@@ -1868,6 +1875,8 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		rc = -ENOTCONN; /* Masked */
 		kvm_xen_check_poller(vcpu, xe->port);
 	} else {
+		bool old;
+
 		rc = 1; /* Delivered to the bitmap in shared_info. */
 		/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
 		read_unlock_irqrestore(&gpc->lock, flags);
@@ -1884,19 +1893,29 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
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
+		 * Explicitly use a 32-bit btsl instead of test_and_set_bit(),
+		 * which would use btsq on x86-64. The vcpu_info is guest-
+		 * controlled and only required to be 32-bit aligned, so a
+		 * 64-bit access could generate a split-lock #AC.
+		 *
+		 * Note, this does not apply to the test_and_set_bit() on
+		 * pending_bits above: that is in the per-VM shared_info, which
+		 * is page aligned, so the access is guaranteed to be 64-bit
+		 * aligned.
+		 */
+		old = GEN_BINARY_RMWcc(LOCK_PREFIX "btsl",
+				       *(u32 *)(gpc->khva + vi_pending_sel_ofs),
+				       c, "Ir", port_word_bit);
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
2.55.0

