Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420569;
	b=jWIYtjsYKS95j7Bk95KbfVqW3FTfY8tgx/YNRXZhcnUUg7rm628kk+ykt5nIVdM3mXTk
	 8Fktl2IDet76PHQF7QK4ZZqHJ0+2RzVX7tuJGPxs7JH9n8XSY7X+89SXZ8Z9sbmX77Yzc
	 pNfJGZA30yDswCF8uJtmlk99XHj81/6cNU75T3CL1JjhzSKw7Zd+JYuY/7i2z5xglmyIQ
	 yjRK2ouIZ9Lp35zMyXeijUm/WU6fQJjliiJvhmR5sN7OOMD5L5ZIeDYlilp43yLLEeJ3a
	 OJxRrNkGVxjmoLEqA02BhYpkKfmbob9cQ/xzzPk1Wl2m9Fm1kn40WxQwkThuxzVgmAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420569;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=rukGdvZHi+FYhueyc7C7kJqyRtxzfRo4uOsIZilmUF4=;
	b=mXCAx6QJbk/arHuiMHF5NFsSG79vebqldwkyR+hY76In0bKSLJuQjl+8XXFSD5KRJskf
	 Mtqw52zBh3GNZBQ9tirnNKZiwpdRhLzFZ3Ea4Q7/H2UGAOi50AkeTO/L7xyzZAhwXxKQ/
	 KbRugvmoySryTgxnaXe44NLR2CBW8i7V1gKHb0CLrRhtx7V8vnbdsVnp7kOCaOm0hGzyy
	 NH/W8pd/tdlyOwRUe9qg6sDzk0hBN7Y0yYYBVBTYiIed3UuzJSegk0UnIjQ87j+MGwDHx
	 VR6SRkGUnnl55TzmpPZPHYWBOzyzVW/jlV2jf+QQ3y2tU1QbbO4TvhOjun32HbIaAGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=RO98a0B7;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74A4606A330;
	Wed, 11 Nov 2026 18:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E74A4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=RO98a0B7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=rukGdvZHi+FYhueyc7C7kJqyRtxzfRo4uOsIZilmUF4=; b=RO98a0B7yQvAbZcLbDxRyDWDE5
	s1WsfHsDLoUB6ke24xUkdT14WCZ7nyXPDpjPEYombjtX59iNOL/LbKsHxhcb7So2o5DWKS/h5SKoP
	n6h/DeoanEookLBmxtYUdkNfhvnGZGsRoOqDQM1LtqnQRCi8Mfdngja01poMjmPGotwO4stJnryH5
	QLbsApgO2GilT/H0+/I+942mIHdlZekyse+kIn4iGXgtKZj3TanL9Z/e0PmcFp+8LnOaamiev4skt
	OUKu9voFytCpj/XFSPl5j/Z2QtoPxrHmtzj/EEXrWwFREd2u1y0vRTCgNTYeuvuM30/ACbW6lMd61
	hfmFH4tw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRCl9-0000000CKvX-1aUq;
	Wed, 11 Nov 2026 18:09:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRCl9-0000000HWse-0mBy;
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
Subject: [PATCH v13 10/26] KVM: x86: Re-synchronize TSC after KVM_SET_TSC_KHZ
Date: Wed, 11 Nov 2026 10:09:06 -0800
Message-ID: <20261111180922.4177927-11-dwmw2@infradead.org>
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

KVM_SET_TSC_KHZ changes the vCPU's TSC scaling ratio but not the
VM-wide cur_tsc_scaling_ratio used by get_kvmclock(), which then
computes the KVM clock with a stale ratio and drifts away from what
the guest observes.

Re-synchronize the TSC after a frequency change. That updates the
VM-wide scaling ratio, keeps the guest TSC value continuous across the
change, and establishes the new generation for subsequent vCPUs to
match. Two cases are skipped: vCPU creation, which is not yet counted
in online_vcpus (the postcreate synchronization covers it), and an
unchanged frequency, which is documented as a no-op — tested before
anything which could fail, since creation commits a frequency even
when set_tsc_khz() cannot honour it, and a repeated set of that same
frequency must not turn into -EINVAL.

The preserved value is sampled as a {guest TSC, host clock} tuple and
the new offset is computed against the tuple's own reference point,
not against "now", so delay between sample and installation costs
nothing. Preemption stays disabled from the sample until
tsc_write_lock is held: this task's own preempt notifier is the one
writer which could apply a pending backwards-TSC compensation to the
offset the sample was read through, and one still pending at the lock
is folded in there. A failed ioctl commits nothing, so a retry does
not masquerade as a frequency change (creation commits regardless, as
it always has — its caller ignores the return value).

A kernel-internal call is distinguished from a userspace write by an
explicit user_initiated parameter: the internal call must not set
user_set_tsc and arm the 1-second slop heuristic before userspace has
ever written a TSC. Because the internal sample is exact it gets a 1ms
matching window instead of the legacy API's 1-second slop: a vCPU on
the generation's timeline still matches, but one which genuinely
diverged (a guest TSC_ADJUST write) keeps its exact value. Values
preserved from the old frequency diverge from the new generation's
line at |F1-F2| per unit time — the honest cost of preserving them.

Only a vCPU which has run, or whose TSC userspace explicitly wrote,
has a value worth preserving; track that with a new per-vCPU
user_set_tsc flag, since the VM-wide flag would let one vCPU's
restored TSC cause a sibling's unrestored creation-time value to be
preserved. A never-run vCPU is synchronized as for a zero write,
landing on the generation's timeline at the new frequency.

The arithmetic corners — a tuple sampled just before a sibling opens a
newer generation, the wrap-safe matching window, the zero clamp for an
unrun vCPU forced onto a younger generation — are documented where
they live, in __kvm_synchronize_tsc_at(). The virtual_tsc_mult/shift
pair is still published non-atomically, exactly as it always was. A
KVM_GET_CLOCK issued before the resulting masterclock update is
serviced still returns the correct time: the masterclock snapshot is
self-consistent, and the ns it yields is independent of the guest
frequency it encodes.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst  |   8 +
 arch/x86/include/asm/kvm_host.h |   1 +
 arch/x86/kvm/msrs.c             |   2 +-
 arch/x86/kvm/x86.c              | 284 ++++++++++++++++++++++++++++----
 arch/x86/kvm/x86.h              |   2 +-
 5 files changed, 260 insertions(+), 37 deletions(-)

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
index 3f5aa1d3f6bb..773df58898ea 100644
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
index 1d4b66257b35..cf35363366f1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1073,10 +1073,20 @@ static int set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz, bool scale)
 	return 0;
 }
 
-static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
+static void __kvm_synchronize_tsc_at(struct kvm_vcpu *vcpu, u64 *value,
+				     u64 host_tsc, s64 ns,
+				     bool user_initiated);
+
+static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz, bool init)
 {
+	bool freq_changed = (vcpu->arch.virtual_tsc_khz != user_tsc_khz);
 	u32 thresh_lo, thresh_hi;
+	u32 tsc_mult;
+	s8 tsc_shift;
 	int use_scaling = 0;
+	u64 tsc, host_tsc;
+	unsigned long flags;
+	s64 ns;
 
 	/* tsc_khz can be zero if TSC calibration fails */
 	if (user_tsc_khz == 0) {
@@ -1085,11 +1095,19 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
 		return -1;
 	}
 
+	/*
+	 * Setting the current frequency again is a no-op, as documented
+	 * — unconditionally, including a frequency the hardware could
+	 * not honour at vCPU creation (which commits it regardless):
+	 * re-running set_tsc_khz() would turn the documented no-op into
+	 * -EINVAL.
+	 */
+	if (!init && !freq_changed)
+		return 0;
+
 	/* Compute a scale to convert nanoseconds in TSC cycles */
 	kvm_get_time_scale(user_tsc_khz * 1000LL, NSEC_PER_SEC,
-			   &vcpu->arch.virtual_tsc_shift,
-			   &vcpu->arch.virtual_tsc_mult);
-	vcpu->arch.virtual_tsc_khz = user_tsc_khz;
+			   &tsc_shift, &tsc_mult);
 
 	/*
 	 * Compute the variation in TSC rate which is acceptable
@@ -1104,7 +1122,92 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
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
+	 * point, so the guest TSC keeps counting through this function.
+	 * Preemption stays disabled from the sample until tsc_write_lock
+	 * is held — not for timing, but because this task's own preempt
+	 * notifier (kvm_sched_in -> kvm_arch_vcpu_load) is the one
+	 * writer which could apply a pending backwards-TSC compensation
+	 * to the offset the sample was read through; a compensation
+	 * still pending when the lock is taken is folded in there.
+	 */
+	if (!init) {
+		preempt_disable();
+#ifdef CONFIG_X86_64
+		if (!kvm_get_time_and_clockread(&ns, &host_tsc))
+#endif
+		{
+			unsigned long irqflags;
+
+			/*
+			 * The two reads must form one coherent reference
+			 * point.
+			 */
+			local_irq_save(irqflags);
+			host_tsc = rdtsc();
+			ns = get_kvmclock_base_ns();
+			local_irq_restore(irqflags);
+		}
+		tsc = kvm_read_l1_tsc(vcpu, host_tsc);
+	}
+
+	/*
+	 * Commit the new frequency only once set_tsc_khz() can no longer
+	 * fail: a failed ioctl must leave no trace, or a retry with the
+	 * still-active frequency would wrongly look like a change. The
+	 * exception is vCPU creation (@init), whose caller ignores the
+	 * return value: commit the requested frequency even when the
+	 * hardware cannot scale to it, as creation always has, rather
+	 * than leave the vCPU with the zeroed frequency from allocation
+	 * (KVM_GET_TSC_KHZ would report 0, and the catchup path would
+	 * compute with a zero mult).
+	 */
+	if (set_tsc_khz(vcpu, user_tsc_khz, use_scaling) && !init) {
+		preempt_enable();
+		return -1;
+	}
+
+	vcpu->arch.virtual_tsc_shift = tsc_shift;
+	vcpu->arch.virtual_tsc_mult = tsc_mult;
+	vcpu->arch.virtual_tsc_khz = user_tsc_khz;
+
+	/*
+	 * At vCPU creation (@init) the vCPU is not yet counted in
+	 * online_vcpus, so synchronizing here would corrupt the VM-wide
+	 * matching state (and leave it corrupted if creation subsequently
+	 * fails). The initial synchronization happens in
+	 * kvm_arch_vcpu_postcreate() instead.
+	 */
+	if (init)
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
+	raw_spin_lock_irqsave(&vcpu->kvm->arch.tsc_write_lock, flags);
+	preempt_enable();
+	if (vcpu->arch.last_vmentry_cpu != -1 || vcpu->arch.user_set_tsc)
+		__kvm_synchronize_tsc_at(vcpu, &tsc, host_tsc, ns, false);
+	else
+		__kvm_synchronize_tsc_at(vcpu, NULL, host_tsc, ns, false);
+	raw_spin_unlock_irqrestore(&vcpu->kvm->arch.tsc_write_lock, flags);
+	return 0;
 }
 
 static u64 compute_guest_tsc(struct kvm_vcpu *vcpu, s64 kernel_ns)
@@ -1458,8 +1561,10 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 		return;
 	}
 
-	if (user_set_tsc)
+	if (user_set_tsc) {
 		vcpu->kvm->arch.user_set_tsc = true;
+		vcpu->arch.user_set_tsc = true;
+	}
 
 	vcpu->arch.last_guest_tsc = tsc;
 
@@ -1511,40 +1616,84 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
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
+static void __kvm_synchronize_tsc_at(struct kvm_vcpu *vcpu, u64 *value,
+				     u64 host_tsc, s64 ns,
+				     bool user_initiated)
 {
-	u64 data = user_value ? *user_value : 0;
+	u64 data = value ? *value : 0;
 	struct kvm *kvm = vcpu->kvm;
-	u64 offset, host_tsc, elapsed;
-	s64 ns;
-	unsigned long flags;
+	u64 elapsed_cycles = 0;
+	s64 elapsed;
+	u64 offset;
 	bool matched = false;
 	bool synchronizing = false;
 
-	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
+	lockdep_assert_held(&kvm->arch.tsc_write_lock);
 
-#ifdef CONFIG_X86_64
-	if (!kvm_get_time_and_clockread(&ns, &host_tsc))
-#endif
-	{
-		host_tsc = rdtsc();
-		ns = get_kvmclock_base_ns();
-	}
+	/*
+	 * A backwards-TSC compensation pending now was not in a sampled
+	 * @value: it is applied to the vCPU's offset only at vcpu_load,
+	 * and the sample was read through the uncompensated offset. Fold
+	 * it in (scaled as adjust_tsc_offset_host() would), since
+	 * __kvm_synchronize_tsc() clears the pending adjustment as
+	 * superseded by the absolute offset installed here. A
+	 * user-initiated value is the desired guest TSC *now*, and needs
+	 * no correction.
+	 */
+	if (unlikely(vcpu->arch.tsc_offset_adjustment) &&
+	    value && !user_initiated)
+		data += kvm_scale_tsc(vcpu->arch.tsc_offset_adjustment,
+				      vcpu->arch.l1_tsc_scaling_ratio);
 
 	offset = kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
+
+	/*
+	 * The {host_tsc, ns} reference may have been sampled before a
+	 * concurrent synchronization (on another vCPU) opened a newer
+	 * generation, making the elapsed time negative. The anchored
+	 * offset above is still exact either way; extrapolate the
+	 * generation's line backwards for the matching comparison, so
+	 * that the error stays at |F1-F2| times the sampling skew.
+	 * Snapping to the generation's origin instead would inflate it
+	 * to the full guest frequency times the skew, spuriously
+	 * splitting the generation when two vCPUs race through
+	 * KVM_SET_TSC_KHZ.
+	 */
 	elapsed = ns - kvm->arch.cur_tsc_nsec;
 
 	if (vcpu->arch.virtual_tsc_khz) {
-		if (data == 0) {
+		/*
+		 * Keep the cycle count as a magnitude with the sign taken
+		 * from @elapsed itself: a genuinely huge positive elapsed
+		 * time (a u32-limit frequency and a weeks-old generation)
+		 * must extrapolate mod 2^64, as the guest's real TSC
+		 * would wrap, not read as negative.
+		 */
+		elapsed_cycles = nsec_to_cycles(vcpu, elapsed >= 0 ? elapsed
+								   : -elapsed);
+
+		if (!value || (data == 0 && user_initiated)) {
 			/*
-			 * Force synchronization when creating a vCPU, or when
-			 * userspace explicitly writes a zero value.
+			 * Force synchronization when creating a vCPU, or
+			 * when userspace explicitly writes a zero value —
+			 * but not for an internal preserved sample which
+			 * happens to be exactly zero: NULL, not zero, is
+			 * the no-value case.
 			 */
 			synchronizing = true;
-		} else if (kvm->arch.user_set_tsc) {
-			u64 tsc_exp = kvm->arch.cur_tsc_write +
-						nsec_to_cycles(vcpu, elapsed);
+		} else if (kvm->arch.user_set_tsc || !user_initiated) {
+			u64 tsc_exp = elapsed >= 0 ?
+				kvm->arch.cur_tsc_write + elapsed_cycles :
+				kvm->arch.cur_tsc_write - elapsed_cycles;
 			u64 tsc_hz = vcpu->arch.virtual_tsc_khz * 1000LL;
+			u64 window;
 			/*
 			 * Here lies UAPI baggage: when a user-initiated TSC write has
 			 * a small delta (1 second) of virtual cycle time against the
@@ -1559,9 +1708,35 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
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
+			 * second. Use a 1ms window for those, unconditionally —
+			 * the sample's exactness owes nothing to the legacy API's
+			 * flag. A frequency *change* still only matches siblings
+			 * converted within 1ms·F2/|F1-F2| of the first: values
+			 * preserved from the old frequency genuinely diverge from
+			 * the new generation's line at |F1-F2| per unit time.
 			 */
-			synchronizing = data < tsc_exp + tsc_hz &&
-					data + tsc_hz > tsc_exp;
+			/*
+			 * 1ms of cycles is virtual_tsc_khz by definition;
+			 * dividing tsc_hz would need libgcc's __udivdi3
+			 * on i386.
+			 */
+			window = user_initiated ? tsc_hz :
+						  vcpu->arch.virtual_tsc_khz;
+			/*
+			 * Wrap-safe |data - tsc_exp| < window: tsc_exp
+			 * may itself have wrapped when elapsed_cycles is
+			 * negative and exceeds the generation's origin
+			 * value; the difference is still correct mod 2^64.
+			 */
+			synchronizing = (u64)(data - tsc_exp + window) <
+					2 * window;
 		}
 	}
 
@@ -1579,10 +1754,19 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 		 * "now": the matching window slides forward with wall time,
 		 * anchored on the generation's origin alone (a matched
 		 * write no longer updates any stored reference point).
+		 * A negative elapsed time (the tuple sampled just
+		 * before a sibling opened this generation) must not wrap
+		 * below zero: the wrapped value would land in
+		 * last_guest_tsc, and an unstable-TSC host would
+		 * re-anchor the guest TSC to it at the next vcpu_load.
 		 */
-		u64 delta = nsec_to_cycles(vcpu, elapsed);
-
-		data = kvm->arch.cur_tsc_write + delta;
+		if (elapsed < 0 &&
+		    elapsed_cycles > kvm->arch.cur_tsc_write)
+			data = 0;
+		else if (elapsed < 0)
+			data = kvm->arch.cur_tsc_write - elapsed_cycles;
+		else
+			data = kvm->arch.cur_tsc_write + elapsed_cycles;
 
 		if (!kvm_check_tsc_unstable())
 			offset = kvm->arch.cur_tsc_offset;
@@ -1591,8 +1775,38 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 		matched = true;
 	}
 
-	__kvm_synchronize_tsc(vcpu, offset, data, ns, matched, !!user_value);
-	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
+	__kvm_synchronize_tsc(vcpu, offset, data, ns, matched, user_initiated);
+}
+
+static void kvm_synchronize_tsc_at(struct kvm_vcpu *vcpu, u64 *value,
+				   u64 host_tsc, s64 ns, bool user_initiated)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&vcpu->kvm->arch.tsc_write_lock, flags);
+	__kvm_synchronize_tsc_at(vcpu, value, host_tsc, ns, user_initiated);
+	raw_spin_unlock_irqrestore(&vcpu->kvm->arch.tsc_write_lock, flags);
+}
+
+void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *value, bool user_initiated)
+{
+	u64 host_tsc;
+	s64 ns;
+
+#ifdef CONFIG_X86_64
+	if (!kvm_get_time_and_clockread(&ns, &host_tsc))
+#endif
+	{
+		unsigned long flags;
+
+		/* The two reads must form one coherent reference point. */
+		local_irq_save(flags);
+		host_tsc = rdtsc();
+		ns = get_kvmclock_base_ns();
+		local_irq_restore(flags);
+	}
+
+	kvm_synchronize_tsc_at(vcpu, value, host_tsc, ns, user_initiated);
 }
 
 #ifdef CONFIG_X86_64
@@ -4035,7 +4249,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (user_tsc_khz == 0)
 			user_tsc_khz = tsc_khz;
 
-		if (!kvm_set_tsc_khz(vcpu, user_tsc_khz))
+		if (!kvm_set_tsc_khz(vcpu, user_tsc_khz, false))
 			r = 0;
 
 		goto out;
@@ -9814,7 +10028,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	kvm_xen_init_vcpu(vcpu);
 	vcpu_load(vcpu);
 	kvm_vcpu_after_set_cpuid(vcpu);
-	kvm_set_tsc_khz(vcpu, vcpu->kvm->arch.default_tsc_khz);
+	kvm_set_tsc_khz(vcpu, vcpu->kvm->arch.default_tsc_khz, true);
 	kvm_vcpu_reset(vcpu, false);
 	kvm_init_mmu(vcpu);
 	vcpu_put(vcpu);
@@ -9873,7 +10087,7 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
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

