Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA45D345731
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406154; cv=none; b=beAMmRZ6ZwFbeg0Q+cbis+JxJ65Ugv86fmCsPaKPHYWCqxYQLaaOIkO9epfnInzi02Y9hvWPk2lfMdmqnyO1kPscSEaRz3hxqkFflCQP+X6p+Deuu/AT/v11MN1mmpTYx7F/UK9J7je6/gBNisNaVKB5wQzFV7M9AmI8CjffQ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406154; c=relaxed/simple;
	bh=Jhrlq5XAtF0cuKnguPorxji/kkXUZROYmKPFLK4nFac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=totYn6tGCZwFKchBwKyNuB52/gPB1T2smSYNjdBcWcWY/4C0y4bZxyVM+4LuMjk+SRipJ05g23B+JbhmHgA4CBUI2eCNKsP19oQbY8N4FRjwjcU9e/IJDd8pr4WVqwzKY7PsZULyLfFUU4fKY9I/dUfeNiiQzd0j9Ch+BiQn950=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o63VBgqc; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o63VBgqc"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33b9e805130so1110747eec.1
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406152; x=1791010952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VtvK64eD6Oei73yOgbqEAR1VlYxIZN+qs4TLFfACmJs=;
        b=o63VBgqcxdw2C+l7Gp8bd2Iv087OTD4b6zmEn/o2RXYWphU78ceVcbmpkyg/fb88sV
         XV9GKv/n/MK5pc5RXDVhnjdj9XFJgaiundxIXlqfdUiRMv4muVtlYc0nlCyGDD0fbq8q
         CNbtcvb3EY3hxeM/PG6cV8q9rwOK//0oBR2NN2nlm57kWcYMdolzkx8JveoVf/bYuhUz
         XK4mKYgVVlqyTJ7k+55N/ZAsg57fkQBCirRoVskd6Y4B/7ZB0dlFkI4LJTC4Qq3FpHvr
         zRVxxu3tCbetEcm5X/ceYn1fNBG0DTEYMXEk35Fvmwp6BVgf3waKke/vvagrbz7anQQw
         yxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406152; x=1791010952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VtvK64eD6Oei73yOgbqEAR1VlYxIZN+qs4TLFfACmJs=;
        b=kU4LfXczpIg6cWLYygZEak5djBGXIbDLZr/jcy7OqqY7u58PHbBU5A7Nyexx/YhVSQ
         KbARPeFgDhD/wcTUvzNRfNiYPU6E8i1VAH0pDnMxw7y98vD1A2UJQ1iWOyV7min3VQPw
         iuxH4UH0lwTvUA/r4n9cxbFO6fiP5LvUzw0EsKhoXa9Ihf6+Wme56k3fxFOnGUW2vF3S
         o2knMWcM+Lqdbd3vHYJuHKYsj2xvMM0UKaFhx8GkjggVml5mBKa30EuXFd5qvkA0+MIe
         jWZjYssruwxfV7u0qwG4m/K+totdJ0M+tn79bDGzravgoPAhF5S3YxJnGFUA4d8ExgHt
         Rb0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwUaWUacdk/xcTXTH38RlvOkUZIZ+UfehzkGfTzp9g+WOpeLoQR+jkQQwe2eoT8jF4Bz3g=@vger.kernel.org
X-Gm-Message-State: AFuF++nuCDNnG+9xfEbLZC1FNLLTc2eSEgauyVEm4MgCnwV7v0lMhnhQ
	Qj7wa6HDUZ2GGG47jlCVPqP8t+nRFbnc7rKRraRkdg0n62NolHeEn7u8
X-Gm-Gg: AYBFou3apTD7stD2mrK3MewSj11zPS77QjBpbqYZHn0pODiHYq2LoGh6uwK9ulrhKIU
	7U7Dd/WB8UnlJne2FNzc+1LATnxb9puk3vG9+N5ejo+NzcqJQYD9a9RWkbEGYNvkfuO0MoNIjXK
	Mqa5fJ212pW/sudfiJpMh+IMajVO/XLdAmgPyfLRr5uTEU6b8tsJbskoGP4e4GvtcLgJNxWDVQY
	hPofUeLgwpZDGyUk2qJVrWyEO3jcPEOFcmcLTqci/aZUuTmfjFDK1DIjxgEdHiY1P8+uDcWilQZ
	3ofW9aMllp4VC/2YdWr3MXvi85p5O5Ky6Of8hduCK3x4pMy/YUmCpDxz+oK8UDAPruWfETM+NLP
	KFWVOe3vAHMQNCOWIZ/b43HjD9LbNr/sWRbKFdxnPQ6xK3HfD8a8/DSlZSU9jYc+b792u2OvVjZ
	4ViJSpnPbA32p45Mdc9O7B9w6kQEltFrWmxwqGCQwDZjtiDeZaapd8KlCPmPALD7eKcePv4BDKX
	kz8rZcL0ttbxU5bDdt6G5M8sEbkXjI=
X-Received: by 2002:a05:7300:3b28:b0:33e:6b65:5eb6 with SMTP id 5a478bee46e88-34273c40a64mr3037346eec.30.1790406151876;
        Sat, 26 Sep 2026 00:02:31 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:02:30 -0700 (PDT)
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
Subject: [PATCH v4 22/55] tcg: dispatch TL memory helpers from tcg-op-mem.h
Date: Sat, 26 Sep 2026 15:00:21 +0800
Message-ID: <20260926070057.1234-23-luoyonggang@gmail.com>
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

Move tcg_temp_new, tcg_global_mem_new, qemu ld/st, and the atomic
*_tl helpers into tcg-op-mem.h. Width follows tl_is_64(), and
TCG_ADDRESS_BITS is no longer forced to TARGET_LONG_BITS.

tcg_type_tl, the TL casts, and tcgv_tl_temp live in tcg.h so helper
wrappers can see them. Per-target tcgv_tl_temp aliases tcgv_i32_temp
or tcgv_i64_temp. The common-build inline picks the width with
tl_is_64(). A common build aliases TCGv_va to TCGv. Per-target
builds still use TARGET_LONG_BITS unless the caller sets
TCG_ADDRESS_BITS. Unit tests cover both fixed widths and a 32-bit VA
with a 64-bit target long.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/tcg/tcg-op-mem.h               | 114 +++++++++++++++++++++++--
 include/tcg/tcg-op.h                   |  61 -------------
 include/tcg/tcg.h                      |  51 +++++++++++
 tests/unit/meson.build                 |  10 +++
 tests/unit/test-tcg-op-mem-config32.h  |   2 +
 tests/unit/test-tcg-op-mem-config64.h  |   2 +
 tests/unit/test-tcg-op-mem-tl32.c      |  26 ++++++
 tests/unit/test-tcg-op-mem-tl64.c      |  26 ++++++
 tests/unit/test-tcg-op-mem-va32-tl64.c |  35 ++++++++
 tests/unit/test-tcg-op-mem.c           |  51 +++++++++++
 10 files changed, 310 insertions(+), 68 deletions(-)
 create mode 100644 tests/unit/test-tcg-op-mem-config32.h
 create mode 100644 tests/unit/test-tcg-op-mem-config64.h
 create mode 100644 tests/unit/test-tcg-op-mem-tl32.c
 create mode 100644 tests/unit/test-tcg-op-mem-tl64.c
 create mode 100644 tests/unit/test-tcg-op-mem-va32-tl64.c
 create mode 100644 tests/unit/test-tcg-op-mem.c

diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
index ea35a02fb40..82aa8a62caf 100644
--- a/include/tcg/tcg-op-mem.h
+++ b/include/tcg/tcg-op-mem.h
@@ -8,24 +8,57 @@
 #ifndef TCG_TCG_OP_MEM_H
 #define TCG_TCG_OP_MEM_H
 
-#ifndef TCG_ADDRESS_BITS
-#error TCG_ADDRESS_BITS must be defined
-#endif
-
 #include "tcg/tcg-op-common.h"
+#include "qemu/target-info.h"
+
+static inline TCGv tcg_temp_new(void)
+{
+    if (tl_is_64()) {
+        return tcg_tl_from_i64(tcg_temp_new_i64());
+    }
+    return tcg_tl_from_i32(tcg_temp_new_i32());
+}
+
+static inline TCGv tcg_global_mem_new(TCGv_ptr reg, intptr_t off,
+                                      const char *name)
+{
+    if (tl_is_64()) {
+        return tcg_tl_from_i64(tcg_global_mem_new_i64(reg, off, name));
+    }
+    return tcg_tl_from_i32(tcg_global_mem_new_i32(reg, off, name));
+}
+
+#ifdef TCG_ADDRESS_BITS
+# define TCG_VA_BITS TCG_ADDRESS_BITS
+#elif defined(COMPILING_PER_TARGET)
+# define TCG_VA_BITS TARGET_LONG_BITS
+#endif
 
-#if TCG_ADDRESS_BITS == 32
+#ifdef TCG_VA_BITS
+# if TCG_VA_BITS == 32
 typedef TCGv_i32 TCGv_va;
 #define TCG_TYPE_VA TCG_TYPE_I32
 #define tcgv_va_temp tcgv_i32_temp
 #define tcgv_va_temp_new tcg_temp_new_i32
-#elif TCG_ADDRESS_BITS == 64
+# elif TCG_VA_BITS == 64
 typedef TCGv_i64 TCGv_va;
 #define TCG_TYPE_VA TCG_TYPE_I64
 #define tcgv_va_temp tcgv_i64_temp
 #define tcgv_va_temp_new tcg_temp_new_i64
+# else
+#  error
+# endif
 #else
-#error
+/*
+ * Without a fixed TCG_ADDRESS_BITS, the VA width follows tcg_type_tl()
+ * at translation time. TCGv_va names the address role in APIs, but it
+ * aliases TCGv because their runtime widths are identical. This is
+ * semantic separation, not C type separation.
+ */
+typedef TCGv TCGv_va;
+#define TCG_TYPE_VA tcg_type_tl()
+#define tcgv_va_temp tcgv_tl_temp
+#define tcgv_va_temp_new tcg_temp_new
 #endif
 
 static inline void
@@ -125,4 +158,71 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
 #undef DEF_ATOMIC2
 #undef DEF_ATOMIC3
 
+static inline void tcg_gen_qemu_ld_tl(TCGv v, TCGv_va a, TCGArg i, MemOp m)
+{
+    if (tl_is_64()) {
+        tcg_gen_qemu_ld_i64(tcg_i64_from_tl(v), a, i, m);
+    } else {
+        tcg_gen_qemu_ld_i32(tcg_i32_from_tl(v), a, i, m);
+    }
+}
+
+static inline void tcg_gen_qemu_st_tl(TCGv v, TCGv_va a, TCGArg i, MemOp m)
+{
+    if (tl_is_64()) {
+        tcg_gen_qemu_st_i64(tcg_i64_from_tl(v), a, i, m);
+    } else {
+        tcg_gen_qemu_st_i32(tcg_i32_from_tl(v), a, i, m);
+    }
+}
+
+#define DEF_ATOMIC2_TL(N)                                       \
+    static inline void N##_tl(TCGv r, TCGv_va a, TCGv v,        \
+                              TCGArg i, MemOp m)                \
+    {                                                           \
+        if (tl_is_64()) {                                       \
+            N##_i64(tcg_i64_from_tl(r), a, tcg_i64_from_tl(v),  \
+                    i, m);                                      \
+        } else {                                                \
+            N##_i32(tcg_i32_from_tl(r), a, tcg_i32_from_tl(v),  \
+                    i, m);                                      \
+        }                                                       \
+    }
+
+#define DEF_ATOMIC3_TL(N)                                       \
+    static inline void N##_tl(TCGv r, TCGv_va a, TCGv o,        \
+                              TCGv n, TCGArg i, MemOp m)        \
+    {                                                           \
+        if (tl_is_64()) {                                       \
+            N##_i64(tcg_i64_from_tl(r), a, tcg_i64_from_tl(o),  \
+                    tcg_i64_from_tl(n), i, m);                  \
+        } else {                                                \
+            N##_i32(tcg_i32_from_tl(r), a, tcg_i32_from_tl(o),  \
+                    tcg_i32_from_tl(n), i, m);                  \
+        }                                                       \
+    }
+
+DEF_ATOMIC3_TL(tcg_gen_atomic_cmpxchg)
+
+DEF_ATOMIC2_TL(tcg_gen_atomic_xchg)
+DEF_ATOMIC2_TL(tcg_gen_atomic_fetch_add)
+DEF_ATOMIC2_TL(tcg_gen_atomic_fetch_and)
+DEF_ATOMIC2_TL(tcg_gen_atomic_fetch_or)
+DEF_ATOMIC2_TL(tcg_gen_atomic_fetch_xor)
+DEF_ATOMIC2_TL(tcg_gen_atomic_fetch_smin)
+DEF_ATOMIC2_TL(tcg_gen_atomic_fetch_umin)
+DEF_ATOMIC2_TL(tcg_gen_atomic_fetch_smax)
+DEF_ATOMIC2_TL(tcg_gen_atomic_fetch_umax)
+DEF_ATOMIC2_TL(tcg_gen_atomic_add_fetch)
+DEF_ATOMIC2_TL(tcg_gen_atomic_and_fetch)
+DEF_ATOMIC2_TL(tcg_gen_atomic_or_fetch)
+DEF_ATOMIC2_TL(tcg_gen_atomic_xor_fetch)
+DEF_ATOMIC2_TL(tcg_gen_atomic_smin_fetch)
+DEF_ATOMIC2_TL(tcg_gen_atomic_umin_fetch)
+DEF_ATOMIC2_TL(tcg_gen_atomic_smax_fetch)
+DEF_ATOMIC2_TL(tcg_gen_atomic_umax_fetch)
+
+#undef DEF_ATOMIC2_TL
+#undef DEF_ATOMIC3_TL
+
 #endif /* TCG_TCG_OP_MEM_H */
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 6835ad97901..158df47bf18 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -16,37 +16,12 @@
 #error must include QEMU headers
 #endif
 
-#define TCG_ADDRESS_BITS TARGET_LONG_BITS
 #include "tcg/tcg-op-mem.h"
 
-#if TARGET_LONG_BITS == 32
-# define TCG_TYPE_TL  TCG_TYPE_I32
-#elif TARGET_LONG_BITS == 64
-# define TCG_TYPE_TL  TCG_TYPE_I64
-#else
-# error
-#endif
-
 #if INSN_START_WORDS != 3
 # error Mismatch with insn-start-words.h
 #endif
 
-#if TARGET_LONG_BITS == 32
-#define tcg_temp_new() tcg_temp_new_i32()
-#define tcg_global_mem_new tcg_global_mem_new_i32
-#define tcgv_tl_temp tcgv_i32_temp
-#define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i32
-#define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i32
-#elif TARGET_LONG_BITS == 64
-#define tcg_temp_new() tcg_temp_new_i64()
-#define tcg_global_mem_new tcg_global_mem_new_i64
-#define tcgv_tl_temp tcgv_i64_temp
-#define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i64
-#define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i64
-#else
-#error Unhandled TARGET_LONG_BITS value
-#endif
-
 #if TARGET_LONG_BITS == 64
 #define tcg_gen_movi_tl tcg_gen_movi_i64
 #define tcg_gen_mov_tl tcg_gen_mov_i64
@@ -152,24 +127,6 @@
 #define tcg_gen_smax_tl tcg_gen_smax_i64
 #define tcg_gen_umax_tl tcg_gen_umax_i64
 #define tcg_gen_ussub_tl tcg_gen_ussub_i64
-#define tcg_gen_atomic_cmpxchg_tl tcg_gen_atomic_cmpxchg_i64
-#define tcg_gen_atomic_xchg_tl tcg_gen_atomic_xchg_i64
-#define tcg_gen_atomic_fetch_add_tl tcg_gen_atomic_fetch_add_i64
-#define tcg_gen_atomic_fetch_and_tl tcg_gen_atomic_fetch_and_i64
-#define tcg_gen_atomic_fetch_or_tl tcg_gen_atomic_fetch_or_i64
-#define tcg_gen_atomic_fetch_xor_tl tcg_gen_atomic_fetch_xor_i64
-#define tcg_gen_atomic_fetch_smin_tl tcg_gen_atomic_fetch_smin_i64
-#define tcg_gen_atomic_fetch_umin_tl tcg_gen_atomic_fetch_umin_i64
-#define tcg_gen_atomic_fetch_smax_tl tcg_gen_atomic_fetch_smax_i64
-#define tcg_gen_atomic_fetch_umax_tl tcg_gen_atomic_fetch_umax_i64
-#define tcg_gen_atomic_add_fetch_tl tcg_gen_atomic_add_fetch_i64
-#define tcg_gen_atomic_and_fetch_tl tcg_gen_atomic_and_fetch_i64
-#define tcg_gen_atomic_or_fetch_tl tcg_gen_atomic_or_fetch_i64
-#define tcg_gen_atomic_xor_fetch_tl tcg_gen_atomic_xor_fetch_i64
-#define tcg_gen_atomic_smin_fetch_tl tcg_gen_atomic_smin_fetch_i64
-#define tcg_gen_atomic_umin_fetch_tl tcg_gen_atomic_umin_fetch_i64
-#define tcg_gen_atomic_smax_fetch_tl tcg_gen_atomic_smax_fetch_i64
-#define tcg_gen_atomic_umax_fetch_tl tcg_gen_atomic_umax_fetch_i64
 #define tcg_gen_dup_tl_vec  tcg_gen_dup_i64_vec
 #define tcg_gen_dup_tl tcg_gen_dup_i64
 #define dup_const_tl dup_const
@@ -275,24 +232,6 @@
 #define tcg_gen_smax_tl tcg_gen_smax_i32
 #define tcg_gen_umax_tl tcg_gen_umax_i32
 #define tcg_gen_ussub_tl tcg_gen_ussub_i32
-#define tcg_gen_atomic_cmpxchg_tl tcg_gen_atomic_cmpxchg_i32
-#define tcg_gen_atomic_xchg_tl tcg_gen_atomic_xchg_i32
-#define tcg_gen_atomic_fetch_add_tl tcg_gen_atomic_fetch_add_i32
-#define tcg_gen_atomic_fetch_and_tl tcg_gen_atomic_fetch_and_i32
-#define tcg_gen_atomic_fetch_or_tl tcg_gen_atomic_fetch_or_i32
-#define tcg_gen_atomic_fetch_xor_tl tcg_gen_atomic_fetch_xor_i32
-#define tcg_gen_atomic_fetch_smin_tl tcg_gen_atomic_fetch_smin_i32
-#define tcg_gen_atomic_fetch_umin_tl tcg_gen_atomic_fetch_umin_i32
-#define tcg_gen_atomic_fetch_smax_tl tcg_gen_atomic_fetch_smax_i32
-#define tcg_gen_atomic_fetch_umax_tl tcg_gen_atomic_fetch_umax_i32
-#define tcg_gen_atomic_add_fetch_tl tcg_gen_atomic_add_fetch_i32
-#define tcg_gen_atomic_and_fetch_tl tcg_gen_atomic_and_fetch_i32
-#define tcg_gen_atomic_or_fetch_tl tcg_gen_atomic_or_fetch_i32
-#define tcg_gen_atomic_xor_fetch_tl tcg_gen_atomic_xor_fetch_i32
-#define tcg_gen_atomic_smin_fetch_tl tcg_gen_atomic_smin_fetch_i32
-#define tcg_gen_atomic_umin_fetch_tl tcg_gen_atomic_umin_fetch_i32
-#define tcg_gen_atomic_smax_fetch_tl tcg_gen_atomic_smax_fetch_i32
-#define tcg_gen_atomic_umax_fetch_tl tcg_gen_atomic_umax_fetch_i32
 #define tcg_gen_dup_tl_vec  tcg_gen_dup_i32_vec
 #define tcg_gen_dup_tl tcg_gen_dup_i32
 
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 7790228eeef..61c0ea78946 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -30,6 +30,7 @@
 #include "qemu/bitops.h"
 #include "qemu/plugin.h"
 #include "qemu/queue.h"
+#include "qemu/target-info.h"
 #include "tcg/tcg-mo.h"
 #include "tcg/target-reg-bits.h"
 #include "tcg-target.h"
@@ -520,6 +521,56 @@ static inline TCGTemp *tcgv_i64_temp(TCGv_i64 v)
     return tcgv_i32_temp((TCGv_i32)v);
 }
 
+static inline TCGType tcg_type_tl(void)
+{
+    return tl_is_64() ? TCG_TYPE_I64 : TCG_TYPE_I32;
+}
+
+/* Runtime TCGType from tcg_type_tl(); not a compile-time constant. */
+#define TCG_TYPE_TL tcg_type_tl()
+
+static inline TCGv_i64 tcg_i64_from_tl(TCGv v)
+{
+    tcg_debug_assert(tl_is_64());
+    return (TCGv_i64)v;
+}
+
+static inline TCGv_i32 tcg_i32_from_tl(TCGv v)
+{
+    tcg_debug_assert(!tl_is_64());
+    return (TCGv_i32)v;
+}
+
+static inline TCGv tcg_tl_from_i64(TCGv_i64 v)
+{
+    tcg_debug_assert(tl_is_64());
+    return (TCGv)v;
+}
+
+static inline TCGv tcg_tl_from_i32(TCGv_i32 v)
+{
+    tcg_debug_assert(!tl_is_64());
+    return (TCGv)v;
+}
+
+#ifdef COMPILING_PER_TARGET
+# if TARGET_LONG_BITS == 32
+#  define tcgv_tl_temp tcgv_i32_temp
+# elif TARGET_LONG_BITS == 64
+#  define tcgv_tl_temp tcgv_i64_temp
+# else
+#  error Unhandled TARGET_LONG_BITS value
+# endif
+#else
+static inline TCGTemp *tcgv_tl_temp(TCGv v)
+{
+    if (tl_is_64()) {
+        return tcgv_i64_temp(tcg_i64_from_tl(v));
+    }
+    return tcgv_i32_temp(tcg_i32_from_tl(v));
+}
+#endif
+
 static inline TCGTemp *tcgv_i128_temp(TCGv_i128 v)
 {
     return tcgv_i32_temp((TCGv_i32)v);
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index c806dbc4ffa..dc139889c1d 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -43,6 +43,16 @@ tests = {
   'test-qgraph': ['../qtest/libqos/qgraph.c'],
   'check-qom-interface': [qom],
   'check-qom-proplist': [qom],
+  'test-tcg-op-mem': [qom],
+  'test-tcg-op-mem-tl32': [declare_dependency(compile_args: [
+    '-DCOMPILING_PER_TARGET',
+    '-DCONFIG_TARGET="test-tcg-op-mem-config32.h"'])],
+  'test-tcg-op-mem-tl64': [declare_dependency(compile_args: [
+    '-DCOMPILING_PER_TARGET',
+    '-DCONFIG_TARGET="test-tcg-op-mem-config64.h"'])],
+  'test-tcg-op-mem-va32-tl64': [declare_dependency(compile_args: [
+    '-DCOMPILING_PER_TARGET',
+    '-DCONFIG_TARGET="test-tcg-op-mem-config64.h"'])],
   'test-target-info': [qom, declare_dependency(
     objects: target_info_def_objects.values(),
     compile_args: ['-DTARGET_INFO_DEF_COUNT=@0@'.format(
diff --git a/tests/unit/test-tcg-op-mem-config32.h b/tests/unit/test-tcg-op-mem-config32.h
new file mode 100644
index 00000000000..37183223edc
--- /dev/null
+++ b/tests/unit/test-tcg-op-mem-config32.h
@@ -0,0 +1,2 @@
+#define TARGET_LONG_BITS 32
+#define TARGET_BIG_ENDIAN 0
diff --git a/tests/unit/test-tcg-op-mem-config64.h b/tests/unit/test-tcg-op-mem-config64.h
new file mode 100644
index 00000000000..bcc429333bf
--- /dev/null
+++ b/tests/unit/test-tcg-op-mem-config64.h
@@ -0,0 +1,2 @@
+#define TARGET_LONG_BITS 64
+#define TARGET_BIG_ENDIAN 0
diff --git a/tests/unit/test-tcg-op-mem-tl32.c b/tests/unit/test-tcg-op-mem-tl32.c
new file mode 100644
index 00000000000..1af53172cdb
--- /dev/null
+++ b/tests/unit/test-tcg-op-mem-tl32.c
@@ -0,0 +1,26 @@
+/*
+ * tcg-op-mem.h with TARGET_LONG_BITS == 32.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "tcg/tcg-op-mem.h"
+
+static void test_tl32_aliases(void)
+{
+    g_assert_cmpint(TARGET_LONG_BITS, ==, 32);
+    g_assert_true(__builtin_types_compatible_p(__typeof__(tcg_temp_new()),
+                                               TCGv_i32));
+    g_assert_true(__builtin_types_compatible_p(
+                      __typeof__(tcg_global_mem_new(NULL, 0, "t")), TCGv_i32));
+    g_assert_true(__builtin_types_compatible_p(__typeof__(tcgv_tl_temp),
+                                               __typeof__(tcgv_i32_temp)));
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/tcg/op-mem/tl32", test_tl32_aliases);
+    return g_test_run();
+}
diff --git a/tests/unit/test-tcg-op-mem-tl64.c b/tests/unit/test-tcg-op-mem-tl64.c
new file mode 100644
index 00000000000..956c428fc31
--- /dev/null
+++ b/tests/unit/test-tcg-op-mem-tl64.c
@@ -0,0 +1,26 @@
+/*
+ * tcg-op-mem.h with TARGET_LONG_BITS == 64.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "tcg/tcg-op-mem.h"
+
+static void test_tl64_aliases(void)
+{
+    g_assert_cmpint(TARGET_LONG_BITS, ==, 64);
+    g_assert_true(__builtin_types_compatible_p(__typeof__(tcg_temp_new()),
+                                               TCGv_i64));
+    g_assert_true(__builtin_types_compatible_p(
+                      __typeof__(tcg_global_mem_new(NULL, 0, "t")), TCGv_i64));
+    g_assert_true(__builtin_types_compatible_p(__typeof__(tcgv_tl_temp),
+                                               __typeof__(tcgv_i64_temp)));
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/tcg/op-mem/tl64", test_tl64_aliases);
+    return g_test_run();
+}
diff --git a/tests/unit/test-tcg-op-mem-va32-tl64.c b/tests/unit/test-tcg-op-mem-va32-tl64.c
new file mode 100644
index 00000000000..acb834f7cb5
--- /dev/null
+++ b/tests/unit/test-tcg-op-mem-va32-tl64.c
@@ -0,0 +1,35 @@
+/*
+ * tcg-op-mem.h with a 32-bit VA and a 64-bit target long.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#define TCG_ADDRESS_BITS 32
+#include "tcg/tcg-op-mem.h"
+
+static void test_va32_tl64(void)
+{
+    g_assert_cmpint(TARGET_LONG_BITS, ==, 64);
+    g_assert_cmpint(TCG_ADDRESS_BITS, ==, 32);
+    g_assert_cmpint(tcg_type_tl(), ==, TCG_TYPE_I64);
+    g_assert_cmpint(TCG_TYPE_VA, ==, TCG_TYPE_I32);
+    g_assert_true(__builtin_types_compatible_p(__typeof__(tcg_temp_new()),
+                                               TCGv_i64));
+    g_assert_true(__builtin_types_compatible_p(
+                      __typeof__(tcg_global_mem_new(NULL, 0, "t")), TCGv_i64));
+    g_assert_true(__builtin_types_compatible_p(__typeof__(tcgv_tl_temp),
+                                               __typeof__(tcgv_i64_temp)));
+    g_assert_true(__builtin_types_compatible_p(__typeof__(tcgv_va_temp_new()),
+                                               TCGv_i32));
+    g_assert_true(__builtin_types_compatible_p(__typeof__(tcgv_va_temp),
+                                               __typeof__(tcgv_i32_temp)));
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/tcg/op-mem/va32-tl64", test_va32_tl64);
+    return g_test_run();
+}
diff --git a/tests/unit/test-tcg-op-mem.c b/tests/unit/test-tcg-op-mem.c
new file mode 100644
index 00000000000..b6bda01e93b
--- /dev/null
+++ b/tests/unit/test-tcg-op-mem.c
@@ -0,0 +1,51 @@
+/*
+ * Compile tcg-op-mem.h with no fixed VA width.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info-def.h"
+#include "tcg/tcg-op-mem.h"
+
+static const TargetInfo tl32_info = {
+    .target_name = "tl32",
+    .long_bits = 32,
+};
+
+static const TargetInfo tl64_info = {
+    .target_name = "tl64",
+    .long_bits = 64,
+};
+
+static void test_runtime_tl_ops(void)
+{
+    TCGType expect = tl_is_64() ? TCG_TYPE_I64 : TCG_TYPE_I32;
+
+    g_assert_cmpint(tcg_type_tl(), ==, expect);
+    g_assert_true(__builtin_types_compatible_p(__typeof__(tcg_temp_new()),
+                                               TCGv));
+    g_assert_true(__builtin_types_compatible_p(
+                      __typeof__(tcg_global_mem_new(NULL, 0, "t")), TCGv));
+    g_assert_true(__builtin_types_compatible_p(
+                      __typeof__(tcgv_tl_temp((TCGv)NULL)), TCGTemp *));
+}
+
+static void test_runtime_tl_width(void)
+{
+    target_info_select(&tl32_info);
+    g_assert_false(tl_is_64());
+    g_assert_cmpint(tcg_type_tl(), ==, TCG_TYPE_I32);
+
+    target_info_select(&tl64_info);
+    g_assert_true(tl_is_64());
+    g_assert_cmpint(tcg_type_tl(), ==, TCG_TYPE_I64);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/tcg/op-mem/runtime-tl", test_runtime_tl_ops);
+    g_test_add_func("/tcg/op-mem/runtime-tl-width", test_runtime_tl_width);
+    return g_test_run();
+}
-- 
2.52.0.windows.1

