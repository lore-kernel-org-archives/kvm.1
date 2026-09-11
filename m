Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367524A0F0F;
	Fri, 11 Sep 2026 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162844; cv=none; b=tL8GJ05X42Gf0i65h6JypTMKy4ts+4ZZ3rHDx05yD4uGksxE+vC4r7kWSfN6lLZgeilKecUXECPF18LZAyCUDM4+1gJpUGFWDfe+TptlxcfVBSt8JHjKYcTgbSOe/0JkZTWivs+NSXgN+Vebsyyok3su8W3WxB9JvtSVRLig5UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162844; c=relaxed/simple;
	bh=w6qxiFwdlREk3h/Q9LuqQ/wTCx279xrP36NXKR5c2R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5jgXCV/DcnvMryn4hquOcJtljTUmt8owgAsS5bNGLjUw+xDLeWwcTATmuC3e49kzqVFVRk7MfFdZ3YfdHReZ7V6v19x3r342IqjNtNKKBiAhH6QPrm0aEK71Qs63GJDbntO6cj7WjkAfhL7gd3dVJr7CU6hNkUJtMZotybvkqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UM9L0qJ8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UM9L0qJ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789162842; x=1820698842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w6qxiFwdlREk3h/Q9LuqQ/wTCx279xrP36NXKR5c2R0=;
  b=UM9L0qJ8x4mkRYyQ0OEA2ZU2AIfQ+vwgYFIyktB1YYlGYtr2Zagye9BH
   pPMqCt6rQhmzzKqGEOqKwkcwpqMw8BOvB3gpztzgr8M9FNNkoMQr1wM5W
   EFeoOKvbjyLhTNKcHpkSfckomTQAtXEvV7ud/RmuzGpCX35z+2C1HNJUJ
   hIjr4msCv19WRkd/QQySEwC1rNmh6J9sdigaBsYHvZR9mO02JkrDlSf/S
   ZWWF1m5xCx+oCEGvzJe42U/jwYueMQpjOpmIUaheEBVXAwEe1bYisM+Jf
   pMzqdV+TDaOHTGLp1B9KauzFT+w8VDE1iHtxLWNfnHScVuUM3Qk7PHjER
   g==;
X-CSE-ConnectionGUID: z96k+3+HSwOsQKUbL3ZicQ==
X-CSE-MsgGUID: OrTpFGyvQ6iTgu00DeVLIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572484"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572484"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:40:42 -0700
X-CSE-ConnectionGUID: 93hrEfdsTqmTNdCVcTCXAA==
X-CSE-MsgGUID: wD5yX24cRgeYyN93LVyqrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272004001"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:40:41 -0700
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
Subject: [PATCH v10 06/28] x86/fred: Export this_cpu_fred_rsp() for KVM usage
Date: Fri, 11 Sep 2026 14:36:36 -0700
Message-ID: <20260911213659.2025974-7-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911213659.2025974-1-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Xin Li (Intel)" <xin@zytor.com>

Introduce and export this_cpu_fred_rsp() to provide KVM with a self-
explanatory interface for retrieving per-CPU FRED regular stacks for
stack levels 1->3.

FRED introduced new fields in the VMCS host-state area for stack levels
1–>3 (HOST_IA32_FRED_RSP[123]), which correspond to the per-CPU FRED
regular stacks for stack levels 1->3.  KVM must populate these fields
each time a vCPU is loaded onto a CPU to ensure a complete valid FRED
event delivery context immediately after any VM-Exits.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Replace direct, raw use of __this_cpu_ist_top_va() with a self-
   explanatory this_cpu_fred_rsp() helper for better readability (Sean).
---
 arch/x86/include/asm/fred.h | 10 ++++++++++
 arch/x86/kernel/fred.c      | 24 +++++++++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index 18a2f811c358..85b851f16bae 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -35,6 +35,13 @@
 
 #ifndef __ASSEMBLER__
 
+enum fred_stack_level {
+	FRED_STACK_LEVEL_0,
+	FRED_STACK_LEVEL_1,
+	FRED_STACK_LEVEL_2,
+	FRED_STACK_LEVEL_3
+};
+
 #ifdef CONFIG_X86_FRED
 #include <linux/kernel.h>
 #include <linux/sched/task_stack.h>
@@ -105,6 +112,8 @@ static __always_inline void fred_update_rsp0(void)
 		__this_cpu_write(fred_rsp0, rsp0);
 	}
 }
+
+unsigned long this_cpu_fred_rsp(enum fred_stack_level lvl);
 #else /* CONFIG_X86_FRED */
 static __always_inline unsigned long fred_event_data(struct pt_regs *regs) { return 0; }
 static inline void cpu_init_fred_exceptions(void) { }
@@ -112,6 +121,7 @@ static inline void cpu_init_fred_rsps(void) { }
 static inline void fred_complete_exception_setup(void) { }
 static inline void fred_sync_rsp0(unsigned long rsp0) { }
 static inline void fred_update_rsp0(void) { }
+static inline unsigned long this_cpu_fred_rsp(enum fred_stack_level lvl) { return 0; }
 #endif /* CONFIG_X86_FRED */
 #endif /* !__ASSEMBLER__ */
 
diff --git a/arch/x86/kernel/fred.c b/arch/x86/kernel/fred.c
index 1c452a389a70..68947c53a494 100644
--- a/arch/x86/kernel/fred.c
+++ b/arch/x86/kernel/fred.c
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/kernel.h>
+#include <linux/kvm_types.h>
 
 #include <asm/desc.h>
 #include <asm/fred.h>
@@ -69,6 +70,23 @@ void cpu_init_fred_exceptions(void)
 	setup_clear_cpu_cap(X86_FEATURE_SYSCALL32);
 }
 
+unsigned long this_cpu_fred_rsp(enum fred_stack_level lvl)
+{
+	switch (lvl) {
+	case FRED_STACK_LEVEL_0:
+		return __this_cpu_read(fred_rsp0);
+	case FRED_STACK_LEVEL_1:
+		return __this_cpu_ist_top_va(ESTACK_DB);
+	case FRED_STACK_LEVEL_2:
+		return __this_cpu_ist_top_va(ESTACK_NMI);
+	case FRED_STACK_LEVEL_3:
+		return __this_cpu_ist_top_va(ESTACK_DF);
+	default:
+		BUG();
+	}
+}
+EXPORT_SYMBOL_FOR_KVM(this_cpu_fred_rsp);
+
 /* Must be called after setup_cpu_entry_areas() */
 void cpu_init_fred_rsps(void)
 {
@@ -84,7 +102,7 @@ void cpu_init_fred_rsps(void)
 	       FRED_STKLVL(X86_TRAP_DF,  FRED_DF_STACK_LEVEL));
 
 	/* The FRED equivalents to IST stacks... */
-	wrmsrq(MSR_IA32_FRED_RSP1, __this_cpu_ist_top_va(ESTACK_DB));
-	wrmsrq(MSR_IA32_FRED_RSP2, __this_cpu_ist_top_va(ESTACK_NMI));
-	wrmsrq(MSR_IA32_FRED_RSP3, __this_cpu_ist_top_va(ESTACK_DF));
+	wrmsrq(MSR_IA32_FRED_RSP1, this_cpu_fred_rsp(FRED_STACK_LEVEL_1));
+	wrmsrq(MSR_IA32_FRED_RSP2, this_cpu_fred_rsp(FRED_STACK_LEVEL_2));
+	wrmsrq(MSR_IA32_FRED_RSP3, this_cpu_fred_rsp(FRED_STACK_LEVEL_3));
 }
-- 
2.43.0

