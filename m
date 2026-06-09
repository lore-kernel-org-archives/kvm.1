Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3824932470A
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014307; cv=none; b=W99m/CItOLYJa1J5DELjIhv7GmH1AaGETyvU3VFbt0m0NMCL7ZGDUTd7+ZI6c7DH91Byr3rFUn/Qem+9KRKHjaEL4qVXhvio7rjEnqvldiOKsSvSfU0Hsqo/eXUkxPANmN/CBxmkKRRMFeu83ZwgxM0VnQjnYCuLbldwmRhm3Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014307; c=relaxed/simple;
	bh=LscaZn2U8TMSyMDRgYZysXua8ulp0SV36/rcQZvzbXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWtnAuDpKWpnaQxu1pddHseN4dl/8sB7+t2ES4+5Ds5+5iJZwWHqDCdn+MsMqHRs1wJ8ly7MD1i8k19McBlH8XHEFafeh4aF4a9Soo6MxIdkGXlLANufA3SwRZNmesJETMIjtOKNIvly/i3493Ms1gknxMB4AvY3E300OEYkOMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=NymXkOew; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="NymXkOew"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1781014306; x=1812550306;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MynxXps3773oKzcaN2ZBAtNL+xpiWJyjkgTpu890bOw=;
  b=NymXkOew/O8mE3hFs60kBPNwIQE8tGWCjshZhx366EHek7RznuOkbYsR
   pgNcJSAWgOfZF7yrN3awGurqhU/HYuBneLJD55kWAzu4rB3Xbp86vPQIo
   +HmTxVyY6t4Fd/Nb/V2Vein9xxeizO9Vv2v5rB7PRi+pvjSDFS2PVvXJT
   kpLA/THiYOxEjzoUMtitb7xNcQb7E2AGuEmo0ABG9DSos/uiTs5BbGNEW
   uNDWwsiep8Ppcr+i4XtsRkFUlWvR/DcAO3+5vG8XZrwE7yFSv7/1dOQhF
   HBDaBtHdeIkGBJXLnD1r+1CVmmzFjyjLoUnow9Bt+AIXaWlvq8V2a5YdH
   w==;
X-CSE-ConnectionGUID: WeELPITzRlmwHauRwXBPxQ==
X-CSE-MsgGUID: Gzu+E+YRTrCse51WXNLxhQ==
X-IronPort-AV: E=Sophos;i="6.24,196,1774310400"; 
   d="scan'208";a="21275480"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:11:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:4505]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.151:2525] with esmtp (Farcaster)
 id 6a86309f-157e-4004-b13e-d1f91ff62d9c; Tue, 9 Jun 2026 14:11:42 +0000 (UTC)
X-Farcaster-Flow-ID: 6a86309f-157e-4004-b13e-d1f91ff62d9c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 9 Jun 2026 14:11:42 +0000
Received: from dev-dsk-gmazz-1b-865f0d50.eu-west-1.amazon.com (10.253.70.18)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 9 Jun 2026 14:11:41 +0000
From: Giacomo Mazzola <gmazz@amazon.de>
To: <kvm@vger.kernel.org>
CC: Giacomo Mazzola <gmazz@amazon.de>
Subject: [kvm-unit-tests PATCH 4/8] x86: fix ISR thunk to use absolute indirect jump
Date: Tue, 9 Jun 2026 14:08:56 +0000
Message-ID: <20260609140901.95727-5-gmazz@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609140901.95727-1-gmazz@amazon.de>
References: <20260609140901.95727-1-gmazz@amazon.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Replace the relative jmp (e9 rel32) with an absolute indirect
jmp *0(%rip) (ff 25 00000000 + addr64).  The rel32 displacement
is sign-extended to 64 bits, so when the displacement between
the thunk and isr_entry_point exceeds 2 GiB the sign extension
corrupts the target address.

Signed-off-by: Giacomo Mazzola <gmazz@amazon.de>
---
 lib/x86/isr.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/x86/isr.c b/lib/x86/isr.c
index 53c0c2b3..4f474931 100644
--- a/lib/x86/isr.c
+++ b/lib/x86/isr.c
@@ -79,9 +79,11 @@ void handle_irq(unsigned vec, void (*func)(isr_regs_t *regs))
     /* mov $func_high, %(rsp+4) */
     *thunk++ = 0xc7; *thunk++ = 0x44; *thunk++ = 0x24; *thunk++ = 0x04;
     *(u32 *)thunk = (ulong)func >> 32; thunk += 4;
-    /* jmp isr_entry_point */
-    *thunk ++ = 0xe9;
-    *(u32 *)thunk = (ulong)isr_entry_point - (ulong)(thunk + 4);
+    /* jmp *0(%rip): absolute indirect jump to isr_entry_point */
+    *thunk++ = 0xff; *thunk++ = 0x25;
+    /* disp32 = 0: address follows */
+    *(u32 *)thunk = 0; thunk += 4;
+    *(u64 *)thunk = (ulong)isr_entry_point;
 #else
     /* push $func */
     *thunk++ = 0x68;
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

