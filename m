Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266528;
	b=o/BJjHF4Df7RccrHapxKmOHrJgz7+atEiIdi13Li3JFMf+wZ8SZ+MCcyar5mQWfa/swO
	 8V9iR4m4HTbcUy55WjRMol6ig2z5cprXhJl7eWKS5KmmEI6J8ql1oBPuaBOUuLZmoN5qc
	 6RUSWHbKERdM5p/Y3kZF7QWqlWXz1Jk/Fzsmyf89J09aNZYxN+LEytP+E21twk1rgEVDi
	 UW4fK8osPHt33GWfhRVguSjFbtVJs/bwtCeWpYWLDV/8qhIXDlTm/D82CKXkjxJFv13zn
	 Rs/2nZkscTPeUsFJ7/rW85mB9E21hFbgmKkEaGuxlLouSWHK+2EMbf6EOe9ypSYsMIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266528;
	h=DMARC-Filter:DKIM-Signature:Content-Transfer-Encoding:Received:
	 References:Subject:Message-Id:In-Reply-To:To:X-Lms-Return-Path:
	 Content-Language:Mime-Version:From:Date:User-Agent:Content-Type:
	 X-Original-From:Cc;
	bh=kPR28qORF32opZ2FjX2BjlSFj/du70LVKxJclETRGgU=;
	b=JsptzJX68xerq6zUGbtGx8kGBUIodmUGYH2c3lMp9d/Ko5TYw5TVmrVz2SsY31SCF/6p
	 35snqiZustknqjcQXSvD8w6GojYT+fkXjp8KDyqJZobARqNyv3Axf+I00kISApqq0G+lD
	 uhdkgy4a+e3KDN6pFXda/kivXmNgJsZRN/DN2Tlij+wo+AQkcrJqHCvQkcZ1q+JSdJCfv
	 osPdEnZGURFNjcotdCb2s+YcNFJukig4fknSyEptv6kQx6ZoQrEyc/uYkcqmmUVQoEHhG
	 5gKLEN07307mpHmHTF+BJiy94swbolLdyE3tAeXJke4rwbrckFtExtctfyeLAxQG7sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=lanxincomputing.com;
	spf=pass smtp.mailfrom=lanxincomputing.com;
	dkim=pass header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=zBp2mKEo;
	arc=none smtp.remote-ip=209.127.231.44
Received: from va-2-44.ptr.blmpb.com (va-2-44.ptr.blmpb.com [209.127.231.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD300606A31A
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 09:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD300606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=zBp2mKEo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1793266521;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=kPR28qORF32opZ2FjX2BjlSFj/du70LVKxJclETRGgU=;
 b=zBp2mKEoXTXTuZOa8PkWeuzgIX1WNnvm4o5bLCptKLJMqUVSgUIL0bSDR0R67lyGsNFLFJ
 fUghZZW6UwGKmTn+He56aIqB321oJyNj5U0JSySiCvSUdyfZAg4oVdTUD/Pww6/zIdXnkY
 UVvbgMXOtt9Un6wQH5tGJcwj9sksnncVPI0xM+GVQWAwIHH0+ZPSCYoo6ERGiHaFxvxo1g
 MrbXfT+gCMkuM7PqrL4IGFkkRInaPFsDJL5Q2y6bwFTglnNA6nGqyXFLVdS5wZz5Y46G0h
 KlEn1YXrKnGiIMBuIJzCOAvqtQ6fU1e7BZzOEN5Fv4Tnp4DpDCS7kJ/zTycAcw==
Content-Transfer-Encoding: quoted-printable
Received: from [127.0.0.1] ([123.120.5.129]) by smtp.feishu.cn with ESMTPS; Thu, 29 Oct 2026 17:35:18 +0800
References: <20261029082426.706302-1-xiangwencheng@lanxincomputing.com> <TYZPR04MB7491A2FF4DB08B00DD53E315F36E2@TYZPR04MB7491.apcprd04.prod.outlook.com>
Subject: Re: [PATCH v2] riscv: KVM: Add hart-to-vCPU mapping for faster MSI injection
Message-Id: <bacc6283-f06e-441b-afa9-c263ced5df3a@lanxincomputing.com>
In-Reply-To: <TYZPR04MB7491A2FF4DB08B00DD53E315F36E2@TYZPR04MB7491.apcprd04.prod.outlook.com>
To: "Nutty.Liu" <nutty.liu@hotmail.com>, <anup@brainfault.org>
X-Lms-Return-Path: <lba+26ae31357+9b5872+vger.kernel.org+xiangwencheng@lanxincomputing.com>
Content-Language: en-US
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Date: Thu, 29 Oct 2026 17:35:15 +0800
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
Cc: <atish.patra@linux.dev>, <pjw@kernel.org>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <kvm@vger.kernel.org>, 
	<kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>

On 10/29/2026 5:15 PM, Nutty.Liu wrote:
>=20
> On 10/29/2026 4:24 PM, BillXiang wrote:
>> Replace linear searches over all vCPUs in MSI injection paths with a
>> hart_index -> vCPU xarray lookup table. This avoids O(n) scans on
>> every injected interrupt and improves performance when the number of
>> vCPUs is large.
>>
>> Both kvm_riscv_aia_inject_msi_by_id() and kvm_riscv_aia_inject_msi()
>> now use the table instead of iterating over the vCPU list.
>>
>> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
>> Changes in v2:
> Hi Bill,
>=20
> The change log should be under the tear line.

Thanks for the reminder.

>> - Use xarray instead of normal array to handle incontiguous hart_index.
>> - Link to v1:
>> =C2=A0=C2=A0 https://lore.kernel.org/kvm-riscv/20260730093614.983508-1-=
=20
>> xiangwencheng@lanxincomputing.com/
>> ---
>> =C2=A0 arch/riscv/include/asm/kvm_aia.h |=C2=A0 3 ++
>> =C2=A0 arch/riscv/kvm/aia_device.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 50 ++=
+++++++++++++++---------------
>> =C2=A0 2 files changed, 30 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/=20
>> asm/kvm_aia.h
>> index ab03f853e507..3b075f18e1d6 100644
>> --- a/arch/riscv/include/asm/kvm_aia.h
>> +++ b/arch/riscv/include/asm/kvm_aia.h
>> @@ -12,6 +12,7 @@
>> =C2=A0 #include <linux/jump_label.h>
>> =C2=A0 #include <linux/kvm_types.h>
>> +#include <linux/xarray.h>
>> =C2=A0 #include <asm/csr.h>
>> =C2=A0 struct kvm_aia {
>> @@ -47,6 +48,8 @@ struct kvm_aia {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Internal state of APLIC */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 *aplic_state;
>> +
>> +=C2=A0=C2=A0=C2=A0 struct xarray hart_to_vcpu;
>> =C2=A0 };
>> =C2=A0 struct kvm_vcpu_aia_csr {
>> diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
>> index efc7c0bcfba9..a415a8c10967 100644
>> --- a/arch/riscv/kvm/aia_device.c
>> +++ b/arch/riscv/kvm/aia_device.c
>> @@ -259,6 +259,8 @@ static int aia_init(struct kvm *kvm)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 xa_init(&aia->hart_to_vcpu);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Iterate over each VCPU */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_for_each_vcpu(idx, vcpu, kvm) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vaia =3D &vcpu->a=
rch.aia_context;
>> @@ -280,6 +282,11 @@ static int aia_init(struct kvm *kvm)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Update HART in=
dex of the IMSIC based on IMSIC base */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vaia->hart_index =
=3D aia_imsic_hart_index(aia,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 vaia->imsic_addr);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D xa_insert(&aia->hart=
_to_vcpu, vaia->hart_index, vcpu,=20
>> GFP_KERNEL);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 fail_cleanup_imsics;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Initialize IMS=
IC for this VCPU */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D kvm_riscv=
_vcpu_aia_imsic_init(vcpu);
>> @@ -299,6 +306,7 @@ static int aia_init(struct kvm *kvm)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 continue;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_riscv_vcpu_ai=
a_imsic_cleanup(vcpu);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 xa_destroy(&aia->hart_to_vcpu);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_riscv_aia_aplic_cleanup(kvm);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> @@ -557,30 +565,25 @@ void kvm_riscv_vcpu_aia_deinit(struct kvm_vcpu=20
>> *vcpu)
>> =C2=A0 int kvm_riscv_aia_inject_msi_by_id(struct kvm *kvm, u32 hart_inde=
x,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 guest_index, u32 iid)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 unsigned long idx;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_vcpu *vcpu;
>> +=C2=A0=C2=A0=C2=A0 struct kvm_aia *aia =3D &kvm->arch.aia;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Proceed only if AIA was initialized su=
ccessfully */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!kvm_riscv_aia_initialized(kvm))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EBUSY;
>> -=C2=A0=C2=A0=C2=A0 /* Inject MSI to matching VCPU */
>> -=C2=A0=C2=A0=C2=A0 kvm_for_each_vcpu(idx, vcpu, kvm) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vcpu->arch.aia_context.h=
art_index =3D=3D hart_index)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn kvm_riscv_vcpu_aia_imsic_inject(vcpu,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guest_index,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, iid);
>> -=C2=A0=C2=A0=C2=A0 }
>> -
>> -=C2=A0=C2=A0=C2=A0 return 0;
>> +=C2=A0=C2=A0=C2=A0 vcpu =3D xa_load(&aia->hart_to_vcpu, hart_index);
>> +=C2=A0=C2=A0=C2=A0 if (!vcpu)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 return kvm_riscv_vcpu_aia_imsic_inject(vcpu, guest_i=
ndex, 0, iid);
>> =C2=A0 }
>> =C2=A0 int kvm_riscv_aia_inject_msi(struct kvm *kvm, struct kvm_msi *msi=
)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpa_t tppn, ippn;
>> -=C2=A0=C2=A0=C2=A0 unsigned long idx;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_vcpu *vcpu;
>> -=C2=A0=C2=A0=C2=A0 u32 g, toff, iid =3D msi->data;
>> +=C2=A0=C2=A0=C2=A0 u32 g, toff, iid =3D msi->data, hart_index;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_aia *aia =3D &kvm->arch.aia;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpa_t target =3D (((gpa_t)msi->address_hi=
) << 32) | msi->address_lo;
>> @@ -595,18 +598,16 @@ int kvm_riscv_aia_inject_msi(struct kvm *kvm,=20
>> struct kvm_msi *msi)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g =3D tppn & (BIT(aia->nr_guest_bits) - 1=
);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tppn &=3D ~((gpa_t)(BIT(aia->nr_guest_bit=
s) - 1));
>> -=C2=A0=C2=A0=C2=A0 /* Inject MSI to matching VCPU */
>> -=C2=A0=C2=A0=C2=A0 kvm_for_each_vcpu(idx, vcpu, kvm) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ippn =3D vcpu->arch.aia_cont=
ext.imsic_addr >>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IMSIC_MMIO_PAGE_SHIFT;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ippn =3D=3D tppn) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 toff=
 =3D target & (IMSIC_MMIO_PAGE_SZ - 1);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn kvm_riscv_vcpu_aia_imsic_inject(vcpu, g,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 toff, iid);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 hart_index =3D aia_imsic_hart_index(aia, target);
>> +=C2=A0=C2=A0=C2=A0 vcpu =3D xa_load(&aia->hart_to_vcpu, hart_index);
>> +=C2=A0=C2=A0=C2=A0 if (!vcpu)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> -=C2=A0=C2=A0=C2=A0 return 0;
>> +=C2=A0=C2=A0=C2=A0 ippn =3D vcpu->arch.aia_context.imsic_addr >> IMSIC_=
MMIO_PAGE_SHIFT;
>> +=C2=A0=C2=A0=C2=A0 if (ippn !=3D tppn)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +=C2=A0=C2=A0=C2=A0 toff =3D target & (IMSIC_MMIO_PAGE_SZ - 1);
>> +=C2=A0=C2=A0=C2=A0 return kvm_riscv_vcpu_aia_imsic_inject(vcpu, g,=C2=
=A0=C2=A0=C2=A0 toff, iid);
>> =C2=A0 }
>> =C2=A0 int kvm_riscv_aia_inject_irq(struct kvm *kvm, unsigned int irq, b=
ool=20
>> level)
>> @@ -647,9 +648,12 @@ void kvm_riscv_aia_init_vm(struct kvm *kvm)
>> =C2=A0 void kvm_riscv_aia_destroy_vm(struct kvm *kvm)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 struct kvm_aia *aia =3D &kvm->arch.aia;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Proceed only if AIA was initialized su=
ccessfully */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!kvm_riscv_aia_initialized(kvm))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0 xa_destroy(&aia->hart_to_vcpu);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Cleanup APLIC context */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_riscv_aia_aplic_cleanup(kvm);
