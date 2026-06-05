Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564DF3CE0A1
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654256; cv=none; b=krhLmARbffuZ4NRJ3Zu5CSpbMTSPF2tq0+y6oBWUr5y+aAjLWa1U6gV4f/IBUi14taTt9nML5I/OXisd5998e75XymL0vULRFJcnW1nlkpF20Qh/mykfU0WLV2HlBg92Oq9wRpdCnhBUupg2d+ocXg/UNC5uVG5j8Psbg5+t+88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654256; c=relaxed/simple;
	bh=M5clyrYSnWP5oX7bII6/WTC/MaMjj6g3KK+pIQQpyyY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q68XCntQdtlc6vbKn773zdL90zuZq6pYWMixST7Dg+D+9CkaBUq8DUctx52RKMESdvggw9MUHvuVa6rClKAc9xgot4zJQTLmDmYtixIgZ0ZsZ7XRLEffcMfTFMHMv5XYTeD5qcMhlc69JgIPH3wnSW7TnEv8GEZBhn316oj5qJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RB1n/6K9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RB1n/6K9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018691F00899;
	Fri,  5 Jun 2026 10:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780654255;
	bh=w/oi0BnBXDHhN2Nw3I6N8CnXJv7i3hIsWfscgLha4n8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RB1n/6K9BBAqdsrdi4uhi2htLLDpRrQnF21LBiiYOv1g6XdoAzSRZFkereOnUNukG
	 b8lV0fbX4lrcRCz8KZvxy9JtyZ3zfttx+4m3zz3iMyNAwWxxUQGcV6RvPfAwYGAfk4
	 LBfLGyrjFzaVP9DOEEXYGcrWdT3s6gMWB2bqf4harztuY7U3MtogFeshTQY0p1G8EX
	 grsYj2mDCz+HmDtLGFnqAehPZ1qoCdVa8bHgLqiRLvcJdjVL/Tx4S+QpYSUGyOaK/O
	 PXPqhAMpr4rjsadHVlfWniqd2F+EQKrcYcyA3/yJjMxeSSioG1NL0FfiW3HroW/u6x
	 T9ZEeIUtdgoyw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/3] KVM: x86: add DSM IRQ forwarding ABI and
 state
Reply-To: sashiko-reviews@lists.linux.dev
To: muliang.shou <muliang.shou@sjtu.edu.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260605100031.834938-2-muliang.shou@sjtu.edu.cn>
References: <20260605100031.834938-2-muliang.shou@sjtu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 10:10:54 +0000
Message-Id: <20260605101055.018691F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Kernel Kconfig macros are used to conditionally define UAPI fi=
elds, hiding the newly introduced ABI from userspace.
- [Critical] New guest-visible exit reasons are introduced without a discov=
erable KVM capability (`KVM_CAP_*`).
- [High] Implicit padding and the use of the non-standard `bool` type in UA=
PI structures compromise 32-bit and 64-bit ABI compatibility and risk infor=
mation leaks.
- [Low] Comment documenting the UAPI structure references a non-existent ma=
cro.
--

commit 7ee1020a0c775261e0fcbfed54c6ddf9a606d235
Author: muliang.shou <muliang.shou@sjtu.edu.cn>

KVM: x86: add DSM IRQ forwarding ABI and state

Add the Kconfig knob, request id, per-vCPU state, and userspace ABI
needed to report DSM IRQ forwarding events to userspace.

> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 801bf9e520db3..bd3a97f115284 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -240,4 +240,16 @@ config KVM_MAX_NR_VCPUS
>  	  the memory footprint of each KVM guest, regardless of how many vCPUs =
are
>  	  created for a given VM.
> =20
> +config KVM_DSM_IRQ_FORWARD
> +	bool "KVM DSM interrupt forwarding support"
> +	depends on KVM && KVM_INTEL
> +	default n
> +	help
> +	  Provide support for interrupt forwarding in distributed KVM.
> +	  When enabled, guest ICR/ICR2 writes are intercepted and
> +	  forwarded to userspace via KVM_EXIT_DSM_SEND_IRQ exit,
> +	  allowing cross-node IPI delivery in a distributed KVM setup.
> +	  This feature can be used independently of the full DSM memory
> +	  coherence framework.
> +

> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 6c8afa2047bf3..75a11e72e232e 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -194,6 +194,17 @@ struct kvm_exit_snp_req_certs {
>  #define KVM_EXIT_ARM_LDST64B      42
>  #define KVM_EXIT_SNP_REQ_CERTS    43
> =20
> +#ifdef CONFIG_KVM_DSM_IRQ_FORWARD

[Severity: Critical]
Will make headers_install strip this CONFIG_ macro via the unifdef tool?

Using a kernel-only CONFIG_ macro in a UAPI header will completely hide the=
se
definitions from userspace programs compiling against the sanitized headers,
preventing userspace from using the new ABI.

> +/* DSM exit reason: distributed APIC region access */
> +#define KVM_EXIT_DAPIC            44
> +/* DSM exit reason: IPI forwarding to userspace */
> +#define KVM_EXIT_DSM_SEND_IRQ     45

[Severity: Critical]
Are these new guest-visible exit reasons discoverable via a KVM capability
(such as KVM_CAP_*)?

By introducing KVM_EXIT_DSM_* exit reasons conditionally via a static kernel
configuration without requiring userspace capability negotiation, KVM will
unconditionally intercept these events and inject unhandled exit reasons in=
to
legacy userspace processes like QEMU.

> +/* DSM exit reason: X2APIC ICR write forwarding to userspace */
> +#define KVM_EXIT_DSM_X2_ICR       46
> +/* DSM exit reason: APIC base MSR write forwarding to userspace */
> +#define KVM_EXIT_DSM_APIC_BASE    47
> +#endif
> +
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

[Severity: Low]
This isn't a bug, but the comment references KVM_EXIT_DSM_X2APIC instead of
KVM_EXIT_DSM_X2_ICR, which is the macro defined above.

> +		struct {
> +			__u32 id;
> +			__u64 data;
> +		} x2apic;

[Severity: High]
Does this UAPI structure create architecture-dependent implicit padding?

Placing a 64-bit data field after a 32-bit id field introduces 4 bytes of
implicit padding on 64-bit architectures, but 0 padding on 32-bit x86 where
__u64 is 4-byte aligned. This structural mismatch changes field offsets and
breaks 32-bit userspace compatibility on a 64-bit kernel, and the padding
bytes risk leaking uninitialized kernel memory.

> +		/* DSM APIC base write data (KVM_EXIT_DSM_APIC_BASE) */
> +		struct {
> +			__u32 id;
> +			bool host;
> +			__u32 index;
> +			__u64 data;
> +		} x2msr_base;

[Severity: High]
Can the use of the non-standard bool type and field ordering create issues =
in
this UAPI structure?

The bool type is non-standard in UAPI headers and depends on <stdbool.h>.
Additionally, this layout introduces 4 bytes of implicit padding before the
data field on 64-bit architectures, but not on 32-bit, further compromising
compatibility and risking information leaks.

> +#endif
>  		struct {
>  			__u64 hardware_exit_reason;
>  		} hw;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605100031.8349=
38-1-muliang.shou@sjtu.edu.cn?part=3D1
