Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FF43F54DD
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773330634; cv=none; b=D+60cbZN1fGX/pUJ+iok+/BbDXp6eaDr74NWBFdXewWoUlg/1xvyNGkUN4ebepyHjnmQLZQ/GtDL614Taw/yNnUM2yFTfmzMNdkHzTZONViBYQEkzRNxcpsdJcaFzBhwxJ6aHY+mtMHDEigpxi3m33h57VMxPgVoX7KQvGnfaKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773330634; c=relaxed/simple;
	bh=7dyKY4bT6MOUmMrHAyuUAssa1/e1k8e695kv0vYv1Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2ahIVlbbpVJ1ZF09U3aHHyzTyI/wL6CHDW6RLNLa9+fm8xA/UC/jYrp0R4lRGO/ZO2ybYaalljO75iBv1wMCBX8fPVOGHie+jYa+hSu5i69LMQviX6xPBxB12+R6Td/3mbE6l8Jwih5Mto1FUGb4RXayDiEw3h5TiypPXT4dTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mz8szP1e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mz8szP1e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9794BC2BC87
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 15:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773330633;
	bh=7dyKY4bT6MOUmMrHAyuUAssa1/e1k8e695kv0vYv1Y8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Mz8szP1egF2Fuc9ZwasAFy3WtLRlP6Y6O1bMJInq/FzBaG9nb/Zye1igB3EX0vgkP
	 xlkBaKr0jiJWPRN6nc4tAqGBnlARXrxabFBEdn4GgeZhR0FyNOHBs78UyHCBKZ1C6F
	 3uUuZITz/F0l6ovYist92Gt5Nc85Ql4NYS4mSFwU0vyndRUYO9cAFFfQpoNxqffaSm
	 YKjngfz7johQJkbJqDSErHEvQXbl4Mn3tt9BgQcIAiV5TSVtyOVT3tqKRJxQMGesBs
	 BmWILud0bGYMIwiu7c4cDofhevf/DuD0pPynKMm3wv27GiC5aCiKEHVNm4cpM3ZaF7
	 CsPTNmbptG4Jg==
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899a5db525cso15320196d6.3
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 08:50:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKjqQcBfzFttbb3f7Mbdcw9BZgfH+zOMplzp5s+gRLCgoJDw2NzcblXWy9BtWwdg8hzGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz8VQWxEOXk/QqJXZTLdIrFen371kHkwvBlEX5OgvcfJo/YPql
	z0KAN7viZlnC6aK4UunBSMVbXOVVlDmE/kN/xTjqztF+8fjXZPNt0qO1fZRCZtF9eTFvPXg4O0A
	jO4CCkTfnTzz4tP9Jgqxh7Ks21b173/M=
X-Received: by 2002:a05:6214:400f:b0:895:1b71:1276 with SMTP id
 6a1803df08f44-89a81fe35f3mr2578796d6.67.1773330632882; Thu, 12 Mar 2026
 08:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306210900.1933788-2-yosry@kernel.org> <CALMp9eRWwPwUSyQmizy8i2tF1CVO4iLY6x0vX1OoPUiRdCm4NQ@mail.gmail.com>
 <CAO9r8zOhaDeYWq_6TNdPGyEE323o_8xsWTozGdro9Oni8310kA@mail.gmail.com>
 <CALMp9eScswzFak+PMOcaDXM-W+cXtkG7fQ=jadq__+5JeqYcTQ@mail.gmail.com>
 <CAO9r8zOK5+xmkf3FsWRz2wHcUCN30GJ9kfZx-K7DAa1HNGhRVA@mail.gmail.com>
 <aatyIPwz9ePKdzJx@google.com> <CAO9r8zMxk9yUiYoosnDygr_oeeRYHz3f7hWLm23c5Q0m-DXnWA@mail.gmail.com>
 <CAO9r8zNHYswypRmHVT5Qn5hFU9-HU1t=Gs3qAh05xRNn5krPXQ@mail.gmail.com>
 <abHTE5uyEZ4cW-fc@google.com> <CAO9r8zNxtSbHjp6EkQ+QbKavL1hn1WQXgQQ+d2=6AZkW9-mVXA@mail.gmail.com>
 <abH0RdnM29Xyh_4G@google.com>
In-Reply-To: <abH0RdnM29Xyh_4G@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 12 Mar 2026 08:50:19 -0700
X-Gmail-Original-Message-ID: <CAO9r8zO_Mo-98MqREwHq4JN0bA11H2EpmNmUkAU5QvNm9OGNbg@mail.gmail.com>
X-Gm-Features: AaiRm51OAwjTOsmRB6DZXNhXbEU6BK9QFJpJ5apXSHrovI23rhsqlkvOXH59zq8
Message-ID: <CAO9r8zO_Mo-98MqREwHq4JN0bA11H2EpmNmUkAU5QvNm9OGNbg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] KVM: SVM: Use maxphyaddr in emulator RAX check for VMRUN/VMLOAD/VMSAVE
To: Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index c8e292e9a24d..74df977a38ca 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -3867,18 +3867,10 @@ static int check_svme(struct x86_emulate_ctxt *ctxt)
>         if (!(efer & EFER_SVME))
>                 return emulate_ud(ctxt);
>
> -       return X86EMUL_CONTINUE;
> -}
> -
> -static int check_svme_pa(struct x86_emulate_ctxt *ctxt)
> -{
> -       u64 rax = reg_read(ctxt, VCPU_REGS_RAX);
> -
> -       /* Valid physical address? */
> -       if (rax & 0xffff000000000000ULL)
> +       if (ctxt->ops->cpl(ctxt))
>                 return emulate_gp(ctxt, 0);
>
> -       return check_svme(ctxt);
> +       return X86EMUL_CONTINUE;
>  }
>
>  static int check_rdtsc(struct x86_emulate_ctxt *ctxt)
> @@ -3984,10 +3976,10 @@ static const struct opcode group7_rm2[] = {
>  };
>
>  static const struct opcode group7_rm3[] = {
> -       DIP(SrcNone | Prot | Priv,              vmrun,          check_svme_pa),
> +       DIP(SrcNone | Prot | Priv,              vmrun,          check_svme),
>         II(SrcNone  | Prot | EmulateOnUD,       em_hypercall,   vmmcall),
> -       DIP(SrcNone | Prot | Priv,              vmload,         check_svme_pa),
> -       DIP(SrcNone | Prot | Priv,              vmsave,         check_svme_pa),
> +       DIP(SrcNone | Prot | Priv,              vmload,         check_svme),
> +       DIP(SrcNone | Prot | Priv,              vmsave,         check_svme),
>         DIP(SrcNone | Prot | Priv,              stgi,           check_svme),
>         DIP(SrcNone | Prot | Priv,              clgi,           check_svme),
>         DIP(SrcNone | Prot | Priv,              skinit,         check_svme),
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e6691c044913..e1223c07593b 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2294,7 +2294,7 @@ static int gp_interception(struct kvm_vcpu *vcpu)
>                                 EMULTYPE_VMWARE_GP | EMULTYPE_NO_DECODE);
>         } else {
>                 /* All SVM instructions expect page aligned RAX */
> -               if (svm->vmcb->save.rax & ~PAGE_MASK)
> +               if (!page_address_valid(vcpu, svm->vmcb->save.rax))
>                         goto reinject;

Final observation (hopefully), this check needs to be moved to the
VMRUN/VMLOAD/VMSAVE interception functions. As kvm_vcpu_map() failures
will stop injecting #GP, we still need to handle the case where
allow_smaller_maxphyaddr is used and the GPA is illegal from the
vCPU's perspective but not the host. In this case, the CPU does not
inject a #GP and the instructions are intercepted, so we need to make
sure the interception functions do the legality check on RAX.

I am doing this in a separate patch after fixing the check, and
opportunistically cleaning up gp_interception() by doing an early
return for the non-SVM insn case to reduce indentation. Will send v3
out after I am done testing.
