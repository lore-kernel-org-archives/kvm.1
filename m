Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899F826D4E5
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423463; cv=none; b=HDHtDx/kEcqPZEpPitqYpDnyvqr99sZxJXA+ngnJJGdMG7NehtttxhIxK6bHfmbyp+D6+gTTF7WvvwQ/cvbwtSUJI6eCPu4/BdE87pQ+fwIhJ3Z1xmd9TH7HMIUkV8ltDFaQWCICAnPQH2BDX2W0M5OMmjdZVI6wyoQjwBtVmQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423463; c=relaxed/simple;
	bh=WJbTkFAj/ZLjlWwJzLZinilRMiAR2tWxC75pSvc7NH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ANnJ9CSL9/f57x0mHeFXYawpd+OmCcxfU7ByV7+ok1yYsg02laEVp4Q5hMbpCubZi/BF15PQJUEMksBm0y3Dkjd5ALhrL5AmtukXZEMjzSz3zXaluyAcMfHxG26gftRt6jcHvc8oZJtQ7ZJOyjtfNKvoAdYcrq42dwmHuTWX97Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iT45tgHu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iT45tgHu"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id CAEDA20B7128;
	Fri, 17 Apr 2026 03:57:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CAEDA20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423461;
	bh=y23U10OHhRRPCOKznJ7K98y1+BJGjXnGiGrs7LPC2Jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iT45tgHu82o/vNt+YxSiFHyX/GkHQw+W6JsL+W0ZLYNQQoE1m2eHqAhuZ86M8rzga
	 NtLZiXBNuAfKuxpukA+pRE/n3otCARSNzJ2uvc3gTP/jQdd7jCllPoX56fLMpxmlbY
	 9rhH1PkR1zPzq5kT9m/mqAazOIRhDJTpnB1OnSFE=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wei Liu <wei.liu@kernel.org>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 21/34] target/i386/mshv: migrate MTRR MSRs
Date: Fri, 17 Apr 2026 12:56:05 +0200
Message-Id: <20260417105618.3621-22-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change roundtrips memory access/caching MSRs. The mapping scheme
is a bit more elaborate on these, so we have added a special handling
instead of individual entries in the MSR mapping table.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/msr.c | 136 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 129 insertions(+), 7 deletions(-)

diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
index 0ecd864458..b26375e4c2 100644
--- a/target/i386/mshv/msr.c
+++ b/target/i386/mshv/msr.c
@@ -79,6 +79,10 @@ static const MshvMsrEnvMap msr_env_map[] = {
     { HV_X64_MSR_SIMP,      HV_REGISTER_SIMP,
                             offsetof(CPUX86State, msr_hv_synic_msg_page) },
 
+    /* MTRR default type */
+    { IA32_MSR_MTRR_DEF_TYPE, HV_X64_REGISTER_MSR_MTRR_DEF_TYPE,
+                              offsetof(CPUX86State, mtrr_deftype) },
+
     /* Other */
 
     /* TODO: find out processor features that correlate to unsupported MSRs. */
@@ -90,6 +94,98 @@ static const MshvMsrEnvMap msr_env_map[] = {
                             offsetof(CPUX86State, spec_ctrl) },
 };
 
+/*
+ * The assocs have to be set according to this schema:
+ *      8  entries for 0-7 mtrr_base
+ *      8  entries for mtrr_mask 0-7
+ *      11 entries for 1 x 64k, 2 x 16k, 8 x 4k fixed MTRR
+ *      27 total entries
+ */
+
+#define MSHV_MTRR_MSR_COUNT 27
+#define MSHV_MSR_TOTAL_COUNT (ARRAY_SIZE(msr_env_map) + MSHV_MTRR_MSR_COUNT)
+
+static void store_in_env_mtrr_phys(CPUState *cpu,
+                                   const struct hv_register_assoc *assocs,
+                                   size_t n_assocs)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    size_t i, fixed_offset;
+    hv_register_name hv_name;
+    uint64_t base, mask;
+
+    assert(n_assocs == MSHV_MTRR_MSR_COUNT);
+
+    for (i = 0; i < MSR_MTRRcap_VCNT; i++) {
+        hv_name = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0 + i;
+        assert(assocs[i].name == hv_name);
+        hv_name = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0 + i;
+        assert(assocs[i + MSR_MTRRcap_VCNT].name == hv_name);
+
+        base = assocs[i].value.reg64;
+        mask = assocs[i + MSR_MTRRcap_VCNT].value.reg64;
+        env->mtrr_var[i].base = base;
+        env->mtrr_var[i].mask = mask;
+    }
+
+    /* fixed 1x 64, 2x 16, 8x 4 kB */
+    fixed_offset = MSR_MTRRcap_VCNT * 2;
+    for (i = 0; i < 11; i++) {
+        hv_name = HV_X64_REGISTER_MSR_MTRR_FIX64K00000 + i;
+        assert(assocs[fixed_offset + i].name == hv_name);
+        env->mtrr_fixed[i] = assocs[fixed_offset + i].value.reg64;
+    }
+}
+
+/*
+ * The assocs have to be set according to this schema:
+ *      8  entries for 0-7 mtrr_base
+ *      8  entries for mtrr_mask 0-7
+ *      11 entries for 1 x 64k, 2 x 16k, 8 x 4k fixed MTRR
+ *      27 total entries
+ */
+static void load_from_env_mtrr_phys(const CPUState *cpu,
+                                    struct hv_register_assoc *assocs,
+                                    size_t n_assocs)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    size_t i, fixed_offset;
+    uint64_t base, mask, fixed_value;
+    hv_register_name base_name, mask_name, fixed_name;
+    hv_register_assoc *assoc;
+
+    assert(n_assocs == MSHV_MTRR_MSR_COUNT);
+
+    for (i = 0; i < MSR_MTRRcap_VCNT; i++) {
+        base = env->mtrr_var[i].base;
+        mask = env->mtrr_var[i].mask;
+
+        base_name = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0 + i;
+        mask_name = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0 + i;
+
+        assoc = &assocs[i];
+        assoc->name = base_name;
+        assoc->value.reg64 = base;
+
+        assoc = &assocs[i + MSR_MTRRcap_VCNT];
+        assoc->name = mask_name;
+        assoc->value.reg64 = mask;
+    }
+
+    /* fixed 1x 64, 2x 16, 8x 4 kB */
+    fixed_offset = MSR_MTRRcap_VCNT * 2;
+    for (i = 0; i < 11; i++) {
+        fixed_name = HV_X64_REGISTER_MSR_MTRR_FIX64K00000 + i;
+        fixed_value = env->mtrr_fixed[i];
+
+        assoc = &assocs[fixed_offset + i];
+        assoc->name = fixed_name;
+        assoc->value.reg64 = fixed_value;
+    }
+}
+
 int mshv_init_msrs(const CPUState *cpu)
 {
     int ret;
@@ -131,8 +227,9 @@ static void store_in_env(CPUState *cpu, const struct hv_register_assoc *assocs,
     union hv_register_value hv_value;
     ptrdiff_t offset;
     uint32_t hv_name;
+    size_t mtrr_index;
 
-    assert(n_assocs <= (ARRAY_SIZE(msr_env_map)));
+    assert(n_assocs <= MSHV_MSR_TOTAL_COUNT);
 
     for (i = 0, j = 0; i < ARRAY_SIZE(msr_env_map); i++) {
         hv_name = assocs[j].name;
@@ -146,17 +243,38 @@ static void store_in_env(CPUState *cpu, const struct hv_register_assoc *assocs,
         MSHV_ENV_FIELD(env, offset) = hv_value.reg64;
         j++;
     }
+
+    mtrr_index = j;
+    store_in_env_mtrr_phys(cpu, &assocs[mtrr_index], MSHV_MTRR_MSR_COUNT);
 }
 
 static void set_hv_name_in_assocs(struct hv_register_assoc *assocs,
                                   size_t n_assocs)
 {
     size_t i;
+    size_t mtrr_offset, mtrr_fixed_offset;
+    hv_register_name hv_name;
+
+    assert(n_assocs == MSHV_MSR_TOTAL_COUNT);
 
-    assert(n_assocs == ARRAY_SIZE(msr_env_map));
     for (i = 0; i < ARRAY_SIZE(msr_env_map); i++) {
         assocs[i].name = msr_env_map[i].hv_name;
     }
+
+    mtrr_offset = ARRAY_SIZE(msr_env_map);
+    for (i = 0; i < MSR_MTRRcap_VCNT; i++) {
+        hv_name = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0 + i;
+        assocs[mtrr_offset + i].name = hv_name;
+        hv_name = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0 + i;
+        assocs[mtrr_offset + MSR_MTRRcap_VCNT + i].name = hv_name;
+    }
+
+    /* fixed 1x 64, 2x 16, 8x 4 kB */
+    mtrr_fixed_offset = mtrr_offset + MSR_MTRRcap_VCNT * 2;
+    for (i = 0; i < 11; i++) {
+        hv_name = HV_X64_REGISTER_MSR_MTRR_FIX64K00000 + i;
+        assocs[mtrr_fixed_offset + i].name = hv_name;
+    }
 }
 
 static bool msr_supported(uint32_t name)
@@ -181,8 +299,8 @@ static bool msr_supported(uint32_t name)
 int mshv_get_msrs(CPUState *cpu)
 {
     int ret = 0;
-    size_t n_assocs = ARRAY_SIZE(msr_env_map);
-    struct hv_register_assoc assocs[ARRAY_SIZE(msr_env_map)];
+    size_t n_assocs = MSHV_MSR_TOTAL_COUNT;
+    struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT];
     size_t i, j;
     uint32_t name;
 
@@ -223,8 +341,9 @@ static void load_from_env(const CPUState *cpu, struct hv_register_assoc *assocs,
     CPUX86State *env = &x86_cpu->env;
     ptrdiff_t offset;
     union hv_register_value *hv_value;
+    size_t mtrr_offset;
 
-    assert(n_assocs == ARRAY_SIZE(msr_env_map));
+    assert(n_assocs == MSHV_MSR_TOTAL_COUNT);
 
     for (i = 0; i < ARRAY_SIZE(msr_env_map); i++) {
         mapping = &msr_env_map[i];
@@ -233,12 +352,15 @@ static void load_from_env(const CPUState *cpu, struct hv_register_assoc *assocs,
         hv_value = &assocs[i].value;
         hv_value->reg64 = MSHV_ENV_FIELD(env, offset);
     }
+
+    mtrr_offset = ARRAY_SIZE(msr_env_map);
+    load_from_env_mtrr_phys(cpu, &assocs[mtrr_offset], MSHV_MTRR_MSR_COUNT);
 }
 
 int mshv_set_msrs(const CPUState *cpu)
 {
-    size_t n_assocs = ARRAY_SIZE(msr_env_map);
-    struct hv_register_assoc assocs[ARRAY_SIZE(msr_env_map)];
+    size_t n_assocs = MSHV_MSR_TOTAL_COUNT;
+    struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT];
     int ret;
     size_t i, j;
 
-- 
2.34.1

