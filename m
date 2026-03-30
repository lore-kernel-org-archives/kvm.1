Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A55E261B92
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 02:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774836509; cv=none; b=YQFnG9xuFjmOuMbdQWo9swF59iAlKz79duzyntVqq//Xdyr6bkIHxVeLdAGTYBMNnEsPKWWRICM1FCGRAnlG/VxiAP/P7nfHDQ/Y3Esoy8Gtn9DVx3kVrvszbM9EBLtBwWdrLWWbdLhAPUi05KvScRJUEli15sMvNvHZotqAXy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774836509; c=relaxed/simple;
	bh=AP76BybfmPT3yzu4ZrlC/O3hKdEjtfbMyHquP8QqMj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Holc5tsFg8qWmxmN08wd2KW2xV+vqjWCtKmL7146282BPayWiXF80Trt3BlSH/fOC9Blba3h8DJfUzG3ff6bR/7Nz7rhimdLGU/9i3lWXByUnWG6kYMPpGAxc/UsiEwoRMswpm7p/f+ruzuL9mgCTsdPJmt3gv22gMUGan35ZPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVY5DH8Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVY5DH8Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095A6C116C6
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 02:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774836509;
	bh=AP76BybfmPT3yzu4ZrlC/O3hKdEjtfbMyHquP8QqMj8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aVY5DH8YaRmPA0MFW339JsUeECKBgoIIVIbzAZUH4LDjJ9fa2lclgTmcoz+5Czyy4
	 pNrqkgfByLsUv0uFf05SDlrNdXdtxYnaEj0YeaPWEh3QVffU16DHUwTO/lWH4Q8nDZ
	 uakYd7KUU6zqofuL4SBNYEnOK811VKONsK0B2i4NIZR1779aRF3KrqphGN9oaoyxwz
	 ZTidta33hSUYmkrybN8gXPGFTMH9NhcUpI2gIJVEDK1rAM6IqETvbnxoax0Bly7PE1
	 zCjAw+pV7SVPZEk+drN2E/4C4W3neIZJRsQco3kDtD4DZ6ojOw9UMUAfpz81OdktFX
	 93wNkMa/jflQA==
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cfe71e5d3so404949f8f.0
        for <kvm@vger.kernel.org>; Sun, 29 Mar 2026 19:08:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YzdFdGi6bhA6uMBx2Cy3SRJBQwV0ZVxpXOnL4k/kmuFMtgG2BAI
	IQZwo/w78kmIXqCSVdQD6yIokUkDvqdgyzCcPHxaWLIdm7DqyxxbkpysABODz7IWOzF/yR34cBh
	DAan8YcS7ihKehy5rPEC1uC70g/itLws=
X-Received: by 2002:a05:6000:3107:b0:439:beb9:5a96 with SMTP id
 ffacd0b85a97d-43b9ea9afc1mr18964267f8f.31.1774836507574; Sun, 29 Mar 2026
 19:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324020227.214445-1-min_halo@163.com>
In-Reply-To: <20260324020227.214445-1-min_halo@163.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 30 Mar 2026 10:08:15 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT=FXzb8wSCSg5d852hFRM84aC0tXiW-ozffJkUkmJ5vg@mail.gmail.com>
X-Gm-Features: AQROBzAJ8qHupUF6HaCkcy9Ug1eKvAbHotIQXVvhQEb4kvVcAQYr_bhWZLS9TLQ
Message-ID: <CAJF2gTT=FXzb8wSCSg5d852hFRM84aC0tXiW-ozffJkUkmJ5vg@mail.gmail.com>
Subject: Re: [PATCH kvmtool] riscv: Add Zicbop extension support
To: Zongmin Zhou <min_halo@163.com>
Cc: kvm@vger.kernel.org, will@kernel.org, julien.thierry.kdev@gmail.com, 
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 10:09=E2=80=AFAM Zongmin Zhou <min_halo@163.com> wr=
ote:
>
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
>
> When the Zicbop extension is available expose it to the guest.
> Also provide the guest the size of the cache block through DT.
>
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
> ---
>  riscv/fdt.c                         | 12 +++++++++++-
>  riscv/include/kvm/kvm-config-arch.h |  3 +++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/riscv/fdt.c b/riscv/fdt.c
> index eba9387..510641e 100644
> --- a/riscv/fdt.c
> +++ b/riscv/fdt.c
> @@ -58,6 +58,7 @@ struct isa_ext_info isa_info_arr[] =3D {
>         {"zfh",         KVM_RISCV_ISA_EXT_ZFH},
>         {"zfhmin",      KVM_RISCV_ISA_EXT_ZFHMIN},
>         {"zicbom",      KVM_RISCV_ISA_EXT_ZICBOM},
> +       {"zicbop",      KVM_RISCV_ISA_EXT_ZICBOP},
>         {"zicboz",      KVM_RISCV_ISA_EXT_ZICBOZ},
>         {"ziccrse",     KVM_RISCV_ISA_EXT_ZICCRSE},
>         {"zicntr",      KVM_RISCV_ISA_EXT_ZICNTR},
> @@ -195,7 +196,7 @@ static void dump_fdt(const char *dtb_file, void *fdt)
>  #define CPU_NAME_MAX_LEN 15
>  static void generate_cpu_nodes(void *fdt, struct kvm *kvm)
>  {
> -       unsigned long cbom_blksz =3D 0, cboz_blksz =3D 0, satp_mode =3D 0=
;
> +       unsigned long cbom_blksz =3D 0, cboz_blksz =3D 0, cbop_blksz =3D =
0, satp_mode =3D 0;
>         int i, cpu, pos, arr_sz =3D ARRAY_SIZE(isa_info_arr);
>
>         _FDT(fdt_begin_node(fdt, "cpus"));
> @@ -249,6 +250,13 @@ static void generate_cpu_nodes(void *fdt, struct kvm=
 *kvm)
>                                         die("KVM_GET_ONE_REG failed (conf=
ig.zicboz_block_size)");
>                         }
>
> +                       if (isa_info_arr[i].ext_id =3D=3D KVM_RISCV_ISA_E=
XT_ZICBOP && !cbop_blksz) {
> +                               reg.id =3D RISCV_CONFIG_REG(zicbop_block_=
size);
> +                               reg.addr =3D (unsigned long)&cbop_blksz;
> +                               if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG,=
 &reg) < 0)
> +                                       die("KVM_GET_ONE_REG failed (conf=
ig.zicbop_block_size)");
> +                       }
> +
>                         if ((strlen(isa_info_arr[i].name) + pos + 1) >=3D=
 CPU_ISA_MAX_LEN) {
>                                 pr_warning("Insufficient space to append =
ISA exension %s\n",
>                                            isa_info_arr[i].name);
> @@ -305,6 +313,8 @@ static void generate_cpu_nodes(void *fdt, struct kvm =
*kvm)
>                         _FDT(fdt_property_cell(fdt, "riscv,cbom-block-siz=
e", cbom_blksz));
>                 if (cboz_blksz)
>                         _FDT(fdt_property_cell(fdt, "riscv,cboz-block-siz=
e", cboz_blksz));
> +               if (cbop_blksz)
> +                       _FDT(fdt_property_cell(fdt, "riscv,cbop-block-siz=
e", cbop_blksz));
>                 _FDT(fdt_property_cell(fdt, "reg", cpu));
>                 _FDT(fdt_property_string(fdt, "status", "okay"));
>
> diff --git a/riscv/include/kvm/kvm-config-arch.h b/riscv/include/kvm/kvm-=
config-arch.h
> index 6d9a29a..d3e1f56 100644
> --- a/riscv/include/kvm/kvm-config-arch.h
> +++ b/riscv/include/kvm/kvm-config-arch.h
> @@ -135,6 +135,9 @@ int riscv__cpu_type_parser(const struct option *opt, =
const char *arg, int unset)
>         OPT_BOOLEAN('\0', "disable-zicboz",                             \
>                     &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZICBOZ],     \
>                     "Disable Zicboz Extension"),                        \
> +       OPT_BOOLEAN('\0', "disable-zicbop",                             \
> +                   &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZICBOP],     \
> +                   "Disable Zicbop Extension"),                        \
>         OPT_BOOLEAN('\0', "disable-ziccrse",                            \
>                     &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZICCRSE],    \
>                     "Disable Ziccrse Extension"),                       \
> --
> 2.47.3
>

Will introduced kvm_riscv_config.zicbop_block_size in commit
ef7a3e85790bd ("Sync kernel UAPI headers with v6.19"), and this patch
is a good fill for empty usage.

Reviewed-by: Guo Ren <guoren@kernel.org>


--
Best Regards
 Guo Ren
