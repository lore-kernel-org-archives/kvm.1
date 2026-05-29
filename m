Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2512E36212E
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076735; cv=none; b=rCj5cvbaBOgAEFADNPX2UBWo7XUmO3PBb2/l+3C0Kb0ZnF64njIO4CSGOQ57UxrBCb6uUwgNZkUVdVaBC7vjXpHefl/s1eHNlKcZ2+Q65l9sGKm7M22ZawA6OLXjDeSYqYXC5nyzzLvMra04fzM3vct07KXTpzguI2MOdoxJbSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076735; c=relaxed/simple;
	bh=sg1Wxh9pQQ50bSDk8WpnEbo4MAPMG99ATA7sj0CAGl4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hEr3sOsOGN8Xlb5lg3H0Z/IXiePAbwi3N0UehroDOmpZn9zbq8JSv9+DAWhIkorFCVWLzZQl+FBNbv4z9ernQ3vydMuLTHaTEx32SLaCKy2yqvX6TY/jRU0B8CFudxoImTHxAWg5IvgmIlxpkQ6YOlnzNtQdRB+u+XrunbS+7TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXIPVXAi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXIPVXAi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EF91F0089A;
	Fri, 29 May 2026 17:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780076733;
	bh=H0LRuS6TDXECXe53S/EBBidUhK8yDh5luQOJm5KJ070=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EXIPVXAiZLazT2a1VzWbTkM/f0IvWygw9Qqu5Ts1KrBIfiDItTQCJbh2vRdDYENPK
	 bZHqbHdXV7QQrHPMtd7CtmDKkyQcT8lWJ0g/JH5MAImupzQpJYF7lqstn0CCdZ7H+4
	 S55F3/m2flS05YOhbxX8Lndv+Gav0fDblDULpNdIFsbyDuJuoGKHfzLzwrdtMV2wSc
	 DtwUwv0CkcRneStiLFbOPb36zuwHtilAXkl77vmEBU5QPHVd0NGoiK9SmBfhgYlNLQ
	 ASwmmopp1RcLDoLlT6hIdIdU2TnkvK6Tckzz6o7LEk3tb+1/mJqVxNkf5tqPx4FumJ
	 AQkdDcJt8YYFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/27] KVM: arm64: Provide arm64 KVM API for
 non-native architectures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529155050.2902245-8-seiden@linux.ibm.com>
References: <20260529155050.2902245-8-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 17:45:32 +0000
Message-Id: <20260529174533.60EF91F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The refactoring of `kvm_arm.h` violates the design convention ex=
plicitly stated in the commit message.
- [Low] `system_supported_vcpu_features()` is made globally visible without=
 a prototype declaration.
- [Low] Newly extracted headers are not self-contained and lack necessary f=
orward declarations and `#include` directives.
--

commit 106dc17001f0c5affae224d8814a51a51af0225e
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: arm64: Provide arm64 KVM API for non-native architectures

This patch moves KVM-related headers to include/kvm/arm64/ to decouple them
from the arm64 architecture directory. This allows non-native hosts to cons=
ume
the arm64 KVM infrastructure without duplicating code.

> The KVM-related headers are moved to include/kvm/arm64/, decoupling them =
from
> the arm64 architecture directory. The design convention is that
> architecture-specific headers under <arch>/include/asm/ include from this
> shared location, allowing non-native hosts to consume the arm64 KVM
> infrastructure without duplicating code.

[Severity: Medium]
The commit message states "architecture-specific headers under
<arch>/include/asm/ include from this shared location". Does moving kvm_arm=
.h
entirely and updating all the source files to include <kvm/arm64/kvm_arm.h>
directly bypass this convention?

Would it be more consistent to leave a wrapper header in
arch/arm64/include/asm/kvm_arm.h as was done for kvm_mmu.h and kvm_host.h?

> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 9453321ef8c67..04a4ef1c7f062 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c

[ ... ]

> @@ -1541,7 +1543,7 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct k=
vm_irq_level *irq_level,
>  	return -EINVAL;
>  }
> =20
> -static unsigned long system_supported_vcpu_features(void)
> +unsigned long system_supported_vcpu_features(void)
>  {
>  	unsigned long features =3D KVM_VCPU_VALID_FEATURES;
> =20

[Severity: Low]
The function system_supported_vcpu_features() is now globally visible. Shou=
ld
a prototype be added to a header file to avoid missing prototype compiler
warnings?

> diff --git a/include/kvm/arm64/guest.h b/include/kvm/arm64/guest.h
> new file mode 100644
> index 0000000000000..fa67d992e8fd2
> --- /dev/null
> +++ b/include/kvm/arm64/guest.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __KVM_ARM64_GUEST_H__
> +#define __KVM_ARM64_GUEST_H__
> +
> +/* Implemented by virt/kvm/arm64/guest.c */
> +unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
> +int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
> +
> +#endif /* __KVM_ARM64_GUEST_H__ */

[Severity: Low]
This new header uses types like u64, __user, and struct kvm_vcpu. Should it
include <linux/types.h>, <linux/compiler.h>, and forward-declare
struct kvm_vcpu so it is fully self-contained?

> diff --git a/include/kvm/arm64/kvm_mmu.h b/include/kvm/arm64/kvm_mmu.h
> new file mode 100644
> index 0000000000000..91607105eaf67
> --- /dev/null
> +++ b/include/kvm/arm64/kvm_mmu.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef KVM_ARM64_KVM_MMU_H__
> +#define KVM_ARM64_KVM_MMU_H__
> +
> +/*
> + * We currently support using a VM-specified IPA size. For backward
> + * compatibility, the default IPA size is fixed to 40bits.
> + */
> +#define KVM_PHYS_SHIFT	(40)
> +
> +/*
> + * We are not in the kvm->srcu critical section most of the time, so we =
take
> + * the SRCU read lock here. Since we copy the data from the user page, we
> + * can immediately drop the lock again.
> + */
> +static inline int kvm_read_guest_lock(struct kvm *kvm,
> +				      gpa_t gpa, void *data, unsigned long len)
> +{

[Severity: Low]
This header uses gpa_t, phys_addr_t, size_t, bool, and srcu functions. Does=
 it
need to include <linux/types.h>, <linux/srcu.h>, and other relevant headers=
 to
ensure it compiles independently?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529155050.2902=
245-1-seiden@linux.ibm.com?part=3D7
