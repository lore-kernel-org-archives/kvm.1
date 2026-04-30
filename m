Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326193630B9
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 04:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777524196; cv=none; b=TrBorwTUHDaNzEAyJ7k2A2P1n75/ABBGay5JhxLcSzU3m7e50A/tM+afyiMDrMSsbKcoor+NqXtaBzc/FC8NOwRSWibPu9kgmpBtvTEptcfC6wHcgWZ4dHXQGDTcElh0p6wmLEh5Q3OJTEKvQqtv2pXP7npectMdd/1WcsoLKtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777524196; c=relaxed/simple;
	bh=VwTWPTxcmD8Q+mU2ivc4k8RfaZQ5s7GGiDf5PcxClEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hcWnZ2kmzDhemCRgYCuFiJUcSqyehLdnUsN/d/+/wrFI6ozu0lqDIHzpxT3sZgewSvJx9iUhpML49P+CDIpju3K+Sed5wa7mKTbml5y/0UKDXaNd7D6ZHXHvAwYAp3/01uhiKKztKHTv65MuT/ZHAv0VIMx4XJQie8UE1iokVfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pHv9+HJx; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHv9+HJx"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so317973a91.1
        for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 21:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777524194; x=1778128994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R56QgG1D9bXIBDN7pmrJ8rb2E5GLXsJR+QR5OWKoEXY=;
        b=pHv9+HJx1dS4jJUCPljZ7I8COQaLerc92hGJ0AKBbCoDCLQpbM67LieEAUBSAyxiA0
         i1cBxUJLhWF2+GEtfLD5SFC1UZ/0ew6KB0WQBr3GWBKMwBU7ZL5J/LFApZQE39jWdsea
         z9e6n7xqDD1pjetQTAhmOykhB4sF82SJDSWw1N9xiCxHDnRjPQd7xLecWwUgmlkEeaqO
         tuiBLCO9MOOzVc2QlQTVHA+h5+raWZ6VlHmzL2QVc0uFsyB+uXf9PZ+S+72PFXIoGhrr
         crE/R5SEi3QodKnodoaOYJL7NrGr9aThhOyDzkg7jTm4NOmDIHeYjUa8wrzfkyK06L8G
         kxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777524194; x=1778128994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R56QgG1D9bXIBDN7pmrJ8rb2E5GLXsJR+QR5OWKoEXY=;
        b=CjZsOSzpangJE+Yyc5mOY4bfvZcXPfO8bZTAzGjgh5SFWOEgHW4p4eBqBgGaah61sg
         Y4UsgpbPt8yGUA7WOS+Ql9q11zNc8s1bkga/M2m4w/oNC5M551Cgmby9QfuloZZCZ9Zp
         sJ1qmISpGMFH+mII1khT1kz7IYSK+eYiJhMiHgtEwbadevvLAdzKej9W1ihBd6e5T8JC
         WbrWbWjYwG+YyctTqfa34B/VvTPqA8KllZnqz4Fw/Sz9PHc8mkLLhm74Nl0y0rAvyZDG
         Ov90n5oObjtP3CH0NiPvchMEMLEiQsomqBJqkMqPw4Cy9LeZ4RNXQh9sBYHgX2eE2R78
         Mx3g==
X-Gm-Message-State: AOJu0Yy3LloPnZ/oSVk+sozxB+vCHAv9cEmn+YrwWhpUg2OUC0QWCFiE
	6jr7H1suOAwO6JwK8+o1dKW1YNudlJBCtCAj/sm82hqNxyqRsaf96WCI
X-Gm-Gg: AeBDiesWu0OIAF0ekEGvOo//9C56u9GTtsXfIg2iWi1OJ8WaSuRuUICtmEjEQ6+DmVD
	7+xUGGJvpdqOYLM56TEhhh0bokDTwEcipQ2CLZ/tkbXpqf8S3O7JzM1O54+dxCqe02Dd2uDjhuE
	kCPZ+2QJu8tHJWjREIsDfMFqp3kTbNFGoSA7ncGEbqKrnUK3hg5nqMoUjsM6Jx4XVwDIs/XC/BP
	bpNmXESFYnUH7R4Kx286ueJ9YEaubK8bXdk8tbns533kYKYhL273VP+phNiH7nVpvKdLQEXxR0a
	tfn0GHxYMynDXKLTc2mTnS0AQ0TCZZxEQhXtMx6vp25Rwh972norZ7onHddGC3vtZaHcI/Jfpju
	lE0yKJULJGwiXm1vghBCj6mXEzP4tYkeUqBEmjxRBv9J/vEtbS3e9Nck0Os5rQpmVgKLh29m/3y
	zWgn8z9x1/qpeSc4FeNXguHMCoaGJ28wjnj+1VxrAkCXg1DbRXQ2A=
X-Received: by 2002:a05:6a21:6d88:b0:39b:da83:91aa with SMTP id adf61e73a8af0-3a3cf8cbdc5mr1452663637.51.1777524194416;
        Wed, 29 Apr 2026 21:43:14 -0700 (PDT)
Received: from acer-nitro-anv15-41.. ([27.4.92.188])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd5e6e830sm3752482a12.6.2026.04.29.21.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:43:13 -0700 (PDT)
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
Date: Thu, 30 Apr 2026 10:12:29 +0530
Message-ID: <20260430044229.10736-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
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

