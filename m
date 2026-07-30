Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0562F429008
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415112; cv=none; b=ea22TOmCdqoE8J6w6ZHAbQteBb5YeC2W+CrpkFgZTgU2DEGJXk3VBlPuk6yL00BYnKMRy7JSISphn1CB3NrIXmSn4VOWgYMKaV3RpZFfJvweaXH/2hnFfaTQ7e1qnK4lKrnjn+ObVy9Z27phL1yzQ45MsPG6iYkJdQx7vak37b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415112; c=relaxed/simple;
	bh=zjhux7bZLcc4ff0CgJs9oRYMKHjZDJNNh/t3PyNC54s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hsGZCjpFgU0V942Vx2cPny9emX0S64vkQxjsRhiA1ElhZcq9nm5w4ew6PSRaXNj/PfbNo4pFHwSmcsZc1kTx0qamBzT7xZKzesi0av11EJPK1QCniHNeb4RgG9DimBo8tDV4RuZtiiMHv/514PMm0k7uAeMoqSiIH/qMZx1yknM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LX3fTMjf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LX3fTMjf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EF01F000E9;
	Thu, 30 Jul 2026 12:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785415110;
	bh=vBgD3oeYJz8IgI/3uvZUa/3h29LmNim/WRe5E7+gq6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LX3fTMjfu8UMY0td2T+pYkyW2NhiPxtR3IG/r5Za9UzuyQ6s6fQq3UhDbhCQf+LpA
	 Y/I9EJ28YqEFyzTfpv2wApFIINjzvuKjrHGXxF+kGYnNMQ8UGksi/X910ndL8+uTMR
	 9VSM/fd9U6xOigYbpcDJrrTJB0+zj99/des6syfTxnrxUun1LNFq1CV7E7kv0fEI4l
	 8v4QqwgvJc0mqNVsAGnrk/zl1IRkZOiKdxBEVlVIlWBLV74bGTQcXu4DD/oxKrVQG9
	 6GABcAw/wAawQo7+eMvT7Kxl+mdYgyXNFP6RNzlSI/ohfBBMzgzwVurahXBSdMUxXb
	 08P0q+j/aQa9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/9] KVM: x86: Add helper to provide intercept linear
 addresses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <233ea37ecf646692c2d2aa6d335643c3dbb1fe09.1785411877.git.zhang_wei@open-hieco.net>
References: <cover.1785411877.git.zhang_wei@open-hieco.net>
 <233ea37ecf646692c2d2aa6d335643c3dbb1fe09.1785411877.git.zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 12:38:30 +0000
Message-Id: <20260730123830.A3EF01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch computes `intercept_linear_addr` and adds it to `x86_ins=
truction_info`, but fails to actually use it in the architecture-specific i=
ntercept handlers (`svm_check_intercept` and `vmx_check_intercept`), leavin=
g a severe preexisting bug unfixed.
--

--- Patch [1]: [PATCH v3 1/9] KVM: x86: Add helper to provide intercept lin=
ear addresses ---
commit e0c208c3018cdb4b9689064eac5e998c1b4d07df
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: x86: Add helper to provide intercept linear addresses

This commit adds get_intercept_linear_addr() to compute the linear address
for INVLPG intercepts. It passes this address through x86_instruction_info
so intercept handlers can use it directly without duplicating the calculati=
on.

> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
[ ... ]
> @@ -427,6 +447,7 @@ static int emulator_check_intercept(struct x86_emulat=
e_ctxt *ctxt,
>  		.src_type   =3D ctxt->src.type,
>  		.dst_type   =3D ctxt->dst.type,
>  		.ad_bytes   =3D ctxt->ad_bytes,
> +		.intercept_linear_addr =3D get_intercept_linear_addr(ctxt, intercept),
>  		.rip	    =3D ctxt->eip,
>  		.next_rip   =3D ctxt->_eip,
>  	};

[Severity: High]
This isn't a bug introduced by this patch, but it looks like the architectu=
re
backends might still need to be updated to consume this new field.

If an L2 guest executes an INVLPG instruction that KVM intercepts and emula=
tes,
and L1 is also intercepting INVLPG, the KVM emulator populates
intercept_linear_addr here.

However, if the handlers in arch/x86/kvm/svm/svm.c:svm_check_intercept() and
arch/x86/kvm/vmx/vmx.c:vmx_check_intercept() don't use this new field, does
KVM synthesize nested VM-exits for INVLPG incorrectly?

For SVM, if it falls through to the default case and leaves
vmcb->control.exit_info_1 unmodified, could this leak previous host or
VM-exit data to the L1 hypervisor?

For VMX, does lacking a case for x86_intercept_invlpg entirely cause it to
return X86EMUL_UNHANDLEABLE and fail emulation?

Should the hardware intercept handlers be updated in this series to prevent
stale data leakage and L2 DoS?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785411877.gi=
t.zhang_wei@open-hieco.net?part=3D1
