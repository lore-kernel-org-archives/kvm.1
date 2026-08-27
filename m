Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9C22E7F25
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787813125; cv=none; b=Kkck8Zk+Hjt/OfHnzErmt9bkuewcfP8J4vnBKAxk8Lm5quftMGJLVyLgI+czZbjCEh/D1V227+jzOVNN/i2gQBwgelm7D09UtOs0G87tM8Y4rjy/KQ8uLGSG2fdhFfDjSexqcpUsOFTPt4XIfz6rAXlMhW5HtVaBB0af2XZuv8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787813125; c=relaxed/simple;
	bh=XGmwQyzKjcY+aGCfdpW8qhopeg1xgE2lfJukbmXqPak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ys+65w8jNbYslUhkrYZxQQ06cYjUTn5IsudZhxwDVp1bv1TeU9bPrus666kdWLGgBO/tOll4F2hsFqW7WFIg+mjZnVS3DbG+to8OcTrfkyrOol2lPnVURmygQmQy9t/P0iww8IrZC0E3HpOnJvD+dy8tqY5jEGqNWEELcCaOhsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVm+zrWG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVm+zrWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B71D1F00A3F
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 06:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787813124;
	bh=w64hbmqoxi4eIucqvvm2p+HldRcaMlL5Ju3HRIh5vUw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BVm+zrWG4iGcwssAFQ5/m+kc5RSc/Ma4eX1sfjNTKvnzyElMW1z/oufxlueJS6uRJ
	 OFQDFkVQ35nyez9D9kflNYd04YfXEDZYW+EM0OlBFXNxnFAmWxuBtslqlxyRGPbxE8
	 C3tFdjy0+cPuj9pJtiPG8lMDaJKg1Qz0xjhQ5XVGTJrwgJmI6h6MN7dYKE21KHFwHl
	 zSEV6+at05XFh3nPTVMDOzyxvb8T0bXKdfNfkr0NDGthTI0hxPDdcpE06ZrIASli5i
	 FGginXUvwrshsRRI41XWoBoAsCRdGR3WTHgd1pSTZiHeaY3GnMg+6epVC7jC4+xKHG
	 KmY87hxOR+SDg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c207cb16cf5so53782766b.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:45:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqeDhVRFKtSoQi18G3vSw2hi7gZxsP6kmRe4kYkK9r45H/vbrT70Qf45GTt80q256dm6HA=@vger.kernel.org
X-Gm-Message-State: AFuF++nLa41iK6ZYHzjdLsyXd4ZQYITf/Kic4x4Xn8s45flwTcJ0pmzZ
	rsYOyi0eqcq8RAnW4EHUzS7d96qjCazjb8QBBdw8gTEQJDPTPJRyJMPAj9xYZFLp9qG8HNBBTcm
	cypuefVXBk2eEgbL+62A9l1X8PvtDYqE=
X-Received: by 2002:a17:907:3d0f:b0:c1f:983f:d8a with SMTP id
 a640c23a62f3a-c250c36b68emr1456130366b.24.1787813123043; Wed, 26 Aug 2026
 23:45:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826233919.998904-1-seanjc@google.com> <20260826233919.998904-13-seanjc@google.com>
In-Reply-To: <20260826233919.998904-13-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 26 Aug 2026 23:45:10 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOuD+wU1Q80z077WHHpFBWvKomLk=TaXjH3gVnqj=mqFQ@mail.gmail.com>
X-Gm-Features: AcwNN1W1K1wcOYFKECCJsH8NB9-j09zWsmaQJT_ycB-dgEdLE37gZ0gCYqumGYo
Message-ID: <CAO9r8zOuD+wU1Q80z077WHHpFBWvKomLk=TaXjH3gVnqj=mqFQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] KVM: selftests: Dedup assembly code for VMLAUNCH
 and VMRESUME
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	f734222792@gmail.com, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 4:39=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Dedup the assembly code from VMLAUNCH vs. VMRESUME, the difference is
> literally only the actual VM-Enter instruction.

You couldn't resist macrofiying this too.

>
> No functional change intended.
>
> Cc: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/include/x86/vmx.h | 74 +++++++------------
>  1 file changed, 26 insertions(+), 48 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testin=
g/selftests/kvm/include/x86/vmx.h
> index 3def8df902a2..fa01341e22bc 100644
> --- a/tools/testing/selftests/kvm/include/x86/vmx.h
> +++ b/tools/testing/selftests/kvm/include/x86/vmx.h
> @@ -359,55 +359,33 @@ static inline u64 vmptrst(void)
>         return value;
>  }
>
> -static inline int vmlaunch(void)
> -{
> -       int ret;
> -
> -       if (enable_evmcs)
> -               return evmcs_vmlaunch();
> -
> -       __asm__ __volatile__("push $0;"
> -                            "vmwrite %%rsp, %[host_rsp];"
> -                            "lea 1f(%%rip), %%rax;"
> -                            "vmwrite %%rax, %[host_rip];"
> -                            VMX_SWITCH_GPRS_ASM
> -                            "vmlaunch;"
> -                            "incq (%%rsp);"
> -                            "1: ;"
> -                            VMX_SWITCH_GPRS_ASM
> -                            "pop %%rax;"
> -                            : [ret]"=3D&a"(ret)
> -                            : [host_rsp]"r"((u64)HOST_RSP),
> -                              [host_rip]"r"((u64)HOST_RIP),
> -                              GUEST_REGS_OFFSETS
> -                            : "memory", "cc");
> -       return ret;
> -}
> -
> -static inline int vmresume(void)
> -{
> -       int ret;
> -
> -       if (enable_evmcs)
> -               return evmcs_vmresume();
> -
> -       __asm__ __volatile__("push $0;"
> -                            "vmwrite %%rsp, %[host_rsp];"
> -                            "lea 1f(%%rip), %%rax;"
> -                            "vmwrite %%rax, %[host_rip];"
> -                            VMX_SWITCH_GPRS_ASM
> -                            "vmresume;"
> -                            "incq (%%rsp);"
> -                            "1: ;"
> -                            VMX_SWITCH_GPRS_ASM
> -                            "pop %%rax;"
> -                            : [ret]"=3D&a"(ret)
> -                            : [host_rsp]"r"((u64)HOST_RSP),
> -                              [host_rip]"r"((u64)HOST_RIP),
> -                              GUEST_REGS_OFFSETS
> -                            : "memory", "cc");
> -       return ret;
> +#define BUILD_VMX_VM_ENTRY_HELPERS(insn)                               \

s/HELPERS/HELPER?

or maybe better: DEFINE_VMX_VM_ENTRY_HELPER()?

With the rename:

Reviewed-by: Yosry Ahmed <yosry@kernel.org>

(Who's f734222792@gmail.com?)

> +static inline int insn(void)                                           \
> +{                                                                      \
> +       int ret;                                                        \
> +                                                                       \
> +       if (enable_evmcs)                                               \
> +               return evmcs_##insn();                                  \
> +                                                                       \
> +       __asm__ __volatile__("push $0;"                                 \
> +                            "vmwrite %%rsp, %[host_rsp];"              \
> +                            "lea 1f(%%rip), %%rax;"                    \
> +                            "vmwrite %%rax, %[host_rip];"              \
> +                            VMX_SWITCH_GPRS_ASM                        \
> +                            __stringify(insn)";"                       \
> +                            "incq (%%rsp);"                            \
> +                            "1: ;"                                     \
> +                            VMX_SWITCH_GPRS_ASM                        \
> +                            "pop %%rax;"                               \
> +                            : [ret]"=3D&a"(ret)                         =
 \
> +                            : [host_rsp]"r"((u64)HOST_RSP),            \
> +                              [host_rip]"r"((u64)HOST_RIP),            \
> +                              GUEST_REGS_OFFSETS                       \
> +                            : "memory", "cc");                         \
> +       return ret;                                                     \
>  }
> +BUILD_VMX_VM_ENTRY_HELPERS(vmlaunch)
> +BUILD_VMX_VM_ENTRY_HELPERS(vmresume)
>
>  static inline void vmcall(void)
>  {
> --
> 2.55.0.887.g758fc8c411-goog
>
