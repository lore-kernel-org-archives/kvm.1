Received: from mail-ed2-f39.google.com (mail-ed2-f39.google.com [74.125.228.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111694D9F99
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605498; cv=pass; b=hUQ/coCVzGctNKNLxZK/nBc+tsFHsTMKFokUHWGGYrA/2W9/aVM6Uo2mRheC5SHGEgci6gQ39K6ik2hT9ypTrljXNFoWyOiuR3o6gI4gGTq+Ixc3mnGFc93a6i11F0VqP0Myi39q0+ladR2HVg422d2MM3SNxU8X+d0yqlXr5L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605498; c=relaxed/simple;
	bh=zV/x34xUvR3c3WOoN6J6UJVr6RTUzKrUeID2Y6fuWGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/KDs3zx1r7WPwpqVgZBP4yH4P7HyS+30HV4lRYkM7uMZ3lKJ2C+jjgDWZKRRHWL8ejNR+wX1hdD+nGUTsqX29w/1a5Fgs2+EggdHRUgaMKnK/crQO+sJEsiLLrdk5EWpkn44Xa66gbGwuSAJH0CK6JbtI2u/WzvawXCDqan9mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BL5W5v7I; arc=pass smtp.client-ip=74.125.228.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BL5W5v7I"
Received: by mail-ed2-f39.google.com with SMTP id 4fb4d7f45d1cf-6aa0ee64afdso3606431a12.0
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 07:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790605494; cv=none;
        d=google.com; s=arc-20260327;
        b=B3mhsZZ4NFu5W/4noK323MbFFyae1LELG9qSaQ8hHM0cgRVM+4mCCvOD3Gic9TrMjf
         WpuTWPR48mnfiJ680qaZKMtJioIY6e1DZ1wKnKa+QLUrXm1jFl6VMD2DOj2lLyA0Yyte
         qeSQcEmXmN4/RkcrpFhPbVIIk1tAC0EBlKtI0UQNsgG8CFYXiBYgvUG0bJiB0NXawlSw
         K7yeOFHwkIBbm90EC+CmABl+G36t0qq+d43oDiMVeDD4CY2vl5/W/NgV6Z8Nc0xXbkgD
         lKTWGL/eQpcCrQ0sCL/u/SuN4oacZrv2dEe0/Nb1j5pDdtK35QQ1rat4m6XbTcgHAoZn
         IOBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=cFi7chTl/dXnccUH1qK76VepQPSMCTxgrhW/RRhkUhE=;
        fh=gLLZOjKlpIatgfWYBDie6havjwWZvKX+cV7S2Vx2XEg=;
        b=eGCCzpVPLhIbaLbPW6nIttXoEk4LTWM09tvYeWEot96s6ibwa72G7V5RrRIhszPOOt
         mTFUOX31AKFsr7vT+sWQozW8jUKTr5RMkLDXiigNbiB4db3gHryIpjOvVnIWRuhDN4Jo
         /8HALwmFHn4Szj0TObRy03aevbc3ol4Bbk91+HRos39nRgyCz3WmBtPKcDyDatxe9OWu
         RXdM4dQHlAhcJJU6ShISFYJW2icFrP/Ycib5XJACclpC5M8OlLLrEPI/okCDUPeNYG32
         skCUKYPD9hRRG4WuQsfyfjp0KRauh7yWqxC0gRducmJGQKeAHx1STBPdKTdfQC7uRGxe
         8y+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790605494; x=1791210294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cFi7chTl/dXnccUH1qK76VepQPSMCTxgrhW/RRhkUhE=;
        b=BL5W5v7I1F7SEwhk0FoNAoeMyxvf/NSXXwY/2m5zRYOb92SX5OctnqfS0de15lRnSB
         gYoPNtz/A2KfbZm4INcXSdR7zegWRXOy9TE0byLkyPXpUiqPpJn+PQoTsWhziRrzQB0N
         wIA1Emr3Jvh1+qf/7qgGX42gQkFeUFVcMWImQgKW/uv7TZJZ4cRN8BheyHIOss8Ca7DQ
         0kwaWm7er9BbWFLbvKxm4oSna1pg2Zl5ZcWiesZK1TMD8bjDTBBwAPKwNf627MfOaClU
         1k24V9LF1gL311JOUHsm+MY+lJLXnLu5HPi4XdYmyw3SwE29Hg1Y2KhWbNYTB5ljrVQ2
         ZprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605494; x=1791210294;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cFi7chTl/dXnccUH1qK76VepQPSMCTxgrhW/RRhkUhE=;
        b=ynrLFXaQ4YyQwgOzBQJzFdmdZibWQKCMAunFnr2Sz6Dx5jXM5VlYsmgmEDBYEFbc/i
         HfiwF3UrSWR7GsBkW3shxrV6vVTsloxkdDdZn0HufUW8+Z+EE+UYaGAl3g8gFoYXlhew
         FK/rxHkHBDvfy4Y9yuwV7k+6nFZVVflUjuj4au5IwtT7XQ/ddwhJl3quXjNkyJCfRopD
         a1eus+7yO4PuWELQsO6S7Qri7zQPz4nFfcu4jn3DklL8WJ1nzRUF1dmBnBR5xHUSa9hn
         Ff7cxf+gP9lGV1s8vpYBj5yrAPUzseDwShFk5B4ysma8qNyG7QR8L8UVduOQqS7bUGH3
         euUA==
X-Forwarded-Encrypted: i=1; AKwUvBxWOk/wQJpnJtldpoj6ReoHy1/WxfzRY4wsiuZK2M+FonrpfCb2CoICBh5DbAEkuOhbwOw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTCFCWDHs2Om9MihVSvOhluLKRa45vVIsz0n4bXthbdc/+3IN/
	USwOUBp5aQxOWOK0yf15WqljaFJRiB/1KI740CCEgTQcORr6vW8MosfOitKPwjBom+YI8AQVni9
	6uGbugKmrvmuJNWSSWhNW63SYaG/pi3c=
X-Gm-Gg: AYBFou22BobB4nVRfvMZuShES6GWTymqHz08vx8P9IBDrW1fGprYeVFERA+BQGb6LC4
	WuaHO+qajewcIbpIWx/tHHwxjIPWmn4F7cuz9xlOwQlUYbAG6nTBHe6esps9eN0J+Xxkm6Vwgfb
	F4GlIwS/eluxQkHRfCpO11QNYDkkcSa4RvWKcjDrKq3u3F+snNWfEjLQVwP3zJc4pZ9tj0vPmUh
	4v9+aNseTc6/T04Xr6USOWYCsEqXrcQJis/ruRxWSnzN6lEEZUy+F2opoVjOP8ah68f0FXCHeJu
	xof1wUMy7tGDZgSbtfZHxaslMJAgbuHhgPfyGktcz6iNQVoNbskn1lw=
X-Received: by 2002:a05:6402:2406:b0:6aa:734b:1a2d with SMTP id
 4fb4d7f45d1cf-6aac908f34amr10185339a12.39.1790605493584; Mon, 28 Sep 2026
 07:24:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926070057.1234-1-luoyonggang@gmail.com> <20260926070057.1234-47-luoyonggang@gmail.com>
 <aro93NuZBXYGbD33@redhat.com>
In-Reply-To: <aro93NuZBXYGbD33@redhat.com>
Reply-To: luoyonggang@gmail.com
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Mon, 28 Sep 2026 22:24:39 +0800
X-Gm-Features: AclHuK_TF7EH46o0FV_02vjDQ7TfERSCRkWxvOvxDGTBInzpkGOWpF_MFAtARQg
Message-ID: <CAE2XoE9AAz8KfJrpErBaZvW5p5COxfE1yveA_AMPwa0j=ghyEA@mail.gmail.com>
Subject: Re: [PATCH v4 46/55] qapi: add query-targets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>, 
	Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, 
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
	qemu-arm@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 6:14=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> I don't think that we need to report machines though.
> We already have 'query-machines' which gives much broader
> information on the machines. "MachineInfo" needs to
> gain
>
>    "targets": ["SysEmuTarget"]
>
> to list which target(s) a machine can be used with.
>

This is my final design for the query-target / query-targets / query-machin=
es,
for consistency and testability.

Per review: reuse `QemuTargetInfo` for both target commands, drop the
per-target machine list, and let
`MachineInfo` say which target(s) each machine runs on.
`QemuTargetInfo` stays small; `query-target` and `query-targets` return a
derived struct that adds the target's device and accel Kconfig state.

## QemuTargetInfo

```
{ 'struct': 'QemuTargetInfo',
  'data': { 'arch': 'SysEmuTarget' } }  # since 1.2
```

`mips` and `mipsel` are distinct `SysEmuTarget` values; the target value
identifies the system emulator, including its endianness, rather than only
the underlying architecture family.

## QemuTargetDetails: QemuTargetInfo plus kconfig

```
{ 'struct': 'QemuTargetDetails',
  'base': 'QemuTargetInfo',
  'data': { 'kconfig': 'any' } }
```

`kconfig` maps every device and accel `CONFIG_*` symbol to whether it
is enabled for that target.

For example, `TYPE_NITRO_ENCLAVE_MACHINE` is available only when
`CONFIG_NITRO_ENCLAVE` is enabled for the target:

```
{ "arch": "x86_64",
  "kconfig": { "CONFIG_NITRO_ENCLAVE": true } }
```

Examples below are trimmed.

## query-target (now returns QemuTargetDetails)

Adding members to a return type is backward compatible; existing
clients reading only `arch` are unaffected.

```
{ 'command': 'query-target', 'returns': 'QemuTargetDetails' }
```

Single-target binary (`qemu-system-aarch64`):

```
-> { "execute": "query-target" }
<- { "return": { "arch": "aarch64",
                 "kconfig": { "CONFIG_ARM_VIRT": true,
                              "CONFIG_Q35": false,
                              ... } } }
```

## query-targets (new, returns ['QemuTargetDetails'])

Single-target binary:

```
-> { "execute": "query-targets" }
<- { "return": [ { "arch": "aarch64",
                   "kconfig": { "CONFIG_ARM_VIRT": true,
                                "CONFIG_Q35": false, ... } } ] }
```

Combined `qemu-system` linking aarch64 and riscv64 (`none` is always
present):

```
-> { "execute": "query-targets" }
<- { "return": [ { "arch": "aarch64",
                   "kconfig": { "CONFIG_ARM_VIRT": true,
                                "CONFIG_RISCV_VIRT": false, ... } },
                 { "arch": "riscv64",
                   "kconfig": { "CONFIG_ARM_VIRT": false,
                                "CONFIG_RISCV_VIRT": true, ... } },
                 { "arch": "none",
                   "kconfig": { "CONFIG_ARM_VIRT": false,
                                "CONFIG_RISCV_VIRT": false, ... } } ] }
```

## query-machines: MachineInfo gains targets

```
{ 'struct': 'MachineInfo',
  'data': { 'name': 'str', 'typename': 'str', ...existing members...,
            'targets': ['QemuTargetInfo'] } }   # since 11.2
```

Combined `qemu-system` (other MachineInfo members trimmed):

```
-> { "execute": "query-machines" }
<- { "return": [
       { "name": "virt-11.2", "typename": "arm-virt-11.2-machine",
         "alias": "virt", "is-default": false,
         "cpu-max": 512, "deprecated": false, "secure": true,
         "targets": [ { "arch": "aarch64" } ] },
       { "name": "virt", "typename": "riscv-virt-machine",
         "cpu-max": 512, "deprecated": false,
         "secure": true,
         "targets": [ { "arch": "riscv64" } ] },
       { "name": "none", "typename": "none-machine",
         "cpu-max": 1, "deprecated": false,
         "secure": false,
         "targets": [ { "arch": "aarch64" },
                      { "arch": "riscv64" },
                      { "arch": "none" } ] }
     ] }
```

Single-target binary: every entry has exactly one element in
`targets`, equal to `query-target`'s `arch`.

A client that wants the old "machines per target" view filters
`query-machines` on `targets`.

## Open questions for the list

Machine names are not unique in a combined binary (`virt` above exists
for aarch64 and riscv64). `typename` is the unique QOM identity, so the
list contains one `MachineInfo` per `typename`; `targets` lists the
targets on which that machine type is available.

1. `kconfig` on `QemuTargetDetails`. The use case is tests telling "not
   built" apart from "missing". Open points:
   - `'any'` (a JSON object) vs. a list of enabled symbol names.
     The object makes a typo (symbol absent) distinguishable from
     "disabled" (`false`).
   - Stable, or an `unstable` feature, given that Kconfig symbol
     names are internal and can be renamed.
   - Size: several hundred entries per target, which is why it is
     in `QemuTargetDetails` (`query-target`, `query-targets`) and not
     in `QemuTargetInfo` (which contains only the target architecture).

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo
