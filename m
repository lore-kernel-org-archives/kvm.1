Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E08D5304BF
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169798; cv=none; b=j7tFR769irjZOeJJThJO1toteAwBP0bjWC+ldNzf2wgPdvJR6/bKlqYayXkMA5dzKH4z5bXG0RhPho8DfcQR7QYmdYhCLLl2xy2xouO7WnRU8VVX0VUFRJldvNKuEWgIBNChZkoSDRjYz+E9UxmAQ0Fd3laNxkRYD5SEKNSb1yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169798; c=relaxed/simple;
	bh=qIgFEcL6rVN+KaA4mdQZ2ONpp6IAu+Jf8m0tCi8Eadw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSn8rEV2Pb7CemYZdL3YwcOIKk0mUf8CwelHtGqS+EROZkhjA0GVN6XvdlQZWrFJzRkQzp9GsjAAODp93H9NPmjGWCaN5C5IH3oRoe8I0pcHmKcXDqNNK0PfFQgwCBcXXhblz5QWrdUAWVVJBSImyiFzUSSbtHwHxOEa/Q1ASEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qw+46yTH; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw+46yTH"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e62211987so1029784eec.2
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169795; x=1790774595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a+vM4VKx04YtiIcob+lp3bwuPAlEC1anahMCoo6i89k=;
        b=Qw+46yTH7jgxwomdpo1D9NBFG7HUvts5pHJ0xu5cKRfhmHHFP3byVZZdbjxfZZbjdn
         KmdcgN/NvSm4YZoyDxD9Kzkv1StNOiWxTTHr8cGJqv+OsiY1M7rnKfIP3iZ/dIlJ0wgF
         0MNjvlcnS0IMvU3ojqivAQZQJSyUPI3evXN+4yi8GaNmbuKs9WtHAtT5eVbaQWQs1Nwt
         diIoq9LNbuv/nX5L2jAwgs+3r3ZLHORDNT9k5mIhpaLUISU+3KpZCWJuCIgLdFoCQLY8
         y+53lBKxeaBQTgygrDGVcFMAffOuEbdJC8OaHd2W9DvCfPGKyU8IUNKH1X2TE67oqT2D
         67Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169795; x=1790774595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a+vM4VKx04YtiIcob+lp3bwuPAlEC1anahMCoo6i89k=;
        b=MpNmQbiKsg00CQNzPIKq/Oe9k3o7ZpBZrC69uMjzlI0bPlOIF5nLTMfXDMmDkbOpo1
         crlZMUf6bHNnVY/QkNFlrXMXrSYEXAskIANEBegQNIhxQzVsXG0lyBZ85Eyyh/ACIWoz
         i/LMYXMP3bWXx1mT2FYEeq4U1unKg7IS/OE2VbZL01leQiOoIDMN18LaWTSq5gKlr8cK
         eLQZ7IhKoR2PLPf8yOsyBF/JAaUabj4BhgVnY1tDT1MyHJ2sv0AhIyFQBCmdIBAFWOHg
         frJccGL3ZAAd3tft8MN4Lcz3kjrsnSN8NRlPVR7rQrS+4aFX2chQJmB1eWUYcpssln1a
         kilA==
X-Forwarded-Encrypted: i=1; AKwUvBz3/th0oQ5nHI5dab7Unak7+7vQy7/j+AHmlqGfNzzlqTGZV7r6sb0igA7HwigWdGQ1Vu0=@vger.kernel.org
X-Gm-Message-State: AFuF++lXNidMS5Y5C+0puQqDwTi4o3asTwmofl7+Q2UIZY1Q1yFipoI2
	GuzUgoXYKMTAsUeBLFwWYrQeue2ueiHvD6XCmrCbXj6y7Dj7kvkJfYLU
X-Gm-Gg: AYBFou0kjchQu1s/8HctrKJ8D0yJo04tqLa26qWPeuiO+pSsmF+74iQ9FMpr19lUCUY
	uCLOlD0PR896INjTPxAZtFO/3Cu1oFnx8IutINf8C3C/o5c1PiY+8qBYAl8ViYEQoPvQ61MCstj
	blqMo2nWFJAKo3mW4SDoIrLfvXDn6bK7/N3KKGhfRJlR9D0ZIixPqPmx460HF6d3ApSff6ys3nS
	m0nY6wSg7+SDBTLdOKRzM7BygqxyGhXuYsgd5PDozY6PN7YebZVwqqAQCqv7hwQdRvubDWl5gCq
	5bw1qrAYn7pzuMymtN6j7M/ZVvwdnEXTlUX+GxLeCvf+f3Oq/tYCwC5cGuinNMYfx0HxHwnLeGP
	tbElez3qKVwvLvxcKrl8ldVJqbczvPQGK8ldwwo4HJSECbhzHE8ArZuXs5rYeM62HLAlxeD/Xv7
	N8XRpdinjAZg9U9x3XlCzvRhjqT6w+vShF6TNgpc7a+teukNmPH/hAUe+dmKNEl9X3lEqP5dZEc
	wiX8ZtkReJqek+TZ00nXQJnClFDaj927WEeDXalwQ==
X-Received: by 2002:a05:7300:3e91:b0:327:affc:b506 with SMTP id 5a478bee46e88-33e8c72c478mr2326450eec.15.1790169794702;
        Wed, 23 Sep 2026 06:23:14 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:23:13 -0700 (PDT)
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
Subject: [PATCH v3 039/114] target/riscv: preserve signed XLEN semantics without target_long
Date: Wed, 23 Sep 2026 21:15:13 +0800
Message-ID: <20260923131635.1894-40-luoyonggang@gmail.com>
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

- Mask pointer-masked addresses with extract64/sextract64 at
  runtime XLEN instead of a target_long arithmetic shift.
- Pass vector vx scalars as int64_t after sextract64 from the
  helper tl slot so RV32 keeps bit 31 as the sign bit.
- Leave every target_ulong helper argument unchanged.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/internals.h            | 12 ++++++++----
 target/riscv/tcg/vector_helper.c    | 21 +++++++++++----------
 target/riscv/tcg/vector_internals.c |  2 +-
 target/riscv/tcg/vector_internals.h |  9 +++++----
 4 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 1ee7e99e988..0844867246d 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -214,6 +214,7 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
 {
     RISCVPmPmm pmm = PMM_FIELD_DISABLED;
     uint32_t pmlen = 0;
+    unsigned kept;
     bool signext = false;
 
     /* do nothing for rv32 mode */
@@ -235,13 +236,16 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
 
     signext = riscv_cpu_virt_mem_enabled(env, is_virt_addr);
     pmlen = riscv_pm_get_pmlen(pmm);
-    addr = addr << pmlen;
 
-    /* sign/zero extend masked address by N-1 bit */
+    /*
+     * Drop the top pmlen bits of XLEN. Do not rely on target_ulong
+     * shift wrap; common-system target_ulong is always 64 bits.
+     */
+    kept = target_long_bits() - pmlen;
     if (signext) {
-        addr = (target_long)addr >> pmlen;
+        addr = sextract64(addr, 0, kept);
     } else {
-        addr = addr >> pmlen;
+        addr = extract64(addr, 0, kept);
     }
 
     return addr;
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 0d1e4e09646..0b78a733ce4 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -1248,7 +1248,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                               \
         ETYPE carry = vext_elem_mask(v0, i);                             \
                                                                          \
-        *((ETYPE *)vd + H(i)) = DO_OP(s2, (ETYPE)(target_long)s1, carry);\
+        *((ETYPE *)vd + H(i)) = DO_OP(s2, (ETYPE)sextract64(s1, 0, target_long_bits()), carry);\
     }                                                                    \
     env->vstart = 0;                                                     \
     /* set tail elements to 1s */                                        \
@@ -1325,7 +1325,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                      \
         ETYPE carry = !vm && vext_elem_mask(v0, i);             \
         vext_set_elem_mask(vd, i,                               \
-                DO_OP(s2, (ETYPE)(target_long)s1, carry));      \
+                DO_OP(s2, (ETYPE)sextract64(s1, 0, target_long_bits()), carry));      \
     }                                                           \
     env->vstart = 0;                                            \
     /*
@@ -1609,7 +1609,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
             continue;                                               \
         }                                                           \
         vext_set_elem_mask(vd, i,                                   \
-                DO_OP(s2, (ETYPE)(target_long)s1));                 \
+                DO_OP(s2, (ETYPE)sextract64(s1, 0, target_long_bits())));                 \
     }                                                               \
     env->vstart = 0;                                                \
     /*
@@ -2050,7 +2050,7 @@ GEN_VEXT_VV(vnmsub_vv_w, 4)
 GEN_VEXT_VV(vnmsub_vv_d, 8)
 
 #define OPIVX3(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)             \
-static void do_##NAME(void *vd, target_long s1, void *vs2, int i)   \
+static void do_##NAME(void *vd, int64_t s1, void *vs2, int i)   \
 {                                                                   \
     TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
     TD d = *((TD *)vd + HD(i));                                     \
@@ -2246,7 +2246,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
     for (i = env->vstart; i < vl; i++) {                             \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                           \
         ETYPE d = (!vext_elem_mask(v0, i) ? s2 :                     \
-                   (ETYPE)(target_long)s1);                          \
+                   (ETYPE)sextract64(s1, 0, target_long_bits()));                          \
         *((ETYPE *)vd + H(i)) = d;                                   \
     }                                                                \
     env->vstart = 0;                                                 \
@@ -2397,12 +2397,12 @@ GEN_VEXT_VV_RM(vsaddu_vv_h, 2)
 GEN_VEXT_VV_RM(vsaddu_vv_w, 4)
 GEN_VEXT_VV_RM(vsaddu_vv_d, 8)
 
-typedef void opivx2_rm_fn(void *vd, target_long s1, void *vs2, int i,
+typedef void opivx2_rm_fn(void *vd, int64_t s1, void *vs2, int i,
                           CPURISCVState *env, uint8_t vxrm);
 
 #define OPIVX2_RM(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)          \
 static inline void                                                  \
-do_##NAME(void *vd, target_long s1, void *vs2, int i,               \
+do_##NAME(void *vd, int64_t s1, void *vs2, int i,               \
           CPURISCVState *env, uint8_t vxrm)                         \
 {                                                                   \
     TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
@@ -2410,7 +2410,7 @@ do_##NAME(void *vd, target_long s1, void *vs2, int i,               \
 }
 
 static inline void
-vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
+vext_vx_rm_1(void *vd, void *v0, int64_t s1, void *vs2,
              CPURISCVState *env,
              uint32_t vl, uint32_t vm, uint8_t vxrm,
              opivx2_rm_fn *fn, uint32_t vma, uint32_t esz)
@@ -2427,7 +2427,7 @@ vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
 }
 
 static inline void
-vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
+vext_vx_rm_2(void *vd, void *v0, int64_t s1, void *vs2,
              CPURISCVState *env,
              uint32_t desc,
              opivx2_rm_fn *fn, uint32_t esz)
@@ -2468,7 +2468,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
                   void *vs2, CPURISCVState *env,          \
                   uint32_t desc)                          \
 {                                                         \
-    vext_vx_rm_2(vd, v0, s1, vs2, env, desc,              \
+    vext_vx_rm_2(vd, v0, sextract64(s1, 0, target_long_bits()), \
+                 vs2, env, desc,                          \
                  do_##NAME, ESZ);                         \
 }
 
diff --git a/target/riscv/tcg/vector_internals.c b/target/riscv/tcg/vector_internals.c
index b490b1d3989..95327052666 100644
--- a/target/riscv/tcg/vector_internals.c
+++ b/target/riscv/tcg/vector_internals.c
@@ -81,7 +81,7 @@ void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
     vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);
 }
 
-void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
+void do_vext_vx(void *vd, void *v0, int64_t s1, void *vs2,
                 CPURISCVState *env, uint32_t desc,
                 opivx2_fn fn, uint32_t esz)
 {
diff --git a/target/riscv/tcg/vector_internals.h b/target/riscv/tcg/vector_internals.h
index 5681b818153..da093d561eb 100644
--- a/target/riscv/tcg/vector_internals.h
+++ b/target/riscv/tcg/vector_internals.h
@@ -201,20 +201,20 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
                do_##NAME, ESZ);                           \
 }
 
-typedef void opivx2_fn(void *vd, target_long s1, void *vs2, int i);
+typedef void opivx2_fn(void *vd, int64_t s1, void *vs2, int i);
 
 /*
  * (T1)s1 gives the real operator type.
  * (TX1)(T1)s1 expands the operator type of widen or narrow operations.
  */
 #define OPIVX2(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)             \
-static void do_##NAME(void *vd, target_long s1, void *vs2, int i)   \
+static void do_##NAME(void *vd, int64_t s1, void *vs2, int i)       \
 {                                                                   \
     TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
     *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)s1);                      \
 }
 
-void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
+void do_vext_vx(void *vd, void *v0, int64_t s1, void *vs2,
                 CPURISCVState *env, uint32_t desc,
                 opivx2_fn fn, uint32_t esz);
 
@@ -224,7 +224,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
                   void *vs2, CPURISCVState *env,          \
                   uint32_t desc)                          \
 {                                                         \
-    do_vext_vx(vd, v0, s1, vs2, env, desc,                \
+    do_vext_vx(vd, v0, sextract64(s1, 0, target_long_bits()), \
+               vs2, env, desc,                            \
                do_##NAME, ESZ);                           \
 }
 
-- 
2.52.0.windows.1

