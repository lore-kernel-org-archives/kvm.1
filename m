Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659959;
	b=j1T+tBJ5pwCgQhcDlsQ0bP3XBKa1USjlcRmruu8E/Kq0lmJiEpScAxqFck+sab0wlGJV
	 hIe/4rY/KGwSygofiwjvxuBOEH3Rpf45Qo1GMJ23Z5NcpLeoHuKmgQmakfLeJoZ0ivJYT
	 SgoaolOXYrU3mpB3LBv0OtEiuTH25d5F/CtkRlJwcE4DavcbRR6fVxBGm+TpRd6bHEAWt
	 1TUZZqJhSZfc/O8J8ITEQyzVJPqkH256r8Cyv6MpjdyblKWDADWj6MbcuwItG5FaNO97B
	 WR/ld+ElKKpUM5kYWVqf+8mWOZREI2czm3Pc4YyNZCbcyAYjWaCzGS+GDOmqmR30avg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659959;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=5EeFOGrNhJvOiwMb9ZcmuSbFCO5HUpUlaUKGB5+z6e8=;
	b=RtgpK87Sr4zZ+Kh5Afrx6lyFaQXMi6WA9ziRFI10rnYdSGvBJFETo9y+7UDKZO/6hhoU
	 HqBsAd2bf1uss6HKCZkutaXdTrli4lzmxC0cslf6ERojFZH10/mJ+AfODRyKPje4f9DTJ
	 RbwLLbfqcIRWREhYXeaosHJDZGPrF9IDgbB6ortK8t6zCUPez6gmU4lIAp9QFDS7fUKIG
	 dwAiSVpI/MjCW/dCo0O/rqxjiylZNswbYwMO9MsZdhO/WKID/cUWtGZFZwFLyzz3mGiDk
	 UILyoe0QVxMGIAVcmED+2RL9cYzPUs3cLbSh1sFahDovKWtM8tFCS0MfgPM3JFbtrdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SX7X9Ppp;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3632E606A32E;
	Mon,  2 Nov 2026 22:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3632E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SX7X9Ppp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793659959; x=1825195959;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=K5gvYgmGTJk4RzxZ/MTJMmU7IeJumBJZ0T2Adr6olbI=;
  b=SX7X9Pppbyf+DEoJHEQ/JLCqMvxDRzIo8EKBu/hYBZkBGiV8ZOkqUnyg
   iGHI0vsQP739dRHqgpzq5kUmD7Tn9S0lSyWtHRRzBff/T9srNuOHqeMb7
   EjETilCcVFRLroGZ6SN7qf39iOmuRnzLaULSBF1BvQSi8JLF//8TwVvSa
   6vP8jQvRJXryvKn36oPVL7ssh1RM7VtTSpAHgQ9RPGlqX2SXLRvPf9axI
   zW4qv7Hc+FtHC73QD0HSC87aNuJHW/wzYHvtuN9cGfsp1lDVYdOQFwYW5
   WrGPS7rxK7PRrA4TCJXf4JHYsdKwMkQuBFx+kbjVM4j5eK+DDLU8g75UO
   Q==;
X-CSE-ConnectionGUID: HENAJWSjQGqSNTWV1ZjmkQ==
X-CSE-MsgGUID: kU/H4WEhS82Ib6SAtC48Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2258124"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2258124"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:52:38 -0800
X-CSE-ConnectionGUID: 5LI0IB62QEClgPyanGW5zw==
X-CSE-MsgGUID: 0DCILlXsTa6Pl16GMftRPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6360441"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.125.109.177])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:52:37 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Mon, 02 Nov 2026 15:51:58 -0700
Subject: [PATCH v5 1/2] x86/tdx: Move port I/O definitions to a shared
 header
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-b4-tdx_earlyprintk_tdcalls-v5-1-b01bc95d44ff@intel.com>
References: <20261102-b4-tdx_earlyprintk_tdcalls-v5-0-b01bc95d44ff@intel.com>
In-Reply-To: <20261102-b4-tdx_earlyprintk_tdcalls-v5-0-b01bc95d44ff@intel.com>
To: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 Nikolay Borisov <nik.borisov@suse.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=3219;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=K5gvYgmGTJk4RzxZ/MTJMmU7IeJumBJZ0T2Adr6olbI=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDFkvRXRbrM27lPMkMuvNBaQddWwUV8vWSySl9jR+1OyQz
 vp0ekZHKQuDGBeDrJgiy989HxmPyW3P5wlMcISZw8oEMoSBi1MAJvJCg+GfLXedHWuZRtYeBt4S
 BvZHW0qeN/2SX8xs+Lv71CtWoea1DL+Y2R7eZL/A8nXrmzPM7vsWsrTqKfKVZFbFJu9fdFL6LTM
 LAA==
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

In preparation for adding a 'tdx' option for early_printk which uses
direct TDVMCALLs for I/O, factor out the PORT_READ and PORT_WRITE
definitions from arch/x86/coco/tdx/tdx.c into
arch/x86/include/asm/shared/tdx.h, and namespace them with 'TDVMCALL_'.

The decompressor also used 0/1 literals in its tdx_io_{in,out} helpers -
switch those to use the new definitions.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/shared/tdx.h | 6 ++++++
 arch/x86/boot/compressed/tdx.c    | 4 ++--
 arch/x86/coco/tdx/tdx.c           | 8 ++------
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 56d741065783b..3d1656a44f75e 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -85,6 +85,12 @@
 #define TDVMCALL_STATUS_ALIGN_ERROR	0x8000000000000002ULL
 #define TDVMCALL_STATUS_SUBFUNC_UNSUPPORTED	0x8000000000000003ULL
 
+/*
+ * TDG.VP.VMCALL<Instruction.IO> direction (passed in R13)
+ */
+#define TDVMCALL_PORT_READ		0
+#define TDVMCALL_PORT_WRITE		1
+
 /*
  * Bitmasks of exposed registers (with VMM).
  */
diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 8451d6a1030c6..ed278bac3c939 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -22,7 +22,7 @@ static inline unsigned int tdx_io_in(int size, u16 port)
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
 		.r12 = size,
-		.r13 = 0,
+		.r13 = TDVMCALL_PORT_READ,
 		.r14 = port,
 	};
 
@@ -38,7 +38,7 @@ static inline void tdx_io_out(int size, u16 port, u32 value)
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
 		.r12 = size,
-		.r13 = 1,
+		.r13 = TDVMCALL_PORT_WRITE,
 		.r14 = port,
 		.r15 = value,
 	};
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 8bacbef62891f..9531490c9c246 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -24,10 +24,6 @@
 #define EPT_READ	0
 #define EPT_WRITE	1
 
-/* Port I/O direction */
-#define PORT_READ	0
-#define PORT_WRITE	1
-
 /* See Exit Qualification for I/O Instructions in VMX documentation */
 #define VE_IS_IO_IN(e)		((e) & BIT(3))
 #define VE_GET_IO_SIZE(e)	(((e) & GENMASK(2, 0)) + 1)
@@ -673,7 +669,7 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
 		.r12 = size,
-		.r13 = PORT_READ,
+		.r13 = TDVMCALL_PORT_READ,
 		.r14 = port,
 	};
 	bool success;
@@ -702,7 +698,7 @@ static bool handle_out(struct pt_regs *regs, int size, int port)
 	 * "TDG.VP.VMCALL<Instruction.IO>".
 	 */
 	return !_tdx_hypercall(hcall_func(EXIT_REASON_IO_INSTRUCTION), size,
-			       PORT_WRITE, port, regs->ax & mask);
+			       TDVMCALL_PORT_WRITE, port, regs->ax & mask);
 }
 
 /*

-- 
2.56.0

