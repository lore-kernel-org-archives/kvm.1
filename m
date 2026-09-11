Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707E948663E;
	Fri, 11 Sep 2026 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162872; cv=none; b=BmjpVUUcm4CwwbQvRSFDaTmipdV5iZZh9/S5K5X2E9tDzBOlj2k7YJyGyoJ4hyH7Kw+w36eNtOsE/WKgDp73P6aSBY2HrgoVCpfcrr8Yb053jn4j8aaJlanTCJJf2f8k8TRXIt9EoUEnjISKo0JvJAJFxE6PNLO36mE83ng/x7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162872; c=relaxed/simple;
	bh=oGW+uzEXEc0mTanrOErJYE0T2Ofyhqc9C3G0tII9PdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFprIxEGzgoEA5g3pjUmg5HVJqhpgNUnTuvhjrhBsVoD3M1Fc/IRl2I06i8xLE2EyyLccpDcyRTDdWIV3oHjTBZJc2QFGK/h6kusALu3rY5OSPfEqw7+cKfQZmyHZSGIu2Q3Fn+RAXgCyg+IQw4ZtVaikhO/UlZ+L8gK6EPxMQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ii9HB16t; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ii9HB16t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789162871; x=1820698871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oGW+uzEXEc0mTanrOErJYE0T2Ofyhqc9C3G0tII9PdY=;
  b=Ii9HB16tweFcRu+vzC9pMPbBXSiKx5F7yDpXZOL2aq38z137gA704S0h
   FCGlBfUEw5Bl+I6HNZZPOyFgO64NiLMIXFT4e+UCoVO2YjnrHHiuDRXbb
   TM+DDrrqjf06fvaNOnoAsbbIZYNU52S4b/hV+vS5oDrD1fbLMR11IgCyn
   ZlRrQsdKwqYqRC/BOtfQ2RItFQf8jQtSb9WUxBwbcGZRbx9+XpWeuPmIE
   o2WgF4PqzhUlwAQkeu9LWtAeGISF1O2/yYy0oBNLnYBjJdm+a98L6zuM0
   /CliSUtFHEGXLxMGNsBHJv7504LL98BmD3G2OHOBV61lPKNxc8cTADbv8
   w==;
X-CSE-ConnectionGUID: myEI+jnjQwm6Bsbkho3GAg==
X-CSE-MsgGUID: sKmmNtU7TeyF8AW7aYz3JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572547"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572547"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:41:10 -0700
X-CSE-ConnectionGUID: yeFQZaU5RrGPsnTdg6YT7g==
X-CSE-MsgGUID: lfK9+TYaR8SLgEFjtP55QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272004062"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:41:09 -0700
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
Subject: [PATCH v10 09/28] KVM: VMX: Save/restore guest FRED RSP0
Date: Fri, 11 Sep 2026 14:36:39 -0700
Message-ID: <20260911213659.2025974-10-sohil.mehta@intel.com>
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

Save guest FRED RSP0 in vmx_prepare_switch_to_host() and restore it
in vmx_prepare_switch_to_guest() because MSR_IA32_FRED_RSP0 is passed
through to the guest, thus is volatile/unknown.

Note, host FRED RSP0 is restored in arch_exit_to_user_mode_prepare(),
regardless of whether it is modified in KVM.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
v10:
 - No change

Note, an equivalent TDX side implementation is missing. No TDX module
with FRED support exists yet so this would be an issue for future
platforms. A generic discussion regarding this is ongoing at:
https://lore.kernel.org/kvm/20260827031837.2863609-1-binbin.wu@linux.intel.com/
---
 arch/x86/kvm/vmx/vmx.c | 13 +++++++++++++
 arch/x86/kvm/vmx/vmx.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 09bbbc680aa7..b6b73ab9cfb7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1395,6 +1395,9 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	}
 
 	wrmsrq(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
+
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_FRED))
+		wrmsrns(MSR_IA32_FRED_RSP0, vmx->msr_guest_fred_rsp0);
 #else
 	savesegment(fs, fs_sel);
 	savesegment(gs, gs_sel);
@@ -1439,6 +1442,16 @@ static void vmx_prepare_switch_to_host(struct vcpu_vmx *vmx)
 	invalidate_tss_limit();
 #ifdef CONFIG_X86_64
 	wrmsrq(MSR_KERNEL_GS_BASE, vmx->vt.msr_host_kernel_gs_base);
+
+	if (guest_cpu_cap_has(&vmx->vcpu, X86_FEATURE_FRED)) {
+		vmx->msr_guest_fred_rsp0 = read_msr(MSR_IA32_FRED_RSP0);
+		/*
+		 * Synchronize the current value in hardware to the kernel's
+		 * local cache.  The desired host RSP0 will be set when the
+		 * CPU exits to userspace (RSP0 is a per-task value).
+		 */
+		fred_sync_rsp0(vmx->msr_guest_fred_rsp0);
+	}
 #endif
 	load_fixmap_gdt(raw_smp_processor_id());
 	vmx->vt.guest_state_loaded = false;
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 7a22e1b1a273..14fd3f57d5c1 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -222,6 +222,7 @@ struct vcpu_vmx {
 	bool                  guest_uret_msrs_loaded;
 #ifdef CONFIG_X86_64
 	u64		      msr_guest_kernel_gs_base;
+	u64		      msr_guest_fred_rsp0;
 #endif
 
 	u64		      spec_ctrl;
-- 
2.43.0

