Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B685A52FE40
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169762; cv=none; b=TY2kq0u3uH+Pmc2wNZUy5QMiJEWMgrxQCcRI4sZj4iK7+wXe2XlQVMTQgeGvPI7d2PcKDUSrUa3Ejvhje5K1bpLbWnbU8iEubKoqFq5iBAPzgeTWFsW+SxCAmW5Y2ZEaMSGSICPnzg67Bv6p0vp+fqyGWiNDKidLc0XB+0XoO0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169762; c=relaxed/simple;
	bh=KC4V6Pw2JUWM9O2zKRMIpBWI1l9C4BpVGXHjn+9/xzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/ktwuTpfKscqCSvB6VT5HitUhw5moNQpKclWU7cNhF/I8aLA+O0zfJFxD8vND77wWmdAsIbVom2LVvg5GPZUo3CHQpr2lXmGhOpb6UWZkQfL6TpjARCEN5zhI/wAa0Zxz9LtMjD5z3KzefawzFR1nn/cJN56p6J4bEHwnfNQNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbyxCtMD; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbyxCtMD"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-328664ef78fso556319eec.2
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169760; x=1790774560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sbxGSR1jQ3mjsiUMVexNy6mEJBAK/pzPmYIAHajWfls=;
        b=UbyxCtMD3ezceOhlkhJNhjmyAj8LdwEMQ7eTpANdZTBpJUcGSVdzMRi0lVuoTmb6AW
         5A2gwtEibG8xOJxrp6uKViMWc8By0XmtDfMhniZ7z4Iv+KUGiUVttjwz6UP0fkjKWmAy
         3jaDp2NvUctg2uD2MQBAt/SL9FFwupc7H+XWbJc7SlJwi/9lNv2T2ADNxz+2bQVT4xGZ
         zlqwNwQMw9DjfZKJbKxwVvEiPIIfxqdCVyzMuvW6aoScLC/Qz3VlIQyBT7hHTOsPM8zx
         qW0qmTtEFjSJI6O/Y1V0FlWpVtzOAKNT++7v6MxDB2crbAN/QYRf2mIvduY6aiGKaoSR
         4xAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169760; x=1790774560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sbxGSR1jQ3mjsiUMVexNy6mEJBAK/pzPmYIAHajWfls=;
        b=dRbqbHKPu5I5QDPAhxOoCmx2coShFpxKPkz5qjL7MMEath51mo4gkpmTQShRXwPgpV
         Z7DaoOcmunI4Krd+ElA2jt8iX/Owh7Jv2KCcGaip26laRdT4pIWnWCE8aopjslUd0tnY
         pGQJDAFGN6Yuw2Ge7+/Kv8sCFVeaF+5MahMVKoTD1OGMVdqU2QjKxktdAe55NhDqNqZy
         GlYbbZlsJ2iAUaMDUU6WzKkxdwk8em4sab5kp+wNN7OjJcd8P61LoQWwVWeCooVAc08O
         LfdpD+zoVToBBqaRQxK2IErBmjEf5cqpjejM9Qojv7geQ2nKr2HQlO7eETj8KzhWlZEb
         fdvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzp2g9KGVzyAJo/l//K27TZ7spvd3pDh6CQB8xvBK3P8odHj66eiZ8CLZA1ghh4zkfTrHE=@vger.kernel.org
X-Gm-Message-State: AFuF++nUPSPu7nup1m8Os9o7Y4XWRui1SMrCa+NonOYyR4wjDbLQZrdM
	MX+c23c/rtmw768uK1fUQFfq4W96bvaeK9yF+FQ7rnmIkYqQOyPhj+9j
X-Gm-Gg: AYBFou3vOmqCcpv+jk9jq40VQb0iczvpCm3CZiQOkPIgE9mPXfyi8jKoSBdv+SJPWA/
	a3piTxzl2AeTn3xcunSOyKNkSIhZR30Xa/gr120YwG/gRIEJ3tSf6xRk0HqX1RRnoUcWr9I2vWi
	HIILCl0icnm+7LTS53def78n4rCO9QzQrxEw/R2OKDg+R65dHPwT6xzuz/GpQ38BiqCYd5Gt/M9
	Ino5Ukg3tW/XTCw6MrkC+/WkRha/aL2vuFWZmf9Nct9dqw6oJJVuYVQLlojjssB/Wj/ZQhXGKRN
	ubsgMJ7TBZ01pxVRRwwHt0spkCygasMFO+Uoqcsw/H4Kmp3lRu1xfm7AVSjarQuJCvnZHmzWYQl
	aH9JimZFeUtwpHI+6+uJfJdRlhD+HqmzVVSWVBoSmiiwRNSn10smejBBC9rs0rCvkxRnN6LLtDD
	2rdyobB4GtJFhaXDq8idLNvxLPWEMK/oPOv1w8Lw75UY5rHswB5iHtYIlT9IRJPjNvCUb16gMbt
	tVTu3YgjUnVANO99gOq0cMf9M/+Vx4=
X-Received: by 2002:a05:7300:fb0a:b0:339:66ff:51b3 with SMTP id 5a478bee46e88-33e8e2b67b8mr2443005eec.37.1790169759593;
        Wed, 23 Sep 2026 06:22:39 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:22:38 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>,
	xen-devel@lists.xenproject.org,
	Chao Liu <chao.liu@processmission.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Peter Xu <peterx@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Fabiano Rosas <farosas@suse.de>,
	Xianglai Li <lixianglai@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	qemu-ppc@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Bibo Mao <maobibo@loongson.cn>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	David Hildenbrand <david@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	qemu-riscv@nongnu.org,
	kvm@vger.kernel.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Song Gao <17746591750@163.com>,
	qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org,
	Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 035/114] target/riscv: gate CPU types with TargetInfo
Date: Wed, 23 Sep 2026 21:15:09 +0800
Message-ID: <20260923131635.1894-36-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Gate CPU types with TypeInfo.is_available instead of
  TARGET_RISCV32/64: DEFINE_RISCV_CPU_AVAIL, DEFINE_RISCV64_CPU,
  and DEFINE_RISCV_CPU_32_64SYS.
- Add RISCVCPUDef.target_init. max and bare keep RV64/SV57 in
  the TypeInfo; on riscv32 the callbacks set RV32/SV32 after
  merge. Do not inherit the parent pointer.
- Validate RV64/128 misa_mxl_max only when not target_riscv32().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/cpu.c | 128 ++++++++++++++++++++++++++++++---------------
 target/riscv/cpu.h |   7 +++
 2 files changed, 93 insertions(+), 42 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c6f17390755..4343f431d62 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1586,18 +1586,37 @@ static const MISAExtInfo misa_ext_info_arr[] = {
     MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)")
 };
 
+static void riscv_max_target_init(RISCVCPUClass *mcc)
+{
+    if (!target_riscv32()) {
+        return;
+    }
+    mcc->def->misa_mxl_max = MXL_RV32;
+    mcc->def->cfg.max_satp_mode = VM_1_10_SV32;
+}
+
+static void riscv_bare_target_init(RISCVCPUClass *mcc)
+{
+    if (!target_riscv32()) {
+        return;
+    }
+    /* BARE has no misa_mxl_max, so the class_base_init satp clamp skips it. */
+    mcc->def->cfg.max_satp_mode = VM_1_10_SV32;
+}
+
 static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
 {
     CPUClass *cc = CPU_CLASS(mcc);
 
     /* Validate that MISA_MXL is set properly. */
     switch (mcc->def->misa_mxl_max) {
-#ifdef TARGET_RISCV64
     case MXL_RV64:
     case MXL_RV128:
+        if (target_riscv32()) {
+            g_assert_not_reached();
+        }
         cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
         break;
-#endif
     case MXL_RV32:
         cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
         break;
@@ -3092,6 +3111,8 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
 
     if (pcc->def) {
         mcc->def = g_memdup2(pcc->def, sizeof(*pcc->def));
+        /* TypeInfo supplies target_init; do not inherit the parent pointer. */
+        mcc->def->target_init = NULL;
     } else {
         mcc->def = g_new0(RISCVCPUDef, 1);
     }
@@ -3152,6 +3173,9 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
             mcc->def->custom_csrs = def->custom_csrs;
         }
 #endif
+        if (def->target_init) {
+            def->target_init(mcc);
+        }
     }
 
     if (!object_class_is_abstract(c)) {
@@ -3262,6 +3286,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = (parent_type_name),                       \
         .abstract = true,                                   \
+        .is_available = target_is_base_riscv,               \
         .class_data = &(const RISCVCPUDef) {                \
              .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
              .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
@@ -3270,10 +3295,11 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         },                                                  \
     }
 
-#define DEFINE_RISCV_CPU(type_name, parent_type_name, ...)  \
+#define DEFINE_RISCV_CPU_AVAIL(type_name, parent_type_name, avail, ...) \
     {                                                       \
         .name = (type_name),                                \
         .parent = (parent_type_name),                       \
+        .is_available = (avail),                            \
         .class_data = &(const RISCVCPUDef) {                \
              .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
              .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
@@ -3282,8 +3308,37 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         },                                                  \
     }
 
+#define DEFINE_RISCV_CPU(type_name, parent_type_name, ...)  \
+    DEFINE_RISCV_CPU_AVAIL(type_name, parent_type_name,     \
+                           target_is_base_riscv, __VA_ARGS__)
+
+#define DEFINE_RISCV64_CPU(type_name, parent_type_name, ...) \
+    DEFINE_RISCV_CPU_AVAIL(type_name, parent_type_name,     \
+                           target_is_riscv64, __VA_ARGS__)
+
+/*
+ * Original:
+ *   #if defined(TARGET_RISCV32) || \
+ *       (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
+ *
+ * RV32 models on every riscv32 binary, and on system riscv64
+ * (-cpu rv32 / e31 / ibex). Not linux-user riscv64.
+ */
+static bool riscv32_64sys_available(const TargetInfo *ti)
+{
+#ifdef CONFIG_USER_ONLY
+    return target_is_riscv32(ti);
+#else
+    return target_is_base_riscv(ti);
+#endif
+}
+
+#define DEFINE_RISCV_CPU_32_64SYS(type_name, parent_type_name, ...) \
+    DEFINE_RISCV_CPU_AVAIL(type_name, parent_type_name,     \
+                           riscv32_64sys_available, __VA_ARGS__)
+
 #define DEFINE_PROFILE_CPU(type_name, parent_type_name, profile_)    \
-    DEFINE_RISCV_CPU(type_name, parent_type_name,             \
+    DEFINE_RISCV64_CPU(type_name, parent_type_name,             \
         .profile = &(profile_))
 
 static void riscv_cpu_instance_finalize(Object *obj)
@@ -3311,6 +3366,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .class_size = sizeof(RISCVCPUClass),
         .class_init = riscv_cpu_common_class_init,
         .class_base_init = riscv_cpu_class_base_init,
+        .is_available = target_is_base_riscv,
     },
 
     DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU,
@@ -3339,21 +3395,14 @@ static const TypeInfo riscv_cpu_type_infos[] = {
          * only MBARE will be available if the user doesn't enable
          * a mode manually (see riscv_cpu_satp_mode_finalize()).
          */
-#ifdef TARGET_RISCV32
-        .cfg.max_satp_mode = VM_1_10_SV32,
-#else
         .cfg.max_satp_mode = VM_1_10_SV57,
-#endif
+        .target_init = riscv_bare_target_init,
     ),
 
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX, TYPE_RISCV_DYNAMIC_CPU,
-#if defined(TARGET_RISCV32)
-        .misa_mxl_max = MXL_RV32,
-        .cfg.max_satp_mode = VM_1_10_SV32,
-#elif defined(TARGET_RISCV64)
         .misa_mxl_max = MXL_RV64,
         .cfg.max_satp_mode = VM_1_10_SV57,
-#endif
+        .target_init = riscv_max_target_init,
     ),
 
     DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E, TYPE_RISCV_VENDOR_CPU,
@@ -3378,9 +3427,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.pmp_regions = 8
     ),
 
-#if defined(TARGET_RISCV32) || \
-    (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
+    DEFINE_RISCV_CPU_32_64SYS(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV32,
         .misa_mxl_max = MXL_RV32,
 
@@ -3406,7 +3453,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_svvptc = true,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_IBEX, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV_CPU_32_64SYS(TYPE_RISCV_CPU_IBEX, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV32,
         .misa_ext = RVI | RVM | RVC | RVU,
         .priv_spec = PRIV_VERSION_1_12_0,
@@ -3423,37 +3470,35 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_xlrbr = true
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E31, TYPE_RISCV_CPU_SIFIVE_E,
+    DEFINE_RISCV_CPU_32_64SYS(TYPE_RISCV_CPU_SIFIVE_E31, TYPE_RISCV_CPU_SIFIVE_E,
         .misa_mxl_max = MXL_RV32
     ),
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E34, TYPE_RISCV_CPU_SIFIVE_E,
+    DEFINE_RISCV_CPU_32_64SYS(TYPE_RISCV_CPU_SIFIVE_E34, TYPE_RISCV_CPU_SIFIVE_E,
         .misa_mxl_max = MXL_RV32,
         .misa_ext = RVF,  /* IMAFCU */
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U34, TYPE_RISCV_CPU_SIFIVE_U,
+    DEFINE_RISCV_CPU_32_64SYS(TYPE_RISCV_CPU_SIFIVE_U34, TYPE_RISCV_CPU_SIFIVE_U,
         .misa_mxl_max = MXL_RV32,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
+    DEFINE_RISCV_CPU_32_64SYS(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV32,
         .misa_ext = RVI
     ),
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32E, TYPE_RISCV_BARE_CPU,
+    DEFINE_RISCV_CPU_32_64SYS(TYPE_RISCV_CPU_RV32E, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV32,
         .misa_ext = RVE
     ),
-#endif
 
-#if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX32, TYPE_RISCV_DYNAMIC_CPU,
+#ifndef CONFIG_USER_ONLY
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_MAX32, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV32,
         .misa_mxl_max = MXL_RV32,
     ),
 #endif
 
-#if defined(TARGET_RISCV64)
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE64, TYPE_RISCV_DYNAMIC_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_BASE64, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
         .misa_mxl_max = MXL_RV64,
 
@@ -3479,19 +3524,19 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_svvptc = true,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
         .misa_mxl_max = MXL_RV64
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U54, TYPE_RISCV_CPU_SIFIVE_U,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_SIFIVE_U54, TYPE_RISCV_CPU_SIFIVE_U,
         .misa_mxl_max = MXL_RV64,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SHAKTI_C, TYPE_RISCV_CPU_SIFIVE_U,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_SHAKTI_C, TYPE_RISCV_CPU_SIFIVE_U,
         .misa_mxl_max = MXL_RV64,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C906, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_THEAD_C906, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVG | RVC | RVS | RVU,
         .priv_spec = PRIV_VERSION_1_11_0,
@@ -3519,7 +3564,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C908, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_THEAD_C908, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
         .priv_spec = PRIV_VERSION_1_12_0,
@@ -3566,12 +3611,12 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C908V, TYPE_RISCV_CPU_THEAD_C908,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_THEAD_C908V, TYPE_RISCV_CPU_THEAD_C908,
         .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU | RVV,
         .vext_spec = VEXT_VERSION_1_00_0,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_TT_ASCALON, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_TT_ASCALON, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVG | RVC | RVS | RVU | RVH | RVV,
         .priv_spec = PRIV_VERSION_1_13_0,
@@ -3635,7 +3680,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV57,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_VEYRON_V1, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_VEYRON_V1, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVG | RVC | RVS | RVU | RVH,
         .priv_spec = PRIV_VERSION_1_12_0,
@@ -3671,7 +3716,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV48,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVG | RVC | RVB | RVS | RVU,
         .priv_spec = PRIV_VERSION_1_12_0,
@@ -3694,7 +3739,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV39,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_XIANGSHAN_KMH, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_XIANGSHAN_KMH, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVG | RVC | RVB | RVS | RVU | RVH | RVV,
         .priv_spec = PRIV_VERSION_1_13_0,
@@ -3754,7 +3799,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     ),
 
     /* https://mips.com/products/hardware/p8700/ */
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
         .priv_spec = PRIV_VERSION_1_12_0,
@@ -3777,16 +3822,16 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     ),
 
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
         .misa_mxl_max = MXL_RV128,
     ),
 #endif /* CONFIG_TCG */
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV64I, TYPE_RISCV_BARE_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_RV64I, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVI
     ),
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV64E, TYPE_RISCV_BARE_CPU,
+    DEFINE_RISCV64_CPU(TYPE_RISCV_CPU_RV64E, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVE
     ),
@@ -3795,7 +3840,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  TYPE_RISCV_CPU_RV64I,  RVA22S64),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  TYPE_RISCV_CPU_RV64I,  RVA23U64),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23S64,  TYPE_RISCV_CPU_RV64I,  RVA23S64),
-#endif /* TARGET_RISCV64 */
 };
 
 DEFINE_TYPES(riscv_cpu_type_infos)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 034d7e96c49..265c6322067 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -597,6 +597,13 @@ typedef struct RISCVCPUDef {
 #endif
     /* This is just a setter for env->num_triggers.  */
     uint32_t num_triggers;
+
+    /*
+     * Optional per-CPU callback run from riscv_cpu_class_base_init
+     * after the static def is merged. Use it to adjust fields that
+     * depend on the build target (e.g. clamp misa_mxl_max for RV32).
+     */
+    void (*target_init)(struct RISCVCPUClass *mcc);
 } RISCVCPUDef;
 
 /**
-- 
2.52.0.windows.1

