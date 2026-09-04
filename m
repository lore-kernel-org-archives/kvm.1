Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE2920A5C4
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788482124; cv=none; b=YMhehv9P8WdUeje7UdGGgFZMEoF8hUnxUW9allE0x0PIhJa1HjmcGv5jO2afpa7/RRpkIf0xnwzNgxEl+z8r8i+nii1Abgt9iWmdZIsdjAnYbW8GefrWIzfmBxc2uO+OwjZBRetXftDJqgY9bQXAMxMPCS2ORrN6FRwanHkHQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788482124; c=relaxed/simple;
	bh=oOWBrRwJvchth9sr7LjSvv6m1Le66CRIEfvkW3KEg30=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WgW1osg7ApAxq2hCzmf0S5izALTPyvgzbvehioSSfR4q9J89Reex+AQcDFfzmmWB2Sh4tAWXV/ZTNX5MfAVECMJcAWzlGSDzYv16upRyxAxuOBEZ1Eo9ChZ/VO5CzuWi2oChHfBjk+9Q2qrc2nbWCIh9NWgbgQmGsJfFpVaY/is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rzw9cNu1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rzw9cNu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9988E1F000E9;
	Fri,  4 Sep 2026 00:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788482122;
	bh=McjahaRTDGZa13iKil07gcJKf6RrX+TM7ZMWrXJ87R4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rzw9cNu10+7dlm8uCAwWVJ98pt0ycDEPHO/U52R7lYCaeqxJI7wFwaUMiSJAQmGcT
	 JcPkgZ05z/fehBHMAfcSduBSIj1eG/JGKMIHGQEumDjOIMf3/JiM3pnZjbUMRRdVU0
	 4KmDDF8D3ZXqP1ngWsOIL6tnhiU1Jz5IlwE4nVLOi+wDmRJ8PQeS9P9c6qC3qzwL5s
	 6N9upHsfpzysBqNfmBRDNdynKQAyMXJzL+6SloOrKfuhzvG0N3tQm/0uVOY8UlVUqE
	 5VYvdOseNPv9kkxcuswN9uFcdrjEVtDQOkIJHXleEwrtham5S24gXG5dbvbZRmKwDY
	 F5rEFW2EujaEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/17] KVM: selftests: Add __vmwrite() and use it
 when initializing optional fields.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260904002423.3154436-16-seanjc@google.com>
References: <20260904002423.3154436-1-seanjc@google.com>
 <20260904002423.3154436-16-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 00:35:22 +0000
Message-Id: <20260904003522.9988E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch fails to convert all blind writes of optional VMCS fie=
lds to the non-asserting `__vmwrite()` in the common setup code, contradict=
ing its stated intent and setting up a test crash.
--

commit 2bdd2a9b67ebe18b99a514555581198b78d1fab6
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Add __vmwrite() and use it when initializing optional field=
s.

This commit introduces __vmwrite(), a non-asserting version of vmwrite(), to
allow writing optional VMCS fields in common setup code where success is not
guaranteed. It prepares for vmwrite() to unconditionally assert success in
subsequent patches.

> diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/se=
lftests/kvm/lib/x86/vmx.c
> index 1a8515de42b06..b6bd9423e6768 100644
> --- a/tools/testing/selftests/kvm/lib/x86/vmx.c
> +++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
> @@ -252,7 +252,7 @@ static inline void init_vmcs_control_fields(struct vm=
x_pages *vmx)
>  	u32 sec_exec_ctl =3D 0;
> =20
>  	vmwrite(VIRTUAL_PROCESSOR_ID, 0);

[Severity: Medium]
Will this blindly write to the VIRTUAL_PROCESSOR_ID field using the asserti=
ng
vmwrite()?

Since VPID is an optional secondary control that may not exist on all
hardware, this could crash selftests with a VM-Fail assertion on unsupported
hardware once vmwrite() is modified to assert success. Could this be conver=
ted
to __vmwrite() similar to POSTED_INTR_NV?

> -	vmwrite(POSTED_INTR_NV, 0);
> +	__vmwrite(POSTED_INTR_NV, 0);
> =20
>  	vmwrite(PIN_BASED_VM_EXEC_CONTROL, rdmsr(MSR_IA32_VMX_TRUE_PINBASED_CTL=
S));

[ ... ]

> @@ -356,8 +356,8 @@ static inline void init_vmcs_guest_state(void *rip, v=
oid *rsp)
>  	vmwrite(GUEST_GS_SELECTOR, vmreadz(HOST_GS_SELECTOR));
>  	vmwrite(GUEST_LDTR_SELECTOR, 0);
>  	vmwrite(GUEST_TR_SELECTOR, vmreadz(HOST_TR_SELECTOR));
> -	vmwrite(GUEST_INTR_STATUS, 0);
> -	vmwrite(GUEST_PML_INDEX, 0);
> +	__vmwrite(GUEST_INTR_STATUS, 0);
> +	__vmwrite(GUEST_PML_INDEX, 0);
> =20
>  	vmwrite(VMCS_LINK_POINTER, -1ll);
>  	vmwrite(GUEST_IA32_DEBUGCTL, 0);

[Severity: Medium]
Will these writes to optional guest state fields cause test failures on CPUs
or nested hypervisors that lack these features?

Fields like GUEST_IA32_DEBUGCTL, GUEST_IA32_PAT, GUEST_IA32_EFER, and
GUEST_IA32_PERF_GLOBAL_CTRL are written unconditionally using vmwrite() here
in init_vmcs_guest_state(). It seems they will assert failure on unsupported
hardware. Should these also be switched to use __vmwrite() to avoid crashin=
g?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904002423.3154=
436-1-seanjc@google.com?part=3D15
