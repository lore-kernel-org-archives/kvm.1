Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC86037F73E
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782426396; cv=none; b=F48T9aze6DNuXwFjkFR5x5oMOv1CeYluPqCXojVhRBJeo+AV9CkOQ+aym+Yajtnpcx7ptG1oNiW9bwT735bltOTs8CzkFvV3cdgUJW7abf+H95esQrNiyrH0QLfn7ebVF6d0/YUyaVabhwQxL0/tijZqVSao2Owlu/Wfq0N5ook=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782426396; c=relaxed/simple;
	bh=IPnJejpW3EC38YHQlvju6wy+R3SHikE4aBQS4Lf9jKw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kc/tnOYuZdqiq3Qt+ws3na+EARKj9Qgqm5E4z/hHlgSv1ZLhZsFYEDjrfjv5P2F4aVsaBhfm7WDZa+00ph0X5gy0WN+ov+mUcfJU4Nn6asUtow4GetYwOEpmCTW09KiyYNbcRwze3ZSgmiFNI1kyryoG9jjW7V7V1LgB4AtnhNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTskEjx5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTskEjx5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D461F000E9;
	Thu, 25 Jun 2026 22:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782426395;
	bh=IPnJejpW3EC38YHQlvju6wy+R3SHikE4aBQS4Lf9jKw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TTskEjx51Cn63So4M85KaQh2qrYpFIhmNIWuDlSD6t5ys/1rCO5nzVpZfBc/9+h3i
	 Tm0TmckCxPvsSmr1jDgldTtuEZ4mrz39c8x49Oxnr3h1PI4MDf60rTUDegmaStDgev
	 szr1zIw7Cz9mjVEGx64jMtKoCE6PcINnvXhlqkUzuJQDxw6kMLruryjDDMhfW+5YfA
	 r/ob+Brbqzp5SKaOkpMvBhyQ6nJCwm4siR7HOvBXR5+MnwIXuZbrQFB53pVM0rM6Js
	 zrbBIjacEzxphWDrOsVEHDl0UX0+R/j0klkcR8xyKb5K8nxZDvJvolQDk107YpWwhh
	 IqdqLcw+3At6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] KVM: SVM: Remove VM from the GA Log notifier list
 before VM destruction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260625220933.3357733-2-seanjc@google.com>
References: <20260625220933.3357733-1-seanjc@google.com>
 <20260625220933.3357733-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 22:26:35 +0000
Message-Id: <20260625222635.A2D461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Moving `hash_del()` from `avic_vm_destroy()` to `avic_vm_pre_destr=
oy()` causes a Use-After-Free if VM creation fails.

Pre-existing issues:
- [High] Time-Of-Check to Time-Of-Use (TOCTOU) race in `avic_ga_log_notifie=
r()` leaves the vCPU pointer vulnerable to Use-After-Free.
--

(Note: The format of this report is altered to provide a free-form summary
without quoting the original patch code due to recitation restrictions.)

commit 0f798fdd5f5b3e142add9c440b53828de523723f
Author: Sean Christopherson <seanjc@google.com>

KVM: SVM: Remove VM from the GA Log notifier list before VM destruction

This commit moves the removal of the VM from the GA log notifier list
from avic_vm_destroy() to avic_vm_pre_destroy(). It also opportunistically
adopts guard() for locking in the pre-destroy hook.

[Severity: High]
Does this change introduce a use-after-free on the VM creation error path?

When kvm_create_vm() in virt/kvm/kvm_main.c encounters an error after
kvm_arch_init_vm() has already succeeded (for instance, if
kvm_init_mmu_notifier() fails due to memory exhaustion), the error unwind
path calls kvm_arch_destroy_vm(), but it completely bypasses
kvm_arch_pre_destroy_vm().

Since the removal of the hash node from svm_vm_data_hash was moved from
avic_vm_destroy() into avic_vm_pre_destroy(), this early failure path will
no longer execute the hash removal. Will this leave a dangling pointer in
the global hash table once the VM struct is freed by kvm_arch_free_vm(),
potentially crashing the host on subsequent hash table traversals?


[Severity: High]
This is a pre-existing issue, but does a time-of-check to time-of-use race
still exist in avic_ga_log_notifier() even with this patch applied?

In arch/x86/kvm/svm/avic.c, avic_ga_log_notifier() looks up the vCPU while
holding svm_vm_data_hash_lock. It then drops the lock before passing the
vCPU to kvm_vcpu_wake_up(). There does not appear to be any rcu_read_lock()
or reference counting protecting the vCPU memory during this window.

If the threaded IOMMU IRQ handler is preempted immediately after unlocking
but before kvm_vcpu_wake_up() executes, could another CPU finish destroying
the VM and free the vCPU via kvm_destroy_vcpus()? When the IRQ thread
resumes, it would attempt to wake up a freed vCPU pointer. Because the
active notifier thread isn't blocked by VM destruction, does moving the
hash removal earlier fully resolve the use-after-free risk?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625220933.3357=
733-1-seanjc@google.com?part=3D1
