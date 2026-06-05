Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BC83D333E
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652903; cv=none; b=BNz48ztIPpnBYUQVNDjCWk1eKHu0++QvbdjX30vjM65MIqrlV9o/6aTkq2TUS474+vEkU0jHBLKzVjzpZJ/LMlenjIehrGDydHjHYkjuVA1+bMaprKHyuO20jdVjqpl6XipjmQxEqlmZpXcs9Z0oKat5mzCASrfHO5YM4EPbVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652903; c=relaxed/simple;
	bh=YDBYuVGjfJCs8tEXd6pzkvGiUAdd+wANt7gCrJixHL0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ciqXWPyT2aKCktUZ5x+V/SFFa6aZh3loSyYfJqmvRZs4U7M5wQ1qY9QwXN96uCdEy6gjj+TBg2Xv/EkY4bU11lAd317a+HNZnOfLms9afjTsQJTWzd/9xx1MkebxtCbt/0OdzLMSS6khVEtHjZ3esIDPBaoGw77jFWFwctm6FJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhGoLk2X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhGoLk2X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7E91F00893;
	Fri,  5 Jun 2026 09:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780652900;
	bh=JunhgmZXh/01tCCiv9bvBgmLPu9HHlYLf55PzWI58Zo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LhGoLk2Xuzts3BkwBJCOrRyKLpZadvdvCz6ujbI51Indr3horqmEaqm+tVRO+TyD5
	 gdsn40bcC1Nv4bqYJCY8sTJVuxD7vTsJFpPWbyiMplRlN/o00dMYoqZfFkOpd1CCs2
	 TpQqrO9pxB4v5V8L4GWk9ARLqpuTpvBKqwo5gzrR4yQmyM7ErdUhtMTeWISSi3YSXj
	 8Ardg9QiCk31bCLnbV31e6wY9t5yoBpeLDZ3n1iiVG2z96xw4kqf0Y62z4hG4k3QXO
	 sihDyXEg3YXxrfK4fH35zc9H+mbnFekdeUUc0qrV/9eCUKVJ6F17OD+ZgTIsG9HGL3
	 1oqB6ugNIPhGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] KVM: x86: add DSM IRQ forwarding ABI and state
Reply-To: sashiko-reviews@lists.linux.dev
To: muliang.shou <muliang.shou@sjtu.edu.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260605093857.747735-2-muliang.shou@sjtu.edu.cn>
References: <20260605093857.747735-2-muliang.shou@sjtu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 09:48:19 +0000
Message-Id: <20260605094820.4D7E91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] New KVM exit reasons and guest-observable behaviors are introd=
uced without KVM capability enumeration, breaking backward compatibility.
- [High] Exposing kernel-internal `#ifdef CONFIG_KVM_DSM_IRQ_FORWARD` macro=
s in a UAPI header hides definitions from userspace.
- [High] Invalid UAPI struct layout in `x2apic` and `x2msr_base` due to the=
 use of `bool` and unaligned 64-bit integers causing implicit padding.
--

commit 0e0a77dd8b9e6279a96c0e7870ab0b326b932eba
Author: muliang.shou <muliang.shou@sjtu.edu.cn>

KVM: x86: add DSM IRQ forwarding ABI and state

Add the Kconfig knob, request id, per-vCPU state, and userspace ABI
needed to report DSM IRQ forwarding events to userspace.

> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
[ ... ]
> @@ -240,4 +240,16 @@ config KVM_MAX_NR_VCPUS
>  	  the memory footprint of each KVM guest, regardless of how many vCPUs =
are
>  	  created for a given VM.
> =20
> +config KVM_DSM_IRQ_FORWARD
> +	bool "KVM DSM interrupt forwarding support"
> +	depends on KVM && KVM_INTEL
> +	default n

[Severity: Critical]
Does this regression break backward compatibility for existing VMMs?

If this is globally enabled by the kernel config, existing VMMs like QEMU=20
might unexpectedly receive unrecognized exit reasons upon guest IPIs and
abort the VM.

Should new guest-visible behaviors and exit reasons default to off and
require explicit discovery and opt-in via KVM's standard capability
interface, such as KVM_CAP_* and KVM_CHECK_EXTENSION?

> +	help
> +	  Provide support for interrupt forwarding in distributed KVM.
> +	  When enabled, guest ICR/ICR2 writes are intercepted and
> +	  forwarded to userspace via KVM_EXIT_DSM_SEND_IRQ exit,
> +	  allowing cross-node IPI delivery in a distributed KVM setup.
> +	  This feature can be used independently of the full DSM memory
> +	  coherence framework.
> =20
>  endif # VIRTUALIZATION
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -194,6 +194,17 @@ struct kvm_exit_snp_req_certs {
>  #define KVM_EXIT_ARM_LDST64B      42
>  #define KVM_EXIT_SNP_REQ_CERTS    43
> =20
> +#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
> +/* DSM exit reason: distributed APIC region access */
> +#define KVM_EXIT_DAPIC            44

[Severity: High]
Will these definitions be hidden from userspace?

Because userspace programs do not include kernel configuration files,
CONFIG_KVM_DSM_IRQ_FORWARD will be undefined when compiling userspace code.

Kernel build scripts also actively strip CONFIG_* macros in exported header=
s,
which could render this new ABI unusable by userspace.

> +/* DSM exit reason: IPI forwarding to userspace */
> +#define KVM_EXIT_DSM_SEND_IRQ     45
> +/* DSM exit reason: X2APIC ICR write forwarding to userspace */
> +#define KVM_EXIT_DSM_X2_ICR       46
> +/* DSM exit reason: APIC base MSR write forwarding to userspace */
> +#define KVM_EXIT_DSM_APIC_BASE    47
> +#endif
> +
>  /* For KVM_EXIT_INTERNAL_ERROR */
>  /* Emulate instruction failed. */
>  #define KVM_INTERNAL_ERROR_EMULATION	1
[ ... ]
> @@ -243,7 +254,27 @@ struct kvm_run {
>  	__u64 psw_addr; /* psw lower half */
>  #endif
>  	union {
> -		/* KVM_EXIT_UNKNOWN */
> +#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
> +		/* DSM IPI forwarding data (KVM_EXIT_DSM_SEND_IRQ) */
> +		struct {
> +			__u32 id;
> +			__u32 val;
> +			__u32 val2;
> +			__u32 dest_id;
> +		} lapic_irq;
> +		/* DSM X2APIC write data (KVM_EXIT_DSM_X2APIC) */
> +		struct {
> +			__u32 id;
> +			__u64 data;
> +		} x2apic;

[Severity: High]
Does this structure in union kvm_run lack explicit padding before the data
field?

On 32-bit x86, __u64 has a 4-byte natural alignment, whereas on 64-bit x86,
it requires 8-byte alignment.

This can cause the compiler to insert implicit padding on 64-bit systems,
leading to a regression due to ABI mismatches when running a 32-bit userspa=
ce
VMM on a 64-bit kernel.

> +		/* DSM APIC base write data (KVM_EXIT_DSM_APIC_BASE) */
> +		struct {
> +			__u32 id;
> +			bool host;
> +			__u32 index;
> +			__u64 data;
> +		} x2msr_base;

[Severity: High]
Is it safe to use the bool type in a UAPI header here in union kvm_run?

The C bool type is not guaranteed to be defined without stdbool.h and
is generally avoided in UAPI headers.

Additionally, there is implicit padding before the index and data fields,
which can cause a similar 32-bit and 64-bit compatibility regression.

> +#endif
>  		struct {
>  			__u64 hardware_exit_reason;
>  		} hw;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605093857.7477=
35-1-muliang.shou@sjtu.edu.cn?part=3D1
