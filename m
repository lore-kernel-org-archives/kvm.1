Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D25A5221ED
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788864806; cv=none; b=PcE0VGYhbMF6oJe8WML/60S3qMPuxO/CSGbDxd8ZbZtrkXd+CIbpevggKrpXGJ8RhO6RBEuX8mkUDlqiXw2zR4pxFQYzf2Iu23DDdC9C5ROoOvveYIOrf5qGCakyvg2vh8yoPuaD3mscDbhnmlPbDvisOR49EUVnsbGxhSrgG5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788864806; c=relaxed/simple;
	bh=NKqDwaM9LI/FhLbfpzcuoCtpD0Fa9bGaJfi2yS3ZK3Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c3sUNLWxlqbDB0djLSazDopxDLpQslcjc+GaPfyaHtm51P8qdeH6Ui+eys0mJwSpPHbg730mmbwq87pb2rCJz+9XNa8b531ShRLxreXc2aiaXIdK7sYtxe2RMA0j5gR73LGeQEKptyoR3UYsrM3E8wLKwoIp0Yp11Jb3qqNi9g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cifOKcfV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cifOKcfV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0651F00A3A;
	Tue,  8 Sep 2026 10:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788864799;
	bh=iwa9oK2sPR0pZdNqWlqOShC29WQ0rZLszXHah/oQYH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cifOKcfVGk4WX/p4yTbp0LtAuAI4kroyLN9H8VzwG7Bs/5RH3SAGzPhINZa35X87h
	 hf2YRtb9Yne4PpJeZfauokMWZPLjY0Lex4TO41xRfJZ3ivah8RjNXtKV0K1689p9fP
	 c8Hi1jWjjID94glwgv01fapip1fG6H4LD2mEC+vvnVPcg7FkD4XpGLBF85wyMyKJQM
	 18aw9wfyKYFexV6P6TdVA0boHM3DeK+a3/VWDCsaT4yukiQyllrO2ZaMGfOVWeUpzL
	 AVYjOqB07VUW9QToaknX/mVPDBRuzo2JzYwpt2r5orUFnrkIdrXSpfdZSc9IobAPon
	 BSoxkrdfwk26g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] KVM: SEV: Add direct VMSA capability
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260908103338.427254-5-joro@8bytes.org>
References: <20260908103338.427254-1-joro@8bytes.org>
 <20260908103338.427254-5-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 10:53:19 +0000
Message-Id: <20260908105319.AA0651F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Using `guard(mutex)` inside a `switch` case without enclosing brace=
s causes a compile-time error and bypasses variable initialization.
--

commit 14ba20ca988537a92ef023f074770d517f738803
Author: Joerg Roedel <joerg.roedel@amd.com>

KVM: SEV: Add direct VMSA capability

This commit introduces the KVM_CAP_SNP_DIRECT_VMSA capability, allowing
userspace to manage VMSA pages directly for SNP VMs. When enabled, it skips
KVM-owned VMSA allocation during vCPU creation and measurement at launch.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 7d59d301e1e54..98c5cffe2c227 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
[ ... ]
> +static int svm_enable_vm_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
> +{
> +	switch (cap->cap) {
> +#ifdef CONFIG_KVM_AMD_SEV
> +	case KVM_CAP_SNP_DIRECT_VMSA:
> +		if (memchr_inv(cap->args, 0, sizeof(cap->args)) ||
> +		    kvm->arch.vm_type !=3D KVM_X86_SNP_VM)
> +			return -EINVAL;
> +
> +		guard(mutex)(&kvm->lock);

[Severity: Low]
Does this code cause a build failure? Using guard(mutex) inside a switch ca=
se
without enclosing braces declares a variable in the wider scope of the swit=
ch
block.

> +		if (kvm->created_vcpus)
> +			return -EINVAL;
> +
> +		to_kvm_sev_info(kvm)->snp_direct_vmsa =3D true;
> +		return 0;
> +#endif
> +	default:
> +		return -EINVAL;

If execution jumps to this default label, it bypasses the initialization of
the cleanup variable declared by the guard in the case above. The cleanup
function will then attempt to run on an uninitialized pointer upon return.

Could the KVM_CAP_SNP_DIRECT_VMSA case be enclosed in curly braces to limit
the scope of the guard?

> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908103338.4272=
54-1-joro@8bytes.org?part=3D4
