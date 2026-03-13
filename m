Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099CF38A285
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395699; cv=pass; b=RWlwr8Ynm/l0MZCHAigUYhnaYNa8XMMhooguS/D+GmrA/YGLxVjqkBkCgPrdrsPiMT7rG4/aMiVsNbjNboJTknuXL1HS9bXn9C6TXn5GlwmW5hiIX4m3SlCHSoSkL056DtQByzNF2yU6QBvOHKwbqWrnzk9VEpCBqTY/JZkjOiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395699; c=relaxed/simple;
	bh=3rlDoAcrTNrDC5PfNXEtDR0owzOOaIjI++dINzYGKUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCdK+gyRvKqUS2EACHpSkg5ZcxMHq/2+BkXUk2YaY7XpUHr0SxvrZPcH9Y0AOawcl+soc8/S4sSMgZKBIU71I8Ixs+psjBl/TrxJoO492R6nB0fn2EjhgEL2d9YJS5XKPVdH5GWmegzx2eQW9QFlQon9PS11UgTd1H/XDj9J65M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ron5B44r; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ron5B44r"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ad79dfb7cso2414888d50.2
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 02:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773395696; cv=none;
        d=google.com; s=arc-20240605;
        b=dLczgo9ETLiS8HYZek0yTOD37A3lkta/+9QY/wXH0yKz0t9+kGU/5fUcQ9ywjNTrXE
         kmvusgXYBZ6jELyhmt4ROsJ9Km3zRjU+fgMLqEiSafOlC5r61qLQMUrpWQRwFIuJIa0K
         Xx9lvD6oa/j5aUw5qT7g3Ka8iBrMC4WjPBejL0aGH1DYD4eRtPBuP7b9TBaJ5Gtb1h/H
         HKNvHjA8hyVLEDivg2kD+18PfC96TuZzhItc3lHMThS8qeYGpwt/oSzGw8xj5j//Hg6D
         hSYdYuNGqX8e3xynjL0NwHqkUuDRodjsHKIr7dJGoauWJz5D8KvJLe25XEB/F8Og2CzI
         GKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LhPiD52RNj6EbcKK9bjjzvDMTUfuYexLC2HZLi5DX0o=;
        fh=08Yt7GAcpgDziYtFkx3M/DAcOgqLR0FW0dVrypV9xAY=;
        b=IS3l6N0upxA37WfGwZKKro+1u/sYGA8CGPR2uHn9U1s9WWfi1cMB9ZlK23fSCwKIdC
         mjzwLXTlHiMsfGxd7PWmLK409cEUj3xl4Iw/r83eh1cgrJxs1IHg0XVQcO1aY1B2aJw0
         BZzHeuJo+IJ0F4S9ptIeASY3/JkGGmzqDGSk9wM7y5NpOgIBXSSgAOGTmgsXZBRHl04O
         Cp3Yvil0lwM0owNkteNECW5F/k61hQLehaIXo+eZcE60KRN4OIWCTkJncVITJW0x7wWt
         YjwomWH12gCQihe5w0xisXremotd4tZyLOses30RbQdN04kHUdfEAPHYo+USbdmTS5Y3
         C/CA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773395696; x=1774000496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhPiD52RNj6EbcKK9bjjzvDMTUfuYexLC2HZLi5DX0o=;
        b=ron5B44r7S79u0f/13P1oC8iuNOhUKb9eCiQTdpuNoFTkP6FZf+6PlFhSB0e0BRIoR
         YoBTXSHuhbhiaES+bPnln71I4N2Q8lMhwuddGZjSsi8C2l3Ngkr0g/D+6ZcuHMV/xzD8
         tA18Jma228Ie3b28zc1v1HuyGLzuH8gGTkeKnkM+HWN5+VUwQdm1mIY/kj601r2ud3vP
         i2tKgWyR0YYvMblEm4MCcoX2uC66+gIRZbemHerf1Bv1NBthwlBEAizwkEZw8gxWC4nR
         zoOrYHJeEp1Eb/BWuz8osq/n0/Og7nQp4IOvK3zI44b4i+wX8IO0tjaL7jdaWeXl2mdz
         jYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773395696; x=1774000496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LhPiD52RNj6EbcKK9bjjzvDMTUfuYexLC2HZLi5DX0o=;
        b=n+GQKZAGmWXgRddTT7bNhIpljuC/iS6rI+H+78i2U4o3sa8BD1D8iHlCRS6SlBlfJt
         ghjHQNjJdURzXrKK8/TAOONxnnOfHdGpMFh5s+ly6Un6Q4B4k8IP8E022c3yMMdF9NAN
         ZrUX3YzrDbB7YJKpTV85GE9vwmJp2N6xyEpt1cONZzYlgQg48tjHTmbcAbLKj3mpJ+fC
         pBnyal69x2LRvmivJzLzkAUYYcB88CjwXhRM8/mFARZpSeDt4f+aw82GHhJb+axtxUe+
         9AaXjmwRenQkRqW+jd45BavRfjhpBiY0XSS8cY+WPMtwwUf/E9fCmTdSflpJBhDvG6Sk
         RSTg==
X-Forwarded-Encrypted: i=1; AJvYcCUOgXQSdBAfVV7x9ieElA0UcrIME/1G20EWMYY9zcQcFt7KNjeLHvwmOLbnAN54z/wMsOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsf6kyQ0JA/wcZ1oDy/jfvIOAYXG1ME0SGwzi8EdOtNOhw/soa
	r+dEb5NzJraqwU1KyPN6A+ALMpv+Hh+eXcGtmrld9RGbbnywV4IoZx4S9hmIXrNDl5U0FipVMAi
	H65AJb2CL6UwKHkeHDKMIxjxHz6YY9j67flSrMblOeQ==
X-Gm-Gg: ATEYQzyN9k+6NPX0CS20Q5IeSNl4vxuGAUgOxkBkJiz94X6zkjGn1L2n6/sVkpWz1Zm
	CFVbnMnLbnMzUSNRN2FdCyreTWyFZ8w7QfdsnqVO3pWGDpCrftXh6HruEraj9pDYrCKYFrk/W4r
	I7E5ez/+oePfW2RgfvaXLLraUKKvUZZ3CnK+mKRbsY/sPrIWwbTVR25N82CHvNA4IcA4m1eph5G
	1aGr2glr+jvAmWptKVE6zLiX9mHC0OmKtOuouBzErXPVOepcz3uTwoAgTA8OIVRIDEfuDFYm/mX
	sEm2/tfyXMkv8Zj5KPoihdVG6ASNA3rR4TyzS80suB8woZHPE/+jwOjSObrhSnbp06c=
X-Received: by 2002:a05:690e:2058:b0:63f:7de1:7acf with SMTP id
 956f58d0204a3-64e62f5457dmr1915432d50.22.1773395695626; Fri, 13 Mar 2026
 02:54:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311095405.26297-1-hi@alyssa.is>
In-Reply-To: <20260311095405.26297-1-hi@alyssa.is>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2026 09:54:44 +0000
X-Gm-Features: AaiRm53V8rzJfK3MJW8n0DXsZoYKtviPOaIt4_CWlAx8D1oHFxJ5NOaKNR1uC9c
Message-ID: <CAFEAcA8ycT250JaECAYTKF+U2a4m6jauLPLbD8PVx2atd70A7g@mail.gmail.com>
Subject: Re: [PATCH] target/arm/kvm: fall back if nested unsupported
To: Alyssa Ross <hi@alyssa.is>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
	kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
	Miguel Luis <miguel.luis@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Mar 2026 at 09:54, Alyssa Ross <hi@alyssa.is> wrote:
>
> If I create a machine with more CPUs than KVM supports, but specify
> multiple accelerator options, QEMU will fall back to the next
> accelerator.  This is great, because if I've explicitly specified
> multiple accelerators, I've told QEMU I'm fine with any of them being
> used to provide the machine I want.
>
> When I create a machine with nested virtualization enabled, though,
> this doesn't happen.  KVM often doesn't support it, but TCG always
> does.  The nice thing to do would be for QEMU to fall back to TCG if
> KVM can't provide, like it does when too many CPUs are requested.
> This patch adjusts the behaviour to do that.
>
> This is very helpful for OS development scripts that run an OS in QEMU
> =E2=80=94 I want everybody to be able to run the script, always with
> virtualization enabled because the OS requires it, but for it to take
> advantage of KVM acceleration when available.
>
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
>  hw/arm/virt.c    | 6 ------
>  target/arm/kvm.c | 8 ++++++++
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7456614d05..0b63b2eac3 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2372,12 +2372,6 @@ static void machvirt_init(MachineState *machine)
>          exit(1);
>      }
>
> -    if (vms->virt && kvm_enabled() && !kvm_arm_el2_supported()) {
> -        error_report("mach-virt: host kernel KVM does not support provid=
ing "
> -                     "Virtualization extensions to the guest CPU");
> -        exit(1);
> -    }
> -
>      if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled(=
)) {
>          error_report("mach-virt: %s does not support providing "
>                       "Virtualization extensions to the guest CPU",
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index d4a68874b8..20dcc6a820 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -615,6 +615,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          ret =3D -EINVAL;
>      }
>
> +    if (object_property_find(OBJECT(ms), "virtualization") &&
> +        object_property_get_bool(OBJECT(ms), "virtualization", NULL) &&
> +        !kvm_arm_el2_supported()) {
> +        error_report("Using ARM nested virtualization with KVM requires =
"
> +                     "a host kernel with KVM_CAP_ARM_EL2");
> +        ret =3D -EINVAL;
> +    }

Looking a bit closer at this, it's a bit awkward that we're
looking at a machine property in generic target/arm code.
There is no guarantee that the machine is "virt" or that every
KVM-supporting machine has a "virtualization" property, and
the target/ code isn't really supposed to do board-specific stuff.

The board-independent way to say "are we trying to enable EL2" is
to look at the CPU property has_el2. But the CPU isn't created at
this point, so it's too early to do that here.

Similar things where the early accelerator code wants information
from the board we have handled with a method in MachineClass,
like get_physical_address_range. We could do that here, but
maybe it's a bit over-engineered? IDK.

There are other cases also where the virt board will error
out for "KVM and some config we could do with TCG":
 * KVM + EL2 + GICv2
 * KVM + EL2 + kernel-irqchip=3Doff
 * KVM + GICv2 but host hardware doesn't support GICv2 emulation
 * KVM + GICv3 but host hardware doesn't support GICv3 emulation
 * KVM + MTE but host hardware/kernel doesn't support MTE

The first two are "always fails", but if we're going to have
a mechanism for "figure out in kvm_arch_init what KVM features
the board is going to want to enable" then it might be nice
to also be able to use it for the last 3.

-- PMM
