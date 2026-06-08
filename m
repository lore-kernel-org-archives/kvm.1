Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A00F46AF36;
	Mon,  8 Jun 2026 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930546; cv=none; b=O3h/OsAwD8hRRxfB8v1ipVfbDu0v+n/MkMynbX/EX/y7byjvFPk07fkg+P2wq0feIe5UhwKdecALyiGphIO7tuQ5rLWcPgV6nRe+jS2fdGneTFn4bFbYyAka6W3yhpddJvLDB5OwoZPONXJ1wl5oknAIWj5OKTkuLXg4DAsYfD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930546; c=relaxed/simple;
	bh=W6njqFmEDJ7HeD7Rffg21UkWZz8yIroVUFoIw5g2Bu4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8LOGhFZuapAms+2n1zQfFnyeDjrken8Q7iyxgrJfD0GPbTJbOiOEHe9Apu7wE1QVI4benQM74ppKjsb42S6MULMGshDuKyUV2EXlgJGwsYHgFxtUOtpk0+U7kBry7vwDIUE/Chkxw92wtVxIbjbjHysP1zzlY9ixi6UHbZ8lKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LZ34K6Z/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LZ34K6Z/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description;
	bh=V9tsEhABtLjPHBbHUDtdbXgPRuXzrYUZjf8XuXI9WXM=; b=LZ34K6Z/ddUt3/HQU86KKuhjIf
	DHs/vhqZl97OOyCk/KC0mjRjKd3b+RCQWe+oE5pzxOekNIgh64VpJwMH51XifVzRtsZwMcz6xLywe
	eMW0NG+tyuhVE85Y6YxEYqiqsj/JqOrv/QcyGxdgA5hG4apiLHPVknvr+dIAIm3Kr2YG+xGlMaEdX
	2jOo5/sxniu4E9QdxMzGM/SduW5Su+K50DThxKGruIN1XbtKcoEpMJxftu8+vJzLwBzx4aOJ+Kbov
	fW1UYS9UvugRAEufvhayteWenkHeBjEIRgiWXJ8XJtdOebVsgjEt+M8HWZzfjV/tHilkP+BvlKdlO
	v763ZQKw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWbNU-00000001AgI-2L15;
	Mon, 08 Jun 2026 14:55:00 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWbNS-00000000NFy-20wI;
	Mon, 08 Jun 2026 15:54:58 +0100
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
Subject: [PATCH v5 23/34] KVM: x86: Factor out kvm_use_master_clock()
Date: Mon,  8 Jun 2026 15:48:04 +0100
Message-ID: <20260608145455.89187-24-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608145455.89187-1-dwmw2@infradead.org>
References: <20260608145455.89187-1-dwmw2@infradead.org>
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

Both kvm_track_tsc_matching() and pvclock_update_vm_gtod_copy() make a
decision about whether the KVM clock should be in master clock mode.
They used *different* criteria for the decision though. This isn't
really a problem; it only has the potential to cause unnecessary
invocations of KVM_REQ_MASTERCLOCK_UPDATE if the masterclock was
disabled due to TSC going backwards, or the guest using the old MSR.
But it isn't pretty.

Factor the decision out to a single function. And document the
historical reason why it's disabled for guests that use the old
MSR_KVM_SYSTEM_TIME.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 arch/x86/kvm/x86.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 86c30be4c5d2..72fb4620a5ba 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2638,11 +2638,30 @@ static inline bool gtod_is_based_on_tsc(int mode)
 {
 	return mode == VDSO_CLOCKMODE_TSC || mode == VDSO_CLOCKMODE_HVCLOCK;
 }
-#endif
+
+static bool kvm_use_master_clock(struct kvm *kvm)
+{
+	struct kvm_arch *ka = &kvm->arch;
+
+	/*
+	 * The 'old kvmclock' check is a workaround (from 2015) for a
+	 * SUSE 2.6.16 kernel that didn't boot if the system_time in
+	 * its kvmclock was too far behind the current time. So the
+	 * mode of just setting the reference point and allowing time
+	 * to proceed linearly from there makes it fail to boot.
+	 * Despite that being kind of the *point* of the way the clock
+	 * is exposed to the guest. By coincidence, the offending
+	 * kernels used the old MSR_KVM_SYSTEM_TIME, which was moved
+	 * only because it resided in the wrong number range. So the
+	 * workaround is activated for *all* guests using the old MSR.
+	 */
+	return ka->all_vcpus_matched_freq &&
+		!ka->backwards_tsc_observed &&
+		!ka->boot_vcpu_runs_old_kvmclock;
+}
 
 static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool new_generation)
 {
-#ifdef CONFIG_X86_64
 	struct kvm_arch *ka = &vcpu->kvm->arch;
 	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
 
@@ -2677,7 +2696,7 @@ static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool new_generation)
 	 * are fine — each vCPU's pvclock has its own tsc_timestamp that
 	 * accounts for its offset.
 	 */
-	bool use_master_clock = ka->all_vcpus_matched_freq &&
+	bool use_master_clock = kvm_use_master_clock(vcpu->kvm) &&
 				gtod_is_based_on_tsc(gtod->clock.vclock_mode);
 
 	/*
@@ -2693,8 +2712,11 @@ static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool new_generation)
 	trace_kvm_track_tsc(vcpu->vcpu_id, ka->nr_vcpus_matched_tsc,
 			    atomic_read(&vcpu->kvm->online_vcpus),
 		            ka->use_master_clock, gtod->clock.vclock_mode);
-#endif
 }
+#else
+static inline void kvm_track_tsc_matching(struct kvm_vcpu *vcpu,
+					  bool new_generation) {}
+#endif
 
 /*
  * Multiply tsc by a fixed point number represented by ratio.
@@ -3216,10 +3238,9 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 #ifdef CONFIG_X86_64
 	struct kvm_arch *ka = &kvm->arch;
 	int vclock_mode;
-	bool host_tsc_clocksource, vcpus_matched;
+	bool host_tsc_clocksource;
 
 	lockdep_assert_held(&kvm->arch.tsc_write_lock);
-	vcpus_matched = ka->all_vcpus_matched_freq;
 
 	/*
 	 * If the host uses TSC clock, then passthrough TSC as stable
@@ -3229,9 +3250,8 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 					&ka->master_kernel_ns,
 					&ka->master_cycle_now);
 
-	ka->use_master_clock = host_tsc_clocksource && vcpus_matched
-				&& !ka->backwards_tsc_observed
-				&& !ka->boot_vcpu_runs_old_kvmclock;
+	ka->use_master_clock = host_tsc_clocksource &&
+				kvm_use_master_clock(kvm);
 
 	if (ka->use_master_clock) {
 		u64 tsc_hz;
@@ -3259,7 +3279,7 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 
 	vclock_mode = pvclock_gtod_data.clock.vclock_mode;
 	trace_kvm_update_master_clock(ka->use_master_clock, vclock_mode,
-					vcpus_matched);
+					ka->all_vcpus_matched_freq);
 #endif
 }
 
-- 
2.54.0

