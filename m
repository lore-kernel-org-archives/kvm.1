Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B32322B9F
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014329; cv=none; b=sKUyeG15/D123STGuBFG8bSYhWJW4zcWsAd6L5dIFlxUO6n3l47P0GQpDT3rQxqtZ469eTtXHrcuneBESI/UaNQnYMrfbpHYGJ5F/BMcROfMcD9HQTrX5UAztYMHr81QcFVFfaDNAoUApnNPuD/ZJw3C6Tsks9FFYHNqvGGuWxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014329; c=relaxed/simple;
	bh=NFh52IwhbAuSzafOUg9FspTSIETuppT70/9FXJHg/xI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nhy/HLK2wT/tf99tTp1TemEQAN84++2F0lcsAIkIf/ugXGdJNMibzlP4GVyOGTiH/gXjtJq/wZzWDGGWGUTgWUvqeHarkbbCXXblIN+15FiYqlQ8OBmT6aSuQXzDhYnzVwGUxebq8QkGaQNWQJ55MyoFZRGfXvqpnvqtPzRczOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=dgv/76cc; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="dgv/76cc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1781014327; x=1812550327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RmLG5xdfVKsoeFzFGudwb0+dfk57vQTiPg/nbQ0Btyc=;
  b=dgv/76cc9LGIzpuOoKaCJDE6W67eYYnaRqkYSZ9miHyW+QJBfNuehqh6
   oWwdatXtXyK4H+WbPjgdA8MS1aqA9CvnaSmNPZx2+dD6u2/MMO/yLavQ0
   KeIdX9YA5WNWmpjXxUw2HEKqi3NzWCWVVQsjpEbqyeKrtfZ2EKQK7/5EQ
   9tEb6wA947nLoXTr70laZFy6MVfOHoCt4oGUVfhQHidtqw6tH7ctTnZ+T
   pUc1WwmUx+5GywtWZ1QN+jjwgCCruM1+BibxC+bRDGjWsWI1dPpiQXiZl
   UrIp/3KRuGzGHhRhesKCWuDgoySbm7MB3OkQHgWZl1vwSeMQv4BaWfNnD
   Q==;
X-CSE-ConnectionGUID: I4A33L2DS5aiA6re2BHqBg==
X-CSE-MsgGUID: CZpu6Pw/QuOd/fPNvi3HeA==
X-IronPort-AV: E=Sophos;i="6.24,196,1774310400"; 
   d="scan'208";a="21187015"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:12:05 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:14361]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.234:2525] with esmtp (Farcaster)
 id b7046bd1-063f-4771-b750-b723909d470e; Tue, 9 Jun 2026 14:12:04 +0000 (UTC)
X-Farcaster-Flow-ID: b7046bd1-063f-4771-b750-b723909d470e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 9 Jun 2026 14:12:04 +0000
Received: from dev-dsk-gmazz-1b-865f0d50.eu-west-1.amazon.com (10.253.70.18)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 9 Jun 2026 14:12:03 +0000
From: Giacomo Mazzola <gmazz@amazon.de>
To: <kvm@vger.kernel.org>
CC: Giacomo Mazzola <gmazz@amazon.de>
Subject: [kvm-unit-tests PATCH 5/8] x86: replace per-AP bringup prints with a single summary line
Date: Tue, 9 Jun 2026 14:08:57 +0000
Message-ID: <20260609140901.95727-6-gmazz@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609140901.95727-1-gmazz@amazon.de>
References: <20260609140901.95727-1-gmazz@amazon.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Remove the per-AP "CPU %d online" printf from ap_online() and the
per-CPU "enabling apic" printf from enable_apic().  Replace them
with a single "smp: %d CPUs online" message printed once after all
APs have come up.

On systems with many CPUs, the serial lock contention from per-AP
prints delays bringup long enough to trigger platform watchdogs.
A single summary line provides the same information without O(ncpus)
serial transactions during bringup.

Signed-off-by: Giacomo Mazzola <gmazz@amazon.de>
---
 lib/x86/apic.c | 1 -
 lib/x86/smp.c  | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/x86/apic.c b/lib/x86/apic.c
index c538fb5f..483b26d3 100644
--- a/lib/x86/apic.c
+++ b/lib/x86/apic.c
@@ -237,7 +237,6 @@ void set_irq_line(unsigned line, int val)
 
 void enable_apic(void)
 {
-	printf("enabling apic\n");
 	xapic_write(APIC_SPIV, 0x1ff);
 }
 
diff --git a/lib/x86/smp.c b/lib/x86/smp.c
index 0cd44cdc..706f071a 100644
--- a/lib/x86/smp.c
+++ b/lib/x86/smp.c
@@ -97,7 +97,6 @@ void ap_online(void)
 {
 	sti();
 
-	printf("setup: CPU %" PRId32 " online\n", apic_id());
 	atomic_inc(&cpu_online_count);
 
 	/* Only the BSP runs the test's main(), APs are given work via IPIs. */
@@ -294,7 +293,8 @@ void bringup_aps(void)
 
 	_cpu_count = fwcfg_get_nb_cpus();
 
-	printf("smp: waiting for %d APs\n", _cpu_count - 1);
 	while (_cpu_count != atomic_read(&cpu_online_count))
 		cpu_relax();
+
+	printf("smp: %d CPUs online\n", _cpu_count);
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

