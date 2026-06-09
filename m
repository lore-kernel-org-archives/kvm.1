Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C082175A75
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014274; cv=none; b=e8gP1bz0g+/04gx7ccamamUX2x4GcrZ6qjhrB/nsbttB5oPDnD0JEgVoEmChisah1q+wqr9S3CHhlMrK7O27KW88ebumOqZIueffQoaRzaXUiIJcezyRRCLShNWm6lHYeVJaJP4z8qkfKXgq924XcVfFnNcXM4EFBgRQNxQoCag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014274; c=relaxed/simple;
	bh=9vjeZ36s4bvrOpl/Yx5n1p8sJ6/clYeJjoXeakOXyHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kH/bpDYAyQUmDgVCWEpFhsK/YuClJYCI9OpfKIxO2MjWatR4O8uEPunmgYlMOVQavFCA227jTJwzFVDISPeU4ijhnWzzQX8n7sJPVpz1ZhvE2G0d7/gKbIL3yKdCPvZyjhVGENqXnvPILJSKAt7QeDuFu2qqRX6MQheNzNzDE5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=U0E/i/es; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="U0E/i/es"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1781014273; x=1812550273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hc5edQlAGvzg6VKUmRlwbd3uU7sX/84deLWl3lzd1JE=;
  b=U0E/i/esSKsk4udlWmV4BC4NBxpCEq+OSDC9k5PdBNyJLDuWtsVY4Db3
   M8xN4J1BEC7cgRf3v4NSBy7giUqsTdyId9dYRzq9do/Q0K71QrQfeUWvO
   sed3dqrX1+DkQhA5SepjlWOQf756xF1YT9MZ9XLfgB6Oy/5y5Uqxr1OF/
   Jbouetg+ca7NxPM1zQFfxD6XDws2oOK9kQRX6YYSiiqE1N8LauSPU+XGK
   pNVJEtt/gRfNnY8hfYWbgrAw8jEtKiaOHhUwPuTI6H1N4T3nJ4ghKHSI6
   NLUSB4P0jvIaJS6y/yRXnWbCE6T9Ixz54IBn2OG64uL4YQOBb9hcmrQ7l
   g==;
X-CSE-ConnectionGUID: g1/CR1O2QkibrlQZkRja+w==
X-CSE-MsgGUID: PKJFJKUgQq6zhZK0yfgYHw==
X-IronPort-AV: E=Sophos;i="6.24,196,1774310400"; 
   d="scan'208";a="21415419"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:11:10 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:5993]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.27:2525] with esmtp (Farcaster)
 id 37fe4b48-6bc7-4efd-bbcb-f1b5a2dceb61; Tue, 9 Jun 2026 14:11:09 +0000 (UTC)
X-Farcaster-Flow-ID: 37fe4b48-6bc7-4efd-bbcb-f1b5a2dceb61
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 9 Jun 2026 14:11:09 +0000
Received: from dev-dsk-gmazz-1b-865f0d50.eu-west-1.amazon.com (10.253.70.18)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 9 Jun 2026 14:11:09 +0000
From: Giacomo Mazzola <gmazz@amazon.de>
To: <kvm@vger.kernel.org>
CC: Giacomo Mazzola <gmazz@amazon.de>
Subject: [kvm-unit-tests PATCH 3/8] x86: skip PMU init when no PMU is advertised
Date: Tue, 9 Jun 2026 14:08:55 +0000
Message-ID: <20260609140901.95727-4-gmazz@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609140901.95727-1-gmazz@amazon.de>
References: <20260609140901.95727-1-gmazz@amazon.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

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




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

