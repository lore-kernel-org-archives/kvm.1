Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF42A39F196;
	Mon, 16 Mar 2026 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674714; cv=none; b=tzDNFjFhP/NCZ4hbINXp5sRQSqSY4PTJHZYZ9chfCdCKtv7LsCLcf9gyLtkMo44DjmlDX6QBZhvGS8IjesSydE/NsXvDZvlUL5DKG6Q73VLOx74vK9T9NkDETE7ctM5Q+mUpbn1WINNKu2RGalz+wWFKX+z0vk9bDa06ve/hvJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674714; c=relaxed/simple;
	bh=QSEvjNM0ShjUbhlyQRxSw9lkI+YOZZuMbq9qzjWXIKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuMdedGXEtTHDt4TTVMe5mMx0K+pnr+8SAJJpmYaiW02OAVsAhXLgdbQj3jrEAf3XwSFeRWoYXHDdN/hE8l0CXGCA42QRrFoGRDuqpcDeXamSRzSaMfWBJ2PJKPF+rRXU2TYG8w7nVl56F935VC0jCakPJbfA/d3p2H3nc96lKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5Bb1FJB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5Bb1FJB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F30C19425;
	Mon, 16 Mar 2026 15:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674714;
	bh=QSEvjNM0ShjUbhlyQRxSw9lkI+YOZZuMbq9qzjWXIKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H5Bb1FJBetM1JOZ5XfrAkUd4KwBgVrHEy6riwKu1jOhaB4HPm6tRd7iRkTINKuNyi
	 OfWt/MbzeTqGr9ghkGhNfxqbEgcXqH7y8C3gThUGJKbThJlCiF4RpRKSzIavG194Wj
	 4f1TjZG5ITgiqTIPXYp4Z1/mttHxj4lRXFaGj7ZS3xdBSNGKtrsEZxHEydwzg/OTAp
	 uWV38tzM72N/t4B73i5fi0DWlDBljVsb6UvTF9DUTpYZ+QbSZ3KTVmC2y5ezy68a1e
	 fVTfQH4XI2AYMvX5RT8wUSKi7zZpeyImYqtDR8nnqbiIx0W5hDvPi6w1WtfLtTaNgA
	 jZkPC9I2rkj+Q==
Date: Mon, 16 Mar 2026 15:25:12 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] KVM: SVM: Move RAX legality check to SVM insn
 interception handlers
Message-ID: <abgfzKvS3d0EZMmg@google.com>
References: <20260313001024.136619-1-yosry@kernel.org>
 <20260313001024.136619-4-yosry@kernel.org>
 <CAO9r8zNdmGK6EKnNHDNC9pZQh7+jxjHOsJin9Kaijk1hs0uX6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9r8zNdmGK6EKnNHDNC9pZQh7+jxjHOsJin9Kaijk1hs0uX6Q@mail.gmail.com>

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index cf5ebdc4b27bf..8942272eb80b2 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2237,10 +2237,11 @@ static int emulate_svm_instr(struct kvm_vcpu
> *vcpu, int opcode)
>                 [SVM_INSTR_VMLOAD] = vmload_interception,
>                 [SVM_INSTR_VMSAVE] = vmsave_interception,
>         };
> +       int exit_code = guest_mode_exit_codes[opcode];
>         struct vcpu_svm *svm = to_svm(vcpu);
> 
> -       if (is_guest_mode(vcpu)) {
> -               nested_svm_simple_vmexit(svm, guest_mode_exit_codes[opcode]);
> +       if (is_guest_mode(vcpu) &&
> vmcb12_is_intercept(&svm->nested.ctl, exit_code))
> +               nested_svm_simple_vmexit(svm, exit_code);

No, this is wrong.. well it's incomplete. So we do need to check the
intercept in vmcb12, but, if it's not set, we'll end up with KVM
emulating the instructions through vmload_vmsave_interception(), and
treating RAX as an L1 GPA.

If L1 has VLS enabled though, this is wrong. KVM should treat RAX as an
L2 GPA an run it through the NPT first before using it (e.g. through
translate_nested_gpa()).

Synthesizing a spurious #VMEXIT(VMLOAD/VMSAVE) is definitely better than
letting L2 bypass L1's NPTs and access its memory. So this change is a
net loss. I will drop it from the next version, and this spurious
#VMEXIT can be fixed separately to keep this series focused on fixing
the non-architectural #GPs.

>                 return 1;
>         }
>         return svm_instr_handlers[opcode](vcpu);
> @@ -2269,8 +2270,11 @@ static int gp_interception(struct kvm_vcpu *vcpu)
>                 goto reinject;
> 
>         opcode = svm_instr_opcode(vcpu);
> -       if (opcode != NONE_SVM_INSTR)
> +       if (opcode != NONE_SVM_INSTR) {
> +               if (svm->vmcb->save.cpl)
> +                       goto reinject;
>                 return emulate_svm_instr(vcpu, opcode);
> +       }
> 
>         if (!enable_vmware_backdoor)
>                 goto reinject;
> 
> ---
> 
> Sean, do you prefer that I send patches separately on top of this
> series or a new version with these patches included?
