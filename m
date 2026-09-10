Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D665C3546C2;
	Thu, 10 Sep 2026 22:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789079668; cv=none; b=s3nO4L9hMeOs/HjEuX9YuCduoIIXTQ15DSBPGgPvEVAftSS1RuJVZUw9T1H2b4WRrUsSRomTQ83rFiZfFx4bm8o0ZBTp4n5F5hxIP9LubTA3kBKYH/3VeK6yKu4ECkMsZCe8lUyVRrZqXMVlfp12t82355DBPVuGTIoqFcWRCQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789079668; c=relaxed/simple;
	bh=AaborA1YqhltsyazAzMXTF21qWXPXv//Ui1djDJE8Fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=puPAUOG1+z3AdVPAyNtSDRZJPIWmWbHgtdFboCf3mSYMfxu//GDI253o5SH821aESgmMk+Uwg1e0DVpr6vKe1iG9BKRkmSZopUkASNjvS6htNc4hiDC5eU/xLrNbnpyAOi15H84/SWtlKRr8Gll+UPqr1LmK1zX7C5w1Nhycr3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U+I7yEMo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+I7yEMo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789079667; x=1820615667;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=AaborA1YqhltsyazAzMXTF21qWXPXv//Ui1djDJE8Fs=;
  b=U+I7yEMo015r0WtQpaS0ZvvxWjYDXcP3dkx0xVu+U7p9O7EVvJCduFFj
   SBFHCFaNWRIuGutFm3/eIkYOEndD6gDk3igGabApptb+LALOBpr4YQp6Z
   djbHVt/dodrZQ9hM/b+kAtBurC5hLxk2UqGujrtYNd5lo8zqCGvQ33tsH
   chpR4ICPuVoIcY6FfkNhxtx1u5pjYYDgmC/fnJ7SIUEGEUHg6CH9fJS5l
   rRy4iZBc9glOTsXX1IEXJp5p0gTIrHX9JameJm+duKohgIpE+6iaMlXFw
   eB5yM0tHeVsg0tnh8if9aJfWi0a8vGnMeI1+Bfgr9LRqJIuyhRTk05rkV
   w==;
X-CSE-ConnectionGUID: ea5X0oBTTDGnQ2sTa6FHAw==
X-CSE-MsgGUID: WuEcCHSkRGO/HjbApo664g==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="93407824"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="93407824"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 15:34:25 -0700
X-CSE-ConnectionGUID: m46k88v2T020yUiLz3uBLg==
X-CSE-MsgGUID: Wt5imkNhRoW5I82HZ+WggQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="301647428"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.125.111.227])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 15:34:25 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Thu, 10 Sep 2026 16:34:08 -0600
Subject: [PATCH 1/2] x86/tdx: Move port I/O definitions to a shared header
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-b4-tdx_earlyprintk_tdcalls-v1-1-4b2b1bf9001b@intel.com>
References: <20260910-b4-tdx_earlyprintk_tdcalls-v1-0-4b2b1bf9001b@intel.com>
In-Reply-To: <20260910-b4-tdx_earlyprintk_tdcalls-v1-0-4b2b1bf9001b@intel.com>
To: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.16-dev-62088
X-Developer-Signature: v=1; a=openpgp-sha256; l=3016;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=AaborA1YqhltsyazAzMXTF21qWXPXv//Ui1djDJE8Fs=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDFmLDfL9t0zLSRDlZVBOLAgXmlQlUCTLPk/huN6TqIuTv
 XTWC/p2lLIwiHExyIopsvzd85HxmNz2fJ7ABEeYOaxMIEMYuDgFYCKRNowMHx2+fD18NHV7gsSH
 yN3L/boe8R8TeD05qH/eXpPSda6yaxj++0y1Y1Ffofv9UMJSd43zBd+8bKcFfNy5XDJ9xq89OtG
 HWQE=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

In preparation for switching early_printk to use direct TDVMCALLs for
I/O, factor out the PORT_READ and PORT_WRITE definitions from
arch/x86/coco/tdx/tdx.c into arch/x86/include/asm/shared/tdx.h, and
namespace them with 'TDVMCALL_'.

The decompressor also used 0/1 literals in its tdx_io_{in,out} helpers -
switch those to use the new definitions.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/shared/tdx.h | 4 ++++
 arch/x86/boot/compressed/tdx.c    | 4 ++--
 arch/x86/coco/tdx/tdx.c           | 8 ++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index f20e91d7ac35..25429d515cc5 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -84,6 +84,10 @@
 #define TDVMCALL_STATUS_ALIGN_ERROR	0x8000000000000002ULL
 #define TDVMCALL_STATUS_SUBFUNC_UNSUPPORTED	0x8000000000000003ULL
 
+/* TDG.VP.VMCALL<Instruction.IO> direction, passed in R13 */
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

