Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7364379996
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785566198; cv=none; b=g/TEkxbBifsqsosDlVhoUsy3Cr/TZYNhbwLLbnkN0NUA3JKdl8dKaBhUsqBc3jvBisA9ylY2gK7UpwgbJw3hW0gR3csPlUbP2WE6/4cVOsa40Wf1zvRd8PJGiO8fPO2rxbSOrJp7tZyewDi1F+wBTth9Dc/dLjroFxeXZDnOnic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785566198; c=relaxed/simple;
	bh=Ousd6CYC1YU8z9pjyH/qBZFeU/54JXTdrMbuXmqFfUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EeJavC6Su7Ass6SMk+2B8o9HNDdHYq7CJeWq+3PJfWUinqv0B+q/wxEIQAeKWUDD/mvbon2FBpNslNuyI4o1/H+uLmaU/EKDayypFtQA8daD5ILz2CA2/w6mEmDO22cSLPKMHpXvpDrU5WuzsF0GNBcJfnMgqn2gQAgDlEc7gTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8gy028H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8gy028H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C611F00ACF
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 06:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785566197;
	bh=j3Kysazr4yCNbR4B/VBHf/2W7V9Ytp+PM2SXBjHYjDE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Y8gy028Hly5PACuF0/UwKcWk5GFxLBfaOrKHlnnxzIQvlMOGCBMt2aKvPGDsj0P52
	 bqVsG88fywR5KdvyhgoRyihiV9c2m1VWf5kLHh9j14nypmlCzbysPv6QsSvvJg0zvm
	 XUL+aoz3lr5uTqY0k1WRQNJ70QCxM6f73nhZbZ407Ca7Yi83BZOURv+HsPIEC1vCsX
	 jZQaxTo2JBYPaoTP9AUdYfqsfjya1rg6fHyZsltR8ZNYCufGQ8/f07XfZQqSy9L2+Y
	 +dGL94xpOfoY2mYZFWfiBSppUaxbcGoADCqzbIiiK52HHVkYELlk9XdwOmg2fKvGaw
	 kIfpceQtb3GvQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15e03c2763so316205766b.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 23:36:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqu/O3iy5wCaa7Qqzrhe6eGSjFrku3UdvV9okXRfZ7L6GJsCZmjjJ2TNqfXtKgqgpzJ78I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHZEIbiRxwvbc5xZdvbN/RBBsB6YPnsc7tEZgMItKUnRRhrWcX
	xntTgJ5V1RgAvvfl4betwg+TfIRRNoj40YacWRJUb2f/8nF1DuVkFLXP5qF8mssIIpltF9VpL5s
	HpBNJrzflmv6Yo4AUOTDA1sBiSkpZ5HM=
X-Received: by 2002:a17:907:ea87:b0:c1c:6d29:8a11 with SMTP id
 a640c23a62f3a-c1fe79e2d56mr141576566b.13.1785566196337; Fri, 31 Jul 2026
 23:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728003557.1136583-1-yosry@kernel.org> <20260728003557.1136583-27-yosry@kernel.org>
In-Reply-To: <20260728003557.1136583-27-yosry@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 31 Jul 2026 23:36:24 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNJj2E=ahPBfHfwVH1XYL1wpgVCSXeTpQMx6XNTOzR-oA@mail.gmail.com>
X-Gm-Features: AUfX_mxOqRY9yhLd7g1O42DAy-KnxrD4xiG9q0df5DOIrFP5ASwS4znYf57mKsw
Message-ID: <CAO9r8zNJj2E=ahPBfHfwVH1XYL1wpgVCSXeTpQMx6XNTOzR-oA@mail.gmail.com>
Subject: Re: [PATCH v1 26/28] KVM: nSVM: Flush the ASID on nested transitions
 if shared by L1 and L2
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 58e7d099c559e..9ea8f21be9940 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -719,6 +719,15 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
>                 kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
>         }
>
> +       /*
> +        * If L1 and L2 share the same ASID in hardware (when using the fallback
> +        * ASID for both, or for SEV guests), flush it on nested transitions.
> +        */
> +       if (svm->asid == svm->nested.asid02) {
> +               WARN_ON_ONCE(svm->asid != fallback_asid && !is_sev_guest(vcpu));

From internal Sashiko:
---
Will this WARN_ON_ONCE fire deterministically on the first nested VM-Enter
for normal nested SVM guests?

Because L1 and L2 ASIDs are not properly separated until a later commit in
this series (commit 0fcd2c53996cc885d1e9898202bcd67438d2a97a, "KVM: nSVM:
Use different ASIDs for L1 and L2"), svm->asid and svm->nested.asid02 are
unconditionally equal at this point in the git history.

For a normal nested SVM guest, both svm->asid != fallback_asid and
!is_sev_guest(vcpu) will evaluate to true.

Could an untrusted L1 guest executing VMRUN trigger this warning, potentially
causing a host Denial of Service if panic_on_warn is set? Even though this is
resolved in a later commit, should the WARN_ON_ONCE be deferred until the
ASID separation is actually implemented so that bisectability is preserved and
intermediate commits remain fully self-contained?
---

I don't think a DoS is a risk here, but yeah the warning will fire at
this patch. It should probably be moved till the next patch or a
standalone patch.
