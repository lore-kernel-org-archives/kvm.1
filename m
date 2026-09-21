Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8600246EF9B
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012691; cv=none; b=NVY2PxuUPLZhM0EjVQX8nqVuUPUu+S1UQasUr7RHg97pkxNHfmu9lID/WL4y5BfEhqEnp0orhHZ96ixxfnNF96LnrdZhH8JLysGmbcrw3bsgAIdm2UgQCrETvDGyTF4Z3CpJ9XgvlXFQ5O+NVoBk7wh/77+YEGE2wFK7W9Eb4Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012691; c=relaxed/simple;
	bh=Pm2NqTs6oRcRC4pVvxFdi78nyABlZFM4rmakGlSjCpY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W8HYn6izBMgNY2qC+/vr5bZSuh/ViabPDy+3fJwSFl+f1qxZrFNASd2b3phMKp67mKwHbYgCc7YA1ha+SHZLHEpROXC5boe6eQ/pyB9vT2PKt9Jnk9Ou8hIdT2FDoDm158CMBIOaSpNzAibCsba6PFxxeD5IIAIf556rZhfZDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KGT20HV4; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KGT20HV4"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-86a2639398cso6662135b3a.3
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 10:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790012689; x=1790617489; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZLfRYJewP8aR3Y4V2zbyCdDW63inecBdjfc5u4aaKpU=;
        b=KGT20HV4ORvKVgmu/kWoIDfdPBrIW+iw/KC01tQxxiB4PkDg8bxOEhgFYslUAqYkXw
         FDpxDkNy1P0lsNOQjhZg4yXvc1dL9UBweQNwDQoJKju9JzY7tVJArL/B0BUPOOGpWT8K
         3fRh/iceuHBchjJMSyfd0KGwmR/j0JD+vPGB578qEsJLqT80OUwGcAtYVUxdyA86fNRp
         mUaOHq6KPnbuGcpPpRyI0pO9vtsQ5zjjdpxKSUDH1oGWlCrhobsy8pFSc1126FD62AJW
         qK1SpjubJxBimDh7u7srgwQGL24rqplorOYWbrtr3eUPrdS3pExPeyZVeATga3SGv63+
         6AZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790012689; x=1790617489;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZLfRYJewP8aR3Y4V2zbyCdDW63inecBdjfc5u4aaKpU=;
        b=ew2qVydGzKLGS0V8gj5O0E584J6U1JyMd7gPzsj0wi8MpewNltwpGY9hboqi9vSslD
         oW07HX8uP7UwGyOz5rciVms7r6t/+EMlQgibUFfd0wReo7tdw2TGbWWvFsHK6QMpBNlj
         VZTwExqSpAAzujkpp+uc4p8uFYpYoHb8WnToegQ6sqr3h+mHgwH4yARgAYObJui36ibm
         oHY1y7StUAhWpx9ZkXFhfpcFI+YjcSPwJY7O9Iqf12TSqjF0Atpkkku8sFzpBZAQtJZ3
         s6Xk050Ac1nggTdXMo63XEZkpVFsKQSuvp5dXVsR7IlSfChEAYqNSrtoyuXlb3b/CBGA
         ATwQ==
X-Forwarded-Encrypted: i=1; AKwUvBwnrZeenaEweMjpdz5WVbftCkDJ+johr30rsveU7P0m4ywzzgu7zp0EwNVK2Z0cl5NT33s=@vger.kernel.org
X-Gm-Message-State: AFuF++k1InQU0xxTpQ1yiPvZX+UlrXBure8MrBcoP522EzcOgSgaLA8n
	ekdPRqsBZcIB5WrgIoAZ5jWKVWz0QmOPhenb37ZhadH04GQ6ccD+2EVbT05vBF0F0BMiXtXVZDm
	B3a5cGQ==
X-Received: from pfbgk3.prod.google.com ([2002:a05:6a00:8483:b0:873:d536:aebe])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:12dd:b0:86b:73b4:30fa
 with SMTP id d2e1a72fcca58-874dc0ff42cmr17041050b3a.11.1790012688332; Mon, 21
 Sep 2026 10:44:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 10:44:39 -0700
In-Reply-To: <20260921174445.911676-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921174445.911676-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921174445.911676-2-seanjc@google.com>
Subject: [PATCH v2 1/7] KVM: Reject attempts to lock all vCPUs if vCPU
 creation is in-progress
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Atish Patra <atish.patra@linux.dev>, 
	Alexandre Ghiti <alex@ghiti.fr>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jean-Christophe Guillain <jean-christophe@guillain.net>, 
	"=?UTF-8?q?Pawe=C5=82=20S?=" <spawel523@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Reject locking of all vCPUs if vCPU creation is in-progress, i.e. if the
number of "created" vCPUs doesn't match the number of "onlined" vCPUs.
It's simply not possible to guarantee that KVM has truly locked all vCPUs
if one or more vCPUs are actively being created.  Holding kvm->lock does
prevent in-flight vCPUs from being fully onlined, but it's infeasible for
common KVM to know whether or not that provides sufficient protection.

In practice, this is likely a minor bug fix for the ARM and RISC-V usage of
kvm_trylock_all_vcpus(), and a glorified nop for everything else.  E.g.
ARM's kvm_timer_vcpu_init() can race kvm_vm_ioctl_set_counter_offset() with
respect to observing KVM_ARCH_FLAG_VM_COUNTER_OFFSET.

Opportunistically drop x86's existing manual checks on vCPU creation being
in-progress as all of x86's checks immediately precede or follow locking of
all vCPUs.  Leave arm64 and RISC-V alone for the moment, as their checks
aren't as obviously redundant/equivalent.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 10 ----------
 arch/x86/kvm/vmx/tdx.c |  5 -----
 virt/kvm/kvm_main.c    |  6 ++++++
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 5705723f1f41..068f8a236a35 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1125,9 +1125,6 @@ static int sev_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (!sev_es_guest(kvm))
 		return -ENOTTY;
 
-	if (kvm_is_vcpu_creation_in_progress(kvm))
-		return -EBUSY;
-
 	ret = kvm_lock_all_vcpus(kvm);
 	if (ret)
 		return ret;
@@ -2115,10 +2112,6 @@ static int sev_check_source_vcpus(struct kvm *dst, struct kvm *src)
 	struct kvm_vcpu *src_vcpu;
 	unsigned long i;
 
-	if (kvm_is_vcpu_creation_in_progress(src) ||
-	    kvm_is_vcpu_creation_in_progress(dst))
-		return -EBUSY;
-
 	if (!sev_es_guest(src))
 		return 0;
 
@@ -2510,9 +2503,6 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	unsigned long i;
 	int ret;
 
-	if (kvm_is_vcpu_creation_in_progress(kvm))
-		return -EBUSY;
-
 	ret = kvm_lock_all_vcpus(kvm);
 	if (ret)
 		return ret;
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b272c20586a7..58c255256e4c 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2728,11 +2728,6 @@ static tdx_vm_state_guard_t tdx_acquire_vm_state_locks(struct kvm *kvm)
 
 	mutex_lock(&kvm->lock);
 
-	if (kvm->created_vcpus != atomic_read(&kvm->online_vcpus)) {
-		r = -EBUSY;
-		goto out_err;
-	}
-
 	r = kvm_lock_all_vcpus(kvm);
 	if (r)
 		goto out_err;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d..78cc090435be 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1363,6 +1363,9 @@ int kvm_trylock_all_vcpus(struct kvm *kvm)
 
 	lockdep_assert_held(&kvm->lock);
 
+	if (kvm_is_vcpu_creation_in_progress(kvm))
+		return -EBUSY;
+
 	kvm_for_each_vcpu(i, vcpu, kvm)
 		if (!mutex_trylock_nest_lock(&vcpu->mutex, &kvm->lock))
 			goto out_unlock;
@@ -1386,6 +1389,9 @@ int kvm_lock_all_vcpus(struct kvm *kvm)
 
 	lockdep_assert_held(&kvm->lock);
 
+	if (kvm_is_vcpu_creation_in_progress(kvm))
+		return -EBUSY;
+
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		r = mutex_lock_killable_nest_lock(&vcpu->mutex, &kvm->lock);
 		if (r)
-- 
2.55.0.1082.g2b9226bbc0-goog

