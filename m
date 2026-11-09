Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187289;
	b=drBFl0/qODwYHCS9Wib51NLa2haAk/XLzrdX9Khc0s2FgIr1Pc8Os6HD0UwwRxxKl2k6
	 yyeAsOAYIlVLllP//06mAbWVy458XB4qYw/ay3XSJHieHYHiSxF+nA52zIavtrNAwGlnM
	 YOpXUsljNix9CGy3fmC7uPrtHyf2NFDPuNI9UThUR43sz1EHElZ534A0P9SSVdSzycw0R
	 wAE08QwAFZplYDpk92dDcM3DGyqJ/IJxZ+kzMpccypDWsrA1p9G//BM5nDtR7N/XdNwcs
	 JFALt2t6ojujH6g6OEWWEHyxtXqVwRXdJfRIV8zhaf1EUR/LFFL208nExNYWFMNKvEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187289;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=1e8jlVZXaPnprQ0WSIFvIXD2UWssR4vVaDT7fBzxPKM=;
	b=WmYNckaZlKDYf68YPs4EnhtCOPLhW/r1jTkoJKWdDeoXAcw4CkFHAIWV8/YsGdcp284S
	 ewZ9sr2g2X7o6qq5JQMmPcJhAcTu5xZxXz6irHwxR44k/lPXtaRdCBqmBa2Re6Vdk2GdI
	 tuwxoUkXu8xlzRu1xrekwUoLPoKu1wIBOp29Ev7ch45/BxU32UI6rM8DUR3ANTnrWLz46
	 xpkuOymDI9Pve0l1t5RbP+D0vrIvwKeqwuNF5KHlu/cjl5jLaL5U1PaVXMjg12Qa8eNd8
	 jd6MxoBJww0r3Htd8ZFfg7VSNfHgfCmoPyiQU/GA/si636JALGv4aUE2uAA3FczJMxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Z0lWkq9c;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462FC606EE87;
	Mon,  9 Nov 2026 01:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 462FC606EE87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Z0lWkq9c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=1e8jlVZXaPnprQ0WSIFvIXD2UWssR4vVaDT7fBzxPKM=; b=Z0lWkq9caKZ3gCoXJORM570T9M
	BCaNriZVoItOnZ7qWylhgXwxz0boBAqH2B+iw53ih/rEVextM/R0UjeCyeQIIDqvIqYgW0LoF1zCq
	lrzcriCJ4zVjHpoEm/q9ealbGHUwgeHPWfIgP83444Eo7ai9rmexf++tsuQtr9eG2nyHtzui2apZs
	dwLGCwcIZrs2N6ouK7iix3aECPu5Mkb6SpU2wLNiqusT/N5XOFMfCoGqAvktkQlOJRDKo4Dt5s/4U
	RWaUOWAmA2P/QVVrNKMHQoGTh4283sj3ioplz2Bm5ya6NujsQIjDWVVKwTQLmf1sPkqYW9pjgIwI6
	MkcEOMcg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQE4Q-00000006AY9-28yu;
	Mon, 09 Nov 2026 01:21:15 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xQE4O-0000000EKUG-2M1t;
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
Subject: [PATCH v12 04/24] KVM: x86: Allow KVM master clock mode when TSCs are offset from each other
Date: Sun,  8 Nov 2026 17:20:50 -0800
Message-ID: <20261109012112.3415328-5-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

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

KVM_SET_TSC_KHZ on a vCPU which has already run does not pass through
__kvm_synchronize_tsc(), so at this point in the series it leaves the
frequency-match state stale, exactly as it previously left the offset
match state stale. The later patch "KVM: x86: Re-synchronize TSC after
KVM_SET_TSC_KHZ" funnels it through the invalidation above.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |   4 ++
 arch/x86/kvm/trace.h            |  12 ++--
 arch/x86/kvm/x86.c              | 114 ++++++++++++++++++++++++++------
 3 files changed, 102 insertions(+), 28 deletions(-)

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
index d29e5bc75f7a..73015825f218 100644
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
 	 */
-	ka->all_vcpus_matched_tsc = (ka->nr_vcpus_matched_tsc + 1 ==
-				     atomic_read(&vcpu->kvm->online_vcpus));
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
 
@@ -1339,7 +1381,22 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
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
 
@@ -1354,6 +1411,16 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
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
@@ -1365,17 +1432,18 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
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
 
@@ -1593,10 +1661,10 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
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
@@ -1606,7 +1674,7 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 					&ka->master_kernel_ns,
 					&ka->master_cycle_now);
 
-	ka->use_master_clock = host_tsc_clocksource && vcpus_matched
+	ka->use_master_clock = host_tsc_clocksource && freqs_matched
 				&& !ka->backwards_tsc_observed
 				&& !ka->boot_vcpu_runs_old_kvmclock;
 
@@ -1636,7 +1704,7 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 
 	vclock_mode = pvclock_gtod_data.clock.vclock_mode;
 	trace_kvm_update_master_clock(ka->use_master_clock, vclock_mode,
-					vcpus_matched);
+					freqs_matched);
 #endif
 }
 
@@ -1924,7 +1992,7 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 
 	/* If the host uses TSC clocksource, then it is stable */
 	hv_clock.flags = 0;
-	if (use_master_clock)
+	if (use_master_clock && READ_ONCE(ka->all_vcpus_matched_tsc))
 		hv_clock.flags |= PVCLOCK_TSC_STABLE_BIT;
 
 	if (vcpu->pv_time.active) {
@@ -9568,6 +9636,7 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 		raw_spin_lock_irqsave(&ka->tsc_write_lock, flags);
 		WRITE_ONCE(ka->all_vcpus_matched_tsc, false);
+		ka->all_vcpus_matched_freq = false;
 		raw_spin_unlock_irqrestore(&ka->tsc_write_lock, flags);
 		return;
 	}
@@ -10045,6 +10114,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	ratelimit_state_init(&kvm->arch.kvmclock_update_rs, HZ, 10);
 	ratelimit_set_flags(&kvm->arch.kvmclock_update_rs, RATELIMIT_MSG_ON_RELEASE);
 	kvm->arch.kvmclock_offset = -get_kvmclock_base_ns();
+	kvm->arch.all_vcpus_matched_freq = true;
 
 	/*
 	 * Start with all (zero) vCPUs considered matched, so that a VM whose
-- 
2.43.0

