Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0DC3E49DA
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788391806; cv=none; b=pn1IdYIxJ7slQuwzIvXaLHuqOSfmF6fXVG157AiEgG8iN/QG7YZAUJTeD5Fhs7jhYkXvDVHpbAZgUx7Gy3WoyloOfpXB29qykK+HiSoT4lrT7cjgolmYO0O6mi61m1UFo6wSoT3P3ZACtZrq2JBluxDIlyXw9ZrKU/6NDJHRzEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788391806; c=relaxed/simple;
	bh=zNIlJ9DwAOHo8ylZ9j9g6YnUi8nRQWMPNZb2xSMMGY8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IsG/ZnxRoXiDVOkL/vkmjb5ry5afW63OBRlttJ5Hi0/oCd6q/fGuhsCLnjhKsv8VQi0gMOW3TgGwUSzdKXw7iZhO3+fger7ywQAh0xM6L/b/JWQc/LBsZKVCu41bznoXH8TB1JdEgzUJ33FIDCrEZsYeS07hlY/GdQlYlmKuM80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKiGNb7m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKiGNb7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B670E1F000E9;
	Wed,  2 Sep 2026 23:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788391804;
	bh=j22M+vWqsDrdMZ5D5JUb/gd4FN7pRXT5uqRIjJsw6d4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LKiGNb7mHJvNVx0RpdH11weU0ADp4pZJJ//sbmObNdu7SrjU1W6Z7NLqnnAdj3qNl
	 zNiu6WD//Ik/DTlpTIz1rBpk3tp+XJC4lcegYyage7HJ40Tb1XGeUpPk5my3WcIVW2
	 ZmwnRdqtaxMIjKFvJLozdRH3ce5iZfquAVWz5quKrRVMFuPzA8oOnyeXY43Mm6DlQI
	 t4yrKUXqeFZ3AWN5rZXIjoMs2ThC1SE6UCeXzuS9eYMafIk5fIJx2kNKQl3P3hjylp
	 1WR3EiUfK4LrtPxUIt9FltixZtu3w8GWY+t3r/eg+qzTK/YmJrQkLJpRnTG9I26lFA
	 VM82/orupDWMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] KVM: x86/mmu: Bug the VM if KVM calcs a CPU role
 with EFER.LMA=1 && CR4.PAE=0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902232028.2767071-5-seanjc@google.com>
References: <20260902232028.2767071-1-seanjc@google.com>
 <20260902232028.2767071-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 23:30:04 +0000
Message-Id: <20260902233004.B670E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Modifying a const-qualified struct member via pointer cast invokes=
 undefined behavior, and the compiler may optimize away subsequent checks, =
defeating the bug mitigation.
--

commit a1c4dd28227e88b096d9ee6618a2543aab000da4
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/mmu: Bug the VM if KVM calcs a CPU role with EFER.LMA=3D1 && CR4.P=
AE=3D0

This commit adds a KVM_BUG_ON check to catch invalid CPU roles where long
mode is active but PAE paging is not. It attempts to mitigate the fallout by
clearing the EFER_LMA bit in the provided registers before continuing MMU
construction.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 064ecc33b9267..81c30e2c74f3c 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5910,6 +5910,9 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct =
kvm_vcpu *vcpu,
>  		return role;
>  	}
> =20
> +	if (KVM_BUG_ON(____is_efer_lma(regs) && !____is_cr4_pae(regs), vcpu->kv=
m))
> +		*(u64 *)&regs->efer &=3D ~EFER_LMA;

[Severity: High]
Does modifying a const-qualified struct member via a pointer cast invoke
undefined behavior here?

Looking at the definition of struct kvm_mmu_role_regs:

struct kvm_mmu_role_regs {
	const unsigned long cr0;
	const unsigned long cr4;
	const u64 efer;
};

Since the efer member is explicitly declared as const, could the compiler
assume it never changes after initialization and optimize away the clearing=
=20
of EFER_LMA for the subsequent checks in kvm_calc_cpu_role()?=20

If the compiler uses a cached value for the remaining efer checks, it seems
this would bypass the intended bug mitigation entirely and still construct a
completely invalid MMU role.

> +
>  	role.base.efer_nx =3D ____is_efer_nx(regs);
>  	role.base.cr0_wp =3D ____is_cr0_wp(regs);
>  	role.base.cr4_smep =3D ____is_cr4_smep(regs);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902232028.2767=
071-1-seanjc@google.com?part=3D4
