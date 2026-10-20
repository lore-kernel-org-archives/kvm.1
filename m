Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.1.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510012;
	b=nbJ0CateMZytPSo2QpTAEW7SA11Q7vhAC64olMDou5zRi7VVK1n6mW0PxJzcWwCQcZV6
	 c/nXQliKaitF/sspZklhnvuKfJ0x48KHOpV56/qQ2qj2wkhYTCsWWXhILrVcwJmBRzVgE
	 RKmC7FA9gWJ36wdFg/g0jmoQLdwW0xQsAjXlCIfRD6QGrnb3QcIOZzPAgH+oP1Mb3Fmeq
	 6RMnSvVNvP/34JEfA+85liVQ/iZZ4qyFWJ4XZVjxtuiOyWzwi0HDncuiTt34iBGs25tgf
	 VP+7siZY1wEc2FEXWygP3jGH1Yp6qYA+SRoWojvI/YYBL1qbn3z8SsxFqz3iTUw1o2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510012;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=LXTn9csIowyCww1P9+buxYuO9TmEQqpYbct46ye3dyk=;
	b=xG6Vb2HvEno+OPPtDk7iLSRhCNuheMduMZhh0UgO3vYPD60pwFM68tkBoO+vbAw+Z15+
	 b57zGwmgXFL3vu+52HlupfDE/6th2o21CMvYBlmDwUwudFYlGxv+u60rGsXd2y1/crM4m
	 zgYXsHPzDZda181a2z1joUBPgzJHrRfiRIgg/vN02PtqURZZMJfdgD4GATt8RsjVZ2LKY
	 zTyiXvtYOcWZMbwQbPfvtQIA+Ecl5AFhPWms2JCm/NCEwqi3nQo/WxqHWFZ8QkTUPhq2s
	 7IWrYDyJcwRWaB4pOse/ValEeIBSLASdNv9J0SO1DH3F8LuQ4ifiyppygqcHpj8xj4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b="l6xm/YDq";
	arc=none smtp.remote-ip=44.246.1.125
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C559606A31B
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 15:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C559606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=l6xm/YDq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1792510012; x=1824046012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LXTn9csIowyCww1P9+buxYuO9TmEQqpYbct46ye3dyk=;
  b=l6xm/YDqo3ZfX3jVRgheAGMibjF3jXCVk+Zi4SfKkGubWDiTSyN5cd7u
   akzQmZTt1+6GQsqFPqId2DbZcsNhGuJ4Zv+i1icG1P8iUGXKMHTkG4NMv
   fwVxrLfU2/oDapKmalvTCuyosgyA73YeaedOSD5acQkZkTBT1xLfNiMjy
   8GRCY4jMjbtx3oLgHG9MJjZIrfOGTv9auWPqLV1x8qPHo3ucu8tzB5h19
   sfzfSr3hIfTcfeSt+DHJYl1Mo1SyWJWwnUc4uL6bqCCORy78CHa3oqRou
   QoKUJGQkPv/Gl31/2TrOk+GJIvfyJpMHyj7w+lFhSgt4NkJ75BMHZVyoL
   w==;
X-CSE-ConnectionGUID: BlwNny86Qb2hcEUeSxT68A==
X-CSE-MsgGUID: +0FCrBc3ScSo7Fnu/79O9w==
X-IronPort-AV: E=Sophos;i="6.27,168,1787011200"; 
   d="scan'208";a="31765087"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 15:26:49 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:15741]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.190:2525] with esmtp (Farcaster)
 id 4cdc7504-5b9a-476c-b438-5fc9e57bace1; Tue, 20 Oct 2026 15:26:49 +0000 (UTC)
X-Farcaster-Flow-ID: 4cdc7504-5b9a-476c-b438-5fc9e57bace1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 20 Oct 2026 15:26:48 +0000
Received: from dev-dsk-gmazz-1b-865f0d50.eu-west-1.amazon.com (10.253.70.18)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 20 Oct 2026 15:26:48 +0000
From: Giacomo Mazzola <gmazz@amazon.de>
To: <kvm@vger.kernel.org>
CC: Giacomo Mazzola <gmazz@amazon.de>
Subject: [kvm-unit-tests PATCH v2 3/8] x86: skip PMU init when no PMU is advertised
Date: Tue, 20 Oct 2026 15:25:20 +0000
Message-ID: <20261020152525.57694-4-gmazz@amazon.de>
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
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Guard pmu_init() behind CPUID checks: Intel's architectural PMU
version (CPUID 0xA EAX[7:0]) and AMD's PERFCTR_CORE feature bit.
Without a PMU, accessing performance counter MSRs triggers #GP.

Signed-off-by: Giacomo Mazzola <gmazz@amazon.de>
---
 lib/x86/setup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/x86/setup.c b/lib/x86/setup.c
index 09241b33..8c8b6e63 100644
--- a/lib/x86/setup.c
+++ b/lib/x86/setup.c
@@ -416,5 +416,7 @@ void bsp_rest_init(void)
 	bringup_aps();
 	enable_x2apic();
 	smp_init();
-	pmu_init();
+	if (this_cpu_property(X86_PROPERTY_PMU_VERSION) ||
+	    this_cpu_has(X86_FEATURE_PERFCTR_CORE))
+		pmu_init();
 }
-- 
2.47.3

