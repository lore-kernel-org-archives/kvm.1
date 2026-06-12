Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E004138E113
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228067; cv=none; b=qgE849iEZ9xP6jls8iILNZaKNIC8RCauIpQNj+W3QZ5202iSWz5+Yl4Rc+mYqRtNLw+rKEwoc9SIUUfIq7uHpulz25wJ5FC+VP1UuTiLtaOkMtoZ+AKgacH9pxeBZnufBREG5GambeSQc6aTsh2uc4Qc/sMgPAeQEDDhFrjdETE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228067; c=relaxed/simple;
	bh=C/WbnAffwS7/9J21ydWg4AkVjqtvD648aiREZdGselA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5Ih2aY3NrfiJ1dvCreM7httRINgeFE/yECkEZlVnBL6n3DrK4TIpcOCcbb9HoctmzfQRapCP1gVQFrKuIx9GTbFAjVr4VokBAqIGANRkPj7xPZVPad/0sxikPplcutDdxRZEX0u0xuYToltdHYbKBi54pxMab9v7IYPkueDwpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCkC2BHh; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCkC2BHh"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso320083a91.1
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 18:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781228065; x=1781832865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDsEGV9rsARv7ZkT3LV2/BQ6R3I89m5gb8J5FbHrnAk=;
        b=OCkC2BHhNghwH+bBfX/US01Mux0ftH89NFTwgNfB+97NQ0nT+uHWZG6yi9itkmY+Cb
         ESrBZFho2uFVl7I8ZXiEYzy1FeRRvS7KTfAGWazok+WU92jdsh6ZW0X0+OEW+/P24N21
         HHoFquI4XtYhX1BYBViQZMMraebK6D1jfcbm9BSqH3R413YL9Lin+XwrDYFzFqy8mQCv
         WzEuSfan6BKDSRSuXWtFBI4OK40GROSDuKG7NYhEGA3w4MUL0qzJTFpYkUl2ht0N18mR
         SR8HS5XSf29GsdA8DKAsXIUn58g6zHPyj7eZ/JuPxh3+YAeR3Q+UkmU025n6eEVpPLVm
         MzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781228065; x=1781832865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DDsEGV9rsARv7ZkT3LV2/BQ6R3I89m5gb8J5FbHrnAk=;
        b=qKML6FV1HrBDD0FskbQzAjVAH1hZcl98RhtDGXpPpxnGPYBntuj4saYwFpIfQUTkd/
         h8EhOZVJJ/p5Z6LlI5xECOghgyqebFw2b1bl2t0jZol7/CozCXOEZ9xSqR2B4M/XMToZ
         oHK9+TlX0ajA5PLrMyuBAHtIKLjsfK+n7eWIWYEicwlvSLccoKxyDGo20/bDe7OKlJte
         VR6KJGVYD/ZlsXOE5Tk61FFm9hWQEAk7nO/bZSXZ9wIRhNQ8Qs9OrvQXnrRjC8uvBID2
         aOSTPAoPO9B2lOaO7S1xKq8MQ1Epblnw18A53Lu0gcXxf0sqL8nDIIgF3iKJQYbEBmY1
         R6hQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ROpGZFAopSIR3Ws4C0Yf9YpdmEOoQdF1F/KVXazWx5pbcZyw6S6lgmlPp9MmhPNV2498=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDsPuuEi40I7IrXtUgMHX2lAjzfPHiLJOmeUoovC2p8LtxM9pb
	OH8g2JfUlWiyhjTtr9X9TtqHAb37KxhQa6kbDyTuqofKzIwtNXSexYzF
X-Gm-Gg: Acq92OGmZ1GA5k8jWX69I+PMED/s/HqvyDK8i9n0JGJSEpEF1p/EZRzGI+yTfMLFlwk
	pWpQbI+HR2VKdJ6rq3sBKrtX6tTyGkkqmWDzleLzGjGlEHebXAMkn1JmTkah5bbaYPVs28fyQ5n
	wzWUJsTPoq6HpeB+L8TDfAe2twuDNdrbdPA67wpuCNSwhzKEU9FrMa51aQ43TNDlPydsT52tOzV
	nUZ7jZiR/gVrgZxikRl5eTb9LTm+C16hrz4yzJwUAEGDdLEHdxw6+Vh9urIQzcfYv/FTz0BqN1m
	Nicv0tB0b89tK/+SsDOAY3fnc9doh0aUrK5hrQBwl8eusnWxEGuwO1oiFzTTs3kOD/91LE3LfgK
	dKTxjdGmAQ61r47g2ypb6WAuS8nT7spSs4I3vJFkXWxnGr/JaU2xBPowyzssiJODafhr79QAGAZ
	DOZ+2F5xfZScBqJqxObQTdiIS+kw==
X-Received: by 2002:a17:90b:57eb:b0:36b:ba9b:7efb with SMTP id 98e67ed59e1d1-37a01a3bfa9mr893397a91.5.1781228065090;
        Thu, 11 Jun 2026 18:34:25 -0700 (PDT)
Received: from wanpengli.. ([2408:822f:1aba:84a0:651:104c:ba0c:1f4a])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-37a1f07bbfdsm250713a91.5.2026.06.11.18.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:34:24 -0700 (PDT)
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
Subject: [PATCH v3 05/10] sched/fair: Force a local resched on yield_to() so the buddy is picked
Date: Fri, 12 Jun 2026 09:33:50 +0800
Message-ID: <20260612013355.59231-6-kernellwp@gmail.com>
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

Lag credit makes the target eligible for PICK_BUDDY, but yield_to() does
not by itself force the caller off the CPU. An active RUN_TO_PARITY
protect_slice() on the local yielder can therefore keep pick_eevdf()
returning the yielder instead of the credited buddy.

Add yield_to_local_force_resched() for the lag-credit path. It applies
the existing leaf forfeit, cancels slice protection along the yielder's
sched_entity hierarchy, and calls resched_curr() on the local rq.
cancel_protect_slice() is already used by PREEMPT_WAKEUP_SHORT and does
not modify vruntime.

Rate-limit only the forced preemption (cancel_protect_slice() plus
resched_curr()) to once per 6ms per rq. The lag credit itself remains
unthrottled so each directed yield refreshes the scheduling hint, while
compute-bound guests avoid excessive forced preemption on PLE-heavy spin
loops.

Dbench (filesystem metadata operations) on 16-vCPU guests under host CPU
overcommit, throughput improvement from the scheduler side alone:

  2 VMs:  +6.65%
  3 VMs:  +4.80%
  4 VMs:  +7.59%

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 kernel/sched/fair.c  | 113 +++++++++++++++++++++++++++++++++++++------
 kernel/sched/sched.h |  10 ++++
 2 files changed, 108 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 48f65a4f1923..e9c5265cf0fa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9485,6 +9485,83 @@ static void yield_task_fair(struct rq *rq)
 	}
 }
 
+/*
+ * Rate-limit the forced local reschedule on the yield_to() lag-credit path
+ * to at most once per 6ms per rq.
+ *
+ * Lag credit is intentionally not rate-limited: a contended lock holder
+ * should be credited on every directed yield to keep the scheduling hint
+ * effective. Only the forced preemption needs bounding, as cancelling
+ * RUN_TO_PARITY protection and calling resched_curr() on every PLE-driven
+ * yield_to() can cause excessive preemption on compute-bound guests.
+ *
+ * Returns true if the caller should skip forcing a reschedule because a
+ * recent one already happened on this rq; the credit just applied still
+ * persists, so the buddy can be selected at the next scheduling point.
+ *
+ * Called under rq->lock with rq_clock up to date. yield_to_task_fair()
+ * updates the clock before walking the hierarchy because yield_to() takes
+ * the rq locks without updating them.
+ */
+static bool yield_to_force_resched_rate_limit(struct rq *rq)
+{
+	u64 now = rq_clock(rq);
+	u64 last = rq->yield_to_force_resched_last_ns;
+
+	if (last && (now - last) <= 6 * NSEC_PER_MSEC)
+		return true;
+
+	rq->yield_to_force_resched_last_ns = now;
+	return false;
+}
+
+/*
+ * Forfeit the local yielder, cancel its RUN_TO_PARITY slice protection
+ * along the whole sched_entity chain, and force a reschedule.
+ *
+ * yield_to() does not reschedule the caller, and an active protect_slice()
+ * at any level can keep pick_eevdf() returning the yielder instead of the
+ * credited buddy. cancel_protect_slice() is EEVDF-native (also used by
+ * PREEMPT_WAKEUP_SHORT) and does not touch vruntime. Caller holds the
+ * local rq lock via yield_to()'s double_rq_lock().
+ *
+ * Only the forced preemption here is rate-limited (to once per 6ms per rq);
+ * the lag credit applied by the caller runs on every yield_to(). When
+ * throttled, the credited buddy can still be selected at the next natural
+ * scheduling point without tearing down slice protection and forcing an
+ * immediate switch.
+ */
+static void yield_to_local_force_resched(struct rq *rq)
+{
+	struct sched_entity *yse = &rq->donor->se;
+
+	yield_task_fair(rq);
+
+	/*
+	 * If the yielder is the only runnable task on this rq there is nothing
+	 * for resched_curr() to switch to: any credited buddy is on a remote rq
+	 * in this cross-rq case, where yield_to() already issued resched_curr()
+	 * on the target's rq. Skip the forced reschedule: it would be a no-op
+	 * and an unnecessary preemption of an unrelated local task.
+	 * yield_task_fair() also returns early here without updating rq_clock.
+	 */
+	if (rq->nr_running <= 1)
+		return;
+
+	/*
+	 * Rate-limit the forced preemption (cancel_protect_slice + resched_curr)
+	 * to once per 6ms per rq. rq's clock was refreshed by the caller before
+	 * the credit walk, so rq_clock(rq) read here is current.
+	 */
+	if (yield_to_force_resched_rate_limit(rq))
+		return;
+
+	for_each_sched_entity(yse)
+		cancel_protect_slice(yse);
+
+	resched_curr(rq);
+}
+
 static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
@@ -9504,21 +9581,22 @@ static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
 	}
 
 	/*
-	 * Walk the ancestor chain set_next_buddy() just nominated and credit
-	 * bounded lag to each not-yet-eligible level so pick_eevdf() returns
-	 * it. yield_to() holds both rq locks via double_rq_lock(), so touching
-	 * p's cfs_rqs (possibly on another CPU) is safe; the primitive is
-	 * idempotent, so no rate limiting is needed.
+	 * Walk the ancestor chain nominated by set_next_buddy() and credit
+	 * bounded lag to each not-yet-eligible level, so pick_eevdf() can
+	 * honor the buddy hint. Lag credit runs on every directed yield; only
+	 * the forced preemption in yield_to_local_force_resched() is
+	 * rate-limited. yield_to() holds both rq locks via double_rq_lock(),
+	 * so touching p's cfs_rqs (possibly on another CPU) is safe.
 	 *
-	 * Only refresh p_rq's clock when it differs from the local rq. A
-	 * remote p_rq must be refreshed so the per-level update_curr() is
-	 * accurate. In the same-rq case we skip it: the credit is a
-	 * best-effort hint and the rq clock is recent enough, while the
-	 * trailing yield_task_fair() would otherwise make this a second
-	 * update_rq_clock() on the same rq and trip
-	 * SCHED_WARN_ON(WARN_DOUBLE_CLOCK).
-	 */
-	if (rq != p_rq)
+	 * Refresh the local rq clock first: yield_to() took the locks without
+	 * updating any clock and the per-level update_curr() below reads
+	 * rq_clock; assert_clock_updated() (default-on, no sched_feat gate)
+	 * fires otherwise. For a remote p_rq refresh it too; in the same-rq
+	 * case the refresh above already covers it (a redundant update is only
+	 * warned about under the default-off WARN_DOUBLE_CLOCK).
+	 */
+	update_rq_clock(rq);
+	if (p_rq != rq)
 		update_rq_clock(p_rq);
 
 	for_each_sched_entity(se) {
@@ -9534,7 +9612,12 @@ static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
 		eevdf_credit_entity_vlag(cfs_rq, se);
 	}
 
-	yield_task_fair(rq);
+	/*
+	 * Force the local CPU to reschedule so the credited buddy can be
+	 * selected instead of the protected yielder;
+	 * yield_to_local_force_resched() also does the leaf forfeit.
+	 */
+	yield_to_local_force_resched(rq);
 
 	return true;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9f63b15d309d..690a2ab99beb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1316,6 +1316,16 @@ struct rq {
 	unsigned int		ttwu_local;
 #endif
 
+	/*
+	 * Last rq_clock at which the yield_to() lag-credit path forced a local
+	 * reschedule on this rq. Used to rate-limit only the forced preemption
+	 * (cancel_protect_slice + resched_curr) to at most once per 6ms per rq,
+	 * preventing excessive forced preemption on PLE-heavy guests. The lag
+	 * credit itself is not rate-limited. Functional state, not a statistic,
+	 * so kept outside CONFIG_SCHEDSTATS.
+	 */
+	u64			yield_to_force_resched_last_ns;
+
 #ifdef CONFIG_CPU_IDLE
 	/* Must be inspected within a RCU lock section */
 	struct cpuidle_state	*idle_state;
-- 
2.43.0

