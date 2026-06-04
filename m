Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8CC3C09FB
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602149; cv=none; b=X7C7hXetUbbkkfVd8hlv1Z9G/GzXXiVVKhFJtCHcyoipV0pAI6jR7mTBpkXtErazu8JppBn4DPPv3UQPljfHKvnXn6hUi2r+9QMHj+oQTWH4s0keRXRCyhd70VtolSkVYaAzPF29mtHCr1WJV2Ca+sI7Aj+ncN4AbbCAnmO19LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602149; c=relaxed/simple;
	bh=G0BFi7dDU7RUWTvl0GR4QOh9jQwYMvWi7nKgww5BxXs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wg+a7ONKAfQULyCtNSwjgt8eacp33vtXSkuRrs0n8JuhcXUxdhKJSVOXsez144nMC6KAZqyVOBs+qRSjFgtmoL//s30iz28DlrA9qALaXg1z40lrrlaYOoWB9lBJNy/PWTUNYDDvJE9e+w4W2YtwUfXkOnHMlTIE697hrNp1q/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFW0dxmz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFW0dxmz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA881F00893;
	Thu,  4 Jun 2026 19:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780602147;
	bh=FEoNyUW8jBGADVPxt7Ra5DhC9kW/epJpVBhaAQCVCu0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WFW0dxmzh4oPoGfgw6fAUT2doAWfPnGy5KzMr5wUAqvBMmHrRtyNwMcMWzijdY0pT
	 M7i71pQcBFPVgIyLVHsRPgTLjqaqpOX/AgwL6MMDPG0JJ71mEnsfU1nVYLOO6+gCgl
	 1Wrl1MXbzS9cfSsyGkoHgA37NpTtRUTbXO+AHW3c1TiAHyJEL/pMMcSFeBnfnBDXx6
	 fAZB4m0Cl9XlXYZSHMZYHUpf1z9KbPGTKS7Jxk8XIBA2bv+y6M6FFy0zUaoE1/hvtH
	 WQbv6PddPPgzWpsdLn8iuubrq1dl6Ubhh+25MglmgpQoHJFA4neHQo6UYLuVwBLigJ
	 PxaqKofAVnHwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/3] KVM: s390: Enable adapter_indicators_set to use
 mapped pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Douglas Freimuth" <freimuth@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604192755.203143-3-freimuth@linux.ibm.com>
References: <20260604192755.203143-3-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 19:42:26 +0000
Message-Id: <20260604194227.5CA881F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Host-userspace reachable WARN_ON_ONCE when pinning the summary pag=
e fails.
- [High] Broken atomicity: The indicator bit is set in guest memory before =
validating the summary page, leaving the guest in an inconsistent state on =
error.
- [High] The fast path for long-term mapped adapter indicators modifies gue=
st memory without updating KVM's dirty page tracking, breaking live migrati=
on.
--

commit eab5dd8ef6ef5a366acb6ed92a72330259c39430
Author: Douglas Freimuth <freimuth@linux.ibm.com>
KVM: s390: Enable adapter_indicators_set to use mapped pages

This commit optimizes the s390 adapter_indicators_set function to use
long-term mapped pages when available. It introduces a fast path that opera=
tes
under a spinlock, falling back to the existing pin-and-map slow path if
the mapped pages are not found.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index d066a282271e2..b5304816aaa04 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
[ ... ]
> @@ -2892,41 +2892,80 @@ static unsigned long get_ind_bit(__u64 addr, unsi=
gned long bit_nr, bool swap)
[ ... ]
>  static int adapter_indicators_set(struct kvm *kvm,
>  				  struct s390_io_adapter *adapter,
>  				  struct kvm_s390_adapter_int *adapter_int)
>  {
[ ... ]
> +	spin_lock_irqsave(&adapter->maps_lock, flags);
> +	ind_info =3D get_map_info(adapter, adapter_int->ind_addr);
> +	if (!ind_info) {
> +		spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +		ind_page =3D pin_map_page(kvm, adapter_int->ind_addr, 0);
> +		if (!ind_page)
> +			return -1;
> +		idx =3D srcu_read_lock(&kvm->srcu);
> +		map =3D page_address(ind_page);
> +		bit =3D get_ind_bit(adapter_int->ind_addr,
> +				  adapter_int->ind_offset, adapter->swap);
> +		set_bit(bit, map);

[Severity: High]
If the indicator bit is set here, but the subsequent attempt to resolve or =
pin=20
the summary page fails and the function returns -1, does this code leave the
indicator bit permanently set in guest memory?

Prior to this patch, both pages were successfully pinned before any bits we=
re
mutated, ensuring an all-or-nothing update.

> +		mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
> +		set_page_dirty_lock(ind_page);
> +		srcu_read_unlock(&kvm->srcu, idx);
> +		unpin_user_page(ind_page);
> +	} else {
> +		map =3D page_address(ind_info->page);
> +		bit =3D get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->=
swap);
> +		set_bit(bit, map);
> +		spin_unlock_irqrestore(&adapter->maps_lock, flags);

[Severity: High]
By modifying the long-term mapped adapter indicator directly in the host=20
virtual mapping, does this bypass KVM's dirty page tracking?

The slow path calls mark_page_dirty() and set_page_dirty_lock(), but the fa=
st=20
path skips them. Could this cause the migrated guest to lose interrupt=20
delivery notifications if the updated indicator pages are not transferred t=
o=20
the destination VM?

> +	}
> +	spin_lock_irqsave(&adapter->maps_lock, flags);
> +	summary_info =3D get_map_info(adapter, adapter_int->summary_addr);
> +	if (!summary_info) {
> +		spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +		summary_page =3D pin_map_page(kvm, adapter_int->summary_addr, 0);
> +		if (WARN_ON_ONCE(!summary_page))
> +			return -1;

[Severity: High]
Since the summary address is derived from guest-controlled KVM routing entr=
ies=20
and managed by host userspace, could a malicious or misbehaving userspace=20
process trigger this warning by unmapping the memory or providing an invali=
d=20
address?

The KVM subsystem guidelines note that asserts whose conditions can be driv=
en=20
by unprivileged host userspace are a host-side denial of service, especiall=
y=20
if panic_on_warn is enabled. Is it better to just return -1 here without th=
e=20
warning?

> +		idx =3D srcu_read_lock(&kvm->srcu);
> +		map =3D page_address(summary_page);
> +		bit =3D get_ind_bit(adapter_int->summary_addr,
> +				  adapter_int->summary_offset, adapter->swap);
> +		summary_set =3D test_and_set_bit(bit, map);
> +		mark_page_dirty(kvm, adapter_int->summary_gaddr >> PAGE_SHIFT);
> +		set_page_dirty_lock(summary_page);
> +		srcu_read_unlock(&kvm->srcu, idx);
> +		unpin_user_page(summary_page);
> +	} else {
> +		map =3D page_address(summary_info->page);
> +		bit =3D get_ind_bit(summary_info->addr, adapter_int->summary_offset,
> +				  adapter->swap);
> +		summary_set =3D test_and_set_bit(bit, map);
> +		spin_unlock_irqrestore(&adapter->maps_lock, flags);

[Severity: High]
Similar to the indicator page fast path above, does this code also bypass K=
VM
dirty page tracking for the summary page when a mapped info structure is fo=
und?

>  	}
> =20
> -	idx =3D srcu_read_lock(&kvm->srcu);
> -	map =3D page_address(ind_page);
> -	bit =3D get_ind_bit(adapter_int->ind_addr,
> -			  adapter_int->ind_offset, adapter->swap);
> -	set_bit(bit, map);
> -	mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
> -	set_page_dirty_lock(ind_page);
> -	map =3D page_address(summary_page);
> -	bit =3D get_ind_bit(adapter_int->summary_addr,
> -			  adapter_int->summary_offset, adapter->swap);
> -	summary_set =3D test_and_set_bit(bit, map);
> -	mark_page_dirty(kvm, adapter_int->summary_gaddr >> PAGE_SHIFT);
> -	set_page_dirty_lock(summary_page);
> -	srcu_read_unlock(&kvm->srcu, idx);
> -
> -	unpin_user_page(ind_page);
> -	unpin_user_page(summary_page);
>  	return summary_set ? 0 : 1;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604192755.2031=
43-1-freimuth@linux.ibm.com?part=3D2
