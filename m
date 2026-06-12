Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9637E30C164
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228049; cv=none; b=iZ6e3pbqSXccqOONLn8Q8YjjRcgWXG7cJZUMUvcyV0P6jhAih1naTDw3aPllaRdmJCNkCJCesowFLCkMOaczD3RFmMbXj3pXvrfpwziYfRL3N1iteMfx/2/INqZpc0/gJctokLkT4jMvPEj8fYiNTCudGsUoFi58t0C0xlmD+us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228049; c=relaxed/simple;
	bh=Emd0iAge1yJWElgbu72y/eRXkT0AFDOYInOspeDoNXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1xnctsCbrKpc4dEVsjiCtj42A0dEGAVlo2L5xLsJCBcxKyLuOdfmkyDu3Pd4PoQIEYVS39d3a8LLHRT3fl3rO0oM65BfCIwQnJebVNrzaSZlKT1n80nieXn5x11+jOLYYTBjt/Affl+Dh+QIVHInf0P0mbNAkPWlnLBXGiX+/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mx7SEPvT; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx7SEPvT"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-372b4330deeso363476a91.0
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 18:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781228048; x=1781832848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBO/Qu5vraFOfUtlMrr746hyyKYTO/nlkxX0iKEt41I=;
        b=Mx7SEPvT6ftiZJwmGE0vNr1bnUeB1WCAAuRI1TrS8AkC196vyzqfD75RR2LhK3noQY
         rEAyxvxr7mFEFlhOuxUNMSA+Rc17SREMsjVIs65o1OSBcZqB5kFDNktv6XsCBe1nhPu+
         6o8yDHROIbNYWVUWet7pt2SNf452P7csfpH1JJ3Ao18carrxF9uQSwR1PSLgV4QXf0Ri
         wKg4zuZbr0Xof+ppwy91U5FcVEe0tvFUyf3kc0jvAWY6e2G0FP6RzO0U1AaAZNWp7Mit
         6eTpFQr6lIDJOY4P6T8zCoBlDfj2e2yYnMXx7yrndyiaaPW3J61kU75+W/reTWh/O397
         IMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781228048; x=1781832848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GBO/Qu5vraFOfUtlMrr746hyyKYTO/nlkxX0iKEt41I=;
        b=KVlFLgTHNh/pofWRyzNZHQVs53JwX+U7Mi6P/5RjslgAx9dxd7HjLgEfs5U4HHXJNA
         Yoa2sYg0OeNFBbiG/Tmh1R571R+DkV5fduziy33c0vx1xMYPYNsxd4RYrVdeA+5zT0VE
         3N55a9/Nlg3ALbdjxB3fKgOH7vbFa2go5m0y9WQutyCjLlKpKGKRVmZS192FVzCdzOuj
         dlTdjl1tOM48dtcisb6bniqubghdyXfgjvQCqEx9vqROmH5ybOOynhiD/A6kz4aVv9Mh
         dSkZeQuXnhtHkyGzOO1shqmqcKwv954zfq5JSXKh07Wi1nOdaroO7thXj4nTWjKqo0hO
         Wu1g==
X-Forwarded-Encrypted: i=1; AFNElJ+QmDZALU5ZR4jQVv/TQogwk974Jao8FZWwKBT1uZEx9D1gklZOytbZtudobs1swbfxiK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwICT8b8OthrR3peItKdIYloanBUzGISVJ65JQysp0YuMnZtBwC
	GTkOGoEwURaui/XRG7u3Z46q9utED5MJbImgqxRxy0qI8IGSsbtz1WLN
X-Gm-Gg: Acq92OHH3CuS2uZTrfYvKMuREBQDfwuTlkVbQXpsJGu7gHcM83+efINhVcDBqEvOSYc
	szZMUuYiSJHTACXJ6uioP4+V1lO/gVFi4hNR4DmBI1IVcRpGH+XBY7JCfS7G3HFzTU783NwjXEN
	6nAopcHeaqiwHC6VGr0e7SSFxO0iiEnlW7UXrFGrul7U9xAD42jwM3s4OwxQ28yfGA99fGc7q4O
	cuZiBT6w39pUo6EF+MF4wDmlxGfsxPf75SIhufe3uFQaAXaTtlsb/cOKqiCv4SmKBz6Q5hqPS71
	CbrtN3vvntWiKoaIuxAo2ea8NVwG3ikGZAAGyXMNZ6f10zH7OGu2Ehc2CFwzrSolTCBugMlHl03
	Oew/COphYPCsfPHJTnexlmxx1fTsFq3P+5msAegRjpgABb+JwICXHxY3lMyARsV9zX5Q21JwdfC
	7sL4Ywm8i2GtNiAEW+aXubcTL5Pq2pP60lKWLo
X-Received: by 2002:a17:90b:4d0d:b0:36a:7da3:266b with SMTP id 98e67ed59e1d1-37a041af2b9mr898338a91.21.1781228047848;
        Thu, 11 Jun 2026 18:34:07 -0700 (PDT)
Received: from wanpengli.. ([2408:822f:1aba:84a0:651:104c:ba0c:1f4a])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-37a1f07bbfdsm250713a91.5.2026.06.11.18.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:34:07 -0700 (PDT)
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
Subject: [PATCH v3 01/10] sched/fair: Add EEVDF lag credit primitive for nominated next-buddy
Date: Fri, 12 Jun 2026 09:33:46 +0800
Message-ID: <20260612013355.59231-2-kernellwp@gmail.com>
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

pick_eevdf()'s PICK_BUDDY path only returns cfs_rq->next when the
entity is eligible. A yield_to() target that is behind avg_vruntime at
any level of its sched_entity hierarchy is skipped, and the
set_next_buddy() hint is lost.

Add eevdf_credit_entity_vlag(), which can credit a nominated entity up to
the eligibility boundary so that pick_eevdf() can honor the buddy hint.
The helper handles cfs_rq->curr, which is off-tree and can be shifted in
place while carrying any active vprot window.

Gate the helper behind SCHED_FEAT(YIELD_TO_LAG_CREDIT). The helper has no
caller in this change, so mark it __maybe_unused; there is no functional
change.

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 kernel/sched/fair.c     | 48 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/features.h |  9 ++++++++
 2 files changed, 57 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3ebec186f982..e7f5ea25fdae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9341,6 +9341,54 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
 	}
 }
 
+/*
+ * eevdf_credit_entity_vlag - credit a nominated next-buddy to eligibility
+ *
+ * Advance @se (already nominated by set_next_buddy(), so cfs_rq->next == se)
+ * just enough negative vlag to reach the eligibility boundary (vlag = 0) so
+ * pick_eevdf()'s PICK_BUDDY branch returns it. cfs_rq->curr is shifted in
+ * place (off-tree, carrying any vprot window). Queued entities are left
+ * unchanged.
+ *
+ * Idempotent: a no-op once @se is already eligible. Caller must hold
+ * rq_of(cfs_rq)->lock with rq_clock up to date.
+ */
+static void __maybe_unused
+eevdf_credit_entity_vlag(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	u64 avruntime, credit;
+	s64 vlag;
+
+	/* Callers gate this helper with YIELD_TO_LAG_CREDIT. */
+	if (cfs_rq->nr_queued < 2)
+		return;
+	if (throttled_hierarchy(cfs_rq))
+		return;
+	if (WARN_ON_ONCE(!se->on_rq) || se->sched_delayed)
+		return;
+
+	update_curr(cfs_rq);
+	avruntime = avg_vruntime(cfs_rq);
+	vlag = entity_lag(cfs_rq, se, avruntime);
+
+	/* Already eligible: nothing to do. */
+	if (vlag >= 0)
+		return;
+
+	credit = (u64)(-vlag);
+
+	if (cfs_rq->curr == se) {
+		/* curr is off-tree: in-place shift, carrying any vprot window. */
+		if (protect_slice(se))
+			se->vprot -= credit;
+		se->vruntime -= credit;
+		se->deadline -= credit;
+		return;
+	}
+
+	/* Queued entities are left unchanged by this helper path. */
+}
+
 /*
  * sched_yield() is very simple
  */
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 84c4fe3abd74..65c511c9ca28 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -40,6 +40,15 @@ SCHED_FEAT(NEXT_BUDDY, false)
  */
 SCHED_FEAT(PICK_BUDDY, true)
 
+/*
+ * Let yield_to_task_fair() credit bounded EEVDF lag to the nominated
+ * next-buddy so pick_eevdf() honors the hint even when the target has
+ * negative vlag at some level of its ancestor chain. The credit is bounded
+ * by a queue-depth-scaled margin within entity_lag()'s legal range, so
+ * fairness is preserved.
+ */
+SCHED_FEAT(YIELD_TO_LAG_CREDIT, true)
+
 /*
  * Consider buddies to be cache hot, decreases the likeliness of a
  * cache buddy being migrated away, increases cache locality.
-- 
2.43.0

