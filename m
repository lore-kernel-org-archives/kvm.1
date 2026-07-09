Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9EB3F1AA6
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586519; cv=none; b=dHiJDp4qrOOrHht9mQp9b0WjxVMBgNnBd2dqEwPDXUN04NyjEnKh8VpsYuKISQ7EnKCyYk5A7jimfRJNC1xnt05p+eeZIYAgy9KHuyQchtJYRPB//r+4nM/EOibKNMusYzXnYCc7CbLDGN8P7AGiTGE969CPBacBrMt1xrDTjcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586519; c=relaxed/simple;
	bh=hfeHilJ0PMxR5GuafU6rVZ1C1T/vDUvqkRNp4JO86nk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WuoiIZvkWlRvWRa0ea0ccIOxz2UBYRoBCwZH90GTXiQV956+FfXAdiI8a7WDVSjTlNXwZ7V1kEQdztpAJxxpOIwsOJg2QWAcih9hCAetQmv2iBIIQBWXJDXWefINaYqhxKOHepAwsc6roFOWIUaiQBxN5DkZNE/bRGqR9TFu0XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bh9alUeK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bh9alUeK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0101F000E9;
	Thu,  9 Jul 2026 08:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783586515;
	bh=I20wEs5u6KymtvGjeyM3KfD6umP7VtO5lOylY6j+Ask=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bh9alUeKzVAWt8IFs59dp3l5XrUCL4b/4nVAgJXBabPPFaIx52uBvYjcFT7lxbh6t
	 QtVpvutj+IN1qaMBhOeDeASH2B0G1RDEVlZrfHvTFft/M9KL5+mqwKir8jap9feZE4
	 yrpeTh85+GLdHb3opt1Io/GGRAuTNI9vgaTiBjZ+ftOV0eUPIFsBPUDqFD6EtJitn5
	 v8vWeaCm7ogoxjp7mF/ErsUYgNIKzOaJxv0E56SLEaqoA5kgEKnhiemV8RItigbaVR
	 IIJNEbFlztvT4upmVAU8MtVWEGNiXWora6iGKqXZEdHSvW0Y+oKlo1aMF9jF63CuGS
	 I0NOy74DUVvbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] LoongArch: KVM: Set default MAILBOX access size
 with 8
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260709082109.1361767-2-maobibo@loongson.cn>
References: <20260709082109.1361767-1-maobibo@loongson.cn>
 <20260709082109.1361767-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 08:41:54 +0000
Message-Id: <20260709084155.2E0101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Guest-triggerable `WARN_ON_ONCE` via unaligned IOCSR address can c=
rash the host, violating KVM guidelines.
- [High] `read_mailbox()` unconditionally performs an 8-byte read, leading =
to structural out-of-bounds array access and undefined behavior.
- [High] Read-modify-write cycles on IPI mailboxes are not protected by `ip=
i_state.lock`, leading to lost mailbox updates.
--

--- Patch [1]: [PATCH v4 1/4] LoongArch: KVM: Set default MAILBOX access si=
ze with 8 ---
commit ddb469fb4110b13e360da0bda699a489c854b92b
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Set default MAILBOX access size with 8

This commit changes the default mailbox access size to 8 bytes in
read_mailbox() and write_mailbox() to handle IOCSR instruction emulation,
removing the previous error logging for unknown sizes.

> diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
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
This isn't a bug introduced by this patch, but does the unconditional 8-byte
read in read_mailbox() risk an out-of-bounds array access?

Looking at read_mailbox(), it computes a byte pointer into the 32-byte
ipi_state.buf array based on the offset, and unconditionally casts it to an
unsigned long pointer to read 8 bytes before evaluating the size cases:

    data =3D *(ulong *)((void *)vcpu->arch.ipi_state.buf + (offset - 0x20));

If a guest performs a valid 4-byte read at the maximum valid offset, the
function still reads 8 bytes. This means the read extends beyond
ipi_state.buf and bleeds into adjacent struct members. Additionally,
unconditionally reading an 8-byte integer from a potentially unaligned
pointer might result in undefined behavior.

[ ... ]

> @@ -92,11 +89,9 @@ static void write_mailbox(struct kvm_vcpu *vcpu, int o=
ffset, uint64_t data, int
>  	case 4:
>  		*(unsigned int *)pbuf =3D (unsigned int)data;
>  		break;
> -	case 8:
> +	default:
>  		*(unsigned long *)pbuf =3D (unsigned long)data;
>  		break;
> -	default:
> -		kvm_err("%s: unknown data len: %d\n", __func__, len);
>  	}
>  	spin_unlock(&vcpu->arch.ipi_state.lock);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but is there a risk of lost
mailbox updates due to unprotected read-modify-write cycles in mail_send()
and send_ipi_data()?

In mail_send(), the code performs a read-modify-write cycle to update IPI
mailboxes using byte bit-masks:

    val =3D read_mailbox(vcpu, offset, 4);
    for (i =3D 0; i < 4; i++)
        if (data & (BIT(27 + i)))
            mask |=3D (0xff << (i * 8));
    val &=3D mask;
    ...
    val |=3D ((uint32_t)(data >> 32) & ~mask);
    write_mailbox(vcpu, offset, val, 4);

Since read_mailbox() and write_mailbox() acquire and release ipi_state.lock
internally, the lock is not held across the entire modification cycle. If
multiple vCPUs send IPIs with masks to the same target concurrently, could
their operations interleave and overwrite each other's updates?

[Severity: High]
This isn't a bug introduced by this patch, but can a guest deliberately
trigger a WARN_ON_ONCE by providing an unaligned IOCSR address?

Looking at loongarch_ipi_readl() and loongarch_ipi_writel(), they
unconditionally assert WARN_ON_ONCE for unaligned offsets:

    WARN_ON_ONCE(offset & (len - 1));

A guest can trigger this by executing an unaligned IOCSR read/write
instruction within the IPI address range, or by writing an unaligned offset
payload to IOCSR_ANY_SEND which reaches kvm_io_bus_read() or
kvm_io_bus_write() in send_ipi_data().

Since KVM io bus operations do not validate alignment before routing to
these functions, an unprivileged guest could intentionally panic the host
kernel on systems configured with panic_on_warn.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709082109.1361=
767-1-maobibo@loongson.cn?part=3D1
