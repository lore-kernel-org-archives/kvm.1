Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562823B6BF9
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725067; cv=none; b=gy5oUTiMmuuCCgWeGGsEOssVIAAwvqjFc7LXAaeypFH+vfmgzm4CfHD5CPT+hn6YP9RFxmoVcw9W2OvmUFLhWsLPR0QMr4bjQdvNbzacjd/mJFERD/fttW57+u79mVyN5Ahoi7rCFsvtCCCrmdrUXscLQwHgzLkRLg6VWAqN2fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725067; c=relaxed/simple;
	bh=ad2KSZ6aj9LaZljjaGmb+DSGR3m4x4q92q9df7qesM4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q/AGZzk2N8WIwCJX0QOLlLz/Q4Imm7k7uFdHcOrZSXWaP1I7LcX899BdzX1jVh400GPdqqOU1Zt9FQhc2DmPf4031XN0auuaS6e3pRQBFPRVADiOtAIk+EgTwmN1yq/35z4KOBawAH4h/EUdKCgXgi/d5nA8VbAB0WKoeabbI0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHZ+a15h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHZ+a15h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEC31F000E9;
	Fri, 14 Aug 2026 16:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786725065;
	bh=wfz+GtiP4IhrbH+BjJ8TCxWccRMAaQb6+4yzbeYz808=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MHZ+a15hv1JILMIE10fwu0/38f3hY84hwsVr878JF2lyH3C3rxztEZQZ7MAu4Djpz
	 3dqF9zca46w6rNL6zBn7yPDjTlNwyy16O3rI3uR+rWx1bLqg9sSggCTLqv45Hn4HIP
	 JxIpVdmzFubV9LURUSjj+AfizXPBByuDzh57oML8Xy5UpxdjrbRr7L1wWY5B9JoB23
	 hAcrJehZBMckRWr8XnXsm35KPjMPSqSChbSJ/ZJ/WO1rR/DElr9R88r2sSETLSsQlB
	 4QlJ+BB7TdTmV8rVQPpk4flMIXzrRoLYwBOeAhs03QCArIkOjinfnHRxHVAp8LNK7q
	 xGLRVEdhoDYfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] KVM: selftests: Check VMPTRLD with active eVMCS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vitaly Kuznetsov" <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260814162221.2144473-5-vkuznets@redhat.com>
References: <20260814162221.2144473-1-vkuznets@redhat.com>
 <20260814162221.2144473-5-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 16:31:05 +0000
Message-Id: <20260814163105.BDEC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The hardcoded `VMPTRLD_INSN_SIZE` of 5 bytes is brittle because =
`vmptrld` is executed using an inline assembly memory operand constraint (`=
"m"`), which results in a variable-sized instruction depending on compiler =
optimizations and register allocation.
--

--- Patch [4]: [PATCH 4/4] KVM: selftests: Check VMPTRLD with active eVMCS =
---
commit 80c84d1f71bebfd26712329b4fe8a487216ec3fb
Author: Vitaly Kuznetsov <vkuznets@redhat.com>

KVM: selftests: Check VMPTRLD with active eVMCS

Check that VMPTRLD when eVMCS is active results in #UD. This matches
genuine Hyper-V's behavior.

> diff --git a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c b/tools/testi=
ng/selftests/kvm/x86/hyperv_evmcs.c
> index 88262ddf7fcb2..6a6d940a78918 100644
> --- a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
> +++ b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
> @@ -18,12 +18,16 @@
>  #include "hyperv.h"
>  #include "vmx.h"
> =20
> +#define VMLAUNCH_INSN_SIZE 3
> +#define VMPTRLD_INSN_SIZE 5
> +
>  static int ud_count;
> +static int ud_insn_skip_size;
> =20
>  static void guest_ud_handler(struct ex_regs *regs)
>  {
>  	ud_count++;
> -	regs->rip +=3D 3; /* VMLAUNCH */
> +	regs->rip +=3D ud_insn_skip_size;
>  }

[ ... ]

> @@ -182,10 +186,15 @@ void guest_code(struct vmx_pages *vmx_pages, struct=
 hyperv_test_pages *hv_pages,
>  	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) =3D=3D EXIT_REASON_VMCALL);
>  	GUEST_SYNC(11);
> =20
> +	ud_insn_skip_size =3D VMPTRLD_INSN_SIZE;
> +	vmptrld(hv_pages->enlightened_vmcs_gpa);

[Severity: Medium]
Could this hardcoded instruction size lead to guest instruction stream
corruption?

The vmptrld() inline assembly in include/x86/vmx.h uses a memory operand
constraint ("m") for the physical address:

static inline int vmptrld(u64 vmcs_pa)
{
	u8 ret;

	__asm__ __volatile__ ("vmptrld %[pa]; setna %[ret]"
		: [ret]"=3Drm"(ret)
		: [pa]"m"(vmcs_pa)
		: "cc", "memory");
        ...
}

Depending on compiler optimizations and register allocation, the resulting
instruction might not be exactly 5 bytes in size (for example, it could be 4
or 7 bytes depending on the chosen addressing mode).

Since guest_ud_handler() unconditionally advances regs->rip by
ud_insn_skip_size, if the generated instruction length does not match
VMPTRLD_INSN_SIZE, resuming the guest could land in the middle of an
instruction and cause #GP faults or infinite #UD loops.

> +	GUEST_ASSERT(ud_count =3D=3D 1);
> +
>  	/* Try enlightened vmptrld with an incorrect GPA */
> +	ud_insn_skip_size =3D VMLAUNCH_INSN_SIZE;
>  	evmcs_vmptrld(0xdeadbeef, hv_pages->enlightened_vmcs);
>  	GUEST_ASSERT(vmlaunch());
> -	GUEST_ASSERT(ud_count =3D=3D 1);
> +	GUEST_ASSERT(ud_count =3D=3D 2);
>  	GUEST_DONE();
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814162221.2144=
473-1-vkuznets@redhat.com?part=3D4
