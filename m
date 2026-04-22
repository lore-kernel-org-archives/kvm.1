Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727783542E5
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853054; cv=none; b=Efhj5a65/zh8a/m4xv4IqhNDZeONoiRqNrvJlKeDmklfdWUv1gIc+cSsGkGMvmXgR+0VWdpyzn8XB01m3UtG/tGlJYlbzD8w5SBKnUusQceAYqTmJokOXOj5apbsLpnsxzYII1g+kPjMY2fMotO462LYajsWg6eOUZ+/iXTgbDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853054; c=relaxed/simple;
	bh=qnnuiUyGl8Vf0OCZx8j/+0ej1P9plBhs1R9lBgM5EKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxoR7c5bR4eeCzoB8+jfyRtLv4d522KrOyIYB8Ql+3CxQ93cMYHrbGL8Oljvnci49SKQCRoIZPLOo0btdgRMse0CEBlpkvhst2/kFGAdQDHjmh9zUeEXsUB1BtUHgr83lJv9oRVZOSrRt9Tg1jaWPsxGixEdwLX7mB9AT4xouZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wnEvc8ZJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wnEvc8ZJ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so41920065e9.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776853051; x=1777457851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSYzG4w2krdb3nT01JqHA9xtpgh1UWf3StMYQUTc4bg=;
        b=wnEvc8ZJq79eXcfRmvdDyD64uWgvIhEGlUoIGBE3RysO0cg4niOSa6pYQrUU1vuC+3
         5gi4sFA7vdC/Fw2JIrrDHGuuAR+rE4pRdnT1QtFG6SWaWPSSkToMTLk2B5hxuJxQESwA
         I7y/4jOxaC6kn5nAYwlcU8Hnr1kaaIKn+pLQgwsNoEs/XphxzvyQS7Syo5LV/Qec9V0V
         cKqdbQJ24jn337Ff6ubaq+vsTF4xDAEITssObgk7q89rWPuTCLXuRSHsYtwW7ga/DJXf
         eQMYayy2GxNGenjUprVNwSt5tYP/iTU5YOs2+WWWcil7wnsx2Bvu4sbwhFiOJnxYSr25
         5sBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776853051; x=1777457851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gSYzG4w2krdb3nT01JqHA9xtpgh1UWf3StMYQUTc4bg=;
        b=tHSx6XvMw7h+h0isu99dxP32HbIx3SJTT7vgmYkxY2vIepZPkDZylhlLsAp3ysYirX
         29H7wxxGWlgSnRZpR6ed/30waQrTHkhHA61mSz7iUR6+9ccaKdT0fIbvEg74YQ6Acobc
         z0ATSqL+RiCnHzlxpkQS8kAhjeXHv7EoINFqKjr3eeMe4RJ2JliLdRKND3MdXxkskwGJ
         lotOY8+8xQ14gY/PVkeQ6jGQwpcMerKjn3P3IXEtPccT9eaC4bzGypRgVm7cWfxdwf4y
         tvsY+3nYxUo2rZqyQk1L3Cf6t8UtFI/sVT5+FrL2VC9TLacoxyaD6xyE+nMhTiSAwnUD
         YJfQ==
X-Forwarded-Encrypted: i=1; AFNElJ888FRPtsg8lt6/wQA9gpeN6s5W8yexoPMWvgHbtvUe5vVsbtko2gQn9rVehQzbpk8aJfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGSrPRdPpB6sw5EpE85FMvuyOV9hXAM6ZvQAWaKodoEsoELk2t
	HdRKFS/lE2VzLjtmSVNj/h2smUuHBKSQY/VxJuTkVxB+mJ15jcbsXZffo9Ity+LQo1g=
X-Gm-Gg: AeBDieuYZBNSJHfkpnzevOJ73pJZddU5At2iG2qPINRHMyRNdQEZ0A1rEwNNPIFloUd
	eHC/BbTqDuDUnUZNGBXgLJam+87OCTbp9aA6ah83IW3sdiGD79LPuNgDy/ZBh7dCzrmFxEC0WUh
	0ORSd7NuqR982iB9mCcS6v4fgszTrpFGCqWRkcioUZn806r7a/JI0Q/3GT1582fC+QJGn1svg+X
	tTqbgm783MvZVIU9Yws1sYhyqXZ6jFiZGBsS1yM1kKeMRL6ybZnjDqWa1l+TWIWFwz/c/iQAv91
	nwCp+DQnmatchad/U7yAr+7HWXTXj/aSUW0+rNHXPHd+T91CE5ZJmOwM/Cm67ZfdQ2DCHWP58RF
	cFsgyIVgF55XRwZZkE3v7ylbYtCl8XeAvb3+eOgEjMXvm61FDQUdIfX16HcAMAK9UxGR+auMtb1
	emIzdzFicULqZ06WX4P0I76Q+ANm4BH7aH2g==
X-Received: by 2002:a05:600c:3e1a:b0:489:1ca2:eafd with SMTP id 5b1f17b1804b1-4891ca2ee65mr169059005e9.11.1776853050447;
        Wed, 22 Apr 2026 03:17:30 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d5b1sm48556196f8f.30.2026.04.22.03.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:17:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id CF1A4616F5;
	Wed, 22 Apr 2026 11:10:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
	qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 29/31] target/arm: implement global monitor events
Date: Wed, 22 Apr 2026 11:10:40 +0100
Message-ID: <20260422101043.1234229-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
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

