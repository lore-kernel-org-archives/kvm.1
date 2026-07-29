Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF6B469830
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345469; cv=none; b=pnRFLU9QqZYkTBvzNeh0ZhX4Zt+zeZvdfF0NSh1ylPYBm7WgkBYAjzomdosr4vAWmqz4me3pq4Zzu2z4aDeyz7w/GrlCN77Pt4nhPWaQk+GaOzV44SNuiFbicINAkHyh74craCohlLAcxiLCKCEmo7RnGMXKibGDpmH1Gmq4VJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345469; c=relaxed/simple;
	bh=tiKMZwS/IuaSdZIC3D/Q+VBsDGa5TvuTAMrduvo4r9E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rYSCSb4WPkpFjzBddgS02TZ5OOJiOGyuXSXzwLYCqdHVwWsYDDfaVkagdOTGR3KCsIQ0RBr0kvys8BYg9eY3T1DhEmne4UJAErqJ98/I5n5jv4uIsLEzTYIv9+3K6+jrMSbg56QStpXnTMqAot2M4E07UsbxLSpVmxJ2nS5Th4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIsf5+Qg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIsf5+Qg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF28E1F000E9;
	Wed, 29 Jul 2026 17:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785345468;
	bh=SR5qeU7SyfG6ziE1ipdwtimCpR1ONA+ce26Ts9CMGls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KIsf5+QgYOmy7ZyjnU5qFLEajyKWC910XyOFvwkdoi7bP7YM/yT0UvA6Or2c/rpab
	 Rs+TKEh/rEcycEJXyZUHtCOSABrbQCypXejC4xJvgyOlsCV8XzJJKA6ohv+O4970Zh
	 OFPF/uyz5GeMThbWWmr+MRTswdazWm1tqLnUZA3/7YLZNn86h7pmYfhZXF6Gqm2f09
	 XYYaPPNNRpnCL8F7DzWtlgnBKirUOLfUhCQcRYbPl97GmyuMKRT9jbyZCJPUnvGWXr
	 yJBNkygeIaZoDSJWuj4ewcIyvu65hTPl8RR8cIH4Pge07PAOhX2kvomC2Z+KZ5MEGS
	 8ZHvtAuViqiRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: have hva_to_pfn_remapped write-upgrade PTEs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729014223.17937-1-slp@redhat.com>
References: <20260729014223.17937-1-slp@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 17:17:47 +0000
Message-Id: <20260729171747.CF28E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for VM_PFNMAP write-upgrades, bypassing already-pop=
ulated read-only PTEs
--

--- Patch [1]: [PATCH] KVM: have hva_to_pfn_remapped write-upgrade PTEs ---
commit 8ea7b308a68b0aabea9b703efac8ec9af51170aa
Author: Sergio Lopez <slp@redhat.com>
Subject: KVM: have hva_to_pfn_remapped write-upgrade PTEs

This patch introduces a second fixup_user_fault call to handle
write-upgrades for VM_PFNMAP mappings that install read-only PTEs on
write faults (such as DRM GEM BOs).

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index b4baa69a55402..b7fb9278f198b 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2958,6 +2958,8 @@ static int hva_to_pfn_remapped(struct vm_area_struc=
t *vma,
[ ... ]
>  	r =3D follow_pfnmap_start(&args);
>  	if (r) {
>  		/*
>  		 * get_user_pages fails for VM_IO and VM_PFNMAP vmas and does
>  		 * not call the fault handler, so do it here.
>  		 */
>  		bool unlocked =3D false;
> +		bool write_upgrade =3D false;
> +do_write_upgrade:
>  		r =3D fixup_user_fault(current->mm, kfp->hva,
>  				     (write_fault ? FAULT_FLAG_WRITE : 0),
>  				     &unlocked);
> @@ -2969,6 +2971,17 @@ static int hva_to_pfn_remapped(struct vm_area_stru=
ct *vma,
>  		r =3D follow_pfnmap_start(&args);
>  		if (r)
>  			return r;
> +
> +		if (write_fault && !args.writable && !write_upgrade) {
> +			/*
> +			 * VM_PFNMAP fault handlers may install read-only PTEs
> +			 * via vmf_insert_pfn(), deferring the write upgrade to
> +			 * a second fault. Trigger that upgrade now.
> +			 */
> +			write_upgrade =3D true;
> +			follow_pfnmap_end(&args);
> +			goto do_write_upgrade;
> +		}
>  	}
> =20
>  	if (write_fault && !args.writable) {
        ^^^^

[Severity: High]
This is a pre-existing issue, but does this placement miss the case where
the PTE is already populated but read-only?

If a guest first reads from the DRM GEM BO, triggering a read fault, the
DRM GEM fault handler installs a read-only PTE. If the guest later attempts
to write to the same page, hva_to_pfn_remapped() calls follow_pfnmap_start(=
),
which finds the read-only PTE and returns 0 (success).

Since r =3D=3D 0, the entire if (r) block containing the new write upgrade =
logic
is bypassed. The code then reaches this check and incorrectly returns
KVM_PFN_ERR_RO_FAULT instead of performing the write upgrade.

Should the upgrade logic be placed outside of the if (r) block so it can al=
so
handle already-populated read-only PTEs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729014223.1793=
7-1-slp@redhat.com?part=3D1
