Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A84F3009D4
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854857; cv=none; b=CtQGBu79F0dHg3TDk64MYr98WVWQFO91iFcXT2810PVzbhg6JsrGJpe/wUdKVi+iEqNUk42miUr8qcKXumc/W/4DEQNJSR/B4GfyXB6o7FJn2cXxrzjzArQYXAbF0WlDDqRmPs8hWV3L/vXtH3Ud72NsysExtWaZK8h42fqN67g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854857; c=relaxed/simple;
	bh=vLjNoL+SKTKzAFgZ/zHzNmMEtP1L0SW73bb+C8wvkj8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UWO2QIuEDe+HW5QGV9Bienftfk7OT78AlPtYwF4Y7yXmHXucsaQwFCaTdMUbG8NigmsRUDyWO+BoS04vqcsu4rggFlmI8F5fYF25dO0qX6ugY0N0TT4RbdvEKGeeH2B5lnIwpyq4sMRxRHpBj2/UbxjykIJTLVUXqvJCs0a5bQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DK6RnmEJ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DK6RnmEJ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c6bbd0afffso94255ad.0
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 14:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782854854; x=1783459654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rVDe7KS7mIi3eI2da6sI/3OeXJKsaxKL11W5ZtPqYz0=;
        b=DK6RnmEJmmBVt8JR8MYRRb9AA6isdygFLH6rGmoxOLrKV6AhIJ37jVCkfDrDbARXg9
         ldjLZSI1HVc56a2hsMEbIa00SE4waGUTi+B1STPN+lvO2OGjNYtwXSUOIk7rNNOqXOuE
         WO5Rm/NrwMpb4lJJvNZWxBFD/4BsVVW6+QLO5C66lCvbDo62tW2cAuQCFlNXv+zQM2PY
         zNlYiYpUZ6xcMPfPEbpWMVU14wO7n4w4giP1jZT35jmHmjKrurpnAe5J0wFAOZfZ4ld6
         ViERWHLZAEfgrW+XW0CP5bEIVkVxq7B3JvR1dItiaHiQ98ECdYece0nKkZ6HsHlcQxuV
         uHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854854; x=1783459654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rVDe7KS7mIi3eI2da6sI/3OeXJKsaxKL11W5ZtPqYz0=;
        b=d+HI0C0HgQhBQSJ+D1izN1wUyLDm6ArAne7lLMPQmZWPaIQH66BTyPVr4bfpIzlweE
         T0QAJTkisMui4y8bRuRwvY9JuzhYoJkI2I6cRl3imrZLEruWrIvdt9s2AUcdQFU/aquE
         t8YVirRXF3k9WsPFN0PFoD98Fbx1qK3u7eZ5G4AC8vRjusizTMaMAD/zIjChskfKK2MW
         DPfoWrPMKrWV/xdGMNwoDuiurTXh0aJu8UJkl8fJ8YgJoCe+dF/zgOlMdJxTGXJgRok4
         pj1YsgXD+tQT/m463u5SwHvvN+VKiEqMux9mJN0m5s1btqL1OnYVwT3LTuT41q0ojIa7
         L5Og==
X-Gm-Message-State: AOJu0YzDSgsz5GO3tzdZaO1lTEQ+nh78Psf/lPtdKD09rZXPmFT+Jzfx
	1j9D9Gn48JKVZrtaDkvHnWvgkiv02fPg+qx5KPCrlhP8ggMyLfY+FL5E+zRyQUijP5B4beKTfXN
	2bvhImQ==
X-Received: from plbkw14.prod.google.com ([2002:a17:902:f90e:b0:2c7:37d5:c0cc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e546:b0:2c9:d298:6c06
 with SMTP id d9443c01a7336-2ca2e714345mr42643205ad.25.1782854854363; Tue, 30
 Jun 2026 14:27:34 -0700 (PDT)
Date: Tue, 30 Jun 2026 14:27:33 -0700
In-Reply-To: <20260630211556.05EA91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630210156.457151-1-seanjc@google.com> <20260630210156.457151-4-seanjc@google.com>
 <20260630211556.05EA91F000E9@smtp.kernel.org>
Message-ID: <akQ0xSvDXSVoLC6e@google.com>
Subject: Re: [PATCH v2 3/3] KVM: SVM: Remove VM from the GA Log notifier list
 before VM destruction
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 30, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> > index d71a2fed1a08b..c5b1d294b15a2 100644
> > --- a/arch/x86/kvm/svm/avic.c
> > +++ b/arch/x86/kvm/svm/avic.c
> > @@ -374,9 +374,20 @@ int avic_vcpu_precreate(struct kvm *kvm)
> >  	return 0;
> >  }
> >  
> > +void avic_vm_pre_destroy(struct kvm *kvm)
> > +{
> > +	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
> > +
> > +	if (WARN_ON_ONCE(!enable_apicv) || !kvm_svm->avic_vm_id)
> > +		return;
> > +
> > +	guard(spinlock_irqsave)(&svm_vm_data_hash_lock);
> > +
> > +	hash_del(&kvm_svm->hnode);
> > +}
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but could there still be a
> Time-Of-Check to Time-Of-Use race in avic_ga_log_notifier()?
> 
> If a notification arrives and avic_ga_log_notifier() finds the VM and its
> vCPU pointer under svm_vm_data_hash_lock, it drops the lock before calling
> kvm_vcpu_wake_up():
> 
> arch/x86/kvm/svm/avic.c:avic_ga_log_notifier() {
>     ...
>     spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
> 
>     if (vcpu)
>         kvm_vcpu_wake_up(vcpu);
> }
> 
> If avic_ga_log_notifier() is preempted right after releasing the lock,
> couldn't avic_vm_pre_destroy() still run concurrently, remove the VM from
> the hash table here, and allow the remaining teardown process to free the
> vCPUs?
> 
> Would this result in avic_ga_log_notifier() calling kvm_vcpu_wake_up()
> on a freed vCPU pointer once it resumes execution?

Ugh, yes, that's theoretically possible.  I *think* we can simply move the call
to kvm_vcpu_wake_up() inside the spinlock.  There is a potential deadlock that's
near this code[*], but I don't think svm_vm_data_hash_lock will have the same
problem as ir_list_lock?  Regardless, I'll tackle this one in a separate patch,
unless it looks like we'll have to completely redo the entire scheme.

[*] https://lore.kernel.org/all/aUmdSb3d7Z5REMLk@google.com
