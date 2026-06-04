Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C156A3CA487
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 20:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780606045; cv=none; b=IksoP+LFXiRy91kdzDkArmv4xctzzziexyZbJ5po9xMU1CHsjBNCe36YvDN7Y+LCAg9Ap3wumGD1tkh4iJiE8F8MA2PzBT130Ci6NoE6hiMYDAkBw2lZfJYDXqKny9KjYUFOLT2t+qsndMfgZBSi0u7iAxZP7cr7vqFRoQ7Nsic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780606045; c=relaxed/simple;
	bh=EfBGX5WM83FmJ0rde7CZvwML3EUI+3klaa2h/N+97m4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lzc+DO9gk9FzzQWJAFc/oxITf7zZkzmyqfcRcB8Ig9ISvOR3evaabNiUef5ykfmhVENPuVfxhM5IV5eAikiZVMgrSf1w2IAv5D6hENWU3D2WRMcH8uqboLzKmDi7wKneKHSZPWlUnaDYUTV23HZzp6Y64vsBcNS7dZk4KEZK6sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6Ev0se3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6Ev0se3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CB81F00893;
	Thu,  4 Jun 2026 20:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780606044;
	bh=uXtk5E2Hp0YTQ0vZRT1y/PGMo+8cQMgFz5uapMN8JM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M6Ev0se35zia4WtEoUbUIDZ9NyC9V9t4Mk8Lr234KqiY40lUdGUCeOgMljzKhuA3U
	 vB0P6kq5Angl3CSdO+DC2yGT12nyVJlDdeghSUPUavajjkGYyOSq3JEZZoCSykcCPD
	 VUO87n2LRe84Rzw2mQ2bRrYcNLctkRx3UH+NT2ll6/BSjlQ8FE/9z8VMkEuQVpK7RX
	 dEKZtip85QCM4x4krbh3GGLEY4wVB1yfoJWHyCyA6FJhLTh0sVecHnx8xMp8IOY8jK
	 YWB3Po4PRtFHf8AObpVaAHyUBpAfWfrRiZ2KsjjtNKRz+UgQexfDqbhKylQQ+Na3xO
	 v/4M9IU/gaHlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/10] KVM: selftests: Move GPR load/save definitions
 outside of nSVM code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604203546.365658-5-yosry@kernel.org>
References: <20260604203546.365658-5-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:47:23 +0000
Message-Id: <20260604204724.48CB81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `guest_regs` array is incorrectly sized (15 instead of 16), =
leading to an out-of-bounds memory access when saving/restoring the R15 reg=
ister.
--

commit 776bec433fbb092e9b3d73813e7a34673cb5fbbb
Author: Yosry Ahmed <yosry@kernel.org>

KVM: selftests: Move GPR load/save definitions outside of nSVM code

This commit moves the guest_regs array declaration and the GPR switching
macro to processor.h. This is done in preparation for reusing the code for
nVMX tests.

> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/=
testing/selftests/kvm/include/x86/processor.h
> index ff0b270bfe27f..57f81f0bcc42d 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -414,6 +414,11 @@ static inline unsigned int x86_model(unsigned int ea=
x)
>  #define GUEST_REGS_R15	15
>  #define NR_GUEST_REGS	GUEST_REGS_R15
> =20
> +extern u64 guest_regs[NR_GUEST_REGS];
> +
> +#define GUEST_SWITCH_GPR_ASM(reg, idx) \
> +	"xchg %%" #reg ", guest_regs + 8 *" XSTR(idx) "\n\t"

[Severity: Medium]
Since NR_GUEST_REGS is defined as GUEST_REGS_R15 (15), does this allocate
guest_regs with only 15 elements (indices 0 to 14)?

If so, won't saving and restoring the R15 register use index 15, which
evaluates to guest_regs + 120, resulting in an 8-byte out-of-bounds read/wr=
ite?

This off-by-one error was introduced earlier in the patch series when repla=
cing
the 16-element gpr64_regs struct with an array. Moving guest_regs to
processor.c in this patch alters the memory layout. Previously, the
out-of-bounds access silently corrupted the adjacently declared rflags vari=
able
(which was safely overwritten immediately afterward), but now it will silen=
tly
corrupt whichever variable immediately follows guest_regs in the .bss secti=
on.

> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/test=
ing/selftests/kvm/lib/x86/processor.c
> index 4ca48de7a926d..44a7233d69900 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
[ ... ]
> @@ -29,6 +29,8 @@ bool host_cpu_is_amd_compatible;
>  bool is_forced_emulation_enabled;
>  u64 guest_tsc_khz;
> =20
> +u64 guest_regs[NR_GUEST_REGS];
> +
>  const char *ex_str(int vector)

> diff --git a/tools/testing/selftests/kvm/lib/x86/svm.c b/tools/testing/se=
lftests/kvm/lib/x86/svm.c
> index 1bd111e8bed26..6528a6416c178 100644
> --- a/tools/testing/selftests/kvm/lib/x86/svm.c
> +++ b/tools/testing/selftests/kvm/lib/x86/svm.c
[ ... ]
> @@ -13,7 +13,6 @@
> =20
>  #define SEV_DEV_PATH "/dev/sev"
> =20
> -u64 guest_regs[NR_GUEST_REGS];
>  u64 rflags;
> =20
>  /* Allocate memory regions for nested SVM tests.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604203546.3656=
58-1-yosry@kernel.org?part=3D4
