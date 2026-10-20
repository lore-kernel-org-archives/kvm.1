Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.77.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510047;
	b=noxD/qxFXWihuey7cBgVhuqQk3/Q73U3YpDRGaizotXmQtuo+8QJGLepZe2YGL9N0Pfm
	 9eBLoTSTyEP5gwa8iWSC8UWAmQdfycTLDuiViSdWJN3FjaQGSer0vDr4m4CMEIUOpZlGM
	 hi/SSTNa8DdF/iP52zPIHHl3rb2PApaJdMjcEMH3KxnddfWRCQ0g24kk6oLt0rc7BJdYl
	 ufBTwuS19tffb/Z5emqQdg9k5lf2mgAispteOMMFEytw1rX90Un+sjmUH1RV5vL6uIBDD
	 lzgQ1Cx3wvxTr4ceixZvQDgCbX0lOSYtQel1OrNAWHahr3J1D2tWnhakjNx10IjoPLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510047;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=smYt2A/D6bgUwhq9IK8nY6O2fO8D40KFUJ7xfAAL5tA=;
	b=tckS64K734OPAkkj/MZa6jHqwMAaOgo/uqfp3cSrN0qqghpJPE1ODufPLGUKNaa6Eg8i
	 Ww1QKb7M842B3mncImaA0a56VIzmW5toMYeGX/cb+jiUG5C6kCGqNCbha2Bkk66tIOiE6
	 9isoa3Fijz+zvvXu1oOxPwKzwkhvkr336+QPQU4h6Nb+ogVeOthrxOCxmTF8UWi5PW+iX
	 EYyv/DT8yfd5MyxcqzyNtY34b4YxFLcgLd3CjOSvfm1zSM1ZS4aFRUa3I86Qs5tIwkIgH
	 RskyEnaNJ8/94R2+dm80rnV0MjwCxtGjqCt3vDADnidOs1AFvcRvUfu1iip/rAfiHIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=shWdw9AB;
	arc=none smtp.remote-ip=44.246.77.92
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570D4606A31D
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 15:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 570D4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=shWdw9AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1792510047; x=1824046047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=smYt2A/D6bgUwhq9IK8nY6O2fO8D40KFUJ7xfAAL5tA=;
  b=shWdw9ABuM6oaHzEBXN5tYKHuoDtoB4fFGsFQt3qmrVHF9pxT4HSNqdo
   XHoYGHr88skmuhUZCsD7I1qCMxxeaV0y+P0XQe+qFKwfXs9KKLQfPc/O9
   w81skMhOqxdBoW0EqvMUGrq5WRElYLdYa7/AOqE8Fjc7RXjUVUj2zY9fh
   Q6sio5erKqMajUCYmtMnnA3IWi1vNh5K8lrm8ZhwxZITHE9RHSXFeweCU
   N81iWbgAUWWLUiD1dwe7tPfocGSGEtSlRRMCXIWnvL1Eh2uy0bOzZcEiB
   rQxmgdaNnJdlOIt/FdO6gv+sQyLiCCGHuT+TOdscXCRwgn02yxhkJ5e2F
   g==;
X-CSE-ConnectionGUID: Jcj+GkKXSHySA4WmnLxOmQ==
X-CSE-MsgGUID: Jg08VMWkQtKCOUUao/upxQ==
X-IronPort-AV: E=Sophos;i="6.27,168,1787011200"; 
   d="scan'208";a="31748079"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 15:27:24 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:25929]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.38:2525] with esmtp (Farcaster)
 id 0b048636-3cdf-4399-9489-66b476c5a006; Tue, 20 Oct 2026 15:27:24 +0000 (UTC)
X-Farcaster-Flow-ID: 0b048636-3cdf-4399-9489-66b476c5a006
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 20 Oct 2026 15:27:24 +0000
Received: from dev-dsk-gmazz-1b-865f0d50.eu-west-1.amazon.com (10.253.70.18)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 20 Oct 2026 15:27:23 +0000
From: Giacomo Mazzola <gmazz@amazon.de>
To: <kvm@vger.kernel.org>
CC: Giacomo Mazzola <gmazz@amazon.de>
Subject: [kvm-unit-tests PATCH v2 5/8] x86: replace per-AP bringup prints with a single summary line
Date: Tue, 20 Oct 2026 15:25:22 +0000
Message-ID: <20261020152525.57694-6-gmazz@amazon.de>
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
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

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

