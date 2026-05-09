Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7D03D904B;
	Sat,  9 May 2026 22:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366947; cv=none; b=EfP837rTZT55u96POCfVo93vWZL5zdfHCVW3mRZrU5akP7rrCWnAH0WAw/yPaiAyiyWxv8k5XDTLiz/OMdx87idCeCf9dTsKirfPA0+apSmHG5bapBm4tm5OyvV2ejy9M6Z6FcCfg+M4hHWca0r9UoWcJLYeBOlMy5/EynVdNw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366947; c=relaxed/simple;
	bh=S+0gG9Ab0padGfYz3qXV4wyWJpsoWxvfS4lsOikGQqk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPisUGw5OhPgndSB0HUjJKPBrH+lLhmZCwujb/du1WztIB272z57aX+90+biIyxDd28gIYKeY2awBTxDjH2VmNGeZ6EPF71A6QyRC90QwygzvZUuSpPZxthFhLrRQsgvAj4DrSrxrSTVUFAMb4z0tQsus6mMa3uuQZSlb6uSK9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S1Qj7ot+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S1Qj7ot+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description;
	bh=kOxo26JgkgBnkgpV4u4u6bNS0TzdmD76LNhTnJ/HBkg=; b=S1Qj7ot+NvaVb/ETnLNcOSWLI7
	a8uV8eSZQIwsFNUiD0HkK8FYHDMAVTpOBbqWewmXi9iTOyErjosby5Pac1eE/QdywtKg3s1IgXLek
	HsNyTFM+ykVPLWmEpjCYTbzPzXkWq2gBFRY2VWy5lSXutf/hfKCAX5QZID2vs2Qba7bmYbLFSYdHJ
	e63CuDfT1qC1GqGhST/XGcE8ayKk2efxCazSVC33178g9UgpHiWeSxDzwAU6HGywcZLQDaNc+JTqO
	f/VY+Sc/cuha12qsM/abTJXD6y2KRPxWwrDd1pwd3HDISKnYc2g96zWw4BFuGCu9pg1BtxPbgj7Dm
	WQFH5k/g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLqTD-00000008wzK-0NIx;
	Sat, 09 May 2026 22:48:28 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLqTD-0000000DhIf-06oU;
	Sat, 09 May 2026 23:48:27 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Jack Allister <jalliste@amazon.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	joe.jin@oracle.com,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 22/30] KVM: x86: Allow KVM master clock mode when TSCs are offset from each other
Date: Sat,  9 May 2026 23:46:48 +0100
Message-ID: <20260509224824.3264567-23-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260509224824.3264567-1-dwmw2@infradead.org>
References: <20260509224824.3264567-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

There is no reason why the KVM clock cannot be in masterclock mode when
the TSCs are not in sync, as long as they are at the same *frequency*.

Running at a different frequency would lead to a systemic skew between
the clock(s) as observed by different vCPUs due to arithmetic precision
in the scaling. So that should indeed force the clock to be based on the
host's CLOCK_MONOTONIC_RAW instead of being in masterclock mode where it
is defined by the guest TSC.

But when the vCPUs merely have a different TSC *offset*, that's not a
problem. The offset is applied to that vCPU's kvmclock->tsc_timestamp
field, and it all comes out in the wash.

Track frequency matching separately from full TSC matching. Use
frequency match for master clock eligibility, and full TSC match
(including offset) only for PVCLOCK_TSC_STABLE_BIT, which tells the
guest it is safe to skip cross-vCPU monotonicity enforcement.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/x86.c              | 27 +++++++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index eb81f90284ba..c770c63087cb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1493,6 +1493,7 @@ struct kvm_arch {
 	u64 cur_tsc_offset;
 	u64 cur_tsc_generation;
 	bool all_vcpus_matched_tsc;
+	bool all_vcpus_matched_freq;
 	int nr_vcpus_matched_tsc;
 
 	u32 default_tsc_khz;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b74fd8b088ad..d36d03b8268e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2647,13 +2647,22 @@ static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool new_generation)
 	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
 
 	/*
-	 * To use the masterclock, the host clocksource must be based on TSC
-	 * and all vCPUs must have matching TSCs.
+	 * Track whether all vCPUs have matching TSC offsets (for
+	 * PVCLOCK_TSC_STABLE_BIT) and matching frequencies (for
+	 * master clock eligibility).
 	 */
 	ka->all_vcpus_matched_tsc = (ka->nr_vcpus_matched_tsc + 1 ==
 				     atomic_read(&vcpu->kvm->online_vcpus));
+	if (ka->all_vcpus_matched_tsc)
+		ka->all_vcpus_matched_freq = true;
 
-	bool use_master_clock = ka->all_vcpus_matched_tsc &&
+	/*
+	 * To use the masterclock, the host clocksource must be based on TSC
+	 * and all vCPUs must have matching TSC *frequency*. Different offsets
+	 * are fine — each vCPU's pvclock has its own tsc_timestamp that
+	 * accounts for its offset.
+	 */
+	bool use_master_clock = ka->all_vcpus_matched_freq &&
 				gtod_is_based_on_tsc(gtod->clock.vclock_mode);
 
 	/*
@@ -2817,7 +2826,13 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 	 * Track the TSC frequency, scaling ratio, and offset for the current
 	 * generation. These are used to detect matching TSC writes and to
 	 * compute the guest TSC from the host clock.
+	 *
+	 * If the frequency changed, master clock mode can no longer be used
+	 * since the kvmclock scaling factors differ between vCPUs.
 	 */
+	if (vcpu->arch.virtual_tsc_khz != kvm->arch.cur_tsc_khz)
+		kvm->arch.all_vcpus_matched_freq = false;
+
 	kvm->arch.cur_tsc_khz = vcpu->arch.virtual_tsc_khz;
 	kvm->arch.cur_tsc_scaling_ratio = vcpu->arch.l1_tsc_scaling_ratio;
 
@@ -3178,7 +3193,7 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 	bool host_tsc_clocksource, vcpus_matched;
 
 	lockdep_assert_held(&kvm->arch.tsc_write_lock);
-	vcpus_matched = ka->all_vcpus_matched_tsc;
+	vcpus_matched = ka->all_vcpus_matched_freq;
 
 	/*
 	 * If the host uses TSC clock, then passthrough TSC as stable
@@ -3513,7 +3528,7 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 
 	/* If the host uses TSC clocksource, then it is stable */
 	hv_clock.flags = 0;
-	if (use_master_clock)
+	if (use_master_clock && ka->all_vcpus_matched_tsc)
 		hv_clock.flags |= PVCLOCK_TSC_STABLE_BIT;
 
 	if (vcpu->pv_time.active) {
@@ -6340,7 +6355,7 @@ static int kvm_vcpu_ioctl_get_clock_guest(struct kvm_vcpu *v, void __user *argp)
 
 	hv_clock.tsc_shift = vcpu->pvclock_tsc_shift;
 	hv_clock.tsc_to_system_mul = vcpu->pvclock_tsc_mul;
-	hv_clock.flags = PVCLOCK_TSC_STABLE_BIT;
+	hv_clock.flags = ka->all_vcpus_matched_tsc ? PVCLOCK_TSC_STABLE_BIT : 0;
 
 	if (copy_to_user(argp, &hv_clock, sizeof(hv_clock)))
 		return -EFAULT;
-- 
2.51.0

