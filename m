Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061FD40912D
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819520; cv=none; b=X7fR0kI7UqbsW70urAEpB++XFBNYd4w/DlJcoWMpaaTtdv6Z3b/mkIaZ3lM3EzygWTZynoNOwwzlOXRahjYt72SSFQdARYtiGNZAX4P6E8HdNXxD1tLkyQb+JC6LNKjhoMJT0PEuqzlS1CrIFrB/0N6b3jrEN5gmwSxTnti4ADU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819520; c=relaxed/simple;
	bh=I2hL7Xv1YXGIOJ3Fng+SxOELQY+n5LLMlvwaeqB3/h0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsQTxpPKLqG44i6A5DAGaf00P/5KmFZh3XUm1EQIfggSmV+GJvUdNNL8VaisBOf7dTxqr8uLcGmPFkUyLH7UR0zImjrFsnvpVWTcAfceY+Rs96L+BgS9dPorbTPwODNaFt2sCuChb5zMVzQWhdClQSnELzTB+Ini7Xl6ZR4X7sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSOw3tT8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSOw3tT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA10F1F00A3A
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 18:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779819518;
	bh=l7unfT3FS0j6hC5nX8tDwm0WHt5djHPUk9DUK+pi40U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HSOw3tT81PM1qndY9yR8q8+nwWtH40ptnzD1wsOd8XwOh2RA0tYu5zTWC0TM303d0
	 +6KiEfscKaiJ36Q56uNxOCcA3fV6fCbhzi3HqXkoS9MM6vfoFn/Td5ZKsQ+4dPPIqQ
	 B0koh/cHGT8SipZ9SI8IbR4tiQxT6vlY19vYcDiAwJyJzfRp+fWkNMKoJueu/j49zD
	 QJ4YnedxUlKMDhUPu3FfRR1lkGzGdoHk8gg532CB0UWaF6Y9iNTgbdcZ3NVjuIREJ3
	 zRJKb1YG0bURzreLtxNJEziMC97X3cvWwowsafn8yqN4mhHHta4/HtIuz6sMHWkpNI
	 laEoCNJqjZZcg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bdbcc6c4500so892066766b.1
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 11:18:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/XRToDkXHFqmm1miR7hgmXCTZvjO8FO5CfACqCd4VN6LQ5MSCrs3jc3STjW8TdU5I3kSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRRpVkGCpQg08E9yQqhQ704JY6FlfK75L7u/D+1hGGwo5D18Xs
	7LxCsUk7wsoiMpiP+Htgrenpr+BT/xVC7b3UmwuxLdQWMGSgIui13JcZ53/ou/FsAIqz1FDxbX0
	iENDdMPfgtOdsGM49O3PmRhiUUhV3uWw=
X-Received: by 2002:a17:906:9918:b0:bdd:52ef:73e3 with SMTP id
 a640c23a62f3a-bdd52ef77c4mr913369466b.12.1779819517747; Tue, 26 May 2026
 11:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522232701.3671446-1-seanjc@google.com> <20260522232701.3671446-3-seanjc@google.com>
In-Reply-To: <20260522232701.3671446-3-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 26 May 2026 11:18:26 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMVVd6LgBRujJZs9mjWp6Fy4SFxbrGUBNBMsSRFw7krsg@mail.gmail.com>
X-Gm-Features: AVHnY4KhwTqvxc1jxAph-TkhOwR2KAilSS5-mjmUap9PZvx4TSJtUVGzAs3Fvoc
Message-ID: <CAO9r8zMVVd6LgBRujJZs9mjWp6Fy4SFxbrGUBNBMsSRFw7krsg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] KVM: x86: Tell ->inject_page_fault() whether or a
 fault came from hardware
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 4:27=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> When injecting a page fault (including nested TDP faults into L1), tell t=
he
> injection routine whether or not the fault originated in hardware, i.e. i=
f
> KVM is effectively forwarding a fault it intercept.  For nested TDP fault
> injection, KVM needs to grab PAGE_WALK vs. GUEST_FINAL information from t=
he
> VMCB/VMCS, _if_ the fault originated in hardware.
>
> No functional change intended (nothing uses the new param, yet...).
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 18 ++++++++++++++----
>  arch/x86/kvm/mmu/paging_tmpl.h  |  2 +-
>  arch/x86/kvm/svm/nested.c       |  3 ++-
>  arch/x86/kvm/vmx/nested.c       |  3 ++-
>  arch/x86/kvm/x86.c              | 16 +++++++++-------
>  5 files changed, 28 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 271bdd109a98..d11063c36f03 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -484,7 +484,8 @@ struct kvm_mmu {
>         u64 (*get_pdptr)(struct kvm_vcpu *vcpu, int index);
>         int (*page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *f=
ault);
>         void (*inject_page_fault)(struct kvm_vcpu *vcpu,
> -                                 struct x86_exception *fault);
> +                                 struct x86_exception *fault,
> +                                 bool from_hardware);

Probably a bit late to ask this question, but why do we need
from_hardware (or the previous hardware_nested_page_fault) as opposed
to just checking exit_code / exit_reason? Is it possible to get an
NPF/EPT violation but then synthesize a different one into L1 rather
than forwarding the one we got from HW?
