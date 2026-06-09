Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4868E2820A9
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014363; cv=none; b=rZw2frXeTCrsvQlABv85Y+Qqc5S5dbIYbBA96o+Ezyv+xcO6D4AaecXfbqRpoteMfS9kjlUUqHUamSbMjKbUU1zGF26m2mv/k2rLpapcnCPQ1jX3HQ3ugWZYl8NFa/8p6L0SU4wKsvZ6YKfWgO7AgTE6YwWUxqT7e1dInfGeIao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014363; c=relaxed/simple;
	bh=1wYM4RKY+H1AM9KotMN6AdjWfWVDw7n4fZfwXbtIpsM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1WJuFFlHhHfW14mRPXKqirI8AnFkp7vlrBcBg+53dwdtMuKZ5tmithZ2xgBcEDN8Apjc7FlAatwLtYZSLOJzSlq/pKz7rooq+AthKq8Vf3LFkRpYyjqD/RzdbCbLDEjB0+IiTVviV3cTKtdObOhfQPOs8xo82byc0CYufdHCns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=m+2fGP8M; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="m+2fGP8M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1781014362; x=1812550362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E83tRH+t9tx2AQYd+iPOeKafd+rraU3Xm94zeMyDYRI=;
  b=m+2fGP8MfksP1BFJ/4TDIVevca7+gzTQx/nTg2dCxuaG+cBfhZKIcA6J
   2/arRcDaFKzsvNaqLk2bdDKKWCGOwMfnyjUMhHA2+OgWVpAZHNPWPiyjb
   ORsYVUGL9roUefP34q5MQLVRB+2V5a8mJGBXQSGNeSoDdci++UphT4ML9
   kJQv8gS90w+ze41pEARSoKwH7hHSqgi8WXqUEV9PziM8+7H8PnjS84Nki
   v8lxgPVoTXOenjuwl17PaczHT1YXFvt59EDJBxYLLBIXYjNZuY1SCS5eX
   yRjw5okQHyEiymN0HoOwOAOrESk1fw0cwqC2haV21XFDwTyQDMD03qA19
   Q==;
X-CSE-ConnectionGUID: 2Y79L9zrR5aOMhi2OBfDZg==
X-CSE-MsgGUID: FzdZJ5SuRiCGD1hGvLCWHw==
X-IronPort-AV: E=Sophos;i="6.24,196,1774310400"; 
   d="scan'208";a="21389180"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:12:39 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:18651]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.226:2525] with esmtp (Farcaster)
 id 1f144e75-09bf-43bf-961d-23262118e5f3; Tue, 9 Jun 2026 14:12:39 +0000 (UTC)
X-Farcaster-Flow-ID: 1f144e75-09bf-43bf-961d-23262118e5f3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 9 Jun 2026 14:12:39 +0000
Received: from dev-dsk-gmazz-1b-865f0d50.eu-west-1.amazon.com (10.253.70.18)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 9 Jun 2026 14:12:38 +0000
From: Giacomo Mazzola <gmazz@amazon.de>
To: <kvm@vger.kernel.org>
CC: Giacomo Mazzola <gmazz@amazon.de>
Subject: [kvm-unit-tests PATCH 6/8] x86: add timeout-based SMP bringup when fw_cfg is unavailable
Date: Tue, 9 Jun 2026 14:08:58 +0000
Message-ID: <20260609140901.95727-7-gmazz@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609140901.95727-1-gmazz@amazon.de>
References: <20260609140901.95727-1-gmazz@amazon.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When fw_cfg is unavailable, fwcfg_get_nb_cpus()
returns 0 and the existing bringup loop spins forever waiting for
cpu_online_count to match.  Add a timeout-based fallback that
watches cpu_online_count and declares bringup complete once no new
AP has checked in for AP_QUIESCE_TICKS (~4 billion TSC ticks).

Assuming a TSC frequency of at least 1 GHz, this gives between ~1 s
(at 4 GHz) and ~4 s (at 1 GHz) of quiescence after the last AP
before declaring bringup complete.

Signed-off-by: Giacomo Mazzola <gmazz@amazon.de>
---
 lib/x86/smp.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/lib/x86/smp.c b/lib/x86/smp.c
index 706f071a..2fcc6c65 100644
--- a/lib/x86/smp.c
+++ b/lib/x86/smp.c
@@ -14,6 +14,13 @@
 
 #define IPI_VECTOR 0x20
 
+/*
+ * Quiescence timeout for AP bringup when the CPU count is not known
+ * (bare-metal EFI without fw_cfg).  Assumes a TSC frequency of at
+ * least 1 GHz; at 4 GHz this gives ~1 s, at 1 GHz ~4 s.
+ */
+#define AP_QUIESCE_TICKS (4ull * 1000 * 1000 * 1000)
+
 typedef void (*ipi_function_type)(void *data);
 
 static struct spinlock ipi_lock;
@@ -293,8 +300,24 @@ void bringup_aps(void)
 
 	_cpu_count = fwcfg_get_nb_cpus();
 
-	while (_cpu_count != atomic_read(&cpu_online_count))
-		cpu_relax();
+	if (_cpu_count) {
+		while (_cpu_count != atomic_read(&cpu_online_count))
+			cpu_relax();
+	} else {
+		int prev = atomic_read(&cpu_online_count);
+		u64 last_change = rdtsc();
+
+		while (rdtsc() - last_change < AP_QUIESCE_TICKS) {
+			int cur = atomic_read(&cpu_online_count);
+
+			if (cur != prev) {
+				prev = cur;
+				last_change = rdtsc();
+			}
+			cpu_relax();
+		}
+		_cpu_count = prev;
+	}
 
 	printf("smp: %d CPUs online\n", _cpu_count);
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

