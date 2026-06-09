Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949D131AABF
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014220; cv=none; b=rF3tfV6RJVKTi0NtKW4kjP0OFeTzHRKQsJbJ53bBJFCGdGvleyH6plHzCGrl+7wm7UwZ/AcM4Qxp6ZEq773/kw4Oe8GTx19o9HZUDb5ueraOS2fR0RdqpeLFmSiMUcxZVeV5R2Uq1Q7GDi53oluIZY0NiqkT2qMcED3ba0aYuXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014220; c=relaxed/simple;
	bh=8GiqBJabFsubSGFnXACrOpLJnmq/X1r27frh86tlbgQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBoRRabTazzAo45IFeaLjY0+NpiCMDdj9rskQAla8MxrnHZ7mH2vc80Kga9VuZYPSU5JVHNaieusAHjMJClYcAKfjtkiLdL6PZ2++P9DokzbdONoN81Ze3LPdHBXzkvmE/68H7iQ+u3SQ+ZwDn6niGfQwYmcEC7akSVhv8Jyvmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=T1AggFfs; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="T1AggFfs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1781014219; x=1812550219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xI+1c74KW1pT3cdQ4hkF2EtHGtpJOwAy+fTQie0Rzrk=;
  b=T1AggFfsY/3AiOysD1AYoeMSoVOmuKvazinTxH5jqGRVNQM3besqdcF6
   RaihEhqp1y9YWOLGAcR2sgFBPbriFr9kH3szfVa2LK2HQ1uSzm6IsIXei
   4JTcq2csu6ytWBILoj8DnZ7eB5xrU0W6aj3yHiGHU0kP+lSAOAYCyi176
   0q+xi4MNPxvRuO4wIk43opx+5NRTzTPCBDXsyEgtfUVYkkqTwfsbv0zCX
   66HeufHt0bVXp09Wb0/Oa+a8qMgIczbXlfKWizh7rFVW7cVXH6CO+Z4Wa
   kX1YTaASjmFb3nN/aNej3+kjKQ5Cn9ACKGv6rXYDwANXmOShePHHX2vgM
   g==;
X-CSE-ConnectionGUID: sTOO+bbiRHmBUsRpeNMIYQ==
X-CSE-MsgGUID: c4Q52XSjSaqnWHVQ18SpMg==
X-IronPort-AV: E=Sophos;i="6.24,196,1774310400"; 
   d="scan'208";a="21388543"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:10:17 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:26243]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.27:2525] with esmtp (Farcaster)
 id fdd54357-7cf8-41ce-b61d-80fd6ceefa93; Tue, 9 Jun 2026 14:10:16 +0000 (UTC)
X-Farcaster-Flow-ID: fdd54357-7cf8-41ce-b61d-80fd6ceefa93
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 9 Jun 2026 14:10:16 +0000
Received: from dev-dsk-gmazz-1b-865f0d50.eu-west-1.amazon.com (10.253.70.18)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 9 Jun 2026 14:10:15 +0000
From: Giacomo Mazzola <gmazz@amazon.de>
To: <kvm@vger.kernel.org>
CC: Giacomo Mazzola <gmazz@amazon.de>
Subject: [kvm-unit-tests PATCH 1/8] x86: efi: use PER_CPU_SIZE for per-CPU stack allocation
Date: Tue, 9 Jun 2026 14:08:53 +0000
Message-ID: <20260609140901.95727-2-gmazz@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609140901.95727-1-gmazz@amazon.de>
References: <20260609140901.95727-1-gmazz@amazon.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The EFI startup code reserves PAGE_SIZE (4 KiB) per-CPU stacks, but
the non-EFI path (cstart64.S) uses PER_CPU_SIZE (12 KiB).  The smaller
EFI stack causes stack overflows.  Make the two paths consistent.

Signed-off-by: Giacomo Mazzola <gmazz@amazon.de>
---
 x86/efi/efistart64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/x86/efi/efistart64.S b/x86/efi/efistart64.S
index 6025dc2f..0f9f23d9 100644
--- a/x86/efi/efistart64.S
+++ b/x86/efi/efistart64.S
@@ -8,7 +8,7 @@
 /* Reserve stack in .data */
 .data
 .align PAGE_SIZE
-	. = . + PAGE_SIZE * MAX_TEST_CPUS
+	. = . + PER_CPU_SIZE * MAX_TEST_CPUS
 .globl stacktop
 stacktop:
 
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

