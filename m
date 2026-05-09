Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86EA31AF3B;
	Sat,  9 May 2026 22:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366930; cv=none; b=s6wsUsVP5wZ1U+FwiBOYtSBtZ896nOoxny/N5dkCTSX55vzjZJDgwm/LrglI1X3T6GXYaTikIAOaXg0BVA5++XwX2NCZ66VZJxpY5pdrIpzOHjBeMKddj5xJ4VLUYK2VFcT8MOIv6zFAbZuKirfUnMPNoGddbOJmzh8dS1qcI0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366930; c=relaxed/simple;
	bh=RFCADm3ZcxDNByR14128b6hc8iugQrF0zppiu1uXGG0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8EN4DMJjinT1rTdqG5/ozoT117SDwDmVKtsJ+JevHpSp8vBo1fEkkUFhmbsKsExl3seICOoFPC6DEwMcHpmGOj3UQ7ZzRlDBWH+Xt7E95jsTXBG5z/wKqcOpP+Pv4ZlSacOdxYoohsgc8AGjbw5SmLcC0MgCK7RW0h6l2HxaLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XdZwbo1A; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XdZwbo1A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=6tRK559BiNuC9vPX6A/P9bB+NgbxmEIjWbF4mmHiKwg=; b=XdZwbo1A+QS0GQ4rSXUX4N1mON
	+BlsbG3jDpcSWQhV5QxKCntdc8Vov11hWedcSRVSsOFPwppBqsZ6Nis+O8bwl2CCSQ5hYR8W++geD
	vukV7rjaZBOrvt6I9xowd93yPY0C0Lzh/iojh9p1uQWpLnPfReYKg8eWZhCQMUPCsNXSqu/Y7toLg
	E6Frch+y/WEDPUhLCG957OQIe+Z+QGM3b4WJ3AXNaeyT5E4hHAIpCsvm122/2Vp2ysz/lvM+nk7kL
	WDy8f4TtKpFr0JcieI8f8+0F+JBj1RNoxvcmBf9YzAQnVG0oBiA+L4x/Lzr26MdYoNPIdFM9YVMzi
	3sLkfLjQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLqTE-00000008wzN-1WDo;
	Sat, 09 May 2026 22:48:30 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLqTD-0000000DhJ3-1Fbj;
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
Subject: [PATCH v4 28/30] KVM: x86: Remove runtime Xen TSC frequency CPUID update
Date: Sat,  9 May 2026 23:46:54 +0100
Message-ID: <20260509224824.3264567-29-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260509224824.3264567-1-dwmw2@infradead.org>
References: <20260509224824.3264567-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Remove the code in kvm_cpuid() that dynamically updates the Xen TSC
info CPUID leaf at runtime. This code was updating the wrong sub-leaf
anyway (0x40000x03/2 EAX is the *host* TSC frequency per the Xen ABI,
not the guest frequency which belongs in 0x40000x03/0 ECX).

Userspace now has all the information it needs to populate the Xen TSC
info leaves (and the generic 0x40000010 timing leaf) at vCPU setup time:

  - KVM_GET_CLOCK_GUEST returns the pvclock_vcpu_time_info structure
    containing tsc_to_system_mul and tsc_shift (Xen leaf index 1)
  - KVM_VCPU_TSC_EFFECTIVE_FREQ returns the effective TSC and bus
    frequencies in kHz (Xen leaf index 2, and 0x40000010)
  - KVM_VCPU_TSC_SCALE returns the raw hardware scaling ratio for
    precise arithmetic (VMClock)

This eliminates the last instance of KVM modifying guest CPUID entries
at runtime for timing information.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/cpuid.c | 16 ----------------
 arch/x86/kvm/xen.h   | 13 -------------
 2 files changed, 29 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 621d950ec692..826637a0b72d 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -2117,22 +2117,6 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
 		} else if (function == 0x80000007) {
 			if (kvm_hv_invtsc_suppressed(vcpu))
 				*edx &= ~feature_bit(CONSTANT_TSC);
-		} else if (IS_ENABLED(CONFIG_KVM_XEN) &&
-			   kvm_xen_is_tsc_leaf(vcpu, function)) {
-			/*
-			 * Update guest TSC frequency information if necessary.
-			 * Ignore failures, there is no sane value that can be
-			 * provided if KVM can't get the TSC frequency.
-			 */
-			if (kvm_check_request(KVM_REQ_CLOCK_UPDATE, vcpu))
-				kvm_guest_time_update(vcpu);
-
-			if (index == 1) {
-				*ecx = vcpu->arch.pvclock_tsc_mul;
-				*edx = vcpu->arch.pvclock_tsc_shift;
-			} else if (index == 2) {
-				*eax = div_u64(vcpu->arch.hw_tsc_hz, 1000);
-			}
 		}
 	} else {
 		*eax = *ebx = *ecx = *edx = 0;
diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index 59e6128a7bd3..f372855857a8 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -50,14 +50,6 @@ static inline void kvm_xen_sw_enable_lapic(struct kvm_vcpu *vcpu)
 		kvm_xen_inject_vcpu_vector(vcpu);
 }
 
-static inline bool kvm_xen_is_tsc_leaf(struct kvm_vcpu *vcpu, u32 function)
-{
-	return static_branch_unlikely(&kvm_xen_enabled.key) &&
-	       vcpu->arch.xen.cpuid.base &&
-	       function <= vcpu->arch.xen.cpuid.limit &&
-	       function == (vcpu->arch.xen.cpuid.base | XEN_CPUID_LEAF(3));
-}
-
 static inline bool kvm_xen_msr_enabled(struct kvm *kvm)
 {
 	return static_branch_unlikely(&kvm_xen_enabled.key) &&
@@ -177,11 +169,6 @@ static inline bool kvm_xen_timer_enabled(struct kvm_vcpu *vcpu)
 {
 	return false;
 }
-
-static inline bool kvm_xen_is_tsc_leaf(struct kvm_vcpu *vcpu, u32 function)
-{
-	return false;
-}
 #endif
 
 int kvm_xen_hypercall(struct kvm_vcpu *vcpu);
-- 
2.51.0

