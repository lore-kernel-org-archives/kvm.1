Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CCC355055;
	Thu, 10 Sep 2026 22:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789079669; cv=none; b=nlHBCiLvfScFzKIiu4R4CAtRtg/QiJpF71igvy1t+87cqKQLvMr4Q5AMgFtNo2V8YbEOPchUaXOX0T96AIgNXvgPv/vCFkrd4qBprlwJLwXe2+e+50UEw3Ank/rK7rCpgwQAYZtJmmXoJAeXtLGn/aDK29XAWjbvEWez1rirqMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789079669; c=relaxed/simple;
	bh=iDQI1L4c2kG8qVvCvgA+Osxg0WS1jnZM/F8nmdFfJnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ffmwVabEvivC/+TSmZ7iTMU3b9ZBGA0HlkriXDxzYPQ22cD8+d9RszlB+VXNcWUdeiVJ+WrTDYGfuzlZr9HQIgRmHnglu2IkxWC+faSChaO5toDQ/RpCEUpUzCtCSD/KIV3RihYNVZUCjhNUfZv56LuSGpauaXLnFVU4NpA7/vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVxaM8O/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVxaM8O/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789079667; x=1820615667;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=iDQI1L4c2kG8qVvCvgA+Osxg0WS1jnZM/F8nmdFfJnY=;
  b=lVxaM8O/ie4gcZFD5hbEhxv1G+9GDnkGeh3AJYc1S9Hp7twrN1dt31/v
   3bS8Di7VBnNaPjcWZ/DZLfafizzHCn1jPedVFWI7myHNvs28PJdFeRdk9
   WHD0ALLFPfvo/sWC7LSNkw2hZvi/NDQNmgJutBQetEdZZJCEwR7OM+se4
   QUa4An0YBgbl9p600/eg73r/m1jMAXAze+BpbeOCpvBBt9hm0pT2YK2P7
   A1N+LM9qFWHNJ1zdVUKM1uz8ZTloyxiEMjL3ir75s+AK5fiXKIkvrWmr6
   u7Eys1ySE4FF50UfJYuwYu/jlEthxABmLbirbWlfmtdrixSiQW+PDHFn7
   w==;
X-CSE-ConnectionGUID: TyYa11YtSZ6lEmXzzcmtKw==
X-CSE-MsgGUID: EEolN1lLT6S5ENkS7FpKyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="93407827"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="93407827"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 15:34:25 -0700
X-CSE-ConnectionGUID: iLufNV7XQ++i3myguPqdYg==
X-CSE-MsgGUID: w0xWTo24RUq7/p19f9CV3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="301647431"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.125.111.227])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 15:34:25 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Thu, 10 Sep 2026 16:34:09 -0600
Subject: [PATCH 2/2] x86/early_printk: Avoid #VE emulation for TDX guest
 serial output
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-b4-tdx_earlyprintk_tdcalls-v1-2-4b2b1bf9001b@intel.com>
References: <20260910-b4-tdx_earlyprintk_tdcalls-v1-0-4b2b1bf9001b@intel.com>
In-Reply-To: <20260910-b4-tdx_earlyprintk_tdcalls-v1-0-4b2b1bf9001b@intel.com>
To: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.16-dev-62088
X-Developer-Signature: v=1; a=openpgp-sha256; l=4064;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=iDQI1L4c2kG8qVvCvgA+Osxg0WS1jnZM/F8nmdFfJnY=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDFmLDQoyrjxcdOeqneHNnMyeO5FvjR6u06ydGV74NtjG6
 MHti4vjO0pZGMS4GGTFFFn+7vnIeExuez5PYIIjzBxWJpAhDFycAjARw0OMDOsL167hU1M+Nm9B
 ao/v0WmRYfsu7PFYvziT9UyrQ9b6p6aMDJOTDh3s7Xv/+sotwQ7ReVOrLA0LrrClH3334HRL8VL
 181wA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

A TDX guest cannot execute port I/O instructions directly, but
earlyprintk's serial console still issues plain inb()/outb() and lets
each one fault into the #VE handler to be emulated as a TDVMCALL.

While that works, it is a roundabout way to get a character out.
early_serial_putc() polls the LSR, and then writes a byte, but since the
TDX guest can't directly do port I/O, a #VE exception is raised. The #VE
handler must call TDG.VP.VEINFO.GET to find out what faulted, and then
it can issue the TDVMCALL that does the actual work.

This makes #VE a functional mechanism for doing I/O, which is not
desirable, is unnecessarily complicated and fragile, and results in
twice the number of calls into the TDX module.

Instead, issue the TDVMCALL directly. In early_printk.c, port access is
routed through static calls so the MMIO console can substitute its own
accessors. Add a TDX pair and swap them in the same way.

Note that the output does not appear any earlier - "earlyprintk=" is an
early_param(), so the console is still registered from
parse_early_param(). This only changes how the bytes leave the guest
once it is up.

LLMs were used under supervision to create this patch, to help
understand the scope and mechanisms, create testing instrumentation
(throwaway) to count #VEs before/after the change, and to drive lab
machines to do this testing.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 arch/x86/kernel/early_printk.c | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index cba75306e5b6..4a70799cd80a 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -21,6 +21,8 @@
 #include <linux/usb/xhci-dbgp.h>
 #include <asm/pci_x86.h>
 #include <linux/static_call.h>
+#include <asm/shared/tdx.h>
+#include <asm/vmx.h>
 
 /* Simple VGA output */
 #define VGABASE		(__ISA_IO_base + 0xb8000)
@@ -111,6 +113,48 @@ ANNOTATE_NOENDBR_SYM(io_serial_out);
 DEFINE_STATIC_CALL(serial_in, io_serial_in);
 DEFINE_STATIC_CALL(serial_out, io_serial_out);
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+/*
+ * A TDX guest cannot execute port I/O instructions, so ask the VMM to do it.
+ */
+static __noendbr unsigned int tdx_serial_in(unsigned long addr, int offset)
+{
+	struct tdx_module_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
+		.r12 = 1,			/* One byte */
+		.r13 = TDVMCALL_PORT_READ,
+		.r14 = addr + offset,
+	};
+
+	if (__tdx_hypercall(&args))
+		return UINT_MAX;
+
+	return args.r11;
+}
+ANNOTATE_NOENDBR_SYM(tdx_serial_in);
+
+static __noendbr void tdx_serial_out(unsigned long addr, int offset, int value)
+{
+	/* One byte */
+	_tdx_hypercall(hcall_func(EXIT_REASON_IO_INSTRUCTION), 1,
+		       TDVMCALL_PORT_WRITE, addr + offset, value);
+}
+ANNOTATE_NOENDBR_SYM(tdx_serial_out);
+
+/* Substitute the hypercall accessors, but only in an actual TDX guest */
+static __init void early_serial_tdx_init(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return;
+
+	static_call_update(serial_in, tdx_serial_in);
+	static_call_update(serial_out, tdx_serial_out);
+}
+#else
+static inline void early_serial_tdx_init(void) { }
+#endif /* CONFIG_INTEL_TDX_GUEST */
+
 static int early_serial_putc(unsigned char ch)
 {
 	unsigned timeout = 0xffff;
@@ -160,6 +204,9 @@ static __init void early_serial_init(char *s)
 	unsigned long baud = DEFAULT_BAUD;
 	char *e;
 
+	/* Must be before early_serial_hw_init(), which does port I/O */
+	early_serial_tdx_init();
+
 	if (*s == ',')
 		++s;
 
@@ -323,6 +370,7 @@ static __init void early_pci_serial_init(char *s)
 	 */
 	if ((bar0 & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO) {
 		/* it is IO mapped */
+		early_serial_tdx_init();
 		early_serial_base = bar0 & PCI_BASE_ADDRESS_IO_MASK;
 		write_pci_config(bus, slot, func, PCI_COMMAND,
 				 cmdreg|PCI_COMMAND_IO);

-- 
2.55.0

