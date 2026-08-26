Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DF42E764D
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780463; cv=none; b=OiRJSaRn6d2bgD2pZhcs4zku/4s0Q4cxPNl/ozSKq3Lt8nJ71X1pGF2wjGqf1CbhWDkwNG++4RWJHz/UFPueSJLJG7xT0qmlqeIZTnmzcsXGINbUgasvtTrgloilTmCsnrWqBjAd78Fg7Egwp1TCrOiwM1nFHihlyrapm7EpXlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780463; c=relaxed/simple;
	bh=l/Y41Xtu65ZyPRw56BlSQh+ttBMSadQR10yBU8XH7H0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dzT4N2KFKFV65TTqV506axYbOu6CT76wasgM/VSAp80DYmfsyvUH8o7Aha/PkUaHY4PJDXjO+Z8EzvFBv8MgAJir8T1kUuDZTo4LKZlM7PMy9iVn7ZmGo7vtDpM0DcbXB/ZG1Q/p2HxM5dEiSb8nyTqe8m3+NiseNeSMXscBt78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUkS5+76; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUkS5+76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1681F000E9;
	Wed, 26 Aug 2026 21:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787780462;
	bh=dNxZDWrJOr2c9bXxOo9R4fqEVHEe5euKIF0B8xxs/o0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lUkS5+76n487P/C8M843GFFA9gHpk6nj9Von6iU1uygd8oi3RTXZWuHem1330xz5H
	 42+Ms96EgWoPoTxUc3FXiAI3NCw5jZ/AzUR0OUnQUAfMhV3+2ElxS6AxzOWP5lL3Ph
	 IB74KCt9xowLI1hX7B/hX5pGZMbRqI6Gf1kbXkcfUC9kWDbEp8ahSzGJwFbP+Dgt2h
	 Favq0NNYuV3M47w5Aqb7domcZeNOSYcr3ILbXDPQXsEou+yLmw0lU7hKKYHSlVKjzS
	 0pB6wWwNALvx4Ej1xKo14OLVLkUgCYmk3g7TEexWfJNItqu72CZSXxqH8OVw6Yxerr
	 jCohQ2Sg7t7RQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] KVM: x86/mmu: Bug the VM if KVM attempts to walk
 more levels than the MMU has
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260826211844.884951-3-seanjc@google.com>
References: <20260826211844.884951-1-seanjc@google.com>
 <20260826211844.884951-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 21:41:01 +0000
Message-Id: <20260826214101.CE1681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The new bounds check falsely triggers KVM_BUG_ON for valid PAE pag=
e walks on 32-bit KVM hosts.
--

commit c8c785606f8b5ac435db8c42d576eaf8f88c2fcd
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/mmu: Bug the VM if KVM attempts to walk more levels than the MMU h=
as

This commit extends the paging levels check to ensure KVM doesn't attempt to
walk more levels than the MMU template provides, preventing out-of-bounds
array accesses.

> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmp=
l.h
> index 27427e7f22fa0..46a0f7796e55a 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -368,13 +368,14 @@ static int FNAME(walk_addr_generic)(struct guest_wa=
lker *walker,
>  	pte_access =3D ~0;
> =20
>  	/*
> -	 * Queue a page fault for injection if this assertion fails, as callers
> -	 * assume that walker.fault contains sane info on a walk failure.  I.e.
> -	 * avoid making the situation worse by inducing even worse badness
> -	 * between when the assertion fails and when KVM kicks the vCPU out to
> -	 * userspace (because the VM is bugged).
> +	 * Queue a page fault for injection if any of the below assertions fail,
> +	 * as callers assume that walker.fault contains sane info on a walk
> +	 * failure.  I.e. avoid making the situation worse by inducing even
> +	 * worse badness between when the assertion fails and when KVM kicks
> +	 * the vCPU out to userspace (because the VM is bugged).
>  	 */
> -	if (KVM_BUG_ON(is_long_mode(vcpu) && !is_pae(vcpu), vcpu->kvm))
> +	if (KVM_BUG_ON(is_long_mode(vcpu) && !is_pae(vcpu), vcpu->kvm) ||
> +	    KVM_BUG_ON(w->cpu_role.base.level > PT_MAX_FULL_LEVELS, vcpu->kvm))

[Severity: High]
Does this new check falsely trigger KVM_BUG_ON for valid PAE page walks on
32-bit KVM hosts?

When a PAE guest runs on a 32-bit KVM host (!CONFIG_X86_64), KVM assigns
w->cpu_role.base.level =3D PT32E_ROOT_LEVEL (3). During a page walk,
walk_addr_generic() is compiled for PTTYPE =3D=3D 64. In this context,
PT_MAX_FULL_LEVELS is defined as 2.

The check w->cpu_role.base.level > PT_MAX_FULL_LEVELS evaluates to 3 > 2,
which unconditionally bugs the VM.

The array accesses in the subsequent loop are safe because walker->level is
explicitly decremented from 3 to 2 in the PAE-specific block earlier in the
function, ensuring the max_level used for array indexing does not exceed 2.

Should this check use the adjusted walker->max_level instead of the original
unmodified w->cpu_role.base.level?

>  		goto error;
> =20
>  	++walker->level;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826211844.8849=
51-1-seanjc@google.com?part=3D2
