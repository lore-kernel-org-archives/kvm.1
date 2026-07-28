Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0D63AA195
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785261355; cv=none; b=pefmGJvY3GbDHPHTXUoVdJxRDHtwgs/8U+J2jssZpMkFXsksj5x+tB982w+nqg++FTPazypXiVHN3yn5b6glHAs7vumX/G3UnK5huobtNsWqc7ta/rFFcpebCo68Tj8WA6AiLatnlEvezLtTcP82/X87YJtFGVO+2VKBUTjCmmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785261355; c=relaxed/simple;
	bh=PsGqV3KZqszTG5pqSW6yB97ram1KCaHTGcMRWWmyTvw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UhvW11MQvtmcXtipfexeLlZ+hKdVe4XkOzukR0ABk3xfC/XD0psiDGun9CO6R/HSljs54eTCxh3I/Cqkl1zzulB1PAz3iIFyybSQ1xjB7/4zgVMV7bmBCRaw66qjWv1LbLcPuoViek6Pe/X4b4Hm1MGGQjv3eEwwIMWlO4a9EY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6er4+N3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6er4+N3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A871F000E9;
	Tue, 28 Jul 2026 17:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785261353;
	bh=EhYjqIHSoj0otrbuOStBD7bF+obNeqFSWt1lXUFV9HY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B6er4+N3TNurJ5fQtIVpSp6ly7JSbV8PPsFBbfaqyGiiTuIwZ48F2iY5LXcRcW3T3
	 91quoAYlzeMdCocaCQjOQ1+120ao5wfwdm33ONUCdrY6QRdkkXtd1m4ugYCa3kzQAo
	 P9u0YJswyp8BYxDYEY5+HHtWG5vKdgl1EtHAawydus2mLmQqgNzTdwj1CundKh+ND2
	 no4ynqW0UOkvzJeFrxNJCvLoeRjC84Uvtfx8qnkzrUO7g5+A+SZaPWlBIrmpqFUNET
	 9eeGnlAH9Eieqiy6MRgLbcxrYU3MgDUWr7XZNn5ltLmBhtv6wLHMHxAyr9BCA53n8W
	 9GNAAT/mbMIwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/13] KVM: selftests: Fix RAX and RFLAGS VMCB
 offsets when running L2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728174232.2423257-3-yosry@kernel.org>
References: <20260728174232.2423257-1-yosry@kernel.org>
 <20260728174232.2423257-3-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:55:52 +0000
Message-Id: <20260728175552.A7A871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The inline assembly macros LOAD_GPR_C and SAVE_GPR_C use incorrect=
 offsets to access guest_regs, shifted by 8 bytes. This corrupts guest regi=
sters and causes an out-of-bounds access that clobbers the rflags variable.
--

--- Patch [2]: [PATCH v5 02/13] KVM: selftests: Fix RAX and RFLAGS VMCB off=
sets when running L2 ---
commit b67ef5c1f8e53b1e2adf72da7c94eb12e46b483e
Author: Yosry Ahmed <yosry@kernel.org>

KVM: selftests: Fix RAX and RFLAGS VMCB offsets when running L2
   =20
This commit corrects the offsets for rax and rflags within the VMCB save
area. It uses the vmcb->save.rax and vmcb->save.rflags C variables directly
as parameters in the inline assembly, avoiding hardcoded miscalculated
offsets.
   =20
Link: https://lore.kernel.org/all/20260521092311.86030-1-pbonzini@redhat.co=
m/
Closes: https://sashiko.dev/#/patchset/20260518202514.2037078-1-yosry%40ker=
nel.org?part=3D1

> diff --git a/tools/testing/selftests/kvm/lib/x86/svm.c b/tools/testing/se=
lftests/kvm/lib/x86/svm.c
> index 1445b890986fd..766d15f1d534a 100644
> --- a/tools/testing/selftests/kvm/lib/x86/svm.c
> +++ b/tools/testing/selftests/kvm/lib/x86/svm.c
> @@ -164,19 +164,22 @@ void run_guest(struct vmcb *vmcb, u64 vmcb_gpa)
>  {
>  	asm volatile (
[ ... ]
>  		LOAD_GPR_C
>  		"vmrun %[vmcb_gpa]\n\t"
>  		SAVE_GPR_C

[Severity: High]
This is a pre-existing issue, but I noticed an out-of-bounds memory access
in tools/testing/selftests/kvm/lib/x86/svm.c related to the SAVE_GPR_C macr=
o=20
used here in run_guest().=20

The macro at line 135 contains the instruction "xchg %%r15, guest_regs+0x80=
".

Since struct gpr64_regs is exactly 128 bytes (0x80) long, doesn't this
instruction write past the end of the guest_regs structure and overwrite the
adjacent rflags variable?

Could the offsets in LOAD_GPR_C and SAVE_GPR_C be shifted by 8 bytes, causi=
ng
them to initialize guest registers from the wrong offsets and corrupt memor=
y?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728174232.2423=
257-1-yosry@kernel.org?part=3D2
