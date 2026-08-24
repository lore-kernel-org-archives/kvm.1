Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FA635C1B2
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 04:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547233; cv=none; b=W+7W8VxRsB78ACa8sJVT+2ilrtrt63GPr95jUYhuXpiBh12hrwmZIKiau+WV8HH0q61AxBzFY1xxgBVtw/Xu+kTDaOJtOgEaVISm0YZumca4nTE37NG8Z92gr/W5929F7FhgyDhKnaTagyI11k6GtSzDN09bRDolGyVT8jhi+UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547233; c=relaxed/simple;
	bh=ukJOCQZ6Eafov1D4N5umsmL3NGcqmkWsy1ABDaCfxS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+iklYA8n1jQwDOH7c002d6vq7Q7F8cPn1qryskENUzTVTO7ysrwHXUgrncYknx9sM4Krqhm016EnDxp3xr9PaB49zi6T4me4mbYMxRD3Raawm+CA8CcZP05uRv408CS1ItoIc479WANJkyQQs4YzCDs13p7ano4ed1Y0cMX91I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07439357|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0855287-0.00298891-0.911482;FP=7196578113995211987|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.ivXOSnt_1787547219;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.ivXOSnt_1787547219 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 24 Aug 2026 12:53:40 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v3 02/10] target/i386: Hide Intel cache CPUID leaves for Hygon
Date: Mon, 24 Aug 2026 12:53:06 +0800
Message-ID: <20260824045314.162941-3-zhang_wei@open-hieco.net>
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

When x-vendor-cpuid-only is enabled, QEMU suppresses CPUID leaves 2
and 4 for AuthenticAMD CPUs because those leaves describe Intel cache
information.  Hygon Dhyana uses the HygonGenuine vendor string, so it
currently skips that filtering and can expose Intel cache leaves together
with AMD/Hygon extended cache leaves.

That is inconsistent guest-visible CPUID: Hygon Dhyana provides cache
information through the extended cache leaves, so it should not also
advertise the Intel cache descriptor and deterministic cache parameter
leaves.

Apply the same leaf 2 and leaf 4 filtering to Hygon CPUs when the vendor
CPU ABI compat gate is enabled.  The gate keeps the old CPUID output for
pc-11.1 and older machine types.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index eca51de50d..c87f4684a3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8608,6 +8608,21 @@ uint32_t cpu_x86_virtual_addr_width(CPUX86State *env)
     }
 }
 
+/*
+ * CPUID leaves 2 and 4 describe Intel cache information.  AMD CPUs use
+ * extended cache leaves instead, and Hygon Dhyana follows that AMD/Hygon
+ * convention.  Enable the corrected Hygon behavior only for machine types
+ * where the CPU ABI compat gate is on.
+ */
+static bool x86_cpu_filter_intel_cache_leaves(const X86CPU *cpu)
+{
+    const CPUX86State *env = &cpu->env;
+
+    return cpu->vendor_cpuid_only &&
+           (IS_AMD_CPU(env) ||
+            (cpu->hygon_vendor_abi_fixes && IS_HYGON_CPU(env)));
+}
+
 void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                    uint32_t *eax, uint32_t *ebx,
                    uint32_t *ecx, uint32_t *edx)
@@ -8693,7 +8708,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
-        } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
+        } else if (x86_cpu_filter_intel_cache_leaves(cpu)) {
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
@@ -8729,7 +8744,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                                 CPU_TOPOLOGY_LEVEL_SOCKET), 4095) << 14;
                 }
             }
-        } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
+        } else if (x86_cpu_filter_intel_cache_leaves(cpu)) {
             *eax = *ebx = *ecx = *edx = 0;
         } else {
             *eax = 0;
-- 
2.43.7

