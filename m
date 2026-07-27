Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9DF3CB55D;
	Mon, 27 Jul 2026 23:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196366; cv=none; b=LjBcKLsMzQHDraSW755imXhNqkjLqWX5e5ahhTnHWrAmJIgo/KJtn+l4jWJNu4xfLnb/WtOKAs52pK/wTUGTGckpn6bp2vv/nii7T0i3Mls3zqCO9bxIkjzc9iCoVhZCEcA0preJ1AqYIfX89ewe+ZOUMcjTZAbK56XtHHAtskw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196366; c=relaxed/simple;
	bh=6rPDuMXHnodQi/OJ6oaeAakLQY4TMAkHcsPeBHUBtU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPnexH4Su8y8+/RLZAk5Ib01qboSY6RohooqWlSoZIK9E5u2cTCnPQ+9R0dNUPjx9ixssFLYgZVBX/Y3QDy8sozFQsMKqX1V+Rw3gMH/ae8yYuh6qVQKIcmLEbZySIh3F3PTZ2kWiIFMBe8JDpgPw1wx9Ya/lgFsC9M9vOtJ7SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KODcGCzb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KODcGCzb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EF51F00A3D;
	Mon, 27 Jul 2026 23:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196365;
	bh=Sv1DYiOhBzdJCe0hu/ca1fwHWgfDZ+1S79F0QDcLsrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KODcGCzbRaUzs4DENIA1pCe9MtMio8eGglbg56bv7i2vaKvtI2xKnqHWhcygGy0C7
	 Z5oECMiP3u5XTbKVowTArkq8f7FGDmCW+ysYTgPRsakiQ4Su6JT5DZSUvsOXxFcSDn
	 bNu2FXgtQT86S4+VvEuEg5ui+o1bZjEIp7m9G84ZMDTvi59Uvu1+tLzOqZffTNvOvF
	 UKDq8xWTp9vTfYtQ6pE6AK/0p3ttLZk5mEX9x1Ci6oPnObFGW9b9HVihx9pgVkSOVS
	 Pv60VZhdlziBfLGGl0Il9c48W4uex3u+6ll8lzWm0wh/dw8SkddUpjhiafCQuQSDjh
	 1oWPYWDXSKaRQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 01/12] KVM: selftests: Use __stringify() instead of custom XSTR() macros
Date: Mon, 27 Jul 2026 23:52:17 +0000
Message-ID: <20260727235228.1007324-2-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260727235228.1007324-1-yosry@kernel.org>
References: <20260727235228.1007324-1-yosry@kernel.org>
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
2.55.0.229.g6434b31f56-goog

