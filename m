Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187281;
	b=ALZUDs8shaBldZ5AZn7ltr3BySqS6uSNQuMKJmLHBXgMmnfmIlEdXFoG1L4WdFU7eCQU
	 htBPwX06ZX8W+P7KBD2vbHkFGg5cePmVz9a3gktMMyzyf2lbIedlFccsYf5pHtFYfxVRf
	 Ud2PUpWmgJsG1MuDgOANtq3Y6Rgg8Y2x9QLDy0k4lTk3htVEyxRzfslR+FXoXcNjv1BiB
	 K3FsdJyFukyvMwNXq643iJwwT044jOuo3N37g99Ot9WjdCw+MW10Jynq0GVhdLO+Sxi5n
	 M2OkYXAp5AHiNvjc9PvhN0AWbW2NtuQCRXHbhVLbz2aTV/kOMj2MRrmp7WaLvLJyFSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187281;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=x2cWMj9WiYqQR5jvKxIauctxP6zgmcEZRuqoi93OgNo=;
	b=3G260ivEEm2LECgySW+n/paP2DB4IdMu/gezA7q+jrb1qVRwhOjWrisxhqiLJjrSuuEi
	 TggzXJzwwbxUJoSCAhSYybV+ZHrYwFbDuNr8JZagBfeBOZged/VcJaGaGzHrz3Z1Y3a2n
	 KeQRCkC+Bckovx5xlf32ZPKqEQNxnRR1T3HmLnTIUE2DjY5TK10ENnCb+pwH1ejNcpC4N
	 vd24ckalgNUA0btNfNIVYVKreLDQHgtDadsnvltOAKe9AV8y/YifGP8d44DanbJkue0mX
	 CdBZGw+CCsL16Rw0JUk1Gabb8GwyeXC6lP9AqhMLCxopPq4uT0aeGJVSqOo3xgTPR3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=r21KepbX;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71421606A326;
	Mon,  9 Nov 2026 01:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71421606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=r21KepbX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=x2cWMj9WiYqQR5jvKxIauctxP6zgmcEZRuqoi93OgNo=; b=r21KepbXGr+sreolwVzbxkkEi4
	ZnboupnRaqIwbQvq2MajhOBtM/PlgSlwIbc99bsloAbeDBkpXOITSRdlmQ01B8qVH4MTfMLJTSXi2
	b8W66m97BlWkdl27niGC+1EY/Uo8fU38xUdcnx7G03/CaLzVQF6SbpvFpeOyFd4f2eEUNSw9NBmYP
	qqhKPB8M+I/FKqiUWzfWMqPLqrW8ribTgyCLTiwRRQjS3CS60XcJVA7ywwRPmSm111nP0YRiIotOK
	mLqQj4JDgIjjYYuVPYDoo2VaL8Z7pxbBjyqYKnE2QUxURow+BiX19rOuFTlaGK57wZqe6A1heJjYL
	rQGzE7cA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQE4P-00000007Pvz-0R7n;
	Mon, 09 Nov 2026 01:21:13 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xQE4O-0000000EKUl-3rft;
	Mon, 09 Nov 2026 01:21:12 +0000
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
Subject: [PATCH v12 11/24] KVM: x86: Activate master clock from kvm_arch_init_vm()
Date: Sun,  8 Nov 2026 17:20:57 -0800
Message-ID: <20261109012112.3415328-12-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109012112.3415328-1-dwmw2@infradead.org>
References: <20261109012112.3415328-1-dwmw2@infradead.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

Initialize the TSC generation and master clock state at VM creation
time, rather than relying on kvm_update_masterclock() from
kvm_arch_vcpu_postcreate().

Set cur_tsc_generation=1, cur_tsc_offset, cur_tsc_nsec and
kvmclock_offset from an atomic ktime/TSC snapshot. This establishes a
coherent epoch so that:

 - pvclock_update_vm_gtod_copy() succeeds immediately.
 - KVM_GET_CLOCK returns valid {host_tsc, realtime} fields as soon
   as the VM is created.
 - KVM_[GS]ET_CLOCK_GUEST works without a prior KVM_RUN.
 - No O(N) iteration of all vCPUs on each vCPU creation.

The initial generation is deliberately not matchable: cur_tsc_khz is
left at zero, which no vCPU frequency ever equals, so the first vCPU
opens its own generation with its TSC starting at zero as it always
has. Letting it match the VM-creation generation would silently change
guest-visible behaviour (a first-vCPU TSC equal to the host cycles
elapsed since KVM_CREATE_VM, over an unbounded window), and would hand
the first vCPU a stale offset when a host suspend resets the TSC
before any vCPU exists, since the backwards-TSC compensation in
kvm_arch_enable_virtualization_cpu() detects the reset only through
existing vCPUs.

The same no-vCPU suspend window can leave the master snapshot itself
stale: nothing refreshes it, as pvclock_gtod_update_fn() also iterates
vCPUs, and the post-reset host TSC may read below master_cycle_now
(underflowing the delta), or — given enough uptime before the suspend,
or a firmware re-init to an arbitrary value — above it, silently
dropping the sleep period. Make __get_kvmclock_master_clock() fall
back to the raw clock whenever the elapsed time computed from the
snapshot disagrees with the raw clock by more than a second, instead
of returning a discontinuity flagged as KVM_CLOCK_TSC_STABLE.

A masterclock refresh is still performed in postcreate (synchronously,
so that it is valid even for userspace which queries the clock before
ever running a vCPU) when the first vCPU is created, since the
VM-creation snapshot can go stale while the VM has no vCPUs: a
clocksource change notifies only VMs with vCPUs, and a change back to
TSC leaves nothing to disagree with the stale snapshot. The same call
services a KVM_REQ_MASTERCLOCK_UPDATE that the postcreate
synchronization raised on any later vCPU, which would otherwise wait
until that vCPU first entered the guest while KVM_GET_CLOCK observed
the stale state.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 109 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 92 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a357efbf1d94..4afafe7ed8b8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1583,6 +1583,14 @@ static void kvm_synchronize_tsc_at(struct kvm_vcpu *vcpu, u64 *value,
 
 		data = kvm->arch.cur_tsc_write + delta;
 
+		/*
+		 * The generation's offset can be reused directly: it is in
+		 * this vCPU's scaling domain, because every generation is
+		 * opened by a vCPU (the initial VM-creation generation is
+		 * not matchable) and set_tsc_khz() derives the scaling
+		 * ratio deterministically from the kHz value, so two vCPUs
+		 * at the same frequency carry the same ratio.
+		 */
 		if (!kvm_check_tsc_unstable())
 			offset = kvm->arch.cur_tsc_offset;
 		else
@@ -1902,6 +1910,7 @@ static bool __get_kvmclock_master_clock(struct kvm *kvm,
 	struct kvm_arch *ka = &kvm->arch;
 	struct pvclock_vcpu_time_info hv_clock;
 	struct timespec64 ts;
+	u64 clock;
 
 	if (!ka->use_master_clock)
 		return false;
@@ -1909,10 +1918,6 @@ static bool __get_kvmclock_master_clock(struct kvm *kvm,
 	if (!kvm_get_walltime_and_clockread(&ts, &data->host_tsc))
 		return false;
 
-	data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
-	data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC |
-		       KVM_CLOCK_TSC_STABLE;
-
 	hv_clock.tsc_timestamp = ka->master_cycle_now;
 	hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
 
@@ -1927,13 +1932,34 @@ static bool __get_kvmclock_master_clock(struct kvm *kvm,
 		u64 tsc_delta = data->host_tsc - ka->master_cycle_now;
 
 		tsc_delta = kvm_scale_tsc(tsc_delta, ka->master_tsc_scaling_ratio);
-		data->clock = hv_clock.system_time +
-			      pvclock_scale_delta(tsc_delta,
-						  hv_clock.tsc_to_system_mul,
-						  hv_clock.tsc_shift);
+		clock = hv_clock.system_time +
+			pvclock_scale_delta(tsc_delta,
+					    hv_clock.tsc_to_system_mul,
+					    hv_clock.tsc_shift);
 	} else {
-		data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
+		clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
 	}
+
+	/*
+	 * Sanity-check the snapshot: if the elapsed time it computes from
+	 * the host TSC disagrees with the raw clock by more than a second,
+	 * the TSC was reset (suspend/resume — possibly re-inited by
+	 * firmware to an arbitrary value, including an underflowing one
+	 * below master_cycle_now) while nothing refreshed the snapshot.
+	 * That can happen while the VM has no vCPUs, since both the
+	 * resume compensation and the clocksource notifier work through
+	 * vCPUs. Use the fallback clock rather than returning a
+	 * discontinuity flagged KVM_CLOCK_TSC_STABLE.
+	 */
+	if (unlikely(abs((s64)(clock - hv_clock.system_time) -
+			 (get_kvmclock_base_ns() - ka->master_kernel_ns)) >
+		     NSEC_PER_SEC))
+		return false;
+
+	data->clock = clock;
+	data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
+	data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC |
+		       KVM_CLOCK_TSC_STABLE;
 	return true;
 #else
 	return false;
@@ -9782,8 +9808,19 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 	}
 	vcpu_load(vcpu);
 	kvm_synchronize_tsc(vcpu, NULL, false);
-	if (kvm_check_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu))
+
+	/*
+	 * Refresh the VM-creation masterclock snapshot (see
+	 * kvm_arch_init_vm), synchronously so that it is valid even for
+	 * userspace which queries the clock before ever running a vCPU.
+	 * Likewise service any masterclock update the synchronization
+	 * above requested on this vCPU, which would otherwise languish
+	 * until it first enters the guest.
+	 */
+	if (kvm_check_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu) ||
+	    vcpu->vcpu_idx == 0)
 		kvm_update_masterclock(vcpu->kvm, NULL);
+
 	vcpu_put(vcpu);
 
 	/* poll control enabled by default */
@@ -10222,6 +10259,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
 	int ret;
 	unsigned long flags;
+	u64 kvmclock_host_tsc;
+	s64 kvmclock_ns;
 
 	if (!kvm_is_vm_type_supported(type))
 		return -EINVAL;
@@ -10253,9 +10292,13 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
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
@@ -10271,14 +10314,46 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm->arch.cur_tsc_scaling_ratio = kvm_caps.default_tsc_scaling_ratio;
 
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
+
+	/*
+	 * Establish an initial TSC generation so that the master clock
+	 * snapshot taken below is immediately valid and KVM_GET_CLOCK
+	 * works before any vCPU exists. The snapshot is refreshed again
+	 * when the first vCPU is created, in case the host clocksource
+	 * changed (and changed back) in between: pvclock_gtod_update_fn()
+	 * does not notify a VM with no vCPUs.
+	 *
+	 * This generation is deliberately not matchable: cur_tsc_khz is
+	 * left at zero, which no vCPU frequency ever equals, so the first
+	 * vCPU opens its own generation with its TSC starting at zero,
+	 * exactly as it always has. Letting it match would make the first
+	 * vCPU's TSC start at the cycles elapsed since KVM_CREATE_VM — a
+	 * silent guest-visible change over an unbounded window — and
+	 * would hand it this offset verbatim even when a host suspend
+	 * reset the TSC in between, since the backwards-TSC compensation
+	 * in kvm_arch_enable_virtualization_cpu() detects the jump only
+	 * through existing vCPUs.
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

