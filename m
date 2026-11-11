Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420578;
	b=qNzOVoKoI1UkFKkOeZJLDJv5QLhYwNQyQgholTud4EVs9D7cas/isvqVAd9YyIEos6Wa
	 KN2Csu4/hKjAhRLmfENUX1dGTmQnVjceKLl34XmBEtPakVpEQ8Uxf5kJ7K86d3oxtzWkk
	 Q7d6zNpfkznsWM5ZhTA64Sm3UPQsINfJptYercOTETST+Pqk0Sv/L45RfVKVWQQ1ild+s
	 dGyl2Q2qLIzYzaLzX8ZsOrCn3f2ASSLNM4aQSha6jZcfh9o67NOSXitsNhlR7/bsKsKUN
	 pmY6rDHA+ijd5IIA2mLYqlh/IgGbNvorWNRIsr52dwalT5bs3x36IAxGy9/F9HuSpbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420578;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=7860VVsdgmRTVktOXOczaQdZ/+pZ2nlkrneJWnbeC7Y=;
	b=kOZcwwTe11WdA85vWotx2/wgn4MbOX8ak93x3h+HA+wbwFk4y0d6V5/0QIqJxaViinzL
	 eX8gNNfkVRsMq+IIYmAA2ezumWB6cXvZcGMMrdge3Suaqg2gH459uSCu+LSU7/CM9/8hq
	 8zW0bzOI0S5gAYreghKSC4p1WGrdvSHZaVNVeMEhrqsBkKQhPtytWIhHzjk1c2AwvMvri
	 t5eqTGFZY+VWymQa6TSxTo6tPqN5+a1YxwhrDorGT2ON1o6Pkq1J2jFDE6vdYbUaORyD5
	 D2UfvDvgAPdTOKhSa9SXDbMOBrFjuF6Qh+087cGQPsm2CzIwzrqrkyZYa2FSCd/aBBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=XG0I5LbO;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378C0606B787;
	Wed, 11 Nov 2026 18:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 378C0606B787
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=XG0I5LbO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=7860VVsdgmRTVktOXOczaQdZ/+pZ2nlkrneJWnbeC7Y=; b=XG0I5LbO9aCFfF5PZQXZrXcbm9
	LQug70qZeG7myxwI7QWolh0b1turCyMli0kb9eh8laEQTZG01lku869ILrEbZwXHJJhcvEqlEun2G
	Zt46yZPiAbMVWbYaf7s9MyX0AynDIITUyhozqZBHZt5KRaUrQ8u0MdiiU9Ax+3eaUqhs9XJEoJPPr
	ZA874mFSl6srO2uFELT/gzw+HTHGfbwmYT5twEBSRz4+Ik7pS9+/408yVIx9F8181D8BjxNIhrcFt
	v5Y0cPY8GA19hqhF4vBuRleOntvHKFiTCtw+w1sqpEBBcnhUCPAC+bHMrhmfoK4Svm72F1Vtk0N4e
	dgatJpsQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRClB-00000009PvK-3CUO;
	Wed, 11 Nov 2026 18:09:25 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRCl8-0000000HWsG-3k8f;
	Wed, 11 Nov 2026 18:09:22 +0000
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
Subject: [PATCH v13 04/26] KVM: x86: Allow KVM master clock mode when TSCs are offset from each other
Date: Wed, 11 Nov 2026 10:09:00 -0800
Message-ID: <20261111180922.4177927-5-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Previously, a guest writing different TSC values on different vCPUs could
force KVM out of master clock mode. With this change, only a frequency
mismatch disables master clock. The only ways for non-master-clock mode
to happen now are archaic hardware without a TSC-based clocksource, a
VMM that sets different TSC frequencies across vCPUs, or a guest using
the legacy MSR_KVM_SYSTEM_TIME (addressed later in this series).

Running at a different frequency leads to systemic skew between the
clocks observed by different vCPUs, due to arithmetic precision in the
scaling, so that should indeed force the clock back onto the host's
CLOCK_MONOTONIC_RAW. But divergent TSC *offsets* are not a problem: the
KVM clock is a single VM-wide nanosecond timeline, and only its
expression in TSC cycles is per-vCPU. Each vCPU's pvclock structure is
generated by translating the shared master snapshot into that vCPU's
own TSC domain via kvm_read_l1_tsc(), so when the guest computes
system_time + (rdtsc - tsc_timestamp) * rate, its own offset is present
in both rdtsc and tsc_timestamp and cancels out. VM-scoped consumers
(KVM_GET_CLOCK, the wall clock epoch, the Xen runstate times) operate
purely in the nanosecond domain, where the offset never appears.

Only two consumers genuinely depend on the TSC offsets matching, and
both are already guarded by PVCLOCK_TSC_STABLE_BIT:

 1. A guest vCPU reading a *sibling* vCPU's pvclock structure with its
    own TSC would compute garbage — precisely why commit b48aa97e3820
    ("KVM: x86: require matched TSC offsets for master clock") required
    matched offsets. But when PVCLOCK_TSC_STABLE_BIT is clear, guests
    already fall back to the global last_value monotonicity clamp.

 2. The Hyper-V TSC page is a single VM-wide {scale, offset} pair, so
    it cannot represent divergent offsets. It is self-guarding:
    compute_tsc_page_parameters() refuses to populate the page unless
    PVCLOCK_TSC_STABLE_BIT is set, forcing such guests onto the (safe,
    nanosecond domain) TIME_REF_COUNT MSR.

So: frequency match gates master clock eligibility, and the full TSC
match (including offset) gates only PVCLOCK_TSC_STABLE_BIT, which tells
the guest it may skip cross-vCPU monotonicity enforcement.

Frequency matching is tracked with a dedicated generation counter
(cur_tsc_freq_generation) which bumps only on actual frequency changes;
each vCPU is counted once per generation via this_tsc_freq_generation.
The existing offset tracking is restructured to the same pattern, and
both counters use a consistent >= online_vcpus threshold. A vCPU set
to a different frequency and back opens a new generation each time,
and its siblings are only counted back in as they synchronize — the
migration procedure sets every vCPU, which re-latches the match as the
last one lands; frequency excursions on a subset of vCPUs are not
free, by design.

A protected vCPU's synchronization returns before
kvm_track_tsc_matching(), the only other place the match is re-latched,
so its branch re-latches the frequency match itself — the first vCPU's
own bump against the zero initial cur_tsc_khz would otherwise clear it
for the life of the VM — and raises KVM_REQ_MASTERCLOCK_UPDATE on the
transition back to matched, since no later synchronization ever runs
for a protected guest to repair a refresh taken in the window.

KVM_SET_TSC_KHZ on a vCPU which has already run does not pass through
__kvm_synchronize_tsc(), so at this point in the series it leaves the
frequency-match state stale, exactly as it previously left the offset
match stale; the later patch "KVM: x86: Re-synchronize TSC after
KVM_SET_TSC_KHZ" funnels it through the invalidation.

The divergent-offset behaviour is exercised by pvclock_migration_test:
vCPUs with TSCs offset by ±0.5-1s keep the master clock, lose
PVCLOCK_TSC_STABLE_BIT, and still agree on the KVM clock to within a
nanosecond, before and after a simulated live migration.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |  11 ++-
 arch/x86/kvm/trace.h            |  12 +--
 arch/x86/kvm/x86.c              | 139 ++++++++++++++++++++++++++------
 3 files changed, 130 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 18d7bb9fd8d2..74306a81e882 100644
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
@@ -1232,9 +1233,10 @@ struct kvm_arch {
 	s64 kvmclock_offset;
 
 	/*
-	 * This also protects nr_vcpus_matched_tsc and
-	 * all_vcpus_matched_tsc, which are read from preemption-disabled
-	 * regions, so it must be a raw spinlock.
+	 * This also protects the matched-state fields
+	 * ({nr_vcpus_matched,all_vcpus_matched}_{tsc,freq} and
+	 * cur_tsc_freq_generation), which are read from
+	 * preemption-disabled regions, so it must be a raw spinlock.
 	 */
 	raw_spinlock_t tsc_write_lock;
 	u32 cur_tsc_khz;
@@ -1244,6 +1246,9 @@ struct kvm_arch {
 	u64 cur_tsc_offset;
 	u64 cur_tsc_generation;
 	bool all_vcpus_matched_tsc;
+	bool all_vcpus_matched_freq;
+	int nr_vcpus_matched_freq;
+	u64 cur_tsc_freq_generation;
 	int nr_vcpus_matched_tsc;
 
 	u32 default_tsc_khz;
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 93de876c318c..704683532ef0 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -1003,25 +1003,25 @@ TRACE_EVENT(kvm_write_tsc_offset,
 	{VDSO_CLOCKMODE_TSC,  "tsc"}			\
 
 TRACE_EVENT(kvm_update_master_clock,
-	TP_PROTO(bool use_master_clock, unsigned int host_clock, bool offset_matched),
-	TP_ARGS(use_master_clock, host_clock, offset_matched),
+	TP_PROTO(bool use_master_clock, unsigned int host_clock, bool freq_matched),
+	TP_ARGS(use_master_clock, host_clock, freq_matched),
 
 	TP_STRUCT__entry(
 		__field(		bool,	use_master_clock	)
 		__field(	unsigned int,	host_clock		)
-		__field(		bool,	offset_matched		)
+		__field(		bool,	freq_matched		)
 	),
 
 	TP_fast_assign(
 		__entry->use_master_clock	= use_master_clock;
 		__entry->host_clock		= host_clock;
-		__entry->offset_matched		= offset_matched;
+		__entry->freq_matched		= freq_matched;
 	),
 
-	TP_printk("masterclock %d hostclock %s offsetmatched %u",
+	TP_printk("masterclock %d hostclock %s freqmatched %u",
 		  __entry->use_master_clock,
 		  __print_symbolic(__entry->host_clock, host_clocks),
-		  __entry->offset_matched)
+		  __entry->freq_matched)
 );
 
 TRACE_EVENT(kvm_track_tsc,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1bb0136042a6..08cc8ab3d699 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1114,30 +1114,72 @@ static inline bool gtod_is_based_on_tsc(int mode)
 }
 #endif
 
-static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool new_generation)
+static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool update_mclock)
 {
 #ifdef CONFIG_X86_64
 	struct kvm_arch *ka = &vcpu->kvm->arch;
 	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
+	bool prev_matched_tsc = ka->all_vcpus_matched_tsc;
+	bool prev_matched_freq = ka->all_vcpus_matched_freq;
 
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
+	 */
+	WRITE_ONCE(ka->all_vcpus_matched_tsc,
+		   ka->nr_vcpus_matched_tsc >= online);
+
+	update_mclock |= (prev_matched_tsc != ka->all_vcpus_matched_tsc);
+
+	/*
+	 * all_vcpus_matched_freq starts true and is cleared when
+	 * __kvm_synchronize_tsc() detects a frequency mismatch.
+	 * Re-enable when all vCPUs have synced with matching frequency.
+	 * If all offsets also match, that implies frequencies match too.
 	 */
-	ka->all_vcpus_matched_tsc = (ka->nr_vcpus_matched_tsc + 1 ==
-				     atomic_read(&vcpu->kvm->online_vcpus));
+	if (ka->all_vcpus_matched_tsc ||
+	    ka->nr_vcpus_matched_freq >= online)
+		ka->all_vcpus_matched_freq = true;
 
-	bool use_master_clock = ka->all_vcpus_matched_tsc &&
+	/*
+	 * A frequency-match transition needs a masterclock update too:
+	 * when the last vCPU reaches the new frequency, the masterclock
+	 * scaling factors still describe the old one, and no toggle of
+	 * use_master_clock occurs to trigger the refresh.
+	 */
+	update_mclock |= (prev_matched_freq != ka->all_vcpus_matched_freq);
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
 
@@ -1336,12 +1378,50 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 	 * bookkeeping, recorded even for a protected guest TSC — a scaled
 	 * protected guest (TDX, SNP Secure TSC) must not leave the master
 	 * clock computing with the host's unscaled frequency.
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
 
-	if (vcpu->arch.guest_tsc_protected)
+	if (vcpu->arch.guest_tsc_protected) {
+		/*
+		 * A protected vCPU synchronizes only here (from postcreate,
+		 * host-initiated MSR_IA32_TSC writes and KVM_VCPU_TSC_OFFSET
+		 * writes) and never reaches
+		 * kvm_track_tsc_matching() — the only other place the
+		 * frequency match is re-latched. Without this, the first
+		 * vCPU's bump above (cur_tsc_khz starts at zero) would
+		 * clear the match for the life of the VM, turning the
+		 * master clock off for exactly the guests the init-to-true
+		 * serves. On the transition back to matched, request the
+		 * masterclock update that kvm_track_tsc_matching() would
+		 * have: a refresh in the mismatched window (another vCPU's
+		 * creation racing this sync) has latched use_master_clock
+		 * off, and nothing else ever re-runs it for a protected
+		 * guest.
+		 */
+		if (kvm->arch.nr_vcpus_matched_freq >=
+		    atomic_read(&kvm->online_vcpus) &&
+		    !kvm->arch.all_vcpus_matched_freq) {
+			kvm->arch.all_vcpus_matched_freq = true;
+			kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
+		}
 		return;
+	}
 
 	if (user_set_tsc)
 		vcpu->kvm->arch.user_set_tsc = true;
@@ -1357,6 +1437,16 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 	 */
 	vcpu->arch.tsc_offset_adjustment = 0;
 
+	/*
+	 * If the offset changes, the guest-visible pvclock must be
+	 * rewritten before the vCPU runs again: its tsc_timestamp was
+	 * computed with the old offset, and the masterclock (which now
+	 * survives offset changes) will not request the refresh for a
+	 * matched write.
+	 */
+	if (offset != vcpu->arch.l1_tsc_offset)
+		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
+
 	kvm_vcpu_write_tsc_offset(vcpu, offset);
 
 	if (!matched) {
@@ -1368,17 +1458,18 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
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
 
@@ -1596,10 +1687,10 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 #ifdef CONFIG_X86_64
 	struct kvm_arch *ka = &kvm->arch;
 	int vclock_mode;
-	bool host_tsc_clocksource, vcpus_matched;
+	bool host_tsc_clocksource, freqs_matched;
 
 	lockdep_assert_held(&kvm->arch.tsc_write_lock);
-	vcpus_matched = ka->all_vcpus_matched_tsc;
+	freqs_matched = ka->all_vcpus_matched_freq;
 
 	/*
 	 * If the host uses TSC clock, then passthrough TSC as stable
@@ -1609,7 +1700,7 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 					&ka->master_kernel_ns,
 					&ka->master_cycle_now);
 
-	ka->use_master_clock = host_tsc_clocksource && vcpus_matched
+	ka->use_master_clock = host_tsc_clocksource && freqs_matched
 				&& !ka->backwards_tsc_observed
 				&& !ka->boot_vcpu_runs_old_kvmclock;
 
@@ -1639,7 +1730,7 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 
 	vclock_mode = pvclock_gtod_data.clock.vclock_mode;
 	trace_kvm_update_master_clock(ka->use_master_clock, vclock_mode,
-					vcpus_matched);
+					freqs_matched);
 #endif
 }
 
@@ -1927,7 +2018,7 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 
 	/* If the host uses TSC clocksource, then it is stable */
 	hv_clock.flags = 0;
-	if (use_master_clock)
+	if (use_master_clock && READ_ONCE(ka->all_vcpus_matched_tsc))
 		hv_clock.flags |= PVCLOCK_TSC_STABLE_BIT;
 
 	if (vcpu->pv_time.active) {
@@ -9607,6 +9698,7 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 	if (!vcpu->arch.guest_tsc_protected) {
 		raw_spin_lock_irqsave(&ka->tsc_write_lock, flags);
 		WRITE_ONCE(ka->all_vcpus_matched_tsc, false);
+		ka->all_vcpus_matched_freq = false;
 		raw_spin_unlock_irqrestore(&ka->tsc_write_lock, flags);
 	}
 
@@ -10095,6 +10187,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	ratelimit_state_init(&kvm->arch.kvmclock_update_rs, HZ, 10);
 	ratelimit_set_flags(&kvm->arch.kvmclock_update_rs, RATELIMIT_MSG_ON_RELEASE);
 	kvm->arch.kvmclock_offset = -get_kvmclock_base_ns();
+	kvm->arch.all_vcpus_matched_freq = true;
 
 	/*
 	 * Start with all (zero) vCPUs considered matched, so that a VM whose
-- 
2.43.0

