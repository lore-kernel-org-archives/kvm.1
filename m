Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244FC374A0A
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789512066; cv=none; b=hVxXXjHSPNN//ZPWpnx8AkRDHkLFF0HdYUW5dUw+uKBZvmQ8bXXd5Md/6RAuSDhuPNPcVwCRQe4sdNwWJ4MFmqc73/qhzrtt2UnkToFIS58qeRmYqEkF/o5I0x1K+D3/ynWhTSKozMKbtEFWkZXH+N1ofKQ+SeL6iU1o3ixBRyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789512066; c=relaxed/simple;
	bh=3zD/1G++gSd3GkQjtP0cKbcgP/u/vzTtgSc+K3Y3tJk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JluzIoB4iYFiydJfW4vzaJ4I+Ob9ULAJ+YPrNe7IotrpuqGTvwFeb7C7IuvwJ3VUaE9mQeRfr4UjzG8UKK3P2xOLdz4vis0m3BV6gEPx/jHnA6hwSrew1kf8Xx+rWLAWlm9PLThX+MyvACfXM4gWHin/0rBYg2czH6SjyBPBLhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W45dAcwG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W45dAcwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB441F000FF;
	Tue, 15 Sep 2026 22:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789512064;
	bh=vsT9Ier2Hb3wIiOjYZl2E5KB3uEJfZPZlsFqL2gKxJw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W45dAcwGmxUXEo8G8yweGgLkCjWomzmawSkKFJnkbp7eHygmO1L4XfQ6V4C3Z4X08
	 zF+v8VAbFdea+KK1zjX8jaZMNACxOMmSNXWR+G8oneWGXvEvjqhEAsU5RlYlHnlD9f
	 s4utgzUEAzJdGlE6o3vRtM829x/yj2qQxsA267ifeA0fmXXMy712HqpO6lQS1ebh79
	 EZijFqAYWJfcXC5ejXPCUFut88AFHZdDlxfce7nFTV6cNopKB9PzTvPVr37n0Q+y9e
	 nRfcXy3XB41E+zllksHxd2eermQ9apL6ZFnfvwf3PUgXHls/BinPhmbe5c7i+zQj6K
	 Vq/bFtYMhGV+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] KVM: x86: Restrict saved GPA writes to hardware
 write faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kyle Zeng" <kylebot@openai.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260915222625.99965-1-kylebot@openai.com>
References: <20260915222625.99965-1-kylebot@openai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 22:41:03 +0000
Message-Id: <20260915224104.4EB441F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: x86: OOB read and type confusion via static SVM feature check
--

commit ed7805af977b5a574d9ccec8367687b0fbc85fd3
Author: Kyle Zeng <kylebot@openai.com>

KVM: x86: Restrict saved GPA writes to hardware write faults

This commit restricts emulated writes through a saved GPA to cases where
the hardware page fault actually reported a write access. It includes an
exception for SEV guests to preserve existing behavior since their guest
page tables are encrypted.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 79468ddfe4736..de7fc8efeadce 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -33,6 +33,7 @@
>  #include "lapic.h"
>  #include "xen.h"
>  #include "smm.h"
> +#include "svm/svm.h"

[Severity: High]
Does including a vendor-specific internal header like "svm/svm.h" inside
generic architecture code violate KVM layering rules?

[ ... ]

> @@ -6454,7 +6456,18 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,=
 gpa_t cr2_or_gpa,
> =20
>  		/* With shadow page tables, cr2 contains a GVA or nGPA. */
>  		if (vcpu->arch.mmu->root_role.direct) {
> -			ctxt->gpa_available =3D true;
> +			ctxt->gpa_access =3D ACC_READ_MASK;
> +			/*
> +			 * Always allow writes for SEV guests, as the guest's
> +			 * page tables are encrypted, i.e. KVM can't walk the
> +			 * guest's page tables and so must always use the GPA
> +			 * from the initial fault.  Restricting use of the GPA
> +			 * to the access type that faulted would prevent KVM
> +			 * from emulating RMW operations for SEV guests.
> +			 */
> +			if ((emulation_type & EMULTYPE_PF_WRITE) ||
> +			    (cpu_feature_enabled(X86_FEATURE_SVM) && is_sev_guest(vcpu)))

[Severity: High]
Could this lead to an out-of-bounds read and type confusion?

The cpu_feature_enabled(X86_FEATURE_SVM) check relies on a static host CPU
capability rather than checking the active KVM hypervisor module. In a nest=
ed
virtualization scenario (like QEMU with -cpu max), the host can expose both
VMX and SVM capabilities, but the kvm-intel module might be the one managing
the VM.

If a guest triggers an emulation fault on a kvm_vmx object, this path could
call is_sev_guest(vcpu). Since is_sev_guest() expects a kvm_svm vCPU, it
will blindly cast the kvm_vmx object to kvm_svm and read memory past the end
of the kvm_vmx allocation.=20

If that out-of-bounds memory happens to be non-zero, it would incorrectly
grant ACC_WRITE_MASK authorization for emulated writes, leading to a
potential security bypass or host kernel panic.

> +				ctxt->gpa_access |=3D ACC_WRITE_MASK;
>  			ctxt->gpa_val =3D cr2_or_gpa;
>  		}
>  	} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915222625.9996=
5-1-kylebot@openai.com?part=3D1
