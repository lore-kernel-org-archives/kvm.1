Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D251E834E
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777558622; cv=none; b=LQ+MGFEMP4rwQcMkz8Lmgl0ALMU/pC3zLLOFGqu0Fb9qzJtiT/3gPkcH/dpB9jTPhltGIkL64AyPdmAYBeitLZbCQhRqGaDYc0eNtLDRCCvLcDyKtKXVoFqlmLaGJyPsKB78k4knVDCc7H8dT9rUlT4/Ai7xcUo1ymANkOupqdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777558622; c=relaxed/simple;
	bh=zii+nV2err+fyskK0vqQWcMICzkH2Dq/bzGZueIYXuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2zzE48pnMg0doVjo4nUuGugeLc2JVts7vGMCL/8EU2My6LQFcJA54Id7mZNddF2GJLNhU9hyPW9MOJ4a8nZk6rVsO/a+SyRvDTDsQ1yiCIyAn1rO1o/Y7fo/imdy3kxywiIt7ktch2uv7XMb2k1kK/EFgHpqcDuVAS47qBYifk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUcZz9pk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUcZz9pk"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b24fdac394so7660865ad.3
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 07:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777558621; x=1778163421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHo9iPjyCSduKMwgGnNHZX/dT+4HXSckBt2Ukm/+PI4=;
        b=BUcZz9pk5agBhhQW+N74e1nHP6MciUAyHGszirliXVHHBZGP+Xy7tAX5AxusJuL0vX
         f4YYwMTcVxsBki3Gy4SRx/wrCAcCAALh4tcC/9v/plCDoFN9xG80chqpWXIhD7It0sbz
         wXOw86Ddeu+ic8Ffv93EVkSKR1qwe8qMcuwAkkKThviowC6JqcZVxf15w0PSHU/MaT/H
         fdUe8MvEDjPJ+vGqUBWvX8A4N4uWyuO3Css2u/1GxvDykLr8UKEjTUZE2bfKgyLfe0oX
         CdnIx4Tsd+x6TYFN+azFHzPSnwWNAcMGNv2QfUrly8OEfD9nF0xGgOVhHsyMi8uGRhpN
         lYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777558621; x=1778163421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aHo9iPjyCSduKMwgGnNHZX/dT+4HXSckBt2Ukm/+PI4=;
        b=IvxPBno/YG9jWN5m3S/cJLrmbDMriqbIwKiGDsgT1+CsvvzmhF1n5pGLRfQWvVm7id
         iOBmdaASNwszgbFri3Wpb/NCqVjFmKXJsUGesAYd5PxXr89rhIadzwwvkAwEImzXwauy
         OFOCpRHhoEvG/cxt86SZ9LAOawxiTesqMz8oTPUDv4YYTwthwdkUppETmYU57duYMmPZ
         Dg0nHZpS6bGPjYOeLNFK4toPzsmtNJ76pZskLOR07A38lXpAQwMAL3lwoUxmkpJ+cLhb
         7FRGWbBe/QZebzSYEPthYTpDTvK31Rb+70LR8DoX5X5NQJk/H9esZVm+ZaS2KelVNKga
         uELA==
X-Gm-Message-State: AOJu0YzGnZX2ajvLAxMtYwfYU7u3xwDZtGtRu60NIurdh//myhdpvPUi
	NOE2cZI0f61TVXQwTGqEoSqA8HLOPbOtHT4g40dK5eFZsocW9xaAp4ZL
X-Gm-Gg: AeBDiesoeGCvEqkVe94nHRFcJhcFpFSx+61oMbNKqMHOBkK2VSu78GonmxUdgqybtyh
	P71GsBJeZiEeSyeDpw5wUQSRP867MepAskXiddPf8kfmbco9uRaVCr1ucVsT9UaCmqYdYiKgJXr
	1KgBc/7qzHxqfPV1RKbaGUkQTKolZHU+ot4ca6Tc4L55fcJ/f9cRxhZkVAPkylUJBRxLLUUCcUg
	Jd6ucnNkUf7sQtu+K9G/T1NZ3sqgPKmu+9oT2/5kK9ssuq26YBDwLNM2FIgmVFvz5moZ5qrb2d6
	H6vs8ufsiT4Dx41Ta77mdZVIHTal15GCz5ObU4MKAQR8wsBiKk0of/ejyq8Pm8FiIrKxpEd+45O
	hMzq4Zo9y+3CNfz+oGK9O494Ik7nkuIxT2l96aGGdcXLLtKodgnayfhy6KK10bbsQO4UB2z4oqY
	TRw7jGaLsqsMYLMZjVP/lSiQ28g5nUdf4atDkFKTie9UYyVaH8Hk4=
X-Received: by 2002:a17:903:3212:b0:2b7:a3bf:b2a0 with SMTP id d9443c01a7336-2b9a23054f1mr22891225ad.5.1777558620563;
        Thu, 30 Apr 2026 07:17:00 -0700 (PDT)
Received: from acer-nitro-anv15-41.. ([27.4.92.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9887ad80bsm57132495ad.37.2026.04.30.07.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 07:17:00 -0700 (PDT)
From: "shaikh.kamal" <shaikhkamal2012@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kvm@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	pbonzini@redhat.com,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	"shaikh.kamal" <shaikhkamal2012@gmail.com>,
	syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com
Subject: [PATCH v2 0/1] mm/mmu_notifier: Add async OOM cleanup via call_srcu()
Date: Thu, 30 Apr 2026 19:46:39 +0530
Message-ID: <20260430141639.10815-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABgObfZQM0Eq1=vzm812D+CAcjOaE1f1QAUqGo5rTzXgLnR9cQ@mail.gmail.com>
References: <CABgObfZQM0Eq1=vzm812D+CAcjOaE1f1QAUqGo5rTzXgLnR9cQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements the after_oom_unregister callback design
proposed by Paolo in v1 review [1].

The current OOM notifier path calls synchronize_srcu() inline from
mmu_notifier_oom_enter(), which can deadlock on PREEMPT_RT when
locks such as siglock are held. This series moves the cleanup to an
asynchronous context using call_srcu(), allowing the OOM path to
proceed without waiting for an SRCU grace period.

Subscribers opt in via a new after_oom_unregister callback in
struct mmu_notifier_ops.

KVM is the first (and currently only) user.

Changes since v1 [1]:
- Implement after_oom_unregister callback in struct
  mmu_notifier_ops as proposed by Paolo
- Add mmu_notifier_oom_enter() to detach subscriptions and
  schedule cleanup via call_srcu()
- Add mmu_notifier_barrier() (srcu_barrier wrapper) so consumers
  can wait for pending callbacks during teardown
- Move call site from __oom_kill_process() to __oom_reap_task_mm()
  to fix KASAN vmalloc-out-of-bounds observed in v1
- Use hlist_del_init() to keep hlist_unhashed() correct for the
  kvm_destroy_vm() detection path, avoiding use-after-free on the
  stack-allocated oom_list head
- Add KVM after_oom_unregister implementation to clear
  mn_active_invalidate_count
- Update kvm_destroy_vm() to detect detached subscriptions via
  hlist_unhashed() and use mmu_notifier_barrier() + mmdrop()
  instead of mmu_notifier_unregister()
- Remove pr_err() on GFP_ATOMIC failure per checkpatch; the
  trade-off is documented inline

Testing
-------

Developed and tested under virtme-ng with PREEMPT_RT, KASAN, and
lockdep enabled.

Test setup:
- simple_kvm.c: minimal userspace program that opens /dev/kvm,
  creates a VM, registers memory, creates a vCPU, and sleeps
- CONFIG_DEBUG_VM-only debugfs interface (not part of this
  submission) at /sys/kernel/debug/oom_reap_task to invoke
  __oom_reap_task_mm() on a target task

Test sequence:
  $ ./simple_kvm &
  $ echo $! | sudo tee /sys/kernel/debug/oom_reap_task

Observed with patch applied:
- __oom_reap_task_mm() completes
- mmu_notifier_oom_enter() detaches the KVM subscription
- call_srcu() callback runs after (SRCU grace period)
- KVM after_oom_unregister clears mn_active_invalidate_count
- mmu_notifier_barrier() returns cleanly
- No KASAN reports, no kernel BUGs, lockdep clean

Stress runs (20 iterations) showed consistent results.

Reproducing the syzbot-reported issue
-------------------------------------
The issue reported by syzbot is reproducible on an unpatched
PREEMPT_RT kernel, triggering a "sleeping function called from
invalid context" warning in kvm_mmu_notifier_invalidate_range_start().
With this patch applied, the warning is no longer observed..


Known limitations
-----------------

Failure of GFP_ATOMIC allocation in mmu_notifier_oom_enter()
causes the corresponding after_oom_unregister callback to be
skipped. The OOM path cannot sleep without reintroducing the
deadlock this series fixes, and synchronous execution would
require waiting for SRCU readers. Cleanup still occurs later via
the normal unregister path. A mempool-backed allocator could
address this in the future.

[1] https://lore.kernel.org/all/CABgObfZQM0Eq1=vzm812D+CAcjOaE1f1QAUqGo5rTzXgLnR9cQ@mail.gmail.com

Reported-by: syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c3178b6b512446632bac
Tested-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>

shaikh.kamal (1):
  mm/mmu_notifier: Add async OOM cleanup via call_srcu()

 include/linux/mmu_notifier.h |  10 +++
 mm/mmu_notifier.c            | 123 +++++++++++++++++++++++++++++++++++
 mm/oom_kill.c                |   3 +
 virt/kvm/kvm_main.c          |  27 +++++++-
 4 files changed, 162 insertions(+), 1 deletion(-)

--
2.43.0

