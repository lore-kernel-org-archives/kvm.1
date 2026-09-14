Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03BB36F42D
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409552; cv=none; b=O1XysHyCtCkD2de8B8bAOXGue5c7R57uLfCFDyoZVEikqCIT3bZ3KhozV+2WQpW9f5AQ4IUKKnv6eEEG5iCDxPBHMeEnpqB71NyZYUiMNQRBy/8nvGs44+XDROwDZoUJ3kfTPQWL5BiGJQoo/dAZ40GpGVDOsXFWkNR9Rs0xiCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409552; c=relaxed/simple;
	bh=H4sD9NLhYyNcdEysJoW8KxDlT7mpxdzkkXtdPUFPlqM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hFLkbksnXhE/edpgqX1FBCNhs7ImjyPJzaSJ3mE782QggS8YF57IWNdmubudmnW/Avkv6M6U5rYeDAfNnIf2UJ4L2gDe772OdUEy+4kSIOEdBKD7EPYr6ek04HEAKfFqfGCMIRyZ5CQdLq0dV85EXOIEYtQpSaMk4/zvAIPQXY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fcmS4yQk; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fcmS4yQk"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso6358820a91.0
        for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 11:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789409546; x=1790014346; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rGmw5H8u8SeMzlWekJA+yxf9/caHSlRymD+gvDgsKlA=;
        b=fcmS4yQknnbr4ayLfd2G0p9/fSw1Lb9tk4COVJz0L7sGngUKHgtM7I07jqpY4pP7sJ
         DkAbVeNVSJQuEuSKLiE3Z/jDgUcc9A8BYzqvvsr/lNTZsnADDyRMu8u34h/u6INd30LR
         gM4we7lPn7XpYoVNMfEwvyRLKEXjv7jC+s4s9b7kmvJgtO3FCsFYvJPwoQdX+jZ2BWka
         psUB4tYT+M8sdJ0lyAnY3eu84ADL++WZJMshV3MQtNgGRC53+v3XvjqYaiQ5IGFgbUo9
         ud+ZIhY24HbeEuAJ65Nmz07f55FSPwyRA1RyAPw/fOXJT9tPm6rD2pP5VwW5MpzpjsHs
         Z+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789409546; x=1790014346;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rGmw5H8u8SeMzlWekJA+yxf9/caHSlRymD+gvDgsKlA=;
        b=XY3K3T2biUBhbDOel8v+ld54KoGFlCq2dn9nds7Otf+tZR3rDfZ9lQyXpR8tjAxGde
         RuvfWMO+23xmJoA7/I6l78Cw7vRs0N2wEopBlgev2f7KYBsBcAvO0d/7WFDQNRfy0/f2
         qVX2lCRG49Wda2RXYyI+8n/iK6VGacamDck+yiiBMC6wjo07SrWcrS4WgWb3BNrou4Fr
         6UKn0keGabxFG44q/lgkuJmlSvrcU8JJ+MVjur2iyNSTQGpzVQy1bfjW1lSeCNDIdq54
         2Vxa3LKgV3CXFAhGcSubLjjZP7LiG8Y+5qItaBbj6p1mtP80cqK/3yhCuTm+3rhD3c60
         QUCw==
X-Gm-Message-State: AFuF++m7lAcq4eVsfX23Hb6n0XXIfcm26H8LSpCfkJrsSP1KS8/l3bdC
	W5JzH+5/noeSFGps96bcRVphLCQxdK5B20H46zg5qWa8BVcqsM1WbDPbt8Vi4R5BVAculbPARZl
	ngPTlLA==
X-Received: from plbkn11.prod.google.com ([2002:a17:903:78b:b0:2dd:54fd:8640])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b10:b0:39d:e54c:a28a
 with SMTP id 98e67ed59e1d1-39debf9b35dmr6973791a91.8.1789409545861; Mon, 14
 Sep 2026 11:12:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 14 Sep 2026 11:12:19 -0700
In-Reply-To: <20260914181223.289061-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260914181223.289061-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260914181223.289061-2-seanjc@google.com>
Subject: [PATCH 1/5] KVM: Reject attempts to lock all vCPUs if vCPU creation
 is in-progress
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
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

Opportunistically drop all existing manual checks on vCPU creation being
in-progress as all such checks immediately precede or follow locking of all
vCPUs.

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
2.55.0.1032.g73a4cd73de-goog

