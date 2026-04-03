Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D05C31E106
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 06:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775197171; cv=pass; b=IB6JORpxZS0H6uBB3a4dULvHcc2AYSFDNXRoqp2xbWgsAXhLyBbLDArF1D4ryK0cnx1Lt0iM4gayzi0F4Cb61AKylkNz7AmcR3nAvzes4VgPlcERKsjmkenWMSnTKTh3G2wAdCJa4pJc1/e/Z8e+tAOKu3mDJklMZ+UVcwGjIP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775197171; c=relaxed/simple;
	bh=0RM1NoS9kWGau6pWqStk9FXFw+YOh62EBXpXS8B8eCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbDNt4eBG6VWVR0VXHJZtS5jG3bpxVnA8DvYfBDYiz5R/0mvihLEPTSrYcW/1VwNsBzaLGen7P4ykeIHEnKdQGLYXoEXtaTpnTdaYLxvlZRS0rfXYSAzT3VbdhcsVxOfH/LQ7Izz+rKas4S4EeIsW7r+L9G5jS/5cq72jPVPGnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=T1drxNed; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="T1drxNed"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-506a7bbe9d0so13376391cf.0
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 23:19:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775197162; cv=none;
        d=google.com; s=arc-20240605;
        b=D9gNU3NPK7oVm7l3j/YZLqZ4KUp1EYkEakO1TGNxBct4xBMKrP7mLWi8kUuYITeLr+
         Q5qQbW7Oz7W4nkJIr0VTx95s9LW+Y/KL2i/ci6uhhbmMmxW/wxHyqSMFnuTXT5FWtkvT
         l5aX2X9wHFegnIS5Dhxaec1ynTFIgDOpgL64PUHzeP6V80UukbnUcxC5s3y3YrZKZ4zz
         Xx2KllDr6SI2dw7leEBp6p6q+EzO4UTjGKcQT9o365EbSREGDlUUDUFbP94g5EeguCmm
         Mtwbyt2zUpiskkMqDOyoDkvi6DyzIAOa+8rZZ7fLihwrLbeC78W3VMK8rdvtUwqKBHRt
         JO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kx6Vr/oJKHrL9MwhUSHyoeKfqKn3quqamoeA29dEegU=;
        fh=KEaYbkaZSAxA4Vh47eND+M3hu8/Gf7rrZGBivNFKnto=;
        b=bU7NUAR0vPDY/TNwdmOPVZm7fdvknJIextnKZbBIgGdZPg5/cWNBgd/O1I2W4vz+eA
         bdKxoD9Btna+Z+WlN1Szz93PcFRdSEFXGo2XrQS5RY3Wx1+FX4KSBwclYHO5JDsvv5Fy
         36rS7t6LlJ0CKGuDtMZf3k0J/rrrM7otYUl8X5n/sPI24pMcPkFAjwjdJ9J2wXK2gyDB
         JJKT4k/4ZdXkim7IyEJ3sF+fkbi8+ZoVjDXFHM/k61MjVDTrEOxiMWK2UT+caIl2tNJv
         JEOw37fPNxvcPPtOo3w4mgfhZ6lS/IpPg1Kh0bD2C6dftk3GlGznVLXNwCnJ0CV5MyYT
         OsmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1775197162; x=1775801962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kx6Vr/oJKHrL9MwhUSHyoeKfqKn3quqamoeA29dEegU=;
        b=T1drxNedjLOnhOtOPuc2aPcBNl/jFUU8jcpsgElXlet9fJ0j4VmAxkysh7QfTGQ/1M
         h9ru7nwTBd+zfrfK/JtuehMdkrb3zTozsCWyu8bdSRfAev99xFPj4J4jog2gP8Bs6E1h
         4eUSnpVQgs5sMLvc58siLe7NwUaOOsV9sNAYBZ3up+1W/DBCr2uSZvRaIOGsFMNDXmyU
         59i3o8KWWG/1TqPzDItxFzKvCfe3DDA9ZfeMW4iDKJhtFoWtZpOdy6hkrA0jCn8wSpVW
         zJCBnV7Vi65vFqzqf8tnGzrqrWkgYEikiQOsO6HevunWinVTqyeidTV4vpxAOp/mgrDC
         7aKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775197162; x=1775801962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kx6Vr/oJKHrL9MwhUSHyoeKfqKn3quqamoeA29dEegU=;
        b=MIJgMw0EsndjgKML8PrMhjBa/dKBi9OCSiLNSRCyoyxJp5G4wWJ/vDKwL9Oviv78BA
         q4yxq/g0j+NtQV04CCVDBDGDY0UQFzZlO0Lqv0bxtFSVbSoV/Lz2Ri5VwQXtqmpswXR5
         LzDokxckQH2B2tUnBW0J1B9woGTqkC0hsvbITI50qsZaRYhDBqi+qkhGw7Ln5dduaqqo
         HmT4UG2xbK87/6tVRISU0mxm7SuyZKZoe0LOBAajSRANL17HBTdP5C/3roj2l4RphJiE
         Q08JNZptc5DXdTG8PXCbJTSMuEWDXNAnv5kU8jNfr5lNUvQsaYr4jwHauV/dJPtTjzTG
         yUFw==
X-Forwarded-Encrypted: i=1; AJvYcCX1mOawxbXjj3Xkt3RCO0ljCwW3EXVnyoNbxH3sNyQe3eSedgarvcrw/HFQAQbdrP2KOPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTODhgwIiXqM/zEN4rgO2J6JL0CgQ0iGcpwKPQESQakdatzzN5
	OFMRXAL7dOfCLezUXf44c8BJhYjORWNaPOmiimFHZZ3iWfMck2uGJk2X5CGC7HYUh7/IZq/5YBL
	i8SfU7jI5Z0xpQHPmIC2E8WpdiZWsMwtPOaSh6rsV/w==
X-Gm-Gg: ATEYQzz3o2S9DmUA7X3ul4zB6F+af/cBcj2H8nvBFO+buwzKZvhEDN2SwxwIbGJc1qu
	p/347mlDpOCQdmL6+49U/QH/Q8khT05eNLWEdHCnQwGS6Gj0B/IcAgCnrdY4kELx/BM1elJi5we
	gidgiYadvmdY5HMbRzLodrq5bkluVUxgvUrlI/xKaZiSjko7JWXZTjQu9OTdfuBuT0HH0FwzaZk
	EqemOfO3WaDK8kf4wkqXhIYDvPKPgsERZrO6WCJi1P1mIGc7a44tYloqCvMF9ZVny0eogVzOYSD
	bo6MtfJtIPjzoe0BAw94KQGVeApwtRvNS/8RBKQZxvSxD1bVynAc9zUxy2Sx4/d5kl2tvAY5HGB
	xadQScNwR5zfwOLE4ntZ9yRltmHKh2NQH9WvM
X-Received: by 2002:a05:622a:a50e:b0:50b:4e72:aa9 with SMTP id
 d75a77b69052e-50d6262d1c3mr24848491cf.9.1775197161880; Thu, 02 Apr 2026
 23:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403013137.32604-1-fangyu.yu@linux.alibaba.com> <20260403020249.36676-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260403020249.36676-1-fangyu.yu@linux.alibaba.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 3 Apr 2026 11:49:09 +0530
X-Gm-Features: AQROBzB9uVaLIXyFCjKCGQ2JYilonAcViQ8zVbduiOvK0F0aOryvQlhRofsaDPE
Message-ID: <CAAhSdy2CibJNXJYxCvyofXC3CUpCT5KdricNt2aViRSYCOWrrA@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v7 4/4] RISC-V: KVM: add KVM_CAP_RISCV_SET_HGATP_MODE
To: fangyu.yu@linux.alibaba.com
Cc: alex@ghiti.fr, andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu, 
	atish.patra@linux.dev, corbet@lwn.net, guoren@kernel.org, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	palmer@dabbelt.com, pbonzini@redhat.com, pjw@kernel.org, 
	radim.krcmar@oss.qualcomm.com, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 7:32=E2=80=AFAM <fangyu.yu@linux.alibaba.com> wrote:
>
> >>On Thu, Apr 2, 2026 at 6:53=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wr=
ote:
> >>>
> >>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> >>>
> >>> Add a VM capability that allows userspace to select the G-stage page =
table
> >>> format by setting HGATP.MODE on a per-VM basis.
> >>>
> >>> Userspace enables the capability via KVM_ENABLE_CAP, passing the requ=
ested
> >>> HGATP.MODE in args[0]. The request is rejected with -EINVAL if the mo=
de is
> >>> not supported by the host, and with -EBUSY if the VM has already been
> >>> committed (e.g. vCPUs have been created or any memslot is populated).
> >>>
> >>> KVM_CHECK_EXTENSION(KVM_CAP_RISCV_SET_HGATP_MODE) returns a bitmask o=
f the
> >>> HGATP.MODE formats supported by the host.
> >>>
> >>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> >>> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> >>> Reviewed-by: Guo Ren <guoren@kernel.org>
> >>> ---
> >>>  Documentation/virt/kvm/api.rst | 27 +++++++++++++++++++++++++++
> >>>  arch/riscv/kvm/vm.c            | 18 ++++++++++++++++--
> >>>  include/uapi/linux/kvm.h       |  1 +
> >>>  3 files changed, 44 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/=
api.rst
> >>> index 032516783e96..9d7f6958fa81 100644
> >>> --- a/Documentation/virt/kvm/api.rst
> >>> +++ b/Documentation/virt/kvm/api.rst
> >>> @@ -8902,6 +8902,33 @@ helpful if user space wants to emulate instruc=
tions which are not
> >>>  This capability can be enabled dynamically even if VCPUs were alread=
y
> >>>  created and are running.
> >>>
> >>> +7.47 KVM_CAP_RISCV_SET_HGATP_MODE
> >>> +---------------------------------
> >>> +
> >>> +:Architectures: riscv
> >>> +:Type: VM
> >>> +:Parameters: args[0] contains the requested HGATP mode
> >>> +:Returns:
> >>> +  - 0 on success.
> >>> +  - -EINVAL if args[0] is outside the range of HGATP modes supported=
 by the
> >>> +    hardware.
> >>> +  - -EBUSY if vCPUs have already been created for the VM, if the VM =
has any
> >>> +    non-empty memslots.
> >>> +
> >>> +This capability allows userspace to explicitly select the HGATP mode=
 for
> >>> +the VM. The selected mode must be supported by both KVM and hardware=
. This
> >>> +capability must be enabled before creating any vCPUs or memslots.
> >>> +
> >>> +If this capability is not enabled, KVM will select the default HGATP=
 mode
> >>> +automatically. The default is the highest HGATP.MODE value supported=
 by
> >>> +hardware.
> >>> +
> >>> +``KVM_CHECK_EXTENSION(KVM_CAP_RISCV_SET_HGATP_MODE)`` returns a bitm=
ask of
> >>> +HGATP.MODE values supported by the host. A return value of 0 indicat=
es that
> >>> +the capability is not supported. Supported-mode bitmask use HGATP.MO=
DE
> >>> +encodings as defined by the RISC-V privileged specification, such as=
 Sv39x4
> >>> +corresponds to HGATP.MODE=3D8, so userspace should test bitmask & BI=
T(8).
> >>> +
> >>>  8. Other capabilities.
> >>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>
> >>> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> >>> index 4d82a886102c..5e82a3ad3ad0 100644
> >>> --- a/arch/riscv/kvm/vm.c
> >>> +++ b/arch/riscv/kvm/vm.c
> >>> @@ -201,6 +201,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm,=
 long ext)
> >>>         case KVM_CAP_VM_GPA_BITS:
> >>>                 r =3D kvm_riscv_gstage_gpa_bits(kvm->arch.pgd_levels)=
;
> >>>                 break;
> >>> +       case KVM_CAP_RISCV_SET_HGATP_MODE:
> >>> +               r =3D kvm_riscv_get_hgatp_mode_mask();
> >>> +               break;
> >>
> >>Introducing a new RISC-V capability looks a bit complex.
> >>Instead of KVM_CAP_RISCV_SET_HGATP_MODE, we can
> >>simply re-use KVM_CAP_VM_GPA_BITS.
> >>
> >>The kvm_vm_ioctl_check_extension() for KVM_CAP_VM_GPA_BITS
> >>return number of GPA bits which in-directly implies the underlying
> >>hgatp.MODE. As we know, if it return 59 bits GPA then it means
> >>Sv57x4 is the selected hgatp.MODE and Sv48x4 and Sv39x4 modes
> >>are also supported as-per RISC-V privileged specification.
> >>
> >>The kvm_vm_ioctl_enable_cap() for KVM_CAP_VM_GPA_BITS
> >>will take the desired number of GPA bits and downsize the selected
> >>hgatp.MODE. For example, if user-space ask GPA bits <=3D 50 and
> >>GPA bits > 41 then we select Sv48x4. If user-space ask GPA
> >>bits <=3D 41 then we select Sv39x4. If user-space ask GPA bits <=3D 59
> >>and GPA bits > 50 then we select Sv57x4.
> >>
> >
> >Thanks, that makes sense.
> >
> >In v8 I=E2=80=99ll drop KVM_CAP_RISCV_SET_HGATP_MODE and re-use KVM_CAP_=
VM_GPA_BITS
> >for both discovery and selection.
> >
>
> Hi Anup,
>
> While working on the respin reusing KVM_CAP_VM_GPA_BITS, I realized
> a potential ambiguity in CHECK_EXTENSION semantics and wanted to confirm =
the
> intended ABI before posting v8.
>
> One concern about the semantics: today KVM_CHECK_EXTENSION(KVM_CAP_VM_GPA=
_BITS)
> on a VM fd may be interpreted as =E2=80=9Cthe GPA bits for this VM=E2=80=
=9D (or at least what
> this VM can use). If we also use KVM_ENABLE_CAP(KVM_CAP_VM_GPA_BITS) to d=
ownsize
> the selected HGATP.MODE for a particular VM (e.g. to Sv48x4 =3D> 50 bits)=
, then a
> subsequent CHECK_EXTENSION(KVM_CAP_VM_GPA_BITS) on the same VM fd would r=
eturn 50.
> Userspace might then assume 50 is the maximum supported by that VM/host a=
nd lose
> the information that the host actually supports 59 (Sv57x4).

I think there is no violation of the semantics because we are providing
a way to allow KVM user space change "the GPA bits for this VM=E2=80=9D
using KVM_ENABLE_CAP(KVM_CAP_VM_GPA_BITS) so subsequent
CHECK_EXTENSION(KVM_CAP_VM_GPA_BITS) must return
effective number of GPA bits visible to the VM.

The only additional constraint I would enforce is that the
KVM_ENABLE_CAP(KVM_CAP_VM_GPA_BITS) must
return -EBUSY if any of the Guest VCPUs have
ran_atleast_once set.

Regards,
Anup

>
> Thanks,
> Fangyu
>
> >Thanks,
> >Fangyu
> >
> >>>         default:
> >>>                 r =3D 0;
> >>>                 break;
> >>> @@ -211,12 +214,23 @@ int kvm_vm_ioctl_check_extension(struct kvm *kv=
m, long ext)
> >>>
> >>>  int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *=
cap)
> >>>  {
> >>> +       if (cap->flags)
> >>> +               return -EINVAL;
> >>> +
> >>>         switch (cap->cap) {
> >>>         case KVM_CAP_RISCV_MP_STATE_RESET:
> >>> -               if (cap->flags)
> >>> -                       return -EINVAL;
> >>>                 kvm->arch.mp_state_reset =3D true;
> >>>                 return 0;
> >>> +       case KVM_CAP_RISCV_SET_HGATP_MODE:
> >>> +               if (!kvm_riscv_hgatp_mode_is_valid(cap->args[0]))
> >>> +                       return -EINVAL;
> >>> +
> >>> +               if (kvm->created_vcpus || !kvm_are_all_memslots_empty=
(kvm))
> >>> +                       return -EBUSY;
> >>> +#ifdef CONFIG_64BIT
> >>> +               kvm->arch.pgd_levels =3D 3 + cap->args[0] - HGATP_MOD=
E_SV39X4;
> >>> +#endif
> >>> +               return 0;
> >>>         default:
> >>>                 return -EINVAL;
> >>>         }
> >>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> >>> index 80364d4dbebb..a74a80fd4046 100644
> >>> --- a/include/uapi/linux/kvm.h
> >>> +++ b/include/uapi/linux/kvm.h
> >>> @@ -989,6 +989,7 @@ struct kvm_enable_cap {
> >>>  #define KVM_CAP_ARM_SEA_TO_USER 245
> >>>  #define KVM_CAP_S390_USER_OPEREXEC 246
> >>>  #define KVM_CAP_S390_KEYOP 247
> >>> +#define KVM_CAP_RISCV_SET_HGATP_MODE 248
> >>>
> >>>  struct kvm_irq_routing_irqchip {
> >>>         __u32 irqchip;
> >>> --
> >>> 2.50.1
> >>>
> >>
> >>Regards,
> >>Anup
