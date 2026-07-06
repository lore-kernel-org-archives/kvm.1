Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com [115.124.28.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176C82E7631
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 05:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317375; cv=none; b=P2MTn7wGAo84EWLcljbHBWuFO+rqin98IZpXnrdoD7/vO59xEOntAt62q6cMuysL3adE9OR1c/FkqKUAXGeY07mO++pUVS0yO+4Anpc0cpATZXE3aXi8dgU3QCECdr6Y2PwNuJTR7AdQot/z89A+ttytWIgdJxN6SME2xKcsaOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317375; c=relaxed/simple;
	bh=aGs11wll3ir1U0i/ZEjEMfX6f+AKhEu4lGFPzzbNaj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlfVJV7rbSszedxaeTIJlPY7Un7arjzDI5fYn1dtN5GWvRfdY12udtHVMf5nNbyPhKtefLwkUNfXA0ABO9Lr569VOGCukqIYv7K8bhyvFxYy9iWbKV7TXbvCjmFwsQVikMlhrDYPzH5wxIZY3npqKtxwd1oilNJ/1orLtVbNM8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0743885|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0678529-0.000905267-0.931242;FP=7205585317544953051|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.iEEStpQ_1783317364;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iEEStpQ_1783317364 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 06 Jul 2026 13:56:04 +0800
From: zhang_wei@open-hieco.net
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v1 2/9] target/i386: Hide Intel cache CPUID leaves for Hygon
Date: Mon,  6 Jul 2026 13:55:23 +0800
Message-ID: <20260706055530.1752094-3-zhang_wei@open-hieco.net>
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

When x-vendor-cpuid-only is enabled, QEMU suppresses CPUID leaves 2
and 4 for AuthenticAMD CPUs because those leaves describe Intel cache
information.  Hygon Dhyana uses the HygonGenuine vendor string, so it
currently skips that filtering and can expose Intel cache leaves together
with AMD/Hygon extended cache leaves.

That is inconsistent guest-visible CPUID: Hygon Dhyana provides cache
information through the extended cache leaves, so it should not also
advertise the Intel cache descriptor and deterministic cache parameter
leaves.

Apply the same leaf 2 and leaf 4 filtering to Hygon CPUs when Hygon
vendor ABI fixes are enabled.  The property keeps the old CPUID output
for pc-11.0 and older machine types.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 target/i386/cpu.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 32b8bc9ebd..f0cad38c94 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8622,6 +8622,21 @@ static bool x86_cpu_has_amd_cpuid_aliases(const X86CPU *cpu)
            (cpu->hygon_vendor_abi_fixes && IS_HYGON_CPU(env));
 }
 
+/*
+ * CPUID leaves 2 and 4 describe Intel cache information.  AMD CPUs use
+ * extended cache leaves instead, and Hygon Dhyana follows that AMD/Hygon
+ * convention.  Enable the corrected Hygon behavior only for machine types
+ * where Hygon vendor ABI fixes are on.
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
@@ -8707,7 +8722,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
-        } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
+        } else if (x86_cpu_filter_intel_cache_leaves(cpu)) {
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
@@ -8743,7 +8758,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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

