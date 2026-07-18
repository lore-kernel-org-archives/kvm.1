Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A8335972
	for <kvm@vger.kernel.org>; Sat, 18 Jul 2026 02:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784340229; cv=none; b=GjvLZYkYdPtEA5rXb6rA4IBGXoSmxit+w4uMsqkGRqj/x90DFehY4bEnRiDpSpRklF+wHuB5XLG+bFyslNy7RsNY0nxBaSXDQ+Mk4577KKYqmX/4WoqQZ12520GU+YMzL/w9gcKJp22SrzZRZ7FsMf+q192mqE/I1sKV3ePvMuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784340229; c=relaxed/simple;
	bh=dlLL8O3UIuI16S7ryJ3lrcIVAPUSc6PzI/bDSNYwYGY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lqiKqA9q4xjqvSCBOb3C0sVB12aqq6B1VSHe5e3MZNkmUrUyYa/gOMofnwaGOrp7dbkJiApQFc067v/RdT9M6g6BMa4gADOUN+UY/juKWVFGikU14qewJYh/XsGfhmVaobzy2+Rj1Ek0SzrtzihdNUubGfNgF1eXeaaNg6VK7WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYdrjqf4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYdrjqf4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4221F000E9;
	Sat, 18 Jul 2026 02:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784340228;
	bh=kbfi1ioDdeD9RHD3E3ot8UENevLK2ePIw/RQUkWzJnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bYdrjqf4QWPoEtBT6n20exbrS7+xNC1r5ubeJy6tkqD6R3QatMfjpyuRkcsKl7k9d
	 0SKcDhl1myBWcC6C7piVThhd1UqRsnBHrfo1tIdqGhI6GrxYwOPfoRQaEGfKtQNh1j
	 uMO5S5xiEoPREoEG+k9+MnNdbTBjf8RXsMghcERsgCIT4tfn+zofF4vubP0/Fq2KkO
	 gfQ98uzKoY/wfvYMkN+N1agRs1omjB6bCp5HvyjTNagx2FGm8AaCiuCtsDdITKQwL5
	 LGOjPQnbfdTJa2Q8dhXQIb8wF6eb2RriARh4poqhUqZ+MRtXYJxYV5zqRxA0d3UHQc
	 8hNpkQxZ7hqIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/11] KVM: TDX: Allocate PAMT memory for TD and vCPU
 control structures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rick Edgecombe" <rick.p.edgecombe@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260718014500.2231262-7-rick.p.edgecombe@intel.com>
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
 <20260718014500.2231262-7-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 02:03:47 +0000
Message-Id: <20260718020348.3B4221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] cpus_read_lock() is acquired while holding kvm->lock, violating th=
e KVM lock ordering.
- [High] misc_cg_uncharge() is called unconditionally on the error path, un=
derflowing the cgroup limit when misc_cg_try_charge() fails.
--

--- Patch [6]: [PATCH v7 06/11] KVM: TDX: Allocate PAMT memory for TD and v=
CPU control structures ---
commit 16605575e9c07ab8d7ae8c15ce1e960fccfd95db
Author: Kiryl Shutsemau <kas@kernel.org>

KVM: TDX: Allocate PAMT memory for TD and vCPU control structures

Use control page helpers for allocating and freeing TD control structures,
such that these operations can work for Dynamic PAMT.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index d1af0a752e97e..528ebb3cb0389 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
[ ... ]
> @@ -2459,7 +2459,7 @@ static int __tdx_td_init(struct kvm *kvm, struct td=
_params *td_params,
> =20
>  	ret =3D -ENOMEM;
> =20
> -	tdr_page =3D alloc_page(GFP_KERNEL_ACCOUNT);
> +	tdr_page =3D tdx_alloc_control_page();
>  	if (!tdr_page)
>  		goto free_hkid;

[Severity: High]
This isn't a bug introduced by this patch, but doesn't jumping to free_hkid
when misc_cg_try_charge() fails result in an underflow?

If misc_cg_try_charge(MISC_CG_RES_TDX, kvm_tdx->misc_cg, 1) in
arch/x86/kvm/vmx/tdx.c:__tdx_td_init() fails, it jumps to free_hkid.
tdx_hkid_free() then unconditionally calls misc_cg_uncharge(), underflowing
the limit.

[Severity: High]
This is a pre-existing issue, but does calling cpus_read_lock() inside
__tdx_td_init() violate KVM lock ordering?

The KVM_TDX_INIT_VM ioctl acquires kvm->lock via tdx_vm_state_guard() in
arch/x86/kvm/vmx/tdx.c:tdx_vm_ioctl(), and then __tdx_td_init() calls
cpus_read_lock() while kvm->lock is already held. Can this create a reverse
locking dependency against CPU hotplug threads?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718014500.2231=
262-1-rick.p.edgecombe@intel.com?part=3D6
