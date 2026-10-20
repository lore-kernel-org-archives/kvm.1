Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.13.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509970;
	b=pA1uyK9KVeU1dFQgh0rd7AXusVDH9KlRN7QnoRT5ui3yekBzy18i9ik2BujW7/kQETwU
	 muXCcFoDAcRGl34G4ksS9c1/ySWf9hm8dK5ezGoB0YiK6IDTpbORICuxmhh2YHvv/oslJ
	 Qn5vFx9rMDjbbmVTIX5q7Q0eW2UyO3fidRcAk3Lbequ0HfAOJ9Mqdj4PQkoSPfkobJeXu
	 lqwzkaJWH8HK+qyKy5C0APGWzqqP9xYwThzOJtiPmPV25gZlx6WLtW9zONraXs3xWuUpC
	 Q9LhnPsN3WupbHbJFZ3JsnA8d8UU2K/0qwze+YdYJzi7Lchstgsh/hZ9CEO4h3cNFhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509970;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=rg0Xg8lPd8wsITGV1AMIawI6HjyuqspzoN1/mwUhiQM=;
	b=XbvA0cXPFqb+o0C+x4XE4dltyVDHfTgyPMkmG9oo0JbAzFIhW8Ib6fT8KkYniwDl3RCK
	 ceGplV9wqQlInSSkYObS01EKFt0iydr0ByTsuNG/XwIM0nisaIQE54AMMVnQ2hk4vlXTO
	 vhUVGNLzHh1kITE6qXOCa6SiDWgFHlx+1M+0vw+yVJYYyN8xyvRk6GL0Ra7/bXmqk+uOo
	 AhiKsnCd0l2LKtdFiL8wk886tf4+OUqfhX9ZfwVg9sM+QUj02NtyFc7mb1MV5lx1H/Cv9
	 mRIBfDNnkbjzaVjbdYWOzLaReYpB7gJy5aJksB73VkjpZXtX8U03kzBHK1EiM2Soi9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=U6j0ueJF;
	arc=none smtp.remote-ip=52.13.214.179
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C72606A330
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 15:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21C72606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=U6j0ueJF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1792509970; x=1824045970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rg0Xg8lPd8wsITGV1AMIawI6HjyuqspzoN1/mwUhiQM=;
  b=U6j0ueJFvbrVug7UANdHPJNpKGiMkJ5j1uWNlRVItuY7xKYl/Tk6Q2bu
   iVImy1Pw4lnAA2SeLQRIkvhsMGvCnPbzcN54sUPd+iMpmnYbsG8MGSgzf
   5FmjBWxQ0w0hYDnDgvGJ4GWQs0YDb+2ZR5stblmvnWcOXKzDj7c0JFVwx
   sz85CFE+EKyOgLCbxV4aF4pYB2j9qZTwYkT8+JifkA+iywKS6QTBR5xdG
   SJnaoh9DiL3q6GZCto8VoWDD+GARiqWrnaXcfyM64QOduul21ofaLXB+k
   GQ+ViucJLv+c29ptxHkjUIYqkHohD0qjiftm3wxmfE7HhS9uFYl0EljDV
   A==;
X-CSE-ConnectionGUID: /KyfEMH/T5+NKonQ4F47xQ==
X-CSE-MsgGUID: jzmgB9KwSZedTXWmb8GvPA==
X-IronPort-AV: E=Sophos;i="6.27,168,1787011200"; 
   d="scan'208";a="31732563"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 15:26:07 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:29494]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.104:2525] with esmtp (Farcaster)
 id 33c557ed-41a1-42dc-983d-36c8a33fd483; Tue, 20 Oct 2026 15:26:07 +0000 (UTC)
X-Farcaster-Flow-ID: 33c557ed-41a1-42dc-983d-36c8a33fd483
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 20 Oct 2026 15:26:06 +0000
Received: from dev-dsk-gmazz-1b-865f0d50.eu-west-1.amazon.com (10.253.70.18)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 20 Oct 2026 15:26:05 +0000
From: Giacomo Mazzola <gmazz@amazon.de>
To: <kvm@vger.kernel.org>
CC: Giacomo Mazzola <gmazz@amazon.de>
Subject: [kvm-unit-tests PATCH v2 1/8] x86: efi: use PER_CPU_SIZE for per-CPU stack allocation
Date: Tue, 20 Oct 2026 15:25:18 +0000
Message-ID: <20261020152525.57694-2-gmazz@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020152525.57694-1-gmazz@amazon.de>
References: <20261020152525.57694-1-gmazz@amazon.de>
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

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

