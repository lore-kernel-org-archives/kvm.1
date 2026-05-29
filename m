Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F232FF15B
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780082123; cv=none; b=r855gRBGGNf0/idHQbDPozmDRcIR1crZ36ApN7sauD5NNPhtlwVOPqQc3WYPmeCjoyapLO/jsZ6Xmo3eFpk7UOfMruustutTX1OFbsdues8+5evcjfOPsx3vXqVno5FGaN/dEoqM9Hd4oKP7xPuUEN0GLYVQGcR8cpot086GBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780082123; c=relaxed/simple;
	bh=zx6b3u2afFpFhXVq8TyUzqDdH9h2l6+ItBxLaMZBkyA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ck3XGi+J8X9qWBelYUH11lCdKmW5RZ4WJg1EcfeQchlwvSjkt/qayfGXMl/UT1nDL0gJvLHLxKtrsp6ZJVWBtyyhKe+k7XMzfE3t5S/HIt1B6nS2sRHSsFTsh62UUzKvp8DKZ5VQ7m+XhAlE9mR4KgoBbiYK2QJ3nfA0WXNNWYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etWemmwf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etWemmwf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA1B1F00893;
	Fri, 29 May 2026 19:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780082121;
	bh=+LfuVk2q9qeFN5hiXVM7CGKgGyLnkDffWCWSRnZ7y1I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=etWemmwfDpbSDCpR9MuejoPEFHd9fRMaY4GJGr0nJapkGhhZY1vqF7KuREPFgrZts
	 LTOJgbv0U+GKa70hdVySLY2rPKnKGPUqYpakYuD4kdATL2vOsoskxegfHKK+xlPxAR
	 qLD4bWAsh8DhK0CAm0YheH01HKmeN4OmRFrE5Qnbab3AG/j093JNi2cYkSnDGd4Eoh
	 5vO9WXgX/y9sLJ8r9f43tIzSr1YbB+dsM8Yp0z+hTP40hCzLdwseNk4xIQppjkPOzp
	 mxox1t27VJLv+s6tIedv8TvkCZNgsolZXpzyOUz4NxUE2MG/JgtI2tIJQR0B7GPXdQ
	 ORCV3QFDPgbtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/27] KVM: arm64: Make some arm64 KVM code shareable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529155050.2902245-11-seiden@linux.ibm.com>
References: <20260529155050.2902245-11-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 19:15:20 +0000
Message-Id: <20260529191521.5FA1B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Missing `<linux/uaccess.h>` in `virt/kvm/arm64/guest.c` causes impl=
icit declarations
- [Low] The header `include/kvm/arm64/handle_exit.h` is not self-contained
--

commit de2ec796cee358898f6d5a8336e76db1e095f6a8
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: arm64: Make some arm64 KVM code shareable
   =20
Support sharing architecture-agnostic KVM-arm64 code by introducing a new
directory virt/kvm/arm64. This also modifies core_reg_addr to use functions
instead of direct field accesses for better portability.

> diff --git a/include/kvm/arm64/handle_exit.h b/include/kvm/arm64/handle_e=
xit.h
> new file mode 100644
> index 0000000000000..9f3f41eaf3ac6
> --- /dev/null
> +++ b/include/kvm/arm64/handle_exit.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef KVM_ARM64_HANDLE_EXIT_H
> +#define KVM_ARM64_HANDLE_EXIT_H
> +
> +#include <linux/kvm_host.h>
> +
> +typedef int (*exit_handle_fn)(struct kvm_vcpu *);
> +extern exit_handle_fn arm_exit_handlers[ESR_ELx_EC_MAX + 1];

[Severity: Low]
This header uses ESR_ELx_EC_MAX, but doesn't include <asm/esr.h>.
Will this cause build failures if a C file includes this header without
previously including <asm/esr.h>?

> +
> +int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu);
> +exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu);
> +int handle_trap_exceptions(struct kvm_vcpu *vcpu);
> +
> +#endif /* KVM_ARM64_HANDLE_EXIT_H */
> diff --git a/virt/kvm/arm64/guest.c b/virt/kvm/arm64/guest.c
> new file mode 100644
> index 0000000000000..83e33e0143b93
> --- /dev/null
> +++ b/virt/kvm/arm64/guest.c
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/kvm_host.h>
> +#include <linux/kvm.h>
> +#include <asm/pstate.h>
> +#include <asm/kvm_emulate.h>
> +#include <asm/kvm_nested.h>
> +#include <asm/sigcontext.h>
> +
> +#include <kvm/arm64/guest.h>

[ ... ]

> +int get_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> +{

[ ... ]

> +	if (copy_to_user(uaddr, addr, KVM_REG_SIZE(reg->id)))
> +		return -EFAULT;

[Severity: Low]
This file uses copy_to_user() here, and also uses copy_from_user() and
put_user() later on, but it does not include <linux/uaccess.h>.
Since <linux/uaccess.h> isn't transitively included by the current headers,
will this lead to implicit declaration build errors?

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529155050.2902=
245-1-seiden@linux.ibm.com?part=3D10
