Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0314C4BEE38
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 21:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789163881; cv=none; b=cO0GzH1z5Hl87kwM/o5jqBvZeTLAD0tg3pYHP70XiKJmoQVUrqlPBBIE5Oz1KVJQA2uDYWLfE3LL6gYrzOnBAXhIhbXy0jsbrRqWqXptFUNhSYJATnSE7dfWomj4PLG9baC8g4U5YLHNs2YvkfAT7LeGf6Xke467iX1iNwHvprM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789163881; c=relaxed/simple;
	bh=cugIrnP8XXPx3PXpzjtol/JdQ1SNtUlFeqV8IbS8pEM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VOKhUcVRhPxvfHDpgbtlh+qxUk5O3BO7fdW694kotO99ZwRud8cmYPd/CRJkKe9iuMS1+H63bGZM75HKgoeMqNzOE7JmTqnODxz0M/J996tjnbk1VNNcgYJXO6820DriU9zygAFuo5tPRfLOCNyHnyX/8xsUe29XAuWyyHbU3Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVLJZ3p1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVLJZ3p1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C04F1F000FF;
	Fri, 11 Sep 2026 21:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789163879;
	bh=8H9nE3nCLJKESu8SCd3yLRe1CyYAJh/iY4WWcLK0DLg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WVLJZ3p1gUCQli9GDFJHMBz94xFYwdrf59mHKYdPot/ch6cuQH+PHZ/STJ9ifCpx0
	 bjcrsE7J0aDS7CjJpiDHlXoZvp4AwWM3oNXfCAlP9km672EayCltWEbh4pIsaTNrvo
	 Nl0LUyR2atzbvaNDAGi4hjLrrTFibwNI8UjMXJ4pqh9HfpoDz5MVpmvBRaPp55bVlm
	 YPdUukQcfhR4bFz0DFjWJ0sdLHxX4nmINfw99HL2qF1tmWckYuY52ilRZV8gKQIMdw
	 dJtbEpRMaGoXrjFcZIYCg5IQDarujkMq4ulQ6RQ2hStsGfcru9oy9i1eOo3vXi6H0T
	 /Ffm/pYUX4cbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 05/28] x86/cea: Use array indexing to simplify
 exception stack access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sohil Mehta" <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260911213659.2025974-6-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-6-sohil.mehta@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 21:57:58 +0000
Message-Id: <20260911215759.6C04F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unnecessary out-of-line function calls and runtime bounds checks=
 introduced in highly performance-sensitive #VC exception entry paths.
--

commit 6ef3745e3d1d46a5989ce999cb84609a2d082888
Author: Xin Li (Intel) <xin@zytor.com>

x86/cea: Use array indexing to simplify exception stack access

Refactors struct cea_exception_stacks to leverage array indexing for
exception stack access, improving code clarity. Converts
__this_cpu_ist_{bottom,top}_va() from macros to functions.

> diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
> index 9fa371af8abc7..a47dfd686bd33 100644
> --- a/arch/x86/mm/cpu_entry_area.c
> +++ b/arch/x86/mm/cpu_entry_area.c
> @@ -18,6 +18,26 @@ static DEFINE_PER_CPU_PAGE_ALIGNED(struct entry_stack_=
page, entry_stack_storage)
>  static DEFINE_PER_CPU_PAGE_ALIGNED(struct exception_stacks, exception_st=
acks);
>  DEFINE_PER_CPU(struct cea_exception_stacks*, cea_exception_stacks);
> =20
> +/*
> + * Typically invoked by entry code, so must be noinstr.
> + */
> +noinstr unsigned long __this_cpu_ist_bottom_va(enum exception_stack_orde=
ring stack)
> +{
> +	struct cea_exception_stacks *s;
> +
> +	BUILD_BUG_ON(ESTACK_DF !=3D 0);
> +	BUG_ON(stack >=3D N_EXCEPTION_STACKS);

[Severity: Medium]
Does moving these helpers from macros in the header to out-of-line functions
introduce an unintended performance regression?

Because the functions are defined out-of-line in a different translation un=
it,
the compiler cannot statically evaluate the BUG_ON(stack >=3D N_EXCEPTION_S=
TACKS)
bounds checks nor inline the pointer math.

This incurs a penalty of multiple function calls and dynamic checks in
performance-sensitive #VC exception entry paths. For example, hot paths like
is_vc2_stack() in arch/x86/coco/sev/vc-handle.c repeatedly call these funct=
ions,
which are evaluated on every #VC exception:

arch/x86/coco/sev/vc-handle.c:is_vc2_stack() {
    ...
    return (sp >=3D __this_cpu_ist_bottom_va(ESTACK_VC2) &&
            sp < __this_cpu_ist_top_va(ESTACK_VC2));
}

Could this regression in a noinstr entry path be avoided by defining these
helpers as static __always_inline in the header instead?

> +
> +	s =3D __this_cpu_read(cea_exception_stacks);
> +
> +	return (unsigned long)&s->event_stacks[stack].stack;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911213659.2025=
974-1-sohil.mehta@intel.com?part=3D5
