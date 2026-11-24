Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551066;
	b=5LJOo8Pp/qPkuJkZStmHJBJFB8HUpvoaHwAIQMYGE94eEG/wILtLu/Xeo/zCSi/ffcRn
	 BSyEPOIpon1lUmtI8y7oDgIn0WSNwgXvL+eAmA5R2s6qJzUtpiPnVzNQ6S2PSSGKPE7ZB
	 4I4TVB5Jwj0az7hvIjisqcCmXC6pBgmL45pCML0jobtCNq7QcuJK1ajBE0PlX6DXMaVFo
	 uk+1bXEeipuekJh+Z7H0+wacpcK8q54mit2ShxKx2ikSaBjPROhhDjnVlVzjZsnolV0NF
	 gaIKxrasvGsJBpyGy+NCU5bJLRhYkkIm5AGaD227MCA+iFepJcQ4nqd82HOLINBqNGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551066;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=U3y9UCsgeJg73xzi87YxF5m6L5LFaQYi0IQ2Zw2olYE=;
	b=cIhbl9sW1U6uVR1JyRfDCcRRbLpaYsLH9dODgJCWLQ5XzAMG8mqCcMxnJI9nK8JRJDPy
	 5kyqTZsQbZzdhyAISQ5ORBOf5NIyl859i/YSPP6CjgxRigGjgU9MZvpthVq+294oXOYCt
	 MDPHDNlEAdsZirZ7gTwoyVp7A88pF8xweNnoetDyyLc3m8txZpH/AV7ze4SByLFd7O8MK
	 B75nUjHh0FE1ho9U98pDWvu5553AUW4eaJnOG12DpUQbRfMnmyVFPfM+2XDqMWL9IZRmN
	 7BDr/mitLxyCWMZJ5CiXBzdqm/z9+lG4DF8XY/DiQwEGWEOIZR0KYz/SzNXsUTZoq3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mbQpsIKK;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BD0606A31E;
	Tue, 24 Nov 2026 20:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2BD0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mbQpsIKK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795551066; x=1827087066;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ud3lCDNXvNmw1yqi6k8UEwUcr9dmgPSDrXaCS39y36M=;
  b=mbQpsIKK7w5xHO+r03vppdftOh+97Douv1efInV9HePmk8tR1KK7o7Ow
   t3lp4eNMLYGSTZ7qcdDcnLvUT8Z/Q2iUGv9I51m+WDGzsbrUFc2h5EdkK
   l1bDQcreTQExsQ8lbn1U/QDSp/2Cbw4Oy3iNRjGNSYtvFFk2KjVLdVqkq
   KRi3Zv4eXk2HrJEAOb7mi/nIjU5bGfeKoyqAv//ndo7AQ05F4/MJR2GP9
   Ph7fKclSA21/Htk+EyJSza6gUdP0qas67EiajZDiN9LQv1G6vDmuJwR2V
   R0dkY/yrgXCQBgTbbfuGARTss4W/XcRYfJGAXQJfFgRcVr+wpWBeICPyE
   w==;
X-CSE-ConnectionGUID: hLlQf+luSmOD2LfB8hFwXA==
X-CSE-MsgGUID: /WldN0YxRzGmVaO62SLHMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4412394"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4412394"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 12:10:20 -0800
X-CSE-ConnectionGUID: ZGC/kd++R42D1q6yY5gUSA==
X-CSE-MsgGUID: uU1Nhyd6Tp2owzcioIEdEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="11646966"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 24 Nov 2026 12:09:20 -0800
From: Sohil Mehta <sohil.mehta@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Chao Gao <chao.gao@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/fred: Consolidate the FRED stack pointer assignments
Date: Tue, 24 Nov 2026 12:06:59 -0800
Message-ID: <20261124200659.471685-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FRED delivers events on one of four stack levels, and each level has its
own stack pointer MSR. The mapping of stacks to levels is only implied
by the MSR writes. Nothing in the code explicitly states it, or notes
that #MC uses the NMI stack.

Add a helper that makes the connection obvious and returns the
corresponding stack pointer for each RSP MSR. Use it to program all four
FRED RSP MSRs during CPU initialization.

Key the helper on the MSR index rather than the stack level to keep it
simple. Later, the same interface can easily be exported to KVM or
extended for FRED shadow stack MSRs as well.

No functional change intended.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
This is a standalone cleanup that was part of the FRED KVM series. Dave
asked me to send things like this up separately for consideration:
https://lore.kernel.org/lkml/1712c0cd-747b-4dce-8231-0c8d75225648@intel.com/

v2:
 - Reframe as an x86 cleanup. Drop the export, the KVM heavy changelog
   and the unused !CONFIG_X86_FRED stub (Dave).
 - Program the level 0 stack pointer MSR through the helper too, so that
   all four of them go through it.
 - Keep the helper static for now, since all the callers are file-local.

v1: https://lore.kernel.org/lkml/20261124015840.2673975-1-sohil.mehta@intel.com/
---
 arch/x86/kernel/fred.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/fred.c b/arch/x86/kernel/fred.c
index 1c452a389a70..35f5c27c7198 100644
--- a/arch/x86/kernel/fred.c
+++ b/arch/x86/kernel/fred.c
@@ -25,6 +25,27 @@
 DEFINE_PER_CPU(unsigned long, fred_rsp0);
 EXPORT_PER_CPU_SYMBOL(fred_rsp0);
 
+static unsigned long this_cpu_fred_sp(u32 msr)
+{
+	switch (msr) {
+	case MSR_IA32_FRED_RSP0:
+		return __this_cpu_read(fred_rsp0);
+	case MSR_IA32_FRED_RSP1:
+		return __this_cpu_ist_top_va(ESTACK_DB);
+	case MSR_IA32_FRED_RSP2:
+		/*
+		 * NMI and #MC both use the NMI stack so ESTACK_MCE is left
+		 * unused on a FRED system.
+		 */
+		return __this_cpu_ist_top_va(ESTACK_NMI);
+	case MSR_IA32_FRED_RSP3:
+		return __this_cpu_ist_top_va(ESTACK_DF);
+	default:
+		WARN_ONCE(1, "Unexpected FRED stack pointer MSR 0x%x\n", msr);
+		return 0;
+	}
+}
+
 void cpu_init_fred_exceptions(void)
 {
 	/*
@@ -53,7 +74,7 @@ void cpu_init_fred_exceptions(void)
 	 * Ater a CPU offline/online cycle, the FRED RSP0 MSR should be
 	 * resynchronized with its per-CPU cache.
 	 */
-	wrmsrq(MSR_IA32_FRED_RSP0, __this_cpu_read(fred_rsp0));
+	wrmsrq(MSR_IA32_FRED_RSP0, this_cpu_fred_sp(MSR_IA32_FRED_RSP0));
 
 	wrmsrq(MSR_IA32_FRED_RSP1, 0);
 	wrmsrq(MSR_IA32_FRED_RSP2, 0);
@@ -84,7 +105,7 @@ void cpu_init_fred_rsps(void)
 	       FRED_STKLVL(X86_TRAP_DF,  FRED_DF_STACK_LEVEL));
 
 	/* The FRED equivalents to IST stacks... */
-	wrmsrq(MSR_IA32_FRED_RSP1, __this_cpu_ist_top_va(ESTACK_DB));
-	wrmsrq(MSR_IA32_FRED_RSP2, __this_cpu_ist_top_va(ESTACK_NMI));
-	wrmsrq(MSR_IA32_FRED_RSP3, __this_cpu_ist_top_va(ESTACK_DF));
+	wrmsrq(MSR_IA32_FRED_RSP1, this_cpu_fred_sp(MSR_IA32_FRED_RSP1));
+	wrmsrq(MSR_IA32_FRED_RSP2, this_cpu_fred_sp(MSR_IA32_FRED_RSP2));
+	wrmsrq(MSR_IA32_FRED_RSP3, this_cpu_fred_sp(MSR_IA32_FRED_RSP3));
 }

base-commit: 135dbd0519cf7f72af120801ec7dbb79275a362d
-- 
2.43.0

