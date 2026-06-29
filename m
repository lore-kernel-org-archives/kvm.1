Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90982410D13
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738744; cv=none; b=Odw+09bHLD+O0jKQ36EwO2ptkWgMNv2HulHlleSk9ive6p4Gl1sUt3KahzNJZcYHM/RSqK7jSoCnKL85XSlVPZoO1jfkslZiUE1tD8cO4iNdWKXFqN7w/jyJmPACNcYPuLoTGGGY0SYYhdyX2h/C1/xIbJk3mFAAyCpVfEv3pbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738744; c=relaxed/simple;
	bh=dFVNEwLVnSrO04j0gL5PA74v/Aqp426ELnEvY/FOI54=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HocDMzaBXUt7NQD71r5qriCHUfah5JEKorSVdsG577YUWMR+TwQ1ASe1qwZEkPntLpLDv2/cLhvpRmD27gaRmPCy2nUxemh4xCf2Ybqg9zwCAU+sYwl2+SnG0DkfPNjHm5P0j1bCW0NR7siqYcf5XZh9gWKRbASweDQplEYqb9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqmLFjpE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqmLFjpE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CEA1F01560;
	Mon, 29 Jun 2026 13:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782738742;
	bh=NDwC0MS4WDLWvXKv2Ihcy/5bi76Sf27YwaVdjCSij+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EqmLFjpEl7k6rhG8fp2u269J+kycgA1s2zUWaq/p7cSRWxxwQ1ZtYmVZ+Y0/WFvu0
	 YHa3sWx5Dhem031QihgetCzkbGLAxpmVSiJbQ9nMVMds4i4CbinySAtkH3+VXo9S75
	 2ni8I3Dot4wAgi+l6Ecx+TVlaI+KiuWMhovpkMzHpajHmkLEH7sRC98fNSwBuJNhDF
	 a46Va5l7cWpUDtTnvBbt1boHwPislV9YonepQ2wCaVBStxUZtc/WcxN4GGIzEh1i4J
	 foTrqPOkPlE6s/ZhIzxCWamZYV+8YLgMS3BceZtCB9Npw6YBEYPsoz1XxHQ8fMWpl8
	 df5QD/H0Are5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] KVM: nSVM: Virtualize DecodeAssists for nested
 guests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260629125205.52394-2-zhang_wei@open-hieco.net>
References: <20260629125205.52394-1-zhang_wei@open-hieco.net>
 <20260629125205.52394-2-zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 13:12:21 +0000
Message-Id: <20260629131222.12CEA1F01560@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch completely fails to propagate DecodeAssist information f=
or hardware-generated #NPF exits, breaking its primary stated goal.
--

commit 25d49971bfa61318056a7a414a7878b30f3a2e0d
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: nSVM: Virtualize DecodeAssists for nested guests

This commit advertises DecodeAssists to L1 nested guests and copies
instruction length and bytes from VMCB02 to VMCB12 for nested VM-Exits.
It introduces the decode_assists_valid flag to track real hardware exits
and prevent KVM from exposing stale bytes for KVM-synthesized exits.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 961804df5f451..86b5cd45a52fe 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c

[ ... ]

> @@ -1608,8 +1650,11 @@ int nested_svm_exit_handled(struct vcpu_svm *svm)
> =20
>  	vmexit =3D nested_svm_intercept(svm);
> =20
> -	if (vmexit =3D=3D NESTED_EXIT_DONE)
> +	if (vmexit =3D=3D NESTED_EXIT_DONE) {
> +		/* This path reflects a real VMCB02 exit directly to L1. */
> +		svm->nested.decode_assists_valid =3D true;
>  		nested_svm_vmexit(svm);
> +	}
> =20
>  	return vmexit;
>  }

[Severity: High]
Does this patch actually propagate DecodeAssist information for #NPF exits?

Looking at nested_svm_exit_special(), SVM_EXIT_NPF unconditionally returns
NESTED_EXIT_HOST. This bypasses nested_svm_exit_handled() entirely, meaning
svm->nested.decode_assists_valid is never set to true for nested page fault=
s.

When KVM later reflects the fault to L1 via nested_svm_inject_npf_exit():

arch/x86/kvm/svm/nested.c:nested_svm_inject_npf_exit() {
        ...
        nested_svm_vmexit(svm);
}

The decode_assists_valid flag will still be false. Won't this cause
nested_svm_vmexit_update_vmcb12() to unconditionally clear the decode
fields, silently discarding the valid hardware DecodeAssist data in VMCB02
that the commit message mentions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629125205.5239=
4-1-zhang_wei@open-hieco.net?part=3D1
