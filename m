Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B409332A3FE
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785565102; cv=none; b=p9lWYc9z6/0s5cxlt9mNHJsRUDgeBXbhlNDJZ274gJ7puLQDDERqqsFN3J6TN27oby/moG6tBwWFkJWT+GSzQl2iNvHOummXd+TTaZiCsB0vT3rRq+Bi4oRSAGz6jegiU4ASUbTbPFPlU0ADSalAAmxbcMO0cdUnfvYmzQdSTVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785565102; c=relaxed/simple;
	bh=/6HW1rhZAjDQer03p3C1r3L8UbFHODIByMHuRroYCKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHt5erVXOfpyFl2MDcGYth7SIw8+3SLH6W5K4bwZxLlgfyPiBHcgiG/DGBNb10pzPSeYSAbI4Sz4vnWd5TzsQmZG3voeOFr9sZHYkJ0MHcknKRRGkyzLhrsmgEx18ZkTpSQeYg+53jfeOJW1eNGDaQtq6UPZj/mikL2/3TxZmTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Neszm1sN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Neszm1sN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4753C1F01559
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 06:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785565101;
	bh=BVh2Pm7xKf2S9E//HUwvAyP+DTGaVi7Ku0xFe9rp4WU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Neszm1sNR6mTE9hvDMGFrIIxeKCrAK8GLiUHmvoARKDqirrqR0fLAL9lN9VpMS8Wx
	 0y4AFX1ZfUFeC29m+wXbOfR8vuGbKz+Axu72uTlmeBrOwN56c5yGu2f/EQjaoaU+c2
	 gN+3xkqqEgH1spdK75ZsVFn1y+kQMFuY6MpVjtRSIEXaL1KEzGcKEY/FObUUcL3U94
	 o0e+fH4l64b92wDAZdbusnsofH8i5RlxdBEAPTLKbMGvlBQBt///FmvL2zhhaa7qp+
	 RC5ZhaABGb8c5UuQDyEZw6vCCckgSJRh7CwFDcAjhgsXy0P2++UmAT9jkGP/iYm3IZ
	 3VpwOFXyikgJg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a051904222so2621696a12.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 23:18:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr/3W58IjdxLYLYtNtiB6+ES2o1Ftg5gwncv1jxtPfh/sFqtNBqVVY/+i6Xpw4ADRarAm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI5iBO4Nw1x2qRXYngghAFNqa0AOWnFj02sNzq8WzUrRKQWMso
	CfGZJURf+L/e6ap60pRdbsOsWgeDPok6+JnyovTbCe3n7aSRihE62cJCcZtSHhGe1LSblzJ8zvi
	qP6fHrHWySwE1CLCHRYdAPmexVH44w2I=
X-Received: by 2002:a17:907:9613:b0:c16:126b:98b4 with SMTP id
 a640c23a62f3a-c1fe7ecb6c8mr169589566b.3.1785565100156; Fri, 31 Jul 2026
 23:18:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728003557.1136583-1-yosry@kernel.org> <20260728003557.1136583-11-yosry@kernel.org>
In-Reply-To: <20260728003557.1136583-11-yosry@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 31 Jul 2026 23:18:08 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPiH5hRUVVspiuBdE-91Q17zz8gq=DG=XWji=FbRGQz9A@mail.gmail.com>
X-Gm-Features: AUfX_mysOfKev_sIg2iyA5T55FN9AJE9t-gt7cJarSheyNMXh_xrcMfSW5-v6Fg
Message-ID: <CAO9r8zPiH5hRUVVspiuBdE-91Q17zz8gq=DG=XWji=FbRGQz9A@mail.gmail.com>
Subject: Re: [PATCH v1 10/28] KVM: SVM: Use a static ASID per vCPU
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 3aac702f45b2b..087d18a5eda69 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2071,6 +2071,7 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
>         kvm_for_each_vcpu(i, dst_vcpu, dst_kvm) {
>                 dst_svm = to_svm(dst_vcpu);
>
> +               dst_svm->asid = dst->asid;

From internal Sashiko:
---
Does this overwrite the destination vCPU's initial ASID without freeing it?

During vCPU creation for the destination VM, before it is marked as an SEV
guest, svm_vcpu_create() allocates a normal TLB tag. When this migration
overwrites dst_svm->asid with the source SEV ASID, the original tag appears
to be leaked.

When the destination VM is eventually destroyed, is_sev_guest(vcpu) will
evaluate to true, preventing the leaked tag from being recovered in
free_asid(). Could this be abused to exhaust the global non-SEV TLB tag pool?
---

Yeah I think this is correct. Looking at the SEV migration selftest,
it seems like the destination VM is not initialized as an SEV VM. We
should probably free the non-SEV ASID before copying the ASID here?


>                 sev_init_vmcb(dst_svm, false);
>
>                 if (!dst->es_active)
> @@ -4816,7 +4817,7 @@ void sev_init_vmcb(struct vcpu_svm *svm, bool init_event)
>         svm->vmcb->control.misc_ctl |= SVM_MISC_ENABLE_SEV;
>         clr_exception_intercept(svm, UD_VECTOR);
>
> -       svm->asid = sev_get_asid(vcpu->kvm);
> +       WARN_ON_ONCE(svm->asid != sev_get_asid(vcpu->kvm));
>         svm->vmcb->control.asid = svm->asid;
>         vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
