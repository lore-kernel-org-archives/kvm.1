Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420569;
	b=IpAccqjoqOYTx0qjgLVOZ9MOZtiAkwSxeYSbduBVMiasPdrHoBJrCrFWUFtm2QMZ2Gf/
	 eLOgHJEgziVuOw0ZryMRAT3QifRb1VafNeki8oha+Pj6xhrMOI2CQMyv9cbq8ZU7eZDK3
	 Q1jK38exolqW5fuoSx+bcK0kd3YopapLrH61GDOCuSEGjwbbGEf+4JId5h2W6H+1+SE2z
	 KA7vvsVWqrMKnVoLrCIibQh1qcbpz55uRdHWd0lEhNL4xO3IMSf+2T+c93aYcQYCWfMuU
	 CcYy3TGkv0fLa9iIb3NrZldGRO1Wekp4HeqIjducw00BK8r+aJvvRpBXw8uOXLQvgEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420569;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=v6POo5WP+PNPDJb/ry79fmZWrQ0aM5wkY7uHVd2gmJo=;
	b=Yxqt/JMItK/3dCqO4i3DB5IeinxOkt0UE091NfdQTrvTopp5dZVKvimvXWrgfXTeloxY
	 OZh09z7VcCgwokOXDZsnEfhBSDmwF/taAT7sD9sJiDlTEXS534CSJOrCcE9dcSValaZ8G
	 lRyIKJIeEmfd1K8lCiHN6/z7Iek/15GjKM/hG+0XjZvDN1FFKNMlrx7BNGXU5AAoKrxpn
	 ExrRlpRpIABQCbWX2jn6pih0viId/i/6TFe/yLfQ0F8CYF3XlTZz2Uu01ub9TBRfLflfm
	 O05fGraaBO57T4KObQhH7Bb9ke31lJZafe+iYwH8Wg1gznPHCmHAtLLdJRi5/5lYC0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b="P/tBGnHf";
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47D7606A327;
	Wed, 11 Nov 2026 18:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E47D7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=P/tBGnHf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=v6POo5WP+PNPDJb/ry79fmZWrQ0aM5wkY7uHVd2gmJo=; b=P/tBGnHfKF5svGir+qjlztjv1z
	CyFpjRo5H3HjKmEWpG82+3UzHoPSVY/1uMpZxL3aLO54K8crHgo+wi3+I/2bUWUEnTC5UDLs7WAi2
	la5cRCVMVm3Ij1csHPPX82Oq7sdJP1BhDBvGAH/4BH7f2/lLp16Ju4i0sYgPwXTISUCsTLi97O4qi
	2IlVffMwxE+GcptAjNKEs5JXsM5Q41kDbLdk0FJW1lEr41k/e+RJgFWCnuwxo7ZPHi4w0js7BFnIT
	C1XNqCU8q3hrQWICjJWiHoJRpT3i+5eF+TX+Nm5ZdBP3hnTycBrrqnz4nA/WisGE8gyWKAE9E4gWR
	U0DFDiBQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRCl9-0000000CKvd-28xR;
	Wed, 11 Nov 2026 18:09:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRCl9-0000000HWsq-1JLC;
	Wed, 11 Nov 2026 18:09:23 +0000
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
Subject: [PATCH v13 13/26] KVM: x86: Keep the master clock trustworthy while the VM has no vCPUs
Date: Wed, 11 Nov 2026 10:09:09 -0800
Message-ID: <20261111180922.4177927-14-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111180922.4177927-1-dwmw2@infradead.org>
References: <20261111180922.4177927-1-dwmw2@infradead.org>
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

The master clock snapshot is taken at VM creation and, now that it no
longer requires matched vCPU TSCs, is active from that moment:
KVM_GET_CLOCK returns valid {host_tsc, realtime} fields before any
vCPU is created, as will KVM_[GS]ET_CLOCK_GUEST later in this series.
But nothing yet defends that snapshot through the window in which the
VM has no vCPUs.

Sample kvmclock_offset inside the tsc_write_lock section, immediately
adjacent to the snapshot it will forever be combined with, so the
kvmclock epoch is anchored to the same instant rather than to some
earlier point the task was preempted at.

No TSC generation is established at VM creation: cur_tsc_khz stays
zero, which no vCPU frequency ever equals, so the first vCPU opens its
own generation with its TSC starting at zero, as it always has. A
matchable VM-creation generation would be a silent guest-visible
change (a first-vCPU TSC equal to the host cycles elapsed since
KVM_CREATE_VM), and would hand the first vCPU a stale offset when a
host suspend resets the TSC before any vCPU exists — the backwards-TSC
compensation detects the reset only through existing vCPUs.

The same no-vCPU suspend window can leave the snapshot itself stale:
nothing refreshes it (pvclock_gtod_update_fn() also iterates vCPUs),
and the post-reset host TSC may read below master_cycle_now,
underflowing the delta, or above it, silently dropping the sleep
period. Make __get_kvmclock_master_clock() fall back to the raw clock
when the snapshot disagrees with it by more than a second — both sides
computed from one coherent {ns, TSC} sample, so a reader preempted
mid-ioctl cannot fake a discrepancy — but only while the VM still has
no vCPUs: the raw clock's and the masterclock's multipliers quantize
the frequency ~0.1ppm apart, which would trip the threshold after a
few months of an undisturbed snapshot and make the host-side clock
jump while the guest's pvclock sails on.

Finally, make the masterclock refresh in kvm_arch_vcpu_postcreate()
unconditional and synchronous for the first vCPU, so the snapshot is
valid even for userspace which queries the clock before ever running
a vCPU: a clocksource change notifies only VMs with vCPUs, and a
change back to TSC leaves nothing to disagree with the stale snapshot.
The same call services a KVM_REQ_MASTERCLOCK_UPDATE raised by any
later vCPU's postcreate synchronization, which would otherwise wait
until that vCPU first entered the guest.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 120 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 103 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bd82c9b38233..743da71cd84d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1716,6 +1716,14 @@ static void __kvm_synchronize_tsc_at(struct kvm_vcpu *vcpu, u64 *value,
 		else
 			data = kvm->arch.cur_tsc_write + elapsed_cycles;
 
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
@@ -2107,6 +2115,7 @@ static bool __get_kvmclock_master_clock(struct kvm *kvm,
 	struct kvm_arch *ka = &kvm->arch;
 	struct pvclock_vcpu_time_info hv_clock;
 	struct timespec64 ts;
+	u64 clock;
 
 	if (!ka->use_master_clock)
 		return false;
@@ -2114,10 +2123,6 @@ static bool __get_kvmclock_master_clock(struct kvm *kvm,
 	if (!kvm_get_walltime_and_clockread(&ts, &data->host_tsc))
 		return false;
 
-	data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
-	data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC |
-		       KVM_CLOCK_TSC_STABLE;
-
 	hv_clock.tsc_timestamp = ka->master_cycle_now;
 	hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
 
@@ -2132,13 +2137,63 @@ static bool __get_kvmclock_master_clock(struct kvm *kvm,
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
+	}
+
+	/*
+	 * While the VM has no vCPUs, nothing can refresh the snapshot
+	 * after a host suspend resets the TSC (both the resume
+	 * compensation and the clocksource notifier work through vCPUs),
+	 * and firmware may re-init the TSC to an arbitrary value —
+	 * including one below master_cycle_now, which would underflow the
+	 * delta. Sanity-check the snapshot against the raw clock in that
+	 * window, and use the fallback clock rather than return a
+	 * discontinuity flagged KVM_CLOCK_TSC_STABLE. Both sides of the
+	 * comparison derive from one coherent {ns, TSC} sample, so a
+	 * preempted reader cannot fake a discrepancy. (A reader racing
+	 * the first vCPU's creation can see online_vcpus already raised
+	 * before the postcreate refresh has run and skip the check
+	 * against a still-stale snapshot; that narrow window existed in
+	 * full before the check did.) Once vCPUs exist
+	 * the check must not run: the raw clock's and the masterclock's
+	 * multipliers quantize the frequency differently, drifting apart
+	 * by ~0.1ppm, which would trip a 1-second threshold after a few
+	 * months of an undisturbed snapshot and make the host-side clock
+	 * jump while the guest's pvclock sails on. A VM genuinely parked
+	 * with no vCPUs for those months serves the fallback clock from
+	 * then on — the conservative direction for a snapshot that old.
+	 */
+	if (unlikely(!atomic_read(&kvm->online_vcpus))) {
+		u64 chk_tsc, delta;
+		s64 chk_ns, diff;
+
+		if (!kvm_get_time_and_clockread(&chk_ns, &chk_tsc))
+			return false;
+
+		delta = chk_tsc - ka->master_cycle_now;
+		if (kvm_caps.has_tsc_control)
+			delta = kvm_scale_tsc(delta,
+					      ka->master_tsc_scaling_ratio);
+		/*
+		 * Two-sided compare rather than abs(): abs(S64_MIN) is
+		 * S64_MIN again, which would fail open on that one value.
+		 */
+		diff = (s64)pvclock_scale_delta(delta, ka->master_tsc_mul,
+						ka->master_tsc_shift) -
+		       (s64)(chk_ns - ka->master_kernel_ns);
+		if (diff > (s64)NSEC_PER_SEC || diff < -(s64)NSEC_PER_SEC)
+			return false;
 	}
+
+	data->clock = clock;
+	data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
+	data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC |
+		       KVM_CLOCK_TSC_STABLE;
 	return true;
 #else
 	return false;
@@ -10039,8 +10094,19 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
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
@@ -10510,9 +10576,13 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
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
@@ -10529,14 +10599,30 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm->arch.cur_tsc_scaling_ratio = kvm_caps.default_tsc_scaling_ratio;
 
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
+
+	/*
+	 * Take the master clock snapshot now, so that KVM_GET_CLOCK works
+	 * before any vCPU exists. It is refreshed again when the first
+	 * vCPU is created, in case the host clocksource changed (and
+	 * changed back) in between: pvclock_gtod_update_fn() does not
+	 * notify a VM with no vCPUs.
+	 *
+	 * No TSC generation is established here: cur_tsc_khz stays zero,
+	 * which no vCPU frequency ever equals, so the first vCPU opens
+	 * its own generation with its TSC starting at zero, exactly as
+	 * it always has. Letting it match a VM-creation generation would
+	 * make the first vCPU's TSC start at the cycles elapsed since
+	 * KVM_CREATE_VM — a silent guest-visible change over an unbounded
+	 * window — and would hand it a stale offset when a host suspend
+	 * reset the TSC in between, since the backwards-TSC compensation
+	 * in kvm_arch_enable_virtualization_cpu() detects the jump only
+	 * through existing vCPUs.
+	 */
+	kvm->arch.kvmclock_offset = -get_kvmclock_base_ns();
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

