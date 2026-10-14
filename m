Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EA14B1D19;
	Wed, 14 Oct 2026 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015517; cv=none; b=Z/4NUkbZ8XybCG8yC2um3L9YWs1YI8VsSHIZDWHttrjSGq3xWWMVnMN7D7J26CjjKobIgCQbeuXBxEGiQUUGoQpGyCHZL8zdKUbV7W87ZzZEdbPEP7CBQbo0vChe/61FQEfJtjIewn2L8mZOu058fpnuE826YqREju/TdN5FHmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015517; c=relaxed/simple;
	bh=jwjGc8g9I06gsGeqH6uwGB1HHn5Qk7fwHq80Ds2h11A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4Y//d64FyhJD1SnrcEByr8s9N0yHHMiBCiDJkECPnSXa6AGjnDaWeQE5/S6JPXvydx+Ih8uUoSrGmJV8VTJST2pxUjJKPhoaX4e6uorIcpHo4Wz9SbuTkkclwcaChTbHuEAL2oH+fxDh555gggAP+LNR79SqhYBNBpzOWT6U5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pJLfHNww; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pJLfHNww"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=LJeRHfJdWqfUY321021fwL2gT9nnvMcXR/5R4/mkY2c=; b=pJLfHNww9dMhEgSJUyTpy/+F5k
	LlCZQWauzCweNp3OeM2FmOheShupuLVzGkmzpTCZA5qBzWb+aBxZeR6yj5lwUg5cf02q/UgzMgBs9
	yYjdD96luMRvexnXTl1UengzBCCNKD23EZVTyLZwMqy2PO+LfJkAgCnj8sfyu5+R7sixiyKPLARb+
	AJyNNJnhYS4JocXixWU+M+kB7lLS1uDskGcT+K02wr3ErOxil2rewXIYgRF/3Cgc1Ze+gd1Bo1V/f
	jZvjl1ENE9ogKDhZt6hYyb9pzXPgaMD6fklkIUbSYbEDw2i360mY4fIWWEKYa2EvZwDdFkrnMa8/M
	0+ssgIYA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xH75y-0000000HFAG-44sJ;
	Wed, 14 Oct 2026 22:05:11 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xH75w-00000002Axs-2jyr;
	Wed, 14 Oct 2026 23:05:08 +0100
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
Subject: [PATCH v2 07/11] KVM: x86/xen: Extract delivery of event to vCPU into a separate helper
Date: Wed, 14 Oct 2026 23:05:03 +0100
Message-ID: <20261014220508.518772-8-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014220508.518772-1-dwmw2@infradead.org>
References: <20261014220508.518772-1-dwmw2@infradead.org>
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
 function.]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/xen.c | 158 ++++++++++++++++++++++++++++-----------------
 1 file changed, 97 insertions(+), 61 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index a88f571e8682..8491b4adaf51 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1893,6 +1893,89 @@ static void kvm_xen_check_poller(struct kvm_vcpu *vcpu, int port)
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
@@ -1907,11 +1990,10 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
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
@@ -1933,23 +2015,19 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 
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
@@ -1965,66 +2043,24 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
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

