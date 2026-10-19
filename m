Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427097;
	b=BrePvOKycDIitvcu21SXRmmCAb1uTmXhVW4H1q0HxxmzfBXHEsJaulVxxer3DZ6RhYpN
	 5owiDJgIWQLXmsdUcHfrvuPE+EmLnE7TVYzyViyEaJ5MsMk2rZKmOnoSrhFtMd2fY+U09
	 AD3o4oSm5X+Uv1hfyT1fgO8HObNlTBL9oA/Sea/kC4cizO+GUFut8ahpMeh37goOcFi57
	 TJFR3EhZunjIh9n3dy7ibXa6g+E3bz31DNsuh6qsux1JrfU85O8TJE0O1SyM8UcB/TjLv
	 6wfT9X8LkTiBPKqYwJwRabTdIV3UbzlY/YGmTW+A00B8394jrjxGrGYW+t2qDXTR/0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427097;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=MMsmnyojUwvfLS70C6005NDLUir89RrnKsT7qQtTj8E=;
	b=IUvdwMHWlQR0p7V1teE+gnHfMDcS4uu+Peh4Zz4kdoICn/eMAVY6kjYyRU0ytA9dmCiO
	 T2uceJEIDB645PFuPjMtKxHnyGG43d8caZ1pC1aBgfitmbG2lImdK8jnyCvg5wEQGBQc8
	 U0mwpa+jGdqNA8Z8bsiKNoJCN0yYd55T/uOGx47iJayiVfnOP9VYI4po0iy/fmO6AVQ38
	 yQNyZjnT4AMtJWB52/bepfdw1oSC08n1pBTwS7HnHDlOO6e/83I/adNs9qjWRcgwcL3E9
	 DQEHPIo6QCmmCVCK5VIN59LtBkWQpjvnotaor4G42sxn3yotB4OyFv/7bZZ/3SUqeEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=g3kMOlJ3;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC87606A31A;
	Mon, 19 Oct 2026 16:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EC87606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=g3kMOlJ3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=MMsmnyojUwvfLS70C6005NDLUir89RrnKsT7qQtTj8E=; b=g3kMOlJ3I7LgQvgmxUDIiGw35t
	gusY9NogLvucUbvU6/ySeirM7N0IESQfjpx1pkGlCfex2+g9KmG83QCxgzsX7DIDiw9oakArJYKMf
	e+9Y4/eP042f7hA1Y4e+OQs+T/HzeiLkXcl/+gbDGm1UEEjDSQ0w9IxxYbiq1l5jiDXQViN9Mw4Qa
	ZvZta9wV73EPE66aERnsvnmLxCrkKUm8+QJeAvWKgI7zvNrzKg6DeUJsUINDG6cyahrkzGc50YYQ9
	Ov72UJbnobKJ4sDDsJgOttvxeFKqukI+KT1dIN+gwcXEUzN+BOTpBd4rrN6/lBabvadWBVPM8yuHh
	ZhPxf+9Q==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIqAH-00000009VGK-3P8J;
	Mon, 19 Oct 2026 16:24:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIqAH-000000009gp-2Cpj;
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
Subject: [PATCH v4 07/12] KVM: x86/xen: Extract delivery of event to vCPU into a separate helper
Date: Mon, 19 Oct 2026 17:24:38 +0100
Message-ID: <20261019162445.37219-8-dwmw2@infradead.org>
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

From: Sean Christopherson <seanjc@google.com>

Move the marking of an event as pending in the target vCPU's vcpu_info
into a separate helper, __kvm_xen_set_evtchn_fast(), invoked after the
shared_info processing is complete and its RCU read-side critical
section has been exited. This makes both halves easier to read.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
[dwmw2: rebased onto the -EAGAIN series. Sean's series first
 converted the GPC locks to read_trylock(), which this series does
 not carry, so the helper takes the plain read lock and the
 original's trylock failure path does not apply. The caller's
 kvm->srcu section extends across the helper call, since
 kvm_gpc_check() on the vcpu_info cache consults the memslot
 generation and the irqfd path enters holding only irq_srcu; in
 Sean's series that was covered by a guard(srcu) spanning the whole
 function. Note the "no functional change" is from the original;
 here the lock scopes do change: kvm_xen_check_poller() and the
 upcall vector injection now run outside the GPC read locks (and
 with interrupts restored), deliberately, so that the vCPU kick and
 the APIC map walk are not nested inside them.]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/xen.c | 158 ++++++++++++++++++++++++++++-----------------
 1 file changed, 97 insertions(+), 61 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index c0b9ac674255..6a1162caee9b 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1970,6 +1970,89 @@ static void kvm_xen_check_poller(struct kvm_vcpu *vcpu, int port)
 	}
 }
 
+static void __kvm_xen_set_evtchn_fast(struct kvm_vcpu *vcpu, int port_word_bit,
+				      bool has_64bit_shinfo)
+{
+	struct gfn_to_pfn_cache *gpc = &vcpu->arch.xen.vcpu_info_cache;
+	unsigned long vi_pending_sel_ofs;
+	bool inject_upcall = false;
+	bool kick_vcpu = false;
+	unsigned long flags;
+	bool old;
+
+	vi_pending_sel_ofs = has_64bit_shinfo ?
+		offsetof(struct vcpu_info, evtchn_pending_sel) :
+		offsetof(struct compat_vcpu_info, evtchn_pending_sel);
+
+	/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
+	read_lock_irqsave(&gpc->lock, flags);
+	if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
+		/*
+		 * Could not access the vcpu_info. Set the bit in-kernel and
+		 * prod the vCPU to deliver it for itself. Note that an MSI is
+		 * *not* an acceptable substitute here even if the vCPU has an
+		 * upcall vector: the pending bit only exists in
+		 * evtchn_pending_sel so far, and the vCPU has to be forced
+		 * out of the guest so that kvm_xen_inject_pending_events()
+		 * can refresh the cache and propagate it to the guest.
+		 */
+		if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
+			kick_vcpu = true;
+		goto out_unlock;
+	}
+	inject_upcall = true;
+
+	/*
+	 * Explicitly use a 32-bit btsl instead of test_and_set_bit(), which
+	 * would use btsq on x86-64. The vcpu_info is guest-controlled and only
+	 * required to be 32-bit aligned, so a 64-bit access could generate a
+	 * split-lock #AC.
+	 *
+	 * Note, this does not apply to the test_and_set_bit() on pending_bits
+	 * in the caller: that is in the per-VM shared_info, which is page
+	 * aligned, so the access is guaranteed to be 64-bit aligned.
+	 */
+	old = GEN_BINARY_RMWcc(LOCK_PREFIX "btsl",
+			       *(u32 *)(gpc->khva + vi_pending_sel_ofs),
+			       c, "Ir", port_word_bit);
+	if (!old) {
+		struct vcpu_info *vi = gpc->khva;
+
+		/* No need for compat handling */
+		BUILD_BUG_ON(offsetof(struct vcpu_info, evtchn_upcall_pending) !=
+			     offsetof(struct compat_vcpu_info, evtchn_upcall_pending));
+
+		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
+		kick_vcpu = true;
+	}
+
+out_unlock:
+	read_unlock_irqrestore(&gpc->lock, flags);
+
+	/*
+	 * Deliver the upcall or kick the vCPU only after dropping the GPC
+	 * read lock. Both paths end up in kvm_vcpu_kick(), and the MSI
+	 * delivery also walks the APIC map and takes APIC locks; none of
+	 * that wants to be nested inside the GPC read lock, which a
+	 * concurrent invalidation may be waiting to take for write.
+	 */
+	if (!kick_vcpu)
+		return;
+
+	/*
+	 * For the per-vCPU lapic vector, deliver it as MSI — but only if the
+	 * vcpu_info was actually updated above. If it wasn't, the vCPU must
+	 * be kicked instead (see above).
+	 */
+	if (inject_upcall && vcpu->arch.xen.upcall_vector) {
+		kvm_xen_inject_vcpu_vector(vcpu);
+		return;
+	}
+
+	kvm_make_request(KVM_REQ_UNBLOCK, vcpu);
+	kvm_vcpu_kick(vcpu);
+}
+
 /*
  * The return value from this function is propagated to kvm_set_irq() API,
  * so it returns:
@@ -1984,11 +2067,10 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 {
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
 	bool has_64bit_shinfo = kvm_xen_has_64bit_shinfo(kvm);
-	unsigned long *pending_bits, *mask_bits, vi_pending_sel_ofs;
+	unsigned long *pending_bits, *mask_bits;
 	struct kvm_vcpu *vcpu;
 	unsigned long flags;
 	int port_word_bit;
-	bool kick_vcpu = false;
 	int vcpu_idx, idx, rc;
 
 	vcpu_idx = READ_ONCE(xe->vcpu_idx);
@@ -2010,23 +2092,19 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 
 	read_lock_irqsave(&gpc->lock, flags);
 	if (!kvm_gpc_check(gpc, PAGE_SIZE))
-		goto out_rcu;
+		goto out_unlock;
 
 	if (has_64bit_shinfo) {
 		struct shared_info *shinfo = gpc->khva;
 		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
 		mask_bits = (unsigned long *)&shinfo->evtchn_mask;
 		port_word_bit = xe->port / 64;
-
-		vi_pending_sel_ofs = offsetof(struct vcpu_info, evtchn_pending_sel);
 	} else {
 		struct compat_shared_info *shinfo = gpc->khva;
 		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
 		mask_bits = (unsigned long *)&shinfo->evtchn_mask;
 		port_word_bit = xe->port / 32;
 
-		vi_pending_sel_ofs = offsetof(struct compat_vcpu_info, evtchn_pending_sel);
-
 		/* test_and_set_bit() needs 64-bit alignment, but that's OK */
 		BUILD_BUG_ON(offsetof(struct compat_shared_info, evtchn_pending) & 7);
 	}
@@ -2042,66 +2120,24 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		rc = 0; /* It was already raised */
 	} else if (test_bit(xe->port, mask_bits)) {
 		rc = -ENOTCONN; /* Masked */
-		kvm_xen_check_poller(vcpu, xe->port);
 	} else {
-		bool old;
-
 		rc = 1; /* Delivered to the bitmap in shared_info. */
-		/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
-		read_unlock_irqrestore(&gpc->lock, flags);
-		gpc = &vcpu->arch.xen.vcpu_info_cache;
-
-		read_lock_irqsave(&gpc->lock, flags);
-		if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
-			/*
-			 * Could not access the vcpu_info. Set the bit in-kernel
-			 * and prod the vCPU to deliver it for itself.
-			 */
-			if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
-				kick_vcpu = true;
-			goto out_rcu;
-		}
-
-		/*
-		 * Explicitly use a 32-bit btsl instead of test_and_set_bit(),
-		 * which would use btsq on x86-64. The vcpu_info is guest-
-		 * controlled and only required to be 32-bit aligned, so a
-		 * 64-bit access could generate a split-lock #AC.
-		 *
-		 * Note, this does not apply to the test_and_set_bit() on
-		 * pending_bits above: that is in the per-VM shared_info, which
-		 * is page aligned, so the access is guaranteed to be 64-bit
-		 * aligned.
-		 */
-		old = GEN_BINARY_RMWcc(LOCK_PREFIX "btsl",
-				       *(u32 *)(gpc->khva + vi_pending_sel_ofs),
-				       c, "Ir", port_word_bit);
-		if (!old) {
-			struct vcpu_info *vi = gpc->khva;
-
-			/* No need for compat handling */
-			BUILD_BUG_ON(offsetof(struct vcpu_info, evtchn_upcall_pending) !=
-				     offsetof(struct compat_vcpu_info, evtchn_upcall_pending));
-
-			WRITE_ONCE(vi->evtchn_upcall_pending, 1);
-			kick_vcpu = true;
-		}
-
-		/* For the per-vCPU lapic vector, deliver it as MSI. */
-		if (kick_vcpu && vcpu->arch.xen.upcall_vector) {
-			kvm_xen_inject_vcpu_vector(vcpu);
-			kick_vcpu = false;
-		}
 	}
 
- out_rcu:
+ out_unlock:
 	read_unlock_irqrestore(&gpc->lock, flags);
-	srcu_read_unlock(&kvm->srcu, idx);
 
-	if (kick_vcpu) {
-		kvm_make_request(KVM_REQ_UNBLOCK, vcpu);
-		kvm_vcpu_kick(vcpu);
-	}
+	/*
+	 * Both of these can kick the vCPU, so keep them outside the GPC
+	 * read lock; an invalidation may be waiting to take it for write.
+	 */
+	if (rc == -ENOTCONN)
+		kvm_xen_check_poller(vcpu, xe->port);
+	else if (rc == 1)
+		__kvm_xen_set_evtchn_fast(vcpu, port_word_bit,
+					  has_64bit_shinfo);
+
+	srcu_read_unlock(&kvm->srcu, idx);
 
 	return rc;
 }
-- 
2.43.0

