Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DD338D3F6
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228054; cv=none; b=OisMJl8FmaaTRVhhpK4YP1L9JZYs+CQp1fJ7vuCH6tr0+r/EjSKi3Ahx0iOVRl229KkxHvqI/cAbVnD+F5IMxhUWdLwQ9vWsk9sxIbjJQHg9dLOyGFyuA5YpP8hXr8podEsvSPsZUjzi2J4YWw5ZURuVatw+JzCOJdhUaDd1VYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228054; c=relaxed/simple;
	bh=u+ntkArrFPY61UaKKmaLqX9myUBfPqs7MyECLJZ8ses=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OA0GkJwOXzrPnVyEpbShQUpLN8uYIkcgtp5nj5BmUYMdOA2w3DxwPX71fz69ufW2bLDvDaM3qKpA9N0JElvCOvT9v0hRaW/seVEB4dAsnn4KfvpupxGvqgm6KclT9jP7FE1EO9R7UPV20gpfaVnGLObjxiPgsmQaRIZ2MlEN/F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bS4fdKWH; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bS4fdKWH"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso525272a91.2
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 18:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781228052; x=1781832852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBY9ydpXqFUhVTa9PkiLmheHxm3JF7bF85lezg9IMD8=;
        b=bS4fdKWH78NAhcPZb+yW/PxZo+2/h2vRkuy6iLgi4EhLsQqYCp8i9VwE7Z1nHNNCTp
         SwyXijuEJiBkhMdpwZTVIZdXamS2vt6M+fwcO4epKKA+/K9ppDfFhGFEtdBxXGVbsvtC
         /pfrkH0RIb0PUSe67kyqpy70PXlP98eVIB1z8LnkiQzqZAml9wPFU8hk/3AzZfdeSnlX
         19pgySDFkDO4L0I+h/jbPArBWCO7XGgztVj8rzq4Z9Dw2BcARwzwATVrGJ1K6r5/Fkl3
         y5UNq8NG33R3xxn5HNkut6/BzSpaxgcpSGF3ZD46nsX8dOb4YEMkBA7MkKFAi7pkekYA
         5oeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781228052; x=1781832852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BBY9ydpXqFUhVTa9PkiLmheHxm3JF7bF85lezg9IMD8=;
        b=er53DsMjst7RpBfHQLwuVNJ9U3kFPqhnm8HZytSnq3hlhomV10i+TzISscIcbRUT9M
         hhqs3vxFezp27NbMZRUz/cmUgv/WttUDpXNntTZlHfqZQfZbX1/8lUuRmVZgtDmRZaE9
         6wGrjnG4rRDXTSXQD2B6dle+HT7M/J8lG/khHDKu3bi/dgU7yzQr2Ruh7rEb1LkwQKzs
         3wc9YMnEP+jemL/IVeWFxE9jhOmji6xL9MDyqrZ3RfEap89Ocb1lvmqCzy67oYR8eOF9
         dMBrD828c/xIJjwIBIVf5tm7xnCmSZ2YO3UPrRnlT8y7dv1v88HZlu8KUerbPez6PZcU
         V94w==
X-Forwarded-Encrypted: i=1; AFNElJ9LO6jurnBglePbDM8YHaA+g82bnjUH0Y5wl4wOXlfMLkvb2UvA6HUiPAaxoDQGqOmNmEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YywxLk/h+nZ4i41y2tcyLA8U52QJ1Y1s+CFk4LY9qU/iiNUAtnJ
	Y9FhMSM/liRmL1IdCr1mPjUmZmhZZkOIb5vIfFvRg/xSqQiHvBxK5Pak
X-Gm-Gg: Acq92OG+Yld7+H5XgCsFcRqH3FJGXXytQX+7Nma+eWKfZtlvKjQaQidTfR6Swt5d6OQ
	rDpgXWQkY/bH8UBzE8bdOl2FGNDd7nfIixpt41AeWF+Z0jWC25Rf27/RwpEMAZnacw1i8IJOvRC
	D0oAvO+qPURN5BhWefGoIHea8RyyNF70nRF9zlmDDsmfXRpCN5SQ029/x03jiMGY19wYf9whKj9
	86w3/Mef5sE7ADtJ57wss74aB2l4JK7DSsdIuLQsgGnwRTw/+jtwkixhUImUfaruneHE+3CsVJx
	bqIomefE7oj/9bURRnRV/oiRGeQpxs52/InrQDjn4QuBhxvL9a3Av3WHFL4BY0UHV5W8F55VZgz
	vRE9+gHxVCjLW79dpUwJsqPppAF4IKYbH47XmpkipbIKoAyo9k7RCDp2C2DCpTMiHR7Pkjtc3DF
	oIPXQ4gtVMG3I/OmOxOCvAuSOtlQ==
X-Received: by 2002:a17:90b:380e:b0:36b:8873:d96d with SMTP id 98e67ed59e1d1-37a02225ca7mr960258a91.11.1781228052113;
        Thu, 11 Jun 2026 18:34:12 -0700 (PDT)
Received: from wanpengli.. ([2408:822f:1aba:84a0:651:104c:ba0c:1f4a])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-37a1f07bbfdsm250713a91.5.2026.06.11.18.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:34:11 -0700 (PDT)
From: Wanpeng Li <kernellwp@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	Wanpeng Li <wanpengli@tencent.com>,
	Richie Buturla <richie@linux.ibm.com>
Subject: [PATCH v3 02/10] sched/fair: Credit a persistent, queue-depth-scaled vlag margin
Date: Fri, 12 Jun 2026 09:33:47 +0800
Message-ID: <20260612013355.59231-3-kernellwp@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612013355.59231-1-kernellwp@gmail.com>
References: <20260612013355.59231-1-kernellwp@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wanpeng Li <wanpengli@tencent.com>

Crediting only up to vlag = 0 makes the buddy eligible for a single
pick_eevdf() pass. The next update_curr() can push it below zero again
before PICK_BUDDY consumes the hint.

Credit to a bounded positive-vlag margin instead, so the buddy stays
eligible across several scheduling decisions. Scale the margin with
runqueue depth, because deeper runqueues dilute eligibility faster, and
clamp it to entity_lag()'s legal positive-lag bound to preserve EEVDF
fairness.

The helper is not called in this change; there is no functional change.

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 kernel/sched/fair.c | 58 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e7f5ea25fdae..c6502db62cd3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9342,21 +9342,45 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
 }
 
 /*
- * eevdf_credit_entity_vlag - credit a nominated next-buddy to eligibility
+ * Positive-vlag target margin for a credited buddy, scaled by runqueue
+ * depth so it stays eligible across several picks. The caller clamps it to
+ * entity_lag()'s legal bound, so EEVDF fairness is preserved.
+ */
+static u64 __maybe_unused
+eevdf_persistent_margin(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	u64 base = sysctl_sched_base_slice;
+	unsigned int n = cfs_rq->h_nr_queued;
+	u64 raw;
+
+	if (n <= 4)
+		raw = base * 4;
+	else if (n <= 8)
+		raw = base * 6;
+	else if (n <= 16)
+		raw = base * 8;
+	else
+		raw = base * 12;
+
+	return calc_delta_fair(raw, se);
+}
+
+/*
+ * eevdf_credit_entity_vlag - credit bounded vlag to a nominated next-buddy
  *
  * Advance @se (already nominated by set_next_buddy(), so cfs_rq->next == se)
- * just enough negative vlag to reach the eligibility boundary (vlag = 0) so
- * pick_eevdf()'s PICK_BUDDY branch returns it. cfs_rq->curr is shifted in
- * place (off-tree, carrying any vprot window). Queued entities are left
- * unchanged.
+ * to a bounded positive-vlag margin so pick_eevdf()'s PICK_BUDDY branch
+ * keeps returning it across several picks, without exceeding entity_lag()'s
+ * legal bound. cfs_rq->curr is shifted in place (off-tree, carrying any
+ * vprot window). Queued entities are left unchanged.
  *
- * Idempotent: a no-op once @se is already eligible. Caller must hold
+ * Idempotent once @se holds the margin. Caller must hold
  * rq_of(cfs_rq)->lock with rq_clock up to date.
  */
 static void __maybe_unused
 eevdf_credit_entity_vlag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	u64 avruntime, credit;
+	u64 avruntime, credit, want, margin, max_slice, lag_limit;
 	s64 vlag;
 
 	/* Callers gate this helper with YIELD_TO_LAG_CREDIT. */
@@ -9371,11 +9395,23 @@ eevdf_credit_entity_vlag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	avruntime = avg_vruntime(cfs_rq);
 	vlag = entity_lag(cfs_rq, se, avruntime);
 
-	/* Already eligible: nothing to do. */
-	if (vlag >= 0)
-		return;
+	/* Clamp the margin to entity_lag()'s bound so place_entity() keeps it. */
+	max_slice = cfs_rq_max_slice(cfs_rq) + TICK_NSEC;
+	lag_limit = calc_delta_fair(max_slice, se);
+	margin = eevdf_persistent_margin(cfs_rq, se);
+	if (lag_limit && margin > lag_limit)
+		margin = lag_limit;
+	if (vlag >= 0) {
+		if ((u64)vlag >= margin)
+			return;
+		want = margin - (u64)vlag;
+	} else {
+		want = margin + (u64)(-vlag);
+	}
 
-	credit = (u64)(-vlag);
+	credit = want;
+	if (!credit)
+		return;
 
 	if (cfs_rq->curr == se) {
 		/* curr is off-tree: in-place shift, carrying any vprot window. */
-- 
2.43.0

