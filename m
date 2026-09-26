Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4F214ABE
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406168; cv=none; b=EhHPXCBmfhKTb37ff5vkbk8Qsq5QjZ/vTk0wJM3kIsrvK+qECCGOzzaw7nkPfLKy97yxq+PqkdsbM9tsgQOmKivBbIesElzSLf34dfRWPV4cwCvsXb23aZilGQUPjxwgG+a+yfwQf7TU7uVid5U2NMt9sopIGz0IVbDlZCeGg1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406168; c=relaxed/simple;
	bh=+GMw0VnuMctqHfurPl9pKH38cBmASQpT6H2E7jbKpA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiqeeLXYXqcYUnDHRVJwcWJX/eWlTHWUqeWLFF38a/ACj0SWvJSNKeYP2AdIGS7dI6KpPTjz/pJ8U6Qe4D3uDhl5qbtB8Lj7ibO5uBAfeUCKenjFkLLGVRxAtUmbXUq2cXS1XvkI6i0CVz975tR9OofyXOatKiqHgrI1eBMrjJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilZ7C+fa; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilZ7C+fa"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bfb26865fso1387864eec.2
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406164; x=1791010964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+/cSI9KSeYzGrYLevJhsdqe9Hab1ATMpzGrHMp6RW0U=;
        b=ilZ7C+fatFQ1OttakiaasqU7XlUsTOMjVkcGxs8SYtmoyI6ZnmQlUwP7gop7paiDl0
         Do90Fx6Oq1+dh5l4pH7iq1aSifLm+35BCNAT+WX8z8A8rlhqGGwIlt+RlJlglbgQwUYN
         20ntBXgQA+uqfHyVlq6kP5ONT6CTcun2r+mdsVjhGw4vHqQ4D0m3eBXSA9CVxMF3Nymj
         xkimonFhdw9Wt4r7E7WZAhgcq9VeUMYLYcRaDPyfgeTrB4i0hDbj7d0YDkASHQeTGjYX
         h/SBJVK0779KNIFx9XLbDjpUMeRyKWGmNP3K4T3Wu3AnviVtdPgh8jVV9c22U73U7QfD
         Mfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406164; x=1791010964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+/cSI9KSeYzGrYLevJhsdqe9Hab1ATMpzGrHMp6RW0U=;
        b=QixVE9dJeUhan6fcRFsaZI1sFGrOpzuHKXxkqJ1sgcy6r2VUWPp0w1I+VzVDbjCvv2
         TVNncC9Syv96U32e9KNFc1spxwELr71gvowtUzBJ/akDdu9QKVM2VCNdfTb3mp01Vwtd
         cmTr1eFOPdZvu/jWc0/IkNOHBIAE6WTTiDqLR1ne04y4UqW9D3ec4AwRkIs/HEvwvO+6
         CfXV7eKX2g8sCG3ykMQEclNAoup1R6KDs7zBlrHp5VM4whzH/5eiO3Dzgd6JHZ09i7Iw
         AlBkmeh7e0kj8P7xNpcYHsBeQ/ia+3KxS17l//HslcoCuXArluBnO7C/glSuU66RGJzn
         6fNA==
X-Forwarded-Encrypted: i=1; AKwUvBzoJNXXgBkWtFZV40OchpcDzeBwcWrhpLj9YVJ7sQs2tgLUOI1mNEhBzxTrF1F+b3LHM5o=@vger.kernel.org
X-Gm-Message-State: AFuF++nQis6XjBOK3bJLGfJXNRGSPTu6C8fiIpELMXVRvCYD3S3zY2NV
	QpG77LuKRw5tT3F3BZiimFaAYAg4HCuvGAqC4jcpIsUIqc6ThofEZqdo
X-Gm-Gg: AYBFou0pY8lfrXb/jwTW0aLdrn73J34ccCShGPByFofujsCq4ZWDZehBJkGHkV4l9l9
	Aglzc7uzmibiqOcEMsgD/SxrjI71/B8rTHE2NkdywJ1AuM19w9RymhkFYndbJ37JjOiL7U/aAzw
	JxH8hH6iS2IYF3MnOxu1b34xlFFytUsB3gJ3d7tfsrt7g02ZTjuDKsP2UFA9EeXJk7OO1VZ1yhp
	2h+KjnguZUS3hsdQrccC4w6Jm1csHLF7kCX6AjCpXEdlkJi947sIMhKsz5lXZedlMAZesNag3SS
	C/xLIGl95OTd4Wn5EKruVxk6k6baF1HgQZkHzy+ETnhGupk3tj5yCuyBUThqrwT6mX1jOmKiSeD
	qax/voCgAhvbsQt6tQGtdXFopvdrgZFWstlICvbdjhOm8O4CnXYJFKQnFCFT0NJ0Dq186E3ljKb
	PPoOuQPCyVY2iFbgF5p5L0NuoZCAEyapuyTSk+7J/yFaNuR2JA5d3jAKXA0zeGVvQJlec5IkKdR
	mPBK6kOduCLD5iFacQEIJvsHFDpdGA=
X-Received: by 2002:a05:7301:7e04:b0:33b:c122:6bd4 with SMTP id 5a478bee46e88-342701bed7amr1810144eec.6.1790406164340;
        Sat, 26 Sep 2026 00:02:44 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:02:43 -0700 (PDT)
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
Subject: [PATCH v4 25/55] tcg: give common-system helper tl an i64 slot
Date: Sat, 26 Sep 2026 15:00:24 +0800
Message-ID: <20260926070057.1234-26-luoyonggang@gmail.com>
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

dh_alias_tl stays tl. In common-system code the helper C slot stays
uint64_t and the typecode stays i64, because one typemask is shared
by 32- and 64-bit guests. tcg_gen_callN zero-extends an I32 temp into
that slot and truncates an i64 return.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/exec/helper-head.h.inc | 21 ++++++++++++++++++--
 tcg/tcg.c                      | 35 ++++++++++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/include/exec/helper-head.h.inc b/include/exec/helper-head.h.inc
index 7dec5f5b067..6612937c5ae 100644
--- a/include/exec/helper-head.h.inc
+++ b/include/exec/helper-head.h.inc
@@ -45,16 +45,29 @@
 #define dh_ctype_noreturn G_NORETURN void
 #define dh_ctype(t) dh_ctype_##t
 
+#define dh_alias_tl tl
 #ifdef COMPILING_PER_TARGET
 # include "exec/target_long.h"
 # if TARGET_LONG_BITS == 32
-#  define dh_alias_tl i32
 #  define dh_typecode_tl dh_typecode_i32
 # else
-#  define dh_alias_tl i64
 #  define dh_typecode_tl dh_typecode_i64
 # endif
 # define dh_ctype_tl target_ulong
+#else
+/*
+ * Common-system helper FFI only: helper_info.typemask is compile-time
+ * and shared by 32- and 64-bit guests, so the C/libffi slot is
+ * max(i32, i64) -- always i64 / uint64_t. This is not the TCG temp
+ * width. TCGv_tl stays dynamic (I32 or I64 via tcg_type_tl());
+ * tcgv_tl_temp() is the handle-to-TCGTemp accessor and is valid for
+ * either size. Call lowering zero-extends an I32 temp into this
+ * unsigned i64 slot (dh_typecode_tl is i64, not s64). A helper C
+ * body that needs a signed guest value must narrow to XLEN and
+ * sign-extend itself; (int64_t)arg is not a 32-bit sign-extend.
+ */
+# define dh_typecode_tl dh_typecode_i64
+# define dh_ctype_tl uint64_t
 #endif /* COMPILING_PER_TARGET */
 
 #if __SIZEOF_POINTER__ == 4
@@ -76,6 +89,7 @@
 #define dh_retvar_decl0_i64 TCGv_i64 retval
 #define dh_retval_decl0_i128 TCGv_i128 retval
 #define dh_retvar_decl0_ptr TCGv_ptr retval
+#define dh_retvar_decl0_tl TCGv_tl retval
 #define dh_retvar_decl0(t) glue(dh_retvar_decl0_, dh_alias(t))
 
 #define dh_retvar_decl_void
@@ -84,6 +98,7 @@
 #define dh_retvar_decl_i64 TCGv_i64 retval,
 #define dh_retvar_decl_i128 TCGv_i128 retval,
 #define dh_retvar_decl_ptr TCGv_ptr retval,
+#define dh_retvar_decl_tl TCGv_tl retval,
 #define dh_retvar_decl(t) glue(dh_retvar_decl_, dh_alias(t))
 
 #define dh_retvar_void NULL
@@ -92,6 +107,7 @@
 #define dh_retvar_i64 tcgv_i64_temp(retval)
 #define dh_retvar_i128 tcgv_i128_temp(retval)
 #define dh_retvar_ptr tcgv_ptr_temp(retval)
+#define dh_retvar_tl tcgv_tl_temp(retval)
 #define dh_retvar(t) glue(dh_retvar_, dh_alias(t))
 
 #define dh_typecode_void 0
@@ -115,6 +131,7 @@
 #define dh_callflag_i64  0
 #define dh_callflag_i128 0
 #define dh_callflag_ptr  0
+#define dh_callflag_tl   0
 #define dh_callflag_void 0
 #define dh_callflag_noreturn TCG_CALL_NO_RETURN
 #define dh_callflag(t) glue(dh_callflag_, dh_alias(t))
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ecc1f54c1bf..ba2a1127f92 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2515,6 +2515,8 @@ static void tcg_gen_callN(void *func, TCGHelperInfo *info,
                           TCGTemp *ret, TCGTemp **args)
 {
     TCGv_i64 extend_free[MAX_CALL_IARGS];
+    TCGv_i64 ret_temp = NULL;
+    TCGTemp *orig_ret = ret;
     int n_extend = 0;
     TCGOp *op;
     int i, n, pi = 0, total_args;
@@ -2524,6 +2526,19 @@ static void tcg_gen_callN(void *func, TCGHelperInfo *info,
         g_once_init_leave(HELPER_INFO_INIT(info), HELPER_INFO_INIT_VAL(info));
     }
 
+    /*
+     * An I32 temp in an i64 slot is zero-extended; s64 is sign-extended.
+     * The call returns the wide temp, then extrl writes the I32 back.
+     */
+    if (ret != NULL && ret->type == TCG_TYPE_I32) {
+        unsigned typecode = info->typemask & 7;
+
+        if (typecode == dh_typecode_i64 || typecode == dh_typecode_s64) {
+            ret_temp = tcg_temp_ebb_new_i64();
+            ret = tcgv_i64_temp(ret_temp);
+        }
+    }
+
     total_args = info->nr_out + info->nr_in + 2;
     op = tcg_op_alloc(INDEX_op_call, total_args);
 
@@ -2560,8 +2575,19 @@ static void tcg_gen_callN(void *func, TCGHelperInfo *info,
     for (i = 0; i < n; i++) {
         const TCGCallArgumentLoc *loc = &info->in[i];
         TCGTemp *ts = args[loc->arg_idx] + loc->tmp_subindex;
+        TCGCallArgumentKind kind = loc->kind;
 
-        switch (loc->kind) {
+        if (kind == TCG_CALL_ARG_NORMAL && ts->type == TCG_TYPE_I32) {
+            unsigned typecode =
+                extract32(info->typemask, (loc->arg_idx + 1) * 3, 3);
+
+            if (typecode == dh_typecode_i64 ||
+                typecode == dh_typecode_s64) {
+                kind = TCG_CALL_ARG_EXTEND_U + (typecode & 1);
+            }
+        }
+
+        switch (kind) {
         case TCG_CALL_ARG_NORMAL:
         case TCG_CALL_ARG_BY_REF:
         case TCG_CALL_ARG_BY_REF_N:
@@ -2574,7 +2600,7 @@ static void tcg_gen_callN(void *func, TCGHelperInfo *info,
                 TCGv_i64 temp = tcg_temp_ebb_new_i64();
                 TCGv_i32 orig = temp_tcgv_i32(ts);
 
-                if (loc->kind == TCG_CALL_ARG_EXTEND_S) {
+                if (kind == TCG_CALL_ARG_EXTEND_S) {
                     tcg_gen_ext_i32_i64(temp, orig);
                 } else {
                     tcg_gen_extu_i32_i64(temp, orig);
@@ -2602,6 +2628,11 @@ static void tcg_gen_callN(void *func, TCGHelperInfo *info,
     for (i = 0; i < n_extend; ++i) {
         tcg_temp_free_i64(extend_free[i]);
     }
+
+    if (ret_temp != NULL) {
+        tcg_gen_extrl_i64_i32(temp_tcgv_i32(orig_ret), ret_temp);
+        tcg_temp_free_i64(ret_temp);
+    }
 }
 
 void tcg_gen_call0(void *func, TCGHelperInfo *info, TCGTemp *ret)
-- 
2.52.0.windows.1

