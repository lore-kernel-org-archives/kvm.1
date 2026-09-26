Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CAF34E766
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406183; cv=none; b=cH2IDMSrHWUHvnGRKc7VcIdXpr0+RrT2MUJgSGycdCakboC4gok6lM9UAmRzx61+4Utro0FSKfPj9PlAwoncrkI93Y7uO9x1Po4i/R1PFY8k4Vd+QTF2G94i4bNSPw11G8ZOq/LW0EWw37WD8tRKC7x4oLxBj//WrZ9xQoDmyxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406183; c=relaxed/simple;
	bh=P1YdT9P6GQwajIjvwzlfdEFB2moBTBTTBLwfow8HZm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+CvfI0W68kFBCx4ehi5LqX+ofuYyFPQ4jqalHF0kcmFD4RSLNucQTBkIvzgQM5WKFI6/SoOthltJY6mwn/OM7SQLwsFzGkYNBEaIwFw7T/3/AIrqkdyFVRVFPb/5sOm28ydVh7wf8MBrlR/zg6JgOrRujUE4NDWxwpkanFmbbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0OCA7g9; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0OCA7g9"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e46a156f4so855843eec.0
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406180; x=1791010980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o68RHY+8I/fHBwtLuIUKNDGtiU+yJ8dKoStrzzdIylI=;
        b=l0OCA7g91HpR4p1Y/4OAHTLQkkgZ9ZqECQyHACCJbvNYq64HQ7elKJbt3tQAlRt/Ix
         in7cvuP+0lm0iIIrHwKAthsRXmBDcmjUp1I+e4ory7o4hbOIYFkimHJWxBjUhBxqet1J
         aLMmvAEU0nI2ewci2sYIGcZUoIbTs0JM2ckSTK4wS+BTgcmhMOioyYJ1+4pVBmhUsHGM
         7LX2iQLzpmWGsMQ8Z1c4EHZTonzBH2eF3sMs0S+Kpqx+12foptD2N5GrGi3BMRwc82PF
         39IYc5kcXQWLVeM0UvekQVl3NYyp0y2yq4CYGvXKJn1JDGXgEeHjKWtAkM0CHm558PZm
         bLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406180; x=1791010980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o68RHY+8I/fHBwtLuIUKNDGtiU+yJ8dKoStrzzdIylI=;
        b=Q2wFKVJGLrUSQcTwxSk+43VBMUQEYmzP6KppbUZSItzqvMQ55KtsGrNPOID2odLUTc
         jrcXhdiCjJnT4bCj3Zmbr4n5LDx+hRsAf9sdXoKzQ4Vm2OVG94X+lEs9dbQXJdcb/ZVX
         qrksr59KfyyoXnGqlcGbYmP10gIJsYTZQDVvGYxnxscTqj1xo1tqnOL+f+NF0mZTpCBY
         DEItJmy4sv+FsWu/oPRk8SRe2aDtoi1vudkITACvjJTghwMR+Tlc1nKydUB1MO+rRsDm
         2cMHjWmyc3ANAjdxcZn6bEM4KBkIcTO0Vsx7jvgbTa3xvnm5a0Ng+cntwoqDJlJk77B0
         4+gQ==
X-Forwarded-Encrypted: i=1; AKwUvBxTT+5tAGL5MIZ8J+tfefkW898km072bTfEzBrzm/FU9s3NnWQBtnzE0y9BdJIZM7UjrX8=@vger.kernel.org
X-Gm-Message-State: AFuF++kLfHu2EPGl1ju8f/gR2admU5NFa670h/fhX3Sr1llID0UbtUOK
	E6uvWhBYe2ahG04E0P3rCekzAeMW50SMkd6SFUA4TfnlzmgfPYgnTBGo
X-Gm-Gg: AYBFou0mAbZEM5+fOymXJkV0xyMVLCYE7snlNnxeV6zMJQ99qKi0stz4euRiYNyWk7u
	y9MfPdDtVJeqPoV8oQX3Qg9LxmD2d8GzmDKTpeiT12l0h+e8s4IPlPUx/3Myv9Tz15fZukf5NbJ
	/BzsdWFGQSMbhrTWLsv2KDFCudKaH9wqDFiu389SO/i1t5Sv6wEL4TRh1fLgXmXdnm8W7jI5ZQj
	SqO1gsFvm1stUC0nav6z/DSRSMlqhQm55Xzz7l+NeUI7hHf0hjjtszuguCpBUugOAH79i5EMzQw
	t+Np6x2vhuikWjhAGmikFDgf+M5y8bjsPDZti316ppd6xk47IoBsinXUHCEWQH12bW6xMTgojSD
	rSr6G+saQMCwvxp/1AjhunX0TYJkzuBzKel30cj5At4vnCm0RYEPscFCIjLdurwqtB46F9oQA35
	4P/qVeTsoOou5/126MLkl+2DXID1h3uTbfc4jN8N9C4wXMtSHZXnlp4eQcNAfpliKnfXbzKwMuW
	s3CsDZk+/iFrqEPbdIMF8ml3R1FtJw=
X-Received: by 2002:a05:7301:53c5:b0:33b:c23b:f2b7 with SMTP id 5a478bee46e88-34272c5c606mr1989923eec.30.1790406180277;
        Sat, 26 Sep 2026 00:03:00 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:02:59 -0700 (PDT)
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
Subject: [PATCH v4 29/55] accel/tcg: move gvec helpers into tcg-runtime-gvec.h
Date: Sat, 26 Sep 2026 15:00:28 +0800
Message-ID: <20260926070057.1234-30-luoyonggang@gmail.com>
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

The gvec helpers are implemented in tcg-runtime-gvec.c. Move their
DEF_HELPER lines to tcg-runtime-gvec.h and emit the helper_info
records from that file.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 accel/tcg/tcg-runtime-gvec.c                  |   3 +
 .../tcg/{tcg-runtime.h => tcg-runtime-gvec.h} | 109 ----------
 accel/tcg/tcg-runtime.h                       | 204 ------------------
 include/exec/helper-gen-common.h              |   4 +
 include/exec/helper-proto-common.h            |   4 +
 5 files changed, 11 insertions(+), 313 deletions(-)
 copy accel/tcg/{tcg-runtime.h => tcg-runtime-gvec.h} (71%)

diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index 67a741e45e1..1bc8fbc31fa 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -22,6 +22,9 @@
 #include "exec/helper-proto-common.h"
 #include "tcg/tcg-gvec-desc.h"
 
+#define HELPER_H  "accel/tcg/tcg-runtime-gvec.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
 
 static inline void clear_high(void *d, intptr_t oprsz, uint32_t desc)
 {
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime-gvec.h
similarity index 71%
copy from accel/tcg/tcg-runtime.h
copy to accel/tcg/tcg-runtime-gvec.h
index 9b4c1c24916..603b0ba8590 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime-gvec.h
@@ -1,112 +1,3 @@
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
-DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, cptr, env)
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
-
 DEF_HELPER_FLAGS_3(gvec_mov, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_3(gvec_dup8, TCG_CALL_NO_RWG, void, ptr, i32, i32)
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 9b4c1c24916..c0626fa0e02 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -106,207 +106,3 @@ GEN_ATOMIC_HELPERS(umax_fetch)
 GEN_ATOMIC_HELPERS(xchg)
 
 #undef GEN_ATOMIC_HELPERS
-
-DEF_HELPER_FLAGS_3(gvec_mov, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_dup8, TCG_CALL_NO_RWG, void, ptr, i32, i32)
-DEF_HELPER_FLAGS_3(gvec_dup16, TCG_CALL_NO_RWG, void, ptr, i32, i32)
-DEF_HELPER_FLAGS_3(gvec_dup32, TCG_CALL_NO_RWG, void, ptr, i32, i32)
-DEF_HELPER_FLAGS_3(gvec_dup64, TCG_CALL_NO_RWG, void, ptr, i32, i64)
-
-DEF_HELPER_FLAGS_4(gvec_add8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_add16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_add32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_add64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_adds8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_adds16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_adds32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_adds64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-
-DEF_HELPER_FLAGS_4(gvec_sub8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_sub16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_sub32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_sub64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_subs8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_subs16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_subs32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_subs64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-
-DEF_HELPER_FLAGS_4(gvec_mul8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_mul16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_mul32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_mul64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_muls8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_muls16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_muls32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_muls64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-
-DEF_HELPER_FLAGS_4(gvec_ssadd8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_ssadd16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_ssadd32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_ssadd64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_sssub8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_sssub16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_sssub32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_sssub64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_usadd8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_usadd16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_usadd32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_usadd64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_ussub8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_ussub16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_ussub32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_ussub64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_smin8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_smin16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_smin32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_smin64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_smax8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_smax16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_smax32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_smax64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_umin8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_umin16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_umin32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_umin64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_umax8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_umax16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_umax32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_umax64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_neg8, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_neg16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_neg32, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_neg64, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_abs8, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_abs16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_abs32, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_abs64, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_not, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_and, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_or, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_xor, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_andc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_orc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_nand, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_nor, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_eqv, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_ands, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_andcs, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_xors, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_ors, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-
-DEF_HELPER_FLAGS_3(gvec_shl8i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_shl16i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_shl32i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_shl64i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_shr8i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_shr16i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_shr32i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_shr64i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_sar8i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_sar16i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_sar32i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_sar64i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_rotl8i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_rotl16i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_rotl32i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_rotl64i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_shl8v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_shl16v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_shl32v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_shl64v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_shr8v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_shr16v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_shr32v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_shr64v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_sar8v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_sar16v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_sar32v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_sar64v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_rotl8v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_rotl16v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_rotl32v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_rotl64v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_rotr8v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_rotr16v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_rotr32v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_rotr64v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_eq8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_eq16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_eq32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_eq64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_ne8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_ne16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_ne32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_ne64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_lt8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_lt16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_lt32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_lt64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_le8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_le16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_le32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_le64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_ltu8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_ltu16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_ltu32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_ltu64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_leu8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_leu16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_leu32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_leu64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_eqs8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_eqs16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_eqs32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_eqs64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-
-DEF_HELPER_FLAGS_4(gvec_lts8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_lts16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_lts32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_lts64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-
-DEF_HELPER_FLAGS_4(gvec_les8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_les16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_les32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_les64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-
-DEF_HELPER_FLAGS_4(gvec_ltus8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_ltus16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_ltus32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_ltus64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-
-DEF_HELPER_FLAGS_4(gvec_leus8, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_leus16, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_leus32, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-DEF_HELPER_FLAGS_4(gvec_leus64, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
-
-DEF_HELPER_FLAGS_5(gvec_bitsel, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/include/exec/helper-gen-common.h b/include/exec/helper-gen-common.h
index ed5521ad881..fa571d88147 100644
--- a/include/exec/helper-gen-common.h
+++ b/include/exec/helper-gen-common.h
@@ -15,4 +15,8 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "accel/tcg/tcg-runtime-gvec.h"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 #endif /* HELPER_GEN_COMMON_H */
diff --git a/include/exec/helper-proto-common.h b/include/exec/helper-proto-common.h
index 28afa7782d0..1b098777e8d 100644
--- a/include/exec/helper-proto-common.h
+++ b/include/exec/helper-proto-common.h
@@ -17,6 +17,10 @@
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "accel/tcg/tcg-runtime-gvec.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 #include "accel/tcg/getpc.h"
 
 #endif /* HELPER_PROTO_COMMON_H */
-- 
2.52.0.windows.1

