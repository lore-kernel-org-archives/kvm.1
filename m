Received: from va-2-36.ptr.blmpb.com (va-2-36.ptr.blmpb.com [209.127.231.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CADB22A4F1
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791441835; cv=none; b=u2KhO3sGSxnl+JPQSUCrEzuRJSj0JlGNO9iajk7v/IuvKzE7OKPj7jnadf+OkVo58px52fF4MpIWKtTZNfiHM0d/G7LN2Owa9wiEjBJVBR2M5vUeFZXyaRMg51sXNvdGW1TEYp6WdGSR9uoGMicl4ieKp14fGi5b+H5udS3DUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791441835; c=relaxed/simple;
	bh=BfxM8vd52dNsMCAjhUtelgVJyQ79sEInHUO+A70HhS8=;
	h=To:Mime-Version:In-Reply-To:Date:References:Subject:Message-Id:Cc:
	 From:Content-Type; b=JuV2DYXQMQOVriC++djiT7WXMuYWrxWE9mmUy2lEq87meE58HbaGxNLTCbdtl3T8HMNJFZVHm7Gepp9Y57FNpR24trbqRqN297MTWt8Qd+SVByk/SD7CJJ72ReAnhOtPpkOHKF8H5agW3bRZB55y/iPBDkJOGlibhN5lEL+I07E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=hKkrnra6; arc=none smtp.client-ip=209.127.231.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="hKkrnra6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1791441707;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=sL7T/hjodnqfA5MGKpC/p/9ovdpQBjVAPfJ0x9At1e0=;
 b=hKkrnra6IIsGTabhd7BSwWpEk0z1OhY4lGg5G6TmU2OHNRlyV81+CClQNWyZMIiG7s0uZp
 sXfnBGzPrPMgt3TYDcjrtZL6IFWkFe0iDz1B/JDVnINzUU/2m+TpmtMkFm81K7wqV0KCn0
 +ObW7RZCqCEJma9ZZpAmwReITtzeo+8KPtdj4gAPkGOZx57jPIrkBlGzUHqQR8bxfWCD7z
 H+RewnXDbrgprGDKp6CFKD47wkJZjBZSHWPM7E58xCOf+VHjiIfLCHgfrH/SpOWHQ7jpWT
 YlTwIsp99RIwX9OTMpYJTvkwi3pP8HgRHttHMe2pa4bFu9hqLWRLqlhhkGfdig==
To: "Anup Patel" <anup@brainfault.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
In-Reply-To: <CAAhSdy0UgBGd2M=Zq3XiaTY-Y5uTrAcOtFF=haKgmFBRB1=ggw@mail.gmail.com>
Date: Thu, 8 Oct 2026 14:41:39 +0800
Content-Language: en-US
References: <20260730093614.983508-1-xiangwencheng@lanxincomputing.com> <CAAhSdy0UgBGd2M=Zq3XiaTY-Y5uTrAcOtFF=haKgmFBRB1=ggw@mail.gmail.com>
Subject: Re: [PATCH] riscv: KVM: Add hart-to-vCPU mapping for faster MSI injection
Message-Id: <3c62dcd4-013f-4de1-93ee-dc74909060df@lanxincomputing.com>
X-Lms-Return-Path: <lba+26ac73b29+288946+vger.kernel.org+xiangwencheng@lanxincomputing.com>
Received: from [127.0.0.1] ([123.120.5.129]) by smtp.feishu.cn with ESMTPS; Thu, 08 Oct 2026 14:41:44 +0800
Cc: <atish.patra@linux.dev>, <pjw@kernel.org>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <kvm@vger.kernel.org>, 
	<kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Content-Transfer-Encoding: quoted-printable
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8

On 10/2/2026 2:53 PM, Anup Patel wrote:
> On Thu, Jul 30, 2026 at 3:06=E2=80=AFPM BillXiang
> <xiangwencheng@lanxincomputing.com> wrote:
>>
>> Replace linear searches over all vCPUs in MSI injection paths with a
>> direct hart_index -> vCPU lookup table. This avoids O(n) scans on
>> every injected interrupt and improves performance when the number of
>> vCPUs is large.
>>
>> Both kvm_riscv_aia_inject_msi_by_id() and kvm_riscv_aia_inject_msi()
>> now use the table instead of iterating over the vCPU list.
>=20
> The AIA hart_index bits for VCPUs are based on the IMSIC address
> set by the KVM user-space and are not required to be contiguous hence
> this patch is already broken.

Hi Anup,

Thanks for the review. You=E2=80=99re right =E2=80=94 hart_index is not gua=
ranteed=20
contiguous because it comes from the userspace-provided IMSIC address.=20
Sizing the table by created_vcpus and bounds-checking against it is=20
therefore wrong.

I'll use an xarray keyed by hart_index instead, or drop the optimization=20
if that=E2=80=99s preferred.

Regards,
Bill

>=20
> NACK from my side.
>=20
> Regards,
> Anup
>=20
>>
>> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
>> ---
>>   arch/riscv/include/asm/kvm_aia.h |  2 +
>>   arch/riscv/kvm/aia_device.c      | 67 +++++++++++++++++++++-----------
>>   2 files changed, 47 insertions(+), 22 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/k=
vm_aia.h
>> index c67ec5ac0..71240b0a2 100644
>> --- a/arch/riscv/include/asm/kvm_aia.h
>> +++ b/arch/riscv/include/asm/kvm_aia.h
>> @@ -47,6 +47,8 @@ struct kvm_aia {
>>
>>          /* Internal state of APLIC */
>>          void            *aplic_state;
>> +
>> +       struct kvm_vcpu **hart_to_vcpu;
>>   };
>>
>>   struct kvm_vcpu_aia_csr {
>> diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
>> index be83c2d5f..595553817 100644
>> --- a/arch/riscv/kvm/aia_device.c
>> +++ b/arch/riscv/kvm/aia_device.c
>> @@ -253,6 +253,14 @@ static int aia_init(struct kvm *kvm)
>>          if (ret)
>>                  return ret;
>>
>> +       aia->hart_to_vcpu =3D kcalloc(kvm->created_vcpus,
>> +                                       sizeof(struct kvm_vcpu*),
>> +                                       GFP_KERNEL);
>> +       if (!aia->hart_to_vcpu) {
>> +               ret =3D -ENOMEM;
>> +               goto fail_cleanup_aplic;
>> +       }
>> +
>>          /* Iterate over each VCPU */
>>          kvm_for_each_vcpu(idx, vcpu, kvm) {
>>                  vaia =3D &vcpu->arch.aia_context;
>> @@ -274,6 +282,12 @@ static int aia_init(struct kvm *kvm)
>>                  /* Update HART index of the IMSIC based on IMSIC base *=
/
>>                  vaia->hart_index =3D aia_imsic_hart_index(aia,
>>                                                          vaia->imsic_add=
r);
>> +
>> +               if (aia->hart_to_vcpu[vaia->hart_index]) {
>> +                       ret =3D -EINVAL;
>> +                       goto fail_cleanup_imsics;
>> +               }
>> +               aia->hart_to_vcpu[vaia->hart_index] =3D vcpu;
>>
>>                  /* Initialize IMSIC for this VCPU */
>>                  ret =3D kvm_riscv_vcpu_aia_imsic_init(vcpu);
>> @@ -293,6 +307,9 @@ static int aia_init(struct kvm *kvm)
>>                          continue;
>>                  kvm_riscv_vcpu_aia_imsic_cleanup(vcpu);
>>          }
>> +       kfree(aia->hart_to_vcpu);
>> +       aia->hart_to_vcpu =3D NULL;
>> +fail_cleanup_aplic:
>>          kvm_riscv_aia_aplic_cleanup(kvm);
>>          return ret;
>>   }
>> @@ -551,30 +568,28 @@ void kvm_riscv_vcpu_aia_deinit(struct kvm_vcpu *vc=
pu)
>>   int kvm_riscv_aia_inject_msi_by_id(struct kvm *kvm, u32 hart_index,
>>                                     u32 guest_index, u32 iid)
>>   {
>> -       unsigned long idx;
>>          struct kvm_vcpu *vcpu;
>> +       struct kvm_aia *aia =3D &kvm->arch.aia;
>>
>>          /* Proceed only if AIA was initialized successfully */
>>          if (!kvm_riscv_aia_initialized(kvm))
>>                  return -EBUSY;
>>
>> -       /* Inject MSI to matching VCPU */
>> -       kvm_for_each_vcpu(idx, vcpu, kvm) {
>> -               if (vcpu->arch.aia_context.hart_index =3D=3D hart_index)
>> -                       return kvm_riscv_vcpu_aia_imsic_inject(vcpu,
>> -                                                              guest_ind=
ex,
>> -                                                              0, iid);
>> -       }
>> +       if (!aia->hart_to_vcpu || hart_index >=3D kvm->created_vcpus)
>> +               return 0;
>>
>> -       return 0;
>> +       vcpu =3D aia->hart_to_vcpu[hart_index];
>> +       if (!vcpu)
>> +               return 0;
>> +
>> +       return kvm_riscv_vcpu_aia_imsic_inject(vcpu, guest_index, 0, iid=
);
>>   }
>>
>>   int kvm_riscv_aia_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
>>   {
>>          gpa_t tppn, ippn;
>> -       unsigned long idx;
>>          struct kvm_vcpu *vcpu;
>> -       u32 g, toff, iid =3D msi->data;
>> +       u32 g, toff, iid =3D msi->data, hart_index;
>>          struct kvm_aia *aia =3D &kvm->arch.aia;
>>          gpa_t target =3D (((gpa_t)msi->address_hi) << 32) | msi->addres=
s_lo;
>>
>> @@ -589,18 +604,22 @@ int kvm_riscv_aia_inject_msi(struct kvm *kvm, stru=
ct kvm_msi *msi)
>>          g =3D tppn & (BIT(aia->nr_guest_bits) - 1);
>>          tppn &=3D ~((gpa_t)(BIT(aia->nr_guest_bits) - 1));
>>
>> -       /* Inject MSI to matching VCPU */
>> -       kvm_for_each_vcpu(idx, vcpu, kvm) {
>> -               ippn =3D vcpu->arch.aia_context.imsic_addr >>
>> -                                       IMSIC_MMIO_PAGE_SHIFT;
>> -               if (ippn =3D=3D tppn) {
>> -                       toff =3D target & (IMSIC_MMIO_PAGE_SZ - 1);
>> -                       return kvm_riscv_vcpu_aia_imsic_inject(vcpu, g,
>> -                                                              toff, iid=
);
>> -               }
>> -       }
>> +       if (!aia->hart_to_vcpu)
>> +               return 0;
>>
>> -       return 0;
>> +       hart_index =3D aia_imsic_hart_index(aia, target);
>> +       if(hart_index >=3D kvm->created_vcpus)
>> +               return 0;
>> +
>> +       vcpu =3D aia->hart_to_vcpu[hart_index];
>> +       if (!vcpu)
>> +               return 0;
>> +
>> +       ippn =3D vcpu->arch.aia_context.imsic_addr >> IMSIC_MMIO_PAGE_SH=
IFT;
>> +       if (ippn !=3D tppn)
>> +               return 0;
>> +       toff =3D target & (IMSIC_MMIO_PAGE_SZ - 1);
>> +       return kvm_riscv_vcpu_aia_imsic_inject(vcpu, g, toff, iid);
>>   }
>>
>>   int kvm_riscv_aia_inject_irq(struct kvm *kvm, unsigned int irq, bool l=
evel)
>> @@ -641,10 +660,14 @@ void kvm_riscv_aia_init_vm(struct kvm *kvm)
>>
>>   void kvm_riscv_aia_destroy_vm(struct kvm *kvm)
>>   {
>> +       struct kvm_aia *aia =3D &kvm->arch.aia;
>>          /* Proceed only if AIA was initialized successfully */
>>          if (!kvm_riscv_aia_initialized(kvm))
>>                  return;
>>
>> +       kfree(aia->hart_to_vcpu);
>> +       aia->hart_to_vcpu =3D NULL;
>> +
>>          /* Cleanup APLIC context */
>>          kvm_riscv_aia_aplic_cleanup(kvm);
>>   }
>> --
>> 2.53.0
