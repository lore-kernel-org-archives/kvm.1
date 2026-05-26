Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD16C329396
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 03:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779765266; cv=none; b=YexrDwG/hSPmM3g2Auz0a1sOdvc64X081x7WqUyQaBcMaJER695uR5PHc3oaiZIBdkeG4XJXNYNYr2wszdJHJqztvS8a25C+fNcABf4Ln1WjvCH607Jpg3rFZwae6wGm8bZ3/p2Xja79IzIBKYvfoR8pswTuvZVYyR4td2KMnzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779765266; c=relaxed/simple;
	bh=0zO3oiVbUZEIxrABAA7SknTYQrGlnLnzJrFR3K/t7Jg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bf7icSaPMV0X2zexOIrWUbyyCTlm6hnBZIu+WC71LQYsNPmSRRQedQqfmgh06dU94CELsdlvuO/73+pvRFlR+XUN7gA5JL6ZljX36caBKRC9IV4xpqG4sqxxELICwaVB/LTiHX0vMvdbgxrXFyrqf7c+XrMzkLPsmw49tfW8W/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POokM44d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POokM44d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443F71F000E9;
	Tue, 26 May 2026 03:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779765265;
	bh=3vQTzuzN9z+OEKIhxoS4fk+Xjv1/LsOKFApVMgJIteo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=POokM44dutPdmjqqCFQRLlK3oklkIq3gLI4OLUf0RjywR2UeMgBrvH+5h69Ti19Mh
	 83Y2xetKy32ZIi+2nzzOwfT24dLz2D1Y7wuw8SF6F8YpsPoabKOWQjJupUvCL80IB4
	 itXNMqba10CPA3AesKKXKW6RbMJhUTdcDshWVCXqUevarmzcMbj6F542ytXUGiz6zD
	 syUv/OqXjEoo9UBfBpsOVL1WWfQyPaITf+OnwSZC4B6XBj9ZsSCfC90e7JbKSZiFf7
	 M3ttS9fMjX+5UQ8pMsxC2hiOgpsGAiLrLa4rSINmy5mh7AwYydTBP+dROgKhm3NE9x
	 bYp8kJIbpwbtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/3] KVM: s390: Enable adapter_indicators_set to use
 mapped pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Douglas Freimuth" <freimuth@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526015323.207343-3-freimuth@linux.ibm.com>
References: <20260526015323.207343-3-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 03:14:24 +0000
Message-Id: <20260526031425.443F71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] A userspace-triggerable WARN_ON_ONCE can crash the host kernel.
- [High] Loss of atomicity leads to partially updated, inconsistent guest a=
dapter indicators on mapping failure.
- [High] The fast path for long-term mapped pages skips KVM dirty page trac=
king, breaking live migration.
--

commit d5dc6d5087f20c38643d53d19e20548f19464244
Author: Douglas Freimuth <freimuth@linux.ibm.com>

KVM: s390: Enable adapter_indicators_set to use mapped pages

This commit optimizes the s390 adapter_indicators_set function to use
long-term mapped pages when available. If adapter indicator pages are
not mapped, local mapping is done on a slow path.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 8c44ed20651b7..23f578e7b9dce 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c

[ ... ]

> @@ -2885,41 +2885,80 @@ static unsigned long get_ind_bit(__u64 addr, unsi=
gned long bit_nr, bool swap)
>  static int adapter_indicators_set(struct kvm *kvm,
>  				  struct s390_io_adapter *adapter,
>  				  struct kvm_s390_adapter_int *adapter_int)
>  {

[ ... ]

> +	} else {
> +		map =3D page_address(ind_info->page);
> +		bit =3D get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->=
swap);
> +		set_bit(bit, map);

[Severity: High]
Does this fast path need to track dirty pages for live migration?

The slow path calls mark_page_dirty() and set_page_dirty_lock() after
setting the bit, but this mapped-page fast path modifies guest memory
directly via set_bit() without updating KVM's dirty logging bitmap.

Could this leave the destination host with stale indicator states after a
live migration?

> +		spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +	}
> +	spin_lock_irqsave(&adapter->maps_lock, flags);
> +	summary_info =3D get_map_info(adapter, adapter_int->summary_addr);
> +	if (!summary_info) {
> +		spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +		summary_page =3D pin_map_page(kvm, adapter_int->summary_addr, 0);

[Severity: High]
Could this lead to a partially updated adapter state if the summary page
fails to map?

The original code atomically pinned both the indicator and summary pages
before making any modifications. Here, if pin_map_page() fails for the
summary page, the function aborts and returns -1, but the indicator bit
was already set in the preceding block and is not rolled back.

Can this result in the indicator being set without a corresponding summary
bit, potentially causing lost events and I/O hangs?

> +		if (WARN_ON_ONCE(!summary_page))

[Severity: High]
Can a malicious userspace process trigger this WARN_ON_ONCE?

Since the summary_addr is provided by userspace (e.g., via QEMU setting up
routing entries), an unprivileged process might be able to intentionally
unmap the memory to force pin_map_page() to fail.

If panic_on_warn is enabled in a production environment, could this action
crash the host kernel?

> +			return -1;
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

[Severity: High]
Similarly, is dirty page tracking missing here for the summary page fast
path, bypassing KVM's dirty logging bitmap?

> +		spin_unlock_irqrestore(&adapter->maps_lock, flags);
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526015323.2073=
43-1-freimuth@linux.ibm.com?part=3D2
