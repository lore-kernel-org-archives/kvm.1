Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7217A3EE1DB
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994430; cv=none; b=VK02R69mHv1mSsLm10lYjNNKxLCeRXUg5e6j29ZP/F95SXMcpQWilY1xuh9Q3zw5tAfkfT9gYTnRa5wNeOIHDuIeOaAco4tuASqqdgCT6nwh6LIZmnhrlIImno2wfx/02MmUIWmp6CPcNNqfNCjwbOsER7BCGmUYshHc/7Kmuwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994430; c=relaxed/simple;
	bh=mGx9VaD8afIyX1ECvO/M16OEgtnR/1mrMF6nmnDUMZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBHDgBbr4HkSGGY1I191MmumKd4fUEjt73p41wbDbtCm75O+EBFeJQxaNzNRxPmP97BoFs6OAIIIAMTgYdGvBkG9x2M95vHXgr6a/mZMnwHrJPv3EGyCNkXGfbaRWa06gVJA+yf/TlGC/ZVyeGXmwYyvDPrd+kwrNEBQ9WuAtMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eflku0SF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eflku0SF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382A61F00899
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 08:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780994429;
	bh=mNReZRsJZUNy13WJ7kOv/YFvHk/F6L0CB8U7FfkyJZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eflku0SFzpNNitfyLQ2iUHkvFl6s/2sTMUdJJ5KS0We7pg+yaoIkWfRWwV6iNsYK2
	 H/WLgz0JsG2gpMeyceHNPnw2InHforUEWd+9eHjB437KG7NOlMVm7ZlGlqb/5S3ju8
	 g/pCIWJyINnW6+ZCJrZBJtbjH9wdVzXPtSAKWjuHZst2wBS5APXcbJPbChwQHSXu/o
	 Ev/DFydsv97X02WHhZ6dpXrxePFov/0k+NaFIFH31+EWg8cBjyIf84Yzpcms6P32lA
	 Z8+MjZqfROlOVlwJ3LyNTKPc0BjgzcddGM+bxqO7aAPbGpetIXwMEdn1oXES0Qr+93
	 nSlRB5Ct0eNXQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68c19f1f3ceso8233958a12.2
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 01:40:29 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz8s67SwTQtWHS3rHlPjr2FhTh2Bt/FlKWxxnYnQD8Hp9QjEFMX
	fJ0sy1fwHdHEQJUwanSJQj/XgmmwlSsUt/vKG9rjTPumdYlOOYGhhothhjD6ZF2oBCwjQcscmUT
	Bem7BYF4sqXWMVTPFxTH5+wgam5zy3EY=
X-Received: by 2002:a05:6402:35cd:b0:68d:651f:ccf6 with SMTP id
 4fb4d7f45d1cf-68fa4c06618mr8739246a12.4.1780994427655; Tue, 09 Jun 2026
 01:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609072715.1005923-1-maobibo@loongson.cn> <20260609072715.1005923-3-maobibo@loongson.cn>
In-Reply-To: <20260609072715.1005923-3-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 9 Jun 2026 16:40:48 +0800
X-Gmail-Original-Message-ID: <CAAhV-H64=C8iBRHrE=0rohnGxK1WeWUoG9zWrH9MB1kaw6usww@mail.gmail.com>
X-Gm-Features: AVVi8CciuXG_2FA7TZUnl2LpbyGEL8fdPgVBIcRUtTBWBmT_kod4H8h70RAVmdA
Message-ID: <CAAhV-H64=C8iBRHrE=0rohnGxK1WeWUoG9zWrH9MB1kaw6usww@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] KVM: LoongArch: selftests: Add FPU test case
To: Bibo Mao <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Tue, Jun 9, 2026 at 3:27=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
> Add FPU test case and verify FPU register get and set APIs, the
> FPU width supports 64/128/256 bits.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../kvm/include/loongarch/processor.h         |   8 +
>  .../selftests/kvm/loongarch/fpu_test.c        | 145 ++++++++++++++++++
>  3 files changed, 154 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/loongarch/fpu_test.c
>
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/sel=
ftests/kvm/Makefile.kvm
> index 9118a5a51b89..7d11592b3759 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -224,6 +224,7 @@ TEST_GEN_PROGS_riscv +=3D rseq_test
>  TEST_GEN_PROGS_riscv +=3D steal_time
>
>  TEST_GEN_PROGS_loongarch =3D loongarch/pmu_test
> +TEST_GEN_PROGS_loongarch +=3D loongarch/fpu_test
>  TEST_GEN_PROGS_loongarch +=3D arch_timer
>  TEST_GEN_PROGS_loongarch +=3D coalesced_io_test
>  TEST_GEN_PROGS_loongarch +=3D demand_paging_test
> diff --git a/tools/testing/selftests/kvm/include/loongarch/processor.h b/=
tools/testing/selftests/kvm/include/loongarch/processor.h
> index 2324e311180f..981ae7078354 100644
> --- a/tools/testing/selftests/kvm/include/loongarch/processor.h
> +++ b/tools/testing/selftests/kvm/include/loongarch/processor.h
> @@ -82,6 +82,14 @@
>  #define  PLV_MASK                      0x3
>  #define LOONGARCH_CSR_PRMD             0x1
>  #define LOONGARCH_CSR_EUEN             0x2
> +#define  CSR_EUEN_LBTEN_SHIFT          3
> +#define  CSR_EUEN_LBTEN                        BIT_ULL(CSR_EUEN_LBTEN_SH=
IFT)
> +#define  CSR_EUEN_LASXEN_SHIFT         2
> +#define  CSR_EUEN_LASXEN               BIT_ULL(CSR_EUEN_LASXEN_SHIFT)
> +#define  CSR_EUEN_LSXEN_SHIFT          1
> +#define  CSR_EUEN_LSXEN                        BIT_ULL(CSR_EUEN_LSXEN_SH=
IFT)
> +#define  CSR_EUEN_FPEN_SHIFT           0
> +#define  CSR_EUEN_FPEN                 BIT_ULL(CSR_EUEN_FPEN_SHIFT)
>  #define LOONGARCH_CSR_ECFG             0x4
>  #define  ECFGB_PMU                     10
>  #define  ECFGF_PMU                     (BIT_ULL(ECFGB_PMU))
> diff --git a/tools/testing/selftests/kvm/loongarch/fpu_test.c b/tools/tes=
ting/selftests/kvm/loongarch/fpu_test.c
> new file mode 100644
> index 000000000000..5bccce9db5d0
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/loongarch/fpu_test.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "loongarch/processor.h"
> +
> +struct kvm_fpureg __aligned(64) vector =3D {{1, 2, 3, 4 }};
> +
> +static void guest_code(void)
> +{
> +       unsigned long val;
> +       struct kvm_fpureg *fp =3D &vector;
> +
> +       val =3D csr_read(LOONGARCH_CSR_EUEN);
> +       val |=3D CSR_EUEN_FPEN | CSR_EUEN_LSXEN | CSR_EUEN_LASXEN;
> +       csr_write(val, LOONGARCH_CSR_EUEN);
> +
> +       __asm__ __volatile__("fld.d $f0, %0, 0\n" : : "r"(fp) : "$f0");
> +       GUEST_SYNC(0);
> +
> +       __asm__ __volatile__("vld $vr0, %0, 0\n" : : "r"(fp) : "$vr0");
> +       GUEST_SYNC(1);
> +
> +       __asm__ __volatile__("xvld $xr0, %0, 0\n" : : "r"(fp) : "$xr0");
> +       GUEST_SYNC(2);
> +
> +       __asm__ __volatile__("fst.d $f0, %0, 0\n" : : "r"(fp) : "memory")=
;
> +       GUEST_SYNC(3);
> +
> +       __asm__ __volatile__("vst $vr0, %0, 0\n" : : "r"(fp) : "memory");
> +       GUEST_SYNC(4);
> +
> +       __asm__ __volatile__("xvst $xr0, %0, 0\n" : : "r"(fp) : "memory")=
;
> +       GUEST_SYNC(5);
> +
> +       GUEST_DONE();
> +}
> +
> +static void run_vcpu(struct kvm_vcpu *vcpu)
> +{
> +       struct ucall uc;
> +       int cont;
> +
> +       cont =3D 1;
> +       while (cont) {
> +               vcpu_run(vcpu);
> +
> +               switch (get_ucall(vcpu, &uc)) {
> +               case UCALL_PRINTF:
> +                       printf("%s", (const char *)uc.buffer);
> +                       break;
> +               case UCALL_DONE:
> +                       printf("FPU test PASSED\n");
> +                       fallthrough;
> +               case UCALL_SYNC:
> +                       cont =3D 0;
> +                       break;
> +               case UCALL_ABORT:
> +                       REPORT_GUEST_ASSERT(uc);
> +               default:
> +                       TEST_ASSERT(false, "Unexpected exit: %s",
> +                               exit_reason_str(vcpu->run->exit_reason));
> +               }
> +       }
> +}
> +
> +static bool __vm_has_feature(struct kvm_vm *vm, int feature)
> +{
> +       int ret;
> +
> +       ret =3D __kvm_has_device_attr(vm->fd, KVM_LOONGARCH_VM_FEAT_CTRL,=
 feature);
> +       return !ret;
> +}
> +
> +
> +int main(void)
> +{
> +       struct kvm_vcpu *vcpu;
> +       struct kvm_vm *vm;
> +       struct kvm_fpu fpu;
> +       struct kvm_fpureg *fp =3D &vector;
> +
> +       vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
> +       __TEST_REQUIRE(__vm_has_feature(vm, KVM_LOONGARCH_VM_FEAT_LSX),
> +                       "LSX not available, skipping test\n");
> +       __TEST_REQUIRE(__vm_has_feature(vm, KVM_LOONGARCH_VM_FEAT_LASX),
> +                       "LASX not available, skipping test\n");
Directly use __kvm_has_device_attr() as the first patch, or use
__vm_has_feature() in the first patch?

BTW, I don't think the __ prefix is necessary.

Huacai

> +
> +       run_vcpu(vcpu);
> +       vcpu_fpu_get(vcpu, &fpu);
> +       TEST_ASSERT(!memcmp(fpu.fpr, fp, 8), "Wanted 0x%llx from f0, got =
0x%llx",
> +                       fp->val64[0], fpu.fpr[0].val64[0]);
> +
> +       run_vcpu(vcpu);
> +       vcpu_fpu_get(vcpu, &fpu);
> +       TEST_ASSERT(!memcmp(fpu.fpr, fp, 16), "Wanted 0x%llx %llx from vr=
0, got 0x%llx %llx",
> +                       fp->val64[0], fp->val64[1],
> +                       fpu.fpr[0].val64[0], fpu.fpr[0].val64[1]);
> +
> +       run_vcpu(vcpu);
> +       vcpu_fpu_get(vcpu, &fpu);
> +       TEST_ASSERT(!memcmp(fpu.fpr, fp, 32),
> +                       "Wanted 0x%llx %llx %llx %llx from xr0, got 0x%ll=
x %llx %llx %llx",
> +                       fp->val64[0], fp->val64[1], fp->val64[2], fp->val=
64[3],
> +                       fpu.fpr[0].val64[0], fpu.fpr[0].val64[1],
> +                       fpu.fpr[0].val64[2], fpu.fpr[0].val64[3]);
> +
> +       fpu.fpr[0].val64[0] +=3D random();
> +       vcpu_fpu_set(vcpu, &fpu);
> +       run_vcpu(vcpu);
> +       vcpu_fpu_get(vcpu, &fpu);
> +       sync_global_from_guest(vm, *fp);
> +       TEST_ASSERT(!memcmp(fpu.fpr, fp, 8), "Wanted 0x%llx from f0, got =
0x%llx",
> +                       fp->val64[0], fpu.fpr[0].val64[0]);
> +
> +       fpu.fpr[0].val64[0] +=3D random();
> +       fpu.fpr[0].val64[1] +=3D random();
> +       vcpu_fpu_set(vcpu, &fpu);
> +       run_vcpu(vcpu);
> +       vcpu_fpu_get(vcpu, &fpu);
> +       sync_global_from_guest(vm, *fp);
> +       TEST_ASSERT(!memcmp(fpu.fpr, fp, 16), "Wanted 0x%llx %llx from vr=
0, got 0x%llx %llx",
> +                       fp->val64[0], fp->val64[1],
> +                       fpu.fpr[0].val64[0], fpu.fpr[0].val64[1]);
> +
> +       fpu.fpr[0].val64[0] +=3D random();
> +       fpu.fpr[0].val64[1] +=3D random();
> +       fpu.fpr[0].val64[2] +=3D random();
> +       fpu.fpr[0].val64[3] +=3D random();
> +       vcpu_fpu_set(vcpu, &fpu);
> +       run_vcpu(vcpu);
> +       vcpu_fpu_get(vcpu, &fpu);
> +       sync_global_from_guest(vm, *fp);
> +       TEST_ASSERT(!memcmp(fpu.fpr, fp, 32),
> +                       "Wanted 0x%llx %llx %llx %llx from xr0, got 0x%ll=
x %llx %llx %llx",
> +                       fp->val64[0], fp->val64[1], fp->val64[2], fp->val=
64[3],
> +                       fpu.fpr[0].val64[0], fpu.fpr[0].val64[1],
> +                       fpu.fpr[0].val64[2], fpu.fpr[0].val64[3]);
> +
> +       run_vcpu(vcpu);
> +       kvm_vm_free(vm);
> +       return 0;
> +}
> --
> 2.39.3
>
