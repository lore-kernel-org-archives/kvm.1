Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD4038C402
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228062; cv=none; b=sJr5cLSUKkNSAAhNddXc269KL8DpPIjfNvm8jZ6D0ckUY8rBezbvvji7YIdJwO13nD3MU6an0mLzmxQSd8fYSKTpb/MVD/y6Fw6kMhkXheZiCHbCVBwPPrFM3vz5mtN5OmyYY0tl4tNReGJvC6NrpxOhE1N/Wq5OL+6FIAT9NUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228062; c=relaxed/simple;
	bh=8lpLMle960ha9C/ogAip4GhbdUlgE/6VENk0jnI85Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvTqlnj9cU4l3H3AwcCPpSnXEimMwo/EzFH0dghv1xyE1wDKrks+I7ZBhG/slMer7fvQR1d41gJSZH3w1KzK2a5YytJ2v0625Ci6qLn2OkVV4iWg+D4jPQMjNqMMggkJR0cN1+g7SZtQ7tvJa5yS5I0iW0qrIi/W2bmFq5qOcM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePyWs7i/; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePyWs7i/"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36baeec21dcso339904a91.3
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 18:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781228061; x=1781832861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3XxmrBy52zOcCh0BE/0Ny+/1gx+aqGXAaE+PTzB4fI=;
        b=ePyWs7i/E74WlcaBGrCGYGD/YKTb8aioBwkbC8PCc/PuMPZjh68nJDBStUGqfh7EDQ
         W0/1z8BQ7NpnUf4VvsQZpiRvXLPXUwKHnIwWU/VF9K6Yv4s4YMnB6oDUuMP/EwOHtCFJ
         SiyZTHowlLCB2TkRI8myMVvvnZuIGV/0IB9Yqhizydh8FstOmopAT4S6TRH6sYuF0b2J
         cqEP5AZQr17oqtkBh5fJXLqkicOz1Xcz38tw+Xu9P/Rr5ImoYRBoJdn3nf/shzaplDSs
         qJcCGooTlpm3JgYQpuf4//e8LJQVzD2dQQjV6MoFLQwbfLj0nFbRDyPhbktborrjikx8
         FDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781228061; x=1781832861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z3XxmrBy52zOcCh0BE/0Ny+/1gx+aqGXAaE+PTzB4fI=;
        b=SynMq8qwG58Fy98+aJS+3b7Am2we3Ja6B85qJEtyXDtLU1H9jkLqT+zBlh3LZaAEdG
         /BBYvmUnPJ4BBlDstuYiYprdnU7p8LPgW3XDN2/5ZwYw8zteaeBcramObPY3OEmqR5Pn
         4OLS+MIBBd4poLb+WPTpSUaqftP9us5+ssW3ScH7aGjC6yk/Kk4uHb9+KygntLf3jFMT
         GULrZJTSJQHzjq1zi9pyPjO+BDl6SxwmnLwdiZcADLCLnaf2ix4KyOhLwHUzRT6fNxDc
         CK2mKE6anWDbiexkkvHdPJsVCjbznkvhIbnjg6ChDkhIaWuiWIcVzoGWr9gt2x9vQYUg
         GdMw==
X-Forwarded-Encrypted: i=1; AFNElJ97odCJyF04OSXQApbc5tWgnOUaL5SwG8iPh6xR+rPucgewbjnCmAIC3ahnnkCM+eSzCok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYDYZURL3jpxptt+oW/4NV6pixMdCSbu1D/IXiwVb8LMU7esmX
	6L1LWFwR2sisDk7MG29E9A0KnN942Q1Oj27T9usuhZjWPwBKFc8/DJ5B
X-Gm-Gg: Acq92OH1B9WUfzMxOXOdgvNN1GoaMahEX7KNfE1Jlv9522MauhU2maq+FX4WgnQwxt1
	LBDcsv2WbXH7Lw81xPJ+eBRIF9hVFEzzclfjA8zPvpJT2C7I2oKlK0qaKH6/w4NLnrhYtBdXYVN
	+BP3REfadfboGGrfi9lS9FsJm0CxxmzqOa0cxGp+mkZorAJcpMsCuFnz6SUB8Ud3WcurMZJJXLs
	zK+d/V0sAR9iqIaMdS0j5aCa2AUlgST5cVvCo7KCJFPDyfpUdnx4eUM5BCwXhaAUbi/VC8oakE/
	9/1E3QoX/pmEvBrLyMin+cuJrHKKxWendmdkm0SyBEUwI6cvCRVj2o8vcR0rfWEhgnyuIC9RA8q
	epD/6KNPUM3/gHWyNwAs7p00xq/PCsRfs6Q7GrlDTqXo5A3nX7LVAqqOV+zPh5zvwxNYG0/g1yX
	mhfyyLpnM373aIwEjBeZLuqJhEig==
X-Received: by 2002:a17:90b:3d81:b0:36d:f28a:c5ee with SMTP id 98e67ed59e1d1-37a04a79e25mr729911a91.25.1781228060771;
        Thu, 11 Jun 2026 18:34:20 -0700 (PDT)
Received: from wanpengli.. ([2408:822f:1aba:84a0:651:104c:ba0c:1f4a])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-37a1f07bbfdsm250713a91.5.2026.06.11.18.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:34:20 -0700 (PDT)
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
Subject: [PATCH v3 04/10] sched/fair: Credit nominated next-buddy in yield_to_task_fair()
Date: Fri, 12 Jun 2026 09:33:49 +0800
Message-ID: <20260612013355.59231-5-kernellwp@gmail.com>
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

After set_next_buddy() nominates the yield_to() target at every level of
its sched_entity hierarchy, walk that same hierarchy and credit bounded
EEVDF lag to each not-yet-eligible entity. This allows pick_eevdf()'s
PICK_BUDDY path to select the nominated target instead of dropping the
hint at the first ineligible group entity.

Gate the walk with YIELD_TO_LAG_CREDIT. With the feature disabled,
yield_to_task_fair() keeps the existing forfeit-based behavior.
yield_to() holds both rq locks via double_rq_lock(), so touching the
target task's cfs_rqs, including remote cfs_rqs, is safe. Stop the walk
where set_next_buddy() stopped, and skip delayed or throttled entities.

Refresh the target rq clock when it differs from the local rq so the
per-level update_curr() calls observe current rq_clock values. The local
rq still uses the existing yield_task_fair() path in this change.

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 kernel/sched/fair.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c28682fedb36..48f65a4f1923 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9346,8 +9346,8 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
  * depth so it stays eligible across several picks. The caller clamps it to
  * entity_lag()'s legal bound, so EEVDF fairness is preserved.
  */
-static u64 __maybe_unused
-eevdf_persistent_margin(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static u64 eevdf_persistent_margin(struct cfs_rq *cfs_rq,
+				   struct sched_entity *se)
 {
 	u64 base = sysctl_sched_base_slice;
 	unsigned int n = cfs_rq->h_nr_queued;
@@ -9379,7 +9379,7 @@ eevdf_persistent_margin(struct cfs_rq *cfs_rq, struct sched_entity *se)
  * Idempotent once @se holds the margin. Caller must hold
  * rq_of(cfs_rq)->lock with rq_clock up to date.
  */
-static void __maybe_unused
+static void
 eevdf_credit_entity_vlag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	u64 avruntime, credit, want, margin, max_slice, lag_limit;
@@ -9488,6 +9488,7 @@ static void yield_task_fair(struct rq *rq)
 static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
+	struct rq *p_rq = task_rq(p);
 
 	/* !se->on_rq also covers throttled task */
 	if (!se->on_rq)
@@ -9496,6 +9497,43 @@ static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
 	/* Tell the scheduler that we'd really like se to run next. */
 	set_next_buddy(se);
 
+	/* Without lag credit, keep the existing forfeit-based yield. */
+	if (!sched_feat(YIELD_TO_LAG_CREDIT)) {
+		yield_task_fair(rq);
+		return true;
+	}
+
+	/*
+	 * Walk the ancestor chain set_next_buddy() just nominated and credit
+	 * bounded lag to each not-yet-eligible level so pick_eevdf() returns
+	 * it. yield_to() holds both rq locks via double_rq_lock(), so touching
+	 * p's cfs_rqs (possibly on another CPU) is safe; the primitive is
+	 * idempotent, so no rate limiting is needed.
+	 *
+	 * Only refresh p_rq's clock when it differs from the local rq. A
+	 * remote p_rq must be refreshed so the per-level update_curr() is
+	 * accurate. In the same-rq case we skip it: the credit is a
+	 * best-effort hint and the rq clock is recent enough, while the
+	 * trailing yield_task_fair() would otherwise make this a second
+	 * update_rq_clock() on the same rq and trip
+	 * SCHED_WARN_ON(WARN_DOUBLE_CLOCK).
+	 */
+	if (rq != p_rq)
+		update_rq_clock(p_rq);
+
+	for_each_sched_entity(se) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+		if (cfs_rq->next != se)
+			break;
+		if (se->sched_delayed)
+			break;
+		if (throttled_hierarchy(cfs_rq))
+			break;
+
+		eevdf_credit_entity_vlag(cfs_rq, se);
+	}
+
 	yield_task_fair(rq);
 
 	return true;
-- 
2.43.0

