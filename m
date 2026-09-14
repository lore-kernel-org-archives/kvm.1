Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CC7381EA9
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789410257; cv=none; b=Cuc7PdM4LDrYJHs+Uqh7fZRU8Fea4Mk7FkAfjrLipPupJgTtL3dNMsQ3NS/CmaXgwTo6o4zGIoP6jwH4ribceDDoYP7LPjcPderS+omy/DdbN3hKMwnz3WON4aPaacXSb8pcPwd6wonNfrS4ZcgujGNToxIRR85+JTftLBU9cBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789410257; c=relaxed/simple;
	bh=dGW+X/liPfgw64pPe+WajoEJA9nILyzUVSIP75uQkRg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EBbo0wV99PWtFCHDCZ9JnMYTjanqMFk+FYaQoa4baY4VS6TDI56zWjq2IKFf+AzlHTDgk0+rXFtyEUK5oGHsWzHPXreNDlY9S0Ko9M3zDpaE/3E4ePE5OJHtiBiZTvBWMijb9+pYaQhAgkaiUFF3/PB5HFxhHWx7dWNr7CIvzQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fG+EeLGM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fG+EeLGM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4011F000FF;
	Mon, 14 Sep 2026 18:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789410256;
	bh=yWPc5MBaUgrrDgZ6ixZIstffpF0yrQ9HrwrFNUkJQI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fG+EeLGM3/pII7eZIBtuLRkjPmjEuc+s0AC86AoqEkwx/OCuXNg4ZLQehllqyBFiB
	 vBMTzJFvq8BpfxqapQys84XE88ZydyNoI4a9lYz7XkLFX9th+GWQGxYbC5PU/xKahz
	 ++UluP7rqQBWKcrPMIFkVmEyaENNag2SxzLjfdbioPj82nsDqtmZCwCa0Tvd1yoWb7
	 jhx5rfDggTeDQyltRhAxO2XfOcNkRfXBT/wZoXO1xkyMaBq+qgUwunRTZsW7bP13E9
	 w1WNwmHm60JV3pLpdulIqmMUHzDWIKZQCttd/7KE8m0Jnm1FTYJY4M88TTf17zZwJT
	 UWND3U9jsSJdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] KVM: Reject attempts to lock all vCPUs if vCPU
 creation is in-progress
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260914181223.289061-2-seanjc@google.com>
References: <20260914181223.289061-1-seanjc@google.com>
 <20260914181223.289061-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 18:24:15 +0000
Message-Id: <20260914182416.4D4011F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Redundant manual check for vCPU creation left behind in ARM VGIC in=
itialization.
--

commit 62db20a1fe5b1f9f44f668c005957e7cf68b7547
Author: Sean Christopherson <seanjc@google.com>

KVM: Reject attempts to lock all vCPUs if vCPU creation is in-progress

This commit updates KVM to reject attempts to lock all vCPUs while vCPU
creation is in progress by adding checks inside kvm_trylock_all_vcpus()
and kvm_lock_all_vcpus(). It also opportunistically drops existing manual
checks that precede or follow locking all vCPUs.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 65eb26a0520d8..78cc090435be5 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1363,6 +1363,9 @@ int kvm_trylock_all_vcpus(struct kvm *kvm)
> =20
>  	lockdep_assert_held(&kvm->lock);
> =20
> +	if (kvm_is_vcpu_creation_in_progress(kvm))
> +		return -EBUSY;
> +

[Severity: Low]
Was the manual check in arch/arm64/kvm/vgic/vgic-init.c missed during the
cleanup of redundant in-progress vCPU creation checks?

The commit message notes that existing manual checks are being dropped, but
in kvm_vgic_create(), there is still a manual check immediately following t=
he
kvm_trylock_all_vcpus() call:

arch/arm64/kvm/vgic/vgic-init.c:kvm_vgic_create() {
        ...
        ret =3D kvm_trylock_all_vcpus(kvm);
        if (ret)
                return ret;

        ret =3D -EBUSY;
        if (kvm->created_vcpus !=3D atomic_read(&kvm->online_vcpus))
                goto out_unlock;
        ...
}

Because this condition is now evaluated inside the preceding
kvm_trylock_all_vcpus() call, this manual check in kvm_vgic_create() appears
to be left as dead code and will never evaluate to true.

>  	kvm_for_each_vcpu(i, vcpu, kvm)
>  		if (!mutex_trylock_nest_lock(&vcpu->mutex, &kvm->lock))
>  			goto out_unlock;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914181223.2890=
61-1-seanjc@google.com?part=3D1
