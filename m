Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334055452B5
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078231; cv=none; b=TYFmWtrolgS2q+1ec3+6i4wSuSZEX4slXXrhC7Nj3f/N35kb8B5l3hkh9gXZygr1aKKvuS4A8dv4tSlwfTLmiitwJ4qQ1l2WCTSzcpuU0JRzuR5W1/ja4VD6lqoyAvVKSGFuwflosiKOPcK5knOZ7dt7Yd64haUF0J042308ls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078231; c=relaxed/simple;
	bh=Aj8aILyGj/n/CL5HB4nN4M2Nr1orzgPRl8/BvrPbotE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ttdI3clYfxvw0mswMHsoj68sFtgEyQZ+qS5Wx+BNZ3wyWyjcMKob2kXMTsVQUNwJkc9ZpL6YdoepO/fjqBO71h4TNo8txn6yeE855FoyIDlvH+snQqtjOfBNWR3H+CWf0DUAZUiY47qh23zsVEmUFHq8JvqcT5An//BMUd6Rpwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQPbIzkE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQPbIzkE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7481F000C4;
	Thu, 15 Oct 2026 15:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792078221;
	bh=nVB5LADnYVSgpMOf6D2+0jjD2w3pBD+E7ZNpQHYr2ig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EQPbIzkExtJz2XS2WdC+wczSI8fCwn0v2B0igUVrWsvFatsPLZeu7RQ3QG/MdrtVr
	 4LDlzeN8CtpnXVzVijcJjiXPbWnMHjbp5rEnJovoGGV1dHHIb5jMHHOWnuPvVsKgmX
	 fd7mxZT8n8WgGFtrWg8qshTZCOyXr4Hpx8TIT+6pJ4ZQ1UCOI+CF+Ohk7Gq7syLrSn
	 RLzcN5y/x8rweDY/d+iDBUmkRAEnQ52DxWMHRnXw6rohnYXV0pNHM02LrZsIGTPP3+
	 yU492HLKOhAzYcRK5MQwRBQyHupggpbiU5Yr6qtrIpBx8/8TrYLgRqPqdT93YsnIvo
	 TKeyHiaqHm8uw==
Message-ID: <sashiko-outbox-173073@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 15/20] attestation: Prepare provider and instance
 core
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261015145053.3664509-16-jiri@resnulli.us>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-16-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:30:21 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] attestation: Mixing guard() and goto in attestation_registry_ins=
ert
- [Low] attestation: ID space exhaustion due to non-recycling monotonic ind=
ex
--

commit f05c5cea6b4219fc6f6c64ba092550bdd10f870b
Author: Jiri Pirko <jiri@resnulli.us>

attestation: Prepare provider and instance core

Add provider validation, instance registration and lifecycle management for
the attestation family.

> diff --git a/drivers/attestation/core/core.c b/drivers/attestation/core/c=
ore.c
> new file mode 100644
> index 0000000000000..e112d3a0ff2b3
> --- /dev/null
> +++ b/drivers/attestation/core/core.c

[ ... ]

> +static int attestation_registry_insert(struct attestation *att)
> +{
> +	unsigned long index;
> +	void *old;
> +	int ret;
> +
> +	guard(mutex)
> +		(&attestation_registry_lock);
> +	if (attestation_next_index > UINT_MAX)
> +		return -ENOSPC;

[Severity: Low]
Because attestation_next_index is a monotonically increasing counter that is
never recycled upon instance unregistration, will this eventually exhaust t=
he
32-bit ID space after enough hotplug or module reload cycles, preventing any
new providers from registering until reboot?

Could we use ida_alloc() or xa_alloc() to safely allocate and recycle
identifiers instead?

> +	index =3D attestation_next_index;
> +	ret =3D xa_reserve(&attestation_instances, index, GFP_KERNEL);
> +	if (ret)
> +		return ret;
> +
> +	xa_lock(&attestation_instances);
> +	if (attestation_parent_exists(ctlv_device_parent(att->ctlvdev))) {
> +		__xa_erase(&attestation_instances, index);
> +		ret =3D -EEXIST;
> +		goto out_unlock;

[Severity: Medium]
Does this manual goto mix incorrectly with the scope-based guard(mutex)
declared at the start of this function?

According to the cleanup guidelines, using goto-based error handling in the
same function as scope-based cleanup creates confusing ownership semantics =
and
increases the risk of bugs.

Could the xa_lock() be converted to use scope-based cleanup (e.g.,
guard(spinlock)), or the goto be eliminated to align with the guidelines?

> +	}
> +	old =3D __xa_store(&attestation_instances, index, att, GFP_NOWAIT);
> +	ret =3D xa_err(old);
> +	if (!ret) {
> +		att->index =3D index;
> +		attestation_next_index++;
> +	}
> +out_unlock:
> +	xa_unlock(&attestation_instances);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015145053.3664=
509-1-jiri@resnulli.us?part=3D15
