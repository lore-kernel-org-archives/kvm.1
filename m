Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3DF3E3DBD
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141435; cv=pass; b=NVZMERf9j4PYHdjGttQcr64ZNtcjKoRE06ZwntjJe0n6dat8C+KKpUwPrPF9XSoQZrVHAWrR0OGykNYfgGOiWuQXWJ0cqlXisoRFTYW8ssLcnY6xjXTW4AjNe43gHAzP9YaXXhsCjH0N6zNALPDEBuy0l3pOcFFknbezO1nd4Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141435; c=relaxed/simple;
	bh=8Myx6mMWS4mnOBzsC4ZdHhnonsc0lkeJ63Qli8FVnr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvakmVhXkt9jeAEdTxO6lJ9uLhmEeJ+1A2toqiwztTRF8Sqnvib/g4YSFcCyZTkGD8+uZw47Q+EJ3IHXklH/bhBM3sbegl/12W6O2ejk94XOH2U7ve3XNLomxqX/nzO1hTH+L+Q3oqaDcw27JVmGUyEVZV5mi4VEDzmkUuGHdqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=a1Cp7oTs; arc=pass smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="a1Cp7oTs"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-67bb04151dcso495640eaf.0
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 07:50:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775141433; cv=none;
        d=google.com; s=arc-20240605;
        b=FlchQynZ7bkDY/g4Yi0Tom37Qmp5IYFCa1u6vAFxhsD3Rq8VeIjJt3273B2GQxrCXx
         pnBmogmQsGjsL7NGOUSpwIvURnGtyatfQVCYXCcd3zemkjKieiltDXmPjRsv7yq2Jsy8
         LgDf/yrIsknGQlWnauy5ofiHNMZZWbQql/xKwKe1yuV6B4BwcRREiEbDNugdfWIaLlyp
         pOFo5ItsnyWoYGgnDrvmZlfmT4WVW2X+J76Zn+oGrD+2scDalUn3gFU6gnj0XeeATqaT
         uQTWlecCx97qDgF6RWZvTzqbWTU+AwjE0OW8GzLymRBUQWOBrzedbxlo9hTiHtm1OXOn
         BgIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=za6pvBAfLHdL3QlDjUc6Bu/xHQp9xLt2WtsbUx+6jAc=;
        fh=lOAVTBD0p4pp+kat+xoOTxaEnvt/51FXzw/O8brejdg=;
        b=am5qkuNrbiU6Ez6UpH4Ag2XTRzWMu8LFA16J9VDvnMOPBa1lo+SoG9Td5WuInZkqWk
         umf809CTNvu2TaaRhO1XY71CkW8ixjYAUBX+E4xzRVgulVAQwE58MDy14cPWch/AfNWM
         cO9wMTK15MqjVKY19AiSM2LCqU44kNDAgcxdG+DJHFQKo8IS6gUZLj51nljXjkGXXKJt
         gNtFa7jiSs8KUxgaqxj4o+oFs7apfx0iEoN67vt076CJEl3rhGwccIFcWcI0OAMxIXLz
         PS9XAb7Ddc+zzi9+yNVNYO/y+2kQoEy02YRqUrP06P7eywMU8Wsnn0igtt0WN9ofA+N/
         I/rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1775141433; x=1775746233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za6pvBAfLHdL3QlDjUc6Bu/xHQp9xLt2WtsbUx+6jAc=;
        b=a1Cp7oTsyPtsN2i4AYi/NVPWKGZC/XFcU5Et3jnTjwmoZHLNMIRDk5ZdwWkfEWi/OM
         XsTtKN8+DLes8eFig3tO0NKTol/8bqWpOCb6kzchZmkYcKH3w6HN7UtPkaVrGk7jc+Ms
         Bd+Yj8UA8uv2raBZMxIDwm6DnQE0kSelYvyzsgzPgrVAapDMB+idl55VdxE4wjwbF5H3
         6dziXd9NwBW5FpRMsU9jrIJIebU8du1TN7uQcJfB81C+ochjhM+sxZgSh3+C52g49/l2
         9Ik0FDFtEMyRemXG8LvX/HihA/+rCh+tbIMvS/v5l28XHCeKDAgnV+WwBMJqjn+KDPSX
         K2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775141433; x=1775746233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=za6pvBAfLHdL3QlDjUc6Bu/xHQp9xLt2WtsbUx+6jAc=;
        b=Gej+0C0g4CP0sU27o3cIqYdVFPDwOc3QPyuOYt3E6PW/v+VrP2B8Dqu4eXWZc7pEvQ
         pRpSfDedHzyOErBWUbWus+R5wer/Gj5MdBIGqVg8viNyt7szRRPhtPkot9W0IN9ZNXTq
         HmUUzt5T8AhF+GvRvflGEjumUYhsV2FpxQcoqWHhSeVIdwAW3usdkCmbAyrWYtXI537c
         NacejLWHm85PWd8maCcUhLQvwpLWvD3jEGR5kQlH6n3O+QfI7zzsFn8Ofoze25yqONkx
         GZgWh08SZEN0oI+GszVIC3SqSIt2DeHGZGLXzw/xVcbivIB1ndjdFkYNop4jtIVXMLeI
         W22g==
X-Forwarded-Encrypted: i=1; AJvYcCWvkcczzfowUzA7gjwLwzLevFsvJUwlPib52xdoNhHuO6eTATEEBESZC6y2/9J3fCiksbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI9W/NGJlfz1whNGwIogRuWhQRz2kjiZlnzhbhdKpNk1jXN/AU
	TUwvhGR6PKwyVoFFF4ypf9uE7OcdiVkg4sGeoHWDqxlmdtiogPkoiQDbm0mTHQuBOxuk+T1eEa8
	HT/WG30HAuYstjGsUOERbTcL4adJDhsWcmybsS3grMQ==
X-Gm-Gg: ATEYQzynKi05gSHe1Ka4KNKeqK7jly2VyC0PJz4pBrPx6D9ozdUWnunmFF/1JBM7KqP
	rMsIEIlzvWim7gn7NI9pqZvxDXh+78QbchaU92zy0lOAyrk/8xB40KHJhjkrkZmbQGTg3oEIzjz
	jmITfaG4OTaBMlG2J4ErX0fvnb43En8v2Cpb1gmqbsDuB85ElnQcObipaleClXVYRfn1+om2lKY
	nnAJzuEfGK/C1Q7K6kpcOuo35b5RrMVtUbBa8g3Jh0sN0lbMws1iKYNaZ6VRrWcsErqp9yoEJyq
	cqyI9MOIHpVk3dqSjIkj0Kk6+mrtc0965/DqblNeWeOk2boR49dEDBTF4ehk82jGBx4LS8AMqKL
	A1Xqy6GGD+8tgKPLVp0TIWo7TSw==
X-Received: by 2002:a05:6820:f02d:b0:67c:2d5e:e9dd with SMTP id
 006d021491bc7-680a7a68576mr2046653eaf.41.1775141432576; Thu, 02 Apr 2026
 07:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402132303.6252-1-fangyu.yu@linux.alibaba.com> <20260402132303.6252-5-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260402132303.6252-5-fangyu.yu@linux.alibaba.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 2 Apr 2026 20:20:21 +0530
X-Gm-Features: AQROBzDsAUAZSEerDJEeGwby7bjL0ghYgE-l4zOLT0yiweIOZblDgrBFsbDEbI0
Message-ID: <CAAhSdy1dXxdF0pb_r+hS+rdZ21VVxezwaZ=MCMmDD+vRCyRUdA@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] RISC-V: KVM: add KVM_CAP_RISCV_SET_HGATP_MODE
To: fangyu.yu@linux.alibaba.com
Cc: pbonzini@redhat.com, corbet@lwn.net, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	skhan@linuxfoundation.org, guoren@kernel.org, radim.krcmar@oss.qualcomm.com, 
	andrew.jones@oss.qualcomm.com, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 6:53=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrote:
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
> Reviewed-by: Guo Ren <guoren@kernel.org>
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

Introducing a new RISC-V capability looks a bit complex.
Instead of KVM_CAP_RISCV_SET_HGATP_MODE, we can
simply re-use KVM_CAP_VM_GPA_BITS.

The kvm_vm_ioctl_check_extension() for KVM_CAP_VM_GPA_BITS
return number of GPA bits which in-directly implies the underlying
hgatp.MODE. As we know, if it return 59 bits GPA then it means
Sv57x4 is the selected hgatp.MODE and Sv48x4 and Sv39x4 modes
are also supported as-per RISC-V privileged specification.

The kvm_vm_ioctl_enable_cap() for KVM_CAP_VM_GPA_BITS
will take the desired number of GPA bits and downsize the selected
hgatp.MODE. For example, if user-space ask GPA bits <=3D 50 and
GPA bits > 41 then we select Sv48x4. If user-space ask GPA
bits <=3D 41 then we select Sv39x4. If user-space ask GPA bits <=3D 59
and GPA bits > 50 then we select Sv57x4.

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

Regards,
Anup
