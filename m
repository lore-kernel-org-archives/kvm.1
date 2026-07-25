Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3068135674E
	for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784972448; cv=none; b=dVEFzQrh8HLeU6jJf+npwcxBa8tZ5Lw3RylPBLn6SUp6zxv+SO52ccguWYdFCl4Fy85W5E80thGYxKUSikXdne5EmZAaqYsbQRf+phySmgRTnoItaU/DNDZ8e79AdwF5E+zbKzspQT3aqJxMaX1fIM5Quq2GNZBbJvrGIBIwqos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784972448; c=relaxed/simple;
	bh=8ctn83JcdY3Unm+xBuWSmcZM7RJ+QoGLSUQ3O5TpEVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkdzzarnEGc400+VHFIV1LokXD6WraB7a1rSex/SuQiSMHGvm4EWfJg1asjbB0P0mV9XcBUC+cOYdh8Ad1GOXMd6Gi+7jrVCfQD7cZTpsU7P+5bVtqm7D5Ew2Vayykn4xeej8IG9LAkY6WAUXSyJSl1yn9PHSmw5JBtWEgSOXHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4D+d7P/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4D+d7P/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37541F000E9
	for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 09:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784972446;
	bh=LaEHV6Lc8bCQ7GgMMuE8YT47IPgc2TnpKj455uV/Zyw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=k4D+d7P/xCbZnITwS5dHbPEc6Mdf8xS5IZJPgb8U8y7mTuzNiA7UcVcc4nHthaSCP
	 WJLdio3Nc9kD0CQTvUAsusQtihmRGNdVqCWM90Ea2qA88eIiiAMZRfES1FZSY01Srx
	 NbOkpAl9RuyvpCFWGB9Qid8lP5PghZY0w7ic8Ixa3g9fuQFeuAMNxx2chi44L6RzyS
	 2ZbhvOTsKbk2DZlmVi1ar+sQt2hZBTKQzMuCrNFX0h2b8/X1urprdR8x1CGGtFsOBE
	 VKM0iugU9muoN69U3TEox2H6idRzBgk3eYhVTK+5jatvphpclxj83Gq9b0gQjdXz41
	 ZLC13hlBe/cxg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69c7697d523so1149817a12.2
        for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 02:40:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq7ocSTCTyR6+yMM/gur/+Eo6hHLurPfC0Tf8UVt3r9WiCtk7GgwgzFKDnmbNK6ZB0Gx7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgjRFVsoOT1n3Rsuym3TTsZbJVweG+k7Mu4zJGuHYxQwA+e/h8
	AuqoyokLBBgM+GPl4XraBh8K8ADt1wRXqh7IBkgQ2N7xI+sTU8dp1hTSuYyzBwTxN0AwFEqf9+4
	yXawis4d5mp6qLaub2jeQsjiNhIe0HWA=
X-Received: by 2002:a05:6402:52d8:b0:698:3a7c:7d6e with SMTP id
 4fb4d7f45d1cf-69fc1141f0fmr573015a12.27.1784972445516; Sat, 25 Jul 2026
 02:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723111605.1630027-1-zeng_chi911@163.com> <146b5e27-2ab0-da17-7b98-09235ef4f9c4@loongson.cn>
In-Reply-To: <146b5e27-2ab0-da17-7b98-09235ef4f9c4@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 25 Jul 2026 17:41:10 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7pLEUeKWGmCZqDdF+2vr=2aexOFVCMa_UxTrDpUY+gvA@mail.gmail.com>
X-Gm-Features: AUfX_mzlyrjDQFc8Hz3eLwYKFUKSIBjUjCKHnVHbY29UE8pX5gYqYbCidH-z7YY
Message-ID: <CAAhV-H7pLEUeKWGmCZqDdF+2vr=2aexOFVCMa_UxTrDpUY+gvA@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: LoongArch: selftests: Add in-kernel MMIO read
 fast path test
To: Bibo Mao <maobibo@loongson.cn>
Cc: Zeng Chi <zeng_chi911@163.com>, zhaotianrui@loongson.cn, kernel@xen0n.name, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zengchi@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 9:28=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
>
>
> On 2026/7/23 =E4=B8=8B=E5=8D=887:16, Zeng Chi wrote:
> > From: Zeng Chi <zengchi@kylinos.cn>
> >
> > Add a test that exercises the in-kernel MMIO read fast path of
> > kvm_emu_mmio_read(). The guest performs an MMIO read from an in-kernel
> > emulated PCH-PIC, immediately followed by a marker instruction, and the
> > test verifies that the marker instruction is executed, i.e. that the PC
> > advances by exactly one instruction instead of skipping the instruction
> > after the MMIO read.
> >
> > The test skips gracefully when the host KVM cannot create a PCH-PIC
> > device.
> >
> > Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
> > ---
> >   tools/testing/selftests/kvm/Makefile.kvm      |  3 +-
> >   .../selftests/kvm/loongarch/mmio_read_test.c  | 89 ++++++++++++++++++=
+
> >   2 files changed, 91 insertions(+), 1 deletion(-)
> >   create mode 100644 tools/testing/selftests/kvm/loongarch/mmio_read_te=
st.c
> >
> > diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/s=
elftests/kvm/Makefile.kvm
> > index 6fc34e9bf8e1..4daf90caaabc 100644
> > --- a/tools/testing/selftests/kvm/Makefile.kvm
> > +++ b/tools/testing/selftests/kvm/Makefile.kvm
> > @@ -228,7 +228,8 @@ TEST_GEN_PROGS_riscv +=3D mmu_stress_test
> >   TEST_GEN_PROGS_riscv +=3D rseq_test
> >   TEST_GEN_PROGS_riscv +=3D steal_time
> >
> > -TEST_GEN_PROGS_loongarch =3D loongarch/pmu_test
> > +TEST_GEN_PROGS_loongarch =3D loongarch/mmio_read_test
> > +TEST_GEN_PROGS_loongarch +=3D loongarch/pmu_test
> >   TEST_GEN_PROGS_loongarch +=3D arch_timer
> >   TEST_GEN_PROGS_loongarch +=3D coalesced_io_test
> >   TEST_GEN_PROGS_loongarch +=3D demand_paging_test
> > diff --git a/tools/testing/selftests/kvm/loongarch/mmio_read_test.c b/t=
ools/testing/selftests/kvm/loongarch/mmio_read_test.c
> > new file mode 100644
> > index 000000000000..7f64ca91ca8f
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/loongarch/mmio_read_test.c
> > @@ -0,0 +1,89 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * LoongArch KVM in-kernel MMIO read fast path test
> > + *
> > + * When an MMIO read hits a device emulated inside KVM (such as the
> > + * PCH-PIC), kvm_emu_mmio_read() completes the access without returnin=
g
> > + * to user space and advances the guest PC by one instruction.
> > + *
> > + * This test issues such an in-kernel MMIO read immediately followed b=
y
> > + * a marker instruction and checks that the marker instruction actuall=
y
> > + * runs, i.e. that the PC advanced by exactly one instruction (4 bytes=
)
> > + * rather than skipping the instruction after the MMIO read.
> > + */
> > +#include "kvm_util.h"
> > +#include "processor.h"
> > +#include "test_util.h"
> > +#include "loongarch/processor.h"
> > +
> > +/* Physical base the in-kernel PCH-PIC is mapped at (no memslot backs =
it) */
> > +#define PCH_PIC_BASE         0x10000000UL
> > +
> > +static void guest_code(void)
> > +{
> > +     unsigned long marker =3D 0;
> > +     unsigned int val =3D 0;
> > +
> > +     /*
> > +      * 'ld.w' faults out as an MMIO read and is emulated in kernel.
> > +      * The following 'addi.d' must execute; it is skipped if the MMIO
> > +      * read fast path advances the PC twice (by 8 instead of 4).
> > +      */
> > +     asm volatile(
> > +             "ld.w   %[val], %[base], 0\n\t"
> > +             "addi.d %[marker], %[marker], 1\n\t"
> > +             : [val] "=3D&r" (val), [marker] "+&r" (marker)
> > +             : [base] "r" (PCH_PIC_BASE)
> > +             : "memory");
> By my understanding, the kvm selftest is mainly to test function. It
> will be better if it is to verify irq handling with in-kernel PCH-PIC
> irqchip.
I think the fist patch is just enough. :)

Huacai

>
> Regards
> Bibo Mao
> > +
> > +     GUEST_PRINTF("mmio read val=3D0x%x, marker=3D%lu\n", val, marker)=
;
> > +     GUEST_ASSERT_EQ(marker, 1);
> > +     GUEST_DONE();
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     struct kvm_vcpu *vcpu;
> > +     struct kvm_vm *vm;
> > +     struct ucall uc;
> > +     uint64_t addr =3D PCH_PIC_BASE;
> > +     int dev_fd;
> > +
> > +     vm =3D vm_create(VM_MODE_P47V47_16K);
> > +     vcpu =3D vm_vcpu_add(vm, 0, guest_code);
> > +
> > +     /* Create the in-kernel PCH-PIC and map it at PCH_PIC_BASE */
> > +     dev_fd =3D __kvm_create_device(vm, KVM_DEV_TYPE_LOONGARCH_PCHPIC)=
;
> > +     if (dev_fd < 0) {
> > +             print_skip("PCH-PIC device not supported by host KVM");
> > +             kvm_vm_free(vm);
> > +             return KSFT_SKIP;
> > +     }
> > +     kvm_device_attr_set(dev_fd, KVM_DEV_LOONGARCH_PCH_PIC_GRP_CTRL,
> > +                         KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT, &addr);
> > +     close(dev_fd);
> > +
> > +     /* Identity-map the MMIO page so the guest can reach the device *=
/
> > +     virt_map(vm, PCH_PIC_BASE, PCH_PIC_BASE, 1);
> > +
> > +     while (1) {
> > +             vcpu_run(vcpu);
> > +             switch (get_ucall(vcpu, &uc)) {
> > +             case UCALL_PRINTF:
> > +                     pr_info("%s", uc.buffer);
> > +                     break;
> > +             case UCALL_DONE:
> > +                     goto done;
> > +             case UCALL_ABORT:
> > +                     REPORT_GUEST_ASSERT(uc);
> > +                     goto done;
> > +             default:
> > +                     TEST_FAIL("Unexpected exit: %s",
> > +                               exit_reason_str(vcpu->run->exit_reason)=
);
> > +             }
> > +     }
> > +
> > +done:
> > +     kvm_vm_free(vm);
> > +     return 0;
> > +}
> >
>
