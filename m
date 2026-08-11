Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB1732143D;
	Tue, 11 Aug 2026 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454575; cv=none; b=L2Z3xXRGQ/xL/JkFr2XYLuJm6VLm86Gv521JcySpXnOTO5l4EwCRK58BUpvR2pkbv6UJxsrsYvMbiUTfOesoNhUUBMEMaOlXSTpZC7iNPXgBXtpba3nTansYMF3tCUwZhZEtPcvG6B/c+AHqrnqZcOa0lMVs+969rseODa/pv1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454575; c=relaxed/simple;
	bh=PoBwmxUowFVvctphMHiU1502xvxhZ9LDsOwk5YVbsOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asGofc3O9P/SKEKJstADP/TdGISfllslIWv8PYE6V6aL1jOvJaa1SeEhplCc+vjY03I0vG52eSA4aXtrg56nzlJXelVXyb9LsQJvUJHKn1la/2SVRMueiOBfspORjOxXfICbWAF3K2IfRuPS3bHAsvX1Dt+bJTv0KROhlrYbvRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ub3kgyQP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ub3kgyQP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=V29VnP0TGuLRIu0HX9T6++rQY3jn2ihSNDPJPUPtEnY=; b=Ub3kgyQPjHN45fTjoI47aKToqW
	q4VMXQgx/XX4ysFnER+W6lDQujxtMo7q35lNhuWlSDoHcbtpU5KWVjUZZ1h2aob7JFwDyMFpVkUVy
	RKigYL1x9cB/MDJVnSMKlFUACmbqubI0bUVbC44MbYuemuZKE7TBZfNkD791WVbcpMDeoRLhk/aq/
	56jLagxQDneOBdPw1nojY/oPcGQEzlDDlLLZL6AZG0/ToBUNO5cV2JmIATBZwcvzT63kkAwgoUOTw
	xWjiXGZcfLrkFmJ3DFtW0TcBp9rieoPFYEUPfn8lWfi8vRkj7GCWH9arJ5Tmw5TX2W7S70VDHVLMd
	etnXOMSQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wtmRF-0000000EbSb-0uys;
	Tue, 11 Aug 2026 13:22:41 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1wtmRC-00000000Qlh-1JH8;
	Tue, 11 Aug 2026 14:22:38 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: dwmw2@infradead.org,
	paul@xen.org,
	joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com,
	ankur.a.arora@oracle.com,
	stollmc@amazon.com,
	paulmck@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	bigeasy@linutronix.de,
	syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] KVM: x86/xen: Extract delivery of event to vCPU into a separate helper
Date: Tue, 11 Aug 2026 13:49:52 +0100
Message-ID: <20260811132237.102400-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811132237.102400-1-dwmw2@infradead.org>
References: <20260811132237.102400-1-dwmw2@infradead.org>
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
[dwmw2: rebased onto the RCU conversion of the GPC locking; the
 read_trylock() failure path in the original no longer exists. The
 caller's kvm->srcu section now extends across the helper call, since
 kvm_gpc_check() on the vcpu_info cache consults the memslot
 generation and the irqfd path enters holding only irq_srcu; in Sean's
 series that was covered by a guard(srcu) spanning the whole function,
 which this series does not carry.]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
---
 arch/x86/kvm/xen.c | 155 ++++++++++++++++++++++++++++-----------------
 1 file changed, 98 insertions(+), 57 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 179efcfb40e3..40cb56621e25 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1791,6 +1791,93 @@ static void kvm_xen_check_poller(struct kvm_vcpu *vcpu, int port)
 	}
 }
 
+/* Called with kvm->srcu held, as kvm_gpc_check() consults the memslots. */
+static void __kvm_xen_set_evtchn_fast(struct kvm_vcpu *vcpu, int port_word_bit)
+{
+	struct gfn_to_pfn_cache *gpc = &vcpu->arch.xen.vcpu_info_cache;
+	bool has_64bit_shinfo = kvm_xen_has_64bit_shinfo(vcpu->kvm);
+	unsigned long vi_pending_sel_ofs;
+	bool inject_upcall = false;
+	bool kick_vcpu = false;
+	bool old;
+	int idx;
+
+	vi_pending_sel_ofs = has_64bit_shinfo ?
+		offsetof(struct vcpu_info, evtchn_pending_sel) :
+		offsetof(struct compat_vcpu_info, evtchn_pending_sel);
+
+	/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
+	idx = srcu_read_lock(&vcpu->kvm->gpc_srcu);
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
+	srcu_read_unlock(&vcpu->kvm->gpc_srcu, idx);
+
+	/*
+	 * Deliver the upcall or kick the vCPU only after dropping the GPC
+	 * read lock. Both paths end up in kvm_vcpu_kick(), and the MSI
+	 * delivery also walks the APIC map and takes APIC locks; none of
+	 * that wants to be nested inside the GPC read-side critical
+	 * section, which must be no longer than the accesses to gpc->khva
+	 * above. Invalidation waits for a grace period, so holding the
+	 * read lock across the kick would extend how long a memory
+	 * invalidation is blocked.
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
@@ -1805,10 +1892,9 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 {
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
 	bool has_64bit_shinfo = kvm_xen_has_64bit_shinfo(kvm);
-	unsigned long *pending_bits, *mask_bits, vi_pending_sel_ofs;
+	unsigned long *pending_bits, *mask_bits;
 	struct kvm_vcpu *vcpu;
 	int port_word_bit;
-	bool kick_vcpu = false;
 	int vcpu_idx, idx, gpc_idx, rc;
 
 	vcpu_idx = READ_ONCE(xe->vcpu_idx);
@@ -1837,16 +1923,12 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
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
@@ -1862,64 +1944,23 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		rc = 0; /* It was already raised */
 	} else if (test_bit(xe->port, mask_bits)) {
 		rc = -ENOTCONN; /* Masked */
-		kvm_xen_check_poller(vcpu, xe->port);
 	} else {
-		bool old;
-
 		rc = 1; /* Delivered to the bitmap in shared_info. */
-		/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
-		gpc = &vcpu->arch.xen.vcpu_info_cache;
-
-		if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
-			/*
-			 * Could not access the vcpu_info. Set the bit in-kernel
-			 * and prod the vCPU to deliver it for itself.
-			 */
-			if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
-				kick_vcpu = true;
-			goto out_gpc_srcu;
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
 
  out_gpc_srcu:
 	srcu_read_unlock(&kvm->gpc_srcu, gpc_idx);
-	srcu_read_unlock(&kvm->srcu, idx);
 
-	if (kick_vcpu) {
-		kvm_make_request(KVM_REQ_UNBLOCK, vcpu);
-		kvm_vcpu_kick(vcpu);
-	}
+	/*
+	 * Both of these can kick the vCPU, so keep them outside the GPC
+	 * read-side critical section; invalidation waits for a grace period.
+	 */
+	if (rc == -ENOTCONN)
+		kvm_xen_check_poller(vcpu, xe->port);
+	else if (rc == 1)
+		__kvm_xen_set_evtchn_fast(vcpu, port_word_bit);
+
+	srcu_read_unlock(&kvm->srcu, idx);
 
 	return rc;
 }
-- 
2.55.0

