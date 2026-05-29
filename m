Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B752DAFA9
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780081320; cv=none; b=gcKx8EBDpPBwlfxjCq+EOuc8bPU2fagd161ufrPPBMDw1lM1M68GfR9ACWDDAKCb/s2M6s8piv58bbdqdtSygNMbv0i5IwNrT2OKVYTXhd/Hx5jWMyhMxSsS2akFhMSyj0gC6fp+XtppURBBsxQa5OHVNTpXwhcAZlkrO8TrxGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780081320; c=relaxed/simple;
	bh=Ewl45K1JfhyBsPMLkXS320VFH3z66GkZBU8nAIN1TR4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hEaAL285LnXdBsFBjXQzTbfK0t7Lwhi13o7XBeUnAe5fuh8yOIfFjWtZjX0/28tXQCYpU08frdfwULTFb9cHhJmkIasAdiJcGuwHmcnnH3FtEDj1JnB5MZP+zt+DENQRgweTXquYi6oowlCKfaZEMXeGPZ4HOx5yOvVrbURbu6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwLUGWdm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwLUGWdm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D597A1F00898;
	Fri, 29 May 2026 19:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780081319;
	bh=eiy0ihhXoxuuJf4XOEkMaFRdj5e60KdoCaYZgHhQoBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DwLUGWdmxHphYNFdFOaXWdW19FZgfSkN7sZHRCtYrhEwKdVhHFwdnUgLo4IfbVjfA
	 CySZFH9NhRci6e96E9mR4bSyoPuH21riQEVewlA13mblyUPh5luxOFbD/2Ha/J6jgW
	 67gmxwxT2+lYc0RuP3GO+ucMhTcBvqaFcGqQ9b8Mrr5+iwH+ocAgQTo7JFnYj3PjBX
	 PkHET5Qweieel3KzwaWKtpGRpQmEAkp/yhO6BAT8y5mcruald+C64lc7gpuegRNvwF
	 tNxmXY9p0OIMbR/UXIb3Ko7tpk6VHaHPG4+hfBlSW7ht7XBlu7pP/fScrvT3p98pwX
	 FUw9qPo906X9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/20] KVM: x86/xen: Convert
 kvm_xen_set_evtchn_fast() to gpc's CLASS() APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529165114.748639-16-seanjc@google.com>
References: <20260529165114.748639-16-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 19:01:58 +0000
Message-Id: <20260529190158.D597A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Scope-based `CLASS()` conversion unintentionally extends the durat=
ion of the `gpc->lock` read locks across expensive cross-vCPU IPIs (`kvm_vc=
pu_kick`) and nested lock acquisitions.
--

commit f52c566cf9e4ecf5b818d43ac788f5009d85b7bc
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/xen: Convert kvm_xen_set_evtchn_fast() to gpc's CLASS() APIs
   =20
Convert the event channel fastpath to the "map local" CLASS() APIs, using
the "try" variants as the faspath can't block.

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 8f822acb11a46..47750316f1322 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
[ ... ]
> @@ -1810,8 +1809,6 @@ static void __kvm_xen_set_evtchn_fast(struct kvm_vc=
pu *vcpu, int port_word_bit)
>  		kick_vcpu =3D false;
>  	}
> =20
> -out_unlock:
> -	read_unlock(&gpc->lock);
>  out_kick:
>  	if (kick_vcpu) {
>  		kvm_make_request(KVM_REQ_UNBLOCK, vcpu);

[Severity: High]
Does this unintentionally hold the gpc lock across the IPI kick?

By replacing the explicit unlock with a function-scoped CLASS() variable, t=
he
vcpu_info_map destructor won't run until the end of the function. This means
the lock is now held while calling kvm_vcpu_kick(), whereas the original
code explicitly dropped it first.

[ ... ]
> @@ -1888,9 +1881,6 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *=
xe, struct kvm *kvm)
>  		rc =3D 1; /* Delivered to the bitmap in shared_info. */
>  	}
> =20
> -out_unlock:
> -	read_unlock(&gpc->lock);
> -
>  	if (rc =3D=3D 1)
>  		__kvm_xen_set_evtchn_fast(vcpu, port_word_bit);
>  	return rc;

[Severity: High]
Does this now hold the VM-wide shinfo_cache lock while calling
__kvm_xen_set_evtchn_fast() and kicking the vCPU?

Since shinfo_map is a function-scoped CLASS() variable, its destructor
won't release the lock until after __kvm_xen_set_evtchn_fast() returns.
This creates a nested locking dependency and holds locks over expensive
cross-vCPU operations, potentially serializing event channel deliveries
across the entire VM on the fast path.

Would it make sense to constrain the mapping to an explicit scope block
to match the original release points and maintain the "No functional change
intended" guarantee?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529165114.7486=
39-1-seanjc@google.com?part=3D15
