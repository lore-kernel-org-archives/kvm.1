Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F2611CA9
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 00:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782778641; cv=none; b=uvrljmCWrRUjSakHttmn0uWwBHYy6Q116tffjQW2QG8Bz+W79/JOTxGQ+ak7/yKxKV2QrD83y8yM9M0qn883y98GA3m3doOe6GPOSWvpvwD6LoLUv9+ICg6mqfhSjN63DhkvGkrmE5lOXEAVxu5SxJclxE9RY77rPM7B08tMINk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782778641; c=relaxed/simple;
	bh=St5stl5bUApmUnayjQn04wCwTrI51KqwOH9BatWQRmk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mLbR3omi9kq/fwgSuacIubzbDKkiuHvxybTOCm4sQbCWcYRD86ZVZMWDAcQzNzcGRmoPVh3GwxJDAI5wOeTnjv5pm97IJgbuJ6tk7aF4Iovl3J7dmyAgpieGqqUYeF0M5sadTiZK4hB0YHl0iziGDQMhook2Cl69z5LZG6eg4Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+SIOjSx; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+SIOjSx"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c894391f000so4877605a12.1
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 17:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782778638; x=1783383438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QPeL7PXwAy4TAlZKGjkCeZO/SvVeUEMwTC/3k9kFrps=;
        b=U+SIOjSxUjZIbg4ndMBX5PUZ4WpjQLduXCGJsiufAo2bo0L+jQ92x98tTSC9KOUfM4
         Y8ELa6i1GbQ0zFFnZOKgBSKfmhlGc0Y+iWmbmW8HBIlVuWybWLW4o+7j4besmQ07X1Ml
         fShE7ORPJSVH0MwX+aBrCKG9X1YDE6wIgW+LGgh1D3Iuvm7ZUhUh+57mvC5B5N+/bzmq
         Cwqc8rusCeksAH/X/qVmcmmNgYvzgboG3K6XV72XhD7N+GhCvq1HmUx9RYXdgrUgmZXd
         2+UdnF5/UVPRajV8Z/gLctgTM7I0nglye9vM2hKeHSWZVFftuW/UQHukvEd1vOvfklwD
         b/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782778638; x=1783383438;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPeL7PXwAy4TAlZKGjkCeZO/SvVeUEMwTC/3k9kFrps=;
        b=ALcghTGtsU2sdR4Z+SQSRrCtvwt7nk/Q8YfAdN1brtL8b7CnbakNRIYcm5y8CzF9gw
         Los0TT/Tor4A4zl5p3CRwHHNL4EEJOy2QTcjo243OgfL3tY3M8Evd20WQucbQ6FehCsE
         AFCvW1oESqGTttcatOtonZwvdYHke9CBUpvziQuH341/qGY/TgldnbhIZ6OWCMMksev8
         qh35NLEwU6D1v3GNTPAEirY8IkX58y532G8/IQgOvVxRMrBHG0VEOuLLD6WfiF87W5jM
         tSE1xzZA4Ov5pgop0I95V8s3SJ8LKHXCpbDHA+wdKqbQ91c1w41fTTRiynNb4WosXbRc
         KhEg==
X-Forwarded-Encrypted: i=1; AHgh+Rq0qXqbg25baTk5JaZAlmnbEMFH3c0KYoupd9jm6nhs9WUwdePyGHi8rSrVQT3Y5Uu+nok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ6eual6Rxqol0ohwDragXCkpRgAbkDQSH2y7Y6TP2T3KdKRJq
	bF8EqSV3Kh7MviTmDxv2Xsv705Y3dkTuzV4CRuX1WyLjjCadgq56NsduHWvI92ipt/5R+MZdYah
	Jpz1xLA==
X-Received: from pfux8.prod.google.com ([2002:a05:6a00:bc8:b0:847:8f34:1b70])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8d1:b0:847:8910:ad74
 with SMTP id d2e1a72fcca58-8479f2bd70fmr1217534b3a.57.1782778638000; Mon, 29
 Jun 2026 17:17:18 -0700 (PDT)
Date: Mon, 29 Jun 2026 17:17:17 -0700
In-Reply-To: <akJw3nXeWO-Xavc5@blrnaveerao1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625220933.3357733-1-seanjc@google.com> <20260625220933.3357733-3-seanjc@google.com>
 <akJw3nXeWO-Xavc5@blrnaveerao1>
Message-ID: <akMLDayXmzhmvJBG@google.com>
Subject: Re: [PATCH 2/2] KVM: SVM: Drop unnecessary avic_vm_destroy() call on
 init failure
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 29, 2026, Naveen N Rao wrote:
> On Thu, Jun 25, 2026 at 03:09:33PM -0700, Sean Christopherson wrote:
> > Don't bother calling avic_vm_destroy() when allocating the logical ID table
> > fails, as there is nothing to clean up now that the physical ID table is
> > allocated later, on-demand at first vCPU creation.
> > 
> > For all intents and purposes, no functional change intended, as calling
> > avic_vm_destroy() is a big nop in this case.
> > 
> > Fixes: 54ffe74cc4ab ("KVM: SVM: Move AVIC Physical ID table allocation to vcpu_precreate()")
> > Cc: Naveen N Rao (AMD) <naveen@kernel.org>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/svm/avic.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> This LGTM, though I'm not sure this deserves a fixes tag.

Yeah, it's borderline.  Because KVM (x86) doesn't do AUTOSEL, i.e. requires an
explicit "Cc: stable@vger.kernel.org" for the vast majority of cases, we can be
very liberal with Fixes.  And so I like to use Fixes to create a paper trail for
anything where a commit did something that would have necessitate a new version
of the patch, had it been caught in code review.

> FWIW, I have had a patch (part of a larger series I am going to post 
> soon) to move the logical_id_table allocation alongside the physical ID 
> table allocation. I'm fine if you want to queue your patch first, but 
> this is what I have locally:

Ah shoot, I should have read this mail earlier.  While floundering around, trying
to figure out how to deal with kvm_arch_pre_destroy_vm() not being called when
VM creation fails after kvm_arch_init_vm(), I ended up with the same idea, though
I moved *all* of avic_vm_init() to the vCPU-precreate phase.  Because what I
needed was to defer adding the VM to the GA Log list until the VM is fully
created.

> @@ -303,10 +303,16 @@ int avic_alloc_physical_id_table(struct kvm *kvm)
>  	if (kvm_svm->avic_physical_id_table)
>  		return 0;
>  
> +	kvm_svm->avic_logical_id_table = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
> +	if (!kvm_svm->avic_logical_id_table)
> +		return -ENOMEM;
> +
>  	kvm_svm->avic_physical_id_table = (void *)__get_free_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO,
>  								   avic_get_physical_id_table_order(kvm));
> -	if (!kvm_svm->avic_physical_id_table)
> +	if (!kvm_svm->avic_physical_id_table) {
> +		free_page((unsigned long)kvm_svm->avic_logical_id_table);

Freeing the page on failure is "wrong".  To keep vCPU creation idempotent from
userspace's perspective (well, not truly idempotent, but close-ish), KVM
deliberately doesn't unwind if .vcpu_precreate() fails.  E.g. so that if
allocating the tables succeeds, but a later stage of vCPU creation fails,
subsequent calls to create vCPUs won't fail at the earlier stage.

The nice thing is that since the VM has already been created, there's no need to
every unwind on failure, because it's no different than if KVM had successfully
allocate the assets during VM creation.

This is what I have (I reworked the avic_alloc_logical_id_table() into
avic_vcpu_pre_create() and dropped svm_vcpu_precreate() in a previous commit.
Hrm, maybe that should be avic_vcpu_precreate()...

---
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 29 Jun 2026 12:23:20 -0700
Subject: [PATCH 2/3] KVM: SVM: Do all per-VM AVIC initialization during vCPU
 precreation phase

Move all per-VM AVIC initialization from VM creation to vCPU pre-creation,
i.e. defer allocating the logical ID table and adding the VM to the GA Log
list until vCPUs are created.  This will allow removing the VM from the GA
Log list before vCPUs are destroyed without needing yet another kvm_x86_ops
hook (.vm_pre_destroy() is very intentionally called if and only if VM
creation fully succeeds).

As a bonus, this re-unites physical and logic table allocation, and avoids
allocating a logical table in the unlikely scenario that userspace creates
a VM without an in-kernel local APIC.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 94 +++++++++++++++++++++++++----------------
 arch/x86/kvm/svm/svm.c  |  6 ---
 2 files changed, 57 insertions(+), 43 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 5d7adc394e5a..3393e90879e6 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -308,47 +308,32 @@ static int avic_alloc_physical_id_table(struct kvm *kvm)
 	return 0;
 }
 
-int avic_vcpu_pre_create(struct kvm *kvm)
+static int avic_alloc_logical_id_table(struct kvm *kvm)
 {
-	if (!irqchip_in_kernel(kvm) || WARN_ON_ONCE(!enable_apicv))
-		return 0;
-
-	return avic_alloc_physical_id_table(kvm);
-}
-
-void avic_vm_destroy(struct kvm *kvm)
-{
-	unsigned long flags;
-	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
-
-	if (!enable_apicv)
-		return;
-
-	free_page((unsigned long)kvm_svm->avic_logical_id_table);
-	free_pages((unsigned long)kvm_svm->avic_physical_id_table,
-		   avic_get_physical_id_table_order(kvm));
-
-	spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
-	hash_del(&kvm_svm->hnode);
-	spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
-}
-
-int avic_vm_init(struct kvm *kvm)
-{
-	unsigned long flags;
-	int err = -ENOMEM;
 	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
-	struct kvm_svm *k2;
-	u32 vm_id;
 
-	if (!enable_apicv)
+	if (kvm_svm->avic_logical_id_table)
 		return 0;
 
 	kvm_svm->avic_logical_id_table = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
 	if (!kvm_svm->avic_logical_id_table)
-		goto free_avic;
+		return -ENOMEM;
 
-	spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
+	return 0;
+}
+
+static void avic_add_vm_to_ga_log_list(struct kvm *kvm)
+{
+	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
+	struct kvm_svm *k2;
+	u32 vm_id;
+
+	lockdep_assert_held(&kvm->lock);
+
+	if (kvm_svm->avic_vm_id)
+		return;
+
+	guard(spinlock_irqsave)(&svm_vm_data_hash_lock);
  again:
 	vm_id = next_vm_id = (next_vm_id + 1) & AVIC_VM_ID_MASK;
 	if (vm_id == 0) { /* id is 1-based, zero is not okay */
@@ -364,13 +349,48 @@ int avic_vm_init(struct kvm *kvm)
 	}
 	kvm_svm->avic_vm_id = vm_id;
 	hash_add(svm_vm_data_hash, &kvm_svm->hnode, kvm_svm->avic_vm_id);
-	spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
+}
 
+int avic_vcpu_pre_create(struct kvm *kvm)
+{
+	int r;
+
+	if (!irqchip_in_kernel(kvm) || WARN_ON_ONCE(!enable_apicv))
+		return 0;
+
+	/*
+	 * Don't unwind on failure, all actions must be idempotent with respect
+	 * to creating multiple vCPUs, i.e. must persist until the VM is destroyed.
+	 */
+	r = avic_alloc_physical_id_table(kvm);
+	if (r)
+		return r;
+
+	r = avic_alloc_logical_id_table(kvm);
+	if (r)
+		return r;
+
+	avic_add_vm_to_ga_log_list(kvm);
 	return 0;
+}
 
-free_avic:
-	avic_vm_destroy(kvm);
-	return err;
+void avic_vm_destroy(struct kvm *kvm)
+{
+	unsigned long flags;
+	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
+
+	if (!enable_apicv)
+		return;
+
+	free_page((unsigned long)kvm_svm->avic_logical_id_table);
+	free_pages((unsigned long)kvm_svm->avic_physical_id_table,
+		   avic_get_physical_id_table_order(kvm));
+
+	if (kvm_svm->avic_vm_id) {
+		spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
+		hash_del(&kvm_svm->hnode);
+		spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
+	}
 }
 
 static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ab3ffe04bc35..ecd4abd41040 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5297,12 +5297,6 @@ static int svm_vm_init(struct kvm *kvm)
 	if (!pause_filter_count || !pause_filter_thresh)
 		kvm_disable_exits(kvm, KVM_X86_DISABLE_EXITS_PAUSE);
 
-	if (enable_apicv) {
-		int ret = avic_vm_init(kvm);
-		if (ret)
-			return ret;
-	}
-
 	svm_srso_vm_init();
 	return 0;
 }
--
