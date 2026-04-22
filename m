Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E2B3DCD91
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863268; cv=none; b=LsNdCms+4ncnX5DKYMmoBbj/tH6836ljzrVOVpLEvePcF0OZlsfVwArXJAYIMwStOzAmCrP09CMCfkIpdIanwF9zxkDx0ISWuJtk4JkDbUls92xfDsDXsi3xxNlBHle11hnCiGAO57AvAyy2oiSaq3MkNT5PGvFFxcB+7E+AHMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863268; c=relaxed/simple;
	bh=qnnuiUyGl8Vf0OCZx8j/+0ej1P9plBhs1R9lBgM5EKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFEBeMi5JRS0ipqTh7TWmQAUIPmnNVAR8wHqp/XiCwYZdLLbVDTx9cF8NWPa+ktQKS4j7mLzfEDg1WAMuW6Yr+aaIXFowDgCSzWJTSDkbizgkHLw5mOhh5HMhSEJFJ7yZG+nqELqs9SFf7yf1+m3PlPrIXt1ewxSwJSIYJmMzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mk1xvKur; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mk1xvKur"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a2c9c5ff87so6156292e87.0
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 06:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776863265; x=1777468065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSYzG4w2krdb3nT01JqHA9xtpgh1UWf3StMYQUTc4bg=;
        b=mk1xvKurpoBz9jPNXLyXV42yEetMT8yMqeS1ujclvVnYVGNHOnftnq2V9w0tpTu3sX
         fAcPCn8OK1Pc0FbP+TnfUvaYx55tOX4NT+23KCP6zWxfdyYBfFT9nVzyACX9t/37fxSH
         Ucey48aBg0qm5djASgDy2ET2asu6FtmxjZCj7o2jVGclqQm4daFyP26tRxLtitHe+K7z
         bTSvD2Kf8SUjxZHNkoMp8BaBy7PaUBYdRER855X5MftJhy2qfXojZOBR3UayxJPDIvjM
         fuKgujG8KjpWRLJC6Phg9ROgq4Y8S5FG71fb6th8nARnRd36ti4fGp5Y+aBFQS6+v4EX
         f+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776863265; x=1777468065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gSYzG4w2krdb3nT01JqHA9xtpgh1UWf3StMYQUTc4bg=;
        b=dC2WP55KrKSYGoMuXGqoSk8VVB5p9qTP1awPah7i/nBR6HShIo1hzzrRt2Q73aU0gw
         wsHgifFoQSq2G2lH/r2Ogk0T/wMvLEdXFakPALNsXl0qAAtxbb5tfKc/YX9bcHvGCIKl
         5C0rc+zazFMPHXJSZQg8m9XsQ4r9E7ejrlTu5AxGIOekSFCIydzSr1x3T8N6xqKWLVLR
         SbZGWZVUgpDvzauwmxQir6/zVGjlmFL8i3G9+NcpcdzvhMbtjLR52kfVRZU1iSkqs3kO
         xVfcvGFgWCwjt34IGeCCLi7ZruKpwPV0VP3vFtijlKigFZzO3VE5loMcn4tJWGPi9unq
         oF5A==
X-Forwarded-Encrypted: i=1; AFNElJ/CwN3TFCXZAtf3uCnI0AEMYztnT6l1O7sQmBpBfcUcsQdGyYBZIZM0zPyYACEi2ez1k/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/u+CCNTBaMbPLs0DAUTKwQYPUNLCDBZAT+rZHaVIDT5U5953I
	Lc11LpQ3gP7U3OIYyXZv6ZAqmlpBwZI6gSKpyISG7ZDNrZaGWyxFCM43tATwBoTLSxEusN+r0ff
	/eqeNFYM=
X-Gm-Gg: AeBDievJgXNsmLitdbXfay3QUlGEle9UZNLMX/F96bt5T3GnLhQP4Rvn7/dQ6bTh1RV
	dLJOe8S/hH309IRnN2ms5Sov4C8kV13EFUjj92rznLyw0CrUz129FljXUEPNfgQHG5Bxk0r1dLK
	rWyrn+SNh9wWX4iklXXDD0pyVsZPCynZo6+Eqkl3pNPyR9gjNNGmraXi8SDYlQwZvtVfiI3AkvQ
	zOCfNs5T45EjR+ewEuiWAyzsGbe9mTCbDfYoraWKdP5wcty35UyZO2kH0XhGrdUPrEYn5bc1/Ea
	auBImW1VQIAkSgXGxe4a1fZGC/rC+0IVXnxAGnyRoL7lWKo5fsWP6AYU2qksr+8wcJNPi8akcbv
	2tcX1cgMcl8+mOn1OW1Mbyggd0OIeopU7dTKjufDvnNwIqnWvnADROoT1b6yX8qu8kiKVH7P6QG
	ULT7fzMz/lrlwCqYrhp29NrDiHHdOwP7XQCQ==
X-Received: by 2002:a17:907:25cd:b0:ba9:559:10c8 with SMTP id a640c23a62f3a-ba905591bf7mr529933866b.41.1776862953878;
        Wed, 22 Apr 2026 06:02:33 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e46898sm47674480f8f.27.2026.04.22.06.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:02:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 6134E616F5;
	Wed, 22 Apr 2026 13:52:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 29/32] target/arm: implement global monitor events
Date: Wed, 22 Apr 2026 13:52:46 +0100
Message-ID: <20260422125250.1303100-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Moving from Exclusive to Open Access should generate event stream
events. Technically a non-exclusive store to any address range covered
by the global monitor should also trigger such an event but we can
only detect that after the event by seeing if memory doesn't match
cpu_exclusive_val when processing the eventual store exclusive.

The CLREX instruction has the same effect as do other operations
clearing the exclusive state (such as eret).

We special case STLR/STL (Store Release) instructions to generate
events because their use is a suggested pattern for clearing locks
that might be sleeping. We only trigger the event if we detect an
exclusive instruction is running.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - add gen_global_event_reg() and use that
  - add handling for STL/STLR
---
 target/arm/internals.h         |  1 +
 target/arm/tcg/translate.h     | 14 ++++++++++++++
 target/arm/tcg/translate-a64.c | 23 +++++++++++++++++++++++
 target/arm/tcg/translate.c     | 20 ++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 089f679ac0a..7045b4a56bd 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -709,6 +709,7 @@ static inline void arm_broadcast_event(void)
 static inline void arm_clear_exclusive(CPUARMState *env)
 {
     env->exclusive_addr = -1;
+    arm_broadcast_event();
 }
 
 /**
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 9bf2701a56b..01053060af4 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -882,6 +882,20 @@ static inline void gen_event_reg(void)
 #endif
 }
 
+/*
+ * Some events affect all PEs in the same shareability domain. In
+ * practice as we currently model SMP systems as single SoC devices so
+ * we signal them all.
+ */
+static inline void gen_global_event_reg(void)
+{
+#ifndef CONFIG_USER_ONLY
+    /* re-use the SEV helper */
+    gen_helper_sev(tcg_env);
+#endif
+}
+
+
 /*
  * Helpers for implementing sets of trans_* functions.
  * Defer the implementation of NAME to FUNC, with optional extra arguments.
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f30df5dbfed..a1b0cc9508e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2253,6 +2253,7 @@ static bool trans_CHKFEAT(DisasContext *s, arg_CHKFEAT *a)
 static bool trans_CLREX(DisasContext *s, arg_CLREX *a)
 {
     tcg_gen_movi_i64(cpu_exclusive_addr, -1);
+    gen_global_event_reg();
     return true;
 }
 
@@ -3407,6 +3408,14 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
         tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, cpu_exclusive_val);
     }
     tcg_gen_mov_i64(cpu_reg(s, rd), tmp);
+
+    /*
+     * On a successful StoreExcl the global monitor transitions from
+     * Exclusive to Open Access and at that point generate an Event
+     * for PEs in the same memory sharing domain.
+     */
+    gen_global_event_reg();
+
     tcg_gen_br(done_label);
 
     gen_set_label(fail_label);
@@ -3544,6 +3553,7 @@ static bool trans_STLR(DisasContext *s, arg_stlr *a)
     TCGv_i64 clean_addr;
     MemOp memop;
     bool iss_sf = ldst_iss_sf(a->sz, false, false);
+    TCGLabel *skip_monitor_event = gen_new_label();
 
     /*
      * StoreLORelease is the same as Store-Release for QEMU, but
@@ -3562,6 +3572,19 @@ static bool trans_STLR(DisasContext *s, arg_stlr *a)
                                 true, a->rn != 31, memop);
     do_gpr_st(s, cpu_reg(s, a->rt), clean_addr, memop, true, a->rt,
               iss_sf, a->lasr);
+
+    /*
+     * We don't fully model the global monitor as it would be very
+     * expensive for every memory access. However in the Arm ARM "Use
+     * of Wait for Event (WFE) and Send Event (SEV) with lock" it does
+     * give the example of using STLR to clear a lock. So if a lock is
+     * active trigger the global event register so we don't deadlock
+     * while sleeping.
+     */
+    tcg_gen_brcondi_i64(TCG_COND_EQ, cpu_exclusive_addr, -1, skip_monitor_event);
+    gen_global_event_reg();
+    gen_set_label(skip_monitor_event);
+
     return true;
 }
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 59925151fc3..18d64620e40 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -2116,6 +2116,12 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
         tcg_gen_setcond_i32(TCG_COND_NE, t0, t0, t2);
     }
     tcg_gen_mov_i32(cpu_R[rd], t0);
+    /*
+     * On a successful StoreExcl the global monitor transitions from
+     * Exclusive to Open Access and at that point generate an Event
+     * for PEs in the same memory sharing domain.
+     */
+    gen_global_event_reg();
     tcg_gen_br(done_label);
 
     gen_set_label(fail_label);
@@ -4218,6 +4224,7 @@ static bool trans_STLEXH(DisasContext *s, arg_STREX *a)
 static bool op_stl(DisasContext *s, arg_STL *a, MemOp mop)
 {
     TCGv_i32 addr, tmp;
+    TCGLabel *skip_monitor_event;
 
     if (!ENABLE_ARCH_8) {
         return false;
@@ -4230,10 +4237,23 @@ static bool op_stl(DisasContext *s, arg_STL *a, MemOp mop)
 
     addr = load_reg(s, a->rn);
     tmp = load_reg(s, a->rt);
+    skip_monitor_event = gen_new_label();
     tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     gen_aa32_st_i32(s, tmp, addr, get_mem_index(s), mop | MO_ALIGN);
     disas_set_da_iss(s, mop, a->rt | ISSIsAcqRel | ISSIsWrite);
 
+    /*
+     * We don't fully model the global monitor as it would be very
+     * expensive for every memory access. However in the Arm ARM "Use
+     * of Wait for Event (WFE) and Send Event (SEV) with lock" it does
+     * give the example of using STL to clear a lock. So if a lock is
+     * active trigger the global event register so we don't deadlock
+     * while sleeping.
+     */
+    tcg_gen_brcondi_i64(TCG_COND_EQ, cpu_exclusive_addr, -1, skip_monitor_event);
+    gen_global_event_reg();
+    gen_set_label(skip_monitor_event);
+
     return true;
 }
 
-- 
2.47.3

