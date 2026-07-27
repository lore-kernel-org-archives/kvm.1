Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82201429CC8
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174984; cv=none; b=gu3v7WnL9zJvQBjPOwQYkxzaiBYzlnEHfl/4o1isK6VpaXhqw1IXbWS0gdcpmQPXXtWhzyWGXl2nR+DAWmYUf6hbm0RztXSJc8yO68KYj951XELM+YuJgpNGP+j4qMWRkbdepOziToIPxL0/otOcADoyZntp/7HVVMmoCN408LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174984; c=relaxed/simple;
	bh=Ex8x1lzItkotrSguV1hcxps0zOMQZ7AhAhf2rSjxacA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQVj7nmaR1YCgiyzpkcwFjmxclaeO6pRTbZ9uRN6DeHEWosl9C/He1RkbE0JOX6giuP42DnMo4PjKpSs6Scuj0jcgECf3HcBMMvKa/dntPn+hXxUVlaJ/szHOY0ZmXS+R9+yZ8FsfwCfvDd4GX1M8bkjNyL+jOv0OtWsh+ig2Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oZsg0ptH; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oZsg0ptH"
X-Forwarded-Encrypted: i=1; AHgh+RosyYmQB57rmJlpQtCdSdzae41um4eJ+3W1YaUwQgIGGgwF7CrdarAAg+LaXXeZcLNn2LY=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785174973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V61MtFHN1V5mcLJHu7tV/IoRmZFZoC5zGlPSgF5EIbk=;
	b=oZsg0ptH3Ggd+EWBBPSqeIFPdK6zwQ6/jrOdreYbsC/CZeeP3EZ6Nft1tw6jLiy+PXX+jh
	eELrag+aLMD4XKUfGv3CGaRoRaAX0iANoEPmuvHpX5ZWt27IsdysdZFqmjAUQ8gUmRumGU
	SvKjvqAVHFZ9avHIknFuEKhckQBM0c0=
X-Gm-Message-State: AOJu0YzUS8UHXRiNIFJn0zKqVXFcV9l6e/qYo+ZKgq2iS30TVF7fcT+w
	Yi3QfMt+9y5AQBsvTWUheEgpQncEOWkaXRbfKndV89m6I8Yb8cJlye23LQakXCdqdXPNxPYj1Dn
	MA+sZgJlgjCDRhSUR1Pbwhb+697mILFSMLObIVP/F
X-Received: by 2002:a05:622a:9c4:20b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-529a5e726b4mr37748591cf.10.1785174970207; Mon, 27 Jul 2026
 10:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724104819.1296803-1-sascha.bischoff@arm.com> <20260724104819.1296803-11-sascha.bischoff@arm.com>
In-Reply-To: <20260724104819.1296803-11-sascha.bischoff@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 27 Jul 2026 18:55:33 +0100
X-Gmail-Original-Message-ID: <CA+EHjTz+msYV6L0ydQR7Qw6LA8ASucpkumAqxrO36KUhvRDW2A@mail.gmail.com>
X-Gm-Features: AUfX_mzT1lQqmfncb9Af7oKyhTBxEtHB6P2oZDlB1iOpMSGOvof6H3RE6t1v3sE
Message-ID: <CA+EHjTz+msYV6L0ydQR7Qw6LA8ASucpkumAqxrO36KUhvRDW2A@mail.gmail.com>
Subject: Re: [PATCH v4 10/48] KVM: arm64: gic-v5: Introduce guest IST alloc
 and management
To: Sascha Bischoff <Sascha.Bischoff@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, nd <nd@arm.com>, 
	"maz@kernel.org" <maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>, Joey Gouly <Joey.Gouly@arm.com>, 
	Suzuki Poulose <Suzuki.Poulose@arm.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"peter.maydell@linaro.org" <peter.maydell@linaro.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	Timothy Hayes <Timothy.Hayes@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

Hi Sascha,

On Fri, 24 Jul 2026 at 11:52, Sascha Bischoff <Sascha.Bischoff@arm.com> wrote:
...
> +static int vgic_v5_alloc_linear_ist(struct kvm *kvm, bool spi_ist,
> +                                   unsigned int id_bits, unsigned int istsz)
> +{
> +       const size_t n = id_bits + 1 + istsz;
...
> +       l1sz = BIT(n + 1);
> +       ist = kzalloc(l1sz, GFP_KERNEL_ACCOUNT);
...
> +static int vgic_v5_alloc_l1_ist(struct kvm *kvm, unsigned int id_bits,
> +                               unsigned int istsz, unsigned int l2sz)
> +{
> +       const size_t n =  max(5, id_bits - ((10 - istsz) + (2 * l2sz)) + 3 - 1);
> +       u32 vm_id = vgic_v5_vm_id(kvm);
> +       const u32 l1_size = BIT(n + 1);

I think the linear path might be missing the floor that this one
applies. The host driver keeps it on its own linear path too:
`gicv5_irs_init_ist_linear()` uses `n = max(5, lpi_id_bits + 1 +
istsz)`.

Without the floor the allocation is under 64 bytes whenever `id_bits +
1 + istsz < 5`, and `vgic_v5_ist_istsz()` gives an `istsz` of 0 on a
host without metadata support. `ARCH_KMALLOC_MINALIGN` is 8 on arm64,
so a 4 to 32 byte allocation is not necessarily 64-byte aligned, and
`vgic_v5_vmte_assign_ist()` rejects that against
`GICV5_VMTEL2E_IST_ADDR`. It depends on where the slab places the
allocation, so it is intermittent rather than reliable.

The rejection also logs with an unratelimited `kvm_err()`, on a path
the guest can drive repeatedly.

This needs the host IRS to report a `MIN_LPI_ID_BITS` low enough to
reach it, since `vgic_v5_ist_cfgr_valid()` rejects an `lpi_id_bits`
below `irs->idr2.min_lpi_id_bits`.

Cheers,
/fuad
