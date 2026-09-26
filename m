Received: from mail-dl2-f32.google.com (mail-dl2-f32.google.com [74.125.229.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D17345731
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406158; cv=none; b=ows8epF8Mf9dzyP/CxRaYSv8ortrZXyX0o5u7ZwQ9PT5DEhRWAaWuDw+P+RpPfE22ePsJA3nfc4XuSbmb6rMhIWcEYypv/D8QpwuEBGZqVK/v57BUvHU4mEj7DbQVoNSd4SBacYjZ33XyrygZ8ufHHgQ9B/NK4mxjl/JaQ4qPkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406158; c=relaxed/simple;
	bh=2ENpVG/R6V1qv0chn+lAC5VLq79P2++YyHKJTvStFfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2MEnvUtvWh88Ji7htfdhiMsqHXBkyBPZBz7yxcw4W7KVYVWYPHiPHKqKNXJUv6fXgHEJ7N78MwymCR1tD4xYovwQkfZaggC9D2FmuDvBCExg8f1pOjU3bE1ZdcrIU0ltzSKBtBF6bu3ccHnXMa+Q1odwA73AtQ6X9OUK+uljMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0xyaaP4; arc=none smtp.client-ip=74.125.229.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0xyaaP4"
Received: by mail-dl2-f32.google.com with SMTP id a92af1059eb24-1437b77c274so827092c88.3
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406156; x=1791010956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0zRIL5w+/7j7HI00vae8hs9ukAVd9SKBuffZMonHGDA=;
        b=X0xyaaP44rnKLIQyhfb7wbv2/vJfFyb+FY1eCmkQqHHWal5F+O3KHd48OjtT3rppBh
         FQDlRNmZOZ6mX8xFZsgU5ancDn1wj5P8CPUv+ls7Lx8JTPjWhMeppcZYHKCUsDOq+sFx
         TJrAD8W/V35WiwUq/qScXA7Eu3SdNgWo+r7U+NmMMP6PQiAvxY7R4cSEHq4wm8gLfVJw
         YsK5pSzKzrjbsWOAVErXNmIw00FiomzBAmleQ4l0cGvZHUgL7C74tpT+ypvVgHx4Pc8F
         /gzLI0kohfhyRDkLNiZ+VTqLOg/UKeA4htBwBAJZU0ZIEPyxzTf7SB3EFl/5oJVSjcRX
         tV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406156; x=1791010956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0zRIL5w+/7j7HI00vae8hs9ukAVd9SKBuffZMonHGDA=;
        b=G9+caFNrGdh5GWhXGomAPgK7O/g0pDn2ZDgD+GAb79xkviusdAm5Jzz0QZfq79/k8I
         kN8JP/GgWAfiBuTKiCwNErJYBUyong8qdV8r361YXuY/w4x4SX1x3jCe4d2b8OrebMrL
         BSRw5PAe0aZeLQyAoQsto13sBnsvyaGhmJ9fcsy4qT4NkJEufNRAqgIhPqImkOrnsGBg
         v+pJyFYzhQE/fl9DOjH2akK1GgJsODPGy3XYoe5sWspNmIvocG+eT/inCL6kSRfd/WK0
         42r9438Mnawv+HgTHa2PwlayZi606nTxmdkihHN7bTWqGgkQqsZBvPAG0W9zXI1kOAt5
         JNtQ==
X-Forwarded-Encrypted: i=1; AKwUvBxEck02MWmTF+HWy6JuRw+bjs59kYLCsGPJeaDKGnqTqmHCknU33xZXpwY1V7+TgRBl53E=@vger.kernel.org
X-Gm-Message-State: AFuF++kVslEuiZfUxNtKc6HTohCu1XljwmXjbIWptjrme2yk0euZDhwT
	8Rk0cMyHPxDpVcyhFTlEayrQPfe9a3CBXrmQg/rUwQnMeOQPxa23Y8ex
X-Gm-Gg: AYBFou05SBxy0GUE3mgABiBRBV2Zt46Fvvqym0IBfcMP3uumnXN6eD05mMQ2NG5vExe
	hO/ZsBb+Xk4Db9ZzMAShDmsWPb3kC4Kx/5+ovyrR8UV//mARK1Fc6lN9S+l2ZRa97yyoq4talv9
	Li8zBAdWWT8awGoZjH0LHp+ngLbAoQWZy3pR1UAHE1spl0+ifv16cgwTo9lO9EHbgLt9SLnv+85
	nqa33SUd13n5KaWN4ANAxwmJiPBwJ50P4r8qrIlA6VwBlldjaXeRW7bb3jmVFYL6Vyabo+y8uVz
	1uyyL2PaDjD3QQefxHybuESriv17PDxJ0Sl15QHTv7OYl0Kd82Bdz50rikclni8S4AjQbUbjWLs
	rNj2U25CT4cPb3OvYUPPyXa9LgvteE35DjBzO8kKcdDC7UyVGBJ0PZmNwrKvv0qzFBT3QOfHgcp
	WY3FsslKvzya1L1702GEEyOX5o0r3/UKv2zfn9degTKARFIYtaeFAl77olVM7tAhDOCSMJxzwsB
	FOKkcrN3k7ODeRUW5/hfhnPvu8ZP9kMP+0g+Fl25w==
X-Received: by 2002:a05:701b:4254:10b0:143:2982:1045 with SMTP id a92af1059eb24-146d02aa3b9mr1963884c88.38.1790406155693;
        Sat, 26 Sep 2026 00:02:35 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:02:34 -0700 (PDT)
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
Subject: [PATCH v4 23/55] tcg: dispatch tcg_gen_*_tl without TARGET_LONG_BITS
Date: Sat, 26 Sep 2026 15:00:22 +0800
Message-ID: <20260926070057.1234-24-luoyonggang@gmail.com>
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

Replace the TARGET_LONG_BITS aliases in tcg-op.h with the runtime
helpers in tcg-op-tl.h. The width follows tl_is_64(), and tcg-op.h
no longer includes exec/target_long.h.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/tcg/tcg-op-tl.h | 568 ++++++++++++++++++++++++++++++++++++++++
 include/tcg/tcg-op.h    | 228 +---------------
 2 files changed, 569 insertions(+), 227 deletions(-)
 create mode 100644 include/tcg/tcg-op-tl.h

diff --git a/include/tcg/tcg-op-tl.h b/include/tcg/tcg-op-tl.h
new file mode 100644
index 00000000000..e05d00a9aaa
--- /dev/null
+++ b/include/tcg/tcg-op-tl.h
@@ -0,0 +1,568 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * target_ulong TCG ops. Width follows target_long_bits() at
+ * translate time. Does not include exec/target_long.h.
+ */
+
+#ifndef TCG_TCG_OP_TL_H
+#define TCG_TCG_OP_TL_H
+
+#include "tcg/tcg-op-mem.h"
+
+/* Load: same callee name on i32 and i64. */
+#define DEF_TL_LD(NAME)                                                 \
+    static inline void tcg_gen_##NAME##_tl(TCGv r, TCGv_ptr b,          \
+                                           tcg_target_long o)           \
+    {                                                                   \
+        if (tl_is_64()) {                                               \
+            tcg_gen_##NAME##_i64(tcg_i64_from_tl(r), b, o);             \
+        } else {                                                        \
+            tcg_gen_##NAME##_i32(tcg_i32_from_tl(r), b, o);             \
+        }                                                               \
+    }
+
+DEF_TL_LD(ld)
+DEF_TL_LD(ld8u)
+DEF_TL_LD(ld8s)
+DEF_TL_LD(ld16u)
+DEF_TL_LD(ld16s)
+#undef DEF_TL_LD
+
+/* i32 target long is the full register, so a 32-bit load is ld. */
+
+static inline void tcg_gen_ld32u_tl(TCGv r, TCGv_ptr b, tcg_target_long o)
+{
+    if (tl_is_64()) {
+        tcg_gen_ld32u_i64(tcg_i64_from_tl(r), b, o);
+    } else {
+        tcg_gen_ld_i32(tcg_i32_from_tl(r), b, o);
+    }
+}
+
+static inline void tcg_gen_ld32s_tl(TCGv r, TCGv_ptr b, tcg_target_long o)
+{
+    if (tl_is_64()) {
+        tcg_gen_ld32s_i64(tcg_i64_from_tl(r), b, o);
+    } else {
+        tcg_gen_ld_i32(tcg_i32_from_tl(r), b, o);
+    }
+}
+
+/* Store: same callee name on i32 and i64. */
+#define DEF_TL_ST(NAME)                                                 \
+    static inline void tcg_gen_##NAME##_tl(TCGv v, TCGv_ptr b,          \
+                                           tcg_target_long o)           \
+    {                                                                   \
+        if (tl_is_64()) {                                               \
+            tcg_gen_##NAME##_i64(tcg_i64_from_tl(v), b, o);             \
+        } else {                                                        \
+            tcg_gen_##NAME##_i32(tcg_i32_from_tl(v), b, o);             \
+        }                                                               \
+    }
+
+DEF_TL_ST(st)
+DEF_TL_ST(st8)
+DEF_TL_ST(st16)
+#undef DEF_TL_ST
+
+/* i32 target long is the full register, so a 32-bit store is st. */
+
+static inline void tcg_gen_st32_tl(TCGv r, TCGv_ptr b, tcg_target_long o)
+{
+    if (tl_is_64()) {
+        tcg_gen_st32_i64(tcg_i64_from_tl(r), b, o);
+    } else {
+        tcg_gen_st_i32(tcg_i32_from_tl(r), b, o);
+    }
+}
+
+static inline void tcg_gen_movi_tl(TCGv r, tcg_imm_tl i)
+{
+    if (tl_is_64()) {
+        tcg_gen_movi_i64(tcg_i64_from_tl(r), i);
+    } else {
+        tcg_gen_movi_i32(tcg_i32_from_tl(r), i);
+    }
+}
+
+static inline void tcg_gen_discard_tl(TCGv v)
+{
+    if (tl_is_64()) {
+        tcg_gen_discard_i64(tcg_i64_from_tl(v));
+    } else {
+        tcg_gen_discard_i32(tcg_i32_from_tl(v));
+    }
+}
+
+static inline void tcg_gen_subfi_tl(TCGv r, tcg_imm_tl i, TCGv x)
+{
+    if (tl_is_64()) {
+        tcg_gen_subfi_i64(tcg_i64_from_tl(r), i, tcg_i64_from_tl(x));
+    } else {
+        tcg_gen_subfi_i32(tcg_i32_from_tl(r), i, tcg_i32_from_tl(x));
+    }
+}
+
+/* Unary: same callee name on i32 and i64. */
+#define DEF_TL_UNOP(NAME)                                               \
+    static inline void tcg_gen_##NAME##_tl(TCGv r, TCGv v)              \
+    {                                                                   \
+        if (tl_is_64()) {                                               \
+            tcg_gen_##NAME##_i64(tcg_i64_from_tl(r), tcg_i64_from_tl(v)); \
+        } else {                                                        \
+            tcg_gen_##NAME##_i32(tcg_i32_from_tl(r), tcg_i32_from_tl(v)); \
+        }                                                               \
+    }
+
+DEF_TL_UNOP(mov)
+DEF_TL_UNOP(neg)
+DEF_TL_UNOP(abs)
+DEF_TL_UNOP(not)
+DEF_TL_UNOP(ext8u)
+DEF_TL_UNOP(ext8s)
+DEF_TL_UNOP(ext16u)
+DEF_TL_UNOP(ext16s)
+DEF_TL_UNOP(clrsb)
+DEF_TL_UNOP(ctpop)
+DEF_TL_UNOP(hswap)
+DEF_TL_UNOP(revbit8)
+#undef DEF_TL_UNOP
+
+/* Binary: same callee name on i32 and i64. */
+#define DEF_TL_BINOP(NAME)                                              \
+    static inline void tcg_gen_##NAME##_tl(TCGv r, TCGv x, TCGv y)      \
+    {                                                                   \
+        if (tl_is_64()) {                                               \
+            tcg_gen_##NAME##_i64(tcg_i64_from_tl(r), tcg_i64_from_tl(x), \
+                                 tcg_i64_from_tl(y));                   \
+        } else {                                                        \
+            tcg_gen_##NAME##_i32(tcg_i32_from_tl(r), tcg_i32_from_tl(x), \
+                                 tcg_i32_from_tl(y));                   \
+        }                                                               \
+    }
+
+DEF_TL_BINOP(add)
+DEF_TL_BINOP(sub)
+DEF_TL_BINOP(and)
+DEF_TL_BINOP(or)
+DEF_TL_BINOP(xor)
+DEF_TL_BINOP(andc)
+DEF_TL_BINOP(eqv)
+DEF_TL_BINOP(nand)
+DEF_TL_BINOP(nor)
+DEF_TL_BINOP(orc)
+DEF_TL_BINOP(shl)
+DEF_TL_BINOP(shr)
+DEF_TL_BINOP(sar)
+DEF_TL_BINOP(mul)
+DEF_TL_BINOP(div)
+DEF_TL_BINOP(rem)
+DEF_TL_BINOP(divu)
+DEF_TL_BINOP(remu)
+DEF_TL_BINOP(clz)
+DEF_TL_BINOP(ctz)
+DEF_TL_BINOP(rotl)
+DEF_TL_BINOP(rotr)
+DEF_TL_BINOP(smin)
+DEF_TL_BINOP(umin)
+DEF_TL_BINOP(smax)
+DEF_TL_BINOP(umax)
+DEF_TL_BINOP(ussub)
+#undef DEF_TL_BINOP
+
+/* Immediate: same callee name on i32 and i64. */
+#define DEF_TL_OPI(NAME)                                                \
+    static inline void tcg_gen_##NAME##_tl(TCGv r, TCGv x, tcg_imm_tl i) \
+    {                                                                   \
+        if (tl_is_64()) {                                               \
+            tcg_gen_##NAME##_i64(tcg_i64_from_tl(r), tcg_i64_from_tl(x), i); \
+        } else {                                                        \
+            tcg_gen_##NAME##_i32(tcg_i32_from_tl(r), tcg_i32_from_tl(x), i); \
+        }                                                               \
+    }
+
+DEF_TL_OPI(addi)
+DEF_TL_OPI(subi)
+DEF_TL_OPI(andi)
+DEF_TL_OPI(ori)
+DEF_TL_OPI(xori)
+DEF_TL_OPI(muli)
+DEF_TL_OPI(shli)
+DEF_TL_OPI(shri)
+DEF_TL_OPI(sari)
+DEF_TL_OPI(clzi)
+DEF_TL_OPI(ctzi)
+DEF_TL_OPI(rotli)
+DEF_TL_OPI(rotri)
+#undef DEF_TL_OPI
+
+static inline void tcg_gen_brcond_tl(TCGCond cond, TCGv x, TCGv y,
+                                     TCGLabel *l)
+{
+    if (tl_is_64()) {
+        tcg_gen_brcond_i64(cond, tcg_i64_from_tl(x), tcg_i64_from_tl(y), l);
+    } else {
+        tcg_gen_brcond_i32(cond, tcg_i32_from_tl(x), tcg_i32_from_tl(y), l);
+    }
+}
+
+static inline void tcg_gen_brcondi_tl(TCGCond cond, TCGv x, tcg_imm_tl i,
+                                      TCGLabel *l)
+{
+    if (tl_is_64()) {
+        tcg_gen_brcondi_i64(cond, tcg_i64_from_tl(x), i, l);
+    } else {
+        tcg_gen_brcondi_i32(cond, tcg_i32_from_tl(x), i, l);
+    }
+}
+
+#define DEF_TL_COND(NAME)                                               \
+    static inline void tcg_gen_##NAME##_tl(TCGCond cond, TCGv r,        \
+                                           TCGv x, TCGv y)              \
+    {                                                                   \
+        if (tl_is_64()) {                                               \
+            tcg_gen_##NAME##_i64(cond, tcg_i64_from_tl(r),              \
+                                 tcg_i64_from_tl(x), tcg_i64_from_tl(y)); \
+        } else {                                                        \
+            tcg_gen_##NAME##_i32(cond, tcg_i32_from_tl(r),              \
+                                 tcg_i32_from_tl(x), tcg_i32_from_tl(y)); \
+        }                                                               \
+    }
+
+DEF_TL_COND(setcond)
+DEF_TL_COND(negsetcond)
+#undef DEF_TL_COND
+
+#define DEF_TL_CONDI(NAME)                                              \
+    static inline void tcg_gen_##NAME##_tl(TCGCond cond, TCGv r,        \
+                                           TCGv x, tcg_imm_tl i)        \
+    {                                                                   \
+        if (tl_is_64()) {                                               \
+            tcg_gen_##NAME##_i64(cond, tcg_i64_from_tl(r),              \
+                                 tcg_i64_from_tl(x), i);                \
+        } else {                                                        \
+            tcg_gen_##NAME##_i32(cond, tcg_i32_from_tl(r),              \
+                                 tcg_i32_from_tl(x), i);                \
+        }                                                               \
+    }
+
+DEF_TL_CONDI(setcondi)
+DEF_TL_CONDI(negsetcondi)
+#undef DEF_TL_CONDI
+
+static inline void tcg_gen_movcond_tl(TCGCond cond, TCGv r, TCGv c1,
+                                      TCGv c2, TCGv v1, TCGv v2)
+{
+    if (tl_is_64()) {
+        tcg_gen_movcond_i64(cond, tcg_i64_from_tl(r), tcg_i64_from_tl(c1),
+                            tcg_i64_from_tl(c2), tcg_i64_from_tl(v1),
+                            tcg_i64_from_tl(v2));
+    } else {
+        tcg_gen_movcond_i32(cond, tcg_i32_from_tl(r), tcg_i32_from_tl(c1),
+                            tcg_i32_from_tl(c2), tcg_i32_from_tl(v1),
+                            tcg_i32_from_tl(v2));
+    }
+}
+
+static inline void tcg_gen_trunc_tl_i32(TCGv_i32 r, TCGv v)
+{
+    if (tl_is_64()) {
+        tcg_gen_extrl_i64_i32(r, tcg_i64_from_tl(v));
+    } else {
+        tcg_gen_mov_i32(r, tcg_i32_from_tl(v));
+    }
+}
+
+static inline void tcg_gen_trunc_i64_tl(TCGv r, TCGv_i64 v)
+{
+    if (tl_is_64()) {
+        tcg_gen_mov_i64(tcg_i64_from_tl(r), v);
+    } else {
+        tcg_gen_extrl_i64_i32(tcg_i32_from_tl(r), v);
+    }
+}
+
+static inline void tcg_gen_extu_i32_tl(TCGv r, TCGv_i32 v)
+{
+    if (tl_is_64()) {
+        tcg_gen_extu_i32_i64(tcg_i64_from_tl(r), v);
+    } else {
+        tcg_gen_mov_i32(tcg_i32_from_tl(r), v);
+    }
+}
+
+static inline void tcg_gen_ext_i32_tl(TCGv r, TCGv_i32 v)
+{
+    if (tl_is_64()) {
+        tcg_gen_ext_i32_i64(tcg_i64_from_tl(r), v);
+    } else {
+        tcg_gen_mov_i32(tcg_i32_from_tl(r), v);
+    }
+}
+
+static inline void tcg_gen_extu_tl_i64(TCGv_i64 r, TCGv v)
+{
+    if (tl_is_64()) {
+        tcg_gen_mov_i64(r, tcg_i64_from_tl(v));
+    } else {
+        tcg_gen_extu_i32_i64(r, tcg_i32_from_tl(v));
+    }
+}
+
+static inline void tcg_gen_ext_tl_i64(TCGv_i64 r, TCGv v)
+{
+    if (tl_is_64()) {
+        tcg_gen_mov_i64(r, tcg_i64_from_tl(v));
+    } else {
+        tcg_gen_ext_i32_i64(r, tcg_i32_from_tl(v));
+    }
+}
+
+static inline void tcg_gen_ext32u_tl(TCGv r, TCGv v)
+{
+    if (tl_is_64()) {
+        tcg_gen_ext32u_i64(tcg_i64_from_tl(r), tcg_i64_from_tl(v));
+    } else {
+        tcg_gen_mov_i32(tcg_i32_from_tl(r), tcg_i32_from_tl(v));
+    }
+}
+
+static inline void tcg_gen_ext32s_tl(TCGv r, TCGv v)
+{
+    if (tl_is_64()) {
+        tcg_gen_ext32s_i64(tcg_i64_from_tl(r), tcg_i64_from_tl(v));
+    } else {
+        tcg_gen_mov_i32(tcg_i32_from_tl(r), tcg_i32_from_tl(v));
+    }
+}
+
+static inline void tcg_gen_ext_tl(TCGv r, TCGv v, MemOp opc)
+{
+    if (tl_is_64()) {
+        tcg_gen_ext_i64(tcg_i64_from_tl(r), tcg_i64_from_tl(v), opc);
+    } else {
+        tcg_gen_ext_i32(tcg_i32_from_tl(r), tcg_i32_from_tl(v), opc);
+    }
+}
+
+static inline void tcg_gen_bswap16_tl(TCGv r, TCGv v, int flags)
+{
+    if (tl_is_64()) {
+        tcg_gen_bswap16_i64(tcg_i64_from_tl(r), tcg_i64_from_tl(v), flags);
+    } else {
+        tcg_gen_bswap16_i32(tcg_i32_from_tl(r), tcg_i32_from_tl(v), flags);
+    }
+}
+
+static inline void tcg_gen_bswap32_tl(TCGv r, TCGv v, int flags)
+{
+    if (tl_is_64()) {
+        tcg_gen_bswap32_i64(tcg_i64_from_tl(r), tcg_i64_from_tl(v), flags);
+    } else {
+        tcg_gen_bswap32_i32(tcg_i32_from_tl(r), tcg_i32_from_tl(v));
+    }
+}
+
+static inline void tcg_gen_bswap64_tl(TCGv r, TCGv v)
+{
+    tcg_debug_assert(tl_is_64());
+    tcg_gen_bswap64_i64(tcg_i64_from_tl(r), tcg_i64_from_tl(v));
+}
+
+static inline void tcg_gen_bswap_tl(TCGv r, TCGv v)
+{
+    if (tl_is_64()) {
+        tcg_gen_bswap64_i64(tcg_i64_from_tl(r), tcg_i64_from_tl(v));
+    } else {
+        tcg_gen_bswap32_i32(tcg_i32_from_tl(r), tcg_i32_from_tl(v));
+    }
+}
+
+static inline void tcg_gen_wswap_tl(TCGv r, TCGv v)
+{
+    tcg_debug_assert(tl_is_64());
+    tcg_gen_wswap_i64(tcg_i64_from_tl(r), tcg_i64_from_tl(v));
+}
+
+static inline void tcg_gen_revbit32_tl(TCGv r, TCGv v, int flags)
+{
+    if (tl_is_64()) {
+        tcg_gen_revbit32_i64(tcg_i64_from_tl(r), tcg_i64_from_tl(v), flags);
+    } else {
+        tcg_gen_revbit32_i32(tcg_i32_from_tl(r), tcg_i32_from_tl(v));
+    }
+}
+
+static inline void tcg_gen_revbit64_tl(TCGv r, TCGv v)
+{
+    tcg_debug_assert(tl_is_64());
+    tcg_gen_revbit64_i64(tcg_i64_from_tl(r), tcg_i64_from_tl(v));
+}
+
+static inline void tcg_gen_revbit_tl(TCGv r, TCGv v)
+{
+    if (tl_is_64()) {
+        tcg_gen_revbit64_i64(tcg_i64_from_tl(r), tcg_i64_from_tl(v));
+    } else {
+        tcg_gen_revbit32_i32(tcg_i32_from_tl(r), tcg_i32_from_tl(v));
+    }
+}
+
+static inline void tcg_gen_concat_tl_i64(TCGv_i64 r, TCGv lo, TCGv hi)
+{
+    if (tl_is_64()) {
+        tcg_gen_concat32_i64(r, tcg_i64_from_tl(lo), tcg_i64_from_tl(hi));
+    } else {
+        tcg_gen_concat_i32_i64(r, tcg_i32_from_tl(lo), tcg_i32_from_tl(hi));
+    }
+}
+
+static inline void tcg_gen_extr_i64_tl(TCGv lo, TCGv hi, TCGv_i64 v)
+{
+    if (tl_is_64()) {
+        tcg_gen_extr32_i64(tcg_i64_from_tl(lo), tcg_i64_from_tl(hi), v);
+    } else {
+        tcg_gen_extr_i64_i32(tcg_i32_from_tl(lo), tcg_i32_from_tl(hi), v);
+    }
+}
+
+static inline void tcg_gen_deposit_tl(TCGv r, TCGv x, TCGv y, unsigned pos,
+                                      unsigned len)
+{
+    if (tl_is_64()) {
+        tcg_gen_deposit_i64(tcg_i64_from_tl(r), tcg_i64_from_tl(x),
+                            tcg_i64_from_tl(y), pos, len);
+    } else {
+        tcg_gen_deposit_i32(tcg_i32_from_tl(r), tcg_i32_from_tl(x),
+                            tcg_i32_from_tl(y), pos, len);
+    }
+}
+
+#define DEF_TL_EXTRACT(NAME)                                            \
+    static inline void tcg_gen_##NAME##_tl(TCGv r, TCGv v,              \
+                                           unsigned pos, unsigned len)  \
+    {                                                                   \
+        if (tl_is_64()) {                                               \
+            tcg_gen_##NAME##_i64(tcg_i64_from_tl(r), tcg_i64_from_tl(v), \
+                                 pos, len);                             \
+        } else {                                                        \
+            tcg_gen_##NAME##_i32(tcg_i32_from_tl(r), tcg_i32_from_tl(v), \
+                                 pos, len);                             \
+        }                                                               \
+    }
+
+DEF_TL_EXTRACT(deposit_z)
+DEF_TL_EXTRACT(extract)
+DEF_TL_EXTRACT(sextract)
+#undef DEF_TL_EXTRACT
+
+static inline void tcg_gen_extract2_tl(TCGv r, TCGv lo, TCGv hi,
+                                      unsigned ofs)
+{
+    if (tl_is_64()) {
+        tcg_gen_extract2_i64(tcg_i64_from_tl(r), tcg_i64_from_tl(lo),
+                             tcg_i64_from_tl(hi), ofs);
+    } else {
+        tcg_gen_extract2_i32(tcg_i32_from_tl(r), tcg_i32_from_tl(lo),
+                             tcg_i32_from_tl(hi), ofs);
+    }
+}
+
+static inline TCGv tcg_constant_tl(tcg_imm_tl val)
+{
+    if (tl_is_64()) {
+        return tcg_tl_from_i64(tcg_constant_i64(val));
+    }
+    return tcg_tl_from_i32(tcg_constant_i32(val));
+}
+
+#define DEF_TL_ADD2(NAME)                                               \
+    static inline void tcg_gen_##NAME##_tl(TCGv rl, TCGv rh, TCGv al,   \
+                                           TCGv ah, TCGv bl, TCGv bh)   \
+    {                                                                   \
+        if (tl_is_64()) {                                               \
+            tcg_gen_##NAME##_i64(tcg_i64_from_tl(rl), tcg_i64_from_tl(rh), \
+                                 tcg_i64_from_tl(al), tcg_i64_from_tl(ah), \
+                                 tcg_i64_from_tl(bl), tcg_i64_from_tl(bh)); \
+        } else {                                                        \
+            tcg_gen_##NAME##_i32(tcg_i32_from_tl(rl), tcg_i32_from_tl(rh), \
+                                 tcg_i32_from_tl(al), tcg_i32_from_tl(ah), \
+                                 tcg_i32_from_tl(bl), tcg_i32_from_tl(bh)); \
+        }                                                               \
+    }
+
+DEF_TL_ADD2(add2)
+DEF_TL_ADD2(sub2)
+#undef DEF_TL_ADD2
+
+static inline void tcg_gen_addcio_tl(TCGv r, TCGv co, TCGv x, TCGv y,
+                                     TCGv ci)
+{
+    if (tl_is_64()) {
+        tcg_gen_addcio_i64(tcg_i64_from_tl(r), tcg_i64_from_tl(co),
+                           tcg_i64_from_tl(x), tcg_i64_from_tl(y),
+                           tcg_i64_from_tl(ci));
+    } else {
+        tcg_gen_addcio_i32(tcg_i32_from_tl(r), tcg_i32_from_tl(co),
+                           tcg_i32_from_tl(x), tcg_i32_from_tl(y),
+                           tcg_i32_from_tl(ci));
+    }
+}
+
+#define DEF_TL_MUL2(NAME)                                               \
+    static inline void tcg_gen_##NAME##_tl(TCGv rl, TCGv rh,            \
+                                           TCGv x, TCGv y)              \
+    {                                                                   \
+        if (tl_is_64()) {                                               \
+            tcg_gen_##NAME##_i64(tcg_i64_from_tl(rl), tcg_i64_from_tl(rh), \
+                                 tcg_i64_from_tl(x), tcg_i64_from_tl(y)); \
+        } else {                                                        \
+            tcg_gen_##NAME##_i32(tcg_i32_from_tl(rl), tcg_i32_from_tl(rh), \
+                                 tcg_i32_from_tl(x), tcg_i32_from_tl(y)); \
+        }                                                               \
+    }
+
+DEF_TL_MUL2(mulu2)
+DEF_TL_MUL2(muls2)
+DEF_TL_MUL2(mulsu2)
+#undef DEF_TL_MUL2
+
+static inline void tcg_gen_dup_tl_vec(unsigned vece, TCGv_vec r, TCGv v)
+{
+    if (tl_is_64()) {
+        tcg_gen_dup_i64_vec(vece, r, tcg_i64_from_tl(v));
+    } else {
+        tcg_gen_dup_i32_vec(vece, r, tcg_i32_from_tl(v));
+    }
+}
+
+static inline void tcg_gen_dup_tl(unsigned vece, TCGv r, TCGv v)
+{
+    if (tl_is_64()) {
+        tcg_gen_dup_i64(vece, tcg_i64_from_tl(r), tcg_i64_from_tl(v));
+    } else {
+        tcg_gen_dup_i32(vece, tcg_i32_from_tl(r), tcg_i32_from_tl(v));
+    }
+}
+
+static inline tcg_imm_tl dup_const_tl(unsigned vece, uint64_t c)
+{
+    if (tl_is_64()) {
+        return dup_const(vece, c);
+    }
+    if (__builtin_constant_p(vece)) {
+        switch (vece) {
+        case MO_8:
+            return 0x01010101ul * (uint8_t)c;
+        case MO_16:
+            return 0x00010001ul * (uint16_t)c;
+        case MO_32:
+            return 0x00000001ul * (uint32_t)c;
+        default:
+            qemu_build_not_reached();
+        }
+    }
+    return (uint32_t)dup_const(vece, c);
+}
+
+#endif /* TCG_TCG_OP_TL_H */
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 158df47bf18..99cd2779687 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -10,238 +10,12 @@
 
 #include "tcg/tcg-op-common.h"
 #include "tcg/insn-start-words.h"
-#include "exec/target_long.h"
-
-#ifndef TARGET_LONG_BITS
-#error must include QEMU headers
-#endif
 
 #include "tcg/tcg-op-mem.h"
+#include "tcg/tcg-op-tl.h"
 
 #if INSN_START_WORDS != 3
 # error Mismatch with insn-start-words.h
 #endif
 
-#if TARGET_LONG_BITS == 64
-#define tcg_gen_movi_tl tcg_gen_movi_i64
-#define tcg_gen_mov_tl tcg_gen_mov_i64
-#define tcg_gen_ld8u_tl tcg_gen_ld8u_i64
-#define tcg_gen_ld8s_tl tcg_gen_ld8s_i64
-#define tcg_gen_ld16u_tl tcg_gen_ld16u_i64
-#define tcg_gen_ld16s_tl tcg_gen_ld16s_i64
-#define tcg_gen_ld32u_tl tcg_gen_ld32u_i64
-#define tcg_gen_ld32s_tl tcg_gen_ld32s_i64
-#define tcg_gen_ld_tl tcg_gen_ld_i64
-#define tcg_gen_st8_tl tcg_gen_st8_i64
-#define tcg_gen_st16_tl tcg_gen_st16_i64
-#define tcg_gen_st32_tl tcg_gen_st32_i64
-#define tcg_gen_st_tl tcg_gen_st_i64
-#define tcg_gen_add_tl tcg_gen_add_i64
-#define tcg_gen_addi_tl tcg_gen_addi_i64
-#define tcg_gen_sub_tl tcg_gen_sub_i64
-#define tcg_gen_neg_tl tcg_gen_neg_i64
-#define tcg_gen_abs_tl tcg_gen_abs_i64
-#define tcg_gen_subfi_tl tcg_gen_subfi_i64
-#define tcg_gen_subi_tl tcg_gen_subi_i64
-#define tcg_gen_and_tl tcg_gen_and_i64
-#define tcg_gen_andi_tl tcg_gen_andi_i64
-#define tcg_gen_or_tl tcg_gen_or_i64
-#define tcg_gen_ori_tl tcg_gen_ori_i64
-#define tcg_gen_xor_tl tcg_gen_xor_i64
-#define tcg_gen_xori_tl tcg_gen_xori_i64
-#define tcg_gen_not_tl tcg_gen_not_i64
-#define tcg_gen_shl_tl tcg_gen_shl_i64
-#define tcg_gen_shli_tl tcg_gen_shli_i64
-#define tcg_gen_shr_tl tcg_gen_shr_i64
-#define tcg_gen_shri_tl tcg_gen_shri_i64
-#define tcg_gen_sar_tl tcg_gen_sar_i64
-#define tcg_gen_sari_tl tcg_gen_sari_i64
-#define tcg_gen_brcond_tl tcg_gen_brcond_i64
-#define tcg_gen_brcondi_tl tcg_gen_brcondi_i64
-#define tcg_gen_setcond_tl tcg_gen_setcond_i64
-#define tcg_gen_setcondi_tl tcg_gen_setcondi_i64
-#define tcg_gen_negsetcond_tl tcg_gen_negsetcond_i64
-#define tcg_gen_negsetcondi_tl tcg_gen_negsetcondi_i64
-#define tcg_gen_mul_tl tcg_gen_mul_i64
-#define tcg_gen_muli_tl tcg_gen_muli_i64
-#define tcg_gen_div_tl tcg_gen_div_i64
-#define tcg_gen_rem_tl tcg_gen_rem_i64
-#define tcg_gen_divu_tl tcg_gen_divu_i64
-#define tcg_gen_remu_tl tcg_gen_remu_i64
-#define tcg_gen_discard_tl tcg_gen_discard_i64
-#define tcg_gen_trunc_tl_i32 tcg_gen_extrl_i64_i32
-#define tcg_gen_trunc_i64_tl tcg_gen_mov_i64
-#define tcg_gen_extu_i32_tl tcg_gen_extu_i32_i64
-#define tcg_gen_ext_i32_tl tcg_gen_ext_i32_i64
-#define tcg_gen_extu_tl_i64 tcg_gen_mov_i64
-#define tcg_gen_ext_tl_i64 tcg_gen_mov_i64
-#define tcg_gen_ext8u_tl tcg_gen_ext8u_i64
-#define tcg_gen_ext8s_tl tcg_gen_ext8s_i64
-#define tcg_gen_ext16u_tl tcg_gen_ext16u_i64
-#define tcg_gen_ext16s_tl tcg_gen_ext16s_i64
-#define tcg_gen_ext32u_tl tcg_gen_ext32u_i64
-#define tcg_gen_ext32s_tl tcg_gen_ext32s_i64
-#define tcg_gen_ext_tl tcg_gen_ext_i64
-#define tcg_gen_bswap16_tl tcg_gen_bswap16_i64
-#define tcg_gen_bswap32_tl tcg_gen_bswap32_i64
-#define tcg_gen_bswap64_tl tcg_gen_bswap64_i64
-#define tcg_gen_bswap_tl tcg_gen_bswap64_i64
-#define tcg_gen_hswap_tl tcg_gen_hswap_i64
-#define tcg_gen_wswap_tl tcg_gen_wswap_i64
-#define tcg_gen_revbit8_tl tcg_gen_revbit8_i64
-#define tcg_gen_revbit32_tl tcg_gen_revbit32_i64
-#define tcg_gen_revbit64_tl tcg_gen_revbit64_i64
-#define tcg_gen_revbit_tl tcg_gen_revbit64_i64
-#define tcg_gen_concat_tl_i64 tcg_gen_concat32_i64
-#define tcg_gen_extr_i64_tl tcg_gen_extr32_i64
-#define tcg_gen_andc_tl tcg_gen_andc_i64
-#define tcg_gen_eqv_tl tcg_gen_eqv_i64
-#define tcg_gen_nand_tl tcg_gen_nand_i64
-#define tcg_gen_nor_tl tcg_gen_nor_i64
-#define tcg_gen_orc_tl tcg_gen_orc_i64
-#define tcg_gen_clz_tl tcg_gen_clz_i64
-#define tcg_gen_ctz_tl tcg_gen_ctz_i64
-#define tcg_gen_clzi_tl tcg_gen_clzi_i64
-#define tcg_gen_ctzi_tl tcg_gen_ctzi_i64
-#define tcg_gen_clrsb_tl tcg_gen_clrsb_i64
-#define tcg_gen_ctpop_tl tcg_gen_ctpop_i64
-#define tcg_gen_rotl_tl tcg_gen_rotl_i64
-#define tcg_gen_rotli_tl tcg_gen_rotli_i64
-#define tcg_gen_rotr_tl tcg_gen_rotr_i64
-#define tcg_gen_rotri_tl tcg_gen_rotri_i64
-#define tcg_gen_deposit_tl tcg_gen_deposit_i64
-#define tcg_gen_deposit_z_tl tcg_gen_deposit_z_i64
-#define tcg_gen_extract_tl tcg_gen_extract_i64
-#define tcg_gen_sextract_tl tcg_gen_sextract_i64
-#define tcg_gen_extract2_tl tcg_gen_extract2_i64
-#define tcg_constant_tl tcg_constant_i64
-#define tcg_gen_movcond_tl tcg_gen_movcond_i64
-#define tcg_gen_add2_tl tcg_gen_add2_i64
-#define tcg_gen_sub2_tl tcg_gen_sub2_i64
-#define tcg_gen_addcio_tl tcg_gen_addcio_i64
-#define tcg_gen_mulu2_tl tcg_gen_mulu2_i64
-#define tcg_gen_muls2_tl tcg_gen_muls2_i64
-#define tcg_gen_mulsu2_tl tcg_gen_mulsu2_i64
-#define tcg_gen_smin_tl tcg_gen_smin_i64
-#define tcg_gen_umin_tl tcg_gen_umin_i64
-#define tcg_gen_smax_tl tcg_gen_smax_i64
-#define tcg_gen_umax_tl tcg_gen_umax_i64
-#define tcg_gen_ussub_tl tcg_gen_ussub_i64
-#define tcg_gen_dup_tl_vec  tcg_gen_dup_i64_vec
-#define tcg_gen_dup_tl tcg_gen_dup_i64
-#define dup_const_tl dup_const
-#else
-#define tcg_gen_movi_tl tcg_gen_movi_i32
-#define tcg_gen_mov_tl tcg_gen_mov_i32
-#define tcg_gen_ld8u_tl tcg_gen_ld8u_i32
-#define tcg_gen_ld8s_tl tcg_gen_ld8s_i32
-#define tcg_gen_ld16u_tl tcg_gen_ld16u_i32
-#define tcg_gen_ld16s_tl tcg_gen_ld16s_i32
-#define tcg_gen_ld32u_tl tcg_gen_ld_i32
-#define tcg_gen_ld32s_tl tcg_gen_ld_i32
-#define tcg_gen_ld_tl tcg_gen_ld_i32
-#define tcg_gen_st8_tl tcg_gen_st8_i32
-#define tcg_gen_st16_tl tcg_gen_st16_i32
-#define tcg_gen_st32_tl tcg_gen_st_i32
-#define tcg_gen_st_tl tcg_gen_st_i32
-#define tcg_gen_add_tl tcg_gen_add_i32
-#define tcg_gen_addi_tl tcg_gen_addi_i32
-#define tcg_gen_sub_tl tcg_gen_sub_i32
-#define tcg_gen_neg_tl tcg_gen_neg_i32
-#define tcg_gen_abs_tl tcg_gen_abs_i32
-#define tcg_gen_subfi_tl tcg_gen_subfi_i32
-#define tcg_gen_subi_tl tcg_gen_subi_i32
-#define tcg_gen_and_tl tcg_gen_and_i32
-#define tcg_gen_andi_tl tcg_gen_andi_i32
-#define tcg_gen_or_tl tcg_gen_or_i32
-#define tcg_gen_ori_tl tcg_gen_ori_i32
-#define tcg_gen_xor_tl tcg_gen_xor_i32
-#define tcg_gen_xori_tl tcg_gen_xori_i32
-#define tcg_gen_not_tl tcg_gen_not_i32
-#define tcg_gen_shl_tl tcg_gen_shl_i32
-#define tcg_gen_shli_tl tcg_gen_shli_i32
-#define tcg_gen_shr_tl tcg_gen_shr_i32
-#define tcg_gen_shri_tl tcg_gen_shri_i32
-#define tcg_gen_sar_tl tcg_gen_sar_i32
-#define tcg_gen_sari_tl tcg_gen_sari_i32
-#define tcg_gen_brcond_tl tcg_gen_brcond_i32
-#define tcg_gen_brcondi_tl tcg_gen_brcondi_i32
-#define tcg_gen_setcond_tl tcg_gen_setcond_i32
-#define tcg_gen_setcondi_tl tcg_gen_setcondi_i32
-#define tcg_gen_negsetcond_tl tcg_gen_negsetcond_i32
-#define tcg_gen_negsetcondi_tl tcg_gen_negsetcondi_i32
-#define tcg_gen_mul_tl tcg_gen_mul_i32
-#define tcg_gen_muli_tl tcg_gen_muli_i32
-#define tcg_gen_div_tl tcg_gen_div_i32
-#define tcg_gen_rem_tl tcg_gen_rem_i32
-#define tcg_gen_divu_tl tcg_gen_divu_i32
-#define tcg_gen_remu_tl tcg_gen_remu_i32
-#define tcg_gen_discard_tl tcg_gen_discard_i32
-#define tcg_gen_trunc_tl_i32 tcg_gen_mov_i32
-#define tcg_gen_trunc_i64_tl tcg_gen_extrl_i64_i32
-#define tcg_gen_extu_i32_tl tcg_gen_mov_i32
-#define tcg_gen_ext_i32_tl tcg_gen_mov_i32
-#define tcg_gen_extu_tl_i64 tcg_gen_extu_i32_i64
-#define tcg_gen_ext_tl_i64 tcg_gen_ext_i32_i64
-#define tcg_gen_ext8u_tl tcg_gen_ext8u_i32
-#define tcg_gen_ext8s_tl tcg_gen_ext8s_i32
-#define tcg_gen_ext16u_tl tcg_gen_ext16u_i32
-#define tcg_gen_ext16s_tl tcg_gen_ext16s_i32
-#define tcg_gen_ext32u_tl tcg_gen_mov_i32
-#define tcg_gen_ext32s_tl tcg_gen_mov_i32
-#define tcg_gen_ext_tl tcg_gen_ext_i32
-#define tcg_gen_bswap16_tl tcg_gen_bswap16_i32
-#define tcg_gen_bswap32_tl(D, S, F) tcg_gen_bswap32_i32(D, S)
-#define tcg_gen_bswap_tl tcg_gen_bswap32_i32
-#define tcg_gen_hswap_tl tcg_gen_hswap_i32
-#define tcg_gen_revbit8_tl tcg_gen_revbit8_i32
-#define tcg_gen_revbit32_tl(D, S, F) tcg_gen_revbit32_i32(D, S)
-#define tcg_gen_revbit_tl tcg_gen_revbit32_i32
-#define tcg_gen_concat_tl_i64 tcg_gen_concat_i32_i64
-#define tcg_gen_extr_i64_tl tcg_gen_extr_i64_i32
-#define tcg_gen_andc_tl tcg_gen_andc_i32
-#define tcg_gen_eqv_tl tcg_gen_eqv_i32
-#define tcg_gen_nand_tl tcg_gen_nand_i32
-#define tcg_gen_nor_tl tcg_gen_nor_i32
-#define tcg_gen_orc_tl tcg_gen_orc_i32
-#define tcg_gen_clz_tl tcg_gen_clz_i32
-#define tcg_gen_ctz_tl tcg_gen_ctz_i32
-#define tcg_gen_clzi_tl tcg_gen_clzi_i32
-#define tcg_gen_ctzi_tl tcg_gen_ctzi_i32
-#define tcg_gen_clrsb_tl tcg_gen_clrsb_i32
-#define tcg_gen_ctpop_tl tcg_gen_ctpop_i32
-#define tcg_gen_rotl_tl tcg_gen_rotl_i32
-#define tcg_gen_rotli_tl tcg_gen_rotli_i32
-#define tcg_gen_rotr_tl tcg_gen_rotr_i32
-#define tcg_gen_rotri_tl tcg_gen_rotri_i32
-#define tcg_gen_deposit_tl tcg_gen_deposit_i32
-#define tcg_gen_deposit_z_tl tcg_gen_deposit_z_i32
-#define tcg_gen_extract_tl tcg_gen_extract_i32
-#define tcg_gen_sextract_tl tcg_gen_sextract_i32
-#define tcg_gen_extract2_tl tcg_gen_extract2_i32
-#define tcg_constant_tl tcg_constant_i32
-#define tcg_gen_movcond_tl tcg_gen_movcond_i32
-#define tcg_gen_add2_tl tcg_gen_add2_i32
-#define tcg_gen_sub2_tl tcg_gen_sub2_i32
-#define tcg_gen_addcio_tl tcg_gen_addcio_i32
-#define tcg_gen_mulu2_tl tcg_gen_mulu2_i32
-#define tcg_gen_muls2_tl tcg_gen_muls2_i32
-#define tcg_gen_mulsu2_tl tcg_gen_mulsu2_i32
-#define tcg_gen_smin_tl tcg_gen_smin_i32
-#define tcg_gen_umin_tl tcg_gen_umin_i32
-#define tcg_gen_smax_tl tcg_gen_smax_i32
-#define tcg_gen_umax_tl tcg_gen_umax_i32
-#define tcg_gen_ussub_tl tcg_gen_ussub_i32
-#define tcg_gen_dup_tl_vec  tcg_gen_dup_i32_vec
-#define tcg_gen_dup_tl tcg_gen_dup_i32
-
-#define dup_const_tl(VECE, C)                                      \
-    (__builtin_constant_p(VECE)                                    \
-     ? (  (VECE) == MO_8  ? 0x01010101ul * (uint8_t)(C)            \
-        : (VECE) == MO_16 ? 0x00010001ul * (uint16_t)(C)           \
-        : (VECE) == MO_32 ? 0x00000001ul * (uint32_t)(C)           \
-        : (qemu_build_not_reached_always(), 0))                    \
-     :  (target_long)dup_const(VECE, C))
-
-#endif /* TARGET_LONG_BITS == 64 */
 #endif /* TCG_TCG_OP_H */
-- 
2.52.0.windows.1

