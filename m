Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B4C44C64D
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552031; cv=none; b=O5SO7ugs5bP0BtpLDp7SDkkC2p3HXkwSRVWuqk6MFgL8W+remI9RvNTsM4lZQ86GwOTUrrfDRNsUIGU6RYlvlWKOfzZqQGm2f6GvM8GWB9tfePSjSc7ikAtHqlY0gpBEJVnCi68Q3EiyxC7Pf2x4PG9hfqFz6TV+Ey7ABo4hzc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552031; c=relaxed/simple;
	bh=/aJpO/9o6TjCbRsqjyeurZ6YdGXhoqiTuue1T1XHao0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rTb+BBJwZ2rWy1TGXtx8Tj6Z91gn3dhXE4K3au50ND92OwpiwzFwq6BhU1vUSM6aN1eg5L31mw9ul50J9Q4tUi+In14kfxSNbAPCrxq1bg4dfr5fjzieJXGfTnupRTXUs1iAhSF4kXURCMbcHGfafzJS2b5kBa/s+KdKfYqO6qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muFjkIU7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muFjkIU7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B941F000FF;
	Fri,  9 Oct 2026 13:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791552030;
	bh=/LoZp1WJsfwlykkg9/2ZvpkwVZI+W92cffe6ASmOWOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=muFjkIU7Pwt1MPGftJJGG7qGJO+WHMF6KhLuq4R6SxBS8UV5GhDNj0KvcHGki/S7Q
	 ZvfS8AThLF/aN+mpls3AKtQaB0u/uSTqlBnJQTka6sGp47Z0Ks69rdOJTdTOjygLGj
	 cioZQhysqktaKUBKgd9jkblArjsgHt9qdw2XxTVLx1OCF3IIMHM/TdwQDVTdMUf6EP
	 G1k//Nq/Ned7p453xSgTmgSduiU5fDwvrp0nZvwpkgGoL/gtFuPlfeQDDVhKR7cw8V
	 4UmPrhp8tNB8S1laM0vgKvyAeaZFA48viAxJ1Amy+yqpBE4x1kCo83/9cYQeV7Piu+
	 oJeoyTVhxtQuQ==
Message-ID: <sashiko-outbox-165619@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: x86/mmu: Cope with the SS bit being set in #NPF
 exit codes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261009130450.361690-1-pbonzini@redhat.com>
References: <20261009130450.361690-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 13:20:29 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kvm: x86/mmu: WARN_ON_ONCE triggered by PFERR_GUEST_RMP_MASK in pe=
rmission_fault()
- [Low] build: unused variable user_fault in walk_addr_generic
--

commit 41b1ccbf9309dd89dc82f560f60a35e3cca23942
Author: Paolo Bonzini <pbonzini@redhat.com>
Subject: KVM: x86/mmu: Cope with the SS bit being set in #NPF exit codes

This commit modifies kvm's handling of page fault error codes to drop the SS
bit and warn on unexpected bits. It intends to fix out-of-bounds accesses in
permission_fault() seen when running Hyper-V from Windows 11. The SS bit is
also preserved when reflecting the fault to L1.

> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 2ae7f9ed4cf86..8e991e02c954e 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -275,8 +275,18 @@ static inline u8 permission_fault(struct kvm_vcpu *v=
cpu, struct kvm_pagewalk *w,
>  				  unsigned pte_access, unsigned pte_pkey,
>  				  u64 access)
>  {
> -	/* strip nested paging fault error codes */
> -	unsigned int pfec =3D access;
> +	/*
> +	 * Of the error codes that do not contribute to the index in
> +	 * fmt->permissions, PK is not included in EPT violation bits and
> +	 * not supported by shadow paging, and RSVD faults are handled
> +	 * elsewhere.  SS however is included in the NPT exit code.
> +	 */
> +	unsigned int pfec =3D access & ~PFERR_SS_MASK;
> +	if (WARN_ON_ONCE(pfec & ~(PFERR_PRESENT_MASK | PFERR_WRITE_MASK |
> +				  PFERR_USER_MASK | PFERR_FETCH_MASK)))

[Severity: High]
Does this strict whitelist introduce a way for unprivileged nested guests
to panic the host?

When running nested VMs on amd hardware with sev-snp support, a guest can
intentionally trigger an rmp violation, for example by attempting an
unauthorized access to an rmp-protected page. The hardware generates a nest=
ed
page fault and sets PFERR_GUEST_RMP_MASK (bit 31) in the exitinfo1 error
code.

The npf_interception() function intercepts the nested page fault and passes
the full error code into kvm_mmu_page_fault(). During shadow page table
walking, walk_addr_generic() propagates the error code down as the access
argument to permission_fault().

Because pfec is defined as an unsigned int, bit 31 survives the initial
bitwise truncation. Since bit 31 is not in this whitelist, the check fails
and triggers the WARN_ON_ONCE, which allows an unprivileged nested guest to
consistently trigger a host kernel panic on panic_on_warn hosts.

> +		pfec &=3D (PFERR_PRESENT_MASK | PFERR_WRITE_MASK |
> +			 PFERR_USER_MASK | PFERR_FETCH_MASK);
> +
>  	unsigned long rflags =3D kvm_x86_call(get_rflags)(vcpu);

[ ... ]

> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmp=
l.h
> index 8e350095508c5..54b3172e84bff 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -489,7 +489,7 @@ static int FNAME(walk_addr_generic)(struct guest_walk=
er *walker,
>  	return 1;
> =20
>  error:
> -	errcode |=3D write_fault | user_fault;
> +	errcode |=3D access & (PFERR_WRITE_MASK | PFERR_USER_MASK | PFERR_SS_MA=
SK);

[Severity: Low]
Does this change leave user_fault unused?

Because user_fault is declared at the top of FNAME(walk_addr_generic):

    const int user_fault  =3D access & PFERR_USER_MASK;

Removing its only usage here seems to trigger a -Wunused-variable compiler
warning, which breaks the build under CONFIG_WERROR. Since this file is a
template included multiple times, the error repeats for each instantiation.

>  	if (fetch_fault && has_pferr_fetch(w))
>  		errcode |=3D PFERR_FETCH_MASK;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009130450.3616=
90-1-pbonzini@redhat.com?part=3D1
