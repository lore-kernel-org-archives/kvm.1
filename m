Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E13152D2D6
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169458; cv=none; b=HmCPAozsB0zAtMWSU0UnLIRbaN/9/sXrB8aK/X2VH+7AFb2PDXQj3A4/5fsDx4WmYT6zoX/hLTSapR+64Lrj3FizQRJhthVQYN33E2vVmlhyCo49dwsv3DxrQiIG1TCBni/me/ZNrHQSklcRKA/EfzPQQZ9taX2zlmk7HGjk1lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169458; c=relaxed/simple;
	bh=j4vie8DKKVIP+U5Ja5oPVn2pj4FSigufkiZYHWZnLWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usXis/5L2/wnPMjsDibFaociQxokes7nmrQgjqPGRwXX1aiW+QBpjDAztPzUfUDv+YzdE1HYkZRMC6ENKC77okpf+1CnGF9afK+jMgOu5zYRrfFB9/g93ZMZ4ZAmFvdKvFSvM/FbCixc63OHdyHbi5iqNfZeZxIrTCn3DlOEVII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cinkT1xe; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cinkT1xe"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664ef783so541157eec.0
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169456; x=1790774256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ElUpYvhknnIwSPfbcSK8wY490g/9t35RPhM2WyomKNg=;
        b=cinkT1xeYBfNuNh8IMUl2ZKMloxqC5Zkb/U9IGnku9KsQUX3ryMBbvO3Cg0EHn+VLL
         /R4eoX/EkfUvMMD7JdhLK36xTZWnKWGWxowzG3ekxA8i9z44o/VG/jaeod7bBSlocvRK
         U+G+mNVv9SDBHroNXmh0YnOwyOX2DZDviKPj41na5uxTECyUxJpjgWLePSnjXw0F6//E
         mk13xloyPZshe7civiPXeYbB8gbbfbt9fNXDWhmbuMK8XRWybO658/WeAHd+7RH5W3QX
         x6g1AMK5orxqydzS9wIsqb7ItMnBTRz0pgqh5yjElw7AnRJV9VhCbAa9Tame4hU1sDBe
         FbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169456; x=1790774256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ElUpYvhknnIwSPfbcSK8wY490g/9t35RPhM2WyomKNg=;
        b=GQjjdjYbl+U4WZQCNIsmHo4+XGMhq17bVkxi2sfqGcUS/JTq/KkNW3WkyogFjgJHFu
         oFiLVGdefrHhAlFe+BZ7eGhosdSeBZUHVRVL6ivYELRdmOY2e7Yzum7ksUBPuJgJ4e0C
         mKpu+ju6n/fwJaZuVLGFI3N7sIJybuw2dqK3gkAnnXV6nkd2iRq2UagGj1EN8qMnw76d
         qXYb6Pzzv/ZyDFgcKK+9R7/7H7iBP/Z+beaVpYAPi14iKUHysPsDSKtkAm1NvwK+v0LN
         i8V8f7uMHmAwBUl1uciJBmespZjdptLMSmHI1+8rLuXX3+erTwUl+8mnyuqcUFlBS/jS
         EM0w==
X-Forwarded-Encrypted: i=1; AKwUvBxEtSsw18CYasLdphcqiZ8kvi0Vu5OP+mVTCRdaSVuZQtAQeAWdEB2XRNiVgbvz+ppTi8g=@vger.kernel.org
X-Gm-Message-State: AFuF++mUXDDiFWAcpgN/Q2bI/FNCiyvmK8mct/ZtlrMlZ6+X/vxn+3R7
	uEDf5muuHN0FVr+IWpyPbjXbaARmR6629lxkkPvG4M6FOjH8LIFGuUJ0
X-Gm-Gg: AYBFou19iggCAemW7WevQ4O80k3S2ebJrmrWiEy/GWEymim9O3VIydM7drkBKgDNTVz
	ljLbehgu6TS9DG8f3OJOuAL9F49TEQLtY4mFL7juV+U/XMkY2vd6i4TFoapm0DVpuOHjjmlYshm
	9zi+nq/x78a5gUvCwvJKM8c9YNMEfC+rKmU3g5jSQ6i4v0xwMYKEt33e8IBGD2Q5zCI/BzSYYk3
	KFQNAOtcGlAuSwLxUS1uPCXSvldpsCCqaBaFvALWdyY5gjDl0M0gOMIjyQBM+uy787IcAM7ll4o
	1F8j1mNEyhKanl+AgaoYzbCKYh/cl3HmUB6H9l8jgAliyVSVnxFkCzc2zZUFeI5tyXcp+c9ZZQI
	MTji2XC9AAvtwVekMm7htC9dWCyuSYa4rEHPQ9m7Sg6UOAglswcrg6kVY7BFYGB80tCm0bsMoWB
	KtVl6VS4vkvoOHwVOCiOwjxiBTzNRaUD1ge6PYjadbCehBCKCTobb7xBTfeHCIHze5u8/Odsjhm
	lQnbHO71v6HcJt0HCG0Wg4vZl6bdllrle8ZdzSXEA==
X-Received: by 2002:a05:7300:b286:b0:30e:f0a5:8762 with SMTP id 5a478bee46e88-33e8d9ca3c8mr2607807eec.19.1790169455486;
        Wed, 23 Sep 2026 06:17:35 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:17:33 -0700 (PDT)
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
Subject: [PATCH v3 005/114] target-info: set cpu_type from TARGET_BASE_ARCH
Date: Wed, 23 Sep 2026 21:14:39 +0800
Message-ID: <20260923131635.1894-6-luoyonggang@gmail.com>
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

target-info-def.c no longer includes cpu.h, so CPU_RESOLVING_TYPE
is unavailable. Emit TARGET_BASE_ARCH as an uppercase identifier in
config-target.h and set cpu_type to TYPE_${TARGET_BASE_ARCH}_CPU.

Alias the base-arch tokens whose QOM name differs: TYPE_I386_CPU,
TYPE_OR1K_CPU, TYPE_PPC_CPU, TYPE_S390X_CPU, and TYPE_SH4_CPU.

Drop the ArchCPU parent_obj and env offsetof checks with the cpu.h
include. Page-size checks stay, via cpu-param.h.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info-def.h |  2 +-
 meson.build                    |  1 +
 target-info-def.c              | 11 +++--------
 target/i386/cpu-qom.h          |  1 +
 target/or1k/cpu-qom.h          |  1 +
 target/ppc/cpu-qom.h           |  1 +
 target/s390x/cpu-qom.h         |  1 +
 target/sh4/cpu-qom.h           |  1 +
 8 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/qemu/target-info-def.h b/include/qemu/target-info-def.h
index 8019d2c7196..ebd88463aea 100644
--- a/include/qemu/target-info-def.h
+++ b/include/qemu/target-info-def.h
@@ -19,7 +19,7 @@ typedef struct TargetInfo {
     SysEmuTarget target_arch;
     /* runtime equivalent of TARGET_LONG_BITS definition */
     unsigned long_bits;
-    /* runtime equivalent of CPU_RESOLVING_TYPE definition */
+    /* runtime equivalent of TYPE_${TARGET_BASE_ARCH}_CPU definition */
     const char *cpu_type;
     /* related to TARGET_BIG_ENDIAN definition */
     EndianMode endianness;
diff --git a/meson.build b/meson.build
index 8bd2d725ca0..20345860c9f 100644
--- a/meson.build
+++ b/meson.build
@@ -3378,6 +3378,7 @@ foreach target : target_dirs
       # Note that TARGET_BASE_ARCH ends up in config-target.h but it is
       # not used to select files from sourcesets.
       config_target_data.set('TARGET_' + v.to_upper(), 1)
+      config_target_data.set(k, v.to_upper())
     elif k == 'TARGET_NAME' or k == 'CONFIG_QEMU_INTERP_PREFIX'
       config_target_data.set_quoted(k, v)
     elif v == 'y'
diff --git a/target-info-def.c b/target-info-def.c
index fa19cabc55f..f167f5f2ac1 100644
--- a/target-info-def.c
+++ b/target-info-def.c
@@ -10,15 +10,10 @@
 #include "qemu/target-info.h"
 #include "qemu/target-info-def.h"
 #include "qemu/target-info-init.h"
-#include "hw/core/boards.h"
-#include "cpu.h"
-#include "exec/cpu-defs.h"
+#include "cpu-qom.h"
+#include "cpu-param.h"
 #include "exec/page-vary.h"
 
-/* Validate correct placement of CPUArchState. */
-QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
-QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
-
 /* Validate target page size, if invariant. */
 #ifndef TARGET_PAGE_BITS_VARY
 QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
@@ -28,7 +23,7 @@ static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
     .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),
     .long_bits = TARGET_LONG_BITS,
-    .cpu_type = CPU_RESOLVING_TYPE,
+    .cpu_type = glue(TYPE_, glue(TARGET_BASE_ARCH, _CPU)),
     .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
 #ifdef TARGET_PAGE_BITS_VARY
     .page_bits_vary = true,
diff --git a/target/i386/cpu-qom.h b/target/i386/cpu-qom.h
index d4e216d000c..7619c4a4826 100644
--- a/target/i386/cpu-qom.h
+++ b/target/i386/cpu-qom.h
@@ -27,6 +27,7 @@
 #else
 #define TYPE_X86_CPU "i386-cpu"
 #endif
+#define TYPE_I386_CPU TYPE_X86_CPU
 
 OBJECT_DECLARE_CPU_TYPE(X86CPU, X86CPUClass, X86_CPU)
 
diff --git a/target/or1k/cpu-qom.h b/target/or1k/cpu-qom.h
index 14bac33312e..c0d5e9e81ba 100644
--- a/target/or1k/cpu-qom.h
+++ b/target/or1k/cpu-qom.h
@@ -12,6 +12,7 @@
 #include "hw/core/cpu.h"
 
 #define TYPE_OPENRISC_CPU "or1k-cpu"
+#define TYPE_OR1K_CPU TYPE_OPENRISC_CPU
 
 OBJECT_DECLARE_CPU_TYPE(OpenRISCCPU, OpenRISCCPUClass, OPENRISC_CPU)
 
diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index 8247fa23367..428cdc85488 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -28,6 +28,7 @@
 #else
 #define TYPE_POWERPC_CPU "powerpc-cpu"
 #endif
+#define TYPE_PPC_CPU TYPE_POWERPC_CPU
 
 OBJECT_DECLARE_CPU_TYPE(PowerPCCPU, PowerPCCPUClass, POWERPC_CPU)
 
diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
index c59bb1eab15..07a8c881fe5 100644
--- a/target/s390x/cpu-qom.h
+++ b/target/s390x/cpu-qom.h
@@ -23,6 +23,7 @@
 #include "hw/core/cpu.h"
 
 #define TYPE_S390_CPU "s390x-cpu"
+#define TYPE_S390X_CPU TYPE_S390_CPU
 
 OBJECT_DECLARE_CPU_TYPE(S390CPU, S390CPUClass, S390_CPU)
 
diff --git a/target/sh4/cpu-qom.h b/target/sh4/cpu-qom.h
index 6cf5fbb0745..08fa92106e9 100644
--- a/target/sh4/cpu-qom.h
+++ b/target/sh4/cpu-qom.h
@@ -23,6 +23,7 @@
 #include "hw/core/cpu.h"
 
 #define TYPE_SUPERH_CPU "superh-cpu"
+#define TYPE_SH4_CPU TYPE_SUPERH_CPU
 
 #define TYPE_SH7750R_CPU SUPERH_CPU_TYPE_NAME("sh7750r")
 #define TYPE_SH7751R_CPU SUPERH_CPU_TYPE_NAME("sh7751r")
-- 
2.52.0.windows.1

