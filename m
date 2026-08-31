Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3106139D6C8;
	Mon, 31 Aug 2026 21:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212239; cv=none; b=NkW5dzsS4it9q+cFJmVY9vM5ZlgyioJbu2d5iDPnlr0JXkDkOfGiiDDfSd97+R71Vh1oaTPT8UCYAsxaOdttBAxrKCL9/mzcxOdIYAXpHHtGJ1x9Ll4B7s1NfW4wOZ6tK1OyaAynACk35AXgU+zZK/3tZiBw7ZMS7IOh+ZtbVvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212239; c=relaxed/simple;
	bh=nMLnE8K7LVeRKGz4j6DzWKMyB0JxF/IsyR+5i2eZIQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3Shjof15cVCvV+mZkT1HCZ06RrwRS2ltbhgY6GRhXN4qe6DeClXxSsPLJS7Iu2PPPX06/pnY5qjCIdtaladt9dHg5FHnvMeM33LR9sWKVdnW7pSaq/9/ZG+FTci0bKkgL9YThFXMhB8YQ6P+8ZqdAebHhuVQDklxy4dkyPCmRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FyTWj47g; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FyTWj47g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JwZMgsCDbmdgOsZj+GCqeKJluBMBpuFCDwfK+6pYG3s=; b=FyTWj47gkrkPqnWtZuQ6lyjZgG
	1b11DTYrlQ/v3MRnYBvqdKJ70iw2MmZgCsvAaoVlOczVw94W7CuPGw7CjSi3Nodikk1ZQWweFa6HM
	5XsPPUEgj102oW4PUBYdvcZBpw4IXJHL9Bi4tawa5eQQtFV71P+TbkwJZPzPDjirJQOm/JADHGLsP
	7uYVJF8VbtXxS7kviYzMa0HhXgZbhFviXD0RDOQaDVJ6hYu+AAS7o/6hzjFTHFSVaRKcBzk7E7yfq
	B9AiaYsgHmgZUCS49Fl95o38/onL9zYMtSoWhM18m06ZDAm9nINK21YQF5Ybf/7bPzTLLikCNIDol
	rqzYjy1g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x19gE-00000003suy-29bS;
	Mon, 31 Aug 2026 21:36:38 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x19gE-00000000LD2-1JLr;
	Mon, 31 Aug 2026 22:36:38 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: dwmw2@infradead.org,
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
	nicoyip.dev@gmail.com,
	frn1furkan10@gmail.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imv4bel@gmail.com
Subject: [PATCH v3 07/13] KVM: x86/xen: Use 32-bit locked bts for vcpu_info evtchn_pending_sel
Date: Mon, 31 Aug 2026 22:26:38 +0100
Message-ID: <20260831213632.81023-8-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831213632.81023-1-dwmw2@infradead.org>
References: <20260831213632.81023-1-dwmw2@infradead.org>
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
index 941099ed50c9..aa49b45dd8dc 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1831,7 +1831,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 {
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
 	bool has_64bit_shinfo = kvm_xen_has_64bit_shinfo(kvm);
-	unsigned long *pending_bits, *mask_bits;
+	unsigned long *pending_bits, *mask_bits, vi_pending_sel_ofs;
 	struct kvm_vcpu *vcpu;
 	unsigned long flags;
 	int port_word_bit;
@@ -1864,11 +1864,18 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
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
@@ -1884,6 +1891,8 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		rc = -ENOTCONN; /* Masked */
 		kvm_xen_check_poller(vcpu, xe->port);
 	} else {
+		bool old;
+
 		rc = 1; /* Delivered to the bitmap in shared_info. */
 		/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
 		read_unlock_irqrestore(&gpc->lock, flags);
@@ -1900,19 +1909,29 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
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

