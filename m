Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893807;
	b=1KYuxBGHBTa18WkGBWabCBuAuWtjUEvy/ztSnErH43JMeERX/xh1Gx6joQ1hdkXhVuV4
	 Oa4nzmkp+P+Y3YpKLCTZTzBU/ZHNaRWpPjECXSrAESBYV4wI6OSuPDtTuHW7dYZ0htaB1
	 46CAOds8JkzrzzbQMPzNoSE/I9iserhzMb6GHrPrfw5iHfa/PuFgPWfSx8X+Q1MOMxrf0
	 B8v9CvZwc3WMu2mGME1Z3Ij4XD5X56EfdB83AcUr0TNErP9YSBwtkiNaFxVy5nIfqRCTS
	 jtyLi1/CALhjohbofLjeOUxihU6W4qsFSgsdzXXszVDjAJcY9W7Jj7qG/Ljrr/2TOjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893807;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=PsNNUanak/d4Ip+sWO3zx6GqIu3bms014MUP+JVO3iY=;
	b=PBwSVuxHZregOCB0VFzEONRWnrl+7Hkuw36p7dKJ5Rztvz58SQWaV3g8TM6zhtZmPTEC
	 W+W8+0WAFBXjt7xS9h5iA8sMNVnyx4GnupQ6uOB21my7IJIch4FaIVaS9pGZcDZ5eIT/6
	 DQwFk1TxtjAIfnbEgzd0PkjeVuK+Y1i3vipnwZht3gy5gwfUurpiBDmr9EyXq3tXOrG5M
	 CVS9y6KyIqB91ZPDcEB/pZYKmw7NywQ9UYEyHulGjyEEC41hoiauSXlOk7d/Q2c6ze5u+
	 lldGXS1g2VSAvRkDFqHCz4MH8WacWNt80BxKij0CT33v6jVEKFaMeqa+er7egddrT9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b="V5zg/a2M";
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ED96075F40;
	Thu,  5 Nov 2026 15:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2ED96075F40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=V5zg/a2M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=PsNNUanak/d4Ip+sWO3zx6GqIu3bms014MUP+JVO3iY=; b=V5zg/a2McUxPGpSPe2gPv4rXJO
	BSOrVjZhPfRZ8yI8elQVF9/Kh3m/Z7kN4MOfmHFrlJjbAbRm37yL4E6QGYjBvuvmSJhcKUITBX2Sa
	yO8rdAMaH/T90bYnG/LMQobRGdOXzrOMEqMGnECs6g3mcHEiocb66CLidNmcStniAFZLPAgDrx21z
	sL10ehE9FXSCILPtMmJS+s2PqHHAVy3zU+CSBfzkQMeFrWKgsD2yigz+Yh5LvgmJy9ukYUDBvPAvs
	twwBQj5QHxr9rDY7i4AZvTLAGlvBKNNZNuOmt0f3FslzFLi8S98xoDB06BWhU/DdGpRc0+fRJXo1r
	iivu7iXQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOzit-00000009aoh-3ST5;
	Thu, 05 Nov 2026 15:49:55 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOzit-0000000Aayy-2Vph;
	Thu, 05 Nov 2026 15:49:55 +0000
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
Subject: [PATCH v11 04/23] KVM: x86: Allow KVM master clock mode when TSCs are offset from each other
Date: Thu,  5 Nov 2026 07:49:35 -0800
Message-ID: <20261105154955.2525419-5-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Previously, a guest writing different TSC values on different vCPUs could
force KVM out of master clock mode. With this change, only a frequency
mismatch disables master clock. The only ways for non-master-clock mode
to happen now are archaic hardware without a TSC-based clocksource, a
VMM that sets different TSC frequencies across vCPUs, or a guest using
the legacy MSR_KVM_SYSTEM_TIME (which could be addressed in future by
simply updating tsc_timestamp more frequently rather than falling out of
master clock mode entirely).

Running at a different frequency would lead to a systemic skew between
the clock(s) as observed by different vCPUs due to arithmetic precision
in the scaling. So that should indeed force the clock to be based on the
host's CLOCK_MONOTONIC_RAW instead of being in masterclock mode where it
is defined by the guest TSC.

But vCPUs having different TSC *offsets* is not a problem, because the
KVM clock is a single VM-wide nanosecond timeline; only its expression
in TSC cycles is per-vCPU. Each vCPU's pvclock structure is generated by
translating the shared master clock snapshot into that vCPU's own TSC
domain via kvm_read_l1_tsc(), which applies the vCPU's scaling ratio and
offset to the snapshot's tsc_timestamp. When the guest then computes
system_time + (rdtsc - tsc_timestamp) * rate, its own offset is present
in both rdtsc and tsc_timestamp and cancels out: every vCPU reads the
same VM-wide clock from its own pvclock. VM-scoped consumers of the
master clock (KVM_GET_CLOCK, the wall clock epoch, the Xen runstate
times) operate purely in the nanosecond domain, where the per-vCPU
offset never appears at all.

Only two consumers genuinely depend on the TSC offsets matching, and
both are already guarded by PVCLOCK_TSC_STABLE_BIT:

 1. A guest vCPU reading a *sibling* vCPU's pvclock structure with its
    own TSC would compute garbage. This is precisely why commit
    b48aa97e3820 ("KVM: x86: require matched TSC offsets for master clock")
    required matched offsets. But the guest-side guard for it already
    exists: when PVCLOCK_TSC_STABLE_BIT is clear, guests fall back to
    the global last_value monotonicity clamp for cross-vCPU reads.

 2. The Hyper-V TSC page is a single VM-wide {scale, offset} pair which
    every guest vCPU applies to its own rdtsc, so it cannot represent
    divergent offsets. It is self-guarding: compute_tsc_page_parameters()
    refuses to populate the page unless PVCLOCK_TSC_STABLE_BIT is set,
    which forces such guests onto the (nanosecond domain, and thus safe)
    TIME_REF_COUNT MSR instead.

So: use frequency match for master clock eligibility, and full TSC match
(including offset) only for PVCLOCK_TSC_STABLE_BIT, which tells the
guest it is safe to skip cross-vCPU monotonicity enforcement.

Track frequency matching separately from offset matching using a
dedicated freq generation counter (cur_tsc_freq_generation) that only
bumps on actual frequency changes. Each vCPU is counted exactly once per
freq generation via a per-vCPU this_tsc_freq_generation field, preventing
repeated syncs of the same vCPU from falsely re-enabling master clock.

Note that the generation-based counting has a known limitation: if all
vCPUs are in sync and one changes away and then back again, the other
vCPUs are still at the old generation and won't be counted until they
sync again (which may never happen). This was always the case for the
offset tracking and isn't expected VMM behaviour — although it is the
scenario that the VM-wide KVM_SET_TSC_KHZ ioctl was introduced to handle
cleanly.

While at it, restructure the existing TSC offset generation tracking to
use the same pattern: reset counter to zero on new generation, then
unconditionally count vCPUs that haven't been seen in this generation.
Both counters now use a consistent >= online_vcpus threshold (1-based
counting where the reference vCPU is included in the count).

The divergent-offset behaviour is exercised by pvclock_migration_test,
which runs vCPUs with TSCs offset by ±0.5-1s from each other and
verifies that the master clock survives, that PVCLOCK_TSC_STABLE_BIT is
cleared, and that all vCPUs nevertheless agree on the KVM clock to
within a nanosecond, before and after a simulated live migration.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |  4 ++
 arch/x86/kvm/x86.c              | 88 ++++++++++++++++++++++++++-------
 2 files changed, 73 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1efca01647d2..30e89e8fb975 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -887,6 +887,7 @@ struct kvm_vcpu_arch {
 	u64 this_tsc_nsec;
 	u64 this_tsc_write;
 	u64 this_tsc_generation;
+	u64 this_tsc_freq_generation;
 	bool tsc_catchup;
 	bool tsc_always_catchup;
 	s8 virtual_tsc_shift;
@@ -1243,6 +1244,9 @@ struct kvm_arch {
 	u64 cur_tsc_offset;
 	u64 cur_tsc_generation;
 	bool all_vcpus_matched_tsc;
+	bool all_vcpus_matched_freq;
+	int nr_vcpus_matched_freq;
+	u64 cur_tsc_freq_generation;
 	int nr_vcpus_matched_tsc;
 
 	u32 default_tsc_khz;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ec8693f4827f..38fcb1d75661 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1114,30 +1114,63 @@ static inline bool gtod_is_based_on_tsc(int mode)
 }
 #endif
 
-static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool new_generation)
+static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool update_mclock)
 {
 #ifdef CONFIG_X86_64
 	struct kvm_arch *ka = &vcpu->kvm->arch;
 	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
+	bool prev_matched_tsc = ka->all_vcpus_matched_tsc;
 
 	/*
-	 * To use the masterclock, the host clocksource must be based on TSC
-	 * and all vCPUs must have matching TSCs.  Note, the count for matching
-	 * vCPUs doesn't include the reference vCPU, hence "+1".
+	 * Track whether all vCPUs have matching TSC offsets (for
+	 * PVCLOCK_TSC_STABLE_BIT) and matching frequencies (for
+	 * master clock eligibility).
+	 */
+
+	/*
+	 * A new vCPU might already have incremented ->online_vcpus
+	 * and cause a temporary false negative here. But will then
+	 * call kvm_synchronize_tsc() from kvm_arch_vcpu_postcreate()
+	 * and finish the job.
+	 */
+	int online = atomic_read(&vcpu->kvm->online_vcpus);
+	/*
+	 * WRITE_ONCE() pairs with the READ_ONCE() in kvm_guest_time_update(),
+	 * which samples the flag locklessly (outside both tsc_write_lock and
+	 * its pvclock seqcount read section); the race is benign (a stale
+	 * value merely delays the PVCLOCK_TSC_STABLE_BIT broadcast to the
+	 * masterclock update which is requested below).
 	 */
-	ka->all_vcpus_matched_tsc = (ka->nr_vcpus_matched_tsc + 1 ==
-				     atomic_read(&vcpu->kvm->online_vcpus));
+	WRITE_ONCE(ka->all_vcpus_matched_tsc,
+		   ka->nr_vcpus_matched_tsc >= online);
 
-	bool use_master_clock = ka->all_vcpus_matched_tsc &&
+	update_mclock |= (prev_matched_tsc != ka->all_vcpus_matched_tsc);
+
+	/*
+	 * all_vcpus_matched_freq starts true and is cleared when
+	 * __kvm_synchronize_tsc() detects a frequency mismatch.
+	 * Re-enable when all vCPUs have synced with matching frequency.
+	 * If all offsets also match, that implies frequencies match too.
+	 */
+	if (ka->all_vcpus_matched_tsc ||
+	    ka->nr_vcpus_matched_freq >= online)
+		ka->all_vcpus_matched_freq = true;
+
+	/*
+	 * To use the masterclock, the host clocksource must be based on TSC
+	 * and all vCPUs must have matching TSC *frequency*. Different offsets
+	 * are fine — each vCPU's pvclock has its own tsc_timestamp that
+	 * accounts for its offset.
+	 */
+	bool use_master_clock = ka->all_vcpus_matched_freq &&
 				gtod_is_based_on_tsc(gtod->clock.vclock_mode);
 
 	/*
-	 * Request a masterclock update if the masterclock needs to be toggled
-	 * on/off, or when starting a new generation and the masterclock is
-	 * enabled (compute_guest_tsc() requires the masterclock snapshot to be
-	 * taken _after_ the new generation is created).
+	 * Request a masterclock update if needed: toggling master clock,
+	 * new generation requiring a fresh snapshot, or a change in
+	 * all_vcpus_matched_tsc (to broadcast PVCLOCK_TSC_STABLE_BIT).
 	 */
-	if ((ka->use_master_clock && new_generation) ||
+	if ((ka->use_master_clock && update_mclock) ||
 	    (ka->use_master_clock != use_master_clock))
 		kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
 
@@ -1339,7 +1372,22 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 	 * Track the TSC frequency, scaling ratio, and offset for the current
 	 * generation. These are used to detect matching TSC writes and to
 	 * compute the guest TSC from the host clock.
+	 *
+	 * If the frequency changed, master clock mode can no longer be used
+	 * since the kvmclock scaling factors differ between vCPUs.
 	 */
+	if (vcpu->arch.virtual_tsc_khz != kvm->arch.cur_tsc_khz) {
+		kvm->arch.cur_tsc_freq_generation++;
+		kvm->arch.all_vcpus_matched_freq = false;
+		kvm->arch.nr_vcpus_matched_freq = 0;
+	}
+
+	/* Count each vCPU once per freq generation */
+	if (vcpu->arch.this_tsc_freq_generation != kvm->arch.cur_tsc_freq_generation) {
+		vcpu->arch.this_tsc_freq_generation = kvm->arch.cur_tsc_freq_generation;
+		kvm->arch.nr_vcpus_matched_freq++;
+	}
+
 	kvm->arch.cur_tsc_khz = vcpu->arch.virtual_tsc_khz;
 	kvm->arch.cur_tsc_scaling_ratio = vcpu->arch.l1_tsc_scaling_ratio;
 
@@ -1365,17 +1413,18 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 		 * exact software computation in compute_guest_tsc()
 		 */
 		kvm->arch.cur_tsc_generation++;
+		WRITE_ONCE(kvm->arch.all_vcpus_matched_tsc, false);
+		kvm->arch.nr_vcpus_matched_tsc = 0;
 		kvm->arch.cur_tsc_nsec = ns;
 		kvm->arch.cur_tsc_write = tsc;
 		kvm->arch.cur_tsc_offset = offset;
-		kvm->arch.nr_vcpus_matched_tsc = 0;
-		kvm->arch.all_vcpus_matched_tsc = false;
-	} else if (vcpu->arch.this_tsc_generation != kvm->arch.cur_tsc_generation) {
+	}
+
+	if (vcpu->arch.this_tsc_generation != kvm->arch.cur_tsc_generation) {
+		vcpu->arch.this_tsc_generation = kvm->arch.cur_tsc_generation;
 		kvm->arch.nr_vcpus_matched_tsc++;
 	}
 
-	/* Keep track of which generation this VCPU has synchronized to */
-	vcpu->arch.this_tsc_generation = kvm->arch.cur_tsc_generation;
 	vcpu->arch.this_tsc_nsec = kvm->arch.cur_tsc_nsec;
 	vcpu->arch.this_tsc_write = kvm->arch.cur_tsc_write;
 
@@ -1594,7 +1643,7 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 	bool host_tsc_clocksource, vcpus_matched;
 
 	lockdep_assert_held(&kvm->arch.tsc_write_lock);
-	vcpus_matched = ka->all_vcpus_matched_tsc;
+	vcpus_matched = ka->all_vcpus_matched_freq;
 
 	/*
 	 * If the host uses TSC clock, then passthrough TSC as stable
@@ -1922,7 +1971,7 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 
 	/* If the host uses TSC clocksource, then it is stable */
 	hv_clock.flags = 0;
-	if (use_master_clock)
+	if (use_master_clock && READ_ONCE(ka->all_vcpus_matched_tsc))
 		hv_clock.flags |= PVCLOCK_TSC_STABLE_BIT;
 
 	if (vcpu->pv_time.active) {
@@ -10008,6 +10057,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	ratelimit_state_init(&kvm->arch.kvmclock_update_rs, HZ, 10);
 	ratelimit_set_flags(&kvm->arch.kvmclock_update_rs, RATELIMIT_MSG_ON_RELEASE);
 	kvm->arch.kvmclock_offset = -get_kvmclock_base_ns();
+	kvm->arch.all_vcpus_matched_freq = true;
 
 	/*
 	 * Start with all (zero) vCPUs considered matched, so that a VM whose
-- 
2.43.0

