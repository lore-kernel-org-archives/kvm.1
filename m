Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5998E40F756
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787913663; cv=none; b=gq21b1+wfv5rh2eLdkoKkjW3lsL//XlsVsba5bfWcHhOfnf4Xo9kbhrIs6PqQEFx1r1hHcu3ryJQsHMedOGAqGgizIIwftatdaplUYw4DT0pfkNf6ljFfcLCZlVeBJ5SlsdhJLgb9I+hn4AizL1043ZWYKvA7y9KESfI/XU78K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787913663; c=relaxed/simple;
	bh=JsIQxlq+ETww1z9F08buiTiqpXWtWpC71YYfT+yzelM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aDUM/upYs2IeYLyICHZtyv1yw4o074uWpN0FI2WFWlYkP18TbhWPgWD5NpqR8JOhfPK7XrNyavqIPuqdPCHiuGyTmYh2wlE3Ysu+9SGSOVvrO9vlVnpZIdTdXx9Z53gjDgNan/MeHIe3MCs7bbCn8LCI+AUDxfIyjYxXgWXOmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rr0d/OxW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rr0d/OxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E45F1F000E9;
	Fri, 28 Aug 2026 10:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787913661;
	bh=TX7+KDDdggSUwfPJKocGhTEyHcyMBPpVQ1XBe7pnhD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rr0d/OxWo7THd9eNuzsn1lgF+BdsxD3n0akJWYNDPAwxIXExNRjlx22AXU8WN9qLk
	 68++IBpv6itc7/6jOj4ItWObmFWdP27qmqOinTR11u175ontFXjFYSngzfDd444ksH
	 wwjA3WjnRVBKubrxSn0YglYg2buJW0dQgPw+WW6Oe8AZxGFiDPhdrsvLmlpLviVcqu
	 efRpaCvbODqtubukzLhsyBeoEdTpeqsonmSUxaPRT+J5zp7QCKvLk9EnBq6AGyoxGN
	 l78nigx3e2eq1/sun7uwHREWDgq8aFMD+cllS6px6Esq9V8srKO8g46ujWgHrhAh2b
	 X/4zirGNv3pIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: Don't treat reserved xarray entries as having
 memory attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zeng Chi" <zeng_chi911@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260828102728.1308266-1-zeng_chi911@163.com>
References: <apCD3F3oOyC6E5oN@google.com>
 <20260828102728.1308266-1-zeng_chi911@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 10:41:01 +0000
Message-Id: <20260828104101.9E45F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing XArray retry handling causes spurious memory attribute p=
resence reporting
--

commit 4066b9047c8a4867ec41a5a11e687a69b4773334
Author: Zeng Chi <zengchi@kylinos.cn>

KVM: Don't treat reserved xarray entries as having memory attributes

This commit fixes a bug in KVM where failed xarray reservations leave zero
entries in the attributes array, causing fully shared memory ranges to be
incorrectly reported as having mixed attributes. It modifies the attribute
check to explicitly skip zero entries when checking if a range is empty.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 65eb26a0520d8..29534bcc7f020 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
> @@ -2447,8 +2447,19 @@ bool kvm_range_has_memory_attributes(struct kvm *k=
vm, gfn_t start, gfn_t end,
>  		return (kvm_get_memory_attributes(kvm, start) & mask) =3D=3D attrs;
> =20
>  	guard(rcu)();
> -	if (!attrs)
> -		return !xas_find(&xas, end - 1);
> +	if (!attrs) {
> +		/*
> +		 * Reserved but unset entries (XA_ZERO_ENTRY, e.g. left behind by
> +		 * a failed reservation in kvm_vm_set_mem_attributes()) are
> +		 * returned as present by xas_find(), but hold no attributes.
> +		 * Skip them so that the range is correctly reported as having no
> +		 * attributes.
> +		 */
> +		xas_for_each(&xas, entry, end - 1)
> +			if (!xa_is_zero(entry))
> +				return false;

[Severity: Medium]
Does this lockless loop need to handle XArray retry entries?

If kvm_vm_set_mem_attributes() modifies the array concurrently (e.g., using
xa_reserve() or xa_store()), the XArray nodes might split or shrink,
temporarily exposing an XA_RETRY_ENTRY to readers.

While !xa_is_zero(entry) correctly evaluates to false for XA_ZERO_ENTRY, it
evaluates to true if the entry is an internal XA_RETRY_ENTRY. This causes
the loop to treat a retry entry as a non-zero attribute entry and
prematurely return false.

Could this cause KVM to incorrectly report a memory range as having
attributes when it actually has none? For instance, on x86, this might force
callers like hugepage_has_attrs() to permanently mark the range as mixed,
disabling hugepage mappings for the affected GFNs until their attributes are
explicitly modified again.

Should we explicitly restart the traversal when encountering retry entries?

		if (xas_retry(&xas, entry))
			continue;

> +		return true;
> +	}
> =20
>  	for (index =3D start; index < end; index++) {
>  		do {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828102728.1308=
266-1-zeng_chi911@163.com?part=3D1
