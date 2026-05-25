Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9473343890
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 01:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673962; cv=none; b=hbt8OXkvqIEGYVQsi0VEKf5+caFv/9rEbXOeJmVyntUKve1Hg1jV8Rj679uqsVBa6/v9jz95818tSH6DrXMAzhPduQf4q3e3q8nshatIglDNE22nRkEkd/SHac1c+VQJxhMsBnBRzKYKao9/18B6X/HbksM8cGz/fkHjxI2q7QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673962; c=relaxed/simple;
	bh=SF8HirQibzkMSgxTArDgsL7MeLXSu2xo60By8s3vFIE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pfb88SknB4wlkh1yHXOEBXJP9kZkLcqibZVvTMl2VrlCPB43BwsYAgapInulJuJHbJXUxOPemwNea0zgrKovDWWHZYepXgujRFbVPQ6SC0WfYSABOpHb2/hh9QK7+k7ZgfihsixxcL/b8aeHqHy+Ulqhp15s2YvpZYOIiqm9+cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfSRXMeQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfSRXMeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C781F000E9;
	Mon, 25 May 2026 01:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779673960;
	bh=v/XDAPv7k0J4Wd5xmcAOUUy/fPqOQpLVQQeVpOJT0Ao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BfSRXMeQJU6ovbJBS81EH437ENVNvRXUr7odWY66ZwdTYGKp79qgWm5XJ5IygjNmy
	 0/Qmus/ZZhS+qfYuLjbVra33TXeAQBXR46JT7Vkb4U0OdkRal5pODrwCCOpp8QYM9O
	 OVaGkyhs7OWC3MWqUmZQP5Iz6qIulloDUAlsVuzkEymp+oWoFXQ6FpO9qFq76Okp+p
	 vxCJX+iv3JM3B86RA+FOVQtDwlU9LJCZxrbLj2O2gMQQCpztiIIsYTYHYaDmdWRJ43
	 0xbgqHtKEz24rtkQI9Kko6CABY2G91KQxOmZB6Y79RPPEpKv1AnFQ+rsR2taYz9ypq
	 vwh+rZfmP9YKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] RISC-V: KVM: Document a TOCTOU race in SBI system
 suspend handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiakai Xu" <xujiakai2025@iscas.ac.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525013642.999187-1-xujiakai2025@iscas.ac.cn>
References: <20260525013642.999187-1-xujiakai2025@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 01:52:40 +0000
Message-Id: <20260525015240.75C781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Attempting to reject the suspend request from userspace silently c=
orrupts the guest state due to an unconditional reset mechanism.
- [High] Explicit dismissal of a structurally possible TOCTOU race conditio=
n in the system suspend handler.
--

commit 7239a492cfe7afdf627bbd87cb7228bf0f2f67bc
Author: Jiakai Xu <xujiakai2025@iscas.ac.cn>

RISC-V: KVM: Document a TOCTOU race in SBI system suspend handler

This commit adds documentation for a known TOCTOU race in the SBI system
suspend handler. It clarifies that a concurrent HSM HART_START can start a=
=20
vCPU after it passes the stopped check, and mentions that userspace can=20
double-check the vCPU states before proceeding with suspend.

> diff --git a/arch/riscv/kvm/vcpu_sbi_system.c b/arch/riscv/kvm/vcpu_sbi_s=
ystem.c
> index 359be90b0fc58..71cde553dcc05 100644
> --- a/arch/riscv/kvm/vcpu_sbi_system.c
> +++ b/arch/riscv/kvm/vcpu_sbi_system.c
> @@ -35,6 +35,20 @@ static int kvm_sbi_ext_susp_handler(struct kvm_vcpu *v=
cpu, struct kvm_run *run,
>  			return 0;
>  		}
> =20
> +		/*
> +		 * Check that all other vCPUs are stopped before entering
> +		 * system suspend.
> +		 *
> +		 * There is a known TOCTOU race here: a concurrent HSM
> +		 * HART_START on another vCPU can start a vCPU after it
> +		 * has already passed this check, violating the invariant.
> +		 *
> +		 * We do not fix this because:
> +		 * 1. Triggering the race requires a pathological guest.
> +		 * 2. Only guest state is at risk, not host integrity.

[Severity: High]
This is a pre-existing issue, but does leaving this race unhandled without
holding the mp_state_lock violate structural ordering guarantees? Even if it
requires a pathological guest, allowing an ordering violation to occur seems
problematic. Should this race be explicitly fixed rather than documented and
dismissed?

> +		 * 3. Userspace can double-check vCPU states before
> +		 *    proceeding with suspend.
> +		 */
>  		kvm_for_each_vcpu(i, tmp, vcpu->kvm) {
>  			if (tmp =3D=3D vcpu)
>  				continue;
>  			if (!kvm_riscv_vcpu_stopped(tmp)) {
>  				retdata->err_val =3D SBI_ERR_DENIED;
>  				return 0;
>  			}
>  		}
>=20
>  		kvm_riscv_vcpu_sbi_request_reset(vcpu, cp->a1, cp->a2);
>=20
>  		/* userspace provides the suspend implementation */
>  		kvm_riscv_vcpu_sbi_forward(vcpu, run);

[Severity: High]
This isn't a bug introduced by this patch, but if userspace attempts to
double-check the vCPU state (as suggested by the new comment) and rejects
the suspend request, does this silently corrupt the guest state?

kvm_riscv_vcpu_sbi_request_reset() queues KVM_REQ_VCPU_RESET and records
the resume address before forwarding to userspace. If userspace returns an
error to reject the suspend, kvm_arch_vcpu_ioctl_run() still unconditionally
processes the pending KVM_REQ_VCPU_RESET.

Could this erase the userspace error and force the PC to the suspend resume
address, causing the guest to falsely believe the system suspend succeeded?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525013642.9991=
87-1-xujiakai2025@iscas.ac.cn?part=3D1
