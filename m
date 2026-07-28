Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A511E435AB3;
	Tue, 28 Jul 2026 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260560; cv=none; b=NuOZSpIDBpZIFyZfBzST1kfNajZE33wYNktvdL05z/4OhNzY3vNiamSAgLtVkIGwPulzirc8UGOELX8EodlAGb9ZJmFZWWqFDFTV6HAbjEoRlQTVs3vquxopvVPwQyBm60GGcDewQvy2O2AjNjf8eW5fV6kSGKJlijMApYicnfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260560; c=relaxed/simple;
	bh=whrrR8QaI9WejrE2lrY3JpDsActkBIgQOW7Zl198sNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TL377EM/wWyiko4KAtMdUIC1g8L5iN5snOPDe3k9Qor5rdU6UlSmP4ssEJcPvwHbIDdc+hjVu53O2IZu1tcIMrYW5MDK7MHbq47oqNAJjW3B4mK9uhtL2M36rhZ9xRUC9EiwfU9z/t8CBR4jlPdYBZHvCq/JHWUxr4timns80AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXP7+u+7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXP7+u+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DF51F00A3A;
	Tue, 28 Jul 2026 17:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260559;
	bh=072o1yhWMH7SFXPZJVumA86OPam1HzYiWo18nuSNC/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JXP7+u+7ShLjEIqfo+qccXckp/6Hg7hIE6OisLIeRFOCTW3X16qlWrEoYVMhqkue0
	 kOTphq+KVNHADkhxnkos+UUh4XVfhCb+Ut3VaD/ovKotKgmeVk+aL9Sd2ijXksr5+N
	 yFu6qOAo0VMYXDUMXuQfzIgXNjY7TJzCUeT577haO5CZRRuc3IhmrTF5XrTWEGklp3
	 2Dw/+tJDT7S+Z2brHkpWnPxM2kfI6KpzA9uyu/JF2D0ZO87egK4xvpCxYe7T4JuBUk
	 s0gYuUAx/lhNVqyL1FfgSrvRbUx0ZQYLIXD1uVJ1co2lvltriTXnddajZJi+6DMeF1
	 t1boAzc3x0SSQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v5 01/13] KVM: selftests: Use __stringify() instead of custom XSTR() macros
Date: Tue, 28 Jul 2026 17:42:20 +0000
Message-ID: <20260728174232.2423257-2-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
In-Reply-To: <20260728174232.2423257-1-yosry@kernel.org>
References: <20260728174232.2423257-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the custom defined XSTR() macros in KVM selftests and use
__stringify() instead. Include stringify.h in test_util.h to make it
available for all tests instead of including it in all the tests that
need it, as more tests will start using it.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/include/test_util.h           | 1 +
 tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c | 5 +----
 tools/testing/selftests/kvm/x86/fix_hypercall_test.c      | 1 -
 tools/testing/selftests/kvm/x86/smm_test.c                | 5 +----
 4 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index d64c8a228207a..e8356ee54d7b9 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -23,6 +23,7 @@
 
 #include <linux/mman.h>
 #include <linux/types.h>
+#include <linux/stringify.h>
 
 #define msecs_to_usecs(msec)    ((msec) * 1000ULL)
 
diff --git a/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c b/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c
index 77ce87c41a868..aa7f3b405fd32 100644
--- a/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c
+++ b/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c
@@ -22,9 +22,6 @@
 
 #define SYNC_PORT	0xe
 
-#define STR(x) #x
-#define XSTR(s) STR(s)
-
 /*
  * SMI handler: runs in real-address mode.
  * Reports SMRAM_STAGE via port IO, then does RSM.
@@ -37,7 +34,7 @@ static u8 smi_handler[] = {
 
 static inline void sync_with_host(u64 phase)
 {
-	asm volatile("in $" XSTR(SYNC_PORT) ", %%al \n"
+	asm volatile("in $" __stringify(SYNC_PORT) ", %%al \n"
 		     : "+a" (phase));
 }
 
diff --git a/tools/testing/selftests/kvm/x86/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86/fix_hypercall_test.c
index 753a0e730ea8d..4931ec22768ee 100644
--- a/tools/testing/selftests/kvm/x86/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86/fix_hypercall_test.c
@@ -6,7 +6,6 @@
  */
 #include <asm/kvm_para.h>
 #include <linux/kvm_para.h>
-#include <linux/stringify.h>
 #include <stdint.h>
 
 #include "kvm_test_harness.h"
diff --git a/tools/testing/selftests/kvm/x86/smm_test.c b/tools/testing/selftests/kvm/x86/smm_test.c
index e2542f4ced605..d1edafd5af755 100644
--- a/tools/testing/selftests/kvm/x86/smm_test.c
+++ b/tools/testing/selftests/kvm/x86/smm_test.c
@@ -22,9 +22,6 @@
 #define SMRAM_GPA 0x1000000
 #define SMRAM_STAGE 0xfe
 
-#define STR(x) #x
-#define XSTR(s) STR(s)
-
 #define SYNC_PORT 0xe
 #define DONE 0xff
 
@@ -42,7 +39,7 @@ u8 smi_handler[] = {
 
 static inline void sync_with_host(u64 phase)
 {
-	asm volatile("in $" XSTR(SYNC_PORT)", %%al \n"
+	asm volatile("in $" __stringify(SYNC_PORT)", %%al \n"
 		     : "+a" (phase));
 }
 
-- 
2.55.0.487.gaf234c4eb3-goog

