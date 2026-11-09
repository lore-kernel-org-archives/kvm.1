Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794243321;
	b=CAftHlE6qdAi54Br6uhFwju7RqZAl/dcdTjxZMJTg26KdtUv/tqi6F0vgF/VEEUezZGK
	 7DmazQDQpIX4Wmv1kQCZuENG1zSTD4YzOXd+RCs/22kVUruA75lmvFmOR4epAQT67Hvk4
	 s3p7FHLmR+xVVzt3McjR+AxHn1Lj8iLrheCfU0JKgg5zgHoMNf69c5NlAWy0rmMo2090M
	 NvSaaslsWfNfrz6Lke2jYa8gQOm5dc0ThJfLyqqFYvgCqeg2z5e8ceKub7I1VrN1HGJGo
	 nFUjMX4yKdmLnP/VSHTOLabKaYLOXfpmHks7C2p7ebnNNsGzLKvwM2mrXen/FpJWieg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243321;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RC0UrwDaQnc2FE/z5VGtYhnyiTOr5aGD0N9qLgTAlhw=;
	b=a4eeRAumNGrtgeUnzHLKRunB4n7NQrQY8zDv7srMTU90VEFMX0alq8wzDL65zA5s6i0L
	 ZKbogO4Ddd5a7QFoLE6L7+KcCmiKzYUe+9ZsNfMNHh1ILZwd3aGAJk/ntItQiOb1cQKyb
	 KLNDzKqv8Wxce2kZrBwYbPRqtlTh31y7jVp07sBS/BW5ZCsURA/dwIKfzMap917U1n9fc
	 kVFfrmgr4gyTkeIKqfbTOkEBUeSUar6UxcYyrU2Ar0g6ejzKNp2FI8zyF6dSDM2Xf1zcq
	 Nvv5DQf47JXB5zplisIdM9/9flrIuuWfYpr3sOwiRr9LNdVvwzKqBcKjeLNOkzF68vQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jc1FL17+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481D2606A415
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 16:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 481D2606A415
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jc1FL17+
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-535f598d126so304281cf.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 08:55:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794243320; cv=none;
        d=google.com; s=arc-20260327;
        b=AzGaiK3EoyyPpAM1Uv5DMf6z6YDsvclgpxzaeC0dHz52qLGRMQxYU1DDfrbyKjsAPr
         CObDxZAQCA2n+coB7ORqOHB6K3bXAwLIuh226dbhaVMDYGAOWF6hurT9cXiyARhHmq5S
         BjjEAwWa2UFAnQoUMkCP9A2KMd6lgMG8qAuJ8+CcFlcleBOJyTbUCq1voVhqxhiTGDjf
         R6xYOIQFXvBZkJ3PgYqKs7UQtD4znPhspcN2pxZ8gOHxc53ycZ+ss/Und6W4qc3spFuA
         lRiNIXTi0GWIuNtYEvh6H4LZQWlNCc3hiwKP5diSnvyhQEINt0I6HuCtis3gs/zof5dM
         pD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RC0UrwDaQnc2FE/z5VGtYhnyiTOr5aGD0N9qLgTAlhw=;
        fh=cQA7O6rb/BUW4YEbI34r+c4zitzAaVLR+BnccfrsyCs=;
        b=cUcRO27YYONA+Q47UbsFWiY2b3yXDA06MmECag5lytkZVkA4PPE9AdVf1SrHU2ftXu
         P7gCes6ya0MUsRW3F5QwbzEsOpMJjdBjNbxN/GnNz4yuEq2W2xnoWE2/VZYjdRRHBtKh
         3vsXnw2rqxdEYtAXLgF/FzmmARY8Oti/wChj6EG+lG8RPIQogX7V7kuVwv36mdXTkxTx
         u8yzVAmYgBY/uWlY1BwBtKdrMpycLrL7gxpF7rUAcpSSlbzvNnCRSPsuBrhkTTwrVtRt
         ADlod+xo3d3U59EJrq87cgch0rXVXmtf/XcVSMXAwqCeEpK+SIGkZRAhnknwFcS3yOFq
         o+7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794243320; x=1794848120; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RC0UrwDaQnc2FE/z5VGtYhnyiTOr5aGD0N9qLgTAlhw=;
        b=jc1FL17+Np+kc4Do8ZN8kgBCjl8M6NjXByLa4z2MmOaoTcUdZBYYV/NseTN4vrG90D
         4c6xr2vltwjgfwSMUr8mg3QiDP6uR9OtNyp7KSC4bRR8ov0xh/upRx9YmfWlGYWi3lOn
         fRJ/oAjlISRd/SpFsj9df3NbmyJSAf4ryLzvQ1W5UqO6UzUB9r7R9xoii+NccAEr/XFw
         mQUAsZAf3Ey4xkdEWIrom9vXB6uTsTdgggYwnaQU9NbD46E+Y01hJ0/UyjDeNtQWrGAn
         DqbfnkfFfFWk7osqRMpqjR2773LTkkFnFLzfqLyHiwIRCctgtxAaqy/rXkBSHDDfNrbf
         qdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243320; x=1794848120;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RC0UrwDaQnc2FE/z5VGtYhnyiTOr5aGD0N9qLgTAlhw=;
        b=DwFEcvRx2WztK0slyvmFavwZvrsMR4/FuRLh2vMozxFw+1opSo4sJL0vSRuD5SQDkf
         aPte1GcaaMoAdQ66QUYvHQixiLpDS+LeZ8EwErM3ADmr/4JaXJNCEHJIwcF9SychHKIJ
         JWwlIa46VtX6Ja8zXyLYh/cS9Vt260n+79Qj0AnfMcQkTkGrDI+Kyj5fAU27nclv5EeK
         4WaUbHiOO99qdy0QrCyjqtWRJnuQRw0nvBbQ+mD9ccXwf0jDBbwirWhSTycoFQ6lOP4d
         R/cSUEod5xt0VUZ9tPem+kQGLk4B4sciGHqFHMLB1CGfH1M2VVNAf49NM5QxGTjvOcHB
         FJRw==
X-Forwarded-Encrypted: i=1; AL+hErEP2AFnIfM6jAzXga7fJtkBk7W0BBybalL9AwIMcsuqn5pgxkiIYvAheDg5uVxRzzD4hOA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Zq9v32Pd0dW8/heT8x5B1bNKOYqxT6XySIldOphCmv/MMBzzF
	NZDqIgXuqrPYe7OJVz8yD3OaqR7+RP+9/goO8F+6/OWojN58TKGqnLbvfPHiUzhVmfNbfmdg4TQ
	cMwsRFyJ8hZGq0H6cSjhtZCaGXQffhBxVh+qXMNAq
X-Gm-Gg: AYBFou0JTYvxQBaxhDb3PKsUexPz42tXGIMqL/Sr+HVQFhS7rqCSYAlPomaXy5aZdUg
	uFEH1yoElNcWzMb6t3GZOZYEKms2FDEqq6Hw+YQIkF85jfpA9DRtrs7wgmitG/siwFn8KNrI7rf
	gqgQQ+hwoqLYyLWH7a9HAIwn1e2kPmuZiBbYLwIrdkpBM0CpLuOxe7NDZ16HyE61OHqwgSe4LI+
	GBYgdTwVII8IslXB5tWJRmkDfVVrnRjWxcLjH9+zzfzQqjCmPo2S263l0lDcV9qx+tzhVshJBx2
	6dZO+PDWA/n/nJ+nrMVvm+Jv+ZMDk9DzVVrV6r4WOC5YG/yfDlO9tiMWDJ99qDxKJv1l2Eco6jb
	Q6E0XWK4v/NXo7i4X9bC1BRwuuJpyVZU+Yz7EdFp0zhK7DRWV515GL0CgQ+lMqCpHfNgVRg==
X-Received: by 2002:a05:622a:4006:b0:546:92f2:7830 with SMTP id
 d75a77b69052e-55517fe3db9mr549891cf.6.1794243319297; Mon, 09 Nov 2026
 08:55:19 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-tdx-selftests-v16-18-2024e8fa517a@google.com> <20261106164732.3939387-1-seanjc@google.com>
In-Reply-To: <20261106164732.3939387-1-seanjc@google.com>
From: Sagi Shahar <sagis@google.com>
Date: Mon, 9 Nov 2026 10:55:07 -0600
X-Gm-Features: AclHuK_aPoWJeYsWIu0Fp7vvyMmwJfBcQK_7pGNixlXWs0_drRFcIAQ91_Pbzbc
Message-ID: <CAAhR5DEwMT+JMYegyuXR2mLJ4C=pvHo1wSbkHF+jS40U2Ag99A@mail.gmail.com>
Subject: Re: [PATCH v16.1] KVM: selftests: Add support for TDX ucalls, via TDVMCALL_REPORT_FATAL_ERROR
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lisa Wang <wyihan@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 10:47=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Add support for doing ucalls on TDX by abusing TDVMCALL_REPORT_FATAL_ERRO=
R
> to pass the address of the payload to the host.  The "fatal error" TDVMCA=
LL
> is perfectly suited for passing information to host userspace, as both th=
e
> TDX Module and KVM allow the guest to pass (almost) all registers to the
> host, i.e. provide enough of a data payload to make a collision with a re=
al
> fatal error practically impossible.
>
> TDX can't use port I/O, as the TDX ABI doesn't allow the guest to share
> arbitrary register state with the host on a port I/O exit, and the port I=
/O
> data payload is limited to 4 bytes, i.e. would potentially truncate the
> ucall address.
>
> Alternatively, TDX could use MMIO, but using a magic emulated MMIO addres=
s
> is fragile (see the TODO in __vm_create()), especially for TDX since TDX
> doesn't support read-only memslots, i.e. doesn't have line of sight towar=
ds
> addressing the TODO.  E.g. TDX could hardcode the address to something th=
at
> is all but guaranteed to be unused on x86, e.g. the I/O APIC base address
> or the HPET address, but that doesn't truly address the fragility concern=
s,
> and it's ugly because ucall_arch_init() would completely ignore the passe=
d
> in @mmio_gpa despite obviously utilizing emulated MMIO.
>
> Use a simple flag to route vCPUs/VMs to the right do_ucall() routine, and
> take care to set the flag via write_guest_global() so that ucall_arch_ini=
t()
> is thread safe (in the *extremely* unlikely scenario a single test create=
s
> both TDX and non-TDX VMs *concurrently).
>
> Alternatively, a virtual function pointer could be used to dispatch to th=
e
> correct do_ucall() via an indirect branch, but that has zero advantages
> other than making ucall_arch_do_ucall() look prettier, at the cost of bei=
ng
> slightly harder to understand and making ucall_arch_init() uglier.  KISS.
>
> Cc: Sagi Shahar <sagis@google.com>
> Cc: Lisa Wang <wyihan@google.com>
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Binbin Wu <binbin.wu@linux.intel.com>
> Cc: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  .../selftests/kvm/include/x86/tdx/tdx.h       |  7 +++
>  .../testing/selftests/kvm/include/x86/ucall.h |  6 +--
>  tools/testing/selftests/kvm/lib/x86/ucall.c   | 53 +++++++++++++++++--
>  3 files changed, 58 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/te=
sting/selftests/kvm/include/x86/tdx/tdx.h
> index d41a1efc8a63..9982aaaba885 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> @@ -4,6 +4,13 @@
>
>  #include <linux/types.h>
>
> +/* TDX hypercall Leaf IDs */
> +#define TDVMCALL_GET_TD_VM_CALL_INFO           0x10000
> +#define TDVMCALL_MAP_GPA                       0x10001
> +#define TDVMCALL_GET_QUOTE                     0x10002
> +#define TDVMCALL_REPORT_FATAL_ERROR            0x10003
> +#define TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT  0x10004
> +
>  u64 __tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15);
>
>  #endif /* SELFTEST_KVM_TDX_TDX_H */
> diff --git a/tools/testing/selftests/kvm/include/x86/ucall.h b/tools/test=
ing/selftests/kvm/include/x86/ucall.h
> index 0e4950041e3e..aca582bb2cd5 100644
> --- a/tools/testing/selftests/kvm/include/x86/ucall.h
> +++ b/tools/testing/selftests/kvm/include/x86/ucall.h
> @@ -2,12 +2,8 @@
>  #ifndef SELFTEST_KVM_UCALL_H
>  #define SELFTEST_KVM_UCALL_H
>
> -#include "kvm_util.h"
> +#include <linux/kvm.h>
>
>  #define UCALL_EXIT_REASON       KVM_EXIT_IO
>
> -static inline void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
> -{
> -}
> -
>  #endif
> diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/=
selftests/kvm/lib/x86/ucall.c
> index 38050c60a067..bb4a7215d9b1 100644
> --- a/tools/testing/selftests/kvm/lib/x86/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
> @@ -5,16 +5,40 @@
>   * Copyright (C) 2018, Red Hat, Inc.
>   */
>  #include "kvm_util.h"
> +#include "tdx/tdx.h"
> +#include "tdx/tdx_util.h"
>
> -#define UCALL_PIO_PORT ((u16)0x1000)
> +#define UCALL_PIO_PORT         ((u16)0x1000)
> +#define UCALL_TDX_MAGIC                0xabacadabaULL
>
> -void ucall_arch_do_ucall(gva_t uc)
> +static void ucall_tdx_do_ucall(gva_t uc)
> +{
> +       __tdvmcall(TDVMCALL_REPORT_FATAL_ERROR, UCALL_TDX_MAGIC, uc, 0, 0=
);
> +}
> +
> +static void *ucall_tdx_get_ucall(struct kvm_vcpu *vcpu)
> +{
> +       struct kvm_run *run =3D vcpu->run;
> +
> +       /*
> +        * KVM_SYSTEM_EVENT_TDX_FATAL stores R0..R15 in data[0..15].  R12
> +        * holds the ucall magic and R13 holds the ucall GVA.
> +        */
> +       if (run->exit_reason =3D=3D KVM_EXIT_SYSTEM_EVENT &&
> +           run->system_event.type =3D=3D KVM_SYSTEM_EVENT_TDX_FATAL &&
> +           run->system_event.data[12] =3D=3D UCALL_TDX_MAGIC)
> +               return (void *)(run->system_event.data[13]);
> +
> +       return NULL;
> +}
> +
> +static void ucall_x86_do_ucall(gva_t uc)
>  {
>         asm volatile("in %[port], %%al"
>                 : : [port] "d" (UCALL_PIO_PORT), "D" (uc) : "rax", "memor=
y");
>  }
>
> -void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
> +static void *ucall_x86_get_ucall(struct kvm_vcpu *vcpu)
>  {
>         struct kvm_run *run =3D vcpu->run;
>
> @@ -26,3 +50,26 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
>         }
>         return NULL;
>  }
> +
> +static bool ucall_is_tdx_vm;
> +
> +void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
> +{
> +       write_guest_global(vm, ucall_is_tdx_vm, is_tdx_vm(vm));
> +}
> +
> +void ucall_arch_do_ucall(gva_t uc)
> +{
> +       if (ucall_is_tdx_vm)
> +               return ucall_tdx_do_ucall(uc);
> +
> +       return ucall_x86_do_ucall(uc);
> +}
> +
> +void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
> +{
> +       if (is_tdx_vm(vcpu->vm))
> +               return ucall_tdx_get_ucall(vcpu);
> +
> +       return ucall_x86_get_ucall(vcpu);
> +}
>
> base-commit: 4aeb1c3931544fb3bb64397391c2e7153a81f824
> --
> 2.56.0.567.gdb80ae8cd5-goog
>

Reviewed-by: Sagi Shahar <sagis@google.com>
