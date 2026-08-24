Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com [115.124.28.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B20C378D9F
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 04:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547235; cv=none; b=MsGWCxdIr6Qo+CVbXmLR/Fsod+3qbqup5jk/h1OS4FY0OCRkIXjb1adIPZXTVUiuE5/mT10TiAXI0apyGt1+WuZ5nJSL4YyXyeLJitmuCRZEKemxL/X1OQQ/GN2xo24CPs1d1n3CwyMpaZEdbqBtMXPxobOWneJNaYS5zaTurVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547235; c=relaxed/simple;
	bh=2/A5J4KclDF6tBjoWt3Sp/9ltJ7r+jPWQH9fTCQNg94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgoDYuzoS9CDz2JAb8U+bln/pFBJrVMrYrSeYPtDNgBASwROWEcX4ijs4mtPJNdKTtQn844Ig78d4DjJIsiG+1NVEDBUgWS6CZAINhq+/AWN1su+3MAwmUjUapiQODdlCiQbwYccQsO0Yb650qcCcVl0Cc2Voin76+oH4br+0pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07565221|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0166025-0.00474792-0.97865;FP=7201093660862791771|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.ivXOSrF_1787547222;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.ivXOSrF_1787547222 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 24 Aug 2026 12:53:43 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v3 06/10] target/i386/kvm: Use AMD PMU MSR paths for Hygon
Date: Mon, 24 Aug 2026 12:53:10 +0800
Message-ID: <20260824045314.162941-7-zhang_wei@open-hieco.net>
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

On SVM, KVM uses the AMD PMU implementation and AMD PMU CPUID/MSR
layout.  Hygon guests that enable PMU and request AMD PMU CPUID
features such as perfctr-core need QEMU's KVM PMU setup and MSR state
paths to use that layout too.

The relevant QEMU KVM PMU paths are currently restricted to
AuthenticAMD guests: host/guest PMU compatibility checks, AMD PMU
information initialization, and AMD PMU MSR save/restore.  For a Hygon
Dhyana guest with pmu=on, the compatibility check reports vPMU as
unsupported solely because the guest vendor is HygonGenuine rather than
AuthenticAMD.  If the VM continues, QEMU still skips AMD PMU setup and
never saves or restores the AMD PMU MSRs for the Hygon guest.

Treat Hygon as using the AMD PMU CPUID/MSR layout for these KVM PMU
paths.  Because the PMU MSR layout is shared, accept both AMD and Hygon
hosts for guests using that layout.  This intentionally allows the PMU
compatibility check to pass for AMD-host/Hygon-guest and
Hygon-host/AMD-guest combinations.

This does not enable PMU, perfctr-core, or perfmon-v2 by default for the
Dhyana CPU model.  On backward migration to older QEMU, Hygon PMU MSR
state may still be dropped because older QEMU did not write that state
back through the AMD PMU MSR KVM paths for Hygon guests.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 target/i386/kvm/kvm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 01fc1d0674..f33bb6bd06 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2178,7 +2178,7 @@ static X86PMUVendor x86_cpu_pmu_vendor(const CPUX86State *env)
         return X86_PMU_VENDOR_INTEL;
     }
 
-    if (IS_AMD_CPU(env)) {
+    if (IS_AMD_CPU(env) || IS_HYGON_CPU(env)) {
         return X86_PMU_VENDOR_AMD;
     }
 
@@ -2197,7 +2197,8 @@ static X86PMUVendor x86_host_pmu_vendor(void)
         return X86_PMU_VENDOR_INTEL;
     }
 
-    if (g_str_equal(host_vendor, CPUID_VENDOR_AMD)) {
+    if (g_str_equal(host_vendor, CPUID_VENDOR_AMD) ||
+        g_str_equal(host_vendor, CPUID_VENDOR_HYGON)) {
         return X86_PMU_VENDOR_AMD;
     }
 
-- 
2.43.7

