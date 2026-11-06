Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983170;
	b=Ssg7ruSTHMQWkrm3gxPU4xQ+TFGPjSq7Vjjsg1KxE9lYSg7njy9shNKxQ+WDS2ap9V2+
	 iVDDgBPrBHPy2DTEUcLW6dfB+jrl8ZkxhvokBTpiC7TMeGVZZcoG6Wb8ILBqe5q/KyXRy
	 6z1O8rZpt8an6ZW1z2lyOe8UPw/FgNs2S1PsqxFubeMh5aVmx0fIYrrtzQPxbcEycHvfG
	 2MRoMODk+GJl8c9Uh7m3bP97eM8cLWeE/0PFcGYVdvetPGWX6iW7A7QNvHZsG1C8+relv
	 A8+PncFQEBmu6PNjSHhJUL0R5dS+1OB+lnLMopx5wNWpibo3nMcnyeCkOk8kAQbFQEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ze343Uaqk+X8UtHweN3K4PjeYKSuxe6pflYwae6tsAs=;
	b=s6eBU4IyYMWos/c08MG+OhdRCH5pMGAVM85cIzxSRlng0TubfbqIL2As0vnP9OMD4Etc
	 Pwf2IFwb6OYFtbWJAJtHFxv8RwwoiZPQzE1HZcSItbNx+BjO7921jZE6cTz/ZVDWRfRSy
	 gA3kdY/72ndBGGhLpHgIUJLp13aMPdzTdzAAtXpokeSAe6AMfNFHSJxq0GumoPeUxtGrx
	 FPtjYGzB1uEaw7ntqY9tLHDEWUUpT2/JGuB7dHBtLObavHzONhTJkJkwTKt867Jh3OCev
	 Jp7etXW+z74deDSinBH/jXO5vvnfA+lrnpaRLYtEtv18hb14AI0L5gz1X8wbTUeZOJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A8tSMFaf;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9544D606A32C
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 16:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9544D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A8tSMFaf
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ae72da2f57so1330306a91.1
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 08:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793983169; x=1794587969; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ze343Uaqk+X8UtHweN3K4PjeYKSuxe6pflYwae6tsAs=;
        b=A8tSMFafFqBRRHJy3GU6h+xCdy/7eVZn1X8eTZmPaKBacLB6VUPbIq9MFpVGkGgprx
         2lFxA9YYCM4g6jOqPk6gJMH363BwXVN4zzbBsdhqcEx+pDz4SKCpt+0vLtMAR2V/7XEZ
         z0UAUuE47C8QtsXMOYnZ83jrcRuJbnRYbcefOAOdbk7FLmcbmw15yw5JNc2XQgrDZNl2
         nC+n93Yt3i+j13l5HZk6vCK4H7uzd7T0Vkikhl8/4pFzIsBlSM0LtErpkDtfG0aaFCuW
         yVwmQrviMtd9BjTkApWCqSf4r+MmBQIrl5ZFodCOcamDBlfkUqX36HvPPRbykFG40tNt
         UMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793983169; x=1794587969;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ze343Uaqk+X8UtHweN3K4PjeYKSuxe6pflYwae6tsAs=;
        b=EFwPfW7Fqs5GQvNSkXiL4ETPPj68wWcKyle9Ikycj4T6EwbC/S5vgIcNYsj4q4lt1v
         JUbCBM8a1a6/No6rtf8A8RA953Vg3fmvcnHqBCh+SPMGmcVG+myJilMUZ5jdalLwh+Xw
         ndID0K8gMdRVrt9VXngELZG8xzKvlGtkAxxRsiRnTIYZR70CVmXv8nNY1jf8dR1Wg7s+
         T1ejgel79GTaAT8b2M09K/I7wR6vgMaG/4m8nJFdtUvoRrZdXfR+2OeRTL5IvHV2XGvO
         VA/FvKvtPzsB2edsFes43Y1I696uqaLy2rkpk96mszNSxPxVz6HneQz/9H/U0a96Y3av
         ooIw==
X-Forwarded-Encrypted: i=1; AL+hErE6VB1KxrSNISKzvzwWjOXjnPx5Lb75eCREIoGjSjAyw19hznoqyT6zYdETHOYZd1tWcWA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FIAeqq7g5jreM6OX1Ytp76QNI3JeEmaHhteNhOIV84VQ9lgmZ
	6sC0mNKWVXteNtWbUfMoeQolU0j76KBWlnzUg7s5s0w12I6Ozo92TxYj9U1mt3ajmVAUBD7CUdP
	bpwovBQ==
X-Received: from pjbco24.prod.google.com ([2002:a17:90a:fe98:b0:3ad:3715:39c8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b8b:b0:3b0:a385:5aaf
 with SMTP id 98e67ed59e1d1-3b0db6e53c8mr2966660a91.39.1793983168137; Fri, 06
 Nov 2026 08:39:28 -0800 (PST)
Date: Fri, 6 Nov 2026 08:39:27 -0800
In-Reply-To: <20261106073417.86867-1-flyingpeng@tencent.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106073417.86867-1-flyingpeng@tencent.com>
Message-ID: <au4Cv1pjFp_7rmlT@google.com>
Subject: Re: [PATCH] KVM: VMX: Allocate struct pt_desc only when PT is
 virtualized for guests
From: Sean Christopherson <seanjc@google.com>
To: Peng Hao <flyingpenghao@gmail.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 06, 2026, Peng Hao wrote:
> struct pt_desc is only used when pt_mode is PT_MODE_HOST_GUEST, so
> allocate it on demand instead of embedding it in struct vcpu_vmx.
> 
> This shrinks struct vcpu_vmx from 8384 to 8128 bytes.

Hrm, I don't think I want to do this to save "only" 256 bytes.  I assume the goal
is to get back down to an order-1 allocation, but vcpu_vmx is sooo close that
shaving off 256 bytes is only going to keep it order-1 for a kernel release or two.

And for "full" configs, e.g. with Xen support, vcpu_vmx is ~9088 bytes.

If we want to get vCPUs back to order-1 allocation with any chance of keeping them
there, I think we need to aim for ~6-7 KiB, but without adding unnecessary layers
of indirection.  E.g. kvm_vcpu.stats is a whopping 1104 bytes, but it's accessed in
a ton of hot paths, so I wouldn't want to allocate that separately.  Similarly,
we could dynamically allocate vcpu_vmx.nested, but I don't know that I'd want to
add that extra pointer chase just to get at a variety of flags.

Potential ideas:

  1. vcpu_vmx.rmode (208) - In practice, it's only used by CPUs launched before
     Westmere (2010), and like PT, it's guarded by a module param so it's easy to
     dynamically allocate.

  2. kvm_vcpu_arch.pmu (912) - Can be allocated if and only if the vCPU has a PMU,
     e.g. in kvm_pmu_refresh(), or based on the module param.  I'd be somehwat
     worried about regressing hot paths though.  On the other hand, we could throw
     pt_desc and lbr_desc into kvm_pmu to get a total of 1208 bytes in savings.

  3. kvm_vcpu_arch.xen (680) - Only impacts a limited set of configs, but at a
     glance, this one would be trivially easy to convert, and if distros enable
     CONFIG_KVM_XEN, would provide meaningful savings for a lot of deployments.

  4. kvm_vcpu_arch.apf.gfns (512) - Would need to be unconditionally allocated,
     but its power-of-2 size makes it well suited for a kmem cache, and for many,
     many VMs, this will almost never be used.

If we did all of the above, that would save 2608 bytes for CONFIG_KVM_XEN=y and
1928 bytes for CONFIG_KVM_XEN=n.  That would put vcpu_vmx around 6.4KiB, which
would give us some room before we cross the order-1 boundary (again).

The other option for pt_desc in particular would be to simply rip out all of the
code, as it's been buried behind CONFIG_BROKEN=y for a few years now.

Actually, duh, the less committing thing to do is to compile out the code.  I
think it'd still be worth doing at least some of the above changes, but hard
disabling PT virtualization seems like a no brainer.  E.g. over a few patches to
isolate the code movement.  I'll post a miniseries.

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 1719059570fb..243307328adf 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -151,6 +151,9 @@ config KVM_INTEL_TDX
 
 	  If unsure, say N.
 
+config KVM_INTEL_PT
+	def_bool y if BROKEN
+
 config KVM_AMD
 	tristate "KVM for AMD processors support"
 	depends on KVM && (CPU_SUP_AMD || CPU_SUP_HYGON)
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index e91650af44c2..a69020c01afd 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -2596,6 +2596,7 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 		if (!kvm_cpu_cap_has(X86_FEATURE_WAITPKG))
 			return;
 		break;
+#ifdef CONFIG_KVM_INTEL_PT
 	case MSR_IA32_RTIT_CTL:
 	case MSR_IA32_RTIT_STATUS:
 		if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT))
@@ -2619,6 +2620,7 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 		     intel_pt_validate_hw_cap(PT_CAP_num_address_ranges) * 2))
 			return;
 		break;
+#endif
 	case MSR_ARCH_PERFMON_PERFCTR0 ...
 	     MSR_ARCH_PERFMON_PERFCTR0 + KVM_MAX_NR_GP_COUNTERS - 1:
 		if (msr_index - MSR_ARCH_PERFMON_PERFCTR0 >=
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 810119167f79..604cc376ca5a 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -17,11 +17,16 @@ extern bool __read_mostly enable_ept_ad_bits;
 extern bool __read_mostly enable_cet;
 extern bool __read_mostly enable_pml;
 extern bool __read_mostly enable_mbec;
-extern int __read_mostly pt_mode;
 
 #define PT_MODE_SYSTEM		0
 #define PT_MODE_HOST_GUEST	1
 
+#ifdef CONFIG_KVM_INTEL_PT
+extern int __read_mostly pt_mode;
+#else
+#define pt_mode			PT_MODE_SYSTEM
+#endif
+
 struct nested_vmx_msrs {
 	/*
 	 * We only store the "true" versions of the VMX capability MSRs. We
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index f0d75f5a968c..4bc0c1b743d8 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5455,10 +5455,12 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
 	vmx->nested.vmcs02_initialized = false;
 	vmx->nested.vmxon = true;
 
+#ifdef CONFIG_KVM_INTEL_PT
 	if (vmx_pt_mode_is_host_guest()) {
 		vmx->pt_desc.guest.ctl = 0;
 		pt_update_intercept_for_msr(vcpu);
 	}
+#endif
 
 	return 0;
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e6a61514e797..bd1ea5f16c78 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -210,8 +210,8 @@ static unsigned int ple_window_max        = KVM_VMX_DEFAULT_PLE_WINDOW_MAX;
 module_param(ple_window_max, uint, 0444);
 
 /* Default is SYSTEM mode, 1 for host-guest mode (which is BROKEN) */
+#ifdef CONFIG_KVM_INTEL_PT
 int __read_mostly pt_mode = PT_MODE_SYSTEM;
-#ifdef CONFIG_BROKEN
 module_param(pt_mode, int, S_IRUGO);
 #endif
 
@@ -1231,6 +1231,165 @@ static unsigned long segment_base(u16 selector)
 }
 #endif
 
+#ifdef CONFIG_KVM_INTEL_PT
+static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	unsigned long value;
+
+	/*
+	 * Any MSR write that attempts to change bits marked reserved will
+	 * case a #GP fault.
+	 */
+	if (data & vmx->pt_desc.ctl_bitmask)
+		return 1;
+
+	/*
+	 * Any attempt to modify IA32_RTIT_CTL while TraceEn is set will
+	 * result in a #GP unless the same write also clears TraceEn.
+	 */
+	if ((vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) &&
+	    (data & RTIT_CTL_TRACEEN) &&
+	    data != vmx->pt_desc.guest.ctl)
+		return 1;
+
+	/*
+	 * WRMSR to IA32_RTIT_CTL that sets TraceEn but clears this bit
+	 * and FabricEn would cause #GP, if
+	 * CPUID.(EAX=14H, ECX=0):ECX.SNGLRGNOUT[bit 2] = 0
+	 */
+	if ((data & RTIT_CTL_TRACEEN) && !(data & RTIT_CTL_TOPA) &&
+		!(data & RTIT_CTL_FABRIC_EN) &&
+		!intel_pt_validate_cap(vmx->pt_desc.caps,
+					PT_CAP_single_range_output))
+		return 1;
+
+	/*
+	 * MTCFreq, CycThresh and PSBFreq encodings check, any MSR write that
+	 * utilize encodings marked reserved will cause a #GP fault.
+	 */
+	value = intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_mtc_periods);
+	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_mtc) &&
+			!test_bit((data & RTIT_CTL_MTC_RANGE) >>
+			RTIT_CTL_MTC_RANGE_OFFSET, &value))
+		return 1;
+	value = intel_pt_validate_cap(vmx->pt_desc.caps,
+						PT_CAP_cycle_thresholds);
+	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_psb_cyc) &&
+			!test_bit((data & RTIT_CTL_CYC_THRESH) >>
+			RTIT_CTL_CYC_THRESH_OFFSET, &value))
+		return 1;
+	value = intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_psb_periods);
+	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_psb_cyc) &&
+			!test_bit((data & RTIT_CTL_PSB_FREQ) >>
+			RTIT_CTL_PSB_FREQ_OFFSET, &value))
+		return 1;
+
+	/*
+	 * If ADDRx_CFG is reserved or the encodings is >2 will
+	 * cause a #GP fault.
+	 */
+	value = (data & RTIT_CTL_ADDR0) >> RTIT_CTL_ADDR0_OFFSET;
+	if ((value && (vmx->pt_desc.num_address_ranges < 1)) || (value > 2))
+		return 1;
+	value = (data & RTIT_CTL_ADDR1) >> RTIT_CTL_ADDR1_OFFSET;
+	if ((value && (vmx->pt_desc.num_address_ranges < 2)) || (value > 2))
+		return 1;
+	value = (data & RTIT_CTL_ADDR2) >> RTIT_CTL_ADDR2_OFFSET;
+	if ((value && (vmx->pt_desc.num_address_ranges < 3)) || (value > 2))
+		return 1;
+	value = (data & RTIT_CTL_ADDR3) >> RTIT_CTL_ADDR3_OFFSET;
+	if ((value && (vmx->pt_desc.num_address_ranges < 4)) || (value > 2))
+		return 1;
+
+	return 0;
+}
+
+static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct kvm_cpuid_entry2 *best = NULL;
+	int i;
+
+	for (i = 0; i < PT_CPUID_LEAVES; i++) {
+		best = kvm_find_cpuid_entry_index(vcpu, 0x14, i);
+		if (!best)
+			return;
+		vmx->pt_desc.caps[CPUID_EAX + i*PT_CPUID_REGS_NUM] = best->eax;
+		vmx->pt_desc.caps[CPUID_EBX + i*PT_CPUID_REGS_NUM] = best->ebx;
+		vmx->pt_desc.caps[CPUID_ECX + i*PT_CPUID_REGS_NUM] = best->ecx;
+		vmx->pt_desc.caps[CPUID_EDX + i*PT_CPUID_REGS_NUM] = best->edx;
+	}
+
+	/* Get the number of configurable Address Ranges for filtering */
+	vmx->pt_desc.num_address_ranges = intel_pt_validate_cap(vmx->pt_desc.caps,
+						PT_CAP_num_address_ranges);
+
+	/* Initialize and clear the no dependency bits */
+	vmx->pt_desc.ctl_bitmask = ~(RTIT_CTL_TRACEEN | RTIT_CTL_OS |
+			RTIT_CTL_USR | RTIT_CTL_TSC_EN | RTIT_CTL_DISRETC |
+			RTIT_CTL_BRANCH_EN);
+
+	/*
+	 * If CPUID.(EAX=14H,ECX=0):EBX[0]=1 CR3Filter can be set otherwise
+	 * will inject an #GP
+	 */
+	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_cr3_filtering))
+		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_CR3EN;
+
+	/*
+	 * If CPUID.(EAX=14H,ECX=0):EBX[1]=1 CYCEn, CycThresh and
+	 * PSBFreq can be set
+	 */
+	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_psb_cyc))
+		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_CYCLEACC |
+				RTIT_CTL_CYC_THRESH | RTIT_CTL_PSB_FREQ);
+
+	/*
+	 * If CPUID.(EAX=14H,ECX=0):EBX[3]=1 MTCEn and MTCFreq can be set
+	 */
+	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_mtc))
+		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_MTC_EN |
+					      RTIT_CTL_MTC_RANGE);
+
+	/* If CPUID.(EAX=14H,ECX=0):EBX[4]=1 FUPonPTW and PTWEn can be set */
+	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_ptwrite))
+		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_FUP_ON_PTW |
+							RTIT_CTL_PTW_EN);
+
+	/* If CPUID.(EAX=14H,ECX=0):EBX[5]=1 PwrEvEn can be set */
+	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_power_event_trace))
+		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_PWR_EVT_EN;
+
+	/* If CPUID.(EAX=14H,ECX=0):ECX[0]=1 ToPA can be set */
+	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_topa_output))
+		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_TOPA;
+
+	/* If CPUID.(EAX=14H,ECX=0):ECX[3]=1 FabricEn can be set */
+	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_output_subsys))
+		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_FABRIC_EN;
+
+	/* unmask address range configure area */
+	for (i = 0; i < vmx->pt_desc.num_address_ranges; i++)
+		vmx->pt_desc.ctl_bitmask &= ~(0xfULL << (32 + i * 4));
+}
+
+void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	bool flag = !(vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN);
+	u32 i;
+
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_STATUS, MSR_TYPE_RW, flag);
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_OUTPUT_BASE, MSR_TYPE_RW, flag);
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_OUTPUT_MASK, MSR_TYPE_RW, flag);
+	vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_CR3_MATCH, MSR_TYPE_RW, flag);
+	for (i = 0; i < vmx->pt_desc.num_address_ranges; i++) {
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_ADDR0_A + i * 2, MSR_TYPE_RW, flag);
+		vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_ADDR0_B + i * 2, MSR_TYPE_RW, flag);
+	}
+}
+
 static inline bool pt_can_write_msr(struct vcpu_vmx *vmx)
 {
 	return vmx_pt_mode_is_host_guest() &&
@@ -1306,6 +1465,25 @@ static void pt_guest_exit(struct vcpu_vmx *vmx)
 		wrmsrq(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
 }
 
+static unsigned int vmx_handle_intel_pt_intr(void)
+{
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
+
+	/* '0' on failure so that the !PT case can use a RET0 static call. */
+	if (!vcpu || !kvm_handling_nmi_from_guest(vcpu))
+		return 0;
+
+	kvm_make_request(KVM_REQ_PMI, vcpu);
+	__set_bit(MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT,
+		  (unsigned long *)&vcpu->arch.pmu.global_status);
+	return 1;
+}
+#else
+static void pt_guest_enter(struct vcpu_vmx *vmx) { }
+static void pt_guest_exit(struct vcpu_vmx *vmx) { }
+static void update_intel_pt_cfg(struct kvm_vcpu *vcpu) { WARN_ON_ONCE(1); }
+#endif /* CONFIG_KVM_INTEL_PT */
+
 void vmx_set_host_fs_gs(struct vmcs_host_state *host, u16 fs_sel, u16 gs_sel,
 			unsigned long fs_base, unsigned long gs_base)
 {
@@ -1708,79 +1886,6 @@ void vmx_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask)
 		vmcs_write32(GUEST_INTERRUPTIBILITY_INFO, interruptibility);
 }
 
-static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
-{
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	unsigned long value;
-
-	/*
-	 * Any MSR write that attempts to change bits marked reserved will
-	 * case a #GP fault.
-	 */
-	if (data & vmx->pt_desc.ctl_bitmask)
-		return 1;
-
-	/*
-	 * Any attempt to modify IA32_RTIT_CTL while TraceEn is set will
-	 * result in a #GP unless the same write also clears TraceEn.
-	 */
-	if ((vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) &&
-	    (data & RTIT_CTL_TRACEEN) &&
-	    data != vmx->pt_desc.guest.ctl)
-		return 1;
-
-	/*
-	 * WRMSR to IA32_RTIT_CTL that sets TraceEn but clears this bit
-	 * and FabricEn would cause #GP, if
-	 * CPUID.(EAX=14H, ECX=0):ECX.SNGLRGNOUT[bit 2] = 0
-	 */
-	if ((data & RTIT_CTL_TRACEEN) && !(data & RTIT_CTL_TOPA) &&
-		!(data & RTIT_CTL_FABRIC_EN) &&
-		!intel_pt_validate_cap(vmx->pt_desc.caps,
-					PT_CAP_single_range_output))
-		return 1;
-
-	/*
-	 * MTCFreq, CycThresh and PSBFreq encodings check, any MSR write that
-	 * utilize encodings marked reserved will cause a #GP fault.
-	 */
-	value = intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_mtc_periods);
-	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_mtc) &&
-			!test_bit((data & RTIT_CTL_MTC_RANGE) >>
-			RTIT_CTL_MTC_RANGE_OFFSET, &value))
-		return 1;
-	value = intel_pt_validate_cap(vmx->pt_desc.caps,
-						PT_CAP_cycle_thresholds);
-	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_psb_cyc) &&
-			!test_bit((data & RTIT_CTL_CYC_THRESH) >>
-			RTIT_CTL_CYC_THRESH_OFFSET, &value))
-		return 1;
-	value = intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_psb_periods);
-	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_psb_cyc) &&
-			!test_bit((data & RTIT_CTL_PSB_FREQ) >>
-			RTIT_CTL_PSB_FREQ_OFFSET, &value))
-		return 1;
-
-	/*
-	 * If ADDRx_CFG is reserved or the encodings is >2 will
-	 * cause a #GP fault.
-	 */
-	value = (data & RTIT_CTL_ADDR0) >> RTIT_CTL_ADDR0_OFFSET;
-	if ((value && (vmx->pt_desc.num_address_ranges < 1)) || (value > 2))
-		return 1;
-	value = (data & RTIT_CTL_ADDR1) >> RTIT_CTL_ADDR1_OFFSET;
-	if ((value && (vmx->pt_desc.num_address_ranges < 2)) || (value > 2))
-		return 1;
-	value = (data & RTIT_CTL_ADDR2) >> RTIT_CTL_ADDR2_OFFSET;
-	if ((value && (vmx->pt_desc.num_address_ranges < 3)) || (value > 2))
-		return 1;
-	value = (data & RTIT_CTL_ADDR3) >> RTIT_CTL_ADDR3_OFFSET;
-	if ((value && (vmx->pt_desc.num_address_ranges < 4)) || (value > 2))
-		return 1;
-
-	return 0;
-}
-
 int vmx_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
 				  void *insn, int insn_len)
 {
@@ -2130,7 +2235,6 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmx_uret_msr *msr;
-	u32 index;
 
 	switch (msr_info->index) {
 #ifdef CONFIG_X86_64
@@ -2216,6 +2320,7 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 							&msr_info->data);
 #endif
 		break;
+#ifdef CONFIG_KVM_INTEL_PT
 	case MSR_IA32_RTIT_CTL:
 		if (!vmx_pt_mode_is_host_guest())
 			return 1;
@@ -2251,8 +2356,9 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		msr_info->data = vmx->pt_desc.guest.output_mask;
 		break;
-	case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
-		index = msr_info->index - MSR_IA32_RTIT_ADDR0_A;
+	case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B: {
+		u32 index = msr_info->index - MSR_IA32_RTIT_ADDR0_A;
+
 		if (!vmx_pt_mode_is_host_guest() ||
 		    (index >= 2 * vmx->pt_desc.num_address_ranges))
 			return 1;
@@ -2261,6 +2367,8 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		else
 			msr_info->data = vmx->pt_desc.guest.addr_a[index / 2];
 		break;
+	}
+#endif
 	case MSR_IA32_S_CET:
 		msr_info->data = vmcs_readl(GUEST_S_CET);
 		break;
@@ -2339,7 +2447,6 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	int ret = 0;
 	u32 msr_index = msr_info->index;
 	u64 data = msr_info->data;
-	u32 index;
 
 	switch (msr_index) {
 	case MSR_EFER:
@@ -2529,6 +2636,7 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_VMX))
 			return 1;
 		return vmx_set_vmx_msr(vcpu, msr_index, data);
+#ifdef CONFIG_KVM_INTEL_PT
 	case MSR_IA32_RTIT_CTL:
 		if (!vmx_pt_mode_is_host_guest() ||
 			vmx_rtit_ctl_check(vcpu, data) ||
@@ -2575,7 +2683,9 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		vmx->pt_desc.guest.output_mask = data;
 		break;
-	case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
+	case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B: {
+		u32 index;
+
 		if (!pt_can_write_msr(vmx))
 			return 1;
 		index = msr_info->index - MSR_IA32_RTIT_ADDR0_A;
@@ -2588,6 +2698,8 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		else
 			vmx->pt_desc.guest.addr_a[index / 2] = data;
 		break;
+	}
+#endif
 	case MSR_IA32_S_CET:
 		vmcs_writel(GUEST_S_CET, data);
 		break;
@@ -4222,22 +4334,6 @@ static void vmx_update_msr_bitmap_x2apic(struct kvm_vcpu *vcpu)
 	}
 }
 
-void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	bool flag = !(vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN);
-	u32 i;
-
-	vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_STATUS, MSR_TYPE_RW, flag);
-	vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_OUTPUT_BASE, MSR_TYPE_RW, flag);
-	vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_OUTPUT_MASK, MSR_TYPE_RW, flag);
-	vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_CR3_MATCH, MSR_TYPE_RW, flag);
-	for (i = 0; i < vmx->pt_desc.num_address_ranges; i++) {
-		vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_ADDR0_A + i * 2, MSR_TYPE_RW, flag);
-		vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_ADDR0_B + i * 2, MSR_TYPE_RW, flag);
-	}
-}
-
 static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 {
 	u64 vm_exit_controls_bits = VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
@@ -4997,12 +5093,14 @@ static void init_vmcs(struct kvm_vcpu *vcpu)
 
 	vmx_write_encls_bitmap(vcpu, NULL);
 
+#ifdef CONFIG_KVM_INTEL_PT
 	if (vmx_pt_mode_is_host_guest()) {
 		memset(&vmx->pt_desc, 0, sizeof(vmx->pt_desc));
 		/* Bit[6~0] are forced to 1, writes are ignored. */
 		vmx->pt_desc.guest.output_mask = 0x7F;
 		vmcs_write64(GUEST_IA32_RTIT_CTL, 0);
 	}
+#endif
 
 	vmcs_write32(GUEST_SYSENTER_CS, 0);
 	vmcs_writel(GUEST_SYSENTER_ESP, 0);
@@ -7758,75 +7856,6 @@ static void nested_vmx_cr_fixed1_bits_update(struct kvm_vcpu *vcpu)
 #undef cr4_fixed1_update
 }
 
-static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	struct kvm_cpuid_entry2 *best = NULL;
-	int i;
-
-	for (i = 0; i < PT_CPUID_LEAVES; i++) {
-		best = kvm_find_cpuid_entry_index(vcpu, 0x14, i);
-		if (!best)
-			return;
-		vmx->pt_desc.caps[CPUID_EAX + i*PT_CPUID_REGS_NUM] = best->eax;
-		vmx->pt_desc.caps[CPUID_EBX + i*PT_CPUID_REGS_NUM] = best->ebx;
-		vmx->pt_desc.caps[CPUID_ECX + i*PT_CPUID_REGS_NUM] = best->ecx;
-		vmx->pt_desc.caps[CPUID_EDX + i*PT_CPUID_REGS_NUM] = best->edx;
-	}
-
-	/* Get the number of configurable Address Ranges for filtering */
-	vmx->pt_desc.num_address_ranges = intel_pt_validate_cap(vmx->pt_desc.caps,
-						PT_CAP_num_address_ranges);
-
-	/* Initialize and clear the no dependency bits */
-	vmx->pt_desc.ctl_bitmask = ~(RTIT_CTL_TRACEEN | RTIT_CTL_OS |
-			RTIT_CTL_USR | RTIT_CTL_TSC_EN | RTIT_CTL_DISRETC |
-			RTIT_CTL_BRANCH_EN);
-
-	/*
-	 * If CPUID.(EAX=14H,ECX=0):EBX[0]=1 CR3Filter can be set otherwise
-	 * will inject an #GP
-	 */
-	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_cr3_filtering))
-		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_CR3EN;
-
-	/*
-	 * If CPUID.(EAX=14H,ECX=0):EBX[1]=1 CYCEn, CycThresh and
-	 * PSBFreq can be set
-	 */
-	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_psb_cyc))
-		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_CYCLEACC |
-				RTIT_CTL_CYC_THRESH | RTIT_CTL_PSB_FREQ);
-
-	/*
-	 * If CPUID.(EAX=14H,ECX=0):EBX[3]=1 MTCEn and MTCFreq can be set
-	 */
-	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_mtc))
-		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_MTC_EN |
-					      RTIT_CTL_MTC_RANGE);
-
-	/* If CPUID.(EAX=14H,ECX=0):EBX[4]=1 FUPonPTW and PTWEn can be set */
-	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_ptwrite))
-		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_FUP_ON_PTW |
-							RTIT_CTL_PTW_EN);
-
-	/* If CPUID.(EAX=14H,ECX=0):EBX[5]=1 PwrEvEn can be set */
-	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_power_event_trace))
-		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_PWR_EVT_EN;
-
-	/* If CPUID.(EAX=14H,ECX=0):ECX[0]=1 ToPA can be set */
-	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_topa_output))
-		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_TOPA;
-
-	/* If CPUID.(EAX=14H,ECX=0):ECX[3]=1 FabricEn can be set */
-	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_output_subsys))
-		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_FABRIC_EN;
-
-	/* unmask address range configure area */
-	for (i = 0; i < vmx->pt_desc.num_address_ranges; i++)
-		vmx->pt_desc.ctl_bitmask &= ~(0xfULL << (32 + i * 4));
-}
-
 void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -8471,20 +8500,6 @@ gva_t vmx_get_untagged_addr(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags
 	return (sign_extend64(gva, lam_bit) & ~BIT_ULL(63)) | (gva & BIT_ULL(63));
 }
 
-static unsigned int vmx_handle_intel_pt_intr(void)
-{
-	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
-
-	/* '0' on failure so that the !PT case can use a RET0 static call. */
-	if (!vcpu || !kvm_handling_nmi_from_guest(vcpu))
-		return 0;
-
-	kvm_make_request(KVM_REQ_PMI, vcpu);
-	__set_bit(MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT,
-		  (unsigned long *)&vcpu->arch.pmu.global_status);
-	return 1;
-}
-
 static __init void vmx_setup_user_return_msrs(void)
 {
 
@@ -8671,6 +8686,7 @@ __init int vmx_hardware_setup(void)
 	kvm_caps.supported_mce_cap |= MCG_LMCE_P;
 	kvm_caps.supported_mce_cap |= MCG_CMCI_P;
 
+#ifdef CONFIG_KVM_INTEL_PT
 	if (pt_mode != PT_MODE_SYSTEM && pt_mode != PT_MODE_HOST_GUEST)
 		return -EINVAL;
 	if (!enable_ept || !enable_pmu || !cpu_has_vmx_intel_pt())
@@ -8679,6 +8695,7 @@ __init int vmx_hardware_setup(void)
 		vt_init_ops.handle_intel_pt_intr = vmx_handle_intel_pt_intr;
 	else
 		vt_init_ops.handle_intel_pt_intr = NULL;
+#endif
 
 	setup_default_sgx_lepubkeyhash();
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 6c9dd5b2365d..a449a36fcd1c 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -46,6 +46,7 @@ enum segment_cache_field {
 	SEG_FIELD_NR = 4
 };
 
+#ifdef CONFIG_KVM_INTEL_PT
 #define RTIT_ADDR_RANGE		4
 
 struct pt_ctx {
@@ -65,6 +66,7 @@ struct pt_desc {
 	struct pt_ctx host;
 	struct pt_ctx guest;
 };
+#endif
 
 /*
  * The nested_vmx structure is part of vcpu_vmx, and holds information we need
@@ -280,7 +282,9 @@ struct vcpu_vmx {
 	u64 msr_ia32_mcu_opt_ctrl;
 	bool disable_fb_clear;
 
+#ifdef CONFIG_KVM_INTEL_PT
 	struct pt_desc pt_desc;
+#endif
 	struct lbr_desc lbr_desc;
 
 	/* ve_info must be page aligned. */

