Received: from out198-30.us.a.mail.aliyun.com (out198-30.us.a.mail.aliyun.com [47.90.198.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1F6171CD
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 06:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317698; cv=none; b=gS7L7GLHs555Q2pLyIWX6bFVlan1B1JZCZgbpOeeLRmA4b7nQZE0n8WeKCZtE8YeQYwXoByGgjrsZTXFY3+LYjWoxHnku6wqeJnZYkzi/4QjrptPFT/TW/AZWVi8iqFp80pUADSgnaHyw6SBie2PMKEGJBY2rFyCChG4RI6M7P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317698; c=relaxed/simple;
	bh=MisJFXWCVdBQNIoksu8dhFPnJduHgJ9HkbqDqltgy78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaX2PYLnMjrWiaXcldERroFEQZtDY5QtjMJCCtOmLy8ZxQ5OAVZw2N/J3Cx3Yis6UZtJrm4yX0lC9xhkml0ub+zCUn74swmMdJJNFxVGhlkFRXMIhd9EhKaR+qi+KO/J8y1jPTlJGsUSaK85grJVq5c4uNbkehGOV5lH0iLjDk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436462|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00386058-0.000288194-0.995851;FP=16568572874340175179|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068005250;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.iEEStvD_1783317368;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iEEStvD_1783317368 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 06 Jul 2026 13:56:08 +0800
From: zhang_wei@open-hieco.net
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v1 9/9] target/i386: Use AMD ucode-rev default for Hygon
Date: Mon,  6 Jul 2026 13:55:30 +0800
Message-ID: <20260706055530.1752094-10-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tina Zhang <zhang_wei@open-hieco.net>

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

Preserve migration ABI through the Hygon vendor ABI fixes property.
pc-11.0 and older machine types leave it off, so they retain the previous
ucode-rev default.  Explicit
user-provided ucode-rev values still override the default.

Add qtest coverage for the new default, the compatibility cases, and an
explicit user override.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 target/i386/cpu.c                   |  8 ++++++--
 tests/qtest/test-x86-cpuid-compat.c | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 279c9b3ae7..af1e5f2857 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10232,10 +10232,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
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

