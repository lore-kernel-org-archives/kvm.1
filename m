Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420578;
	b=qv5Ny6a76gTy0m0Wx7ZkUAMXKBudH1Mr3GKgfCt3RtdOGvYOkj3PZyLg1kyRZ73nS6PB
	 GekV4qJMDiem6nu10VHaMVr1WY7OjdRXmMqIjQnsk5oTYg2ZYdwYioxiGkj/PAjLQUnyM
	 wJfCe17scA8Xbe3pNVbw6qVpgtlu15Rqm60EU45wUIDuv7PGBbUfBz7W/OuXi+EYGaODi
	 hMef3oUsmxdRBi4kVK5rXJJRu+QAiXg79dUZk4+BIhClOpxoYka/v4kDYjSafgDGfOPJR
	 le8cq/nw1C2fn7oqxcrFeAQNPIVzWS40ClGYgWTF9xnDRmKrMb3fMrs5+8NT6t3zgDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420578;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=w+W4pvjVAWxDYqCzpcYD1NsnQ13Ri18fxSzd9QQRmFk=;
	b=QWYgc3dvV1193h/j436goxCpXkdO/DhLIElgYPnnhCTTiEzcGRI+5Kbq2CDG4H8Wm123
	 YU9D+wu+4kbnTbCw6oxDxdwgXIYU19W5ALQKkph70t2nTEwsmI57jZYvmEmNtwwbiqra3
	 drqtLcyMof6D+JFDQBgnTg/6wAg8fZ2rFHbaXlcI5X/k+xlJHl8jMLumgE0aVLCqlT5KL
	 pfYYrT7CowWJBufrpUkSoTdPXyzshojKoo2BZJZMnY1DlW3sg6oR6j6GxLAtI4ayNAU4z
	 ZF56ZToSi47u40twTcQWQEp/UgBPPgmEolv8uGhyhlwdUZVxvb5Rk+Kfamxbtjkumkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=QQ2qW0AU;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36717606B780;
	Wed, 11 Nov 2026 18:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36717606B780
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=QQ2qW0AU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=w+W4pvjVAWxDYqCzpcYD1NsnQ13Ri18fxSzd9QQRmFk=; b=QQ2qW0AUSVZF/Ix0kIAJF8qbiJ
	ABlCe+x/aOGBFABmHGw2uGR9P1uXXK3g6hnrl7eAMfWi8MkGOKZDTQECOpw6dBFDpNnqvxCOgqShq
	D2h6qVeUNWiMjybTvbM2KFs0OXGwAMa1oT5rL2Nq+Wn6JPrfWR80Ip6TTbvfXVo7Y91/wkgN7oPq3
	zd6qxEc+/SmDGUkUfIM3z6ok8uTZ1d6WUGsM537f5yTLQI/XSUWGEZ54ELhCo4kqkZuHWwLh3e9mO
	rxVjF/yB8lwfAR1vb3J/RA+teE7sD//eNF5Gask0vdSb2l2iSh5h9i8/2XggBXUkDO2UYeXrd7vab
	rEZ6i4FQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRClB-00000009PvJ-3BI0;
	Wed, 11 Nov 2026 18:09:25 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRCl8-0000000HWsC-3ay4;
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
Subject: [PATCH v13 03/26] KVM: x86: Replace nr_vcpus_matched_tsc count with all_vcpus_matched_tsc bool
Date: Wed, 11 Nov 2026 10:08:59 -0800
Message-ID: <20261111180922.4177927-4-dwmw2@infradead.org>
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

Comparing nr_vcpus_matched_tsc against kvm->online_vcpus at read time
was always racy — a new vCPU can appear between the increment and its
first synchronization — and it made "all vCPUs matched" an accident of
arithmetic rather than a property with defined semantics. Replace it
with a boolean maintained at synchronization time under tsc_write_lock:
set in kvm_track_tsc_matching(), cleared when a new generation opens,
consumed by pvclock_update_vm_gtod_copy(). The count remains as the
input from which the flag is computed, and for the trace event.

The consistent interface is the point. The flag starts true at VM
creation, so a VM whose vCPUs never synchronize — a protected guest
TSC (TDX, SNP Secure TSC) returns early from __kvm_synchronize_tsc() —
is eligible for PVCLOCK_TSC_STABLE_BIT by design rather than by luck
of the read-time arithmetic, and use_master_clock is true from VM
creation on a TSC-clocksource host, before any vCPU exists; later
patches build on exactly that. The default scaling ratio must then be
initialized too (a zero ratio zeroes tsc_hz and turns the master clock
straight back off), and the khz/ratio bookkeeping recorded even for a
protected guest TSC: it is host-side state, which a scaled protected
guest must not leave at the host's unscaled frequency.

The cached state needs care at vCPU creation: the new vCPU is counted
in online_vcpus before it is synchronized, and userspace taking
vcpu->mutex first can hold that window open across a whole first
KVM_RUN. Clear the matched state up front in postcreate — the old
read-time comparison failed conservatively false throughout — and let
the synchronization (or a racing host-initiated TSC write on the
already-live fd) re-latch it; a postcreate aborted by a fatal signal
just propagates whatever the state then is with a masterclock update.
Only the instants between the online_vcpus increment and the clear
remain stale-true.

The explicit clear at new-generation start is currently overwritten by
the unconditional recompute in kvm_track_tsc_matching(); it is
preparation for later patches which consume the previous value.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |  6 ++-
 arch/x86/kvm/x86.c              | 76 +++++++++++++++++++++++++++------
 2 files changed, 67 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index ea48b1949316..18d7bb9fd8d2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1232,8 +1232,9 @@ struct kvm_arch {
 	s64 kvmclock_offset;
 
 	/*
-	 * This also protects nr_vcpus_matched_tsc which is read from a
-	 * preemption-disabled region, so it must be a raw spinlock.
+	 * This also protects nr_vcpus_matched_tsc and
+	 * all_vcpus_matched_tsc, which are read from preemption-disabled
+	 * regions, so it must be a raw spinlock.
 	 */
 	raw_spinlock_t tsc_write_lock;
 	u32 cur_tsc_khz;
@@ -1242,6 +1243,7 @@ struct kvm_arch {
 	u64 cur_tsc_write;
 	u64 cur_tsc_offset;
 	u64 cur_tsc_generation;
+	bool all_vcpus_matched_tsc;
 	int nr_vcpus_matched_tsc;
 
 	u32 default_tsc_khz;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 12f465040efc..1bb0136042a6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1125,8 +1125,10 @@ static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool new_generation)
 	 * and all vCPUs must have matching TSCs.  Note, the count for matching
 	 * vCPUs doesn't include the reference vCPU, hence "+1".
 	 */
-	bool use_master_clock = (ka->nr_vcpus_matched_tsc + 1 ==
-				 atomic_read(&vcpu->kvm->online_vcpus)) &&
+	ka->all_vcpus_matched_tsc = (ka->nr_vcpus_matched_tsc + 1 ==
+				     atomic_read(&vcpu->kvm->online_vcpus));
+
+	bool use_master_clock = ka->all_vcpus_matched_tsc &&
 				gtod_is_based_on_tsc(gtod->clock.vclock_mode);
 
 	/*
@@ -1327,20 +1329,23 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 
 	lockdep_assert_held(&kvm->arch.tsc_write_lock);
 
-	if (vcpu->arch.guest_tsc_protected)
-		return;
-
-	if (user_set_tsc)
-		vcpu->kvm->arch.user_set_tsc = true;
-
 	/*
-	 * Track the TSC frequency, scaling ratio, and offset for the current
+	 * Track the TSC frequency and scaling ratio for the current
 	 * generation. These are used to detect matching TSC writes and to
-	 * compute the guest TSC from the host clock.
+	 * compute the guest TSC from the host clock. This is host-side
+	 * bookkeeping, recorded even for a protected guest TSC — a scaled
+	 * protected guest (TDX, SNP Secure TSC) must not leave the master
+	 * clock computing with the host's unscaled frequency.
 	 */
 	kvm->arch.cur_tsc_khz = vcpu->arch.virtual_tsc_khz;
 	kvm->arch.cur_tsc_scaling_ratio = vcpu->arch.l1_tsc_scaling_ratio;
 
+	if (vcpu->arch.guest_tsc_protected)
+		return;
+
+	if (user_set_tsc)
+		vcpu->kvm->arch.user_set_tsc = true;
+
 	vcpu->arch.last_guest_tsc = tsc;
 
 	/*
@@ -1367,6 +1372,7 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 		kvm->arch.cur_tsc_write = tsc;
 		kvm->arch.cur_tsc_offset = offset;
 		kvm->arch.nr_vcpus_matched_tsc = 0;
+		kvm->arch.all_vcpus_matched_tsc = false;
 	} else if (vcpu->arch.this_tsc_generation != kvm->arch.cur_tsc_generation) {
 		kvm->arch.nr_vcpus_matched_tsc++;
 	}
@@ -1593,8 +1599,7 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 	bool host_tsc_clocksource, vcpus_matched;
 
 	lockdep_assert_held(&kvm->arch.tsc_write_lock);
-	vcpus_matched = (ka->nr_vcpus_matched_tsc + 1 ==
-			atomic_read(&kvm->online_vcpus));
+	vcpus_matched = ka->all_vcpus_matched_tsc;
 
 	/*
 	 * If the host uses TSC clock, then passthrough TSC as stable
@@ -9584,8 +9589,38 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 {
-	if (mutex_lock_killable(&vcpu->mutex))
+	struct kvm_arch *ka = &vcpu->kvm->arch;
+	unsigned long flags;
+
+	/*
+	 * The new vCPU is already counted in online_vcpus but has not
+	 * been synchronized. Clear the cached matched state before
+	 * trying the mutex: the old read-time comparison failed
+	 * conservatively false throughout this window, and userspace
+	 * can hold it open across a whole first KVM_RUN by taking
+	 * vcpu->mutex before we do. The synchronization below (or any
+	 * racing host-initiated TSC write on the already-live fd)
+	 * re-latches the flags. A protected guest TSC never
+	 * participates in offset matching, so for it there is nothing
+	 * to clear — and no later sync to re-latch.
+	 */
+	if (!vcpu->arch.guest_tsc_protected) {
+		raw_spin_lock_irqsave(&ka->tsc_write_lock, flags);
+		WRITE_ONCE(ka->all_vcpus_matched_tsc, false);
+		raw_spin_unlock_irqrestore(&ka->tsc_write_lock, flags);
+	}
+
+	if (mutex_lock_killable(&vcpu->mutex)) {
+		/*
+		 * Aborted by a fatal signal: the synchronization never
+		 * ran. Propagate whatever the matched state now is (a
+		 * racing TSC write may have re-latched it), so the
+		 * master clock does not stay in its previous mode with
+		 * running siblings keeping PVCLOCK_TSC_STABLE_BIT.
+		 */
+		kvm_update_masterclock(vcpu->kvm);
 		return;
+	}
 	vcpu_load(vcpu);
 	kvm_synchronize_tsc(vcpu, NULL);
 	if (kvm_check_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu))
@@ -10061,6 +10096,21 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	ratelimit_set_flags(&kvm->arch.kvmclock_update_rs, RATELIMIT_MSG_ON_RELEASE);
 	kvm->arch.kvmclock_offset = -get_kvmclock_base_ns();
 
+	/*
+	 * Start with all (zero) vCPUs considered matched, so that a VM whose
+	 * vCPUs never reach kvm_track_tsc_matching() — notably when the guest
+	 * TSC is protected (TDX, SNP Secure TSC) and __kvm_synchronize_tsc()
+	 * returns early — is still eligible for PVCLOCK_TSC_STABLE_BIT. The
+	 * scaling ratio must then also be initialized: with vcpus_matched
+	 * now true here, pvclock_update_vm_gtod_copy() reaches the scaling
+	 * path, and a zero ratio would zero tsc_hz and turn the master
+	 * clock straight back off (permanently so for protected-TSC guests,
+	 * whose syncs return before kvm_track_tsc_matching() ever requests
+	 * the masterclock update that would recompute it).
+	 */
+	kvm->arch.all_vcpus_matched_tsc = true;
+	kvm->arch.cur_tsc_scaling_ratio = kvm_caps.default_tsc_scaling_ratio;
+
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
 	pvclock_update_vm_gtod_copy(kvm);
 	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
-- 
2.43.0

