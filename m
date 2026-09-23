Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8795304AD
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169550; cv=none; b=JjcKcsNlmozeNU/9XpVWNNqg2Ij482nMdbCI1WWbJst9OHlCPjJJZFDHpxuT2xF5zBKuLnkBcyoX4UIBzKGWM7uxwWpd9nJTJ7ue/60OUsIusdAGKOxtDhUC79mFyhsrlkqhmrxUfKcn+1vsu12LmlppDGC0qqqAJ7iEWVV2pgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169550; c=relaxed/simple;
	bh=EZnpX/rnKIBA3Cfkh6M6KG8FaFGRqrO5+Kt/dwL8R9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CydYbn2Ds+Zb54weSoDxS9qj/R6lTyOm7zvLSFaPIPhhoe7bssIgt+RXgPnG7sJic4kYp3PAemyuGQJ/n47q+LNjtUOUgjEd1yvQAyb6ObNpCnTuX6I9T//WtDxkr17I1BZ7VDmNH25l7g2yiQ2NxAMA/9jKpyoLXQpAjNIxhnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pj4tfHJY; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj4tfHJY"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-144f9160b81so327267c88.0
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169540; x=1790774340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Pnb4009fcr63720pQihUF6v8EokAjQS6rcfppqNlzc=;
        b=Pj4tfHJYE4v4bEQvVSrpouwdPE2npof98yflrJfKLT5MXcoTacKCUl0nvrTtk1ocLf
         2nqCFhVt8TIsMkzCWcRX9m5rNCzXHgPxMR8FJUoTdHVs07lCO0jUNBS9C3MTPq84cZ9c
         3XQvulassxusbzJtTv60LvfghZg5HbmIqorCuOHwjawXbOFGcbpiqWGn/HHq/I6QcxRs
         vJtTAZ1pohluTa5FP76vwWLqNX8I43gQfea+/6WSdlvJ3JcbCeu4ofIP74gcZRsDP94U
         nV+rlFtL1uloVYxobXxLUUevP5idruZjdPgnVacXf6DKZPwOKLT83OMUHWbCUW4uO9i9
         YWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169540; x=1790774340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Pnb4009fcr63720pQihUF6v8EokAjQS6rcfppqNlzc=;
        b=oY52T6ZT995rnz6ooWWnGDfFJ1O1YlyXkSrFipEwh/WF4TQecaqbXsiwMpmAkGx1AA
         Iy9lXp3WBsh7+GMNKvKTxm0lASOUc2Pts0gsK0CD3FnBHGtVoyW61LqANJWJEm4l2cDv
         say8nb0bnQaAzCRMHedHp2Ji6Uo4nUdlkpMVPcgBQ7GbxWCd4EiGy1/Km1+W5K8Dlhri
         B8WMqMitWtsK9FdHBiYcCi1cBZYAS22coh8B14r+MbnRchUriYXq9kL3XmHiHY0QeprM
         4Ms5RQe/IfmiiwPXIcwroVdPqwKx1ZZrZ0KKn+mtYNs4EDbIXGXoBWj6Ncqhyo6WFyIj
         qrew==
X-Forwarded-Encrypted: i=1; AKwUvByDSnBX+In+G84MBLUtORnoIMZ+DRBdK3R3KoFlqge9WJ8qpCMw780SYfA5i8Uhxntm5fA=@vger.kernel.org
X-Gm-Message-State: AFuF++mMFyD4kh0vmp1FIZn4FPc9NAKsoyzCwtgSzjI87giKYn5elHBW
	u2DAVrUkdFu/FdusWZVHkQWekHHC8BuzMDMO+saCaQTTaQzk4bvDIP6T
X-Gm-Gg: AYBFou1LawtzYCtvHygIyxfgAQEgGCj/NnbOpA6qwT/QWNq297oC2sPH2G7/wAbOJRA
	X5y9o+eH2Cv9htMa4Vy3qYodDllY0yuM5psXRCsyeMv3G4jEV4iHhv+/F07Ug4xGKElTqp0h6PI
	RzvLhwKVRBFXDJ3NSmqje8lrzSy1JiAS/JhuRZjp8NdcTPH7PlsfZyMtnkeGzbfEK7hhELyiW/w
	RJwgdLapUzuuB7lvbai3s0ZlwceQZ6Qu07PafCjYwycYmpFUOrratOqGc5fz9rCbjuSuGZ65Mbj
	Qw5FhvrmsspLsBSQHRcqUNWX7f/5iv3PXVO+3bwVv4aMXl31rkVplwXpGatpS/TwIVGQLlm5cbM
	GrmjiIAcJirfeyt3oVQMuvqzmTm97QAoWs5ewGShH2VwDN5ww1LpC/HKDqMROYJFe3ZPEYBAp/S
	v4SN63fP+LYiQwKvCvmIJuAcYOC41JQ3H2B+K0D9FWsVhm1Zpx3EV47Au2/lOVi6ET3TaKLfgwE
	XhlPorP/yXTtcfIoRScBbszw5gTubA=
X-Received: by 2002:a05:7022:fa9:b0:143:2973:3240 with SMTP id a92af1059eb24-144f91551e9mr4241198c88.29.1790169539996;
        Wed, 23 Sep 2026 06:18:59 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:18:58 -0700 (PDT)
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
Subject: [PATCH v3 013/114] target-info: add target_is_* helpers for each architecture
Date: Wed, 23 Sep 2026 21:14:47 +0800
Message-ID: <20260923131635.1894-14-luoyonggang@gmail.com>
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

This is added for latter use with is_available.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info.h | 91 +++++++++++++++++++++++++++++++++++++-
 target-info.c              | 83 +++++++++++++++++++++++++++++-----
 2 files changed, 161 insertions(+), 13 deletions(-)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index c48973f20be..89656da1ca4 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -53,6 +53,14 @@ const char *target_cpu_type(void);
  */
 bool target_big_endian(void);
 
+/**
+ * target_is_base_arm:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is ARM or Aarch64.
+ */
+bool target_is_base_arm(const TargetInfo *ti);
+
 /**
  * target_base_arm:
  *
@@ -60,6 +68,14 @@ bool target_big_endian(void);
  */
 bool target_base_arm(void);
 
+/**
+ * target_is_arm:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is ARM (32-bit, not Aarch64).
+ */
+bool target_is_arm(const TargetInfo *ti);
+
 /**
  * target_arm:
  *
@@ -67,6 +83,14 @@ bool target_base_arm(void);
  */
 bool target_arm(void);
 
+/**
+ * target_is_aarch64:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is Aarch64.
+ */
+bool target_is_aarch64(const TargetInfo *ti);
+
 /**
  * target_aarch64:
  *
@@ -74,6 +98,14 @@ bool target_arm(void);
  */
 bool target_aarch64(void);
 
+/**
+ * target_is_base_ppc:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is PowerPC 32-bit or 64-bit.
+ */
+bool target_is_base_ppc(const TargetInfo *ti);
+
 /**
  * target_base_ppc:
  *
@@ -81,6 +113,14 @@ bool target_aarch64(void);
  */
 bool target_base_ppc(void);
 
+/**
+ * target_is_ppc:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is PowerPC 32-bit.
+ */
+bool target_is_ppc(const TargetInfo *ti);
+
 /**
  * target_ppc:
  *
@@ -88,6 +128,14 @@ bool target_base_ppc(void);
  */
 bool target_ppc(void);
 
+/**
+ * target_is_ppc64:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is PowerPC 64-bit.
+ */
+bool target_is_ppc64(const TargetInfo *ti);
+
 /**
  * target_ppc64:
  *
@@ -95,6 +143,14 @@ bool target_ppc(void);
  */
 bool target_ppc64(void);
 
+/**
+ * target_is_s390x:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is S390x.
+ */
+bool target_is_s390x(const TargetInfo *ti);
+
 /**
  * target_s390x:
  *
@@ -102,17 +158,48 @@ bool target_ppc64(void);
  */
 bool target_s390x(void);
 
+/**
+ * target_is_base_riscv:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is RISC-V 32-bit or 64-bit.
+ */
+bool target_is_base_riscv(const TargetInfo *ti);
+
+/**
+ * target_base_riscv:
+ *
+ * Returns whether the target architecture is RISC-V 32-bit or 64-bit.
+ */
+bool target_base_riscv(void);
+
+/**
+ * target_is_riscv32:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is RISC-V 32-bit.
+ */
+bool target_is_riscv32(const TargetInfo *ti);
+
 /**
  * target_riscv32:
  *
- * Returns whether the target architecture is riscv32
+ * Returns whether the target architecture is RISC-V 32-bit.
  */
 bool target_riscv32(void);
 
+/**
+ * target_is_riscv64:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is RISC-V 64-bit.
+ */
+bool target_is_riscv64(const TargetInfo *ti);
+
 /**
  * target_riscv64:
  *
- * Returns whether the target architecture is riscv64
+ * Returns whether the target architecture is RISC-V 64-bit.
  */
 bool target_riscv64(void);
 
diff --git a/target-info.c b/target-info.c
index 6e66f48e1ff..6d57cad5d33 100644
--- a/target-info.c
+++ b/target-info.c
@@ -96,9 +96,9 @@ bool target_big_endian(void)
     return target_endian_mode() == ENDIAN_MODE_BIG;
 }
 
-bool target_base_arm(void)
+bool target_is_base_arm(const TargetInfo *ti)
 {
-    switch (target_arch()) {
+    switch (ti->target_arch) {
     case SYS_EMU_TARGET_ARM:
     case SYS_EMU_TARGET_AARCH64:
         return true;
@@ -107,19 +107,34 @@ bool target_base_arm(void)
     }
 }
 
+bool target_base_arm(void)
+{
+    return target_is_base_arm(target_info());
+}
+
+bool target_is_arm(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_ARM;
+}
+
 bool target_arm(void)
 {
-    return target_arch() == SYS_EMU_TARGET_ARM;
+    return target_is_arm(target_info());
+}
+
+bool target_is_aarch64(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_AARCH64;
 }
 
 bool target_aarch64(void)
 {
-    return target_arch() == SYS_EMU_TARGET_AARCH64;
+    return target_is_aarch64(target_info());
 }
 
-bool target_base_ppc(void)
+bool target_is_base_ppc(const TargetInfo *ti)
 {
-    switch (target_arch()) {
+    switch (ti->target_arch) {
     case SYS_EMU_TARGET_PPC:
     case SYS_EMU_TARGET_PPC64:
         return true;
@@ -128,27 +143,73 @@ bool target_base_ppc(void)
     }
 }
 
+bool target_base_ppc(void)
+{
+    return target_is_base_ppc(target_info());
+}
+
+bool target_is_ppc(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_PPC;
+}
+
 bool target_ppc(void)
 {
-    return target_arch() == SYS_EMU_TARGET_PPC;
+    return target_is_ppc(target_info());
+}
+
+bool target_is_ppc64(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_PPC64;
 }
 
 bool target_ppc64(void)
 {
-    return target_arch() == SYS_EMU_TARGET_PPC64;
+    return target_is_ppc64(target_info());
+}
+
+bool target_is_s390x(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_S390X;
 }
 
 bool target_s390x(void)
 {
-    return target_arch() == SYS_EMU_TARGET_S390X;
+    return target_is_s390x(target_info());
+}
+
+bool target_is_base_riscv(const TargetInfo *ti)
+{
+    switch (ti->target_arch) {
+    case SYS_EMU_TARGET_RISCV32:
+    case SYS_EMU_TARGET_RISCV64:
+        return true;
+    default:
+        return false;
+    }
+}
+
+bool target_base_riscv(void)
+{
+    return target_is_base_riscv(target_info());
+}
+
+bool target_is_riscv32(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_RISCV32;
 }
 
 bool target_riscv32(void)
 {
-    return target_arch() == SYS_EMU_TARGET_RISCV32;
+    return target_is_riscv32(target_info());
+}
+
+bool target_is_riscv64(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_RISCV64;
 }
 
 bool target_riscv64(void)
 {
-    return target_arch() == SYS_EMU_TARGET_RISCV64;
+    return target_is_riscv64(target_info());
 }
-- 
2.52.0.windows.1

