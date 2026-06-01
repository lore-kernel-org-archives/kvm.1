Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FE638AC7E
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302547; cv=pass; b=C8hix9jtHgXiWYpdSkqw1eRG+GZQ6979G9E9D1v3+fCetUsgvX67a/laAdhkRvIL6D+Q+INEWZmnlP9WKz1z2Q6V6jBPcSpLGCIPKRiM4gntcbW83AhAsB3i38Asb90SlKA1fWHwAgoGjyW+nOggDzfMKr5VPaEuhM0UNkBGrdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302547; c=relaxed/simple;
	bh=+USH/4WFsR6fksFeSwEsjAe8sgtqFR1LKqN+uWh81GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVYdhJgLKVgAmfbvzjEZkOAY9DSUyy2KK5lAjUrV7+m4qG+XXeKxEmH2XpJbMTj8mdfBa+dCMoqU7IwM/C7kf1aXwXn+NcXo+Si8wyBh01Aim71TxglEACEdE/f8zj6ObrKlsdir40noHTE3iYMQndOMmqbZlkLWnG6/+3+6X8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=G9ofhXkM; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="G9ofhXkM"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-43b8a96ff5eso5834226fac.2
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 01:29:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780302544; cv=none;
        d=google.com; s=arc-20240605;
        b=XH/PlOuboAsadnCfbSt0oFB+S86JPwNsQv06y1HoO07noi1jazd/sz09vuzfeoFurh
         0i8zqQZDj2JOiYksdKeCdtbodlCzzIB/90LTsOp8Gv2kBgJBmU3GYSE7tMV9ib0Zqlyo
         BVC7JGi45cYFEECUgWkXVMZ4Mfp1GRG+tlnu6xmzazOGH4zBu+1jnOO7jc65SCwIvE/U
         9n/mvgAr9q1s2ui0a0yGTBUWI1GC+dSPWK3419TsKNCcUH9WMddOor+RIP7l3kRLFjD9
         tCFYh1Szo1xxWKLU7HifzBgSsBCzg7i0MfyiAkk1xJc/E6clbWW+YcKutfSsLrMj8AZU
         mdkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T4uERWVbCtCe0m5H8gTjxpfOhUH2UbpUvtNnS13RKH0=;
        fh=p6rdjnODSqyr9nWjtHaCNThOyJc3cC6REu1f7q4uEhA=;
        b=JwvX6h8PZJcB5b1CzDACBuA/ANygapz1wdE0hHlZXsSywHJhUm6UWGKpHYp3EHIn7m
         eTRIgHtV+rww6OCgD6C3YtzDzpPUZcPWG6J9m+VTEUhiaSQmur9R1C7hJVL0+QvrHVsW
         QteiotdMqtCmIn87O1Xeoh4m7/UE0qLPQcxxZ00pUfjEIyAU2cyTC5q85lfNmcPZmtfg
         xZ/pOD1iALs3vT1p0FrGHDBi9Yavxi9sVpis1reL3Q6rECq5U1HYlZvloMozzCANwfvb
         ntoOMpP2rfUFInCvlHD1E3MAVR4r6oriVLcllpI25S5ClEKLuwCocGanhISEHqb5A6X3
         hhsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780302544; x=1780907344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4uERWVbCtCe0m5H8gTjxpfOhUH2UbpUvtNnS13RKH0=;
        b=G9ofhXkMlDm9BE10WHBMvv9BghBmLOhCM8IcepTxyuBG5R9TQmm2PGZnWS+0Kt6Jte
         FzTKikwLauh3UpLX7GQPRfoD99w7Lz3PI8IELtrO4bfPEXpV4zYMBsqSsf7i1bMsdUfw
         7G8AJmSeu5vdodmW0adSXd+dzxLQJO6SGpqbdVUzuvhJxPmP+ka2n7YtCn7Gg07R+UMU
         FTN8iZ0z1o8LgaFzuPgLy86B2042B+QvC5cpq6LfOwhzDEd5IF/tfZrrYqFVUh0NCUeg
         K2rDTqvKQ8mW8o4wOfbHOGvDBmh+MJKxwhlyO/BwWSqUN43CmYmd3HghWQF1FerZNohH
         Y7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780302544; x=1780907344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T4uERWVbCtCe0m5H8gTjxpfOhUH2UbpUvtNnS13RKH0=;
        b=Qw5SG6IEKMA/g3Z3Mi6AV9psCvPMLlGwik4gVHPKLrpNVyoUM2wXJaJF5H0Um/lxBc
         lalcNir5VRg7tw3v+KhlhJ2b6YBwXG60QpNWVFzZuVT/AOjmTw1Tif3+mc/Hr4fioBuM
         6t3ffeAOWfrTlEzlFqxd4bagidNckkOEV9Xc6uDnHRBGVsCW89i4bu7R67iUUcq+2y1S
         zkRHKEFNEJ50Dmb2BvqnqcTVQuGj7W4eWDb+Y86JjoMO8CXYQTXhX8Dc3yotEycEXDGZ
         PTzV5f2X+ReHaNmmZUT/Qr2JfIJvEA1LIyh6X8XintYlt06ulysVXQdhfDich/w/+GXa
         UNAA==
X-Forwarded-Encrypted: i=1; AFNElJ8ZV6IcBv91ZBHbPivshB84/pGng4cilKQtTdOIa0xm4YAaowSJAyHyna3/fno4SMHKBMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLwD4dxD+mGRPjQkL+kUsSstWqI70XBiHOYg+mfnZ7ucOn9828
	GSOF+h1R/qWOWFn8OOLBgTYhzQ2JsawTsaqEntA5hE5ERpB3L9UcDX0zVFPQp7j2RRmeIxS0C5y
	6qgNVIU2RCo6IDEIyuAqWvj6YLz/hi8THqB58vlGFEg==
X-Gm-Gg: Acq92OGfYiBLh7yTpVxS5F65gb/ieGoG+SwRPdIsuneNpId5AP4E76kinCXgV/gRm8M
	pSppqylFEQfoRLvwaTr0+JAFwuGEwprQYKz3fOwRtRSizFLIgA1tgBt7FzkjrFulgoJanvyZSub
	h0Pmm8UEd4PaLEIRUM5v6vNNqbU2pGllKotbqofXgV8JQeXpLSnZHHyZWlyNkf4BivnFtSI7/lB
	Gh/HfPn/d8V2ZpVbHrNOHoKNOGJu23UPdUHwR9Vrp1xmqxbh68HeDO00GX9rGkTlri7TlF5ZrGN
	6lJDaUPRIzkpjemAsBmWCbGAWqD/rKqnGHFGfUuDPGx68j1BgBm4SS9d9nXClBF9DdEHEfrq+JH
	C6CiMFL34p4n4zRmN0uG92fnc8EznsT8EHNpU3w==
X-Received: by 2002:a05:6820:812:b0:699:b131:d597 with SMTP id
 006d021491bc7-69e102b1845mr5081053eaf.6.1780302543533; Mon, 01 Jun 2026
 01:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511-rva23u64-hwprobe-v2-v2-0-21c5a544f1dc@riscstar.com> <20260511-rva23u64-hwprobe-v2-v2-3-21c5a544f1dc@riscstar.com>
In-Reply-To: <20260511-rva23u64-hwprobe-v2-v2-3-21c5a544f1dc@riscstar.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 1 Jun 2026 13:58:51 +0530
X-Gm-Features: AVHnY4J1GWaIVQKgCjbs8yN38J-g4wxDak7kSB1h-MokIhPcmqYhp9wP8gA_jbI
Message-ID: <CAAhSdy0pHPAMRRR-Mri735zLu3ymr=ePQ7gA6zZ11BkHEXj+AA@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] riscv: Standardize extension capitalization
To: Paul Walmsley <pjw@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shuah Khan <shuah@kernel.org>, Atish Patra <atish.patra@linux.dev>, 
	Shuah Khan <skhan@linuxfoundation.org>, Deepak Gupta <debug@rivosinc.com>, 
	Zong Li <zong.li@sifive.com>, Christian Brauner <brauner@kernel.org>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, linux-doc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, Charlie Jenkins <thecharlesjenkins@gmail.com>, 
	Guodong Xu <guodong@riscstar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 7:06=E2=80=AFPM Guodong Xu <guodong@riscstar.com> w=
rote:
>
> From: Charlie Jenkins <charlie@rivosinc.com>
>
> The base extensions are often lowercase and were written as lowercase in
> hwcap, but other references to these extensions in the kernel are
> uppercase. Standardize the case to make it easier to handle macro
> expansion.
>
> Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> [Apply KVM_ISA_EXT_ARR(), fixup all KVM use.]
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>

LGTM.

Acked-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Anup Patel <anup@brainfault.org>

@Paul, This patch is independent of other changes
in this series. If you are okay then I can take this single
patch through KVM RISC-V tree.

Regards,
Anup



>
> ---
> v2:
> - Rebased onto v7.1-rc2.
> - KVM_ISA_EXT_ARR() consolidation moved to its new upstream location
>   (kvm/isa.c); host-side checks now use kvm_riscv_isa_check_host().
> ---
>  arch/riscv/include/asm/hwcap.h     | 18 +++++++++---------
>  arch/riscv/include/asm/switch_to.h |  4 ++--
>  arch/riscv/kernel/cpufeature.c     | 32 ++++++++++++++++----------------
>  arch/riscv/kernel/sys_hwprobe.c    |  4 ++--
>  arch/riscv/kvm/isa.c               | 16 ++++++++--------
>  arch/riscv/kvm/main.c              |  2 +-
>  arch/riscv/kvm/vcpu_fp.c           | 20 ++++++++++----------
>  arch/riscv/kvm/vcpu_onereg.c       |  6 +++---
>  arch/riscv/kvm/vcpu_vector.c       | 10 +++++-----
>  9 files changed, 56 insertions(+), 56 deletions(-)
>
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index 7ef8e5f55c8dc..44bf8c7d8acc5 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -10,15 +10,15 @@
>
>  #include <uapi/asm/hwcap.h>
>
> -#define RISCV_ISA_EXT_a                ('a' - 'a')
> -#define RISCV_ISA_EXT_c                ('c' - 'a')
> -#define RISCV_ISA_EXT_d                ('d' - 'a')
> -#define RISCV_ISA_EXT_f                ('f' - 'a')
> -#define RISCV_ISA_EXT_h                ('h' - 'a')
> -#define RISCV_ISA_EXT_i                ('i' - 'a')
> -#define RISCV_ISA_EXT_m                ('m' - 'a')
> -#define RISCV_ISA_EXT_q                ('q' - 'a')
> -#define RISCV_ISA_EXT_v                ('v' - 'a')
> +#define RISCV_ISA_EXT_A                ('a' - 'a')
> +#define RISCV_ISA_EXT_C                ('c' - 'a')
> +#define RISCV_ISA_EXT_D                ('d' - 'a')
> +#define RISCV_ISA_EXT_F                ('f' - 'a')
> +#define RISCV_ISA_EXT_H                ('h' - 'a')
> +#define RISCV_ISA_EXT_I                ('i' - 'a')
> +#define RISCV_ISA_EXT_M                ('m' - 'a')
> +#define RISCV_ISA_EXT_Q                ('q' - 'a')
> +#define RISCV_ISA_EXT_V                ('v' - 'a')
>
>  /*
>   * These macros represent the logical IDs of each multi-letter RISC-V IS=
A
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/=
switch_to.h
> index 0e71eb82f920c..ff35a4d04f85a 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -60,8 +60,8 @@ static inline void __switch_to_fpu(struct task_struct *=
prev,
>
>  static __always_inline bool has_fpu(void)
>  {
> -       return riscv_has_extension_likely(RISCV_ISA_EXT_f) ||
> -               riscv_has_extension_likely(RISCV_ISA_EXT_d);
> +       return riscv_has_extension_likely(RISCV_ISA_EXT_F) ||
> +               riscv_has_extension_likely(RISCV_ISA_EXT_D);
>  }
>  #else
>  static __always_inline bool has_fpu(void) { return false; }
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 1734f9a4c2fd7..5cf463570229d 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -84,7 +84,7 @@ EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
>  static int riscv_ext_f_depends(const struct riscv_isa_ext_data *data,
>                                const unsigned long *isa_bitmap)
>  {
> -       if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_f))
> +       if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_F))
>                 return 0;
>
>         return -EPROBE_DEFER;
> @@ -146,7 +146,7 @@ static int riscv_ext_f_validate(const struct riscv_is=
a_ext_data *data,
>          * Due to extension ordering, d is checked before f, so no deferr=
al
>          * is required.
>          */
> -       if (!__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_d)=
) {
> +       if (!__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_D)=
) {
>                 pr_warn_once("This kernel does not support systems with F=
 but not D\n");
>                 return -EINVAL;
>         }
> @@ -189,7 +189,7 @@ static int riscv_ext_vector_float_validate(const stru=
ct riscv_isa_ext_data *data
>          * Since this function validates vector only, and v/Zve* are prob=
ed
>          * after f/d, there's no need for a deferral here.
>          */
> -       if (!__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_d)=
)
> +       if (!__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_D)=
)
>                 return -EINVAL;
>
>         return 0;
> @@ -224,7 +224,7 @@ static int riscv_ext_zcd_validate(const struct riscv_=
isa_ext_data *data,
>                                   const unsigned long *isa_bitmap)
>  {
>         if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZCA=
) &&
> -           __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_d))
> +           __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_D))
>                 return 0;
>
>         return -EPROBE_DEFER;
> @@ -237,7 +237,7 @@ static int riscv_ext_zcf_validate(const struct riscv_=
isa_ext_data *data,
>                 return -EINVAL;
>
>         if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZCA=
) &&
> -           __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_f))
> +           __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_F))
>                 return 0;
>
>         return -EPROBE_DEFER;
> @@ -490,15 +490,15 @@ static const unsigned int riscv_c_exts[] =3D {
>   * New entries to this struct should follow the ordering rules described=
 above.
>   */
>  const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
> -       __RISCV_ISA_EXT_DATA(i, RISCV_ISA_EXT_i),
> -       __RISCV_ISA_EXT_DATA(m, RISCV_ISA_EXT_m),
> -       __RISCV_ISA_EXT_SUPERSET(a, RISCV_ISA_EXT_a, riscv_a_exts),
> -       __RISCV_ISA_EXT_DATA_VALIDATE(f, RISCV_ISA_EXT_f, riscv_ext_f_val=
idate),
> -       __RISCV_ISA_EXT_DATA_VALIDATE(d, RISCV_ISA_EXT_d, riscv_ext_d_val=
idate),
> -       __RISCV_ISA_EXT_DATA(q, RISCV_ISA_EXT_q),
> -       __RISCV_ISA_EXT_SUPERSET(c, RISCV_ISA_EXT_c, riscv_c_exts),
> -       __RISCV_ISA_EXT_SUPERSET_VALIDATE(v, RISCV_ISA_EXT_v, riscv_v_ext=
s, riscv_ext_vector_float_validate),
> -       __RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
> +       __RISCV_ISA_EXT_DATA(i, RISCV_ISA_EXT_I),
> +       __RISCV_ISA_EXT_DATA(m, RISCV_ISA_EXT_M),
> +       __RISCV_ISA_EXT_SUPERSET(a, RISCV_ISA_EXT_A, riscv_a_exts),
> +       __RISCV_ISA_EXT_DATA_VALIDATE(f, RISCV_ISA_EXT_F, riscv_ext_f_val=
idate),
> +       __RISCV_ISA_EXT_DATA_VALIDATE(d, RISCV_ISA_EXT_D, riscv_ext_d_val=
idate),
> +       __RISCV_ISA_EXT_DATA(q, RISCV_ISA_EXT_Q),
> +       __RISCV_ISA_EXT_SUPERSET(c, RISCV_ISA_EXT_C, riscv_c_exts),
> +       __RISCV_ISA_EXT_SUPERSET_VALIDATE(v, RISCV_ISA_EXT_V, riscv_v_ext=
s, riscv_ext_vector_float_validate),
> +       __RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_H),
>         __RISCV_ISA_EXT_SUPERSET_VALIDATE(zicbom, RISCV_ISA_EXT_ZICBOM, r=
iscv_xlinuxenvcfg_exts, riscv_ext_zicbom_validate),
>         __RISCV_ISA_EXT_DATA_VALIDATE(zicbop, RISCV_ISA_EXT_ZICBOP, riscv=
_ext_zicbop_validate),
>         __RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, r=
iscv_xlinuxenvcfg_exts, riscv_ext_zicboz_validate),
> @@ -897,8 +897,8 @@ static void __init riscv_fill_hwcap_from_isa_string(u=
nsigned long *isa2hwcap)
>                  * marchid.
>                  */
>                 if (acpi_disabled && boot_vendorid =3D=3D THEAD_VENDOR_ID=
 && boot_archid =3D=3D 0x0) {
> -                       this_hwcap &=3D ~isa2hwcap[RISCV_ISA_EXT_v];
> -                       clear_bit(RISCV_ISA_EXT_v, source_isa);
> +                       this_hwcap &=3D ~isa2hwcap[RISCV_ISA_EXT_V];
> +                       clear_bit(RISCV_ISA_EXT_V, source_isa);
>                 }
>
>                 riscv_resolve_isa(source_isa, isainfo->isa, &this_hwcap, =
isa2hwcap);
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwpr=
obe.c
> index 1659d31fd288f..f8f68ba781b45 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -88,10 +88,10 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pa=
ir,
>         if (has_fpu())
>                 pair->value |=3D RISCV_HWPROBE_IMA_FD;
>
> -       if (riscv_isa_extension_available(NULL, c))
> +       if (riscv_isa_extension_available(NULL, C))
>                 pair->value |=3D RISCV_HWPROBE_IMA_C;
>
> -       if (has_vector() && riscv_isa_extension_available(NULL, v))
> +       if (has_vector() && riscv_isa_extension_available(NULL, V))
>                 pair->value |=3D RISCV_HWPROBE_IMA_V;
>
>         /*
> diff --git a/arch/riscv/kvm/isa.c b/arch/riscv/kvm/isa.c
> index 1132d909cc25c..94077117d1136 100644
> --- a/arch/riscv/kvm/isa.c
> +++ b/arch/riscv/kvm/isa.c
> @@ -17,14 +17,14 @@
>  /* Mapping between KVM ISA Extension ID & guest ISA extension ID */
>  static const unsigned long kvm_isa_ext_arr[] =3D {
>         /* Single letter extensions (alphabetically sorted) */
> -       [KVM_RISCV_ISA_EXT_A] =3D RISCV_ISA_EXT_a,
> -       [KVM_RISCV_ISA_EXT_C] =3D RISCV_ISA_EXT_c,
> -       [KVM_RISCV_ISA_EXT_D] =3D RISCV_ISA_EXT_d,
> -       [KVM_RISCV_ISA_EXT_F] =3D RISCV_ISA_EXT_f,
> -       [KVM_RISCV_ISA_EXT_H] =3D RISCV_ISA_EXT_h,
> -       [KVM_RISCV_ISA_EXT_I] =3D RISCV_ISA_EXT_i,
> -       [KVM_RISCV_ISA_EXT_M] =3D RISCV_ISA_EXT_m,
> -       [KVM_RISCV_ISA_EXT_V] =3D RISCV_ISA_EXT_v,
> +       KVM_ISA_EXT_ARR(A),
> +       KVM_ISA_EXT_ARR(C),
> +       KVM_ISA_EXT_ARR(D),
> +       KVM_ISA_EXT_ARR(F),
> +       KVM_ISA_EXT_ARR(H),
> +       KVM_ISA_EXT_ARR(I),
> +       KVM_ISA_EXT_ARR(M),
> +       KVM_ISA_EXT_ARR(V),
>         /* Multi letter extensions (alphabetically sorted) */
>         KVM_ISA_EXT_ARR(SMNPM),
>         KVM_ISA_EXT_ARR(SMSTATEEN),
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index cb8a65273c1f0..70640701310c8 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -85,7 +85,7 @@ static int __init riscv_kvm_init(void)
>         char slist[64];
>         const char *str;
>
> -       if (!riscv_isa_extension_available(NULL, h)) {
> +       if (!riscv_isa_extension_available(NULL, H)) {
>                 kvm_info("hypervisor extension not available\n");
>                 return -ENODEV;
>         }
> diff --git a/arch/riscv/kvm/vcpu_fp.c b/arch/riscv/kvm/vcpu_fp.c
> index 6ad6df26a2fd4..bb11e6757d349 100644
> --- a/arch/riscv/kvm/vcpu_fp.c
> +++ b/arch/riscv/kvm/vcpu_fp.c
> @@ -21,8 +21,8 @@ void kvm_riscv_vcpu_fp_reset(struct kvm_vcpu *vcpu)
>         struct kvm_cpu_context *cntx =3D &vcpu->arch.guest_context;
>
>         cntx->sstatus &=3D ~SR_FS;
> -       if (riscv_isa_extension_available(vcpu->arch.isa, f) ||
> -           riscv_isa_extension_available(vcpu->arch.isa, d))
> +       if (riscv_isa_extension_available(vcpu->arch.isa, F) ||
> +           riscv_isa_extension_available(vcpu->arch.isa, D))
>                 cntx->sstatus |=3D SR_FS_INITIAL;
>         else
>                 cntx->sstatus |=3D SR_FS_OFF;
> @@ -38,9 +38,9 @@ void kvm_riscv_vcpu_guest_fp_save(struct kvm_cpu_contex=
t *cntx,
>                                   const unsigned long *isa)
>  {
>         if ((cntx->sstatus & SR_FS) =3D=3D SR_FS_DIRTY) {
> -               if (riscv_isa_extension_available(isa, d))
> +               if (riscv_isa_extension_available(isa, D))
>                         __kvm_riscv_fp_d_save(cntx);
> -               else if (riscv_isa_extension_available(isa, f))
> +               else if (riscv_isa_extension_available(isa, F))
>                         __kvm_riscv_fp_f_save(cntx);
>                 kvm_riscv_vcpu_fp_clean(cntx);
>         }
> @@ -50,9 +50,9 @@ void kvm_riscv_vcpu_guest_fp_restore(struct kvm_cpu_con=
text *cntx,
>                                      const unsigned long *isa)
>  {
>         if ((cntx->sstatus & SR_FS) !=3D SR_FS_OFF) {
> -               if (riscv_isa_extension_available(isa, d))
> +               if (riscv_isa_extension_available(isa, D))
>                         __kvm_riscv_fp_d_restore(cntx);
> -               else if (riscv_isa_extension_available(isa, f))
> +               else if (riscv_isa_extension_available(isa, F))
>                         __kvm_riscv_fp_f_restore(cntx);
>                 kvm_riscv_vcpu_fp_clean(cntx);
>         }
> @@ -89,7 +89,7 @@ int kvm_riscv_vcpu_get_reg_fp(struct kvm_vcpu *vcpu,
>         void *reg_val;
>
>         if ((rtype =3D=3D KVM_REG_RISCV_FP_F) &&
> -           riscv_isa_extension_available(vcpu->arch.isa, f)) {
> +           riscv_isa_extension_available(vcpu->arch.isa, F)) {
>                 if (KVM_REG_SIZE(reg->id) !=3D sizeof(u32))
>                         return -EINVAL;
>                 if (reg_num =3D=3D KVM_REG_RISCV_FP_F_REG(fcsr))
> @@ -102,7 +102,7 @@ int kvm_riscv_vcpu_get_reg_fp(struct kvm_vcpu *vcpu,
>                 } else
>                         return -ENOENT;
>         } else if ((rtype =3D=3D KVM_REG_RISCV_FP_D) &&
> -                  riscv_isa_extension_available(vcpu->arch.isa, d)) {
> +                  riscv_isa_extension_available(vcpu->arch.isa, D)) {
>                 if (reg_num =3D=3D KVM_REG_RISCV_FP_D_REG(fcsr)) {
>                         if (KVM_REG_SIZE(reg->id) !=3D sizeof(u32))
>                                 return -EINVAL;
> @@ -138,7 +138,7 @@ int kvm_riscv_vcpu_set_reg_fp(struct kvm_vcpu *vcpu,
>         void *reg_val;
>
>         if ((rtype =3D=3D KVM_REG_RISCV_FP_F) &&
> -           riscv_isa_extension_available(vcpu->arch.isa, f)) {
> +           riscv_isa_extension_available(vcpu->arch.isa, F)) {
>                 if (KVM_REG_SIZE(reg->id) !=3D sizeof(u32))
>                         return -EINVAL;
>                 if (reg_num =3D=3D KVM_REG_RISCV_FP_F_REG(fcsr))
> @@ -151,7 +151,7 @@ int kvm_riscv_vcpu_set_reg_fp(struct kvm_vcpu *vcpu,
>                 } else
>                         return -ENOENT;
>         } else if ((rtype =3D=3D KVM_REG_RISCV_FP_D) &&
> -                  riscv_isa_extension_available(vcpu->arch.isa, d)) {
> +                  riscv_isa_extension_available(vcpu->arch.isa, D)) {
>                 if (reg_num =3D=3D KVM_REG_RISCV_FP_D_REG(fcsr)) {
>                         if (KVM_REG_SIZE(reg->id) !=3D sizeof(u32))
>                                 return -EINVAL;
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index bb920e8923c93..5cc7ddd4aa276 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -770,7 +770,7 @@ static inline unsigned long num_fp_f_regs(const struc=
t kvm_vcpu *vcpu)
>  {
>         const struct kvm_cpu_context *cntx =3D &vcpu->arch.guest_context;
>
> -       if (riscv_isa_extension_available(vcpu->arch.isa, f))
> +       if (riscv_isa_extension_available(vcpu->arch.isa, F))
>                 return sizeof(cntx->fp.f) / sizeof(u32);
>         else
>                 return 0;
> @@ -799,7 +799,7 @@ static inline unsigned long num_fp_d_regs(const struc=
t kvm_vcpu *vcpu)
>  {
>         const struct kvm_cpu_context *cntx =3D &vcpu->arch.guest_context;
>
> -       if (riscv_isa_extension_available(vcpu->arch.isa, d))
> +       if (riscv_isa_extension_available(vcpu->arch.isa, D))
>                 return sizeof(cntx->fp.d.f) / sizeof(u64) + 1;
>         else
>                 return 0;
> @@ -878,7 +878,7 @@ static inline unsigned long num_sbi_regs(struct kvm_v=
cpu *vcpu)
>
>  static inline unsigned long num_vector_regs(const struct kvm_vcpu *vcpu)
>  {
> -       if (!riscv_isa_extension_available(vcpu->arch.isa, v))
> +       if (!riscv_isa_extension_available(vcpu->arch.isa, V))
>                 return 0;
>
>         /* vstart, vl, vtype, vcsr, vlenb and 32 vector regs */
> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index 62d2fb77bb9b9..f26108a4e601e 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
> @@ -26,7 +26,7 @@ void kvm_riscv_vcpu_vector_reset(struct kvm_vcpu *vcpu)
>
>         cntx->vector.vlenb =3D riscv_v_vsize / 32;
>
> -       if (riscv_isa_extension_available(isa, v)) {
> +       if (riscv_isa_extension_available(isa, V)) {
>                 cntx->sstatus |=3D SR_VS_INITIAL;
>                 WARN_ON(!cntx->vector.datap);
>                 memset(cntx->vector.datap, 0, riscv_v_vsize);
> @@ -45,7 +45,7 @@ void kvm_riscv_vcpu_guest_vector_save(struct kvm_cpu_co=
ntext *cntx,
>                                       unsigned long *isa)
>  {
>         if ((cntx->sstatus & SR_VS) =3D=3D SR_VS_DIRTY) {
> -               if (riscv_isa_extension_available(isa, v))
> +               if (riscv_isa_extension_available(isa, V))
>                         __kvm_riscv_vector_save(cntx);
>                 kvm_riscv_vcpu_vector_clean(cntx);
>         }
> @@ -55,7 +55,7 @@ void kvm_riscv_vcpu_guest_vector_restore(struct kvm_cpu=
_context *cntx,
>                                          unsigned long *isa)
>  {
>         if ((cntx->sstatus & SR_VS) !=3D SR_VS_OFF) {
> -               if (riscv_isa_extension_available(isa, v))
> +               if (riscv_isa_extension_available(isa, V))
>                         __kvm_riscv_vector_restore(cntx);
>                 kvm_riscv_vcpu_vector_clean(cntx);
>         }
> @@ -154,7 +154,7 @@ int kvm_riscv_vcpu_get_reg_vector(struct kvm_vcpu *vc=
pu,
>         void *reg_addr;
>         int rc;
>
> -       if (!riscv_isa_extension_available(isa, v))
> +       if (!riscv_isa_extension_available(isa, V))
>                 return -ENOENT;
>
>         rc =3D kvm_riscv_vcpu_vreg_addr(vcpu, reg_num, reg_size, &reg_add=
r);
> @@ -180,7 +180,7 @@ int kvm_riscv_vcpu_set_reg_vector(struct kvm_vcpu *vc=
pu,
>         void *reg_addr;
>         int rc;
>
> -       if (!riscv_isa_extension_available(isa, v))
> +       if (!riscv_isa_extension_available(isa, V))
>                 return -ENOENT;
>
>         if (reg_num =3D=3D KVM_REG_RISCV_VECTOR_CSR_REG(vlenb)) {
>
> --
> 2.43.0
>
