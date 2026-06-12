Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1E38D3EE
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228058; cv=none; b=QExbVqTifB2rvM5ORQyCQpD8lzPaFsns9DIrDLzD6DnC3dO+vu2+pGJGOj7hR/UM0zyqHDf9c241YyjbQAxnfu7qq2paV7Puu5Ikcg1yIYjbyZzN5B4+jBSkP3zRH3ZFs4+9gcGlvWwNUOainAXpRHWMtVak3WmonBxWsEBjeE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228058; c=relaxed/simple;
	bh=zEeIioN7oPapJU3c9h2RVk4/EEKpXxCPOa9eJ8a1a+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4/C4apt2NQJCfT1KdRU0xQN2ugkc8578zFuhAleIAtKaHesgQQAaNr03iFnmBxJ7N4VI10WfCnIRBDIakaws4BeWR6evMQ9xzWz+1avDHDKQZ9H4qHl3GEkX2TyMK+XB/Ka2ZIL3HxvcY/KlaMs5JnjkhrRGBRH8evdWumVvSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TW3lTVUP; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TW3lTVUP"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36b903567fdso600816a91.1
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 18:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781228056; x=1781832856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNVO+jh+8aLfTJNTOqrL5GNoeR3NQijoBRRQ+uUU0zA=;
        b=TW3lTVUP220JrA86kyovA0ZqVKJ1r7ngag1XMOfpsgzfGbeWNPVH9mIQ6A9ilXWx5y
         xS6phDZVtXbpDGCpnl0K/EvlHbwvmPZPPw4mITZRpQNrukSVuqjwhZ7W8Q9/CFZWas37
         ePGkMsxBBLqfFmCDWfhEmkq1VvisLRUralh6+JIm+Mfk+d38vq5oHaEl2Vx+jaSt3rsK
         dtTNBTcoLWI+Jd6WZNV0uB3WW1n+So8JDWatQBZ9aheZWDog0Lfwh39KvEOgnOCX91EU
         +KrXdN8++BRJuHDFNn0EA2UUIkM6jqEABcht2Ru1Bcrk09HuZup95WQYhoHl/GdwNUNA
         tv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781228056; x=1781832856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UNVO+jh+8aLfTJNTOqrL5GNoeR3NQijoBRRQ+uUU0zA=;
        b=dTziOFPz648/8nUxN5b/gPYN9kJR0KRm2F31mEeuEEv7wP+C44ygh3EsUxBgMVYU2F
         skNq53QJ+ec07doU1/YL8nYQVECBnTJRCvpq6qbdtkIbwrngb+7QM0WL8OB04v+AndpL
         QpRcRpN+PEZ14y2m1t+feLkXLWi1TGbSem9xIsvTm2z/MBL2DEFOHcJbwJ04AkklOMKs
         FnnZyA3AVFoUOSSHbIliDh7Cjdgnh0T7pvX7TPhUdsphSCcADCHpZA0ulKHOlbbyUe6N
         L89yrEGpniFpB/sKHqCknm0ReVKq3UKFTTyCW6vQKuhWkgGWKTapgHQYDZGor70f6AGU
         l2gw==
X-Forwarded-Encrypted: i=1; AFNElJ9mVe1GkNmqvKPN4XTsHECUVrJiQmWx5CoyFtg5qECs53fh8ln/O9GkGdxMr+ezjgR3XQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqdn5NpR9ZQlV6Sz8SkGne/dLgpLknSaa48jNLw6ZUKCKer/j6
	W69luvkMHNZ2E8PVHPqhM/VDxcQfQbv+Ym4lwsV8mzY1oXTFWRAyvceU
X-Gm-Gg: Acq92OEXk54JqW9wkTK/r9AnsiolS3aIQ3VEOV1YliwtgV0tI1WUedMI+exHT92u9fy
	aiAbYBCNo/HQq2uA1M9b6rwZzgostzr+eshQF9jbGN8eXwkMRxNM6aPdAvi1UeQh8FRn+y6gi67
	wRWktqYpykLUF24D2oCcbDF9wGuj+NWiPW1tWsjG7xOiNiDC+EdI9RHcbqJJS4UGE8+w9MMAZ75
	h4dxLURnX2R8I21ikvvfyGy+izYYcskt7DUMUWnWbHNk9JOFmmCoYhA+ybwHFlkxKuauvCxafM0
	MVmmdHFv85uEt4g/btSo6SvIJ3Gb8pvqTCjmOWH0k+11C3gxWAqdb3FwV/mzpEpSY4fJx3buXF1
	FwkDbFvS6TrJn8hy63rvvIfa4qM4c4AsmA7AClPXrS/p7YMouyU3WquNQ4Szl401oWi+ZGHiJTp
	bg3zDK+VszpS39qNpH8/UsEoTlVg==
X-Received: by 2002:a17:90a:dfc6:b0:36d:6315:1de5 with SMTP id 98e67ed59e1d1-37a03ccc5c1mr890655a91.18.1781228056379;
        Thu, 11 Jun 2026 18:34:16 -0700 (PDT)
Received: from wanpengli.. ([2408:822f:1aba:84a0:651:104c:ba0c:1f4a])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-37a1f07bbfdsm250713a91.5.2026.06.11.18.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:34:16 -0700 (PDT)
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
Subject: [PATCH v3 03/10] sched/fair: Credit queued next-buddy via canonical requeue
Date: Fri, 12 Jun 2026 09:33:48 +0800
Message-ID: <20260612013355.59231-4-kernellwp@gmail.com>
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

eevdf_credit_entity_vlag() handles cfs_rq->curr, which is off-tree. Extend
it to a queued entity, which is the common case when yield_to() targets a
task that is runnable but not currently executing.

A queued entity's key contributes to cfs_rq->sum_w_vruntime, so its
vruntime cannot be shifted in place. Use the canonical place_entity()-
paired requeue pattern: snapshot vlag, make the deadline relative to
se->vruntime, dequeue the entity, apply the credit via place_entity(), and
enqueue it again. This keeps sum_w_vruntime consistent with entity_key(),
preserves the slice, and shifts the deadline by the same amount as the
off-tree current-entity path.

The helper is not called in this change; there is no functional change.

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 kernel/sched/fair.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c6502db62cd3..c28682fedb36 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9372,7 +9372,9 @@ eevdf_persistent_margin(struct cfs_rq *cfs_rq, struct sched_entity *se)
  * to a bounded positive-vlag margin so pick_eevdf()'s PICK_BUDDY branch
  * keeps returning it across several picks, without exceeding entity_lag()'s
  * legal bound. cfs_rq->curr is shifted in place (off-tree, carrying any
- * vprot window). Queued entities are left unchanged.
+ * vprot window); a queued entity uses the canonical
+ * place_entity()-paired requeue, keeping sum_w_vruntime consistent with
+ * entity_key().
  *
  * Idempotent once @se holds the margin. Caller must hold
  * rq_of(cfs_rq)->lock with rq_clock up to date.
@@ -9422,7 +9424,22 @@ eevdf_credit_entity_vlag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		return;
 	}
 
-	/* Queued entities are left unchanged by this helper path. */
+	/*
+	 * Canonical place_entity()-paired requeue: see dequeue_entity() and
+	 * requeue_delayed_entity(). place_entity() restores the deadline via
+	 * "se->deadline += se->vruntime", so make the deadline relative to
+	 * se->vruntime here (not avg_vruntime). This preserves the slice and
+	 * shifts the deadline by exactly -credit, mirroring the curr branch
+	 * and keeping deadline > vruntime.
+	 */
+	se->vlag = vlag + (s64)credit;
+	se->deadline -= se->vruntime;
+	se->rel_deadline = 1;
+	cfs_rq->nr_queued--;
+	__dequeue_entity(cfs_rq, se);
+	place_entity(cfs_rq, se, 0);
+	__enqueue_entity(cfs_rq, se);
+	cfs_rq->nr_queued++;
 }
 
 /*
-- 
2.43.0

