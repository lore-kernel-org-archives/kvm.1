Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B0944212E;
	Mon,  5 Oct 2026 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791240628; cv=none; b=oKSkSF7uGvRy2SQVAI73zgu5GyBG84NiMKnz2MvuCcfPBFuJmlWmFmXmOVu5j5uI9hqfhJY+MemmiwK2cHMdxN+5D1cI0qb6wXMSQd/aX3swm8NJIzZqdZNQg2VopvKDorthrlL4AuFUFiQa0zLtp7M03mrcVL+6hlGJZUdJKGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791240628; c=relaxed/simple;
	bh=yYFOxPWxF+ebjxNifaNu6ojjenfBN450qHPMmQOo3ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Em+n0YxbbuthZxPbUo1keYOGvLxPeniUOnR6vWalM51Dpv/793Y8FNKd3nSWVKRthj8TBIfD+R5lKTG+uBTGJPibWWo2dlvkfRd9twbgidrLi8e18fwoBvJmWLcnbX7x7i+HJDcRn5aQ0Tc67XGhnL5/UJEUHgQoqqmilieizkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBvBQqQv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBvBQqQv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791240625; x=1822776625;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=yYFOxPWxF+ebjxNifaNu6ojjenfBN450qHPMmQOo3ao=;
  b=PBvBQqQvX/LHa1w5QTWCxkm+B4fQQP3G1oNgconmynbqmvV7EyGpJBqk
   Lc7B12h5OS6k1mSn4k8Jnb08toIqKnHhic3CS3YDWYj7FJMxZ1BZWzcaT
   hfBVwooXyuRaiAT/VFHA2BBhRoFEGke2lVmMFaMLMelpyXtHf2s+defwz
   QLp5xduhEaCgOxAz0bTl/NTHRDmBSeIN/HIC1x2A7i4JV6Xweh2lyzM9z
   QTicWCDUIB6Xu+UQ/SLYmFwvlZpsSkSyzBjjAtFiTHVWhIkQ8mWYTPxTg
   aBUyhcOR5DALp+Hz6hXnpyigNbIXXr2Q4KXyDk/B+PWQ47zRg+ch7R9kh
   Q==;
X-CSE-ConnectionGUID: Z7E5hWGsQWKs3yh7kleyaw==
X-CSE-MsgGUID: j7XKud8bSg+nTJaN2PfcZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="94798740"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="94798740"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 15:50:23 -0700
X-CSE-ConnectionGUID: PItsRXD5RMy1pnQBinp2KA==
X-CSE-MsgGUID: Tp6VzmqxT6iKfWeomvPiKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="277063567"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.125.108.147])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 15:50:23 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Mon, 05 Oct 2026 16:50:06 -0600
Subject: [PATCH v4 1/2] x86/tdx: Move port I/O definitions to a shared
 header
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-b4-tdx_earlyprintk_tdcalls-v4-1-3f7c56dd568a@intel.com>
References: <20261005-b4-tdx_earlyprintk_tdcalls-v4-0-3f7c56dd568a@intel.com>
In-Reply-To: <20261005-b4-tdx_earlyprintk_tdcalls-v4-0-3f7c56dd568a@intel.com>
To: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=3102;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=yYFOxPWxF+ebjxNifaNu6ojjenfBN450qHPMmQOo3ao=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDFlHNFeEKjh1iP01N1zvY7NhxsVfDQk75szh5Orf+PcJx
 /mtPBGVHaUsDGJcDLJiiix/93xkPCa3PZ8nMMERZg4rE8gQBi5OAZjInd8M/30XXJr97AdX8gzr
 hTPqmSb+jW/dcv7W/555juLLpzhu453I8D+wwTGtbE3XyVc/lzP/31GdWSKVt1kx+szrvZNEXVw
 julgA
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
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/shared/tdx.h | 6 ++++++
 arch/x86/boot/compressed/tdx.c    | 4 ++--
 arch/x86/coco/tdx/tdx.c           | 8 ++------
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index f20e91d7ac35..ecaf965f059b 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -84,6 +84,12 @@
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
index 8451d6a1030c..ed278bac3c93 100644
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
index f904a636d449..7d1a93ee2534 100644
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
@@ -691,7 +687,7 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
 		.r12 = size,
-		.r13 = PORT_READ,
+		.r13 = TDVMCALL_PORT_READ,
 		.r14 = port,
 	};
 	bool success;
@@ -720,7 +716,7 @@ static bool handle_out(struct pt_regs *regs, int size, int port)
 	 * "TDG.VP.VMCALL<Instruction.IO>".
 	 */
 	return !_tdx_hypercall(hcall_func(EXIT_REASON_IO_INSTRUCTION), size,
-			       PORT_WRITE, port, regs->ax & mask);
+			       TDVMCALL_PORT_WRITE, port, regs->ax & mask);
 }
 
 /*

-- 
2.55.0

