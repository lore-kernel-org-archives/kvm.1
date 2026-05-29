Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D25239E7E
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073488; cv=none; b=WUTKLWKvWMZ31zQ3NdhoBH707Nlu41OKuJKrvwcrzPPpQZyDOiLqUGEN4pcPVW/TU4bX50QIJQPCKHoSXfbPvikoj9PqRwVN1UYS6u0yZr1eIS944QKCAXceFrczas9hYOMl9QxBkOz3ZAl3X9oQpHfTcxw9Thq8IpP/c3JMi74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073488; c=relaxed/simple;
	bh=PbZYMZRYLczdjt2P7xyS0U+UYKMH1FVH6F9kfPQzfB4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cP/rMV0y0Vlu/jmY3TzzGPaqC/aX/YlExJPZ0HDl69EjJ+M7p9Gr7riwwEqyCZ3JiFDZrPt7cMcyTVWOJ9NPfcYX5oyOWxUByW4YqcDD6nGkTnaE8h3TtO6bYnY4OdSn1HDp5GNEzzDImLmCRUNZrBOVjeFdjfIhobmTFWhDJ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h0hO+NlS; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h0hO+NlS"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-368b15eeb3bso24942982a91.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073484; x=1780678284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6zDAoeEn8PGfgusvzyR+7E54OCJzqQJJs9HK0Wh5WQw=;
        b=h0hO+NlSgGq4KgqmSJCjndfLsaogBKwFMvXhwrd2mTGH7ljDWhhWho1QTnFqVezNsA
         H0nxr8pDvQPwZRkaFfayt8IT4f8uwCdUZoZLdelpah9uuINqaZY+1CBJVMOMvrLmSNMu
         x6pumHutNyRV9ESNlTcKlM+PFWMDkSKo0/chudi2OXnCGA0ShKyswO13UdsaxrBc0Hbr
         mmd1Jj50HAbnpD09oL+6DT6JimnDE5MhBjycWxnJ5KJctEAlUq7F7cha3ltjllJRHdxt
         8cTGgRH7Xjal1QZ0mX8Oe2yWVUr96qQlgyJ5G4xRyhgxTts65mrEjAiTD5ZtyDqD8oXO
         Vt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073484; x=1780678284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6zDAoeEn8PGfgusvzyR+7E54OCJzqQJJs9HK0Wh5WQw=;
        b=MoT2kVYqSCPdqo2YaNokjI1GopVWlWc77JPUX9Yqotd7QeRL7jf1H2cZtr2Uwq1nfF
         v0OSAHqAU29Il6MgRjF1jkGBDaBcj4HpP4vLlngBvX6ExYrBjo9AUhJ2r6mfrvVFdxKa
         rvHEq/lUM6kg69/gS/GZEan2LWGiREIxK/0ulVsNXnWYQyS3WGT4YNkXnpnb7iBVOtfU
         9fX1kpHRsWx5xOEGyR97g4Y2Jn/QLVcfaH3CloD41dFYjRqON2qF0fJQhPhBjW/K3Asc
         N5oQiJ3os7kHM5ojo42arawO3HwZvG3AybVUOOfmTyDdUOlPRw/sEYz6qCOrQgdLaLlB
         b+Qw==
X-Forwarded-Encrypted: i=1; AFNElJ8FOQrUOVROAUnMZMVJcoiqziQ+mkvvahRWRvb2f/ST8+XgghW1LD+Nrc4B0o36HQU9j34=@vger.kernel.org
X-Gm-Message-State: AOJu0YydSSfBpegTyyn0rfh7DOTohRK27MOeFpW3Iwq9qf+BV78oJmC1
	sBnF7G2FnLFVMF1QkO1RZKJ11Kkg8YBFE6KBS+REPMe7anT56/HEtL43uP+0e6S75bKLqXqqO2/
	NpDVBeA==
X-Received: from pgbeh15.prod.google.com ([2002:a05:6a02:256f:b0:c80:15fa:8bd5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6f0e:b0:39f:a42:9247
 with SMTP id adf61e73a8af0-3b4281db00bmr6956637.37.1780073483920; Fri, 29 May
 2026 09:51:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 09:50:55 -0700
In-Reply-To: <20260529165114.748639-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529165114.748639-2-seanjc@google.com>
Subject: [PATCH v2 01/20] locking/rt: Use raw_spin_lock_irqsave() in __rwbase_read_unlock()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>
Cc: Waiman Long <longman@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw@amazon.co.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
	Carsten Stollmaier <stollmc@amazon.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

__rwbase_read_unlock() uses raw_spin_lock_irq()/raw_spin_unlock_irq()
which unconditionally disables and re-enables interrupts. When
read_unlock() is called from hardirq context (e.g. after a successful
read_trylock() in a timer callback), the raw_spin_unlock_irq()
incorrectly re-enables interrupts within the hardirq handler.

This causes lockdep warnings ('hardirqs_on_prepare' from hardirq
context) and can lead to IRQ state corruption.

Using read_trylock() in hardirq context on PREEMPT_RT is safe because
it does not record the lock owner. The read_unlock() acquires the
wait_lock which is hardirq safe. This change additionally allows
rwlock_t during early boot.

Switch to raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore() to
preserve the caller's IRQ state.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/locking/rwbase_rt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 82e078c0665a..25744862d627 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -153,8 +153,9 @@ static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
 	struct rt_mutex_base *rtm = &rwb->rtmutex;
 	struct task_struct *owner;
 	DEFINE_RT_WAKE_Q(wqh);
+	unsigned long flags;
 
-	raw_spin_lock_irq(&rtm->wait_lock);
+	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
 	/*
 	 * Wake the writer, i.e. the rtmutex owner. It might release the
 	 * rtmutex concurrently in the fast path (due to a signal), but to
@@ -167,7 +168,7 @@ static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
 
 	/* Pairs with the preempt_enable in rt_mutex_wake_up_q() */
 	preempt_disable();
-	raw_spin_unlock_irq(&rtm->wait_lock);
+	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
 	rt_mutex_wake_up_q(&wqh);
 }
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

