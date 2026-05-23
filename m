Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D45C1CBEB9
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 00:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779497949; cv=none; b=qmRfagosqZ41UBZFyryXBWBIMCICBgDEffRqnv2wimLcRlaLV9xYuRTCJnZhbHf4M/HadEKpBfEM0vFaNxGa2PXiCmi3zYFecXcmo6skwfTyNMbpAZGxLJJ39VTuQ8ibo73oD2tSx/O+UNV2NxgpjYIMxuf6LK8DF+3UtdaiJFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779497949; c=relaxed/simple;
	bh=zfqeFk5vjCCH1q+1ez2A2ZOtK+wNGGM+SdhOhWoNJcI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nJVbpwk+mD9b5zSgZL9EJ9X4Z9HrvEDQJecUJBDX7uWGTd2RhmS+FlQQJyLnsHqAe64Rir4A9n+WwKVpRY5CDjooz/4UWRe+oeQjaIMbuXuh8DzOxibFX6olODZFpXP7xScWnxy9GSp5pVZXKmTbLpN4HvmaHO2qZq7n1Gik7g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUmAwVCS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUmAwVCS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4BE1F000E9;
	Sat, 23 May 2026 00:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779497948;
	bh=xE5gmc8BQ1Muk2vbETdbRQQxEYV7HszCqTmd8NWkF3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TUmAwVCSEcD+eXHIc7Xf9pFk35fsmYC/09qrDf5Z3LZqdnN5Ijq5NleANkgh5YhZO
	 Vc/LxZImkTutnv59r63d7fM0PQKT9R7ncI0uYNjLeporkGeVgV+fjs+YdH/+zVbFwu
	 En+M4qAsjhhD/65IKLHHV6lLsKAlL6va2kJAsfvZWd+1vwYkJtYGum1ktrRH2gx2bJ
	 3NM5JAigJYcp7buPDo6ZWlEOXUXWVCYp/pjzQnRGe3r5nzE7uPQwOJNhcWwAUDtYMe
	 FsEqsv8sdTheRAYkbR15BEMx5ipYiM5B8Z3M2rmDLw3KIdFjRJuObdrBWwIpRw3CvG
	 bwGebrcfQxZ8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/42] KVM: guest_memfd: Update kvm_gmem_populate()
 to use gmem attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260522-gmem-inplace-conversion-v7-6-2f0fae496530@google.com>
References: <20260522-gmem-inplace-conversion-v7-6-2f0fae496530@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 00:59:07 +0000
Message-Id: <20260523005908.0F4BE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm_gmem_range_is_private() uses an exact equality check for KVM=
_MEMORY_ATTRIBUTE_PRIVATE, which will fail if memory attributes are combine=
d.
--

commit 1b34d7cad86326fff0f76b5602a4419246f71f2f
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Update kvm_gmem_populate() to use gmem attributes

Update the guest_memfd populate() flow to pull memory attributes from the
gmem instance instead of the VM when KVM is not configured to track
shared/private status in the VM. Rename the per-VM API to clarify it is
for per-VM attributes.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index f055e058a3f28..9d025f518c025 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
[ ... ]
> @@ -924,12 +924,31 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_me=
mory_slot *slot,
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
> =20
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
> +static bool kvm_gmem_range_is_private(struct gmem_inode *gi, pgoff_t ind=
ex,
> +				      size_t nr_pages, struct kvm *kvm, gfn_t gfn)
> +{
> +	pgoff_t end =3D index + nr_pages - 1;
> +	void *entry;
> +
> +	if (vm_memory_attributes)
> +		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
> +						       KVM_MEMORY_ATTRIBUTE_PRIVATE,
> +						       KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +
> +	mt_for_each(&gi->attributes, entry, index, end) {
> +		if (xa_to_value(entry) !=3D KVM_MEMORY_ATTRIBUTE_PRIVATE)

[Severity: Medium]
Since memory attributes are implemented as bitmasks, could this exact
equality check incorrectly reject the range if other attribute bits are set
alongside the private bit in the future?

When vm_memory_attributes is true, the generic path
kvm_range_has_vm_memory_attributes() correctly applies a bitwise AND mask.

Would it be safer to check !(xa_to_value(entry) & KVM_MEMORY_ATTRIBUTE_PRIV=
ATE)
here to ensure behavioral consistency and avoid rejecting valid private ran=
ges?

> +			return false;
> +	}
> +
> +	return true;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-gmem-inpla=
ce-conversion-v7-0-2f0fae496530@google.com?part=3D6
