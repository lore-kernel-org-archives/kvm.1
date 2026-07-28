Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929C446AEDB;
	Tue, 28 Jul 2026 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250223; cv=none; b=VHjwOktY5fxwmcVs9eQlAI7cq0MHpQUEqebpxoJ412Z2mgc+85LRWj52+KNjtjLmPHoS9JoROWDjZ1cPodhKCtYwKcrEu8cI8IfCW6qv/6i3QN5C+2ZXDSwFZ4MyTIimhZSz5m+ogTKIlhc7EtdeRY+7C/hCJtILFagBW5gLOGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250223; c=relaxed/simple;
	bh=SWKwv2bOCFCnoukkRlfwH1JbpWLIuDs+DRw0v5NM+H0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKIFZHvLUK9r1GIBtVtuJnHv7d5Blew26/oCwUW90Zx1J8hzrqA6GaBAwMwJTPqNgxYduVbLrGVMF8+j3eXF/VHS3hwrgnvI/6YLcGYSSGazJ7XfpqJ9XvplflJgqBds35QYegN53tFeBvX7WX2KJPkqmGJRKWXqD762BqWIAq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K5PGIFx5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K5PGIFx5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description;
	bh=PztmQVd7JfGl26AYtk1jAuSHUznMXTAvSDcjnSe+xZ4=; b=K5PGIFx5U1QVAmwCsO4S6X5i9m
	KrdApY524qbWvHLTXG00OoYR/tduXR7BgPQaR1DRMCzKakwe3JR5wr47w3wbt8AKrCWuuZMFAwujb
	to/dm+VtSTzMygmAf7O79y5JmgSzSZ3/kPA0U8APaKtVa7lWRiNR8TKJLDCoYW7qtwfMCVzpJAHEU
	kgQ639EC877RBgEVLM2n+mK7pEfgWIjCBllwV4cDnDgmRTGX+J5rP230DDxHzaZwmpeRsOmR+mtn3
	6BqVuCzS9yqmwSNYNU/ShFyoVeVSVMtNg46oNX5foeGhGcgjyAjOhulSVozE/uSX7fghTM+jga1J8
	pK7m3sFQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1woj82-000000052Vg-357w;
	Tue, 28 Jul 2026 14:49:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1woj80-00000001UZU-0pAC;
	Tue, 28 Jul 2026 15:49:56 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Jack Allister <jalliste@amazon.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	joe.jin@oracle.com,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v7 26/36] KVM: x86: Cache host vclock_mode for masterclock eligibility checks
Date: Tue, 28 Jul 2026 15:40:06 +0100
Message-ID: <20260728144954.355376-27-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728144954.355376-1-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
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

The remaining users of pvclock_gtod_data only need to know whether
the host clocksource is TSC-based. Cache the vclock_mode value in a
simple kvm_host_vclock_mode variable, updated by the pvclock_gtod_notify
callback, and use gtod_is_based_on_tsc() for eligibility checks.

This is inherently racy (as it always was — kvm_track_tsc_matching
never held the gtod seqcount), relying on eventual consistency: the
notifier fires on every timekeeping update and will correct any
transient inconsistency within one tick.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro (claude-opus-4.6-1m)
---
 arch/x86/kvm/x86.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a64e5a596a4e..ee992c073b6d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1106,6 +1106,8 @@ static u64 compute_guest_tsc(struct kvm_vcpu *vcpu, s64 kernel_ns)
 }
 
 #ifdef CONFIG_X86_64
+static int kvm_host_vclock_mode;
+
 static inline bool gtod_is_based_on_tsc(int mode)
 {
 	return mode == VDSO_CLOCKMODE_TSC || mode == VDSO_CLOCKMODE_HVCLOCK;
@@ -1135,7 +1137,6 @@ static bool kvm_use_master_clock(struct kvm *kvm)
 static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool update_mclock)
 {
 	struct kvm_arch *ka = &vcpu->kvm->arch;
-	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
 	bool prev_matched_tsc = ka->all_vcpus_matched_tsc;
 
 	/*
@@ -1172,7 +1173,7 @@ static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool update_mclock)
 	 * accounts for its offset.
 	 */
 	bool use_master_clock = kvm_use_master_clock(vcpu->kvm) &&
-				gtod_is_based_on_tsc(gtod->clock.vclock_mode);
+				gtod_is_based_on_tsc(kvm_host_vclock_mode);
 
 	/*
 	 * Request a masterclock update if needed: toggling master clock,
@@ -1185,11 +1186,11 @@ static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool update_mclock)
 
 	trace_kvm_track_tsc(vcpu->vcpu_id, ka->nr_vcpus_matched_tsc,
 			    atomic_read(&vcpu->kvm->online_vcpus),
-		            ka->use_master_clock, gtod->clock.vclock_mode);
+		            ka->use_master_clock, kvm_host_vclock_mode);
 }
 #else
 static inline void kvm_track_tsc_matching(struct kvm_vcpu *vcpu,
-					  bool new_generation) {}
+					  bool update_mclock) {}
 #endif
 
 /*
@@ -1309,7 +1310,7 @@ static inline bool kvm_check_tsc_unstable(void)
 	 * TSC is marked unstable when we're running on Hyper-V,
 	 * 'TSC page' clocksource is good.
 	 */
-	if (pvclock_gtod_data.clock.vclock_mode == VDSO_CLOCKMODE_HVCLOCK)
+	if (kvm_host_vclock_mode == VDSO_CLOCKMODE_HVCLOCK)
 		return false;
 #endif
 	return check_tsc_unstable();
@@ -1717,7 +1718,6 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 {
 #ifdef CONFIG_X86_64
 	struct kvm_arch *ka = &kvm->arch;
-	int vclock_mode;
 	bool host_tsc_clocksource;
 
 	lockdep_assert_held(&kvm->arch.tsc_write_lock);
@@ -1757,9 +1757,9 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 			ka->use_master_clock = false;
 	}
 
-	vclock_mode = pvclock_gtod_data.clock.vclock_mode;
-	trace_kvm_update_master_clock(ka->use_master_clock, vclock_mode,
-					ka->all_vcpus_matched_freq);
+	trace_kvm_update_master_clock(ka->use_master_clock,
+				     kvm_host_vclock_mode,
+				     ka->all_vcpus_matched_freq);
 #endif
 }
 
@@ -7075,12 +7075,15 @@ static int pvclock_gtod_notify(struct notifier_block *nb, unsigned long unused,
 	update_pvclock_gtod(tk);
 
 #ifdef CONFIG_X86_64
+	kvm_host_vclock_mode =
+		tk->tkr_mono.clock->vdso_clock_mode;
+
 	/*
 	 * Disable master clock if host does not trust, or does not use,
 	 * TSC based clocksource. Delegate queue_work() to irq_work as
 	 * this is invoked with tk_core.seq write held.
 	 */
-	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode) &&
+	if (!gtod_is_based_on_tsc(kvm_host_vclock_mode) &&
 	    atomic_read(&kvm_guest_has_master_clock) != 0)
 		irq_work_queue(&pvclock_irq_work);
 #endif
-- 
2.55.0

