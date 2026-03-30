Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60523D0916
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876862; cv=none; b=Je3gUdWstHla11Q5nxKKJEYi8emVhxaXlSO7g9RNLvpwQLbay/DmMEsblPFOhl+qE4P6RXnYHi+HqeEK2doUwlWEfrSXFhZHHMSIe8iXjdGAlDQp+LLlpBwjstP372qaKR3auJt0utkRWjBsjx+YkaNaP2AAAq+pnqRJSLZEGRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876862; c=relaxed/simple;
	bh=KPke672Iy7VsBm4+Gbcr2ZB6wYCFW+/VSHwiIiTHAYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOIwbxYhBMR3US67JkMmzfYLd3jCLfVrjPIR9icsLrgaazQu01GfVGCasV8MpXjgeWuK+CQ4xaCGFCR0wURszz8Bd+25u1IgLA+4SB2dbjcD4OXNK6vpK07Xda4hWXigT2cP78zT9BuEl27DI1zUpguuBhMtEZrCv6OiC420zf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5SrlnO8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5SrlnO8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E32C2BCB3
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 13:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774876862;
	bh=KPke672Iy7VsBm4+Gbcr2ZB6wYCFW+/VSHwiIiTHAYA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m5SrlnO8VoaREPHAMO+uxueViLcyP4edtDKMeFKJcF6+6tn2XcnuAaJ2fUNvSSvKb
	 dHLCBd6LsqIKNQmLK2so3Ug7aPq+3w/1LXtglDKfmlAtDElBgxyALV+zb8O/GArr1X
	 ifDRfaf602MLQ9Kxfw/k9FPltw887OnSTCeaGu4DIYu3macnBJyK6/NR8YMGczDBZZ
	 fLjNs/vw/R1Ylbr3/t5KKY/LCYxozvsOFdLjO6NiWAMFH+DNKywLTRgRJN3W6hFH2h
	 kQjRDIseEfHlTEocy0XeG25YAfXSMvDDtVURRf3e1ZWnR211+ptJ7B/cdp/y0kyAEd
	 B5Impu7d//11A==
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43b87970468so4083290f8f.3
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 06:21:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjMZ0DNv6gAYf3S2LTTU+tYaqrgk+fbe91vDx2vjx4NmqezBvvWTaU8PXcSztsTK2qtdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi+CvWJF53BMM/AK9aKA/X4SOiNxCoxv5TktlVu9mZALuOLAAr
	fpTFUt+rR6PTwsftR3KEC8XySToGE4rYWcpYwhi30Bbqq71KwhZvA8I2k1xdivebqXN17KcY6ts
	yEF+qpIi6Lmgg7DmJmEHcnYf3/7pUQkI=
X-Received: by 2002:a5d:5d86:0:b0:43c:fed2:bb72 with SMTP id
 ffacd0b85a97d-43cfed2bcf4mr6870516f8f.19.1774876860837; Mon, 30 Mar 2026
 06:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330122601.22140-1-fangyu.yu@linux.alibaba.com> <20260330122601.22140-5-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260330122601.22140-5-fangyu.yu@linux.alibaba.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 30 Mar 2026 21:20:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTeJUGBHVWk0uUQuAeEdcQQd540hAshqqYAUKTCJUFOXQ@mail.gmail.com>
X-Gm-Features: AQROBzBOw6CjAB6LaBE98nlXAtriBsqtqJ9xeVAlowp6KFanMWJP0HjEjVCd6XA
Message-ID: <CAJF2gTTeJUGBHVWk0uUQuAeEdcQQd540hAshqqYAUKTCJUFOXQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] RISC-V: KVM: add KVM_CAP_RISCV_SET_HGATP_MODE
To: fangyu.yu@linux.alibaba.com
Cc: pbonzini@redhat.com, corbet@lwn.net, anup@brainfault.org, 
	atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, skhan@linuxfoundation.org, 
	radim.krcmar@oss.qualcomm.com, andrew.jones@oss.qualcomm.com, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 8:26=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrote=
:
>
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> Add a VM capability that allows userspace to select the G-stage page tabl=
e
> format by setting HGATP.MODE on a per-VM basis.
>
> Userspace enables the capability via KVM_ENABLE_CAP, passing the requeste=
d
> HGATP.MODE in args[0]. The request is rejected with -EINVAL if the mode i=
s
> not supported by the host, and with -EBUSY if the VM has already been
> committed (e.g. vCPUs have been created or any memslot is populated).
>
> KVM_CHECK_EXTENSION(KVM_CAP_RISCV_SET_HGATP_MODE) returns a bitmask of th=
e
> HGATP.MODE formats supported by the host.
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> ---
>  Documentation/virt/kvm/api.rst | 27 +++++++++++++++++++++++++++
>  arch/riscv/kvm/vm.c            | 18 ++++++++++++++++--
>  include/uapi/linux/kvm.h       |  1 +
>  3 files changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index 032516783e96..9d7f6958fa81 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -8902,6 +8902,33 @@ helpful if user space wants to emulate instruction=
s which are not
>  This capability can be enabled dynamically even if VCPUs were already
>  created and are running.
>
> +7.47 KVM_CAP_RISCV_SET_HGATP_MODE
> +---------------------------------
> +
> +:Architectures: riscv
> +:Type: VM
> +:Parameters: args[0] contains the requested HGATP mode
> +:Returns:
> +  - 0 on success.
> +  - -EINVAL if args[0] is outside the range of HGATP modes supported by =
the
> +    hardware.
> +  - -EBUSY if vCPUs have already been created for the VM, if the VM has =
any
> +    non-empty memslots.
> +
> +This capability allows userspace to explicitly select the HGATP mode for
> +the VM. The selected mode must be supported by both KVM and hardware. Th=
is
> +capability must be enabled before creating any vCPUs or memslots.
> +
> +If this capability is not enabled, KVM will select the default HGATP mod=
e
> +automatically. The default is the highest HGATP.MODE value supported by
> +hardware.
> +
> +``KVM_CHECK_EXTENSION(KVM_CAP_RISCV_SET_HGATP_MODE)`` returns a bitmask =
of
> +HGATP.MODE values supported by the host. A return value of 0 indicates t=
hat
> +the capability is not supported. Supported-mode bitmask use HGATP.MODE
> +encodings as defined by the RISC-V privileged specification, such as Sv3=
9x4
> +corresponds to HGATP.MODE=3D8, so userspace should test bitmask & BIT(8)=
.
> +
>  8. Other capabilities.
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index 4d82a886102c..5e82a3ad3ad0 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -201,6 +201,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
>         case KVM_CAP_VM_GPA_BITS:
>                 r =3D kvm_riscv_gstage_gpa_bits(kvm->arch.pgd_levels);
>                 break;
> +       case KVM_CAP_RISCV_SET_HGATP_MODE:
> +               r =3D kvm_riscv_get_hgatp_mode_mask();
> +               break;
>         default:
>                 r =3D 0;
>                 break;
> @@ -211,12 +214,23 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
>
>  int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
>  {
> +       if (cap->flags)
> +               return -EINVAL;
> +
>         switch (cap->cap) {
>         case KVM_CAP_RISCV_MP_STATE_RESET:
> -               if (cap->flags)
> -                       return -EINVAL;
>                 kvm->arch.mp_state_reset =3D true;
>                 return 0;
> +       case KVM_CAP_RISCV_SET_HGATP_MODE:
> +               if (!kvm_riscv_hgatp_mode_is_valid(cap->args[0]))
> +                       return -EINVAL;
> +
> +               if (kvm->created_vcpus || !kvm_are_all_memslots_empty(kvm=
))
> +                       return -EBUSY;
> +#ifdef CONFIG_64BIT
> +               kvm->arch.pgd_levels =3D 3 + cap->args[0] - HGATP_MODE_SV=
39X4;
> +#endif
> +               return 0;
>         default:
>                 return -EINVAL;
>         }
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 80364d4dbebb..a74a80fd4046 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -989,6 +989,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_ARM_SEA_TO_USER 245
>  #define KVM_CAP_S390_USER_OPEREXEC 246
>  #define KVM_CAP_S390_KEYOP 247
> +#define KVM_CAP_RISCV_SET_HGATP_MODE 248
>
>  struct kvm_irq_routing_irqchip {
>         __u32 irqchip;
> --
> 2.50.1
>
Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
