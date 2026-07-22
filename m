Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A651733031C;
	Wed, 22 Jul 2026 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730133; cv=none; b=FJe6x9Sf+Rt4tUai/8KyGKDrLUkF/bd4yqehY8guyPuJZgONkF04RTW4FYAnPa1e73bH9cjozd0OKoGx28yOWiO/dqsS2Xpr+zic4pSXR0Tb50CzVaFI/HEoUq7MhdGMKETu2hSM5hgQqntviJjmCMaVT24jGtAof3tbed5D4v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730133; c=relaxed/simple;
	bh=gGw1E3ghHHezOp91vY3ase7DrVUSqGB3oj3AKDRxkUA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rR0XYc37lhxpmhGDpMH96syBBmyzDDdUK9tBdLc0F9kSQP23zakZ/g5ovYoG7DqKvI1TRlp1URT/VZIk4bowEmNe2FcBsHqvZ4aTOYPTdE781vYjl9FLOs11040Mvt/q7ckOAU0pIsVZIEUTxN1LPzLckQOZSm5jkVwpSATX9ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmB6ej5b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmB6ej5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CF51F000E9;
	Wed, 22 Jul 2026 14:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784730131;
	bh=gGw1E3ghHHezOp91vY3ase7DrVUSqGB3oj3AKDRxkUA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hmB6ej5bv6mX78s8tM5+NvtOphFLolmZ6pixq2Hrxnfie54uyZzx98xsyL2uEQJIr
	 u2DZy8zndfFJFwBRr4Rrw1E0fOPptjBzD7hOzjkX1ZemIJViJAots9VemtQ7Qo2oW+
	 fYG6lLWjZ4ruZplBVxd//8/obi1fpU+PSS6uAyDZalXPSm43N1QUolSnFBX75IolSI
	 ELsbTcFVr2P1vFnM02HlezrQBtuuXtaHQga95QJ/D2MMyRoWwZlMLVo9J10T04I0cq
	 14ZUoH4mWusASjL7L0NfNjkddtSWRN1+5iqWFSEQ1MPd3X8znQSAF9ec587N3C3e3Y
	 L81821VekclFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] mm/mmu_notifier: Add async OOM cleanup via
 call_srcu()
Reply-To: sashiko-reviews@lists.linux.dev
To: shaikh.kamal <shaikhkamal2012@gmail.com>
Cc: kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260722140803.11421-1-shaikhkamal2012@gmail.com>
References: <20260722140803.11421-1-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 14:22:10 +0000
Message-Id: <20260722142210.D1CF51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] Reusing an RCU-protected hlist node for a stack-local list ove=
rwrites the RCU pointer, corrupting concurrent SRCU readers.
- [Critical] Disconnecting KVM from the MMU notifier during OOM breaks the =
KVM retry protocol, allowing guests to access freed host memory.
- [High] The patch synchronously invokes the release callback from the OOM =
reaper, reintroducing the PREEMPT_RT deadlock it intended to fix.
- [High] Skipping mmu_notifier_unregister on GFP_ATOMIC failure bypasses SR=
CU synchronization, leading to a Use-After-Free of KVM by active readers.
- [High] Concurrent unregistration races with mmu_notifier_oom_enter's lock=
less iteration over the local oom_list, causing stack corruption.
- [High] A TOCTOU race exists between kvm_destroy_vm() checking hlist_unhas=
hed() and mmu_notifier_oom_enter() scheduling the SRCU callback, leading to=
 a Use-After-Free.
- [Medium] Duplicated cleanup logic in kvm_destroy_vm triggers a false posi=
tive WARN_ON after an OOM event.
--

--- Patch [1]: [PATCH v3] mm/mmu_notifier: Add async OOM cleanup via call_s=
rcu() ---
Note: The format of this review has been altered to use a free-form summary
rather than inline patch quoting due to recitation restrictions.

commit 3eae3d8df937f01d0f1b5da1f0f3daf339692174
Author: shaikh.kamal <shaikhkamal2012@gmail.com>
mm/mmu_notifier: Add async OOM cleanup via call_srcu()

This commit implements asynchronous cleanup of MMU notifiers during OOM kil=
ls
to prevent deadlocks on PREEMPT_RT kernels. It uses call_srcu to defer
after_oom_unregister callbacks until after the SRCU grace period.

Link: https://lore.kernel.org/all/CABgObfZQM0Eq1=3Dvzm812D+CAcjOaE1f1QAUqGo=
5rTzXgLnR9cQ@mail.gmail.com/

[Severity: Critical]
In mmu_notifier_oom_enter(), the code uses hlist_add_head() to move the
subscription to a stack-local list immediately after calling
hlist_del_init_rcu(). Does this overwrite the next pointer of the
RCU-protected node before the grace period elapses?

Concurrent SRCU readers traversing the global list might follow the
overwritten pointer into the stack-allocated list and read garbage data,
potentially causing a panic.

[Severity: Critical]
By removing KVM from the subscriptions list during mmu_notifier_oom_enter(),
does this break the KVM retry protocol?

The OOM reaper will unmap pages while holding mmap_lock for read, but KVM
will miss the invalidate_range_start callbacks. This means mmu_invalidate_s=
eq
won't be incremented. If a concurrent KVM page fault resolves a PFN, it will
pass the sequence retry check and could install a shadow mapping just before
the OOM reaper frees the physical page, which might allow a guest to access
host memory reallocated to other processes.

[Severity: High]
The code iterates over the local list in mmu_notifier_oom_enter() and
synchronously calls the release callback. For KVM,
kvm_mmu_notifier_release() acquires the KVM mmu_lock.

Since the OOM reaper holds the mmap_lock and calls this release callback,
could this recreate the exact AB-BA deadlock between mmap_lock and mmu_lock
on PREEMPT_RT that this patch was intended to fix?

[Severity: High]
If the GFP_ATOMIC allocation fails in mmu_notifier_oom_enter(), the code
continues without scheduling a call_srcu() callback, leaving the node
unhashed.

In kvm_destroy_vm(), if hlist_unhashed() is true, it calls
mmu_notifier_barrier() and then mmdrop(kvm->mm). Because no callback was
queued, srcu_barrier() returns immediately. Could this lead to a
use-after-free of KVM structures by concurrent SRCU readers that are still
traversing the unhashed node?

[Severity: High]
There appears to be a race condition when iterating over the stack-allocated
list in mmu_notifier_oom_enter().

Concurrently, mmu_notifier_unregister() checks if the node is hashed,
acquires the subscriptions lock, and calls hlist_del_init_rcu(). Because the
stack list is iterated locklessly, won't this concurrent deletion modify the
stack-local list pointers, causing data races and potential stack corruptio=
n?

[Severity: High]
Is there a time-of-check to time-of-use race between kvm_destroy_vm() and
mmu_notifier_oom_enter()?

The code in mmu_notifier_oom_enter() unhashes the node before calling
call_srcu(). If kvm_destroy_vm() runs in this small window, it will observe
the unhashed state, call the barrier which won't wait since no callback is
queued yet, and then free the KVM structure.

The OOM reaper thread would then queue the callback pointing to the freed
subscription, leading to a use-after-free when the deferred callback
executes.

[Severity: Medium]
In kvm_destroy_vm(), the cleanup logic checks if mn_active_invalidate_count
is non-zero, and if not, triggers a WARN_ON if mmu_invalidate_in_progress is
set.

However, kvm_mmu_notifier_after_oom_unregister() already zeroes
mn_active_invalidate_count. Since the OOM event detached KVM during an
active invalidation, the in-progress count remains positive. Will this
duplicated cleanup logic consistently trigger a false positive WARN_ON duri=
ng
VM teardown after an OOM event?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722140803.1142=
1-1-shaikhkamal2012@gmail.com?part=3D1
