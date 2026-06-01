Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1068C2DF3DA
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299665; cv=pass; b=dbGaACipkud3N5MIQ+gYUmPiA+3GJZ1onXN4GM8QZERVafdplqeqXfRU4jcSqA6TahOvYylUPwHXruPrAOzkNEV+x7GdHk5ECZrXyodBydIahHRZT1hoRXlU55AYcVeh4ENRw9SumAXe2IQtgb3vFY+v9TlnX6LNlyB7N7dgSYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299665; c=relaxed/simple;
	bh=uldws4YYrDuKQMGKGb313TUyZ0lHqaMjeH0b+jr1WNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=siNuzZLmg0dhJypus46aSpPlQHAT/W+wlyeuk+QqouvDkKfZKSyO3RHaXERB8+SA9EajzVgquaEBrEob1Eu1/keToDXcD383AWCYr2+1R+Zu1eE3HBBUPgRF0SgIAxO0td/TWZ5oRhGvK5Es6tC2VUh1SLkZjITRVuqI2C1sn5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=jdXeoymD; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jdXeoymD"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-59d6e44e5c8so931661e0c.2
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 00:41:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780299663; cv=none;
        d=google.com; s=arc-20240605;
        b=ZuuvV2sj8gQpLXaE1tQVTBp/yJ2gnhdN2Lypc3YaaZ7MQCQ0lSeHXTBFFOnQbGLu8q
         otRWVMiwqB21St+X1yLRbECJam+VtVzuQDJO7/Egj/OjxMlhdtcgQ7fJCRMtxVsOHg6J
         ARoibHAkFaM9icLr5RPgN4zwivMsj3L4DW56dT7Uy9gyI3ABT+YyY6gncAE8Gqqh4uSN
         mp0d2IbPIB3MR1CFpFAsO5ZLrQzka+6VH8C+Q+IHkwRmtZqUp5JMKHLkJSfOMRkFMcTx
         mCLCNuJb3Yf/gUQPZPOIzcMZS+Gu3t13T3SOM/u/yaIRoS5o8D4dYDfgrAVtkg8ZxftB
         1xtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XnpovSeu5LTyBOUlAh1dxONh9WzZ8VZmHp/ieSTt+w0=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=QXTnEwz38Ob7WqucvunWyH09DHtcBvg5YAp/erJ2FEpfDPhdRsHGh4s/YEpqyydtN8
         goKM6f5o2rdgIu3j7OMYxs5GVlmKOsyHKsf5ftyW+8mNPtK1SftftNFGIwKSB/SNDb2r
         ehEApyKJkRKTONH4kkvRscii4U+ma/TCBodP/YcZxTSI0otGgsMX7zAZDk5btvHesZYU
         JEC6bbz5jgAoU3KM333WKVK+qM0aopqG0ZZCwvQ6C5f/9hjNS3b0Ca+QlS2zHZKKQDmL
         gAkIrP3FoV8hhZE0MkscqLHnsNRV7vs/onqXzhd3HeT6YZwA3tMlmbiEGelYq1A/n2Ub
         HtwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1780299663; x=1780904463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnpovSeu5LTyBOUlAh1dxONh9WzZ8VZmHp/ieSTt+w0=;
        b=jdXeoymDMC5TAhBxaXY+HKv+QegAndudLUIU+stmJBwTZfprCYynmG7zfHLas3UWYc
         R+sSSFRe58bwFnBCZqEhw3rSHLwc+Rl3TKh9g7B8ISh6fLnFkvJVVpoIbuF4WHgv/Jn7
         p5Up8lHPLZfImZLg9cu3sNblhME0SgMs/dmXzmUJh+/Vz55n+0n20aIWnTpzCXwUK9Oo
         xYN3n/RNfTKv+W8WayuNxR9PmHZ6htDCPHADlBC6txDcuXH4Nr3SNBhKpKo1JPIunjpO
         wA9Zyxe02yLaKoR35uIFDJ9gLufOQ1lVIkF8Ry8IcQ0FbwO3IoveeTqY+6ulkf5fBnss
         Pu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780299663; x=1780904463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XnpovSeu5LTyBOUlAh1dxONh9WzZ8VZmHp/ieSTt+w0=;
        b=KMFgFNEpFJuiThBzRWRpLNiaBKl3UsquCqIvz+k4cWuDHi40emZpw9SXWA+dF5I7Lt
         02BlJBhc9hqxLewvp5Al+zDEh/Ncc0HGLGf+ui/PMpksNOS3b675zAxrhyXo2pwLMjq6
         1yo9v9ebvfnlScMgwUzJx0zLN63FPHwR8K35R3UBLOvlSinmMs9cl2fJvWfD0mYl5Xnm
         VpMH4fILM755hRRxdPIBnhj2x+6xAYGbyGEAMmKGoiLEJeU1y4BJh40yywvK9fO/gjMz
         kRf9NczLRQWICOHGAsVQn8yYq3xM/w4TBhw4A33icFhxlDNXhqNbMxVIuZZsciG8POFG
         L8Lg==
X-Gm-Message-State: AOJu0Yw5ZNZfPUGb3xJ9IwbqB+RpKErFbwAO3h9PZ9KPzruDlvsaI6WT
	2Mi9ZeO13ZqfMQ/0Oss0fTj93XSdJ319Iy4DuZXFG7i97zgvoPi5zqRO980jKOh8aHbL7kJuTQC
	vsq5KAIHtHcAxyY31eVvSKsId+HXNxXP9W3eGOe9fIBWG/438IuBLRts=
X-Gm-Gg: Acq92OEpI6lEQLknZlZMq9FAXNrcisU6HsFQBHSKlenjgXJ+aAJNFMiBkAcC0sm2RCC
	GTv+rIMO6+ovFT1VO9FS3ZHkZPvPkxImwXN/IISiBGvWldgo2d6YY/ewKJiadovkw/vqRQbEpJq
	DEheBIoc9Gjhq/pFYS+YSMhni8C06lLnpSxr+JPV+wC1rViiUZ0EmfyGo7e9FLXYF2+9ti2umgM
	p5jedn1S2Vm+8K8XfX8ReBHSj5gAMSmyaz8oOuFAJ8F2Sky8sY4Ifq4AfJdNGui3FPb8SAVxnvm
	PEKyuMaR7hrtl4EE/gdW
X-Received: by 2002:a05:6122:4f9e:b0:55b:d85:5073 with SMTP id
 71dfb90a1353d-59bf1653ac0mr3993732e0c.4.1780299663078; Mon, 01 Jun 2026
 00:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528-kvm-get_reg_list-v2-v3-3-170969a8599f@sifive.com> <20260529081023.AE75B1F00893@smtp.kernel.org>
In-Reply-To: <20260529081023.AE75B1F00893@smtp.kernel.org>
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Mon, 1 Jun 2026 15:40:51 +0800
X-Gm-Features: AVHnY4LUldgfv3tioL_N-gmyL6cy_L6milyQSwqu74UtlVs6iKLMpqgiXSjgX20
Message-ID: <CAMWQL2iGu4VPBsJ5dFJp2O8hjzxxOvuLTzP76_B=7vAGnyyoJg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] KVM: riscv: selftests: Split SBI FWFT into
 separate feature-specific sublists
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 4:10=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] FWFT pointer masking registers are incorrectly handled in chec=
k_supported_reg() instead of filter_reg(), leading to dead code and potenti=
al false positive test failures.
> --
>
> commit c0f0519ecd25fb69f07c9b166dfd4ccf59ef2905
> Author: Yong-Xuan Wang <yongxuan.wang@sifive.com>
>
> KVM: riscv: selftests: Split SBI FWFT into separate feature-specific subl=
ists
>
> This commit divides the monolithic SBI FWFT register list into separate
> sublists to test features independently. It adds check_supported_reg() an=
d
> check_fwft_feature() to validate register and feature availability at
> runtime. This prevents tests from failing when only a subset of FWFT
> features or their dependent ISA extensions are available on a given
> platform.
>
> > diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/t=
esting/selftests/kvm/riscv/get-reg-list.c
> > index 5033c09201ef1..7ae55fbad29aa 100644
> > --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > @@ -27,6 +27,23 @@ enum {
> >  };
> >
> >  static bool isa_ext_cant_disable[KVM_RISCV_ISA_EXT_MAX];
> > +static bool isa_ext_enabled[KVM_RISCV_ISA_EXT_MAX];
> > +static bool sbi_ext_enabled[KVM_RISCV_SBI_EXT_MAX];
> > +
> > +bool check_supported_reg(struct kvm_vcpu *vcpu, __u64 reg)
> > +{
> > +     switch (reg & ~REG_MASK) {
> > +     case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_R=
ISCV_SBI_FWFT_REG(pointer_masking.enable):
> > +     case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_R=
ISCV_SBI_FWFT_REG(pointer_masking.flags):
> > +     case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_R=
ISCV_SBI_FWFT_REG(pointer_masking.value):
> > +             return sbi_ext_enabled[KVM_RISCV_SBI_EXT_FWFT] &&
> > +                    isa_ext_enabled[KVM_RISCV_ISA_EXT_SMNPM];
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return true;
> > +}
>
> [Severity: Medium]
> Should these pointer masking registers be handled in filter_reg() instead=
 of
> here?
>
> When testing the config_sbi_fwft_pointer_masking sublist,
> check_fwft_feature() iterates over the expected registers and invokes
> __TEST_REQUIRE(!rc, ...) which skips the test if any are missing. This
> means the test exits early, and the core loop that calls
> check_supported_reg() for missing registers is never reached.

Oh yes the check_supported_reg() can be removed now.

>
> Moving this logic to filter_reg() also seems necessary to avoid false
> positive test failures. If a user runs the config_sbi_fwft_misaligned_del=
eg
> configuration on a host where the SMNPM ISA extension cannot be disabled
> (isa_ext_cant_disable[SMNPM] =3D=3D true), both FWFT and SMNPM extensions=
 will
> be active. KVM will naturally expose the pointer_masking registers in thi=
s
> state.
>
> Because they are not in the misaligned_deleg sublist and are omitted from
> filter_reg(), will the test incorrectly flag them as unexpected new
> registers and fail?

The SMNPM ISA extension can be disabled for a VM, so the
isa_ext_cant_disable[SMNPM] won't be true. Both FWFT and SMNPM
extensions will be active only when testing the new
config_sbi_fwft_pointer_masking sublist.

>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528-kvm-get_=
reg_list-v2-v3-0-170969a8599f@sifive.com?part=3D3
