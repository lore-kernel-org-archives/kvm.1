Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261AE298CAB
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780332729; cv=none; b=g4HTakqqfVJYwg4Iac3cUgjddcKeNvDNDFS169WprE+O+3MFigoTi1Y/zkxYL81fzbSJtldKY37HVwTEMxqg9DRvg0nOS0fdGVp1Cmx1nQVzscK/PlGWnGU5uzqSSYwXuOa0gbES3ofUHS64AmhmEBOm4IvfbPIwajTjhw07ZEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780332729; c=relaxed/simple;
	bh=qmt5jDN7ZlK+ZD/wHTWltfWANIlcwBrVQqrIQDZaH08=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kisC9I9uuduYACFiLclB2M4qyyY9rACy4XcxOdGsSEYi1CmIymwS1x4dvaUiwvHlz9c5E8zyy1X0JOecFoRkV96C/8YMQFUBK/+nMc8oT56QpSuVXYzJpikutbb96zw7aKIbLeC+RU3mgW4epmJTqj/pd1x/vETSJgeQ5WTb/rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBC/949+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBC/949+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A1E1F00893;
	Mon,  1 Jun 2026 16:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780332727;
	bh=txxU4tJVp5/cjZLMvoeAO5qYWxaobeTzhrs8uEBcRgw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VBC/949+Tup04zKLZ16qSQqO3NQ4eh4n0B8UFlnTTF2zi7c8vstbS8ycOSOpl4m7g
	 45R4Vn9sAQ4+2pW9qlydkpJ/h+119NcqL8EaGoGW6C+SygU+scVlngj9kGs0o432bX
	 gEI8fuoudcyhZUNIef83FXZLNPPR96mEobHXis/IjUB20sdV8oQsW8zVh+g3YVCt4J
	 ZhCd8Zvy3/8SF720vNkDD5AtNxTPwW21UPyWj1ChPSfbwJx4uieyc4sOR1ECNVVrp5
	 NiLq1LljkI/R/R0uCwOVbXnEs4oMFNJqDEQxvAGLM+Ecvkif6okUzprQKpivohxuu0
	 F4TRJl/y9qzeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] KVM: s390: Fix fault-in code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260601152951.196859-7-imbrenda@linux.ibm.com>
References: <20260601152951.196859-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 16:52:06 +0000
Message-Id: <20260601165207.61A1E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of the pinned host page reference when `kvm_s390_new_m=
mu_cache()` allocation fails.
--

commit 132617ab1e43f506af43740ee664fcdba7a95ff5
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix fault-in code

This commit fixes the fault-in code so that it does not return success if
a concurrent unmap event invalidated the fault-in process. It ensures the
code retries properly instead of returning success without actually
faulting in the requested page.

> diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
> index ddf0ca71f3741..cf542b0a7e8e3 100644
> --- a/arch/s390/kvm/faultin.c
> +++ b/arch/s390/kvm/faultin.c

[ ... ]

> @@ -110,20 +111,19 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, str=
uct kvm *kvm, struct guest_fa
>  			if (!mmu_invalidate_retry_gfn(kvm, inv_seq, f->gfn)) {
>  				f->valid =3D true;
>  				rc =3D gmap_link(mc, kvm->arch.gmap, f, slot);
> -				kvm_release_faultin_page(kvm, f->page, !!rc, f->write_attempt);
> -				f->page =3D NULL;
>  			}
> +			kvm_release_faultin_page(kvm, f->page, !!rc, f->write_attempt);
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but I have a question about how
f->page is handled when kvm_s390_new_mmu_cache() fails earlier in this loop.

Earlier in kvm_s390_faultin_gfn() in arch/s390/kvm/faultin.c,
__kvm_faultin_pfn() resolves the PFN and pins the host page, storing it
in f->page.

Then, if mc is NULL, the code attempts to allocate a new cache:

    if (!mc) {
        local_mc =3D kvm_s390_new_mmu_cache();
        if (!local_mc)
            return -ENOMEM;
        mc =3D local_mc;
    }

When kvm_s390_new_mmu_cache() fails and returns -ENOMEM, it looks like the
function returns directly without calling kvm_release_faultin_page() to drop
the previously acquired reference in f->page.=20

Callers like kvm_s390_faultin_gfn_simple() and access_guest_page_with_key_g=
pa()
declare struct guest_fault f locally on the stack and propagate the -ENOMEM
error without inspecting or cleaning up f.page.

Can this permanently leak the pinned host page? Under memory pressure, could
an unprivileged guest repeatedly trigger page faults to accumulate leaked p=
age
references and exhaust host memory?

> -		kvm_release_faultin_page(kvm, f->page, true, false);
> =20
>  		if (rc =3D=3D -ENOMEM) {
>  			rc =3D kvm_s390_mmu_cache_topup(mc);
>  			if (rc)
>  				return rc;
> -		} else if (rc !=3D -EAGAIN) {
> -			return rc;
> +			rc =3D -EAGAIN;
>  		}
>  	}
> +
> +	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601152951.1968=
59-1-imbrenda@linux.ibm.com?part=3D6
