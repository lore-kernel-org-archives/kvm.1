Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E71F3B635F
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782841058; cv=none; b=qf9p+MZO5eyBwMIu6IB3cFI8FdOOZfNPzgef9QfoFMvdy8NpJVnnRJMHc5txgXC7Egh+1ptewu/dzVs4ANiQWjWMCBTTcv6bf7eZ6ZSOV8JDvD7Knt9OXPL8q1tzXynf/MeAahVqUjK1VGPt90nXc7YDqZIlyCeBof+DnjGGh9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782841058; c=relaxed/simple;
	bh=zBWWjX+FUv9l6wXHetMFCl/xvHhg6igYiaNQOj2cDc0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tPAyt6HwuVVcWP/6986vhnFwg5ezzXja2rYMo3xQyDX16ciVAobRrhB+u4fgOQjupXJc+LA5QSf14yD0rMDYgQfSholfLgpYsBS775S15FTwRrITq8ORts1STuok3qABwxeNxlfvznhsf2sXlzBHJ0QyzjSu4opWfZTE+6feUak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1jQwqCf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1jQwqCf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782991F000E9;
	Tue, 30 Jun 2026 17:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782841056;
	bh=sKLyBExX9MIp+GXYIZfZpS/5/Cy8V3ValMCaOHtT1yA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U1jQwqCfwftghprrsoIo94ORCW+cSV/IPCW90cm9oPrNafqiyxzMX4VVX194LFvgJ
	 lvgg2+AUzR8oYQDc5fvGV22VdcQbgoQtjbYLQjZ6gl1KzW9PP4GCYXLJtVXB9+qk9a
	 3t1X0AyN48+OyTz5XRwWSyqZZOzlG0eY9eLQxOoeJdtNBMqIY/mnTc0E0KtU7Jaw3y
	 pwWYj0wwYirrV9OABfhgiCEddTNyS/Hyvy3UYqqNONQAwvwEoyPLVmcLBArg+Y8JHw
	 5+HV3Pb1+N6R8dlGYkeXwFLR3nbuU2j6aUEY6FTHBNcUZsnL+5dZ0OZ4heoMRRepzP
	 Er7j83YXXtwNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y 2/2] KVM: SEV: Unmap and unpin the GHCB as needed
 on vCPU free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260630172204.279784-3-seanjc@google.com>
References: <20260630172204.279784-1-seanjc@google.com>
 <20260630172204.279784-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 17:37:34 +0000
Message-Id: <20260630173736.782991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] SEV-ES GHCB unmap functions execute sleep-capable and page-faultin=
g operations while preemption is disabled, leading to kernel panics and sil=
ent guest data corruption.
--

commit 33a2dedac2ed0fec45371ed9062d6e4dbc63f2b1
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: Unmap and unpin the GHCB as needed on vCPU free
   =20
Unmap and unpin the GHCB as needed when freeing a vCPU.  If the VM is
destroyed after mapping+pinning the GHCB on #VMGEXIT, without re-running
the vCPU, KVM will effectively leak the GHCB and any mappings created for
the GHCB.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 0f79e052ac421..7914cdea4cdd1 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3412,6 +3412,20 @@ static int sev_es_validate_vmgexit(struct vcpu_svm=
 *svm)
>  	return 1;
>  }
> =20
> +static void __sev_es_unmap_ghcb(struct vcpu_svm *svm)
> +{
> +	if (svm->sev_es.ghcb_sa_free) {
> +		kvfree(svm->sev_es.ghcb_sa);

[Severity: High]
This isn't a bug introduced by this patch, but can this lead to sleeping in
atomic context or a kernel panic?

If a guest triggers a #VMGEXIT that induces a userspace exit while using a
scratch buffer outside the GHCB, it appears we can reach this execution pat=
h:

arch/x86/kvm/x86.c:vcpu_enter_guest() {
    ...
    preempt_disable();
    kvm_x86_call(prepare_switch_to_guest)(vcpu);
    ...
}

Where the x86 callback resolves to svm_prepare_switch_to_guest() which call=
s:
    sev_es_unmap_ghcb()
        __sev_es_unmap_ghcb()

Since __sev_es_unmap_ghcb() calls kvfree() and kvm_vcpu_unmap() (which can
call memunmap), and sev_es_unmap_ghcb() calls kvm_write_guest(), aren't the=
se
sleep-capable operations being executed while preemption is disabled?

> +		svm->sev_es.ghcb_sa =3D NULL;
> +		svm->sev_es.ghcb_sa_free =3D false;
> +	}
> +
> +	if (svm->sev_es.ghcb) {
> +		kvm_vcpu_unmap(&svm->vcpu, &svm->sev_es.ghcb_map, true);
> +		svm->sev_es.ghcb =3D NULL;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630172204.2797=
84-1-seanjc@google.com?part=3D2
