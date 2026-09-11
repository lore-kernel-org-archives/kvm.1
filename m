Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29404A4984;
	Fri, 11 Sep 2026 21:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162855; cv=none; b=byweZD9DRk64ZTbYBkmDa3WkpnOIAVV8qSG9i6F2l07U2FPx4O0Ob4LRrJxfqybvkc2MwNorwC4xBeASgXg3GYLASw/zR6yG5PJSzjsENpiMvCJpYZliWw0FA7ahJOkReHL9kG+Hpfd0fk7V6OKU4X7pG7E30AxyKfgW4jNs974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162855; c=relaxed/simple;
	bh=OHMvTxwx8WmR6ep9J+RcwSCq9HXroTytnAPdrb0CwxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MepujKYpWKYFRKZO8Cz+lqHgvE16/pWuKKO9iysKg6WVI4OqByR5qqkZ6RXKc24oAPjoRUFqym+Lw1WiYT8XeZRSwwFVdfqpUctkvP9Y9lUbbA+HuriH8+ATYMzd5QhYeaKMfGbRIVqTRGj7DokOOMMWww4cTIMLg0j6dsVjSZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UIsZfn0p; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UIsZfn0p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789162853; x=1820698853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OHMvTxwx8WmR6ep9J+RcwSCq9HXroTytnAPdrb0CwxQ=;
  b=UIsZfn0pcUJC8hTk+GVxybkdVVRvjgbz/A3Jl2cL7SHywjDOwgnsGs7v
   t993GrT2yj5oi3SITv3lDqKImT+tkmP8n5T3JRu5sGastGd0HcMOr8oDU
   p6TdqYLMqX6z6LQQdqL1abqYN4VeB0b87DetFDdI+s8mxDn48ZVnMLMsF
   p3ooMIVPnMXV++CSfwV+q65y1W/sU9kLWRBG/LvDiZwDhr2XTqeLxVwcj
   Xv+XkMJZEBWKjQo4WDVjg8OkOp69+5PpblGxYh4Jtjv0GQL83j6AWTs+p
   4ZSbqlf/KEWwmGMvsWlBJIncrT4jqiHgJzNu2ryEW4clxIx8zPq6x+IOL
   A==;
X-CSE-ConnectionGUID: eentJmiLTZGnHjBUdN99vg==
X-CSE-MsgGUID: cbqcUK3jQg+TlaCuK/Vzfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572502"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572502"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:40:52 -0700
X-CSE-ConnectionGUID: CvQRHx7pQQOiI64O8Vt9mA==
X-CSE-MsgGUID: je4Zy9atSymj2NENkdBA/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272004040"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:40:51 -0700
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
Subject: [PATCH v10 07/28] KVM: VMX: Initialize VMCS FRED fields
Date: Fri, 11 Sep 2026 14:36:37 -0700
Message-ID: <20260911213659.2025974-8-sohil.mehta@intel.com>
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

Initialize host VMCS FRED fields with host FRED MSRs' value and
guest VMCS FRED fields to 0.

FRED CPU state is managed in 9 new FRED MSRs:
        IA32_FRED_CONFIG,
        IA32_FRED_STKLVLS,
        IA32_FRED_RSP0,
        IA32_FRED_RSP1,
        IA32_FRED_RSP2,
        IA32_FRED_RSP3,
        IA32_FRED_SSP1,
        IA32_FRED_SSP2,
        IA32_FRED_SSP3,
as well as a few existing CPU registers and MSRs:
        CR4.FRED,
        IA32_STAR,
        IA32_KERNEL_GS_BASE,
        IA32_PL0_SSP (also known as IA32_FRED_SSP0).

CR4, IA32_KERNEL_GS_BASE and IA32_STAR are already well managed.
Except IA32_FRED_RSP0 and IA32_FRED_SSP0, all other FRED CPU state
MSRs have corresponding VMCS fields in both the host-state and
guest-state areas.  So KVM just needs to initialize them, and with
proper VM entry/exit FRED controls, a FRED CPU will keep tracking
host and guest FRED CPU state in VMCS automatically.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
v10:
 - s/rdmsrl/rdmsrq (Chao)
 - Remove a terse comment which doesn't help at all (Sean).
 - Replace direct, raw use of __this_cpu_ist_top_va() with a self-
   explanatory this_cpu_fred_rsp() helper for better readability (Sean).
 - Add cpu_feature_enabled(X86_FEATURE_FRED) to patch out accesses to
   VMCS FRED fields (Sean).
 - Remove "#ifdef CONFIG_X86_64" after switching to this_cpu_fred_rsp()
   (Sean).
---
 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/include/asm/vmx.h      | 32 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c          | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 683bb8bf43a9..8d3999772ac2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -294,6 +294,9 @@ struct kvm_host_values {
 	u64 xss;
 	u64 s_cet;
 	u64 arch_capabilities;
+
+	u64 fred_config;
+	u64 fred_stklvls;
 };
 extern struct kvm_host_values kvm_host;
 
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 682f09933612..4720619f09ac 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -306,12 +306,44 @@ enum vmcs_field {
 	GUEST_BNDCFGS_HIGH              = 0x00002813,
 	GUEST_IA32_RTIT_CTL		= 0x00002814,
 	GUEST_IA32_RTIT_CTL_HIGH	= 0x00002815,
+	GUEST_IA32_FRED_CONFIG		= 0x0000281a,
+	GUEST_IA32_FRED_CONFIG_HIGH	= 0x0000281b,
+	GUEST_IA32_FRED_RSP1		= 0x0000281c,
+	GUEST_IA32_FRED_RSP1_HIGH	= 0x0000281d,
+	GUEST_IA32_FRED_RSP2		= 0x0000281e,
+	GUEST_IA32_FRED_RSP2_HIGH	= 0x0000281f,
+	GUEST_IA32_FRED_RSP3		= 0x00002820,
+	GUEST_IA32_FRED_RSP3_HIGH	= 0x00002821,
+	GUEST_IA32_FRED_STKLVLS		= 0x00002822,
+	GUEST_IA32_FRED_STKLVLS_HIGH	= 0x00002823,
+	GUEST_IA32_FRED_SSP1		= 0x00002824,
+	GUEST_IA32_FRED_SSP1_HIGH	= 0x00002825,
+	GUEST_IA32_FRED_SSP2		= 0x00002826,
+	GUEST_IA32_FRED_SSP2_HIGH	= 0x00002827,
+	GUEST_IA32_FRED_SSP3		= 0x00002828,
+	GUEST_IA32_FRED_SSP3_HIGH	= 0x00002829,
 	HOST_IA32_PAT			= 0x00002c00,
 	HOST_IA32_PAT_HIGH		= 0x00002c01,
 	HOST_IA32_EFER			= 0x00002c02,
 	HOST_IA32_EFER_HIGH		= 0x00002c03,
 	HOST_IA32_PERF_GLOBAL_CTRL	= 0x00002c04,
 	HOST_IA32_PERF_GLOBAL_CTRL_HIGH	= 0x00002c05,
+	HOST_IA32_FRED_CONFIG		= 0x00002c08,
+	HOST_IA32_FRED_CONFIG_HIGH	= 0x00002c09,
+	HOST_IA32_FRED_RSP1		= 0x00002c0a,
+	HOST_IA32_FRED_RSP1_HIGH	= 0x00002c0b,
+	HOST_IA32_FRED_RSP2		= 0x00002c0c,
+	HOST_IA32_FRED_RSP2_HIGH	= 0x00002c0d,
+	HOST_IA32_FRED_RSP3		= 0x00002c0e,
+	HOST_IA32_FRED_RSP3_HIGH	= 0x00002c0f,
+	HOST_IA32_FRED_STKLVLS		= 0x00002c10,
+	HOST_IA32_FRED_STKLVLS_HIGH	= 0x00002c11,
+	HOST_IA32_FRED_SSP1		= 0x00002c12,
+	HOST_IA32_FRED_SSP1_HIGH	= 0x00002c13,
+	HOST_IA32_FRED_SSP2		= 0x00002c14,
+	HOST_IA32_FRED_SSP2_HIGH	= 0x00002c15,
+	HOST_IA32_FRED_SSP3		= 0x00002c16,
+	HOST_IA32_FRED_SSP3_HIGH	= 0x00002c17,
 	PIN_BASED_VM_EXEC_CONTROL       = 0x00004000,
 	CPU_BASED_VM_EXEC_CONTROL       = 0x00004002,
 	EXCEPTION_BITMAP                = 0x00004004,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2a2218e0983b..dc80ca5f804d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1562,6 +1562,12 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu)
 				    (unsigned long)(cpu_entry_stack(cpu) + 1));
 		}
 
+		if (cpu_feature_enabled(X86_FEATURE_FRED) && kvm_cpu_cap_has(X86_FEATURE_FRED)) {
+			vmcs_write64(HOST_IA32_FRED_RSP1, this_cpu_fred_rsp(FRED_STACK_LEVEL_1));
+			vmcs_write64(HOST_IA32_FRED_RSP2, this_cpu_fred_rsp(FRED_STACK_LEVEL_2));
+			vmcs_write64(HOST_IA32_FRED_RSP3, this_cpu_fred_rsp(FRED_STACK_LEVEL_3));
+		}
+
 		vmx->loaded_vmcs->cpu = cpu;
 	}
 }
@@ -4500,6 +4506,17 @@ void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
 	 */
 	vmcs_write16(HOST_DS_SELECTOR, 0);
 	vmcs_write16(HOST_ES_SELECTOR, 0);
+
+	if (cpu_feature_enabled(X86_FEATURE_FRED) && kvm_cpu_cap_has(X86_FEATURE_FRED)) {
+		/* FRED CONFIG and STKLVLS are the same on all CPUs */
+		vmcs_write64(HOST_IA32_FRED_CONFIG, kvm_host.fred_config);
+		vmcs_write64(HOST_IA32_FRED_STKLVLS, kvm_host.fred_stklvls);
+
+		/* Linux doesn't support kernel shadow stacks, thus SSPs are 0s */
+		vmcs_write64(HOST_IA32_FRED_SSP1, 0);
+		vmcs_write64(HOST_IA32_FRED_SSP2, 0);
+		vmcs_write64(HOST_IA32_FRED_SSP3, 0);
+	}
 #else
 	vmcs_write16(HOST_DS_SELECTOR, __KERNEL_DS);  /* 22.2.4 */
 	vmcs_write16(HOST_ES_SELECTOR, __KERNEL_DS);  /* 22.2.4 */
@@ -5030,6 +5047,17 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 	}
 
 	vmx_setup_uret_msrs(vmx);
+
+	if (cpu_feature_enabled(X86_FEATURE_FRED) && kvm_cpu_cap_has(X86_FEATURE_FRED)) {
+		vmcs_write64(GUEST_IA32_FRED_CONFIG, 0);
+		vmcs_write64(GUEST_IA32_FRED_RSP1, 0);
+		vmcs_write64(GUEST_IA32_FRED_RSP2, 0);
+		vmcs_write64(GUEST_IA32_FRED_RSP3, 0);
+		vmcs_write64(GUEST_IA32_FRED_STKLVLS, 0);
+		vmcs_write64(GUEST_IA32_FRED_SSP1, 0);
+		vmcs_write64(GUEST_IA32_FRED_SSP2, 0);
+		vmcs_write64(GUEST_IA32_FRED_SSP3, 0);
+	}
 }
 
 static void __vmx_vcpu_reset(struct kvm_vcpu *vcpu)
@@ -8883,6 +8911,11 @@ __init int vmx_hardware_setup(void)
 
 	kvm_caps.inapplicable_quirks &= ~KVM_X86_QUIRK_IGNORE_GUEST_PAT;
 
+	if (cpu_feature_enabled(X86_FEATURE_FRED) && kvm_cpu_cap_has(X86_FEATURE_FRED)) {
+		rdmsrq(MSR_IA32_FRED_CONFIG, kvm_host.fred_config);
+		rdmsrq(MSR_IA32_FRED_STKLVLS, kvm_host.fred_stklvls);
+	}
+
 	return 0;
 }
 
-- 
2.43.0

