Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.34.181.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510073;
	b=UOs0HRoEgtbKQWuNI8HPenCMxArCqabqFv34bob1A6WKy79ler5Jdr923h81hqnx2a//
	 4JvCVfGdPdASOX6YHNtfDxelgvmAPox7e0cCAa/8g91Bijzmcuu2TajgGp7eT3Ucp1kfp
	 nNZjlc7LPCGd4EE4cF8qY16+lSncf7AxgkoRHghRLD4PRWf0HTdz9OHbAJShJjFrURBXW
	 LQhENyJ08ekPuVu4uJZyetF3rtsAI4zzA+yyNBPWiz8VXjzVkdqQiKjC+/SyLhFWWYMbq
	 lfQ0bf5VWKuYHiiY2624QncJNeJ1IwFqU8W2ILapS5F6FEbtSMC4Ih2uPhEtHatoOMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510073;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=7k9NOmMMfZXvfteGnF7jjF0ekHZPNYfauGqI9ty4uhc=;
	b=ICZNZwwYSEZW6oqXIXzWrORlKQIrtBFpGBhixuVnViKjMyGJlE5Jv8+1ZLxAIo3THrCp
	 lN0pJ78wZ4gUtf7dVVMSi1NotHObH7yS9lbBHreCvliKCC3wcb9OwnWXyw/GoYxiVluaQ
	 LTnzqq6TYJEPAf91uSwsAoj+KBosuflRijIvRHF09gzNvBlDnDV1bxhmET1cXVu8Cmcjq
	 zs6MeMZUgeHrh/oeHfqqdnPFGPOIztM7fL4ATwjDggJFjootytl9DDla7qacZHG2srkqz
	 rT3Mun6XtJl8j32PgTNJO912Myi3SU7lqNM2fqSwlDI8sIko5Hp2V2CPoyyNZq7TGVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=Fo86sHJQ;
	arc=none smtp.remote-ip=52.34.181.151
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4278606A319
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 15:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4278606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=Fo86sHJQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1792510072; x=1824046072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7k9NOmMMfZXvfteGnF7jjF0ekHZPNYfauGqI9ty4uhc=;
  b=Fo86sHJQH1i4WYYy+J4FezL7Gx/c/r29nz1foKfXJ9UzONMMEMWxTUrW
   Rr4iCtG373u9LvuNzbBPRb/5qYx2z2ZWzJnqxwT1Rh4Oz+C6tVaoJ8/XD
   7tYDcUzuFovMTIpK63Fva62YUNNHmgH0hjFwNJMnCYGx8O2rFLuFm/3op
   w8WnNEQYFf1xVolZ+0JosdiXmpb1OYV2dhBJqT/UOtf4D5kRjPEP3I/SS
   5oriMWfLqr2sisoMVP1nwK66O1Li4DrUrLbkrNCprli4+nxJuHtpt0KXE
   NzImtGGCBe6MO712mQOjnRlEO11W7Ih1zEyYM9FiJhtQ6qIE7JiaoI8Ko
   A==;
X-CSE-ConnectionGUID: cmj60SYARomcbjaamSJ8fw==
X-CSE-MsgGUID: D97Qs6NZS/iB7WB/DHZ0kQ==
X-IronPort-AV: E=Sophos;i="6.27,168,1787011200"; 
   d="scan'208";a="31745993"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 15:27:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:17518]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.190:2525] with esmtp (Farcaster)
 id 4260941c-6a76-4d18-934d-852ed6e88a57; Tue, 20 Oct 2026 15:27:41 +0000 (UTC)
X-Farcaster-Flow-ID: 4260941c-6a76-4d18-934d-852ed6e88a57
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 20 Oct 2026 15:27:41 +0000
Received: from dev-dsk-gmazz-1b-865f0d50.eu-west-1.amazon.com (10.253.70.18)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 20 Oct 2026 15:27:40 +0000
From: Giacomo Mazzola <gmazz@amazon.de>
To: <kvm@vger.kernel.org>
CC: Giacomo Mazzola <gmazz@amazon.de>
Subject: [kvm-unit-tests PATCH v2 6/8] x86: add timeout-based SMP bringup when fw_cfg is unavailable
Date: Tue, 20 Oct 2026 15:25:23 +0000
Message-ID: <20261020152525.57694-7-gmazz@amazon.de>
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
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

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

