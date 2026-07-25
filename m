Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48C32D3727
	for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 00:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784939726; cv=none; b=eJ1ESnX0DH+U6PSGZRDLmJFuXPC3nKCV5XbEXWRE428TJEBIFfCS2WIihIaQnf27aOOr4rotR+BjganN2lKVLZHqmXXmoUBeR24BIBMe7kSOIsJOpr/QTtBfz/5YN/o1or8L/xfqDx8HlCDA4Em1o0roOZrgiyusDqktpQLPK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784939726; c=relaxed/simple;
	bh=i8QQiEPepJGoxdvThp35XL1j3m4P0DuqwhLUBbtFpls=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PY8/PpS27f/QReRdt2qAd+D0gEjHoH0nmJ+ApSzjMe54XaIXwAIVVFZAuVCuPdCd6QPqpcqZAV6uRNox2TXrsoCZRR0OZfKQpp8TQkTIoXPlkPsgP9aQ+XmQ/yo/CuHjTGe8aUxBJldvpbTmU3sdcyjewGEGLsUgaVCvs/wuBOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQOChG3h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQOChG3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A10B1F00A3A;
	Sat, 25 Jul 2026 00:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784939725;
	bh=FTK+uZcWZX/9pv0uc8wIwkhEFtHI2noOObn/xJ11HQk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aQOChG3hRR8284BEalxF8ipa/p1GrOCshqcvEkzoySJm8w66Lpw5sWezFZhy70iy/
	 tP+JlwQBspTQZ7DfS5UgroUV7rFwga+yVdieqWzTRqwiTEt62la+7fD5B3Voun+Agz
	 sUZyJKA19+kt2iS74/T4gOeWxCo1aRk3bsQlS+S/f4tbD7Nf6u5KVJa9G4rfJZBO+R
	 i5VKIkZZrPx6tDvUcfg6x+2f2r3n6WaCTDKVMRRfq+nfO2mTSk85prjhsPxa9z95sv
	 gc7zq6dgtwMBTHCkIpDsHbvrXkgbN+2QiLxTE/h96CKGd4DpAfNoi163y3UVfiSM36
	 dTY1RcxdYL34w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/11] KVM: TDX: Allocate PAMT memory for TD and vCPU
 control structures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rick Edgecombe" <rick.p.edgecombe@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260725002302.3337017-7-rick.p.edgecombe@intel.com>
References: <20260725002302.3337017-1-rick.p.edgecombe@intel.com>
 <20260725002302.3337017-7-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 00:35:24 +0000
Message-Id: <20260725003525.5A10B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Acquiring `cpus_read_lock()` after holding `kvm->lock` and `kvm->s=
lots_lock` creates an ABBA deadlock risk.
--

--- Patch [6]: [PATCH v8 06/11] KVM: TDX: Allocate PAMT memory for TD and v=
CPU control structures ---
commit 777b107da8496af75d46b0c5bfc966aabe90a027
Author: Kiryl Shutsemau <kas@kernel.org>

KVM: TDX: Allocate PAMT memory for TD and vCPU control structures

This commit replaces raw page allocation and free functions with TDX control
page helpers for TD and vCPU control structures. This allows the operations
to properly handle Dynamic PAMT backing.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index d1af0a752e97e..528ebb3cb0389 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c

[ ... ]

> @@ -2472,7 +2472,7 @@ static int __tdx_td_init(struct kvm *kvm, struct td=
_params *td_params,
>  		goto free_tdr;
> =20
>  	for (i =3D 0; i < kvm_tdx->td.tdcs_nr_pages; i++) {
> -		tdcs_pages[i] =3D alloc_page(GFP_KERNEL_ACCOUNT);
> +		tdcs_pages[i] =3D tdx_alloc_control_page();
>  		if (!tdcs_pages[i])
>  			goto free_tdcs;
>  	}

[Severity: High]
This is a pre-existing issue, but does taking cpus_read_lock() inside this
function create an ABBA deadlock risk?

Looking at __tdx_td_init(), just a few lines below this allocation loop, the
code calls cpus_read_lock():

	for (i =3D 0; i < kvm_tdx->td.tdcs_nr_pages; i++) {
		tdcs_pages[i] =3D tdx_alloc_control_page();
		if (!tdcs_pages[i])
			goto free_tdcs;
	}

	if (!zalloc_cpumask_var(&packages, GFP_KERNEL))
		goto free_tdcs;

	cpus_read_lock();

This function is reached via a KVM_TDX_INIT_VM ioctl, which triggers
tdx_vm_ioctl(). That ioctl handler acquires the VM state locks using
CLASS(tdx_vm_state_guard, guard)(kvm) before calling __tdx_td_init().

Is it safe to acquire cpus_read_lock() while kvm->lock and kvm->slots_lock
are already held, or does this violate the KVM locking hierarchy where
cpus_read_lock() should be the outermost lock to prevent deadlocks against
CPU hotplug operations?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725002302.3337=
017-1-rick.p.edgecombe@intel.com?part=3D6
