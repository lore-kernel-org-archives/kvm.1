Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9183F1AD3
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015513; cv=none; b=kVRDQkL+K6BYQISkNdXkdCmkt1VYJ+8JcIcVQf2+e1oy5CoRzZy00P+63CMhdLrRsfbGclhPCmWVmqOIj7GOikDxw72mIy1AOd7H1hdS/9XTh51VlrV/ieH73idgUd5EGd/PimhvRm/bIikG7UWVKvr4L1ZoeSHeB7OhdDF7aGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015513; c=relaxed/simple;
	bh=A9jnYCoxuq4lGnJT5NhqhZD5Q1oijOHQah4B46bGIzM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l541N46cFlxGZJxfhLgz373VYmIwv34LxzB8MbX7okUZ8Vb3sHER9s+PJKCdRS6oSjQcIzRzzXvGheThZoNK2gZOKwxjHLGpqK1tii3k83OWrTFiLCK/mCyIQk1oCvfkuOo4wsiuvDFlyMmQBqw46HjvcMwYqrcHVIHxdBICR0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrWVh0rW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrWVh0rW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058181F000E9;
	Tue, 14 Jul 2026 07:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784015510;
	bh=UMjl5M/zv1Wch8weC9jNNuVe3AOafDwULw9GF30phnU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YrWVh0rWlF1hmpgVkMf9w94bFzrd5rVBW6daEvIZMO1tEHSWbfUtuhQylsx1xAVxW
	 lQH3889nz8yEhQww/BccSIh+/3udkmJSKmTOjXrnr63MHy3gS+8wgIo2RCiBAu093E
	 8lwjaoemD5EEFcEDooazi8tgakptIU5eKiEEQ0i5Ya1cW1k6KvtLA/xTPY/Kx6ATq0
	 hythTa2fHBzw2vxkED/vkHAWv6iERb1P+fbb5TqH6o4UOA/I20w2CZlu5byrKq5Tz3
	 3RBLXjCTP/VsUvt68i25nereP+D7CG4SE23XSDEwLfpP2mgIaHm/6LXK1Cy13ex6RV
	 QnQLwTv6PbP/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/5] LoongArch: KVM: Set default MAILBOX access size
 with 8
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714072520.2745942-4-maobibo@loongson.cn>
References: <20260714072520.2745942-1-maobibo@loongson.cn>
 <20260714072520.2745942-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 07:51:49 +0000
Message-Id: <20260714075150.058181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Non-atomic read-modify-write of IPI mailbox in `mail_send()` and `=
send_ipi_data()` can lead to lost mailbox updates.
--

--- Patch [3]: [PATCH v5 3/5] LoongArch: KVM: Set default MAILBOX access si=
ze with 8 ---
commit 41b08f9f42313b6881c240343f238221b9928a3a
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Set default MAILBOX access size with 8

This commit updates the IOCSR instruction emulation in KVM LoongArch.
It removes the explicit case for 8-byte lengths and instead uses the
default case to handle 8-byte access in the mailbox read and write
functions.

> diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
> index 928f9bd5e1f12..3871a6953a649 100644
> --- a/arch/loongarch/kvm/intc/ipi.c
> +++ b/arch/loongarch/kvm/intc/ipi.c

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
This is a pre-existing issue, but looking at how read_mailbox() and
write_mailbox() are used together, is there a potential race condition
when multiple vCPUs send IPIs concurrently?

In mail_send(), the read and write operations are performed independently:

arch/loongarch/kvm/intc/ipi.c:mail_send() {
    ...
    if ((data >> 27) & 0xf) {
        val =3D read_mailbox(vcpu, offset, 4);
        for (i =3D 0; i < 4; i++)
            if (data & (BIT(27 + i)))
                mask |=3D (0xff << (i * 8));
        val &=3D mask;
    }

    val |=3D ((uint32_t)(data >> 32) & ~mask);
    write_mailbox(vcpu, offset, val, 4);
    ...
}

Since ipi_state.lock is acquired and released inside both read_mailbox()
and write_mailbox(), could two sender vCPUs read the same initial state,
apply their masks, and write back, causing one of the updates to be lost?

A similar pattern appears in send_ipi_data(), where kvm_io_bus_read() and
kvm_io_bus_write() are used with the SRCU lock being dropped in between.

Could this lead to dropped IPI data and guest hangs under concurrent
workloads?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714072520.2745=
942-1-maobibo@loongson.cn?part=3D3
