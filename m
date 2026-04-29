Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB30639C65E
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777501550; cv=none; b=hHRBgOxn8YwM+zQIcQ5lJ44MrRnhenNGw/jdq2SqONy0N7kitYJocm0/M18nA4MCGOhVyG+2ucPTieFwSxV7/qjBFX/vADTt8VImBVU0WskkQmmkp5fiRtqt1FFJ9VAzmFicybsKluC6zqMVbm0b845TzQ3kehYHjks7Fid3wig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777501550; c=relaxed/simple;
	bh=RouSWy9ukQyKnrHikHAtMRDt9vCgJQJGzjDeWu4lk6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUR66rUQ+8Gt7YiXk95JqsZODpDZsfeqpXj8PpHEIK5nIgoUJAFnjYPgo79tBZLo7zW9ofip5n5dk76cGmhVcer+AXLCXRCubeW+wcd6ZyaCUo/BwdZeWxSmgtna5Rby7QJxdmQ4bG+i49v8qtDo9nP1nLicyL0hg6lmQpfc3EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ya8Xt5uu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya8Xt5uu"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-834da62e52dso134195b3a.3
        for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 15:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777501547; x=1778106347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxUnQLQb6XPCcE87YUxnNZ2orEQCvCppUNYgev623DI=;
        b=Ya8Xt5uu3S5jSw8Mlo/reVWoJz9Bk8lkHN0bh0QwMxrwjgXztRA2Scj1SXPr9wNixs
         D0GT5ao7sceM0Pkxv7ubOgoSdxeaKtk4y2fucoA2pwFXL/V0upHwUpwdB3QI8m3BOzE2
         4Sttx8g3srHmTiqxE0ZE0+9ahlRN0NIeZKgInBOV/6QF+GASEejaJJP3azQjpZ2mhu/G
         Eg/Cndv4zYmZU9DvICKUyoCrr+pIfBUGTpvoEir3vNcpQE8EO4tF7Q+DEtpsW/y3U5qR
         /udk4yzs7AnxflY2jn6CwVn+0IghszKFcFBxM0aPBWRUQhFcVKBpaxliYhBG9IR9jWGg
         efpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777501547; x=1778106347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rxUnQLQb6XPCcE87YUxnNZ2orEQCvCppUNYgev623DI=;
        b=BLK5WOU32j+HXiCWeu8xOge2zMDnfHCzBCyRYpd23YP+how3nojDi6NJg06+54AnJu
         9LNsgjd8ojkLl3jx8MAxyHAWNgunbdeXvHe8yLOi4wxHNiF/+Yswakd8BwRltrGQhTTM
         +HO9yfP7Mo+LPV1rn/zN4cZ02arrUY1wymR6KV04cOlMgOUbQUGbXgrW2ydUA3piozAv
         hNuNo79GON1a/kMFD4TnvRzQbO1HENE89NnaGlxGofHoiklKcwO8stjA90xXU1OW3TUe
         NgQl03tdMGy+3W8rimhwe/Qn4vLCgVP8rOSx5iCCbTU3ciWRKc8oHdC9kGrtScKmbw6m
         ZDxQ==
X-Gm-Message-State: AOJu0YzU5BcL96+AM6DLH3+piU5JmvN1RC9ebfTOcausgU5QPzqTGW9s
	NKdfXUALwnd+TsEae3AXviRW4D1nX+dmevhTbpemDziD2hbLQgrWQ947f/ZPtWIw
X-Gm-Gg: AeBDietguvzzZzqSejvP96LRPMA4vzaYHBKgcH+ihwJ+KureeVn52hYAH+/5q88A2H+
	7tnD3A/P5eetHuhmk9aPzkjqkhvFU0mk5LWo3/1TuttijpDaur8sqDYVaQMalHNaC9QxoNcqHP2
	mXpkHt8iHKRoLRKz8VlJuxC+upNIRQVlq0tR8cqCS0IbiUqvpWYTcYkdvFfrI3YltBQ2+5H3ukd
	svq/LRuIyt8xwu3bbcU+t2aQJVPuMnMShFO48OhYUbZVEfvTgg/R35rGq2MNZuarB2vPXQB6Cn0
	Y5vYVVHhAtUppmsp619oCQ58lQ1MlEFC6PndWR+URbK9Upjjb/x6gE9GjkJzXEbLTZ2siYtBbXD
	ud979eTPyZecqxRMHzjcQNiOvDo7BAHq6i2ZUxF+S+MvYswDnnQalBCdwa5vA0ZOIumasHtqF9+
	dBZHxaxqulrdsclfFPFTXPr+BogT7TaV6typNph0EDj6ryrIYHjV10
X-Received: by 2002:a05:6a00:b605:b0:82f:4a4d:3793 with SMTP id d2e1a72fcca58-834fdbd5476mr498305b3a.28.1777501546629;
        Wed, 29 Apr 2026 15:25:46 -0700 (PDT)
Received: from acer-nitro-anv15-41.. ([116.73.138.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80ec94sm3118592b3a.52.2026.04.29.15.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 15:25:46 -0700 (PDT)
From: "shaikh.kamal" <shaikhkamal2012@gmail.com>
To: kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	dwmw@amazon.co.uk,
	linux-kernel@vger.kernel.org,
	syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	"shaikh.kamal" <shaikhkamal2012@gmail.com>
Subject: [PATCH v2 0/1] mm/mmu_notifier: Add async OOM cleanup via call_srcu()
Date: Thu, 30 Apr 2026 03:55:02 +0530
Message-ID: <20260429222502.25414-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ac08V4TaM2yh9SY1@google.com>
References: <ac08V4TaM2yh9SY1@google.com>
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
- __oom_reap_task_mm() completes in ~3 ms
- mmu_notifier_oom_enter() detaches the KVM subscription
- call_srcu() callback runs after ~57 ms (SRCU grace period)
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

[1] https://lore.kernel.org/all/20260209161527.31978-1-shaikhkamal2012@gmail.com/

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

