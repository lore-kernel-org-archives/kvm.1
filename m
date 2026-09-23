Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247FB24DD17
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169453; cv=none; b=uEty4CuV9V1w0LDSSN9sddzd2KmVVEb4fx1xAyD9CTWNCXS9cJ8nAp4KFedjCqUSz/4ES9kDU6Ml4oRwxwcvAYuAQsNnrwFjpl+Matb9/2fhPThmihRiBhuiv2MVUb9aSJi3fG+6MVtHQFMT3ZfgDqZ7LYocQ2+tfYAmbPiKYB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169453; c=relaxed/simple;
	bh=bd8mgaG+qvquP+2clWMKiUl2nXg5ZFJBVTRodzsU0bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLBOx9+RPvBhugX5O3jKRWgMoiHRAMtd2D1BH2nsywZBEVSn4Xh9fmURJ8BSBu5TWb7DtluIrfVf3hxVivbj9OikX8aKREjW4vBdrU3dHXhZ6dZoR4/pHFYhhGmdQ965mpdpRAilWFMvFnvMJ2jai1GFbxu8dC4o66eWQYazGg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2MG05T3; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2MG05T3"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e652b7178so487530eec.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169451; x=1790774251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qkiRWh0yDSkP2OT8vLUxuaEaTt8B1WJVNLebJyYrgq0=;
        b=K2MG05T3MdLm3n1ygoPozLaQfSw/cZnN9K5s3+2ZaSJDfhnzXSJYd/ps3UJ28JJqW4
         KQkotf0XuYYYX/0QXTgkUzSok9ON8OiHllHBCJP66rdJ/2Zkv/8dYT7lROUl+bgsJGFV
         1gpko3zfeHLTAu5c1N0193ntR/SU9G1wTgevsbMKo1OYAqwl4ydgbsrqgwVGUp9tFXsr
         Y/bEobYW2LwUaItwP2zkLC3V3nb2BOv1gSzrz36mBd8SrymsneGXUyvWLNi1DOZAqGpQ
         rdJ/65cVB9GUl5AY02gplknh0uMW9TDRlAlM09fB53NRkfmvPBuUPEKmfKvan+pPk7Vo
         g/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169451; x=1790774251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qkiRWh0yDSkP2OT8vLUxuaEaTt8B1WJVNLebJyYrgq0=;
        b=Qcp19eBz1OB6ve30u1ZIsSxPOTjZpG1hp0xxTGHAX4lGLLaniG44KavNa4zI8MYP0v
         QpsD68JNd9zy0x633ZXEOTgvpi5WE6Rmuc8d7VecSyrCtLVu8LmeVL0ZuBNEF38aHPap
         JW2GIEEmenoj8INDpgMMsgWRH6xraU4YkRRonOZpJnUM1L7ugfZjceXikxRBMBuuprMO
         oEnqIc6EnL07YuXTljVDursonQa9flLTYwgGACdElfpbBTkyrYWbuP86QCp+5NPv/6LV
         JENFaFdrZNzLMytKByN9IK963O+Ci578VtFPVdVt38V6NS7u8XEFvJHv10wEHrU989In
         zLLg==
X-Forwarded-Encrypted: i=1; AKwUvBzksJE8VxaQwhfSAegZ8mrBxfZUHrdmyjhFju8sXdo0lbgoo4fsq5OcXDTPQgLZXUbFOQ8=@vger.kernel.org
X-Gm-Message-State: AFuF++kp9pf/QSdyTB/jCDSSWQR+qkC6eBujWYTkx73wRsNvh4BWFL9t
	ET0CEO3aKarkUZska8sic/ErE2UDEwaBd13xZPAPlYcXee5FsTvjds0p
X-Gm-Gg: AYBFou3+T3tFEcntgscWMN6TckkXFAq4Hv25szknESX4aVn8sx9N8hOVVUCwvzDNlZk
	VTFcsLAxteOCfWVsE08FPboFdePRcAuX/j11FWjYT7Qz0t3C/UX39IhInP40wQ8HujIJ4nrvzBx
	s3VCGDQ1sjxOMckldJgUrDTYpZ2sJL1Zwy9UjvwQpA8Y1Jkn8IICO+MSG+L1vlfxdcuEWeL94eK
	wHV3uqCicQh+XYfMDdO6irNBjzBxgeImUJtwr2k8ZN1Vu5rrRr9oJY4J0uOC89j8E6/GzytB85V
	zx0b3pGtck5Ifwmu4U08YSC5E0DuZXdyXzEkrrX9OccXCXiZ1yT3YaiPWlDi8sWCc+l4Srm6H6P
	bOP1J5AxWUkh/X9mRemtJWo1GbSA11gVpxiJ6k+9yb2GteRhP/QpcOXWsTnEjOJbsKkpT5TwUQD
	kKTJQpzNjui+TR+pa1LeoA3vS21IpzJW+Eci5BxjfemG3O6Vc/5biaFwCuuJ5UzqRdxeMYl8STE
	i7VVGF1BR8bqF+LnarrFU+H3W+Z5PM=
X-Received: by 2002:a05:693c:228f:b0:33c:3134:1055 with SMTP id 5a478bee46e88-33e8c53b899mr2375553eec.12.1790169445480;
        Wed, 23 Sep 2026 06:17:25 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:17:23 -0700 (PDT)
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
Subject: [PATCH v3 004/114] target-info: rename target-info-impl.h to target-info-def.h
Date: Wed, 23 Sep 2026 21:14:38 +0800
Message-ID: <20260923131635.1894-5-luoyonggang@gmail.com>
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

Rename the TargetInfo structure header and its include guard.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/{target-info-impl.h => target-info-def.h} | 4 ++--
 include/qemu/target-info-qom.h                         | 2 +-
 page-vary-common.c                                     | 2 +-
 page-vary-system.c                                     | 2 +-
 target-info-def.c                                      | 2 +-
 target-info-qom.c                                      | 2 +-
 target-info.c                                          | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)
 rename include/qemu/{target-info-impl.h => target-info-def.h} (94%)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-def.h
similarity index 94%
rename from include/qemu/target-info-impl.h
rename to include/qemu/target-info-def.h
index cf42aabbc8b..8019d2c7196 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-def.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef QEMU_TARGET_INFO_IMPL_H
-#define QEMU_TARGET_INFO_IMPL_H
+#ifndef QEMU_TARGET_INFO_DEF_H
+#define QEMU_TARGET_INFO_DEF_H
 
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-types-machine.h"
diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
index 91be415ed33..0f6772e65c3 100644
--- a/include/qemu/target-info-qom.h
+++ b/include/qemu/target-info-qom.h
@@ -9,7 +9,7 @@
 #ifndef QEMU_TARGET_INFO_QOM_H
 #define QEMU_TARGET_INFO_QOM_H
 
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 #include "qom/object.h"
 
 #define TYPE_TARGET_INFO "target-info"
diff --git a/page-vary-common.c b/page-vary-common.c
index ddd08633788..5a4654725a8 100644
--- a/page-vary-common.c
+++ b/page-vary-common.c
@@ -20,7 +20,7 @@
 #define IN_PAGE_VARY 1
 
 #include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 #include "exec/page-vary.h"
 
 /* WARNING: This file must *not* be complied with -flto. */
diff --git a/page-vary-system.c b/page-vary-system.c
index 6c49c10e23b..9773685dc16 100644
--- a/page-vary-system.c
+++ b/page-vary-system.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "exec/page-vary.h"
 #include "exec/tlb-flags.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 
 QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & ((1u < TARGET_PAGE_BITS_MIN) - 1));
 
diff --git a/target-info-def.c b/target-info-def.c
index d121b8c0170..fa19cabc55f 100644
--- a/target-info-def.c
+++ b/target-info-def.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 #include "qemu/target-info-init.h"
 #include "hw/core/boards.h"
 #include "cpu.h"
diff --git a/target-info-qom.c b/target-info-qom.c
index 6965e4d1169..2b38673a3f8 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qom/object.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 #include "qemu/target-info-init.h"
 #include "qemu/target-info-qom.h"
 
diff --git a/target-info.c b/target-info.c
index bba4503151a..9abe72b1f55 100644
--- a/target-info.c
+++ b/target-info.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
 #include "qemu/target-info-qapi.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 #include "qapi/error.h"
 
 const char *target_name(void)
-- 
2.52.0.windows.1

