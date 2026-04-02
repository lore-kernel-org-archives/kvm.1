Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5225081AA8
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 00:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775090790; cv=pass; b=GGsFaRS5YaumhMPMc2yeDLOy1+Ph4/TuDYXAA58bfC7QD1fOT3b4kiJqQCSwMJotU7hFjMNdNl6eDJq+sVHwfUItlsYGwC/5w8rDvHx9oKaET9Ry0UA2tzOF5v347g/I/2Rp+aml4yNkkpugun12re+TMtQAdIgrWKrldVRRQMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775090790; c=relaxed/simple;
	bh=xzw9WARjpaBEucXktpzGnYAuBVe9j/GbarNL4vaVkUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LH6F17t75U/H7i8VqOag9gVFhnnphltCn+pIukvALewum68dgdKQiTvYnkNelzhKl7rAa/Lec5FnI+IIt2X6y/HwuIKaHgUPmfXYb1kcKgtiWrZ6dKhIb4lXEDDh7mEPkQoXy/hE4nZW3CmqtDY5k/1zMuUTMnvdO8BNyrYa6G0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDEkpiFd; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDEkpiFd"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so37018366b.1
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 17:46:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775090787; cv=none;
        d=google.com; s=arc-20240605;
        b=N0zK5Xf+0GlVBLkdWBlnzQETbmK/Yn7AEtHo4n21i5UTPYvdFl7YOGohQOWZ7yO0Mx
         hbMmsFF8oI6If/5mdhFkVv6NfnAj14VymTYOff6JB9YHRXu/5L/BRDjYDtGtVBjc//oI
         3KdyEZH4w+pM9/3/DKRPNAIKJyow78blQ5kom+nVRx/AKVEAmGe/zVw2lGWIUeSE3wNj
         0ohhEaEeXGJgWzRyX7bMIRBfjnSfQs/L6oqcJSRBaGGWldMdZC6fRDu74CO3jti0aG47
         1kdrO9GJjkfHP45oXgQcPR94D0nveOxjzvqmCE239a4u3QrNS00gRMlu8YvPrrvOy1AR
         2Dag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w7ZjIP4wxwkHbCGk+xqfZg9Y+KuPrsg39riRIKt2IvY=;
        fh=tHY4ssVBMoUqBXnAp9lukBWQed3rjxEWBYtEeHnNjXU=;
        b=JL6VfHE4MtglIsubzxpn9WRrqT0Wh/j/87SFm+kGWqAwToyenniPfj4dOvWrPdr7QI
         27PsQgzgRuwx1uWfxEBoRfh2L4Ski5xd6xbpIWIDtMg0yF7vWDxvmMGyEsRgkzQwrAx3
         lxGngv0JDXtXFXsq6QUb3p7/4bo/OA7Wb1pQ7EMK/nkE8l1mM/K5W9+4Zolc2bspujXP
         O+qF7wVxh0ruqOjMoyi/FAE2jD4/jYbsI2MZugalDoPzzZnLRIaZVIAmXnvfD+K60Eob
         W/l4ZNf3P8oqMkQD2FUthvNkdkNVVu1y8YhuGd/Zj9vGgu23Vg6FBmYgy+igT+yl6Z03
         3z2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775090787; x=1775695587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7ZjIP4wxwkHbCGk+xqfZg9Y+KuPrsg39riRIKt2IvY=;
        b=hDEkpiFd86Lv5D/t3U35DiOpYSjZ7ZJNFKsc2DaNxZROPWCgNqU5tdh2bwdtxF4HiK
         QH5TEhrzYqPCf11zVMRbcsSBOZRB5lnkLM4EwczkKcH4uh6rWRpBJtSQwVEd46PxntBd
         DNWBeYdF2OjUvXko0cyWtCXK0eljJI0AOJMSMhkuerje7HxhWmcGqYDWdFdWGJ8TDpr6
         zWW2AGv1RUfOpgZlJQaKdeutryH4GYGAbLtjGcJuzdUvBSThe2fTXr7F5Vmzy3hUocNY
         I8zUU7GgOPawMXTrHu7LjVek6NyRzPyeiyrl3SbuNCDTOgo4MxW3expkESKYdvpnFvFc
         YxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775090787; x=1775695587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w7ZjIP4wxwkHbCGk+xqfZg9Y+KuPrsg39riRIKt2IvY=;
        b=Qc1JFsq68/Ciz/IfM6/I5qp1Qotxwl//cPwm56UCt+cOxeBobjOE/+AAlRHPyQCa+J
         TDYy+RcW8lXs6Jq7zP3RfCoDGiVUS62iu3v3bP0k6gx2pY/szGwbBciOdJ6gu3FCUqDH
         ZuVbfDlekc/V0isxazLE8P4+7TUQygSAWFR/avZRy9QQPDavazfkpTb96+lqJOWX0bGR
         tYVEBBbnx3cX/fXb2Jgh/35R3aWzefMJZwdVEvu7UHiRKZSnEfRWGErVt43o8L/HAPgR
         H/F6yYSVx5j08Ryl5ou+psuesiCxy8nxdwvOcYiWbNtkBKGiEohAlsdIsYzQoCxaNYxp
         IDvA==
X-Forwarded-Encrypted: i=1; AJvYcCUB5oVSBR46jYExoZCo3IG6O7/zoEKEeO8XlKAWadx7lBQJSf1Emdj4PxjAcjm+wdgWM2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcSfJYSI40TKC45pQzas0xTRzqRg2HGfOi33qJd+j3FqzmNbLH
	SZ2sY5PPO4PlI+zI6Hmwut5WOLSIbadJE+wkwr5NIe5jqXpn02GKW5/5sXQa0M7cXX4KnP5RUwC
	8k1uZg0dDja8bR1V8phe0kmFp0kSa/hE=
X-Gm-Gg: ATEYQzz5japIwyEmOPr1sKCkg99K0b2Z+tfwLfm6OigKzQQeHeVl02LJbA/6cr90ohT
	69ycKnXBB9PHRgpD/Cmfiuhiof41/QKrJyPLRNQABVCACYslIEItBNffyWfhcEEUCw1zZJW2/ta
	Rzy9kKKUwRYVTq7o4HmmCf/XZmgKp4H15ZRgh/fzXi8D6O8LhuHfhQFcvGXz44rrHQyCVKGAMfk
	CDYdbLMn6pmj5HD1GAgsAc0g1YXYU2XmuFyujeeIzsg5FQsE5FlOJQDx/4R2SN6fMjy2wgCFQe+
	WOW9VX5SBS4GFD28hyLbt6uhjQgYVr+OSxI/Pw==
X-Received: by 2002:a17:907:a604:b0:b93:6ae4:aa83 with SMTP id
 a640c23a62f3a-b9c138e7d94mr384586866b.18.1775090786132; Wed, 01 Apr 2026
 17:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401201753.92290-1-philmd@linaro.org> <20260401201753.92290-3-philmd@linaro.org>
In-Reply-To: <20260401201753.92290-3-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Apr 2026 10:45:59 +1000
X-Gm-Features: AQROBzCwwUU-hZsY0U89IfFUHeLh_to88ntKSLA14V2dIF2bIKjclWYrKDf2AmQ
Message-ID: <CAKmqyKM5vdETfiQB6Ls+s4MbudKJjAR9b7t7VUszdS0e6kE0YA@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 2/8] accel/kvm: Remove TARGET_KVM_HAVE_GUEST_DEBUG
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>, 
	Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
	Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org, 
	Peter Maydell <peter.maydell@linaro.org>, Huacai Chen <chenhuacai@kernel.org>, qemu-riscv@nongnu.org, 
	Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>, Anton Johansson <anjo@rev.ng>, 
	Song Gao <gaosong@loongson.cn>, Weiwei Li <liwei1518@gmail.com>, 
	Aleksandar Rikalo <arikalo@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
	Chao Liu <chao.liu.zevorn@gmail.com>, Bibo Mao <maobibo@loongson.cn>, qemu-arm@nongnu.org, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Mohamed Mediouni <mohamed@unpredictable.fr>, 
	Zhao Liu <zhao1.liu@intel.com>, Aurelien Jarno <aurelien@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 6:18=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> All targets except MIPS have TARGET_KVM_HAVE_GUEST_DEBUG=3Dy.
> Declare the kvm_update_guest_debug() stub to MIPS and have
> TARGET_KVM_HAVE_GUEST_DEBUG be the default.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  configs/targets/aarch64-softmmu.mak     |  1 -
>  configs/targets/i386-softmmu.mak        |  1 -
>  configs/targets/loongarch64-softmmu.mak |  1 -
>  configs/targets/ppc-softmmu.mak         |  1 -
>  configs/targets/ppc64-softmmu.mak       |  1 -
>  configs/targets/riscv64-softmmu.mak     |  1 -
>  configs/targets/s390x-softmmu.mak       |  1 -
>  configs/targets/x86_64-softmmu.mak      |  1 -
>  include/system/kvm.h                    |  7 -------
>  include/system/kvm_int.h                |  2 --
>  accel/kvm/kvm-accel-ops.c               |  4 ----
>  accel/kvm/kvm-all.c                     | 13 ++-----------
>  target/mips/kvm.c                       |  5 +++++
>  13 files changed, 7 insertions(+), 32 deletions(-)
>
> diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch6=
4-softmmu.mak
> index d34aead41c4..6f60ca6505c 100644
> --- a/configs/targets/aarch64-softmmu.mak
> +++ b/configs/targets/aarch64-softmmu.mak
> @@ -1,6 +1,5 @@
>  TARGET_ARCH=3Daarch64
>  TARGET_BASE_ARCH=3Darm
> -TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>  TARGET_XML_FILES=3D aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vf=
p.xml arm-vfp3.xml arm-vfp-sysregs.xml arm-neon.xml arm-m-profile.xml arm-m=
-profile-mve.xml aarch64-pauth.xml aarch64-sme2.xml
>  # needed by boot.c
>  TARGET_NEED_FDT=3Dy
> diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-soft=
mmu.mak
> index 38a8f85201f..2eef68dc55e 100644
> --- a/configs/targets/i386-softmmu.mak
> +++ b/configs/targets/i386-softmmu.mak
> @@ -1,5 +1,4 @@
>  TARGET_ARCH=3Di386
> -TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>  TARGET_KVM_HAVE_RESET_PARKED_VCPU=3Dy
>  TARGET_XML_FILES=3D i386-32bit.xml
>  TARGET_LONG_BITS=3D32
> diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/lo=
ongarch64-softmmu.mak
> index 476407f9413..7e0b1ab5d05 100644
> --- a/configs/targets/loongarch64-softmmu.mak
> +++ b/configs/targets/loongarch64-softmmu.mak
> @@ -1,6 +1,5 @@
>  TARGET_ARCH=3Dloongarch64
>  TARGET_BASE_ARCH=3Dloongarch
> -TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>  TARGET_XML_FILES=3D loongarch-base32.xml loongarch-base64.xml loongarch-=
fpu.xml loongarch-lsx.xml loongarch-lasx.xml
>  # all boards require libfdt
>  TARGET_NEED_FDT=3Dy
> diff --git a/configs/targets/ppc-softmmu.mak b/configs/targets/ppc-softmm=
u.mak
> index 867898bd47c..c47887f8992 100644
> --- a/configs/targets/ppc-softmmu.mak
> +++ b/configs/targets/ppc-softmmu.mak
> @@ -1,5 +1,4 @@
>  TARGET_ARCH=3Dppc
>  TARGET_BIG_ENDIAN=3Dy
> -TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>  TARGET_XML_FILES=3D power-core.xml power-fpu.xml power-altivec.xml power=
-spe.xml
>  TARGET_LONG_BITS=3D32
> diff --git a/configs/targets/ppc64-softmmu.mak b/configs/targets/ppc64-so=
ftmmu.mak
> index 10d7a2681e7..8c6dc84b821 100644
> --- a/configs/targets/ppc64-softmmu.mak
> +++ b/configs/targets/ppc64-softmmu.mak
> @@ -1,7 +1,6 @@
>  TARGET_ARCH=3Dppc64
>  TARGET_BASE_ARCH=3Dppc
>  TARGET_BIG_ENDIAN=3Dy
> -TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>  TARGET_XML_FILES=3D power64-core.xml power-fpu.xml power-altivec.xml pow=
er-spe.xml power-vsx.xml
>  # all boards require libfdt
>  TARGET_NEED_FDT=3Dy
> diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv6=
4-softmmu.mak
> index 5059c550480..e0d2c7032d6 100644
> --- a/configs/targets/riscv64-softmmu.mak
> +++ b/configs/targets/riscv64-softmmu.mak
> @@ -1,6 +1,5 @@
>  TARGET_ARCH=3Driscv64
>  TARGET_BASE_ARCH=3Driscv
> -TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>  TARGET_XML_FILES=3D riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-=
fpu.xml riscv-64bit-virtual.xml riscv-32bit-cpu.xml riscv-32bit-virtual.xml
>  # needed by boot.c
>  TARGET_NEED_FDT=3Dy
> diff --git a/configs/targets/s390x-softmmu.mak b/configs/targets/s390x-so=
ftmmu.mak
> index e273075f1a9..699e5ced96f 100644
> --- a/configs/targets/s390x-softmmu.mak
> +++ b/configs/targets/s390x-softmmu.mak
> @@ -1,6 +1,5 @@
>  TARGET_ARCH=3Ds390x
>  TARGET_BIG_ENDIAN=3Dy
> -TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>  TARGET_XML_FILES=3D s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.x=
ml s390-cr.xml s390-virt.xml s390-virt-kvm.xml s390-gs.xml
>  TARGET_LONG_BITS=3D64
>  TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-=
softmmu.mak
> index c7f8746b4f5..491173df466 100644
> --- a/configs/targets/x86_64-softmmu.mak
> +++ b/configs/targets/x86_64-softmmu.mak
> @@ -1,6 +1,5 @@
>  TARGET_ARCH=3Dx86_64
>  TARGET_BASE_ARCH=3Di386
> -TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>  TARGET_KVM_HAVE_RESET_PARKED_VCPU=3Dy
>  TARGET_XML_FILES=3D i386-64bit.xml i386-64bit-apx.xml
>  TARGET_LONG_BITS=3D64
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index 12f7fc8fb58..a2463a3ac3f 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -236,14 +236,7 @@ void kvm_irqchip_change_notify(void);
>   * calling down to kvm_arch_update_guest_debug after the generic
>   * fields have been set.
>   */
> -#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>  int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap);
> -#else
> -static inline int kvm_update_guest_debug(CPUState *cpu, unsigned long re=
inject_trap)
> -{
> -    return -EINVAL;
> -}
> -#endif
>
>  /* internal API */
>
> diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
> index 0876aac938d..9d1d3fd3deb 100644
> --- a/include/system/kvm_int.h
> +++ b/include/system/kvm_int.h
> @@ -113,9 +113,7 @@ struct KVMState
>      struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
>      bool coalesced_flush_in_progress;
>      int vcpu_events;
> -#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>      QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
> -#endif
>      int max_nested_state_len;
>      int kvm_shadow_mem;
>      bool kernel_irqchip_allowed;
> diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
> index 6d9140e549f..d4af6b416c3 100644
> --- a/accel/kvm/kvm-accel-ops.c
> +++ b/accel/kvm/kvm-accel-ops.c
> @@ -85,12 +85,10 @@ static bool kvm_cpus_are_resettable(void)
>      return !kvm_enabled() || !kvm_state->guest_state_protected;
>  }
>
> -#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>  static int kvm_update_guest_debug_ops(CPUState *cpu)
>  {
>      return kvm_update_guest_debug(cpu, 0);
>  }
> -#endif
>
>  static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
>  {
> @@ -105,13 +103,11 @@ static void kvm_accel_ops_class_init(ObjectClass *o=
c, const void *data)
>      ops->synchronize_pre_loadvm =3D kvm_cpu_synchronize_pre_loadvm;
>      ops->handle_interrupt =3D generic_handle_interrupt;
>
> -#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>      ops->update_guest_debug =3D kvm_update_guest_debug_ops;
>      ops->supports_guest_debug =3D kvm_supports_guest_debug;
>      ops->insert_breakpoint =3D kvm_insert_breakpoint;
>      ops->remove_breakpoint =3D kvm_remove_breakpoint;
>      ops->remove_all_breakpoints =3D kvm_remove_all_breakpoints;
> -#endif
>  }
>
>  static const TypeInfo kvm_accel_ops_type =3D {
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 774499d34f8..9a46a61b7f5 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2919,9 +2919,7 @@ static int kvm_init(AccelState *as, MachineState *m=
s)
>      s->sigmask_len =3D 8;
>      accel_blocker_init();
>
> -#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>      QTAILQ_INIT(&s->kvm_sw_breakpoints);
> -#endif
>      QLIST_INIT(&s->kvm_parked_vcpus);
>      s->fd =3D qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
>      if (s->fd =3D=3D -1) {
> @@ -3032,23 +3030,19 @@ static int kvm_init(AccelState *as, MachineState =
*ms)
>      kvm_vm_attributes_allowed =3D
>          (kvm_check_extension(s, KVM_CAP_VM_ATTRIBUTES) > 0);
>
> -#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>      kvm_has_guest_debug =3D
>          (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
> -#endif
>
>      kvm_sstep_flags =3D 0;
>      if (kvm_has_guest_debug) {
> -        kvm_sstep_flags =3D SSTEP_ENABLE;
> -
> -#if defined TARGET_KVM_HAVE_GUEST_DEBUG
>          int guest_debug_flags =3D
>              kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG2);
>
> +        kvm_sstep_flags =3D SSTEP_ENABLE;
> +
>          if (guest_debug_flags & KVM_GUESTDBG_BLOCKIRQ) {
>              kvm_sstep_flags |=3D SSTEP_NOIRQ;
>          }
> -#endif
>      }
>
>      kvm_state =3D s;
> @@ -3781,7 +3775,6 @@ bool kvm_arm_supports_user_irq(void)
>      return kvm_check_extension(kvm_state, KVM_CAP_ARM_USER_IRQ);
>  }
>
> -#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>  struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu, vaddr pc=
)
>  {
>      struct kvm_sw_breakpoint *bp;
> @@ -3941,8 +3934,6 @@ void kvm_remove_all_breakpoints(CPUState *cpu)
>      }
>  }
>
> -#endif /* !TARGET_KVM_HAVE_GUEST_DEBUG */
> -
>  static int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset)
>  {
>      KVMState *s =3D kvm_state;
> diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> index a85e162409c..49bff68b137 100644
> --- a/target/mips/kvm.c
> +++ b/target/mips/kvm.c
> @@ -1262,6 +1262,11 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
>      abort();
>  }
>
> +int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
> +{
> +    return -EINVAL;
> +}
> +
>  int kvm_arch_get_default_type(MachineState *machine)
>  {
>  #if defined(KVM_CAP_MIPS_VZ)
> --
> 2.53.0
>
>
