Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4715F49E157
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101793; cv=none; b=mNmKd60yEYAS6Bm1aMH7ZxfhDqmjGZ2JkMYFxH/lUm8Iu3F+Q6DQrWHka2guzvbusb4Lgs9tYWdCsfCvo/a3c1S6RS72dQOKzGYNbeguU7sgDLq7W5GQtq0dThd3XqrrkFM5+1wKJn3/OkOlUVQiQppX9XlB4rvDpgx4+EzdpBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101793; c=relaxed/simple;
	bh=KzcFLwxDYRUviGnz7lciExDgQPjdt85UQfQ5GEWv/6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Za42pYyhC68eKmSFnnjCjO1kmk9gM7BzsqHRiyQj2FpfjQa+yNc4KWVkB/b8p8TwX1q0abtYqOigcAPGSOc7PhgHP7S5ntn+7z4UpcVey+CuZYdrr9N1lMZ6Q7VGsfQhwLawTzOtt5WFQL7/MQ0/MozdxVADinIWwXIAGBi+JAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLBcfe+Q; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLBcfe+Q"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664e051fso108640eec.1
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 11:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101791; x=1790706591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+EizYOfATJ2ZpuBFIvbNSn2bZp6dnoqHuB3tFHvlG54=;
        b=aLBcfe+Qv+FXrbn2xWraUZyR2/T0JNR7Ptz/gRZXnMDUCM3ZKn1GFto2/Sfp+7HvrI
         yeAPSkHI/cnSITzws2+/N1tFAvwqVqGl3QOq6ZS9ubGfxSHK8r4R6gzVgo2RFZHN88jf
         Fwhul02SqEZqC0yhSnMPxAl4rXBnTXpsRDSA/OaoKDLIZLtwrcqetLkd+1vR6RVHodv2
         +/q1y4fRLRlvKuhvOwUkniqYUzyk9nFuvPQ+ck4AlXG36ZVbZvtZoBKVgdil1qHSORt7
         QhanrVVxRudJK2Q8RlCZOVdWE+2mlrREtKbTnrat3uczDuxSy+uTY7p3M9Pk9ErYDPfd
         OjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101791; x=1790706591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+EizYOfATJ2ZpuBFIvbNSn2bZp6dnoqHuB3tFHvlG54=;
        b=YVp1VCsAyI0edSV9no8/girhSUJt7P444qTNR44npgv+TeGWiz8PXCKjMHdeyYfWbg
         iPMKtIOQapk1JGZc8tcdC1N3Xl7W39aXgOnx8uRYQyE1tM/aVfkc8fMOpbIisx06GuDR
         TTSsGmIWiHF4VNAGidOed0GQPVNCCbgCnU1OiWhItupy9ruWGaTMOZD7LgRxGPFR/8MN
         K3AAmFCSUulnmPupi1MkoNqOHIytk1nVeRgEaW3bGmYINSNwQ2SZ1hsQjIwv4nWLuW32
         J/MkVlD8K18gltjXAoaoiU4+xToCalaEF9VyKry2guyosCfTcOV8eHnOZzMJFoa1V8zH
         rHig==
X-Gm-Message-State: AFuF++neFq/e3Mh25DzsbH2ZECWK/asOzGIt+pW93kxXCNUHMnPcl4zR
	Kcsk67FJOByb5zY2OuOX3rtm41rR7myrO9ghCiXqrSwuGKfDFhJuBxJrb8uMLw==
X-Gm-Gg: AYBFou3XHHek8SxLUDfHNdubXRLYr0kuzmKxRuRKxU5nNjaOXrj2rsMTjS00F5Z5IcQ
	Mh0VhPQfFq9WOszTlQMdLvi4UBxr8bvFrMBI8Q1Z3BvF/IQ6lYSFceArCQ2eEFT4rancpf998ur
	cxO5MDyYEjiHh8jMPRZ/THbmVNCkLdkXquIBQILgnbBHi9GHHsxKEub3/ReG3ra0DkK2TVCIQlT
	tS0N6coTZ3O/M9nSkMSe6xvjAIP0Mweu99qVU/qJVTk5hb67OX/n0Mlk7HSqyGtl5owOCuzAMh2
	vTjp6iR/vbUxwbtpJrsloZa+GCmGUeKgp0EmorAYhgi9ATqnw8FcCLFcnwjzfd+oRZCrvBrc4y2
	G5p+9eaqLi5/dnSNLGJxFqFHknR8baJ4byHhZM/f2o94cAu5HrEOu/gNuAhSsWkoB98jHAhM4fG
	3AwerXrw+/stYxjl1TKv8cdvGoyGDdoHRtUpNSMKXd5R3qulf+BHbXWtSVICVGx1mCY8H4I8Fuh
	G8843ea7ZbI9pZcQJdyt7kQ3qBNQhf+x6j1DmPn+JB3jY4w6cWpVYYamk2z
X-Received: by 2002:a05:7300:fb15:b0:334:2bee:348e with SMTP id 5a478bee46e88-33e8dbc413amr139604eec.22.1790101791075;
        Tue, 22 Sep 2026 11:29:51 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdabcsm154315eec.3.2026.09.22.11.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:29:50 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v5 7/9] KVM: PPC: selftests: Make nested case on pseries LPARs as resource constrained
Date: Tue, 22 Sep 2026 23:58:51 +0530
Message-Id: <39f4b13c66955df3fd75f3ea3aa48aa5b2da3840.1790101179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790101179.git.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For nested guest case (L1 as pseries LPAR), L0 may fail with -44
(H_NOT_ENOUGH_RESOURCES) during vm or vcpu creation, causing enomem
due to limited resource/quotas.
This adds the necessary arch hooks for the same so that it can survive
hardware_disable_test and kvm_create_max_vcpus test cases.

Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 .../testing/selftests/kvm/include/powerpc/processor.h  |  7 +++++++
 tools/testing/selftests/kvm/lib/powerpc/processor.c    | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/powerpc/processor.h b/tools/testing/selftests/kvm/include/powerpc/processor.h
index f0ee21a8e2d4..a46f6828991c 100644
--- a/tools/testing/selftests/kvm/include/powerpc/processor.h
+++ b/tools/testing/selftests/kvm/include/powerpc/processor.h
@@ -6,6 +6,8 @@
 #define SELFTEST_KVM_PROCESSOR_H
 
 #include <linux/compiler.h>
+#include <unistd.h>
+
 #include "ppc_asm.h"
 #include "kvm_util_types.h"
 
@@ -36,4 +38,9 @@ static inline void cpu_relax(void)
 	asm volatile("" ::: "memory");
 }
 
+static inline bool is_pseries_lpar(void)
+{
+	return !access("/proc/device-tree/rtas/ibm,hypertas-functions", F_OK);
+}
+
 #endif
diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/testing/selftests/kvm/lib/powerpc/processor.c
index 301455024571..e5d84f6d82f2 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/processor.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -23,6 +23,16 @@ bool kvm_arch_needs_naturally_aligned_page_tables(void)
 	return true;
 }
 
+/*
+ * For nested guest case (L1 as pseries LPAR), L0 may fail with -44
+ * (H_NOT_ENOUGH_RESOURCES) during vm or vcpu creation, causing enomem
+ * due to limited resource/quotas.
+ */
+bool kvm_arch_vm_create_may_enomem(void)
+{
+	return is_pseries_lpar();
+}
+
 static void set_proc_table(struct kvm_vm *vm, int pid, u64 dw0, u64 dw1)
 {
 	u64 *proc_table;
-- 
2.39.5

