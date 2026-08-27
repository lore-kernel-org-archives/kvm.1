Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEE943A7E9
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787829435; cv=none; b=iESyLU+61+mdY1ux8OlldYLg+4GAvNVXxY/gGWLgzamWAczGQ/p1MeGKCwHPMj3hkgkD9EdouiPOJWLn6w/+w1PPLfeb0SZF9dUD1Sf2HWDOR9gnhjWQEOyznM0Z86Z0qY0k2zw/4/YVaExWLxoJR30FJ1KG8j1DvJ4m4XR3bqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787829435; c=relaxed/simple;
	bh=P+n7t1lgDLepCUh6QK0CJBLUoi/QVnmD37Pp3bbMScU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oLfH8Xz4wIwkk9TQjEkcnRLAicQD0kwZ8wEc2byGgZW4MvQ/2GqLJ/udq99BjUYCyFpoJ57YsFWdvBkQfzMV/7EogY6ewJfkKes424sYRXGUm5FOiyCsMZiu+CrTF/vUEHgAHbPMEj6chxNNyf4oZKgdJti5IsA8e+7fy2zb33A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmoPHhsZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmoPHhsZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860791F000E9;
	Thu, 27 Aug 2026 11:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787829425;
	bh=mCgiuu9Tc7EirM0QmHma2GvPOcCRqwf+MFqZ84T4WhE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VmoPHhsZBbleqko8zyQvhjUus2VexBVdg72lf+Xw5MerOaxveGi2S0WYucRRHUDb3
	 o7r+CH1Kr/UhXaUteCWLZXicl+nSYBb7TOvAzGbYnGT4kd/za1eZlebiLvfH+krNgu
	 TG6UJSXRMFvgzIPGA2hebdb+pk5W/acWs8s9RlCQ4D59NfCfrJNh6gIlVmJgMl+nFp
	 SknYTKHN+BVbQyNS12hONG/ZpRvEGYRICIvBrfblrBru2kJxYv67PaDZpknhAXYmTj
	 0IreM530LviEMJHSbmA+bWYKLz5ZACrEZwJ8StCSYHfzZa/PlvK9+43vgh34e+IGc0
	 yxq1gVIngCU7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: Release reserved xarray entries if reserving
 memory attributes fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zeng Chi" <zeng_chi911@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260827110558.457891-1-zeng_chi911@163.com>
References: <20260827110558.457891-1-zeng_chi911@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 11:17:05 +0000
Message-Id: <20260827111705.860791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The error cleanup loop in `kvm_vm_set_mem_attributes` lacks a `con=
d_resched()` call, which can cause CPU soft lockups when reverting a massiv=
e memory range.
--

commit 628b8d791b455e8fdc196cf53b9e1f82e2d7fdb6
Author: Zeng Chi <zengchi@kylinos.cn>

KVM: Release reserved xarray entries if reserving memory attributes fails

This commit fixes a memory leak in kvm_vm_set_mem_attributes() where previo=
usly
reserved xarray entries were left behind if a subsequent reservation failed=
. It
adds a backward loop to release the successfully reserved entries before ba=
iling
out on the error path.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2575,8 +2575,11 @@ static int kvm_vm_set_mem_attributes(struct kvm *k=
vm, gfn_t start, gfn_t end,
>  	 */
>  	for (i =3D start; i < end; i++) {
>  		r =3D xa_reserve(&kvm->mem_attr_array, i, GFP_KERNEL_ACCOUNT);
> -		if (r)
> +		if (r) {
> +			while (i-- > start)
> +				xa_release(&kvm->mem_attr_array, i);

[Severity: High]
Can this backward cleanup loop cause CPU soft lockups if a massive memory
range was requested?

The forward loop correctly yields the CPU via cond_resched() to handle large
ranges, but the unwinding error path does not.=20

If userspace invokes KVM_SET_MEMORY_ATTRIBUTES on a massive range and
xa_reserve() eventually fails, this loop will continuously process potentia=
lly
millions of entries. On kernels with CONFIG_PREEMPT_VOLUNTARY or
CONFIG_PREEMPT_NONE, could this block scheduling long enough to trigger the
soft lockup watchdog?

>  			goto out_unlock;
> +		}
> =20
>  		cond_resched();
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827110558.4578=
91-1-zeng_chi911@163.com?part=3D1
