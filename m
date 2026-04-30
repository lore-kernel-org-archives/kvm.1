Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0878A3DBD71
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777539442; cv=pass; b=NC5bJiDZKSCPT/ZzfgpQ6yDRKEDma9HzW62tj/PmJnpKdyagKHOvMgSal6y8gj3ppRhxpqLE9rIE/qfh20yPM26jbm8/COpCmUF6WU7hidOWcly3OkONsbYjxPEAnS8CNJXO6xjTjpULkIw0GW+3Mdi0V4hwvUA7Oa56XsqdQTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777539442; c=relaxed/simple;
	bh=wjFl6GDkmUJl+dKx1Cia494ZvHYp6ty44K36Qbt6DgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rznOAXlFr+ZuuXMfgyAGDUNLUTxu7jwI81AH6HfwCJ6J/urcJY7++0AXozviESGRS16antDzrUTgXmnO637kPFwPSweFQ6TDOd3vfHdzeYuOdgI736hXEpf9NC9RFcpBFmUGgosVvgitPr3guv74944E8zSnIhMqkfUWnQAhwdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L74zFk9h; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L74zFk9h"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6530287803cso667461d50.1
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 01:57:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777539440; cv=none;
        d=google.com; s=arc-20240605;
        b=kld9yUYKUQg0HvKVo6JnuqXgut/ARvrbO8DWvJ07+T94L2CLEie1BA+GPLgj8wY3kb
         9DN4ulEuI44+9MlcJxSvqQGvwtfYSu4d1pRN9/mnoFhCm2N5P49rXYb0ANwzYCHUGOnA
         f1iZs6OtYhS6g2o6bNGsiWc9Us8ZeT4YRGii1tz9AZLsF4rES8YbixWNnjotdRgNYv56
         vVkraM3d7wS/OIjIlOgGA+DedMu8qOl8e0onTA29WS3HWksET1UzRDDNTpxWhFpufqGb
         EJXA5rFdCpHIiIFJIWQ0DY6xo+Wwt+Levtmlwtb9+/RexWcK7OqWxG5XjRug1/mHktXh
         uoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WHn7aNKe8Z0UpZANHbjAHiTC29hYbOiQjktEyz/Ro2M=;
        fh=eLyMBGUjNwqzSUPz9l7Xh7hHT/B8VAOSJiqGQPYyR+8=;
        b=UiXIP7oR9nqGUc0hAazilE4vfCK7W5KlbSRtuyjO8ETO+J9gsg4/i4qhunFAbZrCbC
         43SzbWXqlDkafZEte8bXIAyrgzdGmFSAGNu6lT0grqvJPNHc28ZXvtMFKlZEcqdivAOJ
         Vf5IjYhaFJR27NlKzEUkpq3NKZDRe8FRJPqhA28//jiUmC34T+s7Uu9jtoqrjyGCHyQv
         +PVJljadsqb6KKc8L++iFnobqcF8TASATvc9RhDGjrl3Qzskh59+lyTmqK9TRhb/GRRn
         keAnkCotef/EnaGlc4PmnoJfWwlYVorByikEoFL/tYYtYt8HFz3Mkg/Uqs3ikLFPSn/Z
         Ne5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777539440; x=1778144240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WHn7aNKe8Z0UpZANHbjAHiTC29hYbOiQjktEyz/Ro2M=;
        b=L74zFk9hf2DcG7kiPzU5qEczU9uO1gZcZVODS0rNwVPkY+CTOtYPcdv/ASvkAAS7af
         FO6oHG9Yzz9u1mjgefYgGBHvSoiqYobnxP/YApt1G+sosUnzBGbkj3pjiJWktT9OelXC
         s2Kio3eR4Rc9hTnaptwm9KZCf9HZNX6gvLCD8TURtcUHprVSuVWlGUYNj3e8VTyS4AqU
         X7ahaILHtf0fayPoSuIsuMv6Rqc1v8v1RavkITgZfxrrxSi+uwD9A1LxKaM7pmkvQFwy
         1FKlyCHM3XWCGlqPnPPjeUnNowFeWC+H6M7LrghTUn3VVVjh3WhMJxW1tjTsCjIBuJ0I
         egnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777539440; x=1778144240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHn7aNKe8Z0UpZANHbjAHiTC29hYbOiQjktEyz/Ro2M=;
        b=RUpFZ/6dJ/CRpPQ+RcjwE00jkEwLraDTrCOhT9CSdOp+uRPBXd+PxAkgUV6yVewMKl
         ca8B5nif5rA9gdC7m8ox3GKP6a8o/N19ZRHs6UyYDMY6CUuXzvGTJC7W4f1olfQnJ93k
         ZPjAOlDdJ+DYyBUP8VDAqasAJFoQbbAPQFnll7F2jMTc8c0B8bSg2xxigQDtbHvqvCRs
         tC/RNMoDXHfCKX8GjT97f6iqJmXMO2kXANm3uTdyKTrPu9cYQwVQ7tRvKeRG7YS/93cr
         0+lfczvxvsdTA0RLOlq6GpMRglg2sKl+eyRhvsZaJpQKgZPmIiXzzoiC37UE6MUP3Ajq
         k1QQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7jz8wMkN0xuKVPBBzT0ACaSUNTRCuTCD03aGKRxq2MB28Nofvxdj0wG6uZaVd20blu8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF2b6gZZnbtCeLXHrKNjzOWbZd6OhFPZ3JWtINYJwUlNUtCzMz
	Ho+y0nZEYDvzT/iDwX0eG5sYNDbc0q2OdkM2/JlO3T1BgUCfZzhLZOTe52X/TuOV0fZpJUKvKmY
	B+colcXDj28zcXkTU/V1L3EWEAxaRsCzqCfUfLRthvA==
X-Gm-Gg: AeBDievH6EIaMZMSoxih09Wc8JTwQeQhEMzTc+iwkQyEJIXi9Hw1Ydn9Due9WH+yd+W
	PGYtvffwkRGyIKjW2IEC6mYRzPwHw/mX1OQoJtOAJwQkuiK9saNQgRrmrJg//YilMiojOp1eC78
	NlDnFRDpi3aCi8iW+bJeQ5TrjkaBxKTrbp45pYNrZQ/rB2R8UhyRplVo1WryAsP2tLS4In4usjj
	2cE0I/Hfh27uTu5UoJ/y8Stz176a6WBlOKd40uTm1wjjqzocAdUpCdk2qgRrSYKKNXy1DYb6D3X
	9s4PWwMFdgpZ1wM1Jdx65TmjF+B8prNpIQt7jqoc8q/Y1s89MTKP8165ddEyjkqzjSiLd3tHQ82
	F7A==
X-Received: by 2002:a05:690e:1698:b0:651:c782:6a8 with SMTP id
 956f58d0204a3-65c18b3e650mr1335368d50.15.1777539439953; Thu, 30 Apr 2026
 01:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427160547.3129448-1-sascha.bischoff@arm.com> <20260427160547.3129448-44-sascha.bischoff@arm.com>
In-Reply-To: <20260427160547.3129448-44-sascha.bischoff@arm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 09:57:08 +0100
X-Gm-Features: AVHnY4Jvy3n3XpKrxh1FlvrSB6Vt4VXuFhqD0yDhLAN5iHhEm91Tb3vWrZI7GfM
Message-ID: <CAFEAcA8m1Y-8=+7RZjte1WBwycgnHEx_+yiU_ieriZr5DbQKsQ@mail.gmail.com>
Subject: Re: [PATCH 43/43] Documentation: KVM: Add the VGICv5 IRS save/restore sequences
To: Sascha Bischoff <Sascha.Bischoff@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, nd <nd@arm.com>, 
	"maz@kernel.org" <maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>, Joey Gouly <Joey.Gouly@arm.com>, 
	Suzuki Poulose <Suzuki.Poulose@arm.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, Timothy Hayes <Timothy.Hayes@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 17:22, Sascha Bischoff <Sascha.Bischoff@arm.com> wrote:
>
> When saving/restoring the state of the GICv5 IRS, it is important that
> it happens in the correct order. Failure to do so will almost
> certainly result in failing to restore a guest that is capable of
> handling interrupts correctly.
>
> On a save, the ISTs must be saved prior to saving the guest's memory
> as the guest's LPI IST is written to guest memory. Conversely, on
> restore the guest's memory must be restored prior to restoring the
> ISTs.
>
> It is important to restore the IRS MMIO registers by first restoring
> the IRS_IDx registers as they define the capabilities of the IRS, and
> are used as part of creating and managing ISTs and SPIs.
>
> In order to restore the ISTs themselves, the IRS_IST_CFGR must be
> restored prior to the IRS_IST_BASER. This is because KVM extracts
> fields from the CFGR to determine the size and structure of the IRS
> created by the guest. The IST itself is created as part of the write
> to the IRS_IST_BASER. At this stage the remaining MMIO registers can
> be restored.
>
> Once the LPI IST has been created (by the aforementioned write to the
> IRS_IST_BASER), the IST state can be restored using
> KVM_DEV_ARM_VGIC_GRP_IST. The SPI IST gets extracted from a userspace
> provided buffer, and is transferred to the host-allocated SPI IST. The
> LPI IST is extracted from guest memory, and is written to the
> host-allocated LPI IST.
>
> As a general rule, the IRS_*_STATUSR registers can be ignored on
> restore. They are not userspace writable.
>
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> ---
>  .../virt/kvm/devices/arm-vgic-v5.rst          | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/Documentation/virt/kvm/devices/arm-vgic-v5.rst b/Documentation/virt/kvm/devices/arm-vgic-v5.rst
> index 38eef7cc63e3e..1c55f5040757d 100644
> --- a/Documentation/virt/kvm/devices/arm-vgic-v5.rst
> +++ b/Documentation/virt/kvm/devices/arm-vgic-v5.rst
> @@ -201,3 +201,66 @@ Groups:
>        -ENOMEM      Restoring IST state failed while tracking pending interrupts
>        -ETIMEDOUT   An IRS save/VM operation timed out
>        ===========  ============================================================
> +
> +IRS Save Sequence:
> +------------------
> +
> +The following ordering should be followed when saving the virtual GICv5 and
> +IRS:
> +
> +a) Save the ISTs by issuing KVM_GET_DEVICE_ATTR on KVM_DEV_ARM_VGIC_GRP_IST.
> +   This MUST happen before the guest's memory is serialised as the LPI IST is
> +   stored directly to guest memory.
> +
> +b) Save the IRS MMIO register state in the following order by issuing
> +   KVM_GET_DEVICE_ATTR on KVM_DEV_ARM_VGIC_GRP_IRS_REGS:
> +
> +     1. Save IRS_IDR0-2 and IRS_IDR5-7 registers.
> +     2. Save IRS_IST_CFGR.
> +     3. Save IRS_IST_BASER.
> +     4. Save the remaining global IRS MMIO registers.
> +     5. For each PE:
> +        - write IRS_PE_SELR
> +        - save IRS_PE_CR0
> +     6. For each SPI:
> +        - write IRS_SPI_SELR
> +        - save IRS_SPI_CFGR
> +
> +IRS Restore Sequence:
> +---------------------
> +
> +The following ordering must be followed when restoring the virtual GICv5 and
> +IRS:
> +
> +a) restore all guest memory and create vcpus
> +b) provide the IRS base address by issuing KVM_SET_DEVICE_ATTR on
> +   KVM_DEV_ARM_VGIC_GRP_ADDR
> +c) initialise the GIC - this sets up the default state and creates the SPI
> +   IST - by issuing KVM_SET_DEVICE_ATTR on KVM_DEV_ARM_VGIC_GRP_CTRL with
> +   KVM_DEV_ARM_VGIC_CTRL_INIT

This isn't going to work for QEMU, if I understand it correctly.
QEMU always creates the whole VM first, including creating the
VCPUs and GIC, telling KVM what its base address is, initializing it,
etc, before it starts an inbound migration. So the memory read
is going to come in after step (c), not right at the start.

> +d) restore the IRS MMIO register state in the following order by issuing
> +   KVM_SET_DEVICE_ATTR on KVM_DEV_ARM_VGIC_GRP_IRS_REGS:
> +
> +     1. Restore IRS_IDR0-2 and IRS_IDR5-7 registers.
> +     2. Restore IRS_IST_CFGR.
> +     3. Restore IRS_IST_BASER - this triggers KVM to create the LPI IST.
> +
> +e) restore the ISTs by issuing KVM_SET_DEVICE_ATTR on
> +   KVM_DEV_ARM_VGIC_GRP_IST.
> +f) restore the remaining IRS MMIO register state in the following order by
> +   issuing KVM_SET_DEVICE_ATTR on KVM_DEV_ARM_VGIC_GRP_IRS_REGS:
> +
> +     1. Restore the remaining global IRS MMIO registers.
> +     2. For each PE:
> +        - write IRS_PE_SELR
> +        - restore IRS_PE_CR0
> +     3. For each SPI:
> +        - write IRS_SPI_SELR
> +        - restore IRS_SPI_CFGR

More generally, if your API involves this much in the way
of complicated ordering dependencies, it's going to be
very bug prone.  From userspace's perspective, this is
not a very helpful way to design the interface :-)

thanks
-- PMM
