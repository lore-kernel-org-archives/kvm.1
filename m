Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE8A2D781B
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350672; cv=none; b=CAugLZ468R7r322+f8r2hAAXI755wh/dhHn3LrgJVnh3ZamzY2ftT8zH+uYpbyCSkeV/wxEwrIc+4R66Gkxv/l6lw5i0hJqiVYcbf9oOFlypowgXzpK+JDn37TKUM8Fec9OnunhUab1jfqI+lCnd5t7yFR3omZjVSjNvRngw/bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350672; c=relaxed/simple;
	bh=AnfpaQtQu8qyufpuFzUuQJzuBRgVrFalevuvtIkWYK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bh9Sh97L2OFEHacYfkAqC+wysH1jBB1YgVsxVyXa4AftiCphAl8uOQxYlJp5gDKcO3vX+UyTQnXLmItSdVLECLffDSGY2JVlBc9GO7Tj5gOS+QgQU5jnwvRDk6uF+KAeoiA8O1Sn3/hnrZRrCDr8+HRH+are2QfPIkHgDvI7J80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0320193-0.00123147-0.966749;FP=16717333417464172249|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iiL7hJD_1786350659;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iiL7hJD_1786350659 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 10 Aug 2026 16:30:59 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>,
	Tina Zhang <zhang_wei@open-hieco.net>,
	Yongwei Xu <xuyongwei@open-hieco.net>
Subject: [PATCH v2 1/9] target/i386: Sync AMD CPUID aliases for Hygon
Date: Mon, 10 Aug 2026 16:29:48 +0800
Message-ID: <20260810082956.1768042-2-zhang_wei@open-hieco.net>
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

AMD defines CPUID[0x80000001].EDX bits as aliases for a subset of
CPUID[1].EDX.  QEMU currently synchronizes those aliases only when the
guest CPU vendor is AuthenticAMD.

Hygon Dhyana uses the HygonGenuine vendor string, but implements the
same AMD-compatible extended CPUID feature aliases.  This can leave QEMU
advertising a feature in CPUID[1].EDX while the matching extended alias
in CPUID[0x80000001].EDX stays clear.  This inconsistent CPUID state can
confuse guest OS feature detection.

Apply the alias synchronization to Hygon CPUs as well.  Gate the new
behavior with x-hygon-vendor-abi-fixes and disable it for pc-11.0 and
older machine types, because the CPUID result is guest-visible ABI and
must remain migration-compatible.

Add qtest coverage for the Dhyana model, including the compat property.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
Tested-by: Yongwei Xu <xuyongwei@open-hieco.net>
---
 hw/i386/pc.c                        |  5 ++
 hw/i386/pc_piix.c                   |  1 +
 hw/i386/pc_q35.c                    |  1 +
 include/hw/i386/pc.h                |  3 ++
 target/i386/cpu.c                   | 10 ++--
 target/i386/cpu.h                   | 13 +++++
 tests/qtest/test-x86-cpuid-compat.c | 76 +++++++++++++++++++++++++++++
 7 files changed, 106 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f064aa2b3e..2b4e322b2f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -74,6 +74,11 @@
 #include "hw/xen/xen-bus.h"
 #endif
 
+GlobalProperty pc_compat_11_1[] = {
+    { TYPE_X86_CPU, "x-hygon-vendor-abi-fixes", "false" },
+};
+const size_t pc_compat_11_1_len = G_N_ELEMENTS(pc_compat_11_1);
+
 GlobalProperty pc_compat_11_0[] = {};
 const size_t pc_compat_11_0_len = G_N_ELEMENTS(pc_compat_11_0);
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 82457bdb16..8e58f2a7ee 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -438,6 +438,7 @@ DEFINE_I440FX_MACHINE_AS_LATEST(11, 1);
 static void pc_i440fx_machine_11_0_options(MachineClass *m)
 {
     pc_i440fx_machine_11_1_options(m);
+    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);
     compat_props_add(m->compat_props, hw_compat_11_0, hw_compat_11_0_len);
     compat_props_add(m->compat_props, pc_compat_11_0, pc_compat_11_0_len);
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6c1e4eff5f..fd4366f51f 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -393,6 +393,7 @@ DEFINE_Q35_MACHINE_AS_LATEST(11, 1);
 static void pc_q35_machine_11_0_options(MachineClass *m)
 {
     pc_q35_machine_11_1_options(m);
+    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);
     compat_props_add(m->compat_props, hw_compat_11_0, hw_compat_11_0_len);
     compat_props_add(m->compat_props, pc_compat_11_0, pc_compat_11_0_len);
 }
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d4b6d3ed57..ac03da97b6 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -209,6 +209,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
 
+extern GlobalProperty pc_compat_11_1[];
+extern const size_t pc_compat_11_1_len;
+
 extern GlobalProperty pc_compat_11_0[];
 extern const size_t pc_compat_11_0_len;
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5805d33ab9..2d1542ad17 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10147,10 +10147,12 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
-    /* On AMD CPUs, some CPUID[8000_0001].EDX bits must match the bits on
-     * CPUID[1].EDX.
+    /*
+     * CPUs that use AMD-compatible extended CPUID aliases must keep selected
+     * CPUID[0x80000001].EDX bits synchronized with CPUID[1].EDX.
      */
-    if (IS_AMD_CPU(env)) {
+    if (IS_AMD_CPU(env) ||
+        (cpu->hygon_vendor_abi_fixes && IS_HYGON_CPU(env))) {
         env->features[FEAT_8000_0001_EDX] &= ~CPUID_EXT2_AMD_ALIASES;
         env->features[FEAT_8000_0001_EDX] |= (env->features[FEAT_1_EDX]
            & CPUID_EXT2_AMD_ALIASES);
@@ -10810,6 +10812,8 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
     DEFINE_PROP_BOOL("x-vendor-cpuid-only-v2", X86CPU, vendor_cpuid_only_v2, true),
+    DEFINE_PROP_BOOL("x-hygon-vendor-abi-fixes", X86CPU,
+                     hygon_vendor_abi_fixes, true),
     DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e6a197602d..491c911139 100644
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
@@ -2461,6 +2467,13 @@ struct ArchCPU {
      */
     bool vendor_cpuid_only_v2;
 
+    /*
+     * Compatibility bit for old machine types: if true, apply Hygon
+     * vendor-specific ABI fixes.  Old machine types disable this to preserve
+     * the guest-visible CPU ABI.
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

