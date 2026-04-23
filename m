Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576824F5E0
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 04:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918048; cv=none; b=UwtzagK0crPHFG+5P7Tl47II3RHj4ujIjPi0uvV/8EY+FGmGv4wdBZn5z/rHgfv60oJ6YkN3W6fHXDZQmVAYDJXXmRsRVwbjsfWgmiGiF68rTUZVJh5ELJzE3ccd1KBgv9L265i3/JrgFYqieCV0oH/JYf62CGiw2so9ijdn/s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918048; c=relaxed/simple;
	bh=rQR/Gxa7esLwjh/1GhruJvDmkidRrkrPjdXuMifO1mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j92TDLZ/0NuYW9FxBugyXrxd+sLCed5sYh1Ff5wF5op2ajDGz1X6fCkr+lM0+z7nbsMUOO+oB6taDJn/hhUK85k2mTJ4SsRCwurMKvdwkV4iWI1D/CeB8EKvUHK78AKW9k77AAETTEXTjKqhDVMEs3BA4VmgvEz7Awyt9TdZ9qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sAb/1bXr; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAb/1bXr"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82735a41920so2520998b3a.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 21:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776918045; x=1777522845; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GfOCDFeuRY0gBaADLpxF7xAt7ukg8gVW7Q9qKSqhzCQ=;
        b=sAb/1bXrdacb61GJ47yLpcTkU+K6jwZ2hOm71OJScI2JFlX1VCXGGoV0gIeJuTqztp
         m1AHzuifEoegLxWPlTq/KI242eFpnGQUVf+XaYFxgHOqg5ktXjGPbbsmoDLkiSysv7FL
         U1pppRWbWSB9tyhL1XsGsYExb/DhQXW4OttZq86fUTmWzxcU/de/VuvfGctT89s8fxAO
         iMdjiIt8Xfru6MpWl5TgHI9CETWzFiVaxGdR49c8IJgWwKGrnh8d2htsKycKGIKA8u94
         kWdN1Lci7Kin+fdBIaerc/9bZFE9MgFKN+6+8HHy5BTcT9fvU9LntQ1SUvqqEB03oova
         F4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776918045; x=1777522845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfOCDFeuRY0gBaADLpxF7xAt7ukg8gVW7Q9qKSqhzCQ=;
        b=bWFQpuqh/uW1rj/L/hNXj8hJNnpHua5VZ2VNknw7sufBKwBBZq8vwjXWgA+NPSbNy4
         flhhqFH+832AnOyCnjMDqIgZ7BMM9fCWv9dwpcCAqMKBYvnEmu3kbfzNx6zzCT4KmhFi
         qjoMdX6Af/KRJKDToCpBCon/X8mkMdHCIoL0slB2yEwbxYdOIr9c3fHpH78RoK+4QY3h
         rDWhGx856SbYeITb3+xpGMozPKiM5O8LUmHGwr1+vgRfViI/J3WDb+c5e1ZbQGk/ED5j
         xSesSqrcSRIfif+wiGpeErOZA2tV8aGGo1xuRAPdk0A7YmAeCmQl1kS4edqyScOa6zBk
         SQHg==
X-Forwarded-Encrypted: i=1; AFNElJ9tX7Wv4K7NFRAn5UoGYhj5oIlPSIeK8jqBk6AVfveSlusv3OamsaqcSWJRrna2PfG4i2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YySoltR5OntvM6UV/S5vCo0UIQA3tue7luh8JPTfggQI7+Z70ql
	YNqgwujfNUXwTT7NCTvXC8b4ms2vS8u6xALxZLhJkP6I0ts52DryqTjS
X-Gm-Gg: AeBDieujLvZDWf/y5PZHI30ti+MfnoXAD2wZbConn+PA8Zz747tr0wv8aQCrsGzXctg
	6uhsEjXbK2aqs9o1uJqrTMwl7rFoabjs51/IVuj3+OCUcoYiq2zGxDQpF8P4s6KwUE1zWy6ngmx
	zms2AB1OnIUgztjW5fmrnhZH7GR9cMHZH1c0PkSq/nxIuh6T14pF5OaQEV0llMH7gL9EzVURxwW
	5WXBU98qCdAMd2spkdy0js55wW/U6O9INJldd2LDgF8W2XLDtpnE/PlKMv8rADp9dwzab6wfZ35
	UE/aG6zcxdMtqML5A35/DLR43cLUTj3APqCjhubT0dCFqhdttMrCPPayJHX0dv1P2jbgmmpW40O
	hveLp322cQFIfOaGFzWueV5nGn9BCgv4FWUGl4Csh2gNiw2DMuuj4SaWTPYhQ5k3pLLYGWtd+Az
	wolznE1MyArMufY8KoKJAIeOekpAOQzBnlUTmWCBVauZ81
X-Received: by 2002:a05:6a00:bb84:b0:81f:be3c:9c9e with SMTP id d2e1a72fcca58-82f8c8d67d0mr26456125b3a.33.1776918044598;
        Wed, 22 Apr 2026 21:20:44 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb3829sm19490565b3a.31.2026.04.22.21.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 21:20:43 -0700 (PDT)
Date: Thu, 23 Apr 2026 12:20:26 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Guo Ren <guoren@kernel.org>, fangyu.yu@linux.alibaba.com, 
	cp0613@linux.alibaba.com, inochiama@gmail.com, me@ziyao.cc, gaohan@iscas.ac.cn, 
	anup@brainfault.org, atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	alex@ghiti.fr, tglx@kernel.org, Albert Ou <aou@eecs.berkeley.edu>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/3] irqchip/riscv-imsic: Remove global nr_guest_files
 after KVM AIA per-HART conversion
Message-ID: <aemaxgRgviykvKPf@inochi.infowork>
References: <20260421145451.1597930-1-guoren@kernel.org>
 <20260421145451.1597930-4-guoren@kernel.org>
 <CAJF2gTSi_j2LsOSm2MEfz0y38O0MAEEqdYufciGtAhxVOC+U2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTSi_j2LsOSm2MEfz0y38O0MAEEqdYufciGtAhxVOC+U2A@mail.gmail.com>

On Wed, Apr 22, 2026 at 11:09:30AM +0800, Guo Ren wrote:
> Hi all,
> 
> This patch simply removed `nr_guest_files`, which is suboptimal. For
> v2, I will keep `nr_guest_files` inside `struct imsic_local_config`
> (per-HART) and compute the effective HGEI count in
> `kvm_riscv_aia_enable()` as:
> 
> min(hgctrl->nr_hgei, lc->nr_guest_files)
> 
> This provides a more accurate and robust per-HART configuration.
> 
> Here are the updated two patches for your review:
> 
>     irqchip/riscv-imsic: Move nr_guest_files to per-HART local config
> 
>     With the recent KVM AIA per-HART HGEI conversion, the global
>     nr_guest_files is no longer appropriate. Different HARTs in
>     heterogeneous SoCs may have different numbers of guest interrupt
>     files.
> 
>     Move `nr_guest_files` from `struct imsic_global_config` to
>     `struct imsic_local_config`, and compute it per-CPU in
>     imsic_setup_state() based on the actual MMIO guest file region size.
> 
>     Update the related comment to reflect that KVM now uses the
>     per-HART value.
> 
>     This eliminates the last global assumption about guest files and
>     completes the per-HART conversion series for RISC-V AIA/IMSIC.
> 
>     Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> 
> diff --git a/drivers/irqchip/irq-riscv-imsic-state.c
> b/drivers/irqchip/irq-riscv-imsic-state.c
> index e3ed874d89e7..3d455ef43298 100644
> --- a/drivers/irqchip/irq-riscv-imsic-state.c
> +++ b/drivers/irqchip/irq-riscv-imsic-state.c
> @@ -784,7 +784,7 @@ static int __init imsic_parse_fwnode(struct
> fwnode_handle *fwnode,
> 
>  int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
>  {
> -       u32 i, j, index, nr_parent_irqs, nr_mmios, nr_guest_files,
> nr_handlers = 0;
> +       u32 i, j, index, nr_parent_irqs, nr_mmios, nr_handlers = 0;
>         struct imsic_global_config *global;
>         struct imsic_local_config *local;
>         void __iomem **mmios_va = NULL;
> @@ -878,7 +878,6 @@ int __init imsic_setup_state(struct fwnode_handle
> *fwnode, void *opaque)
>         }
> 
>         /* Configure handlers for target CPUs */
> -       global->nr_guest_files = BIT(global->guest_index_bits) - 1;
>         for (i = 0; i < nr_parent_irqs; i++) {
>                 rc = imsic_get_parent_hartid(fwnode, i, &hartid);
>                 if (rc) {
> @@ -920,13 +919,13 @@ int __init imsic_setup_state(struct
> fwnode_handle *fwnode, void *opaque)
>                 local->msi_va = mmios_va[index] + reloff;
> 
>                 /*
> -                * KVM uses global->nr_guest_files to determine the
> available guest
> +                * KVM uses local->nr_guest_files to determine the
> available guest
>                  * interrupt files on each CPU. Take the minimum number of guest
>                  * interrupt files across all CPUs to avoid KVM
> incorrectly allocating
>                  * an unexisted or unmapped guest interrupt file on some CPUs.
>                  */

> -               nr_guest_files = (resource_size(&mmios[index]) -
> reloff) / IMSIC_MMIO_PAGE_SZ - 1;
> -               global->nr_guest_files = min(global->nr_guest_files,
> nr_guest_files);
> +               local->nr_guest_files =
> +                       (resource_size(&mmios[index]) - reloff) /
> IMSIC_MMIO_PAGE_SZ - 1;
> 

The min is still required, otherwise the local->nr_guest_files can be
bigger than BIT(global->guest_index_bits) - 1, which is the max number
of the guest interrupt files that a hart can have. This condition is
true if the IMSIC group has more than one harts.

Regards,
Inochi

>                 nr_handlers++;
>         }
> diff --git a/include/linux/irqchip/riscv-imsic.h
> b/include/linux/irqchip/riscv-imsic.h
> index 4b348836de7a..13e8bd7ff4b4 100644
> --- a/include/linux/irqchip/riscv-imsic.h
> +++ b/include/linux/irqchip/riscv-imsic.h
> @@ -40,6 +40,9 @@
>  struct imsic_local_config {
>         phys_addr_t                             msi_pa;
>         void __iomem                            *msi_va;
> +
> +       /* Number of guest interrupt files per core */
> +       u32                                     nr_guest_files;
>  };
> 
>  struct imsic_global_config {
> @@ -68,9 +71,6 @@ struct imsic_global_config {
>         /* Number of guest interrupt identities */
>         u32                                     nr_guest_ids;
> 
> -       /* Number of guest interrupt files per core */
> -       u32                                     nr_guest_files;
> -
>         /* Per-CPU IMSIC addresses */
>         struct imsic_local_config __percpu      *local;
>  };
> 
> ------------------------
> The other one:
> 
>     RISC-V: KVM: AIA: Use per-HART IMSIC guest files to compute final HGEI count
> 
>     Now that `nr_guest_files` has been moved to `struct imsic_local_config`
>     and is computed per-HART, KVM must respect the actual number of guest
>     interrupt files available on each HART when setting up HGEI.
> 
>     In `kvm_riscv_aia_enable()`:
> 
>      - Retrieve the per-CPU IMSIC local config
>      - Take `min(hgctrl->nr_hgei, lc->nr_guest_files)` as the final usable
>        HGEI count for this HART
>      - Use the result to initialize `free_bitmap`
> 
>     This ensures correct HGEI allocation on heterogeneous RISC-V SoCs
>     where different cores may have different IMSIC guest file counts, and
>     completes the per-HART conversion series.
> 
>     Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> 
> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index 70ff1d25dd99..a5f4b7fe1dce 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c
> @@ -534,6 +534,9 @@ static void aia_hgei_exit(void)
>  void kvm_riscv_aia_enable(void)
>  {
>         struct aia_hgei_control *hgctrl;
> +       const struct imsic_global_config *gc;
> +       const struct imsic_local_config *lc;
> +       unsigned int nr_hgei;
> 
>         if (!kvm_riscv_aia_available())
>                 return;
> @@ -547,8 +550,13 @@ void kvm_riscv_aia_enable(void)
>         if (hgctrl->nr_hgei)
>                 hgctrl->nr_hgei--;
> 
> -       if (hgctrl->nr_hgei) {
> -               hgctrl->free_bitmap = BIT(hgctrl->nr_hgei + 1) - 1;
> +       gc = imsic_get_global_config();
> +       lc = (gc) ? this_cpu_ptr(gc->local) : NULL;
> +       if (lc)
> +               nr_hgei = min(hgctrl->nr_hgei, lc->nr_guest_files);
> +
> +       if (nr_hgei) {
> +               hgctrl->free_bitmap = BIT(nr_hgei + 1) - 1;
>                 hgctrl->free_bitmap &= ~BIT(0);
>         } else {
>                 hgctrl->free_bitmap = 0;
> 
> 
> On Tue, Apr 21, 2026 at 10:55 PM <guoren@kernel.org> wrote:
> >
> > From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> >
> > With the recent KVM AIA changes, HGEI line management is now fully
> > per-CPU (via struct aia_hgei_control::nr_hgei) and the global
> > kvm_riscv_aia_nr_hgei has been replaced by a simple enabled flag.
> > The IMSIC driver no longer needs to compute and enforce a global
> > minimum number of guest interrupt files across all HARTs.
> >
> > Remove:
> >  - `u32 nr_guest_files` from `struct imsic_global_config`
> >  - the initial `BIT(global->guest_index_bits) - 1` assignment
> >  - the entire per-CPU MMIO-based min() calculation and its comment
> >    (which was specifically there to protect old KVM)
> >
> > The per-HART guest file count is already handled locally in
> > `imsic_local_config` during the parent IRQ loop, so this global
> > field was redundant.
> >
> > This completes the cleanup series, eliminates the last global
> > assumption about guest files, and improves support for heterogeneous
> > (big.LITTLE / multi-vendor) RISC-V platforms.
> >
> > Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> > ---
> >  drivers/irqchip/irq-riscv-imsic-state.c | 12 +-----------
> >  include/linux/irqchip/riscv-imsic.h     |  3 ---
> >  2 files changed, 1 insertion(+), 14 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
> > index e3ed874d89e7..fef27247a34f 100644
> > --- a/drivers/irqchip/irq-riscv-imsic-state.c
> > +++ b/drivers/irqchip/irq-riscv-imsic-state.c
> > @@ -784,7 +784,7 @@ static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
> >
> >  int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
> >  {
> > -       u32 i, j, index, nr_parent_irqs, nr_mmios, nr_guest_files, nr_handlers = 0;
> > +       u32 i, j, index, nr_parent_irqs, nr_mmios, nr_handlers = 0;
> >         struct imsic_global_config *global;
> >         struct imsic_local_config *local;
> >         void __iomem **mmios_va = NULL;
> > @@ -878,7 +878,6 @@ int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
> >         }
> >
> >         /* Configure handlers for target CPUs */
> > -       global->nr_guest_files = BIT(global->guest_index_bits) - 1;
> >         for (i = 0; i < nr_parent_irqs; i++) {
> >                 rc = imsic_get_parent_hartid(fwnode, i, &hartid);
> >                 if (rc) {
> > @@ -919,15 +918,6 @@ int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
> >                 local->msi_pa = mmios[index].start + reloff;
> >                 local->msi_va = mmios_va[index] + reloff;
> >
> > -               /*
> > -                * KVM uses global->nr_guest_files to determine the available guest
> > -                * interrupt files on each CPU. Take the minimum number of guest
> > -                * interrupt files across all CPUs to avoid KVM incorrectly allocating
> > -                * an unexisted or unmapped guest interrupt file on some CPUs.
> > -                */
> > -               nr_guest_files = (resource_size(&mmios[index]) - reloff) / IMSIC_MMIO_PAGE_SZ - 1;
> > -               global->nr_guest_files = min(global->nr_guest_files, nr_guest_files);
> > -
> >                 nr_handlers++;
> >         }
> >
> > diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/riscv-imsic.h
> > index 4b348836de7a..7f3ff5c5ea53 100644
> > --- a/include/linux/irqchip/riscv-imsic.h
> > +++ b/include/linux/irqchip/riscv-imsic.h
> > @@ -68,9 +68,6 @@ struct imsic_global_config {
> >         /* Number of guest interrupt identities */
> >         u32                                     nr_guest_ids;
> >
> > -       /* Number of guest interrupt files per core */
> > -       u32                                     nr_guest_files;
> > -
> >         /* Per-CPU IMSIC addresses */
> >         struct imsic_local_config __percpu      *local;
> >  };
> > --
> > 2.40.1
> >
> 
> 
> --
> Best Regards
>  Guo Ren
> 
> -- 
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv
