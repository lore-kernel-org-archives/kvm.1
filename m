Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6CF31E82F
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780128479; cv=none; b=cOBg/31SApkJFhlDxQ58DLqYfTwVrDXowGbK4XW9UOHwX0fBoPIyGNSxGoBR5BXz+UbWkAxZAEv9KndoaAV0fKJX9Y48UC/ADcz9uIhvxZThwYgI3lKxjFn4W9ZIwBpCOvj76wwmSlsKUp2UqPJZ/uQB4N2AiLNVDXSuQ3B6CP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780128479; c=relaxed/simple;
	bh=Y63WGygLnDMDJDi04zLcJhv7H3VFBswDV/0HPB6kXww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jVzA+ivgV/iThbcDesXwtSsJ0gx/K5AiY3AaSGy8eSjcLALx8LL6qpl5rF38BXyosXinJW/vhZt1KN9gTqfaQgmeLbWyqbKVgDtPGp/7kZQGOIo9ntqLYxpDoUiP6AP4C1y8g+tT4NwPBv2oPFj+naFEDlICUxpi5bFGO/AVD4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kivZfBKT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kivZfBKT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EF81F00893;
	Sat, 30 May 2026 08:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780128477;
	bh=1m8mExdA4wu3S1hrcYF7NQJ0aK6azIG11hUfwHVWIs0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kivZfBKTgLH3UyUvWRllN+g0+bJfijD13WPb4zV8Moce3Ca4V+7lQWTXdf8VIlAB3
	 m/pD4t9Ympu3xB9uBnTatm99xTt6DpOoqEus2p/HgNdE+I9H8cqSGmt8WaGOsGikV3
	 jaamwzvPNe79XMxpDrc4fvkDxjLiNTSiVD7YJbuk0pVbGbuhfRDX/W3YE6Pp/jpRHR
	 q1CdELwmxl/y1SKo5bG5uPczVSOTT0N5mLDaAUnHIklSI1EAYRaG/LIJ1ZzR0hDOhl
	 vfU3nwDlKtjdIHv5MJ1PQ3or7WpE04Tb5gh8S9ssLJm1yxYH7z1bNAGUDajNuXybfv
	 Y/ZXjphY+7wlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 20/27] KVM: s390: arm64: Introduce host definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529155050.2902245-21-seiden@linux.ibm.com>
References: <20260529155050.2902245-21-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 08:07:57 +0000
Message-Id: <20260530080757.B8EF81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Macro `__ctxt_sys_reg` returns NULL, breaking KVM_GET_ONE_REG/KVM_=
SET_ONE_REG for ELR_EL1 and SPSR_EL1
--

commit e22b4e249b651c1cc6aa77134aa91b1e8f9d4063
Author: Steffen Eiden <seiden@linux.ibm.com>
KVM: s390: arm64: Introduce host definitions

This commit adds basic definitions the arm on s390 KVM host requires,
including struct kvm*arch definitions, function prototypes, and various
macros required to run arm64 guests.

> diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/a=
sm/kvm_host_arm64.h
> new file mode 100644
> --- /dev/null
> +++ b/arch/s390/include/asm/kvm_host_arm64.h
[ ... ]
> +/* Minimal (=3Dno) vgic definitions */
> +#define KVM_IRQCHIP_NUM_PINS 1
> +#define irqchip_in_kernel(_v) false;
> +
> +#define __ctxt_sys_reg(ctx, reg) NULL

[Severity: High]
Does defining this macro to return NULL break KVM_GET_ONE_REG and
KVM_SET_ONE_REG for ELR_EL1 and SPSR_EL1?

Shared code in virt/kvm/arm64/guest.c uses this macro to resolve the storage
address of core registers ELR_EL1 and SPSR_EL1. Returning NULL causes
core_reg_addr() to return NULL, resulting in the ioctls failing with -EINVA=
L.

However, copy_core_reg_indices() includes these registers in the list retur=
ned
by KVM_GET_REG_LIST because core_reg_size_from_offset() returns a valid size
for them.

Advertising support for registers in KVM_GET_REG_LIST but failing to get or
set them is an API contract violation that can cause userspace VMMs like
QEMU to abort during vCPU initialization.

> +struct kvm_cpu_context {
> +	/*
> +	 * These are just for 32 bit, which we don't have, making them RES0.
> +	 * They are exposed to user space.
> +	 */
> +	u64	spsr_abt;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529155050.2902=
245-1-seiden@linux.ibm.com?part=3D20
