Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB01F48663E;
	Fri, 11 Sep 2026 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162882; cv=none; b=eXW7oHrTMNOR8pVok+CA0uETFwvECYpraJy2b8H6IcsxutH+eED1yXrsLpxVc7VFiwAThkE7m/wxcFJycTYxGN1erw7lBRhAux4RvOLSAhwYhuffqHBukiBXsiGf7OHFtjwUW2RhINaYxnJF/R/n1n5WxjD/M65hEjw4Q+HKW68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162882; c=relaxed/simple;
	bh=pTC5a4/Yt0WjHvZekgLXWfLwG+w0fYiORfetO1Na3Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9Gx6e/zTBo3MobYyJHPu+PGvoL1QoIIqIb/dJMWEn1OMTjbulR1DtzxAGH96GKAhm9V8A7H+eg9rnKlFo8zhG16ZCKYtMcK7cAcXVZQUuWs978O9FCw4hLXC1bkZu+TOlAkfG0gDdmFdjWkDbCqoB+jFLSDVErUi+SJf5wijaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmTG69U7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmTG69U7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789162881; x=1820698881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pTC5a4/Yt0WjHvZekgLXWfLwG+w0fYiORfetO1Na3Oc=;
  b=dmTG69U7ciwgw1Zdx0O1asBlFFy+g2P+KkmPcjPsn5IfhVkZi2jgQyNA
   yuPS3Sa1umDu7x3fC9EYkeP6clY8DVeCZSFXeBzYR9JR/IlJvOqePkgiG
   rXZumeTQPhJq5edE3Z41wZdAv+sePupZIDl8XCbvYOQJ/qWHd+M7UrJZB
   8PJg/gjx+k7FbEW+1N4yLbZbhLygtGRzUMV7GVm/ckT8WpS10//bPNhBF
   M+2HY/4SsrN9OLD7Fpnl/qlaRZPSvwJjHt2L9TwNJ4YkWZ+t6JCKUvRfR
   HPsYjt7VFOxu8s+RN9cmQZPvdjgamVGZ7H8N2eAo9Ulp58XB3J0FQt8x0
   Q==;
X-CSE-ConnectionGUID: BBVoSd2USAS+grbwj+yUeA==
X-CSE-MsgGUID: BbCXnO6aR02LPyuUAXqUyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572584"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572584"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:41:20 -0700
X-CSE-ConnectionGUID: B5O9CTF/RA2tVLer98aADw==
X-CSE-MsgGUID: l6CDTyODSA6U1zmDENhvvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272004074"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:41:19 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org,
	x86@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v10 10/28] KVM: VMX: Add support for saving and restoring FRED MSRs
Date: Fri, 11 Sep 2026 14:36:40 -0700
Message-ID: <20260911213659.2025974-11-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911213659.2025974-1-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Xin Li (Intel)" <xin@zytor.com>

Introduce support for handling FRED MSR access requests, enabling both
host and guest to read and write FRED MSRs, which is essential for VM
save/restore and live migration, and allows userspace tools such as QEMU
to access the relevant MSRs.

Specially, intercept accesses to the FRED SSP0 MSR (IA32_PL0_SSP), which
remains accessible when FRED is enumerated even if CET is not.  This
ensures the guest value is fully virtual and does not alter the hardware
FRED SSP0 MSR.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
---
v10:
 - Fix a corner case identified by Chao Gao.
---
 arch/x86/include/asm/kvm_host.h  |  5 ++
 arch/x86/include/asm/msr-index.h |  2 +
 arch/x86/kvm/msrs.c              | 89 ++++++++++++++++++++++++++++++--
 arch/x86/kvm/vmx/vmx.c           | 45 ++++++++++++++++
 4 files changed, 138 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8d3999772ac2..0fd5d4edeebb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1032,6 +1032,11 @@ struct kvm_vcpu_arch {
 #if IS_ENABLED(CONFIG_HYPERV)
 	hpa_t hv_root_tdp;
 #endif
+	/*
+	 * Stores the FRED SSP0 MSR when CET is not supported, prompting KVM
+	 * to intercept its accesses.
+	 */
+	u64 fred_ssp0_fallback;
 };
 
 struct kvm_lpage_info {
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index ad899d9070e1..b386709515c4 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -64,6 +64,8 @@
 #define MSR_IA32_FRED_SSP3	0x1d3			/* Level 3 shadow stack pointer */
 #define MSR_IA32_FRED_CONFIG	0x1d4			/* Entrypoint and interrupt stack level */
 
+#define FRED_CONFIG_RESERVED	(BIT_ULL(2) | GENMASK_ULL(5, 4) | BIT_ULL(11))
+
 /* Intel MSRs. Some also available on other CPUs */
 #define MSR_TEST_CTRL				0x00000033
 #define MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT	29
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index 66fa7140d65d..9eabb7b02cb5 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -193,6 +193,9 @@ static const u32 msrs_to_save_base[] = {
 	MSR_STAR,
 #ifdef CONFIG_X86_64
 	MSR_CSTAR, MSR_KERNEL_GS_BASE, MSR_SYSCALL_MASK, MSR_LSTAR,
+	MSR_IA32_FRED_RSP0, MSR_IA32_FRED_RSP1, MSR_IA32_FRED_RSP2,
+	MSR_IA32_FRED_RSP3, MSR_IA32_FRED_STKLVLS, MSR_IA32_FRED_SSP1,
+	MSR_IA32_FRED_SSP2, MSR_IA32_FRED_SSP3, MSR_IA32_FRED_CONFIG,
 #endif
 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
 	MSR_IA32_FEAT_CTL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
@@ -772,7 +775,7 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
 		 * architecture. Intercepting XRSTORS/XSAVES for this
 		 * special case isn't deemed worthwhile.
 		 */
-	case MSR_IA32_PL0_SSP ... MSR_IA32_INT_SSP_TAB:
+	case MSR_IA32_PL1_SSP ... MSR_IA32_INT_SSP_TAB:
 		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK))
 			return KVM_MSR_RET_UNSUPPORTED;
 		/*
@@ -787,6 +790,52 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
 		if (index != MSR_IA32_INT_SSP_TAB && !IS_ALIGNED(data, 4))
 			return 1;
 		break;
+	case MSR_IA32_FRED_STKLVLS:
+		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_FRED))
+			return KVM_MSR_RET_UNSUPPORTED;
+		break;
+	case MSR_IA32_FRED_RSP0 ... MSR_IA32_FRED_RSP3:
+	case MSR_IA32_FRED_SSP1 ... MSR_IA32_FRED_CONFIG: {
+		u64 reserved_bits = 0;
+
+		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_FRED))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		if (is_noncanonical_msr_address(data, vcpu))
+			return 1;
+
+		switch (index) {
+		case MSR_IA32_FRED_CONFIG:
+			reserved_bits = FRED_CONFIG_RESERVED;
+			break;
+		case MSR_IA32_FRED_RSP0 ... MSR_IA32_FRED_RSP3:
+			reserved_bits = GENMASK_ULL(5, 0);
+			break;
+		case MSR_IA32_FRED_SSP1 ... MSR_IA32_FRED_SSP3:
+			reserved_bits = GENMASK_ULL(2, 0);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			return 1;
+		}
+
+		if (data & reserved_bits)
+			return 1;
+
+		break;
+	}
+	case MSR_IA32_PL0_SSP: /* I.e., MSR_IA32_FRED_SSP0 */
+		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) &&
+		    !guest_cpu_cap_has(vcpu, X86_FEATURE_FRED))
+			return KVM_MSR_RET_UNSUPPORTED;
+
+		if (is_noncanonical_msr_address(data, vcpu))
+			return 1;
+
+		if (!IS_ALIGNED(data, 4))
+			return 1;
+
+		break;
 	}
 
 	msr.data = data;
@@ -841,10 +890,19 @@ static int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
 		if (!host_initiated)
 			return 1;
 		fallthrough;
-	case MSR_IA32_PL0_SSP ... MSR_IA32_INT_SSP_TAB:
+	case MSR_IA32_PL1_SSP ... MSR_IA32_INT_SSP_TAB:
 		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK))
 			return KVM_MSR_RET_UNSUPPORTED;
 		break;
+	case MSR_IA32_FRED_RSP0 ... MSR_IA32_FRED_CONFIG:
+		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_FRED))
+			return KVM_MSR_RET_UNSUPPORTED;
+		break;
+	case MSR_IA32_PL0_SSP: /* I.e., MSR_IA32_FRED_SSP0 */
+		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) &&
+		    !guest_cpu_cap_has(vcpu, X86_FEATURE_FRED))
+			return KVM_MSR_RET_UNSUPPORTED;
+		break;
 	}
 
 	msr.index = index;
@@ -1833,7 +1891,15 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 #endif
 	case MSR_IA32_U_CET:
+		kvm_set_xstate_msr(vcpu, msr_info);
+		break;
 	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
+		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK)) {
+			WARN_ON_ONCE(msr != MSR_IA32_FRED_SSP0);
+			vcpu->arch.fred_ssp0_fallback = data;
+			break;
+		}
+
 		kvm_set_xstate_msr(vcpu, msr_info);
 		break;
 	default:
@@ -2186,7 +2252,15 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 #endif
 	case MSR_IA32_U_CET:
+		kvm_get_xstate_msr(vcpu, msr_info);
+		break;
 	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
+		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK)) {
+			WARN_ON_ONCE(msr_info->index != MSR_IA32_FRED_SSP0);
+			msr_info->data = vcpu->arch.fred_ssp0_fallback;
+			break;
+		}
+
 		kvm_get_xstate_msr(vcpu, msr_info);
 		break;
 	default:
@@ -2656,10 +2730,19 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 		if (!kvm_cpu_cap_has(X86_FEATURE_LM))
 			return;
 		fallthrough;
-	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
+	case MSR_IA32_PL1_SSP ... MSR_IA32_PL3_SSP:
 		if (!kvm_cpu_cap_has(X86_FEATURE_SHSTK))
 			return;
 		break;
+	case MSR_IA32_FRED_RSP0 ... MSR_IA32_FRED_CONFIG:
+		if (!kvm_cpu_cap_has(X86_FEATURE_FRED))
+			return;
+		break;
+	case MSR_IA32_PL0_SSP: /* I.e., MSR_IA32_FRED_SSP0 */
+		if (!kvm_cpu_cap_has(X86_FEATURE_SHSTK) &&
+		    !kvm_cpu_cap_has(X86_FEATURE_FRED))
+			return;
+		break;
 	default:
 		break;
 	}
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b6b73ab9cfb7..362bd4dda298 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1489,6 +1489,18 @@ static void vmx_write_guest_kernel_gs_base(struct vcpu_vmx *vmx, u64 data)
 	vmx_write_guest_host_msr(vmx, MSR_KERNEL_GS_BASE, data,
 				 &vmx->msr_guest_kernel_gs_base);
 }
+
+static u64 vmx_read_guest_fred_rsp0(struct vcpu_vmx *vmx)
+{
+	return vmx_read_guest_host_msr(vmx, MSR_IA32_FRED_RSP0,
+				       &vmx->msr_guest_fred_rsp0);
+}
+
+static void vmx_write_guest_fred_rsp0(struct vcpu_vmx *vmx, u64 data)
+{
+	vmx_write_guest_host_msr(vmx, MSR_IA32_FRED_RSP0, data,
+				 &vmx->msr_guest_fred_rsp0);
+}
 #endif
 
 static void grow_ple_window(struct kvm_vcpu *vcpu)
@@ -2140,6 +2152,27 @@ int vmx_get_feature_msr(u32 msr, u64 *data)
 	}
 }
 
+#ifdef CONFIG_X86_64
+static const u32 fred_msr_vmcs_fields[] = {
+	GUEST_IA32_FRED_RSP1,
+	GUEST_IA32_FRED_RSP2,
+	GUEST_IA32_FRED_RSP3,
+	GUEST_IA32_FRED_STKLVLS,
+	GUEST_IA32_FRED_SSP1,
+	GUEST_IA32_FRED_SSP2,
+	GUEST_IA32_FRED_SSP3,
+	GUEST_IA32_FRED_CONFIG,
+};
+
+static_assert(MSR_IA32_FRED_CONFIG - MSR_IA32_FRED_RSP1 ==
+	      ARRAY_SIZE(fred_msr_vmcs_fields) - 1);
+
+static u32 fred_msr_to_vmcs(u32 msr)
+{
+	return fred_msr_vmcs_fields[msr - MSR_IA32_FRED_RSP1];
+}
+#endif
+
 /*
  * Reads an msr value (of 'msr_info->index') into 'msr_info->data'.
  * Returns 0 on success, non-0 otherwise.
@@ -2162,6 +2195,12 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_KERNEL_GS_BASE:
 		msr_info->data = vmx_read_guest_kernel_gs_base(vmx);
 		break;
+	case MSR_IA32_FRED_RSP0:
+		msr_info->data = vmx_read_guest_fred_rsp0(vmx);
+		break;
+	case MSR_IA32_FRED_RSP1 ... MSR_IA32_FRED_CONFIG:
+		msr_info->data = vmcs_read64(fred_msr_to_vmcs(msr_info->index));
+		break;
 #endif
 	case MSR_EFER:
 		return kvm_get_msr_common(vcpu, msr_info);
@@ -2394,6 +2433,12 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			vmx_update_exception_bitmap(vcpu);
 		}
 		break;
+	case MSR_IA32_FRED_RSP0:
+		vmx_write_guest_fred_rsp0(vmx, data);
+		break;
+	case MSR_IA32_FRED_RSP1 ... MSR_IA32_FRED_CONFIG:
+		vmcs_write64(fred_msr_to_vmcs(msr_index), data);
+		break;
 #endif
 	case MSR_IA32_SYSENTER_CS:
 		if (is_guest_mode(vcpu))
-- 
2.43.0

