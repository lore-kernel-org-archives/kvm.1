Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF2B3D8122;
	Fri,  8 May 2026 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778264263; cv=none; b=E6Aj+QUJ+KDqGBkHbbUgUFTQ6VzpD5vpB7T/4SUOfPKTpZLcWOock8LHq0DMVCQDVFA44/t443Zuh+1FKX8HKyGEIV10PJj63ox8qE1awooAbNkgY3DT9BhgepiKwzQEydBXqSWoUGVXCK0tl6qzLeuCHNdYRm976Y8xLvH4t0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778264263; c=relaxed/simple;
	bh=2ACizhkl4W/Aai3iUn5Na6hUxUGCawJ8JBkYrlgzOAQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIS7P1GPtMv37gkdZvIXz+7d+PGq7mAsGJ9j6xPbFNYRdOWqbyxvRX+wK83rAh1U14pOc/tvrkTVSMFQ/eMGDCK9STkj55e+of4gE6PRZk+XUgiDkaQ71POCqamO6ZLlaXqUTHuVsmZCXi4V5//iXn75PKcTFlzitt4sZPvTbBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a03sg80Y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a03sg80Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=FQOlSxV2N2SZxsJanRrE5lx7UIrWEeyRThnKAatYFck=; b=a03sg80YA+skTAfvvdbx/mOu6c
	jVfRWw2U0oJJ05+3OFSD/1AjPot4c0pwpTJUN1OgsnPEcSU95vWFaeKVsd7DDBEphoTJK0mzKC9s0
	/UF+OQl9WyXxmATyBqsIESmPdfwtXG33lziwIH9emTVs2dc+hFZCSxl8QJV0QEe0/zbzPKZ9QBelg
	s+TQzPlmhcaYDfDEU2HHk1Tv4hcDu9aX8HNVHBit7wk2myTXMRSkG3754eNXd2qj+7YJ9LZxntF8g
	tKNztP9zzXfZb7rz5U2Ob/qTHWE3Wb/hXlFyI7o4tVbLvdqDT6zIu3uACmwSK5FqbQkgpY5pEQeVR
	8qLu4eNg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLPlH-00000004XFE-1L2g;
	Fri, 08 May 2026 18:17:20 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLPlH-0000000DYYd-03S5;
	Fri, 08 May 2026 19:17:19 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paul Durrant <paul@xen.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Mauricio Faria de Oliveira <mfo@igalia.com>,
	kernel-dev@igalia.com,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Subject: [PATCH 1/7] locking/rt: Use raw_spin_lock_irqsave() in __rwbase_read_unlock()
Date: Fri,  8 May 2026 19:10:03 +0100
Message-ID: <20260508181717.3230988-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260508181717.3230988-1-dwmw2@infradead.org>
References: <20260508181717.3230988-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

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
2.51.0

