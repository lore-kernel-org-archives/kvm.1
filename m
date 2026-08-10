Received: from out198-29.us.a.mail.aliyun.com (out198-29.us.a.mail.aliyun.com [47.90.198.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8269F3AB47B
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786351001; cv=none; b=j57trt7DO7U6gJDuDr+/O40XJEpvjJfZzVAVs3WPp1eJjjL0Ds3Kucw4uTCnq/Q8dFSuK7aqURA6Q84ldr3SgwRZ0ufBkj6SEY/c4DIw61bPB0YpmsvV515f7LBQmHt0Y86nj2TN3zwRq0HqTuUQUUApFy1Z80T3t+N3H5tH4S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786351001; c=relaxed/simple;
	bh=6md9IcDmAwMKuFCizgpuz4wGQYlErgoSQJ68bhfayow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIhP6HWVF0y/zQk2zshfE5L8BeWnluVOhc7Uug8hYUH4DCm1mCEHTPSn2ZNjEk8Nf0fH0Ps+vam35ZFYS5EsJrm2hM2U0ngPNqWgAGXpVSQ+5copmhcbmQtcsnMiIfHZ/hUXlEUObdqzJhQOMs2rV4dzCujjdsAkdnSKM+Z5DeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436348|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00378828-0.000704797-0.995507;FP=16568555282154128715|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.iiL7hRH_1786350665;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iiL7hRH_1786350665 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 10 Aug 2026 16:31:05 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v2 9/9] target/i386: Use AMD ucode-rev default for Hygon
Date: Mon, 10 Aug 2026 16:29:56 +0800
Message-ID: <20260810082956.1768042-10-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QEMU currently gives named Hygon Dhyana CPUs the non-AMD default
ucode-rev value, 0x100000000.  That is the Intel/KVM-VMX-shaped
encoding, where the visible revision is in the high 32 bits.

Linux reads MSR 0x8b for Hygon CPUs through the AMD patch-level path,
using MSR_AMD64_PATCH_LEVEL and storing the low 32 bits as
cpuinfo_x86.microcode.  With the old QEMU default, a Dhyana guest sees
microcode revision 0.

Use the AMD/KVM-SVM-shaped default, 0x01000065, for Hygon on this
specific MSR 0x8b default path.  This does not route Hygon through AMD
microcode loading and does not claim that Hygon CPUs are otherwise
identical to AMD CPUs.

Preserve migration ABI through the vendor CPU ABI compatibility gate used
by this Hygon bug-fix group.  pc-11.0 and older machine types leave that
gate off, so they retain the previous ucode-rev default.  Explicit
user-provided ucode-rev values still override the default.

Add qtest coverage for the new default, the compatibility cases, and an
explicit user override.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 target/i386/cpu.c                   |  8 ++++++--
 tests/qtest/test-x86-cpuid-compat.c | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4d8364f1ef..eb4295e562 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10219,10 +10219,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     if (cpu->ucode_rev == 0) {
         /*
          * The default is the same as KVM's. Note that this check
-         * needs to happen after the evenual setting of ucode_rev in
+         * needs to happen after the eventual setting of ucode_rev in
          * accel-specific code in cpu_exec_realizefn.
+         *
+         * Hygon uses the AMD patch-level MSR 0x8b encoding, where the visible
+         * microcode revision is in the low 32 bits.
          */
-        if (IS_AMD_CPU(env)) {
+        if (IS_AMD_CPU(env) ||
+            (IS_HYGON_CPU(env) && cpu->hygon_vendor_abi_fixes)) {
             cpu->ucode_rev = 0x01000065;
         } else {
             cpu->ucode_rev = 0x100000000ULL;
diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index b7f8834052..06cbf35d76 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -404,6 +404,25 @@ static const CpuidTestArgs cpuid_tests[] = {
         "486", "xlevel2=0xC0000002,xstore=on",
         NULL, "xlevel2", 0xC0000002,
     },
+    {
+        "x86/cpuid/props/dhyana/ucode-rev/default",
+        "Dhyana", NULL, NULL, "ucode-rev", 0x01000065,
+    },
+    {
+        "x86/cpuid/props/dhyana/ucode-rev/compat-off",
+        "Dhyana", "x-hygon-vendor-abi-fixes=off", NULL,
+        "ucode-rev", 0x100000000LL,
+    },
+    {
+        "x86/cpuid/props/dhyana/ucode-rev/pc-i440fx-11.0",
+        "Dhyana", NULL, "pc-i440fx-11.0",
+        "ucode-rev", 0x100000000LL,
+    },
+    {
+        "x86/cpuid/props/dhyana/ucode-rev/user",
+        "Dhyana", "ucode-rev=0x12345678", NULL,
+        "ucode-rev", 0x12345678,
+    },
 };
 
 /*
-- 
2.43.7

