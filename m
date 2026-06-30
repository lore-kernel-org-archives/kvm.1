Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DA91FC110
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854157; cv=none; b=MQ71jDsizoxd9u3cdGHMM/4zzuTAR4ywhtYl4qRJvybzDjE2C5eLBQoC93qa1mw6Rec21qVIimrzyvsct+irHb7NnqeX2zTqBc7rUSeXLo/JgMwY1/WKNmS/n7ductWfTjoFsN9r0L+288HCNi3qFBJ7jGFjPcOTPvDKtOCYvRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854157; c=relaxed/simple;
	bh=3yfa6h/58dr38iBwWQ9ocbM6LFLCcLNpQz8iorUj8Cw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W2d8t4EPSNQ8N5hWNz2EEHQDbRAAWGl+NiEk9yPgj+V1Ahpd6KDIOFoG5zS0usQbmgoxSlHwHhH1j0uELBO7WtaGFHrhu2/wFUbgwLRJok3jpWq0kBrNMDNeHaFRBkCaengaYmgbKa/W7iN3/95G5nNuynsm6C4L8PIHj47TecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dm6/ZsoE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dm6/ZsoE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EA91F000E9;
	Tue, 30 Jun 2026 21:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782854156;
	bh=XvwsfREd8PP7GDvKru9R9fKd8LTjQ/0vI7+ChphAsS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dm6/ZsoEkTTyUNnNOZiryHEO9Opg5o8rW6+0UH4z9Et5DvWljurs3rWUU++nhyHhk
	 W2NX6dmyB9lvcHHfqncTIPvXHolhHNG5nyjlyY/yuIWPAdqhUHyZ5fvETmcAlvo9KF
	 aiGH2dvY6g5+/d+TZZDgxuT4sb/fEWF8IivcxPgK6d4VAU5yiNrcc4Cnb/YDJyILrV
	 q0ih35iRae5UcXZpJuwSUJWfHfEg5V8NQzPb1MOPaGPunu9QCWbX2flbXg78Jagz8b
	 W9I4GabIFw+co0S75iW3zAEZX1/S9w7olQ200b8y6W2TUXNLjvWoC5Im4oWdyivQcK
	 G1R22iLlpF1vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] KVM: SVM: Remove VM from the GA Log notifier
 list before VM destruction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260630210156.457151-4-seanjc@google.com>
References: <20260630210156.457151-1-seanjc@google.com>
 <20260630210156.457151-4-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 21:15:55 +0000
Message-Id: <20260630211556.05EA91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fails to fully resolve the Use-After-Free race in `avic_=
ga_log_notifier()`. It leaves a Time-Of-Check to Time-Of-Use (TOCTOU) vulne=
rability where an already-found vCPU pointer can be dereferenced after it i=
s freed.
--

commit a94e2dbde8bab766023c731fa2628928c6d8e750
Author: Sean Christopherson <seanjc@google.com>

KVM: SVM: Remove VM from the GA Log notifier list before VM destruction

This patch changes when a VM is deleted from the GA Log interrupt list. It
now removes the VM during avic_vm_pre_destroy() instead of waiting for
avic_vm_destroy(). This attempts to prevent a use-after-free if a GA Log
notification arrives for a vCPU after the last reference to the VM is put.

> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index d71a2fed1a08b..c5b1d294b15a2 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -374,9 +374,20 @@ int avic_vcpu_precreate(struct kvm *kvm)
>  	return 0;
>  }
> =20
> +void avic_vm_pre_destroy(struct kvm *kvm)
> +{
> +	struct kvm_svm *kvm_svm =3D to_kvm_svm(kvm);
> +
> +	if (WARN_ON_ONCE(!enable_apicv) || !kvm_svm->avic_vm_id)
> +		return;
> +
> +	guard(spinlock_irqsave)(&svm_vm_data_hash_lock);
> +
> +	hash_del(&kvm_svm->hnode);
> +}

[Severity: High]
This isn't a bug introduced by this patch, but could there still be a
Time-Of-Check to Time-Of-Use race in avic_ga_log_notifier()?

If a notification arrives and avic_ga_log_notifier() finds the VM and its
vCPU pointer under svm_vm_data_hash_lock, it drops the lock before calling
kvm_vcpu_wake_up():

arch/x86/kvm/svm/avic.c:avic_ga_log_notifier() {
    ...
    spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);

    if (vcpu)
        kvm_vcpu_wake_up(vcpu);
}

If avic_ga_log_notifier() is preempted right after releasing the lock,
couldn't avic_vm_pre_destroy() still run concurrently, remove the VM from
the hash table here, and allow the remaining teardown process to free the
vCPUs?

Would this result in avic_ga_log_notifier() calling kvm_vcpu_wake_up()
on a freed vCPU pointer once it resumes execution?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630210156.4571=
51-1-seanjc@google.com?part=3D3
