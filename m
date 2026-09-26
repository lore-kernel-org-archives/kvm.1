Received: from mail-dy2-f14.google.com (mail-dy2-f14.google.com [74.125.229.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5273A451B
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406190; cv=none; b=N3h08c9fCMDYCzgB/Niw4RwdxoNsSdZdTW+/mq5LJQyoObNJmDPrIsRGwyfKMZsteDsqzcvrokCl+jNmogvAYlqOx9dEq9UJA28Xj3Un0gvkI/82HYoEO6k1GmRnG9/I4QDnyK8wL/hu41LcvmZ291vB2N3G7NjlIhRX3sVrxS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406190; c=relaxed/simple;
	bh=hRBxwZSIAUhCmYiKP3UkUO9BWlZSD0xW9RFz0p2BcTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5tVtk+PgGrzbddOZJcdVvlTmlQAvEwWQptXyU9PZCKmXZwTO4fvrD54Mc+Y/wmVanghuYa1+fBNBhrZrgTYVhnGr+xOP+cK8mUsWKHIf9Ai7EyrdEw6YimnlIW9jpF4xjaTNcygvelfSnrG+EtRNfiQ3tQq7XCLrzQwzHGBoT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMk3fWJI; arc=none smtp.client-ip=74.125.229.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMk3fWJI"
Received: by mail-dy2-f14.google.com with SMTP id 5a478bee46e88-328664b7528so1430652eec.2
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406188; x=1791010988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RDJx03fDpoFhoiEvP/bHkwDQkhcB3SmHYPY0Nad5xBI=;
        b=LMk3fWJIpRNv7VA+36BA4X1j/kZT7wGsiVYeI2gIi9gFeeAqjv7nhvjkfc6DLz6nQG
         ZylmM+QF18EMRf/+8Wftx9Zoor5Y1vYN2KGT48k7qxi3baeh1VD2vGoTvneaZe7QmLQJ
         uWINRo+Erz90DuPKdoW+xJyN0Ilxa6ew8n9TAMYeLULveX+37MRu3p2dqAThkNEohPS+
         gwbmyVMn9UU4BtLMuKdSEVX++3b7QshStrpxPoIOWSAQ1s9mlVujADXoV3z7WAnT6Iya
         APlOUPOnLQ5jXkWx/54rRRJoRfiwSi5ERZq6IU0chPkER1YZzujxhHTkL3mkGx05TVJa
         b/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406188; x=1791010988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RDJx03fDpoFhoiEvP/bHkwDQkhcB3SmHYPY0Nad5xBI=;
        b=sz9KDcCO90Zz/vPC9QDJMsP9bbbX3U9nhPfZ6HPGtstxTzNYZI1POGVcWC+0UFvddh
         wPztO/SBxnksxcxvyc6+/hCs2YIivgWng7/ULfVdFGUeGeBVzExMcol7IJfmeIJPH8Mm
         Il4aZfJ0am39x5A86hkWzSncs6LshKVMn/tK36XitGFZ+Xxs1+pC1IOjXTR/EggBcr1i
         jQohowuojzCUfLLj+mdotXqSmy/Wrbop2VMS93FOgXPbxKwIiGKA85dtd9irt+lZMFAk
         2X+/s3fNRaUyH2nVYP9SaEoDF/nr2z4IU4Tp5P3rZxA7Athki8t20+KXeqcHLsMu2YEg
         BiAw==
X-Forwarded-Encrypted: i=1; AKwUvBxncQUV/q1DNJwMZqvKFGxYvihpVHtPpp09GlUu8WZ5nrDBAHuN2xbXnErR7qwuRDlcNU4=@vger.kernel.org
X-Gm-Message-State: AFuF++nNeToYwyTSmX5hxhL8sPCYXkSYcJG3JeHke6WWd5kuGpJJpIPI
	dCqpxF4z+Oo+rFToTwYBA+UIeh07oItN5HI4Sh95BGLcwtVuensFRy8J
X-Gm-Gg: AYBFou2U4Fe7qpGToAwZgwoRuPfJ2YayodSDR3ivvYtb7T6th7vwWpYWgHFgJGG8NJ2
	HeVML8uLMz1ikc7n2FlHKxbyQErvMohqie9a6HGbh9LBiqMApLkHTpJ4SiM/5xPleCSdil5+pxL
	K4+tVDuTFptiscAQDz1QuO4hYg4M0PgvApwLwVNm41Q/xULY07s0j2277mStK6emKGa7svB1JCR
	LIQ0WwN2dnHu+y7ptxmh+V5UCwRUewanagipQrmiBt2BiGpvLNh2L45LeY+A9ZrtLHBAMROoJHq
	U/vbTQgFiR3cr+5kZA9dMOlx14d+r0urkswT+hPQpx7alQflCPKwgUDS1g3ZSggGjbIPkdLJqX2
	tDX93PIJiQF7TBVnFSRh8brl2j0VX4/56EIW5vQ2HjdaZkGbqTvc7AwAQd3/P8exrUcIyhkINfm
	ja7DUj+9nabjN1DHXXUeSGUjgrsBBvzUV3JoraNZ9ZVvnPdmhgNkVvh97gpeDSWloovWDiONPh0
	vUPsViFEgVcPmcO2EIriwcasu0D6p4=
X-Received: by 2002:a05:7301:4d0b:b0:341:4f3:8f84 with SMTP id 5a478bee46e88-342707b3fb2mr2095737eec.13.1790406187813;
        Sat, 26 Sep 2026 00:03:07 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:03:07 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 31/55] accel/tcg: move memory helpers out of tcg-runtime.h
Date: Sat, 26 Sep 2026 15:00:30 +0800
Message-ID: <20260926070057.1234-32-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memset, ld_i128, and st_i128 are declared in ldst_common.h, and
ldst_common.c.inc emits their helper info. Atomic helpers move to
atomic_common.h, with info records emitted from atomic_common.c.inc.
tcg-runtime.h keeps the integer helpers implemented in tcg-runtime.c.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 accel/tcg/atomic_common.c.inc                |  4 +
 accel/tcg/{tcg-runtime.h => atomic_common.h} | 36 ---------
 accel/tcg/ldst_common.c.inc                  |  4 +
 accel/tcg/ldst_common.h                      | 13 +++
 accel/tcg/tcg-runtime.h                      | 85 --------------------
 include/exec/helper-gen-common.h             |  8 ++
 include/exec/helper-proto-common.h           |  8 ++
 7 files changed, 37 insertions(+), 121 deletions(-)
 copy accel/tcg/{tcg-runtime.h => atomic_common.h} (65%)
 create mode 100644 accel/tcg/ldst_common.h

diff --git a/accel/tcg/atomic_common.c.inc b/accel/tcg/atomic_common.c.inc
index 7d779dd51db..a24250be75e 100644
--- a/accel/tcg/atomic_common.c.inc
+++ b/accel/tcg/atomic_common.c.inc
@@ -101,3 +101,7 @@ ATOMIC_HELPER(fetch_oro_le, Int128)
 
 #undef ATOMIC_HELPER
 #undef GEN_ATOMIC_HELPERS
+
+#define HELPER_H "accel/tcg/atomic_common.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/atomic_common.h
similarity index 65%
copy from accel/tcg/tcg-runtime.h
copy to accel/tcg/atomic_common.h
index 26e0baeca51..4fee73cf916 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/atomic_common.h
@@ -1,39 +1,3 @@
-DEF_HELPER_FLAGS_2(div_i32, TCG_CALL_NO_RWG_SE, s32, s32, s32)
-DEF_HELPER_FLAGS_2(rem_i32, TCG_CALL_NO_RWG_SE, s32, s32, s32)
-DEF_HELPER_FLAGS_2(divu_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-DEF_HELPER_FLAGS_2(remu_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-
-DEF_HELPER_FLAGS_2(div_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-DEF_HELPER_FLAGS_2(rem_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-DEF_HELPER_FLAGS_2(divu_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(remu_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-
-DEF_HELPER_FLAGS_2(mulsh_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-DEF_HELPER_FLAGS_2(muluh_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-
-DEF_HELPER_FLAGS_2(clz_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-DEF_HELPER_FLAGS_2(ctz_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-DEF_HELPER_FLAGS_2(clz_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(ctz_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_1(clrsb_i32, TCG_CALL_NO_RWG_SE, i32, i32)
-DEF_HELPER_FLAGS_1(clrsb_i64, TCG_CALL_NO_RWG_SE, i64, i64)
-DEF_HELPER_FLAGS_1(ctpop_i32, TCG_CALL_NO_RWG_SE, i32, i32)
-DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE, i64, i64)
-
-#ifndef IN_HELPER_PROTO
-/*
- * Pass calls to memset directly to libc, without a thunk in qemu.
- * Do not re-declare memset, especially since we fudge the type here;
- * we assume sizeof(void *) == sizeof(size_t), which is true for
- * all supported hosts.
- */
-#define helper_memset memset
-DEF_HELPER_FLAGS_3(memset, TCG_CALL_NO_RWG, ptr, ptr, int, ptr)
-#endif /* IN_HELPER_PROTO */
-
-DEF_HELPER_FLAGS_3(ld_i128, TCG_CALL_NO_WG, i128, env, i64, i32)
-DEF_HELPER_FLAGS_4(st_i128, TCG_CALL_NO_WG, void, env, i64, i128, i32)
-
 DEF_HELPER_FLAGS_5(atomic_cmpxchgb, TCG_CALL_NO_WG,
                    i32, env, i64, i32, i32, i32)
 DEF_HELPER_FLAGS_5(atomic_cmpxchgw_be, TCG_CALL_NO_WG,
diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
index 57f3e061924..bf74d65dd75 100644
--- a/accel/tcg/ldst_common.c.inc
+++ b/accel/tcg/ldst_common.c.inc
@@ -119,6 +119,10 @@ void helper_st_i128(CPUArchState *env, uint64_t addr, Int128 val, MemOpIdx oi)
     helper_st16_mmu(env, addr, val, oi, GETPC());
 }
 
+#define HELPER_H "accel/tcg/ldst_common.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 /*
  * Load helpers for cpu_ldst.h
  */
diff --git a/accel/tcg/ldst_common.h b/accel/tcg/ldst_common.h
new file mode 100644
index 00000000000..cec4751ff16
--- /dev/null
+++ b/accel/tcg/ldst_common.h
@@ -0,0 +1,13 @@
+#ifndef IN_HELPER_PROTO
+/*
+ * Pass calls to memset directly to libc, without a thunk in qemu.
+ * Do not re-declare memset, especially since we fudge the type here;
+ * we assume sizeof(void *) == sizeof(size_t), which is true for
+ * all supported hosts.
+ */
+#define helper_memset memset
+DEF_HELPER_FLAGS_3(memset, TCG_CALL_NO_RWG, ptr, ptr, int, ptr)
+#endif /* IN_HELPER_PROTO */
+
+DEF_HELPER_FLAGS_3(ld_i128, TCG_CALL_NO_WG, i128, env, i64, i32)
+DEF_HELPER_FLAGS_4(st_i128, TCG_CALL_NO_WG, void, env, i64, i128, i32)
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 26e0baeca51..d635e6b708b 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -19,88 +19,3 @@ DEF_HELPER_FLAGS_1(clrsb_i32, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(clrsb_i64, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_1(ctpop_i32, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE, i64, i64)
-
-#ifndef IN_HELPER_PROTO
-/*
- * Pass calls to memset directly to libc, without a thunk in qemu.
- * Do not re-declare memset, especially since we fudge the type here;
- * we assume sizeof(void *) == sizeof(size_t), which is true for
- * all supported hosts.
- */
-#define helper_memset memset
-DEF_HELPER_FLAGS_3(memset, TCG_CALL_NO_RWG, ptr, ptr, int, ptr)
-#endif /* IN_HELPER_PROTO */
-
-DEF_HELPER_FLAGS_3(ld_i128, TCG_CALL_NO_WG, i128, env, i64, i32)
-DEF_HELPER_FLAGS_4(st_i128, TCG_CALL_NO_WG, void, env, i64, i128, i32)
-
-DEF_HELPER_FLAGS_5(atomic_cmpxchgb, TCG_CALL_NO_WG,
-                   i32, env, i64, i32, i32, i32)
-DEF_HELPER_FLAGS_5(atomic_cmpxchgw_be, TCG_CALL_NO_WG,
-                   i32, env, i64, i32, i32, i32)
-DEF_HELPER_FLAGS_5(atomic_cmpxchgw_le, TCG_CALL_NO_WG,
-                   i32, env, i64, i32, i32, i32)
-DEF_HELPER_FLAGS_5(atomic_cmpxchgl_be, TCG_CALL_NO_WG,
-                   i32, env, i64, i32, i32, i32)
-DEF_HELPER_FLAGS_5(atomic_cmpxchgl_le, TCG_CALL_NO_WG,
-                   i32, env, i64, i32, i32, i32)
-DEF_HELPER_FLAGS_5(atomic_cmpxchgq_be, TCG_CALL_NO_WG,
-                   i64, env, i64, i64, i64, i32)
-DEF_HELPER_FLAGS_5(atomic_cmpxchgq_le, TCG_CALL_NO_WG,
-                   i64, env, i64, i64, i64, i32)
-#if HAVE_CMPXCHG128
-DEF_HELPER_FLAGS_5(atomic_cmpxchgo_be, TCG_CALL_NO_WG,
-                   i128, env, i64, i128, i128, i32)
-DEF_HELPER_FLAGS_5(atomic_cmpxchgo_le, TCG_CALL_NO_WG,
-                   i128, env, i64, i128, i128, i32)
-DEF_HELPER_FLAGS_4(atomic_xchgo_be, TCG_CALL_NO_WG,
-                   i128, env, i64, i128, i32)
-DEF_HELPER_FLAGS_4(atomic_xchgo_le, TCG_CALL_NO_WG,
-                   i128, env, i64, i128, i32)
-DEF_HELPER_FLAGS_4(atomic_fetch_ando_be, TCG_CALL_NO_WG,
-                   i128, env, i64, i128, i32)
-DEF_HELPER_FLAGS_4(atomic_fetch_ando_le, TCG_CALL_NO_WG,
-                   i128, env, i64, i128, i32)
-DEF_HELPER_FLAGS_4(atomic_fetch_oro_be, TCG_CALL_NO_WG,
-                   i128, env, i64, i128, i32)
-DEF_HELPER_FLAGS_4(atomic_fetch_oro_le, TCG_CALL_NO_WG,
-                   i128, env, i64, i128, i32)
-#endif
-
-#define GEN_ATOMIC_HELPERS(NAME)                                  \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), b),              \
-                       TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), w_le),           \
-                       TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), w_be),           \
-                       TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), l_le),           \
-                       TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), l_be),           \
-                       TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), q_le),           \
-                       TCG_CALL_NO_WG, i64, env, i64, i64, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), q_be),           \
-                       TCG_CALL_NO_WG, i64, env, i64, i64, i32)
-
-GEN_ATOMIC_HELPERS(fetch_add)
-GEN_ATOMIC_HELPERS(fetch_and)
-GEN_ATOMIC_HELPERS(fetch_or)
-GEN_ATOMIC_HELPERS(fetch_xor)
-GEN_ATOMIC_HELPERS(fetch_smin)
-GEN_ATOMIC_HELPERS(fetch_umin)
-GEN_ATOMIC_HELPERS(fetch_smax)
-GEN_ATOMIC_HELPERS(fetch_umax)
-
-GEN_ATOMIC_HELPERS(add_fetch)
-GEN_ATOMIC_HELPERS(and_fetch)
-GEN_ATOMIC_HELPERS(or_fetch)
-GEN_ATOMIC_HELPERS(xor_fetch)
-GEN_ATOMIC_HELPERS(smin_fetch)
-GEN_ATOMIC_HELPERS(umin_fetch)
-GEN_ATOMIC_HELPERS(smax_fetch)
-GEN_ATOMIC_HELPERS(umax_fetch)
-
-GEN_ATOMIC_HELPERS(xchg)
-
-#undef GEN_ATOMIC_HELPERS
diff --git a/include/exec/helper-gen-common.h b/include/exec/helper-gen-common.h
index 73e979a35f3..5943a3aedf0 100644
--- a/include/exec/helper-gen-common.h
+++ b/include/exec/helper-gen-common.h
@@ -19,6 +19,14 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "accel/tcg/ldst_common.h"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
+#define HELPER_H "accel/tcg/atomic_common.h"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "accel/tcg/tcg-runtime-gvec.h"
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
diff --git a/include/exec/helper-proto-common.h b/include/exec/helper-proto-common.h
index 3c32f95f4c1..eabe7828047 100644
--- a/include/exec/helper-proto-common.h
+++ b/include/exec/helper-proto-common.h
@@ -21,6 +21,14 @@
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "accel/tcg/ldst_common.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
+#define HELPER_H "accel/tcg/atomic_common.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "accel/tcg/tcg-runtime-gvec.h"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
-- 
2.52.0.windows.1

