Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893805;
	b=nPjQOzaG6VfTTT6n5za6iX+No7c1O4QWvUWAKvapyogn/iKKT9WSDcIGIMhbR/i0O1sq
	 RE5al6elotJ54kABBkxOjNcspbA1SWywEdilLtEeNj6a4feaNyfG5Lkf5AkAx5kAjj20x
	 pD1+R5RDzpouiSzq/OYACcKcAo+6XJSfvsVHGJ66Mpnc3unGucQGN234K7Hk1P9UAJftm
	 6fV4h14sJObbCBRyZ1aRtdLf5rlUtwUYGTpTaijY6Vy8G+K9j2U8iP207eQtXxbkPbkzM
	 SHufYs6gAws7tKPFK0qqRaKNJiAqpneE69bUHNb84JGJ/QR6aXfIKaDUKokaEyMg/Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893805;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=WVtfluigLHm+qCIoMwJls4zd6p70KJsFBBAO4EnPbSY=;
	b=e8yHAy9whncDL40BYi+HjjCS9J3Ho9Vf9mdabFhPnhtu1KlZG0t+ZaOLmeFSyb8F7+jA
	 7rLXtQOg6gVUi8FZthJ51IQtoeTN1bRK30pRLEmB5XTflCDZK5sZhUrbp5AqS/5A8zZOS
	 oO+iSd0q/cSHfUqoOU/Kk4MAqnBXnxCrg3+TBrz8jNGaK1h+TARtoljcJB6U+HNVA6ib/
	 fpK110oX6lE4cjx4cQxSFekUXNLykJBgfAyp/N9JRILljqBUKET3Wnec+R74MIOCJMTda
	 Mk3ZTqkD6HgzceZKWuSUJGpm3hQmfyZTfW4ecGnClmGKiWc86gnGfe6wF5GIXsiKHGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=IPxuipau;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4070606A33C;
	Thu,  5 Nov 2026 15:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4070606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=IPxuipau
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=WVtfluigLHm+qCIoMwJls4zd6p70KJsFBBAO4EnPbSY=; b=IPxuipauPh1uxvLe8CbOPYLS4J
	vfXdV83+56i8IGOPlQ1wOVhKkuA4BlHApMOlXaBrgLCP4Ls5amnO9shAQCuonKgetQda59SU4s4Fc
	Upx0kZ2G5CVCxQd6ZlV+KzNcIozzfXizorRjZP18jrkGACtgQmR9tV99a1Z/fNVf0NHzj/rKsEIU2
	/uobNRbQcM/wIpdn2fIYxt8k1cJcBy+J96/UH6V7Dx9LdQhJfXzuUsJ8ALytrIMiB80EpKGBnJrOu
	BYX8Qfgw5WkCxv30CoQjKQ6BRoirOcT6Ihrx4OLh3ZZEhNA6vShpKTD9afezLI5K2d2ks4ozk/AbJ
	3zdwgRMA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOziw-00000003Bny-29bb;
	Thu, 05 Nov 2026 15:49:58 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOziu-0000000AazR-01Rb;
	Thu, 05 Nov 2026 15:49:56 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Jack Allister <jalliste@amazon.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	joe.jin@oracle.com,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v11 11/23] KVM: x86: Activate master clock from kvm_arch_init_vm()
Date: Thu,  5 Nov 2026 07:49:42 -0800
Message-ID: <20261105154955.2525419-12-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105154955.2525419-1-dwmw2@infradead.org>
References: <20261105154955.2525419-1-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Initialize the TSC generation and master clock state at VM creation
time, rather than relying on kvm_update_masterclock() from
kvm_arch_vcpu_postcreate().

Set cur_tsc_generation=1, cur_tsc_khz, cur_tsc_scaling_ratio,
cur_tsc_offset, cur_tsc_nsec and kvmclock_offset from an atomic
ktime/TSC snapshot. This establishes a coherent epoch so that:

 - The first vCPU synchronizes to the existing generation (getting
   the pre-computed TSC offset) rather than computing its own.
 - pvclock_update_vm_gtod_copy() succeeds immediately (no zero
   tsc_hz from uninitialized cur_tsc_scaling_ratio).
 - KVM_GET_CLOCK returns valid {host_tsc, realtime} fields as soon
   as any vCPU exists.
 - KVM_[GS]ET_CLOCK_GUEST works without a prior KVM_RUN.
 - No O(N) iteration of all vCPUs on each vCPU creation.

This replaces the KVM_REQ_MASTERCLOCK_UPDATE check and
kvm_update_masterclock() call in kvm_arch_vcpu_postcreate(), which
worked around the missing initialization. A masterclock refresh is
still performed (synchronously, so that it is valid even for userspace
which queries the clock before ever running a vCPU) when the first
vCPU is created, since the VM-creation snapshot can go stale while the
VM has no vCPUs: a clocksource change notifies only VMs with vCPUs,
and a change back to TSC leaves nothing to disagree with the stale
snapshot.

The generation's recorded offset in kvm_synchronize_tsc() can now only
be joined by a vCPU with the same scaling ratio it was recorded with:
the initial generation's offset is recorded with the default ratio
before any vCPU exists, and a vCPU with a different ratio opens a new
generation with its own offset, keeping the generation's ratio and
offset describing the same scaling domain.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 76 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 940168528721..6dbdb60962fe 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1500,11 +1500,25 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *value, bool user_initiated)
 
 		data = kvm->arch.cur_tsc_write + delta;
 
-		if (!kvm_check_tsc_unstable())
-			offset = kvm->arch.cur_tsc_offset;
-		else
+		/*
+		 * The generation's offset can only be joined by a vCPU which
+		 * scales the TSC by the same ratio it was recorded with; the
+		 * initial generation's offset is recorded at VM creation
+		 * with the default ratio, before any vCPU exists. With a
+		 * different ratio, open a new generation (recording this
+		 * vCPU's own offset) rather than leave the generation's
+		 * ratio and offset describing different scaling domains.
+		 */
+		if (vcpu->arch.l1_tsc_scaling_ratio !=
+		    kvm->arch.cur_tsc_scaling_ratio) {
 			offset = kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
-		matched = true;
+		} else {
+			if (!kvm_check_tsc_unstable())
+				offset = kvm->arch.cur_tsc_offset;
+			else
+				offset = kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
+			matched = true;
+		}
 	}
 
 	__kvm_synchronize_tsc(vcpu, offset, data, ns, matched, user_initiated);
@@ -9645,8 +9659,15 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 		return;
 	vcpu_load(vcpu);
 	kvm_synchronize_tsc(vcpu, NULL, false);
-	if (kvm_check_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu))
+
+	/*
+	 * Refresh the VM-creation masterclock snapshot (see
+	 * kvm_arch_init_vm), synchronously so that it is valid even for
+	 * userspace which queries the clock before ever running a vCPU.
+	 */
+	if (vcpu->vcpu_idx == 0)
 		kvm_update_masterclock(vcpu->kvm, NULL);
+
 	vcpu_put(vcpu);
 
 	/* poll control enabled by default */
@@ -10065,6 +10086,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
 	int ret;
 	unsigned long flags;
+	u64 kvmclock_host_tsc;
+	s64 kvmclock_ns;
 
 	if (!kvm_is_vm_type_supported(type))
 		return -EINVAL;
@@ -10096,9 +10119,13 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	seqcount_raw_spinlock_init(&kvm->arch.pvclock_sc, &kvm->arch.tsc_write_lock);
 	ratelimit_state_init(&kvm->arch.kvmclock_update_rs, HZ, 10);
 	ratelimit_set_flags(&kvm->arch.kvmclock_update_rs, RATELIMIT_MSG_ON_RELEASE);
-	kvm->arch.kvmclock_offset = -get_kvmclock_base_ns();
-	kvm->arch.all_vcpus_matched_freq = true;
 
+	kvm->arch.default_tsc_khz = max_tsc_khz ? : tsc_khz;
+	kvm->arch.apic_bus_cycle_ns = APIC_BUS_CYCLE_NS_DEFAULT;
+	kvm->arch.guest_can_read_msr_platform_info = true;
+	kvm->arch.enable_pmu = enable_pmu && !kvm->arch.has_protected_pmu;
+
+	kvm->arch.all_vcpus_matched_freq = true;
 	/*
 	 * Start with all (zero) vCPUs considered matched, so that a VM whose
 	 * vCPUs never reach kvm_track_tsc_matching() — notably when the guest
@@ -10106,16 +10133,41 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	 * returns early — is still eligible for PVCLOCK_TSC_STABLE_BIT.
 	 */
 	kvm->arch.all_vcpus_matched_tsc = true;
+	kvm->arch.cur_tsc_scaling_ratio = kvm_caps.default_tsc_scaling_ratio;
+	kvm->arch.cur_tsc_khz = kvm->arch.default_tsc_khz;
 
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
+
+	/*
+	 * Establish the initial TSC generation for synchronization logic.
+	 * The first vCPU will sync to this, starting its guest TSC at the
+	 * number of cycles elapsed since VM creation rather than at zero.
+	 * This ensures coherence with the kvmclock epoch (also set here),
+	 * and the master clock snapshot taken below is immediately valid.
+	 * It is refreshed again when the first vCPU is created, in case
+	 * the host clocksource changed (and changed back) in between:
+	 * pvclock_gtod_update_fn() does not notify a VM with no vCPUs.
+	 */
+#ifdef CONFIG_X86_64
+	if (!kvm_get_time_and_clockread(&kvmclock_ns, &kvmclock_host_tsc))
+#endif
+	{
+		/*
+		 * If not simultaneous, we want the TSC to be zero slightly
+		 * *after* the kvmclock is zero.
+		 */
+		kvmclock_ns = get_kvmclock_base_ns();
+		kvmclock_host_tsc = rdtsc();
+	}
+	kvm->arch.cur_tsc_write = 0;
+	kvm->arch.cur_tsc_offset = -(s64)kvmclock_host_tsc;
+	kvm->arch.cur_tsc_nsec = kvmclock_ns;
+	kvm->arch.cur_tsc_generation = 1;
+	kvm->arch.kvmclock_offset = -kvmclock_ns;
+
 	pvclock_update_vm_gtod_copy(kvm);
 	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
 
-	kvm->arch.default_tsc_khz = max_tsc_khz ? : tsc_khz;
-	kvm->arch.apic_bus_cycle_ns = APIC_BUS_CYCLE_NS_DEFAULT;
-	kvm->arch.guest_can_read_msr_platform_info = true;
-	kvm->arch.enable_pmu = enable_pmu && !kvm->arch.has_protected_pmu;
-
 #if IS_ENABLED(CONFIG_HYPERV)
 	spin_lock_init(&kvm->arch.hv_root_tdp_lock);
 	kvm->arch.hv_root_tdp = INVALID_PAGE;
-- 
2.43.0

