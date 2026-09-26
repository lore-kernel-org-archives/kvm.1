Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3593C34E766
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406179; cv=none; b=cmjjj98M5I+GwwArGaQHJVZKHkdej9AW7VOdpSvBmLO+bxl00IQcKd0eBhgPT093GyGqnCbrrOzBLfv46c01kCeB6nQ4nEaQvY28QqrbdF7lsXWTLKdppd8SC9UhEIeX0j76O3y024rZI7IRsqrW1TG08unDENX0bNiZqwvbW20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406179; c=relaxed/simple;
	bh=CaqIA4whkiqD2lY5c09Dfa6anK+K7UFc5IIHOoQLVyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B38nDjLgFa/FToypOBFcpuOTBkTH1K1AqDlnaATIP9pCPzM1Fg/G+m1rq0Z2vPswGb36V+C5S39dJlyg5nvfAJmul/Io8uTTyuf3I9nQuZpcUKeUr88YunqF34uRCSnbpnlyXr0zrVtzrDmmGCnfn8SOfSqqwdIBl68qBv1reZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4mS9lqK; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4mS9lqK"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341f6327b95so909438eec.0
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406177; x=1791010977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=awp3H7a2O80uyPRL2fhVcR6Bx9g9YW6vpgBv8R062bc=;
        b=V4mS9lqKGg5hrGa3RkOvP0OrH9GcZvomq+ZpFDPaw5KCPJCWPZ70gz4j197At0IHLm
         gZNOc90RKcAt3vMWcgEtKBvF/b7hkG3TwI4bACooRdqkztFzDolqrc6UTUascWnrd9nE
         0VtJhrrGN9xz+ZnbYAt2u3CFpcEqTuxlKnDP90hkUWPA68oePji0rZNlsaBaKtk47Sod
         Iegjd+5blANhyAV9c8wOx6bOcfF7GFLoMpJxWLeJtdq0Il/3Hqt/3QkUDB17rvWZqto/
         /2963RQ8Y8cp76kQ24Yt5unvuF997bCXAUTrNlpt8Yt8Z/qDNtdOsHvV8aX6f44TAdf1
         uozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406177; x=1791010977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=awp3H7a2O80uyPRL2fhVcR6Bx9g9YW6vpgBv8R062bc=;
        b=M4lXRftrmbuE4FHgAa1vIo6eA/sbQgt43pZw9zJti8P6DErAVyLRZVZHsgx3KjYPBO
         OLJB8JkiX9+DnKIzN9F3wYVIFLdTsGLAtQzby/g9HTdP9y6adDp8ftyDjfXiRI8gFs/X
         H2G+EjIBQ0cvdgrwlQtqbnK6/VLLAbSRkigiqmBLIC2F56FzhZukzi+DBvoEDh1wYaWL
         MSiElkaJ6xpBEJ6zcmrrjSsYV1OxSfTff/0Q6xbWC8KPsZO+cOC+rNFgarZAKC363Q40
         88qhqlzWaHIReQrXotlr0DR66YjTwTxINvaBc6sTIkcz1yFSK9z5CwTCU+7hcfU2YXN2
         BF3w==
X-Forwarded-Encrypted: i=1; AKwUvByK3Pad8Cuw2yp5OCxpW+VVb+7O5431MqzYlKZHWE3gW2fo/Cw4yHZU+GvQCGM9xlb30sY=@vger.kernel.org
X-Gm-Message-State: AFuF++nlkTN5wfyks6Z1u2Anp0pV0RHbhg+OYGwMF6mkXq+Bk3nAINN8
	biexIbaACRtNZ+dDr+rK9BI7DMHmuErQmzU65ZL92g+Tb/u7yZ9aHLCn
X-Gm-Gg: AYBFou1jChKHBtjn77imQfkgde5GKffOVE5c9b3fbfk8mL2PeitD4tEalxGPjGimDUN
	ID1WTJ1KNvm7fBcx2qiR5Dxz+/JlVsVh0Ki7CoLuCrg8Y6VFfOGnJAviadXoBYxkfu9MlnDyQ5N
	LvLQviBpGYjBuQhzAMYJuX2e1i6nnQ4I1+MYMPkfcBBpRD6k4P0VgfTKYu1kzM1btKnTKqfSGL7
	68fjs3uJVJ34mf7+2BfHYev/dJA9xAxXWtBYZrG0CZ0MOk+gI1aBw4wCvcBhLsvjaRR3ueOYXBl
	609WV8XnSPl0Ei59VWX49kUCVvv3nI38idPh+Sb0K9fbRsiNGTGluP7k+PmTv38zIk0KTYsKyCH
	2YZkGmT7a4ZIN9jCvqNdt2VigrGNO3iXV6PekO0p5/iMLrLrP4hWFfQzqpn2u3fObKKT0VOdERI
	Wa2/7gACxG+dwYVZ5xs+rpi/bom3/xe9Jts6vsRlMLiiGMlqO96w+5asL9M/mB1wU2Jw2ZVmZRN
	Apx55UTX95q01c/nzb5pjK9i1VtzuU=
X-Received: by 2002:a05:7300:d10a:b0:33b:e1f2:fa10 with SMTP id 5a478bee46e88-34271d8d2fbmr1860726eec.24.1790406176444;
        Sat, 26 Sep 2026 00:02:56 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:02:54 -0700 (PDT)
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
Subject: [PATCH v4 28/55] tcg: move goto_tb helpers into tcg-op-ldst.c
Date: Sat, 26 Sep 2026 15:00:27 +0800
Message-ID: <20260926070057.1234-29-luoyonggang@gmail.com>
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

tcg_gen_goto_tb and tcg_gen_lookup_and_goto_ptr call plugin and
lookup_tb_ptr helpers. Define them in tcg-op-ldst.c. tcg_gen_op1i is
static in tcg-op.c, so the moved calls use tcg_gen_op1.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tcg/tcg-op-ldst.c | 31 +++++++++++++++++++++++++++++++
 tcg/tcg-op.c      | 32 --------------------------------
 2 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 22211ccb452..fb13c2f1523 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -1346,3 +1346,34 @@ GEN_ATOMIC_HELPER128(xchg, mov2, 0)
 
 #undef GEN_ATOMIC_HELPER
 #undef GEN_ATOMIC_HELPER128
+
+void tcg_gen_goto_tb(unsigned idx)
+{
+    /* We tested CF_NO_GOTO_TB in translator_use_goto_tb. */
+    tcg_debug_assert(!(tcg_ctx->gen_tb->cflags & CF_NO_GOTO_TB));
+    /* We only support two chained exits.  */
+    tcg_debug_assert(idx <= TB_EXIT_IDXMAX);
+#ifdef CONFIG_DEBUG_TCG
+    /* Verify that we haven't seen this numbered exit before.  */
+    tcg_debug_assert((tcg_ctx->goto_tb_issue_mask & (1 << idx)) == 0);
+    tcg_ctx->goto_tb_issue_mask |= 1 << idx;
+#endif
+    plugin_gen_disable_mem_helpers();
+    tcg_gen_op1(INDEX_op_goto_tb, 0, idx);
+}
+
+void tcg_gen_lookup_and_goto_ptr(void)
+{
+    TCGv_ptr ptr;
+
+    if (tcg_ctx->gen_tb->cflags & CF_NO_GOTO_PTR) {
+        tcg_gen_exit_tb(NULL, 0);
+        return;
+    }
+
+    plugin_gen_disable_mem_helpers();
+    ptr = tcg_temp_ebb_new_ptr();
+    gen_helper_lookup_tb_ptr(ptr, tcg_env);
+    tcg_gen_op1(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
+    tcg_temp_free_ptr(ptr);
+}
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2c88f4f7ca9..bd3bae37500 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -27,7 +27,6 @@
 #include "tcg/tcg-temp-internal.h"
 #include "tcg/tcg-op-common.h"
 #include "exec/translation-block.h"
-#include "exec/plugin-gen.h"
 #include "tcg-internal.h"
 #include "tcg-has.h"
 
@@ -2699,34 +2698,3 @@ void tcg_gen_exit_tb(const TranslationBlock *tb, unsigned idx)
 
     tcg_gen_op1i(INDEX_op_exit_tb, 0, val);
 }
-
-void tcg_gen_goto_tb(unsigned idx)
-{
-    /* We tested CF_NO_GOTO_TB in translator_use_goto_tb. */
-    tcg_debug_assert(!(tcg_ctx->gen_tb->cflags & CF_NO_GOTO_TB));
-    /* We only support two chained exits.  */
-    tcg_debug_assert(idx <= TB_EXIT_IDXMAX);
-#ifdef CONFIG_DEBUG_TCG
-    /* Verify that we haven't seen this numbered exit before.  */
-    tcg_debug_assert((tcg_ctx->goto_tb_issue_mask & (1 << idx)) == 0);
-    tcg_ctx->goto_tb_issue_mask |= 1 << idx;
-#endif
-    plugin_gen_disable_mem_helpers();
-    tcg_gen_op1i(INDEX_op_goto_tb, 0, idx);
-}
-
-void tcg_gen_lookup_and_goto_ptr(void)
-{
-    TCGv_ptr ptr;
-
-    if (tcg_ctx->gen_tb->cflags & CF_NO_GOTO_PTR) {
-        tcg_gen_exit_tb(NULL, 0);
-        return;
-    }
-
-    plugin_gen_disable_mem_helpers();
-    ptr = tcg_temp_ebb_new_ptr();
-    gen_helper_lookup_tb_ptr(ptr, tcg_env);
-    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
-    tcg_temp_free_ptr(ptr);
-}
-- 
2.52.0.windows.1

