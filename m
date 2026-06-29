Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DED3382F3
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782701159; cv=none; b=ixNGQbzlkTMB+VciN2qI1u3AEHQnjNeyza5sQZyI2AOGU22TIoD6HMC+NuNNH+jcNm51XRReE3BtvAkdf8uxxSMtbsaRbP5d8U1IqnfZ4SbUWKjqpuqszEum9OylRXoTwy+Hp0UtfCCN4rtukgLNrkCkFZ0aoMieO/wfj8rjXLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782701159; c=relaxed/simple;
	bh=ZhCqDaBawFw0Fmwi0ASynj4cvnTeCORFS5K6yrOuk3A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cZruupKc0o0Yo8orPkYEM3p7Xg8FlQuUpvFFJD0NnKH/O9kdVCEJu6iTgNVktIWUWj2OfxAa0AfydaBNQox9qvYs+8ErOYoJX02DU1NuNEYGh1L3uWiVCm/mUbAalsXulycsnO2B/nCFU4qaHF8FbDY4fcsPWnVS0ZKXUvEnIyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxNViy8r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxNViy8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C531F000E9;
	Mon, 29 Jun 2026 02:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782701158;
	bh=86OfUi/nHFDWkw+Du7Ql2WTJ8bNoDZ/pxT/RV4x390g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UxNViy8rkl2scVjY9DAbbM9q1OibsL2tVNnZt/IGGBC431TKx8vPBNxzfK8sebOvE
	 bfGUwhREIpYg8YoqyrV3Oo75FUyfrsLVdWEJiUhGR+jsUVyZCrfsE/3ih/lc5Ka0de
	 cBTsPci8V0oSehtEFS5R4rE3dmMgWEjR+5pOn9gF5KZ2t2cbicXwfrnk91R0YIRUsg
	 /t24bSkyQ95+9ydRXkfxkt+UIH+tK+PEf3I6VpHf+0pM/g8dLkHalX1tJIuQt0tuKX
	 R4qz1BBVfgtgt3h669RCW5B9q/hMw9WlgfwzaFOjLYbDDJ6rNntNqggU2JoyQcVmEc
	 8cnyi6X/bpUgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] LoongArch: KVM: Set default MAILBOX access size
 with 8
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260629023213.597030-2-maobibo@loongson.cn>
References: <20260629023213.597030-1-maobibo@loongson.cn>
 <20260629023213.597030-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 02:45:57 +0000
Message-Id: <20260629024558.27C531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Guest-triggerable Host Denial of Service via WARN_ONCE assertions.

Pre-existing issues:
- [High] Guest-triggerable Host Denial of Service via WARN_ON_ONCE on unali=
gned IOCSR access.
- [High] Slab-Out-Of-Bounds memory read in `read_mailbox()` causes KASAN pa=
nic.
--

commit cd8b88f78bdc2b7a47541c3fb91dfaf558c8c761
Author: Bibo Mao <maobibo@loongson.cn>
Date:   Mon Jun 29 02:32:11 2026 +0000

    LoongArch: KVM: Set default MAILBOX access size with 8
   =20
    With IOCSR instruction emulation in function kvm_emu_iocsr(), the possi=
ble
    size combination is 1/2/4/8 and no other combinations. Here remove the
    old default case and replace the default case with 8 in read_mailbox()
    and write_mailbox().
   =20
    Signed-off-by: Bibo Mao <maobibo@loongson.cn>

> diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
> index 4fa0897d7bdb0..d70bf415c7fc6 100644
> --- a/arch/loongarch/kvm/intc/ipi.c
> +++ b/arch/loongarch/kvm/intc/ipi.c
> @@ -67,11 +67,8 @@ static uint64_t read_mailbox(struct kvm_vcpu *vcpu, in=
t offset, int len)
>  		return data & 0xffff;
>  	case 4:
>  		return data & 0xffffffff;
> -	case 8:
> -		return data;
>  	default:
> -		kvm_err("%s: unknown data len: %d\n", __func__, len);
> -		return 0;
> +		return data;
>  	}
>  }

[Severity: High]
This is a pre-existing issue, but does read_mailbox() unconditionally read 8
bytes from the buffer, exceeding the 32-byte bounds if the requested offset
and length approach the end of the allowed range (e.g., offset 0x3c with
length 4)?

Looking at read_mailbox():

    arch/loongarch/kvm/intc/ipi.c:read_mailbox() {
        ...
        spin_lock(&vcpu->arch.ipi_state.lock);
        data =3D *(ulong *)((void *)vcpu->arch.ipi_state.buf + (offset - 0x=
20));
        spin_unlock(&vcpu->arch.ipi_state.lock);
        ...

A guest performing a valid 4-byte IOCSR read at offset 0x3c causes
read_mailbox() to calculate the array index as 0x1c (28). Dereferencing an
8-byte ulong pointer from this index within the 32-byte
vcpu->arch.ipi_state.buf array reads bytes 28 through 35, where bytes 32-35
fall outside the bounds of the array into adjacent fields in struct
kvm_vcpu_arch. Could this out-of-bounds memory read trigger a KASAN panic,
causing a host denial of service?

[Severity: High]
This is a pre-existing issue, but can an unprivileged guest trigger a host
denial of service via WARN_ON_ONCE on unaligned IOCSR access?

Looking at loongarch_ipi_readl() and loongarch_ipi_writel():

    arch/loongarch/kvm/intc/ipi.c:loongarch_ipi_readl() {
        ...
        offset =3D (uint32_t)(addr & 0x1ff);
        WARN_ON_ONCE(offset & (len - 1));
        ...

If a guest executes an IOCSR instruction with an unaligned address (e.g.,
iocsrrd.w at address 0x1001), the hardware/emulated offset is calculated as
addr & 0x1ff, which will be unaligned. This causes the
WARN_ON_ONCE(offset & (len - 1)) assertion to fire, which can panic the host
kernel if panic_on_warn is enabled.

[Severity: High]
While the intention may have been to reduce log spam by replacing kvm_err()
with WARN_ONCE(), does this inadvertently create a denial of service vector?

Looking at mail_send() in arch/loongarch/kvm/intc/ipi.c:

    arch/loongarch/kvm/intc/ipi.c:mail_send() {
        ...
        if (unlikely(vcpu =3D=3D NULL)) {
            WARN_ONCE(1, "%s: invalid target cpu: %d\n", __func__, cpu);
            return 0;
        }
        ...

And in kvm_complete_iocsr_read() in arch/loongarch/kvm/exit.c:

    arch/loongarch/kvm/exit.c:kvm_complete_iocsr_read() {
        ...
        default:
            WARN_ONCE(1, "Bad IOCSR length: %d, addr is 0x%lx\n", run->iocs=
r_io.len, vcpu->arch.badv);
            er =3D EMULATE_FAIL;
        ...

An unprivileged guest can deliberately provide invalid inputs (e.g., an
unknown IOCSR address, an invalid target CPU ID for a mailbox send, or an
unsupported MMIO length). This causes the emulation handlers to hit these
WARN_ONCE() macros. Could this allow a malicious guest to trigger a kernel
panic if panic_on_warn is enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629023213.5970=
30-1-maobibo@loongson.cn?part=3D1
