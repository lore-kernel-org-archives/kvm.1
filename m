Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4123A169F
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776827385; cv=none; b=L1+zM5ymHBBbNtZYo3MXFWp7UgXZ9TgqrVsLgzOnWIo+3GhRkPZ5+U6oA6szMecLOOyasvoSv4vzk7RhMga04RPe4Roc9uJXVn9yEPsgciA0yMnAb5KxRkL5W+vuzf9idTRnsFbauImakL/SRLrgVT7kLDplpGZHdZsmbULF0uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776827385; c=relaxed/simple;
	bh=ZcIggO6rHVKXrbMaaBNS5ZInxgMloGHCtV37gIxmurY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMZzK9J38Vm7MuWn+u4p7fPgzbdcVoVqfhgHBFBmbu5JaQq4FyDJ/KE+w+KKkjPqR5+3Q/sAzxgTs5njKweXBWIxzJJxW+n80xgJnj2bV2IFIBO91r3QPH/0Uu6fTv1LlP5N1xc61kQzTKMBQYTlBwywOPtcfc6e4wnizBCC9gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Avp5W5po; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Avp5W5po"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF46C2BCC4
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776827384;
	bh=ZcIggO6rHVKXrbMaaBNS5ZInxgMloGHCtV37gIxmurY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Avp5W5poptctvjKCTAqiq6a8TNgR7vR/ZVQlrL42Da/YTuiAR/UZ9cGkt9hflaAGO
	 o/KDC2c6HZ5brkUSxcfaLJnftVULK2tj64go9WdsMKpS9lp/5IcXDrh5qSRGFPNFnR
	 VeGA8HMhYwnfRW29qgX3DbecftA6sy7nh19fkmUVV8XFnX/USSPn9XG3qpxKhPsQDr
	 mRMtOm6RVQBKhNH/IXrJhFGZ1sn6bwZAVcknvroHBK+VZ6RMcorm2BdevpoWYGhHLz
	 DfcZKHzFD1IPBHBSyD2P+NunT9DX5EMW0P0HZzqesOTB114Qeo5OpqZ/ul1i9UhOuW
	 hDc6hZkAFYGgA==
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cfd832155so3549499f8f.1
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 20:09:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+xQwItwF7bbi7g/wpGvy0Ekjerq8e368p2veTVRDGPkgDy2nWd4sUw0SFgFlNqAtH0Gf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYtZI42dr1LRXq2IYjDEH3g+DsgLrGzqOQbdrSYq6z8oyRpQ/r
	qPIVjvlv4kWXUv9jsl1sQBWoGoetfUz6Whx1CgvFOewQtXm1YQxEHrhwyyO7gYkC9LSPWvKIrIQ
	p0xkyUDnOhLEJ98hwTnchbQaVVSNR5u4=
X-Received: by 2002:a05:6000:144d:b0:43c:fe0e:5bbc with SMTP id
 ffacd0b85a97d-43fe3dc59a6mr29815285f8f.19.1776827382437; Tue, 21 Apr 2026
 20:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421145451.1597930-1-guoren@kernel.org> <20260421145451.1597930-4-guoren@kernel.org>
In-Reply-To: <20260421145451.1597930-4-guoren@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 22 Apr 2026 11:09:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSi_j2LsOSm2MEfz0y38O0MAEEqdYufciGtAhxVOC+U2A@mail.gmail.com>
X-Gm-Features: AQROBzBZe1JTgYQdvIW5sUIzIHV5HT_GKcTOIRFGW7PWkgVOz-gmNFks7hiURc0
Message-ID: <CAJF2gTSi_j2LsOSm2MEfz0y38O0MAEEqdYufciGtAhxVOC+U2A@mail.gmail.com>
Subject: Re: [PATCH 3/3] irqchip/riscv-imsic: Remove global nr_guest_files
 after KVM AIA per-HART conversion
To: fangyu.yu@linux.alibaba.com, cp0613@linux.alibaba.com, inochiama@gmail.com, 
	me@ziyao.cc, gaohan@iscas.ac.cn, anup@brainfault.org, atish.patra@linux.dev, 
	pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, tglx@kernel.org, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

This patch simply removed `nr_guest_files`, which is suboptimal. For
v2, I will keep `nr_guest_files` inside `struct imsic_local_config`
(per-HART) and compute the effective HGEI count in
`kvm_riscv_aia_enable()` as:

min(hgctrl->nr_hgei, lc->nr_guest_files)

This provides a more accurate and robust per-HART configuration.

Here are the updated two patches for your review:

    irqchip/riscv-imsic: Move nr_guest_files to per-HART local config

    With the recent KVM AIA per-HART HGEI conversion, the global
    nr_guest_files is no longer appropriate. Different HARTs in
    heterogeneous SoCs may have different numbers of guest interrupt
    files.

    Move `nr_guest_files` from `struct imsic_global_config` to
    `struct imsic_local_config`, and compute it per-CPU in
    imsic_setup_state() based on the actual MMIO guest file region size.

    Update the related comment to reflect that KVM now uses the
    per-HART value.

    This eliminates the last global assumption about guest files and
    completes the per-HART conversion series for RISC-V AIA/IMSIC.

    Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>

diff --git a/drivers/irqchip/irq-riscv-imsic-state.c
b/drivers/irqchip/irq-riscv-imsic-state.c
index e3ed874d89e7..3d455ef43298 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -784,7 +784,7 @@ static int __init imsic_parse_fwnode(struct
fwnode_handle *fwnode,

 int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
 {
-       u32 i, j, index, nr_parent_irqs, nr_mmios, nr_guest_files,
nr_handlers =3D 0;
+       u32 i, j, index, nr_parent_irqs, nr_mmios, nr_handlers =3D 0;
        struct imsic_global_config *global;
        struct imsic_local_config *local;
        void __iomem **mmios_va =3D NULL;
@@ -878,7 +878,6 @@ int __init imsic_setup_state(struct fwnode_handle
*fwnode, void *opaque)
        }

        /* Configure handlers for target CPUs */
-       global->nr_guest_files =3D BIT(global->guest_index_bits) - 1;
        for (i =3D 0; i < nr_parent_irqs; i++) {
                rc =3D imsic_get_parent_hartid(fwnode, i, &hartid);
                if (rc) {
@@ -920,13 +919,13 @@ int __init imsic_setup_state(struct
fwnode_handle *fwnode, void *opaque)
                local->msi_va =3D mmios_va[index] + reloff;

                /*
-                * KVM uses global->nr_guest_files to determine the
available guest
+                * KVM uses local->nr_guest_files to determine the
available guest
                 * interrupt files on each CPU. Take the minimum number of =
guest
                 * interrupt files across all CPUs to avoid KVM
incorrectly allocating
                 * an unexisted or unmapped guest interrupt file on some CP=
Us.
                 */
-               nr_guest_files =3D (resource_size(&mmios[index]) -
reloff) / IMSIC_MMIO_PAGE_SZ - 1;
-               global->nr_guest_files =3D min(global->nr_guest_files,
nr_guest_files);
+               local->nr_guest_files =3D
+                       (resource_size(&mmios[index]) - reloff) /
IMSIC_MMIO_PAGE_SZ - 1;

                nr_handlers++;
        }
diff --git a/include/linux/irqchip/riscv-imsic.h
b/include/linux/irqchip/riscv-imsic.h
index 4b348836de7a..13e8bd7ff4b4 100644
--- a/include/linux/irqchip/riscv-imsic.h
+++ b/include/linux/irqchip/riscv-imsic.h
@@ -40,6 +40,9 @@
 struct imsic_local_config {
        phys_addr_t                             msi_pa;
        void __iomem                            *msi_va;
+
+       /* Number of guest interrupt files per core */
+       u32                                     nr_guest_files;
 };

 struct imsic_global_config {
@@ -68,9 +71,6 @@ struct imsic_global_config {
        /* Number of guest interrupt identities */
        u32                                     nr_guest_ids;

-       /* Number of guest interrupt files per core */
-       u32                                     nr_guest_files;
-
        /* Per-CPU IMSIC addresses */
        struct imsic_local_config __percpu      *local;
 };

------------------------
The other one:

    RISC-V: KVM: AIA: Use per-HART IMSIC guest files to compute final HGEI =
count

    Now that `nr_guest_files` has been moved to `struct imsic_local_config`
    and is computed per-HART, KVM must respect the actual number of guest
    interrupt files available on each HART when setting up HGEI.

    In `kvm_riscv_aia_enable()`:

     - Retrieve the per-CPU IMSIC local config
     - Take `min(hgctrl->nr_hgei, lc->nr_guest_files)` as the final usable
       HGEI count for this HART
     - Use the result to initialize `free_bitmap`

    This ensures correct HGEI allocation on heterogeneous RISC-V SoCs
    where different cores may have different IMSIC guest file counts, and
    completes the per-HART conversion series.

    Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>

diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index 70ff1d25dd99..a5f4b7fe1dce 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -534,6 +534,9 @@ static void aia_hgei_exit(void)
 void kvm_riscv_aia_enable(void)
 {
        struct aia_hgei_control *hgctrl;
+       const struct imsic_global_config *gc;
+       const struct imsic_local_config *lc;
+       unsigned int nr_hgei;

        if (!kvm_riscv_aia_available())
                return;
@@ -547,8 +550,13 @@ void kvm_riscv_aia_enable(void)
        if (hgctrl->nr_hgei)
                hgctrl->nr_hgei--;

-       if (hgctrl->nr_hgei) {
-               hgctrl->free_bitmap =3D BIT(hgctrl->nr_hgei + 1) - 1;
+       gc =3D imsic_get_global_config();
+       lc =3D (gc) ? this_cpu_ptr(gc->local) : NULL;
+       if (lc)
+               nr_hgei =3D min(hgctrl->nr_hgei, lc->nr_guest_files);
+
+       if (nr_hgei) {
+               hgctrl->free_bitmap =3D BIT(nr_hgei + 1) - 1;
                hgctrl->free_bitmap &=3D ~BIT(0);
        } else {
                hgctrl->free_bitmap =3D 0;


On Tue, Apr 21, 2026 at 10:55=E2=80=AFPM <guoren@kernel.org> wrote:
>
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>
> With the recent KVM AIA changes, HGEI line management is now fully
> per-CPU (via struct aia_hgei_control::nr_hgei) and the global
> kvm_riscv_aia_nr_hgei has been replaced by a simple enabled flag.
> The IMSIC driver no longer needs to compute and enforce a global
> minimum number of guest interrupt files across all HARTs.
>
> Remove:
>  - `u32 nr_guest_files` from `struct imsic_global_config`
>  - the initial `BIT(global->guest_index_bits) - 1` assignment
>  - the entire per-CPU MMIO-based min() calculation and its comment
>    (which was specifically there to protect old KVM)
>
> The per-HART guest file count is already handled locally in
> `imsic_local_config` during the parent IRQ loop, so this global
> field was redundant.
>
> This completes the cleanup series, eliminates the last global
> assumption about guest files, and improves support for heterogeneous
> (big.LITTLE / multi-vendor) RISC-V platforms.
>
> Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> ---
>  drivers/irqchip/irq-riscv-imsic-state.c | 12 +-----------
>  include/linux/irqchip/riscv-imsic.h     |  3 ---
>  2 files changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/ir=
q-riscv-imsic-state.c
> index e3ed874d89e7..fef27247a34f 100644
> --- a/drivers/irqchip/irq-riscv-imsic-state.c
> +++ b/drivers/irqchip/irq-riscv-imsic-state.c
> @@ -784,7 +784,7 @@ static int __init imsic_parse_fwnode(struct fwnode_ha=
ndle *fwnode,
>
>  int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
>  {
> -       u32 i, j, index, nr_parent_irqs, nr_mmios, nr_guest_files, nr_han=
dlers =3D 0;
> +       u32 i, j, index, nr_parent_irqs, nr_mmios, nr_handlers =3D 0;
>         struct imsic_global_config *global;
>         struct imsic_local_config *local;
>         void __iomem **mmios_va =3D NULL;
> @@ -878,7 +878,6 @@ int __init imsic_setup_state(struct fwnode_handle *fw=
node, void *opaque)
>         }
>
>         /* Configure handlers for target CPUs */
> -       global->nr_guest_files =3D BIT(global->guest_index_bits) - 1;
>         for (i =3D 0; i < nr_parent_irqs; i++) {
>                 rc =3D imsic_get_parent_hartid(fwnode, i, &hartid);
>                 if (rc) {
> @@ -919,15 +918,6 @@ int __init imsic_setup_state(struct fwnode_handle *f=
wnode, void *opaque)
>                 local->msi_pa =3D mmios[index].start + reloff;
>                 local->msi_va =3D mmios_va[index] + reloff;
>
> -               /*
> -                * KVM uses global->nr_guest_files to determine the avail=
able guest
> -                * interrupt files on each CPU. Take the minimum number o=
f guest
> -                * interrupt files across all CPUs to avoid KVM incorrect=
ly allocating
> -                * an unexisted or unmapped guest interrupt file on some =
CPUs.
> -                */
> -               nr_guest_files =3D (resource_size(&mmios[index]) - reloff=
) / IMSIC_MMIO_PAGE_SZ - 1;
> -               global->nr_guest_files =3D min(global->nr_guest_files, nr=
_guest_files);
> -
>                 nr_handlers++;
>         }
>
> diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/=
riscv-imsic.h
> index 4b348836de7a..7f3ff5c5ea53 100644
> --- a/include/linux/irqchip/riscv-imsic.h
> +++ b/include/linux/irqchip/riscv-imsic.h
> @@ -68,9 +68,6 @@ struct imsic_global_config {
>         /* Number of guest interrupt identities */
>         u32                                     nr_guest_ids;
>
> -       /* Number of guest interrupt files per core */
> -       u32                                     nr_guest_files;
> -
>         /* Per-CPU IMSIC addresses */
>         struct imsic_local_config __percpu      *local;
>  };
> --
> 2.40.1
>


--
Best Regards
 Guo Ren
