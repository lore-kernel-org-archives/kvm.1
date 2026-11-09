Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187289;
	b=jbCA5YRQhL9zNiXoTMToqY63T987UOS5rbLB0RYA+Cw1GZXORZ0suP1Hwqwa+GwxVAil
	 Pp+bVVbxuVPoattn4yU5rXEX2k8C3wr9fsa1TU03RzVq13VPp6H6Qi3VDH6sV7fW8WFMa
	 ayPNm+uMdJF+YaJfMxeI9rv8Z+UNi5G3C+a47BT896ql2W4Gf6vCd0YWjGKocMOczLnIz
	 S2uMlxxFvp7i2aj+9vvtSmlbsNKnFKEbYn/bxBk6YG79nE2nsvwhe0fHQ85xGjhXfFTll
	 tj151ri7VJWjK/6rLSGMa21a3a/UkKCBJbSfnJe12GUcgOgtNXybo5BH7mA4FmxqhMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187289;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=m2fbPc6XHvWEP1WHR95w78T0mzWK9qb5UsTlN179DUY=;
	b=TYjlimOwo5Dt9ILrkeK6/hv8rnfsgNkMj4cHgiv61ZZolBCYb0K5raM7VAuCJFZGKEQT
	 ZBDQlsQeBARFeYNwKM01pNz7aySVr9gVpcUdh3sjdkDCbDFAGEfm1h2a5OII/zry1U2SS
	 /fNsNuHig5/jxsPw69ULJt4dtMIkojKYfpx6g+VEiRlZ6eH5688XkRpAACfoHqUCHTOns
	 oPCsnlFrUI7HaZ1rsTARB7klhYjwPxi/tCLo8Z2ZTxOAYIHWvSnSRDAHndZ1NSu5oByTn
	 1tsdUU1GNcKHz6aiKbHsNVgkuZUsdoZeT8LWrGtoLuFHLxOshphDhfil0aKe1u0gq/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=ES5u6lWg;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B669606EE8E;
	Mon,  9 Nov 2026 01:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B669606EE8E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=ES5u6lWg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=m2fbPc6XHvWEP1WHR95w78T0mzWK9qb5UsTlN179DUY=; b=ES5u6lWgnx208h9BxW/VwpJR5g
	8d08nYWsbfhFvE/O7fc+yaqoNW1lLrLEl/0OQzyYjYxyTLUJtXTJcXIHNIxtiqifmlZBfaRpoPD1C
	HhpghyN22R2EJTLAy7LAOB56Hy2XU+N87HG99MKut7ywYNppf/DJjVyO8AUGSTcHDuMYhHfViOpbL
	yN6Zc3KPyEqPvdoiJE4jFYzVbEcFzNwoYfomqU0NNfe0anix1ZA/lTLYtxGjCCmiNHgbq4pKQihcI
	xWc2eiCUP7m5PmDD7dAOzsloyNIHzM1SHPcPeL4MwAkIAS4LWXVfkpQtK2K20ZDJox/O8MkNzNpo7
	3IPjDGGw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQE4Q-00000006AY8-28SP;
	Mon, 09 Nov 2026 01:21:15 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xQE4O-0000000EKUA-23cT;
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
Subject: [PATCH v12 02/24] KVM: x86: Kill last_tsc_{nsec,write,offset} fields
Date: Sun,  8 Nov 2026 17:20:48 -0800
Message-ID: <20261109012112.3415328-3-dwmw2@infradead.org>
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

These mostly duplicate the cur_tsc_{nsec,write,offset} values. In the
matching paths for a stable TSC, the values used were definitely
identical. On the unstable-TSC paths the two could diverge (a matched
synchronization recorded its freshly computed offset in last_tsc_offset
while cur_tsc_offset kept the generation's reference), so matching in
kvm_arch_tsc_set_attr() now compares against the generation's reference
offset instead. With an unstable TSC the master clock is off and the
match only affects generation accounting, and matching against the
generation's own reference is the more principled behaviour anyway.

Rename last_tsc_khz and last_tsc_scaling_ratio to cur_tsc_khz and
cur_tsc_scaling_ratio respectively, since they are properties of the
current TSC generation.

Since cur_tsc_offset now serves as the single source of truth for the
TSC generation's offset, the backwards-TSC adjustment (used during S4
resume when the host TSC resets) must also update cur_tsc_offset by
the same delta applied to all vCPUs (scaled to the guest TSC rate, as
adjust_tsc_offset_host() does). Without this, subsequent vCPUs that
synchronize after the adjustment would get the stale pre-S4 offset.

Since a synchronization now establishes an absolute offset which (via
a matched reuse of cur_tsc_offset) already includes any backwards-TSC
delta, clear the vCPU's pending tsc_offset_adjustment when writing it:
the deferred per-vCPU compensation would otherwise be applied on top
at the next vcpu_load, doubling the delta. Previously a nonzero write
could not hit this, because zeroing the last_tsc values broke the
1-second matching window after a backwards TSC; a forced
synchronization (vCPU creation, or a zero write) could always match,
and takes the compensated offset as intended.

The lockless vm_list walk in kvm_arch_enable_virtualization_cpu() is
unsound against a concurrent kvm_destroy_vm(), but that predates this
patch and is not made materially worse by it; it cannot be fixed by
taking kvm_lock here, which would recreate the lock inversion against
cpus_read_lock() that commit 44d174596260 ("KVM: Use dedicated mutex
to protect kvm_usage_count to avoid deadlock") untangled.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 Documentation/virt/kvm/locking.rst |  2 +-
 arch/x86/include/asm/kvm_host.h    |  7 +--
 arch/x86/kvm/x86.c                 | 98 +++++++++++++++++++++---------
 3 files changed, 71 insertions(+), 36 deletions(-)

diff --git a/Documentation/virt/kvm/locking.rst b/Documentation/virt/kvm/locking.rst
index 662231e958a0..4548b61a7652 100644
--- a/Documentation/virt/kvm/locking.rst
+++ b/Documentation/virt/kvm/locking.rst
@@ -263,7 +263,7 @@ time it will be set using the Dirty tracking mechanism described above.
 
 :Type:		raw_spinlock_t
 :Arch:		x86
-:Protects:	- kvm_arch::{last_tsc_write,last_tsc_nsec,last_tsc_offset}
+:Protects:	- kvm_arch::{cur_tsc_write,cur_tsc_nsec,cur_tsc_offset}
 		- tsc offset in vmcb
 :Comment:	'raw' because updating the tsc offsets must not be preempted.
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e2eef7057bd3..ea48b1949316 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1236,11 +1236,8 @@ struct kvm_arch {
 	 * preemption-disabled region, so it must be a raw spinlock.
 	 */
 	raw_spinlock_t tsc_write_lock;
-	u64 last_tsc_nsec;
-	u64 last_tsc_write;
-	u32 last_tsc_khz;
-	u64 last_tsc_offset;
-	u64 last_tsc_scaling_ratio;
+	u32 cur_tsc_khz;
+	u64 cur_tsc_scaling_ratio;
 	u64 cur_tsc_nsec;
 	u64 cur_tsc_write;
 	u64 cur_tsc_offset;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7a2b0b99373f..20b84b2e4424 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1334,17 +1334,24 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 		vcpu->kvm->arch.user_set_tsc = true;
 
 	/*
-	 * We also track th most recent recorded KHZ, write and time to
-	 * allow the matching interval to be extended at each write.
+	 * Track the TSC frequency, scaling ratio, and offset for the current
+	 * generation. These are used to detect matching TSC writes and to
+	 * compute the guest TSC from the host clock.
 	 */
-	kvm->arch.last_tsc_nsec = ns;
-	kvm->arch.last_tsc_write = tsc;
-	kvm->arch.last_tsc_khz = vcpu->arch.virtual_tsc_khz;
-	kvm->arch.last_tsc_offset = offset;
-	kvm->arch.last_tsc_scaling_ratio = vcpu->arch.l1_tsc_scaling_ratio;
+	kvm->arch.cur_tsc_khz = vcpu->arch.virtual_tsc_khz;
+	kvm->arch.cur_tsc_scaling_ratio = vcpu->arch.l1_tsc_scaling_ratio;
 
 	vcpu->arch.last_guest_tsc = tsc;
 
+	/*
+	 * The offset written below is absolute, superseding any backwards-TSC
+	 * compensation still pending from kvm_arch_enable_virtualization_cpu()
+	 * (which has already been folded into cur_tsc_offset, and thus into
+	 * a matched @offset); applying it again at the next vcpu_load would
+	 * double it.
+	 */
+	vcpu->arch.tsc_offset_adjustment = 0;
+
 	kvm_vcpu_write_tsc_offset(vcpu, offset);
 
 	if (!matched) {
@@ -1354,8 +1361,6 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 		 * nanosecond time, offset, and write, so if TSCs are in
 		 * sync, we can match exact offset, and if not, we can match
 		 * exact software computation in compute_guest_tsc()
-		 *
-		 * These values are tracked in kvm->arch.cur_xxx variables.
 		 */
 		kvm->arch.cur_tsc_generation++;
 		kvm->arch.cur_tsc_nsec = ns;
@@ -1395,7 +1400,7 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 	}
 
 	offset = kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
-	elapsed = ns - kvm->arch.last_tsc_nsec;
+	elapsed = ns - kvm->arch.cur_tsc_nsec;
 
 	if (vcpu->arch.virtual_tsc_khz) {
 		if (data == 0) {
@@ -1405,7 +1410,7 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 			 */
 			synchronizing = true;
 		} else if (kvm->arch.user_set_tsc) {
-			u64 tsc_exp = kvm->arch.last_tsc_write +
+			u64 tsc_exp = kvm->arch.cur_tsc_write +
 						nsec_to_cycles(vcpu, elapsed);
 			u64 tsc_hz = vcpu->arch.virtual_tsc_khz * 1000LL;
 			/*
@@ -1436,15 +1441,14 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 	 * it's better to try to match offsets from the beginning.
          */
 	if (synchronizing &&
-	    vcpu->arch.virtual_tsc_khz == kvm->arch.last_tsc_khz) {
+	    vcpu->arch.virtual_tsc_khz == kvm->arch.cur_tsc_khz) {
 		/*
-		 * If synchronizing, advance the reference point to "now"
-		 * so the matching window slides forward with each vCPU.
-		 * Extrapolate from the generation's own origin: 'elapsed'
-		 * is measured from the most recent write, which lies on
-		 * the generation's line only for the first matched write.
+		 * If synchronizing, extrapolate the generation's value to
+		 * "now": the matching window slides forward with wall time,
+		 * anchored on the generation's origin alone (a matched
+		 * write no longer updates any stored reference point).
 		 */
-		u64 delta = nsec_to_cycles(vcpu, ns - kvm->arch.cur_tsc_nsec);
+		u64 delta = nsec_to_cycles(vcpu, elapsed);
 
 		data = kvm->arch.cur_tsc_write + delta;
 
@@ -1615,7 +1619,7 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 		 * get_kvmclock() to compute kvmclock from the host TSC
 		 * without needing a vCPU reference.
 		 */
-		ka->master_tsc_scaling_ratio = ka->last_tsc_scaling_ratio;
+		ka->master_tsc_scaling_ratio = ka->cur_tsc_scaling_ratio;
 		tsc_hz = (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
 		if (tsc_hz && kvm_caps.has_tsc_control)
 			tsc_hz = kvm_scale_tsc(tsc_hz,
@@ -3344,8 +3348,8 @@ static int kvm_arch_tsc_set_attr(struct kvm_vcpu *vcpu,
 		raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
 
 		matched = (vcpu->arch.virtual_tsc_khz &&
-			   kvm->arch.last_tsc_khz == vcpu->arch.virtual_tsc_khz &&
-			   kvm->arch.last_tsc_offset == offset);
+			   kvm->arch.cur_tsc_khz == vcpu->arch.virtual_tsc_khz &&
+			   kvm->arch.cur_tsc_offset == offset);
 
 		tsc = kvm_scale_tsc(rdtsc(), vcpu->arch.l1_tsc_scaling_ratio) + offset;
 		ns = get_kvmclock_base_ns();
@@ -9803,7 +9807,7 @@ int kvm_arch_enable_virtualization_cpu(void)
 {
 	struct kvm *kvm;
 	struct kvm_vcpu *vcpu;
-	unsigned long i;
+	unsigned long i, flags;
 	int ret;
 	u64 local_tsc;
 	u64 max_tsc = 0;
@@ -9874,6 +9878,44 @@ int kvm_arch_enable_virtualization_cpu(void)
 	if (backwards_tsc) {
 		u64 delta_cyc = max_tsc - local_tsc;
 		list_for_each_entry(kvm, &vm_list, vm_list) {
+			/*
+			 * Hold tsc_write_lock across the per-vCPU adjustments
+			 * AND the generation reference offset adjustment, so
+			 * that a concurrent TSC synchronization cannot observe
+			 * one without the other (it would compute an offset
+			 * with the delta applied twice, or not at all). The
+			 * consume of tsc_offset_adjustment in
+			 * kvm_arch_vcpu_load() remains outside the lock, as
+			 * it always was; its races are with vcpu_put/load
+			 * ordering, not with the generation state.
+			 *
+			 * The generation's reference offset is adjusted by the
+			 * same (guest-scaled, as adjust_tsc_offset_host()
+			 * does for each vCPU) delta, so that future
+			 * KVM_SET_TSC / vCPU creation still matches against
+			 * the adjusted TSC timeline.
+			 *
+			 * The recorded {cur_tsc_nsec, cur_tsc_write} pair is
+			 * left alone, and ends up stale by the sleep period:
+			 * cur_tsc_nsec is CLOCK_BOOTTIME, which has the sleep
+			 * injected on resume, while the guest TSC (kept
+			 * continuous across the host TSC jump) does not
+			 * advance during the sleep. It cannot be re-anchored
+			 * here because, as noted above, timekeeping has not
+			 * yet been resumed. The 1-second matching window
+			 * therefore fails to match across a longer sleep,
+			 * and the next nonzero TSC write opens a fresh,
+			 * coherent generation. A forced synchronization
+			 * (vCPU creation, or a zero write) bypasses the
+			 * window and does extrapolate along the stale line,
+			 * overshooting by the sleep period — but it installs
+			 * the compensated offset, so the vCPU's actual TSC
+			 * is correct; only last_guest_tsc overshoots, which
+			 * matters only if the TSC turns unstable before the
+			 * vCPU first enters the guest, exactly as it did
+			 * before this accounting existed.
+			 */
+			raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
 			kvm->arch.backwards_tsc_observed = true;
 			kvm_for_each_vcpu(i, vcpu, kvm) {
 				vcpu->arch.tsc_offset_adjustment += delta_cyc;
@@ -9881,14 +9923,10 @@ int kvm_arch_enable_virtualization_cpu(void)
 				kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
 			}
 
-			/*
-			 * We have to disable TSC offset matching.. if you were
-			 * booting a VM while issuing an S4 host suspend....
-			 * you may have some problem.  Solving this issue is
-			 * left as an exercise to the reader.
-			 */
-			kvm->arch.last_tsc_nsec = 0;
-			kvm->arch.last_tsc_write = 0;
+			kvm->arch.cur_tsc_offset +=
+				kvm_scale_tsc(delta_cyc,
+					      kvm->arch.cur_tsc_scaling_ratio);
+			raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
 		}
 
 	}
-- 
2.43.0

