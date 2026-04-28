Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485ED399039;
	Tue, 28 Apr 2026 02:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777344243; cv=none; b=RkBmJmZXci/kqOJU4LCgYSnjUx9L3e4D2Q8Xr4klkAfVKox20sAWPkZCWrhmz25kEu8S+HpcFm1ecfK8aS9nIBgQRrmdMTAxvXVx1EifUuPOIeLul2iQsSNpYk22ua3bnpwSWszcSP/Xu+/Jo3kKH9xpx6NPCgliaXg9rdFip7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777344243; c=relaxed/simple;
	bh=z7ZK8TLDaYBSF/7f/V/eqd54Mqd0jIJMP4tJH7E1aMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlU02oyq6gBjGVWmKdALl0DUrFiAkBmeDeaEVCRCr8BbUODsx4AIz8MzgIo58AxogvgCVihfNa8Km57hFmay2OQyzE0RWNYuDXLMHpD2lBhTXTO/6NNogpI98EX+Uirfuer1txX4PMIcTkhlocYgH861Jn2pca4gAXqr4nfD6Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1/mwqTT; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1/mwqTT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777344231; x=1808880231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z7ZK8TLDaYBSF/7f/V/eqd54Mqd0jIJMP4tJH7E1aMU=;
  b=E1/mwqTTHVelN1ISHgiBJNmPz//zYzhFlvbPwva831lWm6ow7ebuzjyk
   Ul1DRDkYa4l2G2FSwGs8fF8sEh0zymFE9857LnwfQ5zF71UY2KiFTk8KX
   dhAeqEbBYrfyLGOJ3k/obplKEozzAiuOL/+cC8kwbLym/7LPzuHZwPPg6
   CnYsclJ95nZLcQJYHcic3+4Vr9w7vuIsnVr48XlT1VDMfbSV4dBrGuvX/
   k9mHfIcpaHkIDOjq+501WzVedx95h91hhT/jGOqylMPuuI2oS9WJchp3/
   7qQrdioGHrOZvtWQMcHLWkJiLrfbNupXJCpvOBQBPoUJQf8uciu1VKkFL
   Q==;
X-CSE-ConnectionGUID: wlSgttKgQwGa4NUBMBuwTw==
X-CSE-MsgGUID: pHIk2DK5ST+/pZsRVnZwcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82096004"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="82096004"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 19:43:51 -0700
X-CSE-ConnectionGUID: UHvBJLxwQlit1jjx2+V7cQ==
X-CSE-MsgGUID: ihXS4Ql4Q3ySeRj/rQtVJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="271943214"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 19:43:48 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	dave.hansen@intel.com,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	vishal.l.verma@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	binbin.wu@linux.intel.com
Subject: [PATCH 2/2] x86/cpu: Skip reading MSR_IA32_PLATFORM_ID in virtualized environment
Date: Tue, 28 Apr 2026 10:47:46 +0800
Message-ID: <20260428024746.1040531-3-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260428024746.1040531-1-binbin.wu@linux.intel.com>
References: <20260428024746.1040531-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Linux kernel now reads MSR_IA32_PLATFORM_ID during CPU init.  When
running as a guest, if the underlying hypervisor does not emulate the
MSR, the RDMSR from 0x17 in intel_get_platform_id() can trigger an
unchecked MSR access during early boot.

    unchecked MSR access error: RDMSR from 0x17 at rIP: 0xffffffffba38d6fc (intel_get_platform_id+0x7c/0xb0)
    Call Trace:
     <TASK>
     ? early_init_intel+0x28/0x2c0
     ? early_cpu_init+0x9b/0x930
     ? setup_arch+0xbf/0xbb0
     ? _printk+0x6b/0x90
     ? start_kernel+0x7f/0xaa0
     ? x86_64_start_reservations+0x24/0x30
     ? x86_64_start_kernel+0xda/0xe0
     ? common_startup_64+0x13e/0x141
     </TASK>

Currently, KVM does not support guest reads of MSR_IA32_PLATFORM_ID for
TDX.  This should be fixed in the hypervisor, but for compatibility with
newer guests running on older KVM hosts, skip reading MSR_IA32_PLATFORM_ID
and return 0. It's meaningless to read MSR_IA32_PLATFORM_ID since guests
are not allowed to do microcode update.  cpu_has_old_microcode(), which
uses platform ID for CPU match, also skips checking whether the microcode
is old or not in a virtualized environment.

Since intel_get_platform_id() can be called early before cpuinfo_x86
is fully initialized, check whether it's running in a virtualized
environment from CPUID and opportunistically add a helper.

Fixes: d8630b67ca1ed ("x86/cpu: Add platform ID to CPU info structure")
Reported-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kernel/cpu/microcode/core.c     | 2 +-
 arch/x86/kernel/cpu/microcode/intel.c    | 4 ++++
 arch/x86/kernel/cpu/microcode/internal.h | 5 +++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 651202e6fefb..ee204c8a90bf 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -135,7 +135,7 @@ bool __init microcode_loader_disabled(void)
 	 * 3) Certain AMD patch levels are not allowed to be
 	 *    overwritten.
 	 */
-	hypervisor_present = native_cpuid_ecx(1) & BIT(31);
+	hypervisor_present = x86_cpuid_has_hypervisor();
 
 	if ((hypervisor_present && !IS_ENABLED(CONFIG_MICROCODE_DBG)) ||
 	    amd_check_current_patch_level())
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 37ac4afe0972..cb93e4ea410e 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -147,6 +147,10 @@ u32 intel_get_platform_id(void)
 	if (intel_cpuid_vfm() <= INTEL_PENTIUM_II_KLAMATH)
 		return 0;
 
+	/* Don't try to read microcode bits when virtualized. */
+	if (x86_cpuid_has_hypervisor())
+		return 0;
+
 	/* get processor flags from MSR 0x17 */
 	native_rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
 
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 3b93c0676b4f..0233e074d76b 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -100,6 +100,11 @@ static inline unsigned int x86_cpuid_family(void)
 	return x86_family(eax);
 }
 
+static inline bool x86_cpuid_has_hypervisor(void)
+{
+	return native_cpuid_ecx(1) & BIT(31);
+}
+
 extern bool force_minrev;
 
 #ifdef CONFIG_CPU_SUP_AMD
-- 
2.46.0

