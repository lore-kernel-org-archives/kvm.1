Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07AA26E165
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 02:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789007850; cv=none; b=LSrsMzCR22pE5kV+n4WuUOe+Rw1hQaRuW+vn6fvwR/HXR4CsbToJHCtThfxxkR26Ih3zOfwYFsfje0a9EDPzm+Tvom6iSzQ4ce0eCSG6aCXiyTTGlf83JAReybfkQ63TVuPorownK1YeHvsRcXoBUDaFdZ4lHCcZl5g0y1ly20U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789007850; c=relaxed/simple;
	bh=fnzkdWiJjnqYYEQ2Vi2ivKVAn0qEsmfj5a+9QuyNniw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ujH7yslAfjClA6UlCUzNK9I9tIG7tFhOexV7C144ucWOPAGuFOcZJBGq3oijSvTchgQ0NitaG0lsQLkz/3UIFCFvzXV6ccpJ4NCN7RWxXYtndYj6PMn1qI1He9kIgmiI4DrkYjkab2Sgel0cRc/N10isIsSCqtQnv5uQ+ok5DUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XISPUgrQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XISPUgrQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF77D1F000FF;
	Thu, 10 Sep 2026 02:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789007849;
	bh=r15PspO1rIdQMFCt3PB0pMXQ/JRFKd/F1OGYNXpB/TY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XISPUgrQmcSq3JL+2GBxCnvbZ7rolAzwr7YWa+53aZwPLFam02LgNPqFKHJBLu1cy
	 qd+arL/edndiMlpCLhVSnJ709huWsjVc8bp/0ASA8S1MCAu5aTHszfu01xKjETRgg6
	 DE6GDoFqxrH8jKtG7mUWzwKh9rD1eOV5WK4ZLGC6C+2Gu5YCde22KpDaDtYI3z/Yo5
	 4PuK2N7/aOhg0OksX8CTa4aWR5/jABDLdAO5n2vlXbHILEep5gR2FpDm4twIqtH3ph
	 TTxNytBeZi1+LpQYokjJTED/kkg1RcFwZrVfmcg+jtS5jWJov0WeCtfqKDhjfPjQ90
	 IrtQ+Fuj2BHhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] LoongArch: KVM: Allow to set pv_feature until vCPU
 run
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260910022118.2339780-1-maobibo@loongson.cn>
References: <20260910022118.2339780-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 02:37:28 +0000
Message-Id: <20260910023728.DF77D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] A per-vCPU guard (`has_run`) is incorrectly used to protect a VM-w=
ide state (`kvm->arch.pv_features`), allowing runtime mutation and conflict=
ing configurations across vCPUs.
--

commit c74c65cf1934e410a4858855575161a3136ee9d8
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Allow to set pv_feature until vCPU run

This commit modifies the KVM LoongArch PV feature configuration so that
features can be configured multiple times until the vCPU has run, which
helps with VM migration.

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 8e028be3f0a97..dbf87ac5252b6 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1166,12 +1166,17 @@ static int kvm_loongarch_cpucfg_set_attr(struct k=
vm_vcpu *vcpu,
> =20
>  		/* All vCPUs need set the same PV features */
>  		spin_lock(&kvm->arch.pv_setting_lock);
> -		if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
> -				&& ((kvm->arch.pv_features & valid) !=3D val)) {
> +		if ((kvm->arch.pv_features & valid) =3D=3D val) {
> +			spin_unlock(&kvm->arch.pv_setting_lock);
> +			return 0;
> +		}

[Severity: High]
Can conflicting configurations silently overwrite the shared
kvm->arch.pv_features without returning an error here, given the removed
LOONGARCH_PV_FEAT_UPDATED cross-vCPU enforcement logic?

> +
> +		if (vcpu->arch.has_run) {
>  			spin_unlock(&kvm->arch.pv_setting_lock);
>  			return -EINVAL;
>  		}

[Severity: High]
Since kvm->arch.pv_features is a VM-wide state, is it safe to use the
per-vCPU guard vcpu->arch.has_run here in kvm_loongarch_cpucfg_set_attr()?

If a userspace process configures VCPU0 with features A and starts it
(vcpu0->arch.has_run becomes true), and while VCPU0 is running, userspace
configures VCPU1 (which has not run yet) with conflicting features B:

Because vcpu1->arch.has_run is false, wouldn't the ioctl succeed and
overwrite kvm->arch.pv_features with B?

This would override VCPU0's configuration and mutate the shared state
while VCPU0 is running, which can lead to a state-machine mismatch and
data race since kvm->arch.pv_features is accessed locklessly by running
vCPUs.

> -		kvm->arch.pv_features =3D val | LOONGARCH_PV_FEAT_UPDATED;
> +
> +		kvm->arch.pv_features =3D val;
>  		spin_unlock(&kvm->arch.pv_setting_lock);
>  		return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910022118.2339=
780-1-maobibo@loongson.cn?part=3D1
