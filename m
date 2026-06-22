Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07183438A7
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154880; cv=none; b=k6LYZn4pOQT+wWgh2M7oajozRNbsnGytFzUZk8e+zaRAhAfqkZCA3ClvDRZs8opPxncqYC0COGWiyObXkAqDn++oK6Av8miUNoiY6w8dcVi2ZkCojSnjnBNQYkv0ZcKbX+CxdmwkYmIy2G45hi8BcBd+Zn/vcHd6ls+o1S0bFm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154880; c=relaxed/simple;
	bh=Ep/XnTHZTii2jnrwtld34R2Gh++x78ZXsQSvggjaA4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xi99/NDS8rG8jONVTtbZESuYq4a9TEyIWwnj97LxcKMr13uDUrqBq9XhZIzvT15kG2CI147lDt5T7lGm+bX/nHJ3ZZfropFIL3LHRUaCLlX/RfND+XVQc0Jj74oqNsDlm2WGj+fESNbpBUJFiNVtb7PSJGTWrlZ/UzkYaoT2akA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRz4SnHd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRz4SnHd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690A11F000E9;
	Mon, 22 Jun 2026 19:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782154879;
	bh=DjmqMO0MKPZ6exbwmBc5MtKmk4A6iHzP0t66Edt6p7Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DRz4SnHdDSTeYGN+l3+6dl26vBSs9d2FV2NrydMvIHR/ItNofxmdJjFrzEMOiOr0O
	 KiO6F5m5uoPJzqOcpTrvedRuVUfvfdwRmFEhuEwgL7WQtc9dPBgGXxrLZXKa5BnSf8
	 9qenBGIR/F+PxYG8lepdAeXquwvCIW9xz7WnsgYVwRcU1ob1bGXykLVrhbhth1DqQp
	 3GM0VZ+zp/ILzG7YSir1z/hIbjG1HJWQ73bmewpj3dhNeO/QCwmPxPIJPHLpocRVoR
	 LlJKEF3Yyt22FK06Jl6Ri6zw/lkj6YlKVEYMKVRoNdp1eXyhRuOdMUNFruCzKcsEtv
	 4X4SdHCxOoPxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/9] kvm: Prepare core VM structs and helpers for LUO
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260622184851.2309827-3-tarunsahu@google.com>
References: <20260622184851.2309827-1-tarunsahu@google.com>
 <20260622184851.2309827-3-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 19:01:18 +0000
Message-Id: <20260622190119.690A11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing `__rcu` annotation for the `vm_file` field in `struct kvm`.
--

commit 742b05343deb7763672dc99dce96c4773cc18720
Author: Tarun Sahu <tarunsahu@google.com>

kvm: Prepare core VM structs and helpers for LUO support

This commit introduces core infrastructure to support VM preservation with
LUO. It refactors VM file creation into a unified kvm_create_vm_file()
helper and tracks a weak reference to the backing file in struct kvm to
enable reverse file resolution.

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
[ ... ]
> @@ -874,6 +874,18 @@ struct kvm {
>  #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
>  	/* Protected by slots_lock (for writes) and RCU (for reads) */
>  	struct xarray mem_attr_array;
> +#endif
> +#ifdef CONFIG_LIVEUPDATE_GUEST_MEMFD
> +	/*
> +	 * Weak reference to the VFS file backing this KVM instance. Stored
> +	 * without incrementing the file refcount to prevent a circular lifetime
> +	 * dependency (since file->private_data already pins this struct kvm).
> +	 * Used exclusively to resolve the file pointer back from struct kvm.
> +	 *
> +	 * Written/cleared via rcu_assign_pointer() and read locklessly under
> +	 * RCU (e.g. via get_file_active() to prevent ABA races).
> +	 */
> +	struct file *vm_file;

[Severity: Low]
Should this pointer be annotated with __rcu?

It is documented as being read locklessly under RCU and is updated using
rcu_assign_pointer() below. Without the annotation, sparse static analysis
will likely generate warnings about incorrect types and different address
spaces when the pointer is updated.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
> +struct file *kvm_create_vm_file(unsigned long type, const char *fdname)
> +{
[ ... ]
> +#ifdef CONFIG_LIVEUPDATE_GUEST_MEMFD
> +	/*
> +	 * Weak reference to the file (without get_file()) to prevent a circular
> +	 * dependency. Safe because the file's release path clears this pointer
> +	 * and drops its reference to the VM.
> +	 *
> +	 * Written via rcu_assign_pointer() because the pointer can be read
> +	 * locklessly under RCU (e.g., in kvm_gmem_luo_preserve() via
> +	 * get_file_active() to prevent lockless ABA races).
> +	 */
> +	rcu_assign_pointer(kvm->vm_file, file);

[Severity: Low]
Since kvm->vm_file is updated here in kvm_create_vm_file() using
rcu_assign_pointer(), does the member in struct kvm require the __rcu
modifier to prevent sparse warnings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622184851.2309=
827-1-tarunsahu@google.com?part=3D2
