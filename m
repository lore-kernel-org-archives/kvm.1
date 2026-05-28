Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4C928727D
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976774; cv=none; b=EDMrWCBQN9tctC+PzydmT+a/bw7YQYk2bphqt+1D76NwWlBFix1T27NGFKxaMBv3pSlWQ/ujTs/rwq8payQOlvUWGPzAQ1hk7hlptA+RdHOk1Ntg6PEeHBJepNv1N40Dhh0GCFs89ir7UnXV4mtjUbqJDTi8rQT9UTXVT+4V+TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976774; c=relaxed/simple;
	bh=UZdlt+FJYk4S92LZv+gfeOHVzOQJPKlvSnNFcuqiqCU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mgy75BhcmF4o0F8UtgSo17Z43sK6QmZcwqrHprFvDHZU/ptN6P7/9ZvdpH3T/nWrAulV+NuUxu2JBPgGQCJhs2qLe2VBihbbG/PwW9aGG7hp8EegMjKKL+97tjQIJJ8Y4A9RMMDzKZP3LU/ejgWlvn87nkjoiesw0tPMv80dOmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLr9StLm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLr9StLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E6C1F000E9;
	Thu, 28 May 2026 13:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779976773;
	bh=b4XRJdw/OmMaWmv/P/7RRz82++6XEvgR/Szq+hzeo9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oLr9StLmq0UGhtdOA1G0lwCdKeoSJks9wkrQyPHcKhUP4xOPf5xEIALG59CBXiNij
	 sueHcM+dtq9IFi/kHKXsw0lvLajj4BTFiw5HtTE/cHjCbgaJaIZrMEpk0RrSBG8CYJ
	 wh/689n9H4C63DURfBLQo7qKcD33WjpmNkVEmCi7YtskmEt4wTAjlkCfB/atCQyeT3
	 F0uKxqVcX0U0yg7E4p7VyA1JNokTcTiPW9AlBxxBdLzogO1Rqj4JmL4rV9IQ7zX/Xc
	 EX/vqoN7WkBAy+P57r8ylw7swADATgQ9JNT+ISgDZhC41OD6WOOXjoMseQaXD0cPml
	 Sbf64MRk9EtfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] LoongArch: KVM: Preserve auto-enabled PV
 features on userspace override
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cuitao@kylinos.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528133558.2196416-2-cuitao@kylinos.cn>
References: <20260528133558.2196416-2-cuitao@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 13:59:32 +0000
Message-Id: <20260528135933.21E6C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Setting CPUCFG_KVM_FEATURE on multi-vCPU VMs fails with -EINVAL if=
 userspace does not explicitly include auto-enabled PV features.
- [High] Unconditionally forcing auto-enabled PV features overrides userspa=
ce intent, preventing the disablement of features and breaking live migrati=
on compatibility.
--

commit 95ab045927fa0c15f853bc0aab6acbd07c86541d
Author: Tao Cui <cuitao@kylinos.cn>

LoongArch: KVM: Preserve auto-enabled PV features on userspace override

This commit adds a pv_auto_features field to struct kvm_arch to save the
kernel-default PV features. It then includes these saved features back into
the user-provided configuration during KVM_SET_DEVICE_ATTR.

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index e28084c49e682..d82782b90457b 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1169,7 +1169,7 @@ static int kvm_loongarch_cpucfg_set_attr(struct kvm=
_vcpu *vcpu,
>  		if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
>  				&& ((kvm->arch.pv_features & valid) !=3D val))
>  			return -EINVAL;
> -		kvm->arch.pv_features =3D val | LOONGARCH_PV_FEAT_UPDATED;
> +		kvm->arch.pv_features =3D (val | kvm->arch.pv_auto_features) | LOONGAR=
CH_PV_FEAT_UPDATED;

[Severity: High]
Does this break VM creation for multi-vCPU configurations?

When kvm_loongarch_cpucfg_set_attr() is called for the first vCPU,
kvm->arch.pv_features is updated to include both the user-provided val
and kvm->arch.pv_auto_features, and the LOONGARCH_PV_FEAT_UPDATED flag
is set.

When the ioctl is subsequently called for the second vCPU with the
identical val from userspace, the compatibility check above compares the
newly modified pv_features (which now includes auto-enabled features)
against the user's val (which lacks them). Because they do not match,
the check will fail and return -EINVAL.

[Severity: High]
Does unconditionally forcing auto-enabled PV features override userspace
intent and prevent feature disablement?

KVM API semantics expect userspace to have authoritative control over the
CPU features exposed to the guest. By unconditionally including
kvm->arch.pv_auto_features into the user-provided configuration mask,
the kernel actively ignores userspace's explicit requests to clear those
feature bits, which prevents deliberately disabling features for live
migration compatibility.

>  		return 0;
>  	default:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528133558.2196=
416-1-cuitao@kylinos.cn?part=3D1
