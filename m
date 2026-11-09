Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187287;
	b=2rfbKn3sqyTi12rLp8IGJb+p9yB8OsNXRF4cwvd+BHvAisteoZJlkRIs8EuvSVeqYvhr
	 wz8WzXKtNWTnre3B6sC1K+bJHOvcxPnrkSWlcCVmwTvZ1rZJIq3J6WFzW9G9Q6V9JArYx
	 O5vi6+VviKw/oDQTnrVB8IafNO8jNgt28Y9H64/DuKY9BhCxtJ8VPWldRXAJqyoFWLqV+
	 CUKDgALS0z+9iAB1Gqio2U9t+fOoH4KZn3MhHAgpPqNXaNwFHBL7uaOflY/DsB89VtskP
	 9OP1ubzxrLEiyXU9QRWOr89qnoSkvimcjPwYqnDC9zjRssfdP2TzngqGov9RMKLKWZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187287;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=OGXN0D0AnakZQfmHEkKPNkYcySUtuJFGfGpWognUlZg=;
	b=euAqh2yY7we1ftVdUih1PJdR/h058VLTaQBWgjxbzKKpFNjgQ+J3nyxz1SAy1ECSXNOC
	 wC5V10B4t2pYTH8C2889SgZ7NvngxF3ozcLej+VDZ6GhbKPMqshVMX784r2/xPpgfgUQ+
	 C2FdPYn97nb3WhlG7MHkSZUc3tFwHylX7BvXF8wyW42AikC4eCKS4OK/6pG8u420KQIN8
	 SNM1L+IcAXvh2NyMeKTx/Fr2Q9Gq8DcMF7DMSj+cTsTyhYsG/WjMvP6/nFupzS6+hfSAN
	 G9Rwj6dsJCfSlMZ4Z/p4in7m+A5MpD1b1PclQHJovV1y+jzm59UdeGiHPb6AWmaj3tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=BlcG+kUi;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4628D606D80F;
	Mon,  9 Nov 2026 01:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4628D606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=BlcG+kUi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=OGXN0D0AnakZQfmHEkKPNkYcySUtuJFGfGpWognUlZg=; b=BlcG+kUioyjKmZnJeACk4Nuqun
	q24fNixOf2dqW9pl1WEw1JY68gEQQ/RBx7tVu/0I018bYMAnj4z/BFGq8pu2mUnxm0WTfOgx6emzR
	nRW9w5s3x5RIlF3wBkTcrY3CRt0ttltQndI1zOPXBTNbEo0P2/937BSkICkMTSfbZPXgi/yEgYrbH
	v0Q8IN8jaRODckRLBi3YUZJX2NOWGPSS23kS7RsV5FxmF612mIGHEryZ76J9sXvxGogub/cb3KU3O
	d5eMAwxPNA3ocAFJZ5shoXU28kNY+QoU/YqqanGJ56R5QCj76bHwqAfkiuaBfeWJFoDu6JjfLU/oq
	3aKvFsXw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQE4Q-00000006AYB-28ju;
	Mon, 09 Nov 2026 01:21:15 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xQE4O-0000000EKUZ-3FJ2;
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
Subject: [PATCH v12 08/24] KVM: x86: Re-synchronize TSC after KVM_SET_TSC_KHZ
Date: Sun,  8 Nov 2026 17:20:54 -0800
Message-ID: <20261109012112.3415328-9-dwmw2@infradead.org>
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

KVM_SET_TSC_KHZ changes the vCPU's TSC scaling ratio but does not
update the VM-wide cur_tsc_scaling_ratio used by get_kvmclock().
This causes get_kvmclock() to use a stale (default 1:1) ratio when
computing the KVM clock, leading to drift between the host-side
kvmclock and what the guest observes.

Fix this by calling kvm_synchronize_tsc() after changing the TSC
frequency. This:
 - Updates cur_tsc_scaling_ratio (consumed by pvclock_update_vm_gtod_copy)
 - Ensures the TSC value is continuous across the frequency change
 - Triggers kvm_track_tsc_matching() for proper masterclock handling
 - Establishes the new TSC generation for subsequent vCPUs to match

Since kvm_synchronize_tsc() previously inferred "userspace wrote the
TSC" from being given a non-NULL value, and this new call is a purely
kernel-internal resynchronization, make that an explicit
'user_initiated' parameter instead. Otherwise the kernel's own call
would set kvm->arch.user_set_tsc and incorrectly enable the 1-second
slop heuristic before userspace has ever written a TSC value, breaking
the restore of a guest with less than one second of runtime.

The resynchronization is skipped in two cases. At vCPU creation (which
comes through here with the default frequency), the vCPU is not yet
counted in online_vcpus, so synchronizing would corrupt the VM-wide
matching state — and leave it corrupted if creation subsequently
fails; the initial synchronization in kvm_arch_vcpu_postcreate()
covers it. And when the frequency is unchanged, there is nothing to
re-synchronize: opening a new generation for a no-op ioctl would
needlessly orphan the matched state of the sibling vCPUs.

The preserved value is sampled as a {guest TSC, host clock} tuple
and handed to the synchronization together with its reference point,
so the new offset is computed against the host TSC the sample was
taken at — not against "now". The guest TSC keeps counting through
the frequency change, and any delay between sample and installation
(preemption included) costs nothing. The new frequency itself is only
committed once set_tsc_khz() can no longer fail; a failed ioctl must
leave no trace, or a retry with the still-active frequency would
wrongly look like a change and open a gratuitous generation.

Because the internal sample is exact, it is not given the 1-second
slop window intended for the racy legacy userspace API: a vCPU on the
generation's timeline still matches within a 1ms window, but one which
genuinely diverged (a guest TSC_ADJUST write, or a deliberate
sub-second offset) keeps its exact value rather than being snapped
back onto the generation by up to a second. Setting a frequency which
no longer needs catchup also clears the always-catchup state which an
earlier above-host-rate setting on scaling-less hardware left behind,
and which otherwise persisted for the life of the vCPU.

Only preserve the TSC value across a frequency change for a vCPU
which has run, or whose TSC userspace has explicitly written (tracked
with a new per-vCPU user_set_tsc flag — the VM-wide flag would make
one vCPU's restored TSC cause a sibling's unrestored, creation-time
value to be preserved, clobbering the generation it could otherwise
match). A never-run vCPU holds nothing worth preserving, so
synchronize it as for a zero write, placing it on the generation's
timeline at the new frequency.

A KVM_GET_CLOCK issued before the resulting masterclock update is
serviced still returns the correct time: the masterclock parameters
are consumed as one self-consistent snapshot, and a host TSC delta
scaled by the snapshot's ratio and converted by its mul/shift yields
nanoseconds independent of the guest frequency they encode.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst  |   8 ++
 arch/x86/include/asm/kvm_host.h |   1 +
 arch/x86/kvm/msrs.c             |   2 +-
 arch/x86/kvm/x86.c              | 156 +++++++++++++++++++++++++++-----
 arch/x86/kvm/x86.h              |   2 +-
 5 files changed, 142 insertions(+), 27 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index ddc61ea36ac5..9487afc4431f 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -2023,6 +2023,14 @@ If the KVM_CAP_VM_TSC_CONTROL capability is advertised, this can also
 be used as a vm ioctl to set the initial tsc frequency of subsequently
 created vCPUs.  Note, the vm ioctl is only allowed prior to creating vCPUs.
 
+Changing the frequency of a vCPU with the vcpu ioctl re-synchronizes
+its TSC: for a vCPU which has run, or whose TSC userspace has written,
+the current guest TSC value is preserved across the change (the TSC
+offset, as visible through the KVM_VCPU_TSC_OFFSET attribute, is
+rewritten accordingly); otherwise the vCPU is synchronized to the
+VM's existing TSC timeline at the new frequency. Setting the current
+frequency again is a no-op.
+
 For TSC protected Confidential Computing (CoCo) VMs where TSC frequency
 is configured once at VM scope and remains unchanged during VM's
 lifetime, the vm ioctl should be used to configure the TSC frequency
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 30e89e8fb975..8af808fbf6ce 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -888,6 +888,7 @@ struct kvm_vcpu_arch {
 	u64 this_tsc_write;
 	u64 this_tsc_generation;
 	u64 this_tsc_freq_generation;
+	bool user_set_tsc;
 	bool tsc_catchup;
 	bool tsc_always_catchup;
 	s8 virtual_tsc_shift;
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index 26eb30f10c43..d07831b5dfb8 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -1645,7 +1645,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_IA32_TSC:
 		if (msr_info->host_initiated) {
-			kvm_synchronize_tsc(vcpu, &data);
+			kvm_synchronize_tsc(vcpu, &data, true);
 		} else if (!vcpu->arch.guest_tsc_protected) {
 			u64 adj = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data) -
 				  vcpu->arch.l1_tsc_offset;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 290a3c3bb44f..b47c36265c2f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1031,7 +1031,7 @@ static int set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz, bool scale)
 	/* Guest TSC same frequency as host TSC? */
 	if (!scale) {
 		kvm_vcpu_write_tsc_multiplier(vcpu, kvm_caps.default_tsc_scaling_ratio);
-		return 0;
+		goto clear_catchup;
 	}
 
 	/* TSC scaling supported? */
@@ -1057,13 +1057,34 @@ static int set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz, bool scale)
 	}
 
 	kvm_vcpu_write_tsc_multiplier(vcpu, ratio);
+
+clear_catchup:
+	/*
+	 * A frequency which no longer needs catchup must also stop it: a
+	 * previous above-host-rate setting on scaling-less hardware set
+	 * the always-catchup flags, and nothing else ever clears them.
+	 * Only undo that pairing — tsc_catchup alone also serves the
+	 * unstable-host-TSC compensation in kvm_arch_vcpu_load().
+	 */
+	if (vcpu->arch.tsc_always_catchup) {
+		vcpu->arch.tsc_always_catchup = 0;
+		vcpu->arch.tsc_catchup = 0;
+	}
 	return 0;
 }
 
-static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
+static void kvm_synchronize_tsc_at(struct kvm_vcpu *vcpu, u64 *value,
+				   u64 host_tsc, s64 ns, bool user_initiated);
+
+static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz, bool init)
 {
+	bool freq_changed = (vcpu->arch.virtual_tsc_khz != user_tsc_khz);
 	u32 thresh_lo, thresh_hi;
+	u32 tsc_mult;
+	s8 tsc_shift;
 	int use_scaling = 0;
+	u64 tsc, host_tsc;
+	s64 ns;
 
 	/* tsc_khz can be zero if TSC calibration fails */
 	if (user_tsc_khz == 0) {
@@ -1074,9 +1095,7 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
 
 	/* Compute a scale to convert nanoseconds in TSC cycles */
 	kvm_get_time_scale(user_tsc_khz * 1000LL, NSEC_PER_SEC,
-			   &vcpu->arch.virtual_tsc_shift,
-			   &vcpu->arch.virtual_tsc_mult);
-	vcpu->arch.virtual_tsc_khz = user_tsc_khz;
+			   &tsc_shift, &tsc_mult);
 
 	/*
 	 * Compute the variation in TSC rate which is acceptable
@@ -1091,7 +1110,67 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
 			 user_tsc_khz, thresh_lo, thresh_hi);
 		use_scaling = 1;
 	}
-	return set_tsc_khz(vcpu, user_tsc_khz, use_scaling);
+
+	/*
+	 * Sample the guest TSC before changing the ratio, so continuity
+	 * can be preserved across the change — as a {guest TSC, host
+	 * clock} tuple, not a bare value: the synchronization below
+	 * computes the new offset against the tuple's own reference
+	 * point, so the guest TSC keeps counting through this function
+	 * and any delay here (preemption included) costs nothing.
+	 */
+#ifdef CONFIG_X86_64
+	if (!kvm_get_time_and_clockread(&ns, &host_tsc))
+#endif
+	{
+		host_tsc = rdtsc();
+		ns = get_kvmclock_base_ns();
+	}
+	tsc = kvm_read_l1_tsc(vcpu, host_tsc);
+
+	if (set_tsc_khz(vcpu, user_tsc_khz, use_scaling))
+		return -1;
+
+	/*
+	 * Commit the new frequency only once set_tsc_khz() can no longer
+	 * fail: a failed ioctl must leave no trace, or a retry with the
+	 * still-active frequency would wrongly look like a change.
+	 */
+	vcpu->arch.virtual_tsc_shift = tsc_shift;
+	vcpu->arch.virtual_tsc_mult = tsc_mult;
+	vcpu->arch.virtual_tsc_khz = user_tsc_khz;
+
+	/*
+	 * At vCPU creation (@init) the vCPU is not yet counted in
+	 * online_vcpus, so synchronizing here would corrupt the VM-wide
+	 * matching state (and leave it corrupted if creation subsequently
+	 * fails). The initial synchronization happens in
+	 * kvm_arch_vcpu_postcreate() instead. An unchanged frequency is
+	 * a no-op for synchronization: don't disturb the generation
+	 * tracking of a configured vCPU.
+	 */
+	if (init || !freq_changed)
+		return 0;
+
+	/*
+	 * Changing the frequency changes the vCPU's position on the
+	 * generation's cycle timeline, so re-synchronize. For a vCPU
+	 * which has run, preserve the guest TSC value read above across
+	 * the change; likewise if userspace has written a TSC on this
+	 * vCPU — a zero write would discard it. Otherwise the vCPU holds
+	 * only its creation-time synchronization, so synchronize as for
+	 * a zero write. When the generation is already at the new
+	 * frequency this places the vCPU on its timeline rather than
+	 * opening a gratuitous new generation and orphaning the matched
+	 * state of its siblings; the first vCPU to adopt a new frequency
+	 * necessarily opens a new generation, starting at zero — mixed
+	 * frequencies within a VM forfeit the master clock anyway.
+	 */
+	if (vcpu->arch.last_vmentry_cpu != -1 || vcpu->arch.user_set_tsc)
+		kvm_synchronize_tsc_at(vcpu, &tsc, host_tsc, ns, false);
+	else
+		kvm_synchronize_tsc_at(vcpu, NULL, host_tsc, ns, false);
+	return 0;
 }
 
 static u64 compute_guest_tsc(struct kvm_vcpu *vcpu, s64 kernel_ns)
@@ -1396,8 +1475,10 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 	if (vcpu->arch.guest_tsc_protected)
 		return;
 
-	if (user_set_tsc)
+	if (user_set_tsc) {
 		vcpu->kvm->arch.user_set_tsc = true;
+		vcpu->arch.user_set_tsc = true;
+	}
 
 	/*
 	 * Track the TSC frequency, scaling ratio, and offset for the current
@@ -1472,26 +1553,25 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 	kvm_track_tsc_matching(vcpu, !matched);
 }
 
-void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
+/*
+ * Synchronize the vCPU's TSC against an explicit {host_tsc, ns} reference
+ * point: @value (when non-NULL) is the guest TSC *at* @host_tsc, not at
+ * some unspecified "now". The offset is computed against that reference,
+ * so a sampled value stays valid however much time passes between the
+ * sampling and this call.
+ */
+static void kvm_synchronize_tsc_at(struct kvm_vcpu *vcpu, u64 *value,
+				   u64 host_tsc, s64 ns, bool user_initiated)
 {
-	u64 data = user_value ? *user_value : 0;
+	u64 data = value ? *value : 0;
 	struct kvm *kvm = vcpu->kvm;
-	u64 offset, host_tsc, elapsed;
-	s64 ns;
+	u64 offset, elapsed;
 	unsigned long flags;
 	bool matched = false;
 	bool synchronizing = false;
 
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
 
-#ifdef CONFIG_X86_64
-	if (!kvm_get_time_and_clockread(&ns, &host_tsc))
-#endif
-	{
-		host_tsc = rdtsc();
-		ns = get_kvmclock_base_ns();
-	}
-
 	offset = kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
 	elapsed = ns - kvm->arch.cur_tsc_nsec;
 
@@ -1506,6 +1586,7 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 			u64 tsc_exp = kvm->arch.cur_tsc_write +
 						nsec_to_cycles(vcpu, elapsed);
 			u64 tsc_hz = vcpu->arch.virtual_tsc_khz * 1000LL;
+			u64 window;
 			/*
 			 * Here lies UAPI baggage: when a user-initiated TSC write has
 			 * a small delta (1 second) of virtual cycle time against the
@@ -1520,9 +1601,18 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 			 * to this 'correction' to make it sync up with values that only
 			 * come from the kernel's default vCPU creation. Make the 1-second
 			 * slop hack only trigger if the user_set_tsc flag is already set.
+			 *
+			 * A kernel-internal write (a frequency change preserving the
+			 * guest TSC) carries an exact value sampled with its own
+			 * reference point, not a racy userspace one; a vCPU on the
+			 * generation's line still matches it to within arithmetic
+			 * rounding, but one which genuinely diverged (e.g. by a guest
+			 * TSC_ADJUST write) must not be snapped back by up to a
+			 * second. Use a 1ms window for those.
 			 */
-			synchronizing = data < tsc_exp + tsc_hz &&
-					data + tsc_hz > tsc_exp;
+			window = user_initiated ? tsc_hz : tsc_hz / 1000;
+			synchronizing = data < tsc_exp + window &&
+					data + window > tsc_exp;
 		}
 	}
 
@@ -1552,10 +1642,26 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 		matched = true;
 	}
 
-	__kvm_synchronize_tsc(vcpu, offset, data, ns, matched, !!user_value);
+	__kvm_synchronize_tsc(vcpu, offset, data, ns, matched, user_initiated);
 	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
 }
 
+void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *value, bool user_initiated)
+{
+	u64 host_tsc;
+	s64 ns;
+
+#ifdef CONFIG_X86_64
+	if (!kvm_get_time_and_clockread(&ns, &host_tsc))
+#endif
+	{
+		host_tsc = rdtsc();
+		ns = get_kvmclock_base_ns();
+	}
+
+	kvm_synchronize_tsc_at(vcpu, value, host_tsc, ns, user_initiated);
+}
+
 #ifdef CONFIG_X86_64
 
 static bool kvm_snapshot_has_tsc(struct system_time_snapshot *snap,
@@ -3905,7 +4011,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (user_tsc_khz == 0)
 			user_tsc_khz = tsc_khz;
 
-		if (!kvm_set_tsc_khz(vcpu, user_tsc_khz))
+		if (!kvm_set_tsc_khz(vcpu, user_tsc_khz, false))
 			r = 0;
 
 		goto out;
@@ -9680,7 +9786,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	kvm_xen_init_vcpu(vcpu);
 	vcpu_load(vcpu);
 	kvm_vcpu_after_set_cpuid(vcpu);
-	kvm_set_tsc_khz(vcpu, vcpu->kvm->arch.default_tsc_khz);
+	kvm_set_tsc_khz(vcpu, vcpu->kvm->arch.default_tsc_khz, true);
 	kvm_vcpu_reset(vcpu, false);
 	kvm_init_mmu(vcpu);
 	vcpu_put(vcpu);
@@ -9724,7 +9830,7 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 		return;
 	}
 	vcpu_load(vcpu);
-	kvm_synchronize_tsc(vcpu, NULL);
+	kvm_synchronize_tsc(vcpu, NULL, false);
 	if (kvm_check_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu))
 		kvm_update_masterclock(vcpu->kvm, NULL);
 	vcpu_put(vcpu);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 436e2fb1396c..de4c86ea5a7d 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -330,7 +330,7 @@ uint64_t kvm_get_wall_clock_epoch(struct kvm *kvm);
 bool kvm_get_monotonic_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp);
 int kvm_guest_time_update(struct kvm_vcpu *v);
 
-void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value);
+void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *value, bool user_initiated);
 u64 kvm_scale_tsc(u64 tsc, u64 ratio);
 u64 kvm_read_l1_tsc(struct kvm_vcpu *vcpu, u64 host_tsc);
 u64 kvm_calc_nested_tsc_offset(u64 l1_offset, u64 l2_offset, u64 l2_multiplier);
-- 
2.43.0

