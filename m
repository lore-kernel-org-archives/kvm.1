Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C434483814;
	Sun, 20 Sep 2026 21:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789941381; cv=none; b=AfbpLcwMGjG2ZbG3kUp1+359wRTKwxkprZ9uZxMKn5x6W7SFYnZwGkMURdm7z1I8KNmkEgTGnjIkiS+nXPK/7Kl4McateZMD6J9YwATn9ytPSwbPgC1qp0cxI86g4woO5jew8PiH9OvdoV/4GhNOxTKm2N9a82oar+PGiBhdxAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789941381; c=relaxed/simple;
	bh=eyWZimdW/+7lax5AzPHc2aviNrwivD1Pj7215EOxZt0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RKQdtN2bQbPsjYhQ8zMAehDs7HHcBujjDws7AzZmHOz5uCBW/xbZ6frHxu5TCthPgtRChZ2GKfl6AewJVj0P4exNfa4PkiZTMcwsufx8olGl7uC8Ko9t8hF68ieLA5WWK2rqN7YN+RNBPrzYjEwJxZoRUyMUU09bU2KgbbkyR8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVDhWMZK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVDhWMZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC0C1F000FF;
	Sun, 20 Sep 2026 21:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789941373;
	bh=OFqa6PPLT6iwGR3gh4b5Gebm2sF0nY27+oSrbzyfRzU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cVDhWMZKThFdVfC53WomA3ETWhmPnbRVZaHRiWCAkkY1eDkyy9C58dX+vaWgNVlRl
	 YxDdTao8urn5AeJElAm0tEpYQGbmPpEG6ebHK4/JE1+xY+uhMk5z9DrA5S3hmpDW9x
	 hoKMAk0jGB4zDoGzXYnGDNRBK09Zj5XKi9HuF1vetVFMfHM+krKCKfnX5Nv9Ck7Lbe
	 JgLbINGmklpH2FThfxBJddP4JXH9PEM2RU8nw7h8TOPj9lPY2gVNZQtzzoD93ohFKT
	 ImWUgfmehKatp7bir2wg/wfIMqiZ69cjiTpt2Oeq9OLwRyVO0zh5gS0lVjNlgRzKiM
	 GkRC7IctdIITQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/17] KVM: nVMX: Implement cache for L1 MSR bitmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260920211920.928306-11-dwmw2@infradead.org>
References: <20260920211920.928306-1-dwmw2@infradead.org>
 <20260920211920.928306-11-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 21:56:12 +0000
Message-Id: <20260920215613.1CC0C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kvm: nVMX: __kvm_gpc_init() re-initializes mutex on every VMXON
- [Medium] kvm: nVMX: gfn_to_pfn_cache breaks read-only L1 MSR bitmaps
--

commit 6f0690b4a89f3e0c76a94240889c416f2d71a8ec
Author: Fred Griffoul <fgriffo@amazon.co.uk>

KVM: nVMX: Implement cache for L1 MSR bitmap

This commit introduces a gfn_to_pfn_cache to optimize L1 MSR bitmap accesses
during L2 VM-entry, replacing individual map and unmap operations. The cache
is initialized on VMXON and deactivated when VMX operation ends.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 151873407abd3..5fe7e5d1f72d9 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c

[ ... ]

> @@ -759,11 +793,11 @@ static inline bool nested_vmx_prepare_msr_bitmap(st=
ruct kvm_vcpu *vcpu,
>  			return true;
>  	}
> =20
> -	CLASS(kvm_vcpu_map_local_readonly, m)(vcpu, gpa_to_gfn(vmcs12->msr_bitm=
ap));
> -	if (m.ret)
> +	idx =3D nested_gpc_lock(&vmx->nested.msr_bitmap_cache, vmcs12->msr_bitm=
ap);
> +	if (idx < 0)

[Severity: Medium]
Does this change break support for read-only L1 MSR bitmaps?

The previous code used kvm_vcpu_map_local_readonly(), which maps guest pages
without requesting write access. By switching to nested_gpc_lock(), the
underlying page lookup hardcodes FOLL_WRITE.

If the L1 hypervisor provides a read-only MSR bitmap, GPC activation will
fail here, causing KVM to silently fall back to software emulation for all
L2 MSR accesses.

>  		return false;
> =20
> -	msr_bitmap_l1 =3D (unsigned long *)m.map.hva;
> +	msr_bitmap_l1 =3D (unsigned long *)vmx->nested.msr_bitmap_cache.khva;
> =20
>  	/*
>  	 * To keep the control flow simple, pay eight 8-byte writes (sixteen

[ ... ]

> @@ -5443,6 +5479,9 @@ static int enter_vmx_operation(struct kvm_vcpu *vcp=
u)
> =20
>  	vmx->nested.vpid02 =3D allocate_vpid();
> =20
> +	/* KVM only ever reads the L1 MSR bitmap, so never mark it dirty. */
> +	__kvm_gpc_init(&vmx->nested.msr_bitmap_cache, vcpu->kvm, true, NULL, 0);

[Severity: High]
Does this re-initialize an active mutex on consecutive VMX transitions?

enter_vmx_operation() is called when the L1 guest executes VMXON, and
__kvm_gpc_init() calls mutex_init(&gpc->refresh_lock). When the guest
executes VMXOFF, free_nested() deactivates the cache but does not destroy
the mutex.

A subsequent VMXON will re-initialize the already active mutex, which
triggers lockdep/debugobjects warnings and can cause a host panic if
panic_on_warn is set.

> +
>  	/*
>  	 * Clear last_vpid to ensure that the VPID is flushed on the first
>  	 * nested VM-Enter. Otherwise, stale TLB entries from a previous life of

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920211920.9283=
06-1-dwmw2@infradead.org?part=3D10
