Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D07377AB2
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 04:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547556; cv=none; b=YpPZxOTDAjYmMKhXIMAY7I+lY+OE5FbI/LiFNOarPDU2EXpZvT+7svFD8SLTbKGnZ+wmkrOYLA3A952LAcAGVTeqJG4+XC0MlbViQUPK180etvYvUJj69ouZqKoLZWLHnvKG5WLbXksjpIJZ4kwVKGTfTh6KWDc8APSjD6BjF6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547556; c=relaxed/simple;
	bh=eUONUQtnrE6CpOD4DpAjNi0nBa9yypW9qspLl3p1p9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=se5SDbwBA4Iy5OXp/9WJiofng8HUBSQS2AYUjjMIzqK6C567EwRCOTBS88fVQEzGPKGGU/Bj3hpc2t8triHpmZN7d22cGbRoPIOSIyu5fzg6l78CU3fIbqPJLX65A5S4tsBvwGTYMiHtKtXgptqqnxQSXYZUo1aASKSUOp4OcHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436456|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00378828-0.000704797-0.995507;FP=7345161255091965258|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.ivXOSuN_1787547225;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.ivXOSuN_1787547225 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 24 Aug 2026 12:53:46 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v3 10/10] target/i386: Use AMD ucode-rev default for Hygon
Date: Mon, 24 Aug 2026 12:53:14 +0800
Message-ID: <20260824045314.162941-11-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260824045314.162941-1-zhang_wei@open-hieco.net>
References: <20260824045314.162941-1-zhang_wei@open-hieco.net>
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
by this Hygon bug-fix group.  pc-11.1 and older machine types leave that
gate off, so they retain the previous ucode-rev default.  Explicit
user-provided ucode-rev values still override the default.

Add qtest coverage for the new default, the compatibility cases, and an
explicit user override.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c                   |  3 ++-
 tests/qtest/test-x86-cpuid-compat.c | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f65a5b32bc..0630cfd8b2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10222,7 +10222,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
          * needs to happen after the evenual setting of ucode_rev in
          * accel-specific code in cpu_common_realize.
          */
-        if (IS_AMD_CPU(env)) {
+        if (IS_AMD_CPU(env) ||
+            (IS_HYGON_CPU(env) && cpu->hygon_vendor_abi_fixes)) {
             cpu->ucode_rev = 0x01000065;
         } else {
             cpu->ucode_rev = 0x100000000ULL;
diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index 44d4631cd6..13c9ddb4db 100644
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
+        "x86/cpuid/props/dhyana/ucode-rev/pc-i440fx-11.1",
+        "Dhyana", NULL, "pc-i440fx-11.1",
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

