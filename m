Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D954B2E736F
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814182; cv=none; b=giPv4ndAIUQg71ec6GOfgKd7ek00/CIUm89etVo4IHWGYcRwH/oVAqvmKNI1zpgjd2VaA+Sak3tQV1F0HvyyJrHbZil+F7aL3TXCDGXcrfLvfc98NDT7mLUk7jTuJNck3BqiOyQLUk+Su5bHOPgYkaoz+4Ls1qiCL1Is0PbBgGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814182; c=relaxed/simple;
	bh=Q2+0VebrWVzm4E6FXllG2qyjxu+bsnq2xi5YnpULivk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvvf2WgM7OOp3137NwVaFjFb2i9zvg+SThOBaEyZ5+Y16Z2agd9Iid0gG9OdNZdDGrMQokt0Tf4r/jDlACbIwbpHe6pFXF+vNMwTRKNN4i8Zu2/+dh+wI1eygYJqn3N+dH3T5p92EbNAGWZvFHvCyuHCkeqqRzyuDzkGdKth99I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXeZbVem; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXeZbVem"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12B31F00A3F
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 07:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787814180;
	bh=lweN44y+/bDHEaKN5dkWQvmebYWLy0CuIXhDMnxMHM4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aXeZbVemkCqjDFcjeQYwY2jXO415RNQ1xdUDqxLmgjZenWBny0FCV6JoERgbUNDn+
	 Q8OHJe0xy9VA1xJaYYKKtJ2Mia9FmMVrlCrG6gmgM7lq50Jw62QYWlBTda63tLrqX8
	 SQxIacNazhKhmTA0Dn8BIw0JcZx9Y73KM2m6yqVkFuQkMQicmHCXEyO2E8W9BFfHsn
	 3QUn8hSwqsB/MdrXfSsGZpnRiy06KI8ILW5FzdPKRGzx/D7K3kQ4bdCUC80nMmlZ4T
	 gbdmtUywspz0IX6gSb0w5Heo92KnNHS8CNJRvW3HdphZMPBguRJxIJ4iYQiDmLiEgU
	 8OhXSlz41xdDQ==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a156627e22so1232979a12.1
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 00:03:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoBQ0SEl8sAsR9z7B6FX3KVWBpeGPu/SMNXv6QfocGeipcoQLPuokWtKs/4/ce2tQW2cL0=@vger.kernel.org
X-Gm-Message-State: AFuF++mh0+dkAcC48EI+FyUs6OYQZEpYWdTkFcxhZg+0SsgkbkVtZU6z
	w4fAtrZu6u+P6p44K3j1W1rkmT/KdyrEZehxu49gLKNIJl7xgryYGFZdxi3iZXEm0K5Zp2dSgsX
	JSnPxGmheGKzQbeBbdPkVNISczGRXXHc=
X-Received: by 2002:a17:907:6d07:b0:c20:a243:9a52 with SMTP id
 a640c23a62f3a-c2535b7b987mr357134966b.0.1787814179676; Thu, 27 Aug 2026
 00:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826211844.884951-1-seanjc@google.com> <20260826211844.884951-2-seanjc@google.com>
In-Reply-To: <20260826211844.884951-2-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 27 Aug 2026 00:02:48 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMnPwXVf6wx_gDMzv4j47xWa7idLD+vVm9DUiB=huiLaw@mail.gmail.com>
X-Gm-Features: AcwNN1VHL4oaVBuU6s6s6aayVrPzo_EmXeGE2W5EkpN3aebm9K5XKhlcteVJdKA
Message-ID: <CAO9r8zMnPwXVf6wx_gDMzv4j47xWa7idLD+vVm9DUiB=huiLaw@mail.gmail.com>
Subject: Re: [PATCH 1/4] KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has
 EFER.LMA=1 && EFER.LME=0
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 2:18=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Reject KVM_SET_NESTED_STATE if the incoming L1 host state has what is
> effectively an impossible EFER combination of LMA=3D1 but LME=3D0, i.e. i=
f the
> state says long mode is active but not enabled.  Unlike VMX, SVM doesn't
> have an explicit consistent check for the illegal combination; presumably
> hardware simply ignores EFER.LMA if EFER.LME=3D0.
>
> Unfortunately, KVM doesn't ignore EFER.LMA in this case and consumes the
> illegal state when constructing the shadow MMU for L2.  E.g. if userspace
> also clears CR4.PAE, then kvm_calc_cpu_role() will compute a role with 4 =
or
> 5 levels of paging, but shadow_mmu_init_context() will wire up the MMU to
> use the paging32 template, which maxes out its levels at 2.

Isn't the "right" thing to do what hardware (presumably) does and
ignore EFER.LMA if EFER.LME=3D0?

>
> Note, the "real badness" is effectively the same as what happened with th=
e
> nVMX bug fixed by commit 112e66017bff ("KVM: nVMX: add missing consistenc=
y
> checks for CR0 and CR4").  Unfortunately, the sanity check added by commi=
t
> 72e2fb24a0b0 ("KVM: x86/mmu: Bug the VM if a vCPU ends up in long mode
> without PAE enabled") doesn't work for this case, since L2 state is activ=
e
> at the time of the page fault, but it's L1 that has the bad state.
>
> Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and KVM_S=
ET_NESTED_STATE")
> Cc: stable@vger.kernel.org
> Cc: Yosry Ahmed <yosry@kernel.org>
> Reported-by: Stefan Teodorescu <fane@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/nested.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 73f37b050d0a..49fb10ad1f9f 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -2028,6 +2028,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vc=
pu,
>         if (!(save->cr0 & X86_CR0_PG) ||
>             !(save->cr0 & X86_CR0_PE) ||
>             (save->rflags & X86_EFLAGS_VM) ||
> +           ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)) ||

I just realized I have no idea why we check X86_CR0_PE and
X86_EFLAGS_VM here. Commit 6906e06db9b04 ("KVM: nSVM: Add missing
checks for reserved bits to svm_set_nested_state()") says it's to do
the same checks as VMRUN, but I don't think that's actually the case?
The checks here seem arbitrary to me?

>             !nested_vmcb_check_save(vcpu, &save_cached, false))
>                 goto out_free;
>
> --
> 2.55.0.887.g758fc8c411-goog
>
