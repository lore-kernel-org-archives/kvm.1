Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DDE27144B
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782872412; cv=none; b=EwgoqRyZQ4rBWeOaO7H4xIvxVbKfFVR8bcWxTl9cDNJz62JIEVP68EfiD6GlWxJFz1mszWXGlxacRleeLYIF2rUCZUcLR/yDfhdvVjSVSVB6+ZE4POtF0OrPv3QsHKsXZhyaC/Hj/TC2yVIcXqc0qAttKtwSIPqWV7UceGMnObA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782872412; c=relaxed/simple;
	bh=aVfA+4ThTKrL4v1OByEouk5rXjnLCQTcHbVut6XbgSk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RPyR32iLt6WKEQDQDuT3WF9SkrPk5iUi2kmovOdvy9uPfUkUx48fydhFomwKks2acuvxQQzjThlSvqgqNHF3n1NZ8jpxwMsbvCk9XTzFEcDlKjU6Ow3BTXKP4s1XTfMCo/fxT2kqj2SosGxadtGy3UgYlB/tluuO22F8LR+xr/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvVWSGHr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvVWSGHr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CAB1F000E9;
	Wed,  1 Jul 2026 02:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782872411;
	bh=Q6gSDs4eMtYVwZf8drW7qkK8bPjpc/wHBNJNj5O5QdY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GvVWSGHr3KBg7CXk2PZpQHOUK1Kb2+XwYSoeP8etCWNAlSww1TXAGb4sdR1diLzwc
	 LlHclrqm8Vpx4U9gmYj7zCRqAWwyo1eYGc+5+6+3ANBo9T2GLc+nxw4TRKnjG88cqU
	 4lv++f/Z+F+pYoK1RtOb2FLQIV/noJ3Y7kYpsulJ9M26ibIejSccTshnFvihNX/Wc3
	 yGqZGlBLe6dJgWunzHd2euD+6D1O//e7rS6pRrdO1h6D2+k6uS1P1wtISE4Z1DM+K3
	 wsfxepjBuXpX3g1CkHvG6QoD5IDIYeJxkkztBuFfMBq6VsOia79OFBXHCebN6Jtsua
	 TRzXlt+dHQdIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/8] RISC-V: KVM: Delegate SPELP bit to VS/VU mode if
 landing pad is enabled.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701020746.170157-7-inochiama@gmail.com>
References: <20260701020746.170157-1-inochiama@gmail.com>
 <20260701020746.170157-7-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 02:20:10 +0000
Message-Id: <20260701022011.19CAB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing clearance of SR_SPELP in guest_context.sstatus during trap=
 redirection causes the guest to resume with an incorrect ELP state, leadin=
g to spurious landing pad faults.
--

commit 2ec992c0d3b802f1fb7b83ffb3d6328de134362d
Author: Inochi Amaoto <inochiama@gmail.com>

RISC-V: KVM: Delegate SPELP bit to VS/VU mode if landing pad is enabled.

This patch delegates the newly added SPELP bit from the Zicfilp extension
to VS/VU mode if it enables landing pad support.

> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -154,6 +154,12 @@ void kvm_riscv_vcpu_trap_redirect(struct kvm_vcpu *v=
cpu,
>  	/* Clear Guest SSTATUS.SIE bit */
>  	vsstatus &=3D ~SR_SIE;
> =20
> +	/* Change Guest SSTATUS.SPELP bit */
> +	if (vcpu->arch.cfg.henvcfg & ENVCFG_LPE) {
> +		vsstatus &=3D ~SR_SPELP;
> +		vsstatus |=3D vcpu->arch.guest_context.sstatus & SR_SPELP;

[Severity: High]
Does this missing clearance cause the guest to resume with an incorrect ELP
state?

While this correctly saves the old ELP state to vsstatus, it appears to
leave SR_SPELP set in vcpu->arch.guest_context.sstatus. If a guest with
the Zicfilp extension enabled takes an exception while its active ELP state
is 1, won't the guest's exception handler be entered with an active ELP
state of 1 instead of 0?

Could this cause an immediate Software Check exception (landing pad fault)
when the guest exception handler executes its first instruction, resulting
in a trap loop or guest crash?

> +	}
> +
>  	/* Update Guest SSTATUS */
>  	ncsr_write(CSR_VSSTATUS, vsstatus);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701020746.1701=
57-1-inochiama@gmail.com?part=3D6
