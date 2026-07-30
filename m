Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA431F942
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785401758; cv=none; b=lm0tHFu28/Cdvup5Hyx1AiB+SPqMLj9ZRIWeYzT3vVLfn+teGwusoirolJIHNDgbq63OYvW9Z9vnK+W6WKaGBxhykykqCNhARWzC+2EcZANQd2Ko/+p1U9328w+u2kYZoAYBqMYl8uLMUUAVnW8aKmj47dDZJx+F07z0PbLyZXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785401758; c=relaxed/simple;
	bh=MWKwskepmHSqRFtof5HVGe21NT1vGxkzj4I7n+lm9Ao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nNw9TB5TPaAoSBMgqKElR3lwfUK4p67w5yJPh1p2l+lIVvVwlfCuXam0Nlq8E0xxtrAuZxFdkeFXPK8n2BSx234IeL8shtcXDTtS8+kIRwV8n+WHy5Regp+XDchNvuGfdKORTU1+XJBcZqXiBhoaiHoFvGvAGxAVi45gkyfo+N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4QQqqqK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4QQqqqK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8261F00A3A;
	Thu, 30 Jul 2026 08:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785401756;
	bh=LfT5nUZIidj5vdMKsjHk4tUdf1SX+i2t1KDVQ0C7MeE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z4QQqqqKcaswAvgXY1UEyMQwT9+CkUWRoxi2LF82c1gAM1V3+Du7nL+RgdkqZqbr2
	 1sJDfBRZnoluAaKb6+CUIqpf+hJVIGWreoPS+UAkRhMiNW8XlXIukax4d8gB2bhxBk
	 K9v3G8TR+MpaL6xd9vZWGcBGFDuLEMpSsVrYtzpBGSsnNFr81JRi6AfQSG+G59Lnc6
	 59Ibr3mckpVgsnXEEFX3NPJunoktX/Cv9Hf83UdnEryNEV/NTfStq2+e1K1mmtEaNm
	 UkpeYjKeInvx8gaVc7nLz0PEz5L5bACRkjGB2sPEEnNPvAapNz36HpfNla85/5UHju
	 pNoMP+laJi/4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: have hva_to_pfn_remapped write-upgrade PTEs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729032112.20629-1-slp@redhat.com>
References: <20260729032112.20629-1-slp@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 08:55:56 +0000
Message-Id: <20260730085556.AF8261F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Error codes from the second `do_fixup_user_fault()` are swallowed,=
 breaking the mmap_lock retry mechanism and masking errors.
--

--- Patch [1]: [PATCH v2] KVM: have hva_to_pfn_remapped write-upgrade PTEs =
---
commit 7ba2282b7cceb5b68ffdd0d236fcc8d5d4cbe83b
Author: Sergio Lopez <slp@redhat.com>
KVM: have hva_to_pfn_remapped write-upgrade PTEs

This patch addresses an issue where guest writes to unpopulated PTEs backed
by DRM GEM BOs trigger an EFAULT due to the fault handler installing a
read-only PTE. It introduces a second fixup_user_fault() call to trigger a
write-upgrade for these mappings.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index b4baa69a55402..8fd2b8644cfad 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c

[ ... ]

> @@ -2957,27 +2972,28 @@ static int hva_to_pfn_remapped(struct vm_area_str=
uct *vma,

[ ... ]

>  	if (write_fault && !args.writable) {
> -		*p_pfn =3D KVM_PFN_ERR_RO_FAULT;
> -		goto out;
> +		/*
> +		 * VM_PFNMAP fault handlers may install read-only PTEs via
> +		 * vmf_insert_pfn(), deferring the write upgrade to a second
> +		 * fault. Trigger that upgrade now.
> +		 */
> +		follow_pfnmap_end(&args);
> +		r =3D do_fixup_user_fault(kfp->hva, FAULT_FLAG_WRITE, &args);
> +		if (r) {
> +			*p_pfn =3D KVM_PFN_ERR_RO_FAULT;
> +			return 0;
> +		}

[Severity: High]
Does this code swallow important error codes from do_fixup_user_fault()?

If do_fixup_user_fault() returns an error such as -EAGAIN (due to mmap_read=
_lock
being dropped and re-acquired under contention) or -EHWPOISON, overriding it
by returning 0 with KVM_PFN_ERR_RO_FAULT seems to break the mmap_lock retry
mechanism and mask hardware errors.

KVM might then incorrectly fall back to instruction emulation instead of
retrying the fault, or attempt to emulate accesses on poisoned memory.

Should the actual error 'r' be propagated back to the caller instead?

>  	}
> =20
>  	*p_pfn =3D kvm_resolve_pfn(kfp, NULL, &args, args.writable);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729032112.2062=
9-1-slp@redhat.com?part=3D1
