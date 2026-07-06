Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com [115.124.28.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A5B3BE659
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 05:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317376; cv=none; b=OYO+XvhcPV7ltAuYUSvEqtgB8fYrCmj0hFujMkEqtcnfqkCqAk2FdvgCv/wwh45qpgczb2Q0nEnV5RCpUwx9ifj7dpmRXggxqpdVNKzGGJj4vj76JQy31GcZSOrNEXtaCKXRismMWI4kvFT2DzBiz8hmoFxJ82PSR2AMLs8jxH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317376; c=relaxed/simple;
	bh=HLb3y2Or5DMXmZ4Bt5bBsjJ2gjHnM5SfESaTlL7OUBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZM59noxZ4JMmgagn3p5lqpzzV7JHBZmyGEyCA22MSiDh6qwhRls9ejh6Zgi+w2TiOtMQvCWe6IipPU5fi9es4HYDRJVaTd8T1t2oPJMSH6/JPW3a0TFg8ero+83yur5n/0nEWa5Il6QCF8qjfabyjsiK3YMndmljIyhC53MiZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0304456-0.000448784-0.969106;FP=16428971096157982427|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068005250;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.iEEStoh_1783317363;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iEEStoh_1783317363 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 06 Jul 2026 13:56:03 +0800
From: zhang_wei@open-hieco.net
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v1 1/9] target/i386: Sync AMD CPUID aliases for Hygon
Date: Mon,  6 Jul 2026 13:55:22 +0800
Message-ID: <20260706055530.1752094-2-zhang_wei@open-hieco.net>
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

AMD defines CPUID[0x80000001].EDX bits as aliases for a subset of
CPUID[1].EDX.  QEMU currently synchronizes those aliases only when the
guest CPU vendor is AuthenticAMD.

Hygon Dhyana uses the HygonGenuine vendor string, but implements the
same AMD-compatible extended CPUID feature aliases.  This can leave QEMU
advertising a feature in CPUID[1].EDX while the matching extended alias
in CPUID[0x80000001].EDX stays clear, for example MMX.  Windows guests
with Hyper-V enabled can fail to start the Hyper-V hypervisor when
exposed to that inconsistent CPUID state.

Apply the alias synchronization to Hygon CPUs as well.  Gate the new
behavior with x-hygon-vendor-abi-fixes and disable it for pc-11.0 and
older machine types, because the CPUID result is guest-visible ABI and
must remain migration-compatible.

Add qtest coverage for the Dhyana model, including the
Hygon vendor ABI fixes property.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 hw/i386/pc.c                        |  4 +-
 target/i386/cpu.c                   | 23 +++++++--
 target/i386/cpu.h                   | 12 +++++
 tests/qtest/test-x86-cpuid-compat.c | 76 +++++++++++++++++++++++++++++
 4 files changed, 111 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 73a625327c..11dade642f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -73,7 +73,9 @@
 #include "hw/xen/xen-bus.h"
 #endif
 
-GlobalProperty pc_compat_11_0[] = {};
+GlobalProperty pc_compat_11_0[] = {
+    { TYPE_X86_CPU, "x-hygon-vendor-abi-fixes", "false" },
+};
 const size_t pc_compat_11_0_len = G_N_ELEMENTS(pc_compat_11_0);
 
 GlobalProperty pc_compat_10_2[] = {};
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5805d33ab9..32b8bc9ebd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8608,6 +8608,20 @@ uint32_t cpu_x86_virtual_addr_width(CPUX86State *env)
     }
 }
 
+/*
+ * AMD CPUs define CPUID[0x80000001].EDX aliases for selected CPUID[1].EDX
+ * feature bits.  Hygon Dhyana follows the same extended feature alias rules.
+ * Enable the corrected Hygon behavior only for machine types where Hygon
+ * vendor ABI fixes are on.
+ */
+static bool x86_cpu_has_amd_cpuid_aliases(const X86CPU *cpu)
+{
+    const CPUX86State *env = &cpu->env;
+
+    return IS_AMD_CPU(env) ||
+           (cpu->hygon_vendor_abi_fixes && IS_HYGON_CPU(env));
+}
+
 void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                    uint32_t *eax, uint32_t *ebx,
                    uint32_t *ecx, uint32_t *edx)
@@ -10147,10 +10161,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
-    /* On AMD CPUs, some CPUID[8000_0001].EDX bits must match the bits on
-     * CPUID[1].EDX.
+    /*
+     * CPUs that use AMD-compatible extended CPUID aliases must keep selected
+     * CPUID[0x80000001].EDX bits synchronized with CPUID[1].EDX.
      */
-    if (IS_AMD_CPU(env)) {
+    if (x86_cpu_has_amd_cpuid_aliases(cpu)) {
         env->features[FEAT_8000_0001_EDX] &= ~CPUID_EXT2_AMD_ALIASES;
         env->features[FEAT_8000_0001_EDX] |= (env->features[FEAT_1_EDX]
            & CPUID_EXT2_AMD_ALIASES);
@@ -10810,6 +10825,8 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
     DEFINE_PROP_BOOL("x-vendor-cpuid-only-v2", X86CPU, vendor_cpuid_only_v2, true),
+    DEFINE_PROP_BOOL("x-hygon-vendor-abi-fixes", X86CPU,
+                     hygon_vendor_abi_fixes, true),
     DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e6a197602d..3e75b03609 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1281,6 +1281,9 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_VENDOR_ZHAOXIN1   "CentaurHauls"
 #define CPUID_VENDOR_ZHAOXIN2   "  Shanghai  "
 
+#define CPUID_VENDOR_HYGON_1  0x6f677948 /* "Hygo" */
+#define CPUID_VENDOR_HYGON_2  0x6e65476e /* "nGen" */
+#define CPUID_VENDOR_HYGON_3  0x656e6975 /* "uine" */
 #define CPUID_VENDOR_HYGON    "HygonGenuine"
 
 #define IS_INTEL_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 && \
@@ -1289,6 +1292,9 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define IS_AMD_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_AMD_1 && \
                          (env)->cpuid_vendor2 == CPUID_VENDOR_AMD_2 && \
                          (env)->cpuid_vendor3 == CPUID_VENDOR_AMD_3)
+#define IS_HYGON_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_HYGON_1 && \
+                           (env)->cpuid_vendor2 == CPUID_VENDOR_HYGON_2 && \
+                           (env)->cpuid_vendor3 == CPUID_VENDOR_HYGON_3)
 #define IS_ZHAOXIN1_CPU(env) \
     ((env)->cpuid_vendor1 == CPUID_VENDOR_ZHAOXIN1_1 && \
      (env)->cpuid_vendor2 == CPUID_VENDOR_ZHAOXIN1_2 && \
@@ -2461,6 +2467,12 @@ struct ArchCPU {
      */
     bool vendor_cpuid_only_v2;
 
+    /*
+     * Enable Hygon vendor ABI fixes for new machine types.  Old machine
+     * types disable this to preserve guest-visible CPU ABI.
+     */
+    bool hygon_vendor_abi_fixes;
+
     /* Only advertise TOPOEXT features that AMD defines */
     bool amd_topoext_features_only;
 
diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index 17c0965827..b7f8834052 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -113,6 +113,21 @@ typedef struct FeatureTestArgs {
     bool expected_value;
 } FeatureTestArgs;
 
+typedef struct BoolPropTestArgs {
+    /* Test name */
+    const char *name;
+    /* CPU type */
+    const char *cpu;
+    /* CPU features (may be NULL) */
+    const char *cpufeat;
+    /* machine type (may be NULL to use default machine) */
+    const char *machine;
+    /* CPU property to read */
+    const char *property;
+    /* expected value of the property */
+    bool expected_value;
+} BoolPropTestArgs;
+
 /* Get the value for a feature word in a X86CPUFeatureWordInfo list */
 static uint32_t get_feature_word(QList *features, uint32_t eax, uint32_t ecx,
                                  const char *reg)
@@ -170,6 +185,38 @@ static void test_feature_flag(const void *data)
     g_free(cmdline);
 }
 
+static void test_bool_prop(const void *data)
+{
+    const BoolPropTestArgs *args = data;
+    char *cmdline;
+    char *save;
+    char *path;
+    bool value;
+
+    cmdline = g_strdup_printf("-cpu %s", args->cpu);
+
+    if (args->cpufeat) {
+        save = cmdline;
+        cmdline = g_strdup_printf("%s,%s", cmdline, args->cpufeat);
+        g_free(save);
+    }
+    if (args->machine) {
+        save = cmdline;
+        cmdline = g_strdup_printf("-machine %s %s", args->machine, cmdline);
+        g_free(save);
+    }
+
+    qtest_start(cmdline);
+    path = get_cpu0_qom_path();
+    value = qom_get_bool(path, args->property);
+    qtest_end();
+
+    g_assert_cmpint(value, ==, args->expected_value);
+
+    g_free(path);
+    g_free(cmdline);
+}
+
 static void test_plus_minus_subprocess(void)
 {
     char *path;
@@ -407,6 +454,28 @@ static const FeatureTestArgs feature_tests[] = {
         "max", "mmx=off",
         1, 0, "EDX", 23, false,
     },
+    {
+        "x86/cpuid/features/dhyana/ext-mmx",
+        "Dhyana", NULL,
+        0x80000001, 0, "EDX", 23, true,
+    },
+    {
+        "x86/cpuid/features/dhyana/ext-mmx/compat-off",
+        "Dhyana", "x-hygon-vendor-abi-fixes=off",
+        0x80000001, 0, "EDX", 23, false,
+    },
+};
+
+static const BoolPropTestArgs bool_prop_tests[] = {
+    {
+        "x86/cpuid/props/dhyana/hygon-vendor-abi-fixes/default",
+        "Dhyana", NULL, NULL, "x-hygon-vendor-abi-fixes", true,
+    },
+    {
+        "x86/cpuid/props/dhyana/hygon-vendor-abi-fixes/pc-i440fx-11.0",
+        "Dhyana", NULL, "pc-i440fx-11.0",
+        "x-hygon-vendor-abi-fixes", false,
+    },
 };
 
 int main(int argc, char **argv)
@@ -433,6 +502,13 @@ int main(int argc, char **argv)
         qtest_add_data_func(feature_tests[i].name,
                             &feature_tests[i], test_feature_flag);
     }
+    for (int i = 0; i < ARRAY_SIZE(bool_prop_tests); i++) {
+        if (!qtest_has_cpu_model(bool_prop_tests[i].cpu)) {
+            continue;
+        }
+        qtest_add_data_func(bool_prop_tests[i].name,
+                            &bool_prop_tests[i], test_bool_prop);
+    }
 
     return g_test_run();
 }
-- 
2.43.7

