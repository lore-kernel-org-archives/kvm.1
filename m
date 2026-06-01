Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D310C3955C7
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307157; cv=none; b=EN4zIE1m9V1bYW4EaWJVcwmeeamhKesoK0Jdvs5tTsuwGZ4ks0gQ7P2VBBHxmjvFB4cRJXmx85brxx0vWZO+T2dQ5XhdWGsq+xXRydAaouTn7z7sfa5yh3FWtmZZ1GawiSr7BoPH/69hLfdu2VijjIOgq5LFVCdKz8VT6diJYes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307157; c=relaxed/simple;
	bh=gKxsvf627xbqNFMQ2TSRvAsaW9tQbESmz3FxHoicc1E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T9/GZAHGLRTjY+Ve2PwGDkuGmhgL3I641ZV8i33EGlhy6igYFOnnF5gV/ScquvBv9YFW7C17uPklpuJZCQREyu+Sw0fQLgyBHQ3M5Hr9LDZ+maqGXB2PkP+g4VcFgZvi8UTaIg2Xfe5ezq4CUFu02YIEjFOntC9tZ7pZNUY3I3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDWVoUE0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDWVoUE0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8CA1F00893;
	Mon,  1 Jun 2026 09:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780307151;
	bh=mVyC34Ui1g+SbpOJ1I8tJtvlLyv79b4hPD/8rD4r1Fg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cDWVoUE0esVK0OgebWlDM+k5cgCUYPV5k6/5kFiAzUanviolczKi1xbeKZSdjryAI
	 FfD7b5no+unDtT8TteZChwKRpOfMHJqqTUERgNpjkXJfFDggwRmeo+tusv4CZ+ZAbN
	 hAAwKEe3jGwtrLOcfC9fvCsd2vZ8bu4dyV3ntMe7sj9tx/PzLpon4qhFfiZhhyUjqQ
	 CsjL/IJmvXLhDLMZI20jRjuWqiW3s34d0VyPpZPnRmcPAdZJyx8mYlT+Sk/zySKTgJ
	 5+DljyGhSrwG//5MaZ3x49aLMvDqNHhGYczlF+QsJw/XQdleYJO1njBzaVfKKSvEwb
	 msXlucPS1Q8hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] RISC-V: KVM: Allow Zicfiss/Zicfilp extensions
 for Guest/VM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260601084336.2601675-5-inochiama@gmail.com>
References: <20260601084336.2601675-5-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 09:45:50 +0000
Message-Id: <20260601094551.1A8CA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Missing context switch and API support for the Zicfiss shadow =
stack pointer (`CSR_SSP`).
- [High] Zicfilp and Zicfiss extensions are enabled by default, violating K=
VM subsystem guidelines.
--

commit a0c518ab3b8be233eb4530a1f65b1f7970a43692
Author: Inochi Amaoto <inochiama@gmail.com>

RISC-V: KVM: Allow Zicfiss/Zicfilp extensions for Guest/VM

Extend the KVM ISA extension array to allow KVM userspace to
detect and enable Zicfiss/Zicfilp extensions for Guest/VM.

> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index 501e4fc60dd24..9f9c5ababd1e3 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -199,6 +199,8 @@ enum KVM_RISCV_ISA_EXT_ID {
>  	KVM_RISCV_ISA_EXT_ZCLSD,
>  	KVM_RISCV_ISA_EXT_ZILSD,
>  	KVM_RISCV_ISA_EXT_ZALASR,
> +	KVM_RISCV_ISA_EXT_ZICFILP,
> +	KVM_RISCV_ISA_EXT_ZICFISS,

[Severity: Critical]
Does this patch miss the context switch and API support for the Zicfiss
shadow stack pointer (CSR_SSP)?

Since the Zicfiss extension is exposed to the guest here, shouldn't the
unbanked ssp CSR (0x011) be saved for the host and restored for the guest
in arch/riscv/kvm/vcpu_switch.S:__kvm_riscv_switch_to()?

Without this, if the host userspace uses shadow stacks, returning from the
guest might leave the guest's ssp active, potentially pointing into guest
memory.

Additionally, ssp appears to be missing from struct kvm_riscv_csr in
arch/riscv/include/uapi/asm/kvm.h and struct kvm_vcpu_csr in
arch/riscv/include/asm/kvm_host.h. Does this prevent saving or restoring
the register during live migration?

>  	KVM_RISCV_ISA_EXT_MAX,
>  };
> =20
> diff --git a/arch/riscv/kvm/isa.c b/arch/riscv/kvm/isa.c
> index 1132d909cc25c..9852a91fdecc9 100644
> --- a/arch/riscv/kvm/isa.c
> +++ b/arch/riscv/kvm/isa.c
> @@ -65,6 +65,8 @@ static const unsigned long kvm_isa_ext_arr[] =3D {
>  	KVM_ISA_EXT_ARR(ZICBOP),
>  	KVM_ISA_EXT_ARR(ZICBOZ),
>  	KVM_ISA_EXT_ARR(ZICCRSE),
> +	KVM_ISA_EXT_ARR(ZICFILP),
> +	KVM_ISA_EXT_ARR(ZICFISS),

[Severity: High]
Are these extensions being enabled by default?

Adding KVM_RISCV_ISA_EXT_ZICFILP and KVM_RISCV_ISA_EXT_ZICFISS here
advertises them to the KVM capabilities, but they don't appear to be added
to the exclusion list in kvm_riscv_isa_enable_allowed() in the same file.

Would this cause them to fall through to the default return true, and
subsequently be enabled automatically for all new VMs if the host supports
them?

If so, this might silently alter guest hardware discovery and affect
backwards compatibility for live migration to older hosts.

>  	KVM_ISA_EXT_ARR(ZICNTR),
>  	KVM_ISA_EXT_ARR(ZICOND),
>  	KVM_ISA_EXT_ARR(ZICSR),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601084336.2601=
675-1-inochiama@gmail.com?part=3D4
