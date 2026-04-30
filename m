Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C7DEACD;
	Thu, 30 Apr 2026 02:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777514755; cv=none; b=Xr90IgNSXE26WHfee2KaCAZeoyFbGk9bx3h8ktbciZSBteB4nZM4kdyIZIMVo9IQzFaa9XQEbyCVm9Rbgp9OL+rByQuoCXwxSEd18J027I5dLkqY4EdU22RVNcXo8GDq2ASHkTUe1ZBeJj1tSTEOhhLDFO3yyfR0vkK9Nqplcjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777514755; c=relaxed/simple;
	bh=F/jba/X8074nZy1KSSUYW8kNl5RKiW/d9kTOdmXc4yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qC06UBfkm3FfrYY7xwZKJEeBJZl+vuxikscHPQZph+sa91RXPrzkxVyCryBXlka5RLUcMEb1flltG0NafFsJdzTf0LC3m+8tqUyi11kggXGx0p+5zvNQr2u2vIA1RiGubwxwhvJ1oQYOwOsKqA5O+IcXslJ20Wpmk1E+lOZ8gYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QPnjLwN1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QPnjLwN1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777514753; x=1809050753;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F/jba/X8074nZy1KSSUYW8kNl5RKiW/d9kTOdmXc4yk=;
  b=QPnjLwN1ri7A2jMQ3RTdPKdEnAvgr79Yi4M8mmlplLCc1AN7WmkMY0VN
   PLBu428ZD4ITzC8wcbyWaqVmmuOnLyXRTvUOJuLIcgv+Zz8yFIhVgaIVD
   D4yeSu8kSDVzmZrnganDhexUwQcZzmaG4PViHssimZup/iOUdScoJCf2n
   pujDmyUykI38OpzD2e871TL1BORW9MhoY9fG58HQl3UiZ/yA+2GM99rur
   CFbL0u9QYIaicvHi+Mcx30Ml2Tg+FtRV2D2kBhM3xk2s0EqHEtlPSBVul
   olC2fwHU/5sB9dg6BOzGBO02Dvo8Xd9NHX1xDEmhnPoX+hGcEZy38/g0C
   g==;
X-CSE-ConnectionGUID: bOvsW2viQout6BHP7W/1sw==
X-CSE-MsgGUID: b8RW2E3+TjGDyaP8SS+b/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78167318"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="78167318"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 19:05:53 -0700
X-CSE-ConnectionGUID: XyWo98CTSCmFDygViR15cQ==
X-CSE-MsgGUID: ZUGLaO8ERPe5uSJZf4xYPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="234327523"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 19:05:51 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	kvm@vger.kernel.org
Cc: dave.hansen@intel.com,
	seanjc@google.com,
	pbonzini@redhat.com,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	vishal.l.verma@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	binbin.wu@linux.intel.com
Subject: [PATCH v2] x86/cpu: Skip reading MSR_IA32_PLATFORM_ID in virtualized environment
Date: Thu, 30 Apr 2026 10:09:53 +0800
Message-ID: <20260430020953.1405535-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel now reads MSR_IA32_PLATFORM_ID during CPU init.  When
running as a guest, if the underlying hypervisor does not emulate the
MSR, the RDMSR from MSR_IA32_PLATFORM_ID can trigger an unchecked MSR
access during early boot.  This MSR is not emulated in the case for KVM
TDX, where the following is observed in the TD guest:

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

The platform ID is used for one thing and one thing only: microcode
updates.  Those updates are solely the domain of the bare-metal OS.  The
guest kernel code should not even try to touch the MSR.  Skip reading
the MSR when the kernel is running in a virtualized environment.  0 is a
valid platform ID, however, microcode related logic is skipped in a
virtualized environment.

Since intel_get_platform_id() could be called early before cpuinfo_x86
is fully initialized in the case of CONFIG_MICROCODE_DBG, check whether
the kernel is running in a virtualized environment from CPUID.  Use
cpuid_ecx() instead of native_cpuid_ecx() so that Xen PV guest will see
the virtualized bit.

Fixes: d8630b67ca1ed ("x86/cpu: Add platform ID to CPU info structure")
Reported-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v2:
- Drop the patch on KVM side. (Sean, Dave)
- Use X86_FEATURE_HYPERVISOR for better readability. (Dave)
- Use cpuid_ecx() instead of native_cpuid_ecx() to check the hypervisor bit.
- Add RB from Rick.
---
 arch/x86/kernel/cpu/microcode/intel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 37ac4afe0972..1bc0c350726c 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -147,6 +147,10 @@ u32 intel_get_platform_id(void)
 	if (intel_cpuid_vfm() <= INTEL_PENTIUM_II_KLAMATH)
 		return 0;
 
+	/* Don't try to read microcode bits when virtualized. */
+	if (cpuid_ecx(1) & BIT(X86_FEATURE_HYPERVISOR & 0x1f))
+		return 0;
+
 	/* get processor flags from MSR 0x17 */
 	native_rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
 

base-commit: 9974969c14031a097d6b45bcb7a06bb4aa525c40
-- 
2.46.0

