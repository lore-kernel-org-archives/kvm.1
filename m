Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187289;
	b=IF8pDGggSx5LehPXPfwdXeHyy1HbLQ7NL+JN4endjB7myrIPU0VE6kjSopimn/dVVyDG
	 N0+DVXqKPYDpTMgxvn0Rg/KZZMyWAPtIxV6jkIgdRUfi+FsGrjGheIHk6+S8R/R13Zk6r
	 qg+8kRqqnSTigLY6IvVES1VBVN10DH2gurUaaq2IWdwSt6ytpe/Pc0hocwS49TtHsnMRb
	 VUGGVFQXGBARCinXoTg2fXdw+fFON+CjUld6Hz9UJpZf6O2GB4p0bfv5uBtkA7TCDjuIi
	 pV6S38vVzLZCFS1zAmVOofvYk59PnTojAvXlOHf6R59zo93BJ8cY++VVVSClWsLJtbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187289;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=gSB/Q9g2yibJwD9klPXFy+4TUZDSE+Oz1s1D+60pOVU=;
	b=dQbz55ZxDpsg5s7POC2AoLFTpSfiCRIFFSusRfnNKfJEEG3JYIFUShZoN4mBdZfzCZ/r
	 RWWdSFMNZEGJJm90X1daFQLKyo/HQ5BCFuZq07Vuc1rJnE009ExzHVZTUMe6wAg/trvNc
	 l4eVlEYIVVVPnHn5MzaWmsfzs0WmgX4izvg+/hgPGG1m8h790ygU5qBQ3w2Zn+AHBrpbc
	 4mcFcAN9wAaCOAZOuEr51Nk4nPMs9kbYXZwtWvK1XcoC09xXomWbKNAj1F5mXS1asCxyL
	 DU52hXmoR4hTlCIkBVN0ZSgg/4yqVnwuajfnrK3ek61SujviGyccgJoJv354rtWaSgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=o3dyt0zt;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C5F606EE8C;
	Mon,  9 Nov 2026 01:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49C5F606EE8C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=o3dyt0zt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=gSB/Q9g2yibJwD9klPXFy+4TUZDSE+Oz1s1D+60pOVU=; b=o3dyt0zte310tj+0K/tp82gDvN
	s8TRU8MMU+xs4tLlXEcOzm2ycUUHAog6y2O8bEieNbhSRQLJqe1u69KnP40/zOZ1B8+meeGlal9TA
	jVU4kwLCjKEIt7sSHiTgMoC2uzq5i2IJ9Vmx3cwG0BHfIrEHL0KvQj4NFEtqrjiXd3ybW/SBm+Ad8
	wFaJoXTF0u1aMD9gabOvdlgGuYCNhBFMOZYxvsiGvlZ3mpKDZYFBonE/G6CVgx+UwPR1Wiw7s4BB0
	29LTjnwbaxcNkJiSlDU9BFypwqeNAsbjpMSTmUAbcOMtX4hIwkZN9U1ZtqpRb6EY7t6L5PIcckGOY
	JKevFVRQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQE4Q-00000006AY7-27ye;
	Mon, 09 Nov 2026 01:21:15 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xQE4O-0000000EKUD-2CZT;
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
Subject: [PATCH v12 03/24] KVM: x86: Replace nr_vcpus_matched_tsc count with all_vcpus_matched_tsc bool
Date: Sun,  8 Nov 2026 17:20:49 -0800
Message-ID: <20261109012112.3415328-4-dwmw2@infradead.org>
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

Using a count and comparing with kvm->online_vcpus was always racy
because a new vCPU could be created while kvm_track_tsc_matching() was
running and comparing with kvm->online_vcpus. That variable is only
atomic with respect to itself; kvm_arch_vcpu_create() runs before
kvm->online_vcpus is incremented for the new vCPU.

Replace the count with a boolean that is set in kvm_track_tsc_matching()
after comparing the count, and cleared when a new TSC generation starts.
The boolean is consumed by pvclock_update_vm_gtod_copy() under the
tsc_write_lock, which serializes against __kvm_synchronize_tsc().

Keep the count for now as it's still used in the trace event.

Note that the explicit clear of the flag when a new generation starts
is currently overwritten by the unconditional recompute in
kvm_track_tsc_matching() under the same lock; it is preparation for
subsequent patches which consume the previous value of the flag.

Initialize the flag to true at VM creation: a VM whose vCPUs never
reach kvm_track_tsc_matching() — notably with a protected guest TSC
(TDX, SNP Secure TSC), where __kvm_synchronize_tsc() returns early —
would otherwise never be eligible for PVCLOCK_TSC_STABLE_BIT, where
the old read-time computation gave 0 + 1 == 1 for a single-vCPU VM.

Initializing the flag to true means pvclock_update_vm_gtod_copy() now
reaches its scaling path from kvm_arch_init_vm(), where the scaling
ratio is still zero from allocation; initialize it to the default
ratio at the same point, since a zero ratio would zero tsc_hz and turn
the master clock straight back off — permanently for protected-TSC
guests, whose vCPUs never write the ratio in __kvm_synchronize_tsc().

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/x86.c              | 41 +++++++++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index ea48b1949316..1efca01647d2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1242,6 +1242,7 @@ struct kvm_arch {
 	u64 cur_tsc_write;
 	u64 cur_tsc_offset;
 	u64 cur_tsc_generation;
+	bool all_vcpus_matched_tsc;
 	int nr_vcpus_matched_tsc;
 
 	u32 default_tsc_khz;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 20b84b2e4424..d29e5bc75f7a 100644
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
@@ -1367,6 +1369,7 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 		kvm->arch.cur_tsc_write = tsc;
 		kvm->arch.cur_tsc_offset = offset;
 		kvm->arch.nr_vcpus_matched_tsc = 0;
+		kvm->arch.all_vcpus_matched_tsc = false;
 	} else if (vcpu->arch.this_tsc_generation != kvm->arch.cur_tsc_generation) {
 		kvm->arch.nr_vcpus_matched_tsc++;
 	}
@@ -1593,8 +1596,7 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 	bool host_tsc_clocksource, vcpus_matched;
 
 	lockdep_assert_held(&kvm->arch.tsc_write_lock);
-	vcpus_matched = (ka->nr_vcpus_matched_tsc + 1 ==
-			atomic_read(&kvm->online_vcpus));
+	vcpus_matched = ka->all_vcpus_matched_tsc;
 
 	/*
 	 * If the host uses TSC clock, then passthrough TSC as stable
@@ -9552,8 +9554,23 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 {
-	if (mutex_lock_killable(&vcpu->mutex))
+	if (mutex_lock_killable(&vcpu->mutex)) {
+		/*
+		 * The new vCPU is already counted in online_vcpus but has
+		 * not been synchronized. Nothing recomputes the cached
+		 * matched state against the raised count until the next
+		 * synchronization, so clear it here rather than leave the
+		 * clock advertised as matched while an unmatched vCPU is
+		 * runnable. It heals when this vCPU first synchronizes.
+		 */
+		struct kvm_arch *ka = &vcpu->kvm->arch;
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&ka->tsc_write_lock, flags);
+		WRITE_ONCE(ka->all_vcpus_matched_tsc, false);
+		raw_spin_unlock_irqrestore(&ka->tsc_write_lock, flags);
 		return;
+	}
 	vcpu_load(vcpu);
 	kvm_synchronize_tsc(vcpu, NULL);
 	if (kvm_check_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu))
@@ -10029,6 +10046,20 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
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
+	 * which never write the ratio in __kvm_synchronize_tsc()).
+	 */
+	kvm->arch.all_vcpus_matched_tsc = true;
+	kvm->arch.cur_tsc_scaling_ratio = kvm_caps.default_tsc_scaling_ratio;
+
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
 	pvclock_update_vm_gtod_copy(kvm);
 	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
-- 
2.43.0

