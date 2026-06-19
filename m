Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E463B14C8
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882429; cv=none; b=XJsMSM6KDcvD2u9Hn8mS4aYBu84Tqd7AxRrWksL0QMgWGxFhik/bLgGHXX0NvrSlxXhf4iPVoL1r7LQnYXKL2tH19mobNK25O19w98MWZ1fZEs5Y9wEj7xSvvWI3LscQvAhuCvqRfUeFiSXGdwPRglwVrVZ6oCOcipcp4oCL8Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882429; c=relaxed/simple;
	bh=pVQCY/mCheQDsG5xXuTLOHrGtjQVyaFSCAWgwV2UOE8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kEIdvkF2yKAMmDhTnw1+xn5JKQBf/EM62ikQHvYZGYFdRdEd7WyOgJydfAzw2SrUFXym9vzv7Hqn8p3SqKBWwve3RLeUvwrYIJMNFXcOA2DaHThnYKYRsn096YuAx0eRnfYTBTp02ABtMLveEFttF1rnm6uROY61NxHFaYVHUgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p0PC43Ix; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p0PC43Ix"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8611b27631so2132342a12.0
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 08:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781882426; x=1782487226; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+vw7YYohjD+DTWxJHhhg4uukjaWH//EBPhsjPR2EJ6Y=;
        b=p0PC43IxsIvwJbbVVsLMP6F/QYFMkxlydK6aIGsC0jScjYDGZbz3p0dLFmlkdmnjAm
         wRfizLJI3UHfwFJXgzsvUUIsUDSZuVWQQtgIoq0oCvHiqIBkkY6qsfLKrmGS0+xK98Jy
         jDYjQtTIJbxpmMTP/Tfik3w38/qRHse2zzScVIdVHR+bQIJwB6GJYRcORHP2uG0XdF2D
         bAAuPAuN9kd2eqWpsy1VjWvviEoo0P/DFWuabkayQMjI+Sbfo28YfnF4RjvYsRca5Ke9
         dV+xSKHwu7XJyJhzQ1VBH3lqrHV0cnOsfOrMWokLcS3h0z1YqsHGyXTqy4+xcUmjTcLh
         opHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781882426; x=1782487226;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vw7YYohjD+DTWxJHhhg4uukjaWH//EBPhsjPR2EJ6Y=;
        b=CTsAuklOUha0H3/x2KLwJVmrT6Z1a83c3uZHEo/8oS/1BHYSSf9ZerMyCbBYQ7CA/R
         FDsNbVmZOuw3NyTAfZiA1R1tNm2PBNPaGHBVXK/JSjof7Bfkte+LatJNV6GQaA9BpOfh
         jynG5rUw2LpGvaXC7CTF25ZsR5glH/Rxe7+pg7qJoHho0TrjNfzbnWoOhzo0IQMEhY6a
         RfS7hsxQxfphxzT/wzq3gwQkw+MSD75pinw7AsiqyMhWZiKELP2mzb3T4Oc0n23TRDVC
         4HEQU+OY2goF8BXKdxpVEywiwMG6T4AUuWGmcr+w5MODkSKxE+l0V03FbvDlBG95V7/1
         vqsQ==
X-Forwarded-Encrypted: i=1; AFNElJ+UxxZkMJn970k8J2c2h8okF18wx46mWWnrcpnyhjITk1eIcYmu0zswrt7wTSenPHQdhBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3brDY3HFBJaGA0vS3fsuuNsYjpBRY+pDHX/7PHOBOYGEsO+u/
	HR8iPAQxo08SivEwsrqVgdCSL9DkK0jXggZTiNrokL1lgPDmjigdyvMtC7yl5luU9B15zQ0R9Kk
	wYZiVwCp+STQ4/Q==
X-Received: from pgc9.prod.google.com ([2002:a05:6a02:2f89:b0:c89:dbbc:c841])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3418:b0:3ba:d7b0:fcac with SMTP id adf61e73a8af0-3bb3364fe09mr3899266637.5.1781882425809;
 Fri, 19 Jun 2026 08:20:25 -0700 (PDT)
Date: Fri, 19 Jun 2026 08:19:26 -0700
In-Reply-To: <20260619152006.3684428-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260619152006.3684428-1-jmattson@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260619152006.3684428-4-jmattson@google.com>
Subject: [kvm-unit-tests PATCH 3/5] x86/apic: Support subtest selection via
 command line
From: Jim Mattson <jmattson@google.com>
To: pbonzini@redhat.com, kvm@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Refactor the APIC test suite to support running a subset of tests specified
via command line arguments (e.g., passed via QEMU's -append option). This
matches the test selection pattern already established in x86/vmexit.c.

Define 'struct apic_test' to associate a name with each test function and
leverage the new 'argv_test_wanted()' library helper to filter the
execution loop.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 x86/apic.c | 57 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/x86/apic.c b/x86/apic.c
index fee1b7893185..65198ecfb3c1 100644
--- a/x86/apic.c
+++ b/x86/apic.c
@@ -1,4 +1,5 @@
 #include "libcflat.h"
+#include "argv.h"
 #include "apic.h"
 #include "vm.h"
 #include "smp.h"
@@ -905,43 +906,42 @@ static void test_aliased_xapic_physical_ipi(void)
 	report(!f, "IPI to aliased xAPIC physical IDs");
 }
 
-typedef void (*apic_test_fn)(void);
+struct apic_test {
+	const char *name;
+	void (*fn)(void);
+};
 
-int main(void)
+
+
+int main(int argc, char **argv)
 {
 	bool is_x2apic = is_x2apic_enabled();
 	u32 spiv = apic_read(APIC_SPIV);
 	int i;
 
-	const apic_test_fn tests[] = {
-		test_lapic_existence,
-
-		test_apic_disable,
-		test_enable_x2apic,
-
-		test_self_ipi_xapic,
-		test_self_ipi_x2apic,
-		test_physical_broadcast,
-		test_logical_ipi_xapic,
-
-		test_pv_ipi,
-
-		test_sti_nmi,
-		test_multiple_nmi,
-		test_pending_nmi,
-
-		test_apic_timer_one_shot,
-		test_apic_change_mode,
-		test_tsc_deadline_timer,
-
+	const struct apic_test tests[] = {
+		{ "lapic_existence", test_lapic_existence },
+		{ "apic_disable", test_apic_disable },
+		{ "enable_x2apic", test_enable_x2apic },
+		{ "self_ipi_xapic", test_self_ipi_xapic },
+		{ "self_ipi_x2apic", test_self_ipi_x2apic },
+		{ "physical_broadcast", test_physical_broadcast },
+		{ "logical_ipi_xapic", test_logical_ipi_xapic },
+		{ "pv_ipi", test_pv_ipi },
+		{ "sti_nmi", test_sti_nmi },
+		{ "multiple_nmi", test_multiple_nmi },
+		{ "pending_nmi", test_pending_nmi },
+		{ "apic_timer_one_shot", test_apic_timer_one_shot },
+		{ "apic_change_mode", test_apic_change_mode },
+		{ "tsc_deadline_timer", test_tsc_deadline_timer },
 		/*
 		 * KVM may disable APICv if the APIC ID and/or APIC_BASE is
 		 * modified, keep these tests at the end so that the test as a
 		 * whole provides coverage for APICv (when it's enabled).
 		 */
-		test_apic_id,
-		test_apicbase,
-		test_aliased_xapic_physical_ipi,
+		{ "apic_id", test_apic_id },
+		{ "apicbase", test_apicbase },
+		{ "aliased_xapic_physical_ipi", test_aliased_xapic_physical_ipi },
 	};
 
 	assert_msg(is_apic_hw_enabled() && is_apic_sw_enabled(),
@@ -953,7 +953,10 @@ int main(void)
 	sti();
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-		tests[i]();
+		if (!argv_test_wanted(tests[i].name, argv + 1, argc - 1))
+			continue;
+
+		tests[i].fn();
 
 		if (is_x2apic)
 			enable_x2apic();
-- 
2.55.0.rc0.799.gd6f94ed593-goog

