Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795689014;
	b=b30GBBXRpbb8CRcuyF8XknaF/MNyosGm3F1qFEeRMMHXbpCska21lFlCdm2fYTaZ4xAD
	 BmIdCHMOTNfM+DD4Z1QQcP5Kb1vGZrqD5pQMuCT+WA5WvMsOdpQwEVpGIQT9d6iUwKiVK
	 /a4lpumYq7Yun0v8L+HLmg/WWU8zNyn6CqTvW14zpx4U/dGY6WWpFCoaSmDxWJmW3XFMy
	 VPxEYfDU2u4SHPXhKygkB3gGiDWHU+PUgEtmhcnN6NvqyoLzWlup10v5+NhE22eqooDrw
	 YBOTn4+sHySCmISI0vteXwBriFAQsW6B7Bt+Q4ca+uzPelBFMzFb7SV6p7wBifuf8MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689014;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=PNNNAps2GAWHn+wZn/RJOFKnKBTvpgrZnghX/qsXXF0=;
	b=O2DJhjPfKsEPEBPKb1xRWxLWrBlpVV7lMx87xoLy4Ppxxrvf5RdTHZvXXWq7re0ngdEL
	 fdYn3AJZqr+0K19k8U/MenYtHaquJUDzxnLIZo7UJYL5Kr9UBQwNRogwmjhqafpgVNlPl
	 7yWFtOQ+VGs+pcnUFv3xUIN/G6tfJBY7AXFv55Ega+HJ0KSg1LGESq2t82SBO++zrqBDs
	 CYlQTC/u/PA2sXRe+j/9mWT02tZdz33J2ETIop4XTRn88katHFq4ZUk4NNLYJx6Vojb5j
	 qTaeem3vyGOzFF5+LiaAFGkBkhM9VV/NVNWxkurkDNSb+w3pAaRlZ+RfNRVtmlc6lSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gEriYqT2;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F25606A6AC
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 10:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98F25606A6AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gEriYqT2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795689010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PNNNAps2GAWHn+wZn/RJOFKnKBTvpgrZnghX/qsXXF0=;
	b=gEriYqT2MQFC1kN1doBW9qp7Mm0te/GRfWKebmK/Kl13scX27/bHjtnsfVJEo0LokSVA4I
	APN017xGnYmV9D9H7w/ZvklDrGrH1VfQGloCEidvUNg8t85S+GbHpwfye9ReIHSeNsyxqr
	rLVxzour6XZLu5+m8O7T3/XTX0BpK04=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-A3HN2bO5Ox6Ji-xPBYFVPw-1; Thu,
 26 Nov 2026 10:30:08 +0000
X-MC-Unique: A3HN2bO5Ox6Ji-xPBYFVPw-1
X-Mimecast-MFC-AGG-ID: A3HN2bO5Ox6Ji-xPBYFVPw_1795689007
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51E8418002D7;
	Thu, 26 Nov 2026 10:30:07 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B8D51956086;
	Thu, 26 Nov 2026 10:30:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com,
	andrew.jones@linux.dev
Subject: [PATCH kvm-unit-tests 1/6] arm: remove usage of the errata mechanism
Date: Thu, 26 Nov 2026 11:29:57 +0100
Message-ID: <20261126103002.2145135-2-pbonzini@redhat.com>
In-Reply-To: <20261126103002.2145135-1-pbonzini@redhat.com>
References: <20261126103002.2145135-1-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The errata mechanism has never seen widespread use, and the few instances
of it date back to 2019.  Drop it from the tests.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arm/debug.c |  1 -
 arm/gic.c   | 10 ----------
 arm/pmu.c   |  8 ++------
 arm/psci.c  |  9 ++-------
 arm/timer.c |  5 +----
 5 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/arm/debug.c b/arm/debug.c
index 0299fd28..8cd04604 100644
--- a/arm/debug.c
+++ b/arm/debug.c
@@ -1,6 +1,5 @@
 #include <libcflat.h>
 #include <migrate.h>
-#include <errata.h>
 #include <asm/setup.h>
 #include <asm/processor.h>
 #include <asm/delay.h>
diff --git a/arm/gic.c b/arm/gic.c
index 256dd80d..e76de2b7 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -13,7 +13,6 @@
  */
 #include <libcflat.h>
 #include <migrate.h>
-#include <errata.h>
 #include <asm/setup.h>
 #include <asm/processor.h>
 #include <asm/delay.h>
@@ -811,8 +810,6 @@ static void test_its_migration(void)
 	check_spurious();
 }
 
-#define ERRATA_UNMAPPED_COLLECTIONS "ERRATA_8c58be34494b"
-
 static void test_migrate_unmapped_collection(void)
 {
 	struct its_collection *col = NULL;
@@ -826,13 +823,6 @@ static void test_migrate_unmapped_collection(void)
 		return;
 	}
 
-	if (!errata(ERRATA_UNMAPPED_COLLECTIONS)) {
-		report_skip("Skipping test, as this test hangs without the fix. "
-			    "Set %s=y to enable.", ERRATA_UNMAPPED_COLLECTIONS);
-		migrate_skip();
-		return;
-	}
-
 	col = its_create_collection(pe0, pe0);
 	dev2 = its_get_device(2);
 	dev7 = its_get_device(7);
diff --git a/arm/pmu.c b/arm/pmu.c
index 2fcec71a..59ace986 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -14,7 +14,6 @@
  * for more details.
  */
 #include "libcflat.h"
-#include "errata.h"
 #include "asm/barrier.h"
 #include "asm/sysreg.h"
 #include "asm/processor.h"
@@ -1171,11 +1170,8 @@ static void pmccntr64_test(void)
 {
 #ifdef __arm__
 	if (pmu.version == ID_DFR0_PMU_V3) {
-		if (ERRATA(9e3f7a296940)) {
-			write_sysreg(0xdead, PMCCNTR64);
-			report(read_sysreg(PMCCNTR64) == 0xdead, "pmccntr64");
-		} else
-			report_skip("Skipping unsafe pmccntr64 test. Set ERRATA_9e3f7a296940=y to enable.");
+		write_sysreg(0xdead, PMCCNTR64);
+		report(read_sysreg(PMCCNTR64) == 0xdead, "pmccntr64");
 	}
 #endif
 }
diff --git a/arm/psci.c b/arm/psci.c
index 5800c0ac..33dce081 100644
--- a/arm/psci.c
+++ b/arm/psci.c
@@ -7,7 +7,6 @@
  *
  * This work is licensed under the terms of the GNU LGPL, version 2.
  */
-#include <errata.h>
 #include <libcflat.h>
 
 #include <asm/delay.h>
@@ -250,14 +249,10 @@ int main(void)
 	report(psci_affinity_info_on(), "affinity-info-on");
 	report(psci_affinity_info_off(), "affinity-info-off");
 
-	if (ERRATA(6c7a5dce22b3))
-		report(psci_cpu_on_test(), "cpu-on");
-	else
-		report_skip("Skipping unsafe cpu-on test. Set ERRATA_6c7a5dce22b3=y to enable.");
-
+	report(psci_cpu_on_test(), "cpu-on");
 	assert(!cpu_idle(0));
 
-	if (!ERRATA(6c7a5dce22b3) || cpumask_weight(&cpu_idle_mask) == nr_cpus - 1)
+	if (cpumask_weight(&cpu_idle_mask) == nr_cpus - 1)
 		report(psci_cpu_off_test(), "cpu-off");
 	else
 		report_skip("Skipping cpu-off test because the cpu-on test failed");
diff --git a/arm/timer.c b/arm/timer.c
index 898043f0..2d419859 100644
--- a/arm/timer.c
+++ b/arm/timer.c
@@ -7,7 +7,6 @@
  */
 #include <libcflat.h>
 #include <devicetree.h>
-#include <errata.h>
 #include <asm/timer.h>
 #include <asm/delay.h>
 #include <asm/processor.h>
@@ -360,9 +359,7 @@ static void test_init(void)
 	ptimer_info.read_ctl();
 	install_exception_handler(EL1H_SYNC, ESR_ELx_EC_UNKNOWN, NULL);
 
-	if (ptimer_unsupported && !ERRATA(7b6b46311a85)) {
-		report_skip("Skipping ptimer tests. Set ERRATA_7b6b46311a85=y to enable.");
-	} else if (ptimer_unsupported) {
+	if (ptimer_unsupported) {
 		report_fail("ptimer: read CNTP_CTL_EL0");
 		report_info("ptimer: skipping remaining tests");
 	}
-- 
2.56.1


