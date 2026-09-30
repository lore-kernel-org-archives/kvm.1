Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DCA3AEB4E
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805388; cv=none; b=ahkdvtKSaNc5K3aP7t7DZH5pyYN887MaFKKJ6Jeg/gWGyC3ImZ4igOeK+jjdXRc5kgH8aLkSjFuLLCqjzZB7mmWRGcO/QyKqeuxvuVDhwr1qpw2TMZ1rqFMbTVuS34XmODtsQeZ5UEHnTtIsKX+aZRS4zAquRJZ+CZAdWIQXMNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805388; c=relaxed/simple;
	bh=flt6asXiI8on5lzCjZB31aQNZlVlHpLl3giGZSkEj5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k6IXzz663Oc2AGuaidsvMeJU8EN0wBVtbRpogZ4oTNPtUi+J0dkeeYiAdpDnvdxLvkd87nUzNU1PcJar9YgnDKD1gKM1kcqUNAy8HBSPEkBPMahsjVRTEG7J3jX+vtDsXvj0z52PMV8osSuELGxNjJqnktmQfDO3b88wj0/7wFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/o9wF6y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/o9wF6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFEA1F000FF;
	Wed, 30 Sep 2026 21:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790805386;
	bh=X5EZA0L1+C9dSu8/0fUS6ZvPIZe0oTPIPHKnzxdK4O8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P/o9wF6yC7gRGgi51rnmoof70B2g8bG9P0tN9rbBdzT1dsnHVKv/PYYUa2gfj1H1P
	 lXZLvRnejRqV6JPfLxT/RrMrIp/aRZN1JZLP+tIa+dtZlrtMioUQhrtSW0PLSl25tU
	 QHlqFBj5Cc7L26u+7VraymtbtReuPjtIU1qSHwv8045x1p8MqbyjKv4aQ5x04ryTcn
	 +jvQzpyiTUWf0iRhvnwnvFP1z/6zwA3iXjNW5jkAcU6oHDSzjzm++kfvji58PRf82O
	 /GoCRdqv5UXweGuPOEQnvziqEycZer8o5O5ufYsAje6QBGRivyinD0T6J3VdwwDFdH
	 HZ4KAeFoVsPlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/20] KVM: VMX: Save guest EGPRs in VCPU cache
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260930210750.1487547-3-chang.seok.bae@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-3-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 21:56:26 +0000
Message-Id: <20260930215626.8BFEA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] x86/kvm: Host #UD if compiled with APX due to eager XCR0 switchi=
ng
--

commit 5f3e2588771c8927cac932c31186a1b9a8aea80f
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: VMX: Save guest EGPRs in VCPU cache

This commit enables saving and restoring guest EGPRs on VM exit/entry if
the system supports APX. The patch switches EGPRs during the vmentry/vmexit
assembly path instead of lazily. This avoids conditional checks in register
read/write paths and allows for future usage of APX registers in the kernel.

Link: https://lore.kernel.org/adPRA4ZhnvbaXSn0@google.com

> diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> index 00d807505fc88..02308fb36f0f5 100644
> --- a/arch/x86/kvm/vmx/vmenter.S
> +++ b/arch/x86/kvm/vmx/vmenter.S
[ ... ]
> @@ -46,6 +47,16 @@ SYM_FUNC_START(__vmx_vcpu_run)
>  	/* Reload @vmx, _ASM_ARG1 may be modified by vmx_update_host_rsp().  */
>  	mov WORD_SIZE(%_ASM_SP), %_ASM_DI
> =20
> +#ifdef CONFIG_KVM_APX
> +	ALTERNATIVE "jmp .Lload_egprs_done", "", X86_FEATURE_APX
> +	testl	$KVM_ENTER_EGPR_SWITCH, (%_ASM_SP)
> +	jz	.Lload_egprs_done
> +	LOAD_REGS %_ASM_DI, VMX_vcpu_arch_regs, \
> +		  %r16, %r17, %r18, %r19, %r20, %r21, %r22, %r23, \
> +		  %r24, %r25, %r26, %r27, %r28, %r29, %r30, %r31
> +.Lload_egprs_done:
> +#endif

[Severity: Medium]
If the host kernel is compiled with APX instructions (which this patch
prepares for to allow future usage of APX registers in the kernel), could
this lead to a host #UD in host C code?

In arch/x86/kvm/x86.c:vcpu_enter_guest(), we eagerly set the hardware XCR0
to the guest's value, which disables the APX bit if the guest disabled it:

	kvm_load_xfeatures(vcpu, true);

Just above this new EGPR switch in __vmx_vcpu_run(), we call into host C
code:

	call vmx_update_host_rsp

Since the hardware XCR0 is still the guest's XCR0 at this point, if the
compiler emitted APX instructions in vmx_update_host_rsp() or any other
C code called before VM-Enter (or after VM-Exit), wouldn't the CPU raise
a #UD?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930210750.1487=
547-1-chang.seok.bae@intel.com?part=3D2
