Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBA637FF41
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780078435; cv=none; b=NjyUk8dGQPumkRN1t0ff098WwitEIYjPxAIo9j5wAYBKT3GD5SHTgwQkxWb9nmOzOJRWcOM1+oUBADifKCUWZGS5loPMTQCJfujOQAJqiz/ml4OVbjItLPLuo/WeRoN2KJLkU/gDFQBUd0WpPcyWTgpGj97EevFNHjk9ipFqVXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780078435; c=relaxed/simple;
	bh=CKh8v8Tm28cz2zpF2BWK0N+Fy0zmyPy6wEtdZkpyCf8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sSUlibOsXV5sj7+35b0PKNR4K8pAbOJATTCsyKvknqGA3l/kO6ol5B7vDOUgbFjp1uzAC1da9E/vzZZOltltFZdN6xeUfnLWmaROAkYVHorwWo8hrcKR2/AuI1kbpf8Yx/lB34OTy3DWw8/C8L8gUNT6wII/BT5JpiYMOAGGqxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PL9RbHAS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PL9RbHAS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6BD1F00893;
	Fri, 29 May 2026 18:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780078434;
	bh=CKh8v8Tm28cz2zpF2BWK0N+Fy0zmyPy6wEtdZkpyCf8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PL9RbHASJ66iUASGxEO3968bC576crfoMnSNJ3YbdNyiNsbNO7+HdviPt0dLmRJTe
	 Dn38iDbXRFlcJMl+sIR9GnCdoKYd2EWpH0RQNNGGTnYRMI1Q8XWHCt2Wn3D6wh27Gy
	 XmC6ZHKCmump5vN4PNsMzZLkMWO9vIoAQ8eVuV4JBCgX6KMa0c9EBI5ZrQQ9fl6u/f
	 ubIr5RSHNrrpXJcq1+qvMlRCdOV519uc71M8jMvl0Gz0SxdKTKMA8sPlYhyZKou9aw
	 Jhx8Al8cMahwfdXZQ5jg1v+50QfCbSK6cCGgrdQt7MrwrZJeUt9C4LGIR8fQhq2uVY
	 9CSJJHvriB/Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/27] KVM: arm64: Share kvm_emulate definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529155050.2902245-10-seiden@linux.ibm.com>
References: <20260529155050.2902245-10-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 18:13:53 +0000
Message-Id: <20260529181354.2A6BD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The forward declaration of `kvm_vcpu_get_esr` in the shared header =
is missing the `inline` keyword.
--

commit cd45780d22b912a0d1f22d6af7c40c20667b35da
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: arm64: Share kvm_emulate definitions

This commit moves functions and definitions useful for emulating arm64
instructions from arch/arm64 to include/kvm/arm64 so they can be shared.

> diff --git a/include/kvm/arm64/kvm_emulate.h b/include/kvm/arm64/kvm_emul=
ate.h
> new file mode 100644
> index 0000000000000..25322b95af21b
> --- /dev/null
> +++ b/include/kvm/arm64/kvm_emulate.h
> @@ -0,0 +1,268 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef KVM_ARM64_KVM_EMULATE_H
> +#define KVM_ARM64_KVM_EMULATE_H
> +
> +#include <asm/esr.h>
> +#include <asm/pstate.h>
> +#include <asm/sysreg-defs.h>
> +
> +static inline bool kvm_vcpu_is_be(struct kvm_vcpu *vcpu);
> +static __always_inline unsigned long *vcpu_pc(const struct kvm_vcpu *vcp=
u);
> +static __always_inline unsigned long *vcpu_cpsr(const struct kvm_vcpu *v=
cpu);
> +static inline bool kvm_vcpu_trap_is_permission_fault(const struct kvm_vc=
pu *vcpu);
> +static u64 kvm_vcpu_get_esr(const struct kvm_vcpu *vcpu);

[Severity: Low]
This isn't a bug, but should this forward declaration include the "inline"
keyword? The surrounding forward declarations use "static inline" or
"static __always_inline" to match their definitions, but this one is just
"static u64" which creates a slight stylistic inconsistency.

> +static __always_inline bool vcpu_mode_is_32bit(const struct kvm_vcpu *vc=
pu);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529155050.2902=
245-1-seiden@linux.ibm.com?part=3D9
