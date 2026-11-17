Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884079;
	b=t0ATu+P/CKZaBYQZvh3EVGXy+RiZCUoFPurJDfebCp4JefYRp2FCgrKwQ3uV2zD7DgBY
	 lnnZ4YBTf1IJ6OgQwdTgA8A4yEDi02z8q3HbUcEnPb/04upAsTqUR/L7uyh5BKA2g+TZC
	 2vqB1+8C0Zq+26o7oiLjumqzbTpr79qfW3fBYV2fYM9vfyHdhuW/Ut1FL2uIA3s2C3Z2f
	 7Mn1/g4KmXRo1oCRccjU1xYLDeKcihVn7Q1xNTSPIqnvBcCmUo81WfdfEugDAC4vOIUpB
	 9P02USLCYkEPSrlAplL1Kczi5A0Dbs0ZY7zd5r68cVtVFshnkDZkcU19W3PDkSUQ/GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884079;
	h=DMARC-Filter:DKIM-Signature:To:Content-Transfer-Encoding:
	 Content-Language:In-Reply-To:Cc:Message-Id:References:User-Agent:
	 X-Lms-Return-Path:Subject:X-Original-From:From:Date:Mime-Version:
	 Received:Content-Type;
	bh=B6o0YTG1q+hlC1dIwJ8MRViNtPcn8I2cwDIc51AfJlU=;
	b=Yp21CqC7oBLjmZNSUfd+7UpdrBh9TC73f5aktsiKTB40hWLYdcavMdrB55InXRGxEUgw
	 mkHwAH+A2cPphEDfHcYlQzWXfwybfI3g+8zf6yn637BvyAeJNFyXQptBvbOZUCFZnNl2Q
	 evZ/SfPtDs/EGSd8yWboaMC+23hD2CN5avTkEqq9i6j5BQvTq66cp392NeMu7WOrqWdES
	 hyonpgxtcrZK2ayFnZR+W/bWmjvaSnD1Pbv8864tUjmidwvCQK0DKSp4WeORq1/65Kg4v
	 pBqD7b3JdLAG+4YsIuprTQ0Hbo52mspQjimLLzH3XZ0n4r/cPaMPxdSeLiNgKaSZ8hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=lanxincomputing.com;
	spf=pass smtp.mailfrom=lanxincomputing.com;
	dkim=pass header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=NAU6GYya;
	arc=none smtp.remote-ip=209.127.231.38
Received: from va-2-38.ptr.blmpb.com (va-2-38.ptr.blmpb.com [209.127.231.38])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8474A606A31C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 02:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8474A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=NAU6GYya
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1794884072;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=B6o0YTG1q+hlC1dIwJ8MRViNtPcn8I2cwDIc51AfJlU=;
 b=NAU6GYyaq4Wb0QHlXhFg7ATfwc/YgfdyT2kNCbZIUZyKk9tcTSMOUVoDiGs1MPG0IQLv4/
 8zqfZ6NmjLZcOgrYbFiwDC6W3bzyzK3v2aq4ZRRWfUfgxCLZ3ovoRB2EtUnGbIZ5I5R0fY
 zOugUACONXcaEweSoP3NwK7zahW9fP9lt58v6r1wcqf9PA+858ggNofyAa0IR8VfC6znSJ
 OQbr4iQDLyAyOP1V0r8B2SHdAz6uaKbGLk96z8yJb78yO0H3SMUYmtxjs0Gb5SzGlKqrXm
 kdNbaaFk/h5R0nB7A9kH5MCUoI1JUVyTMDkNYIRh+e8fBYv4qtzMvOwco6RETg==
To: "Anup Patel" <anup@brainfault.org>
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
In-Reply-To: <CAAhSdy0Fp5R9v1O7gEoVriBBfnSapTgQ52ZLn5+QJOMxnn1z3w@mail.gmail.com>
Cc: <xb@ultrarisc.com>, <atish.patra@linux.dev>, <pjw@kernel.org>, 
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, 
	<pbonzini@redhat.com>, <graf@amazon.com>, 
	<kvm-riscv@lists.infradead.org>, <kvm@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Message-Id: <e26b8c0e-f5d1-4d43-96a9-e4adb46da8ef@lanxincomputing.com>
References: <20260923091658.1421475-1-xiangwencheng@lanxincomputing.com> <CAAhSdy0Fp5R9v1O7gEoVriBBfnSapTgQ52ZLn5+QJOMxnn1z3w@mail.gmail.com>
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+26afbc1e6+0bdfe2+vger.kernel.org+xiangwencheng@lanxincomputing.com>
Subject: Re: [PATCH v3] RISC-V: KVM: Serialize and atomize the IMSIC's TOPEI read-and-clear operation
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Date: Tue, 17 Nov 2026 10:54:26 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Received: from [127.0.0.1] ([123.120.4.67]) by smtp.feishu.cn with ESMTPS; Tue, 17 Nov 2026 10:54:29 +0800
Content-Type: text/plain; charset=UTF-8

On 11/13/2026 1:36 PM, Anup Patel wrote:
> On Wed, Sep 23, 2026 at 2:47=E2=80=AFPM BillXiang
> <xiangwencheng@lanxincomputing.com> wrote:
>>
>> The TOPEI read-and-clear must be atomic with respect to
>> interrupt injection (set_bit in EIP). Otherwise an
>> interrupt injected between the topei read and the
>> clear_bit could be silently dropped.
>>
>> v3:
>>   - fix undefined eflags
>>
>> v2:
>>   - fix patch file curruption
>>
>> v1: https://lore.kernel.org/kvm-riscv/20260923070332.1376132-1-xiangwenc=
heng@lanxincomputing.com/
>>
>> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
>> ---
>>   arch/riscv/kvm/aia_imsic.c | 42 +++++++++++++++++++++++++-------------
>>   1 file changed, 28 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
>> index c1af23e79ae0..c440088651ec 100644
>> --- a/arch/riscv/kvm/aia_imsic.c
>> +++ b/arch/riscv/kvm/aia_imsic.c
>> @@ -607,26 +607,25 @@ static void imsic_vsfile_cleanup(struct imsic *ims=
ic)
>>                  kvm_riscv_aia_free_hgei(old_vsfile_cpu, old_vsfile_hgei=
);
>>   }
>>
>> -static void imsic_swfile_extirq_update(struct kvm_vcpu *vcpu)
>> +static void __imsic_swfile_extirq_update(struct kvm_vcpu *vcpu)
>>   {
>>          struct imsic *imsic =3D vcpu->arch.aia_context.imsic_state;
>>          struct imsic_mrif *mrif =3D imsic->swfile;
>> -       unsigned long flags;
>> -
>> -       /*
>> -        * The critical section is necessary during external interrupt
>> -        * updates to avoid the risk of losing interrupts due to potenti=
al
>> -        * interruptions between reading topei and updating pending stat=
us.
>> -        */
>> -
>> -       raw_spin_lock_irqsave(&imsic->swfile_extirq_lock, flags);
>>
>>          if (imsic_mrif_atomic_read(mrif, &mrif->eidelivery) &&
>>              imsic_mrif_topei(mrif, imsic->nr_eix, imsic->nr_msis))
>>                  kvm_riscv_vcpu_set_interrupt(vcpu, IRQ_VS_EXT);
>>          else
>>                  kvm_riscv_vcpu_unset_interrupt(vcpu, IRQ_VS_EXT);
>> +}
>> +
>> +static void imsic_swfile_extirq_update(struct kvm_vcpu *vcpu)
>> +{
>> +       struct imsic *imsic =3D vcpu->arch.aia_context.imsic_state;
>> +       unsigned long flags;
>>
>> +       raw_spin_lock_irqsave(&imsic->swfile_extirq_lock, flags);
>> +       __imsic_swfile_extirq_update(vcpu);
>>          raw_spin_unlock_irqrestore(&imsic->swfile_extirq_lock, flags);
>>   }
>>
>> @@ -912,12 +911,15 @@ int kvm_riscv_vcpu_aia_imsic_rmw(struct kvm_vcpu *=
vcpu, unsigned long isel,
>>          struct imsic_mrif_eix *eix;
>>          int r, rc =3D KVM_INSN_CONTINUE_NEXT_SEPC;
>>          struct imsic *imsic =3D vcpu->arch.aia_context.imsic_state;
>> +       unsigned long flags;
>>
>>          /* If IMSIC vCPU state not initialized then forward to user spa=
ce */
>>          if (!imsic)
>>                  return KVM_INSN_EXIT_TO_USER_SPACE;
>>
>>          if (isel =3D=3D KVM_RISCV_AIA_IMSIC_TOPEI) {
>> +               raw_spin_lock_irqsave(&imsic->swfile_extirq_lock, flags)=
;
>> +
>>                  /* Read pending and enabled interrupt with highest prio=
rity */
>>                  topei =3D imsic_mrif_topei(imsic->swfile, imsic->nr_eix=
,
>>                                           imsic->nr_msis);
>> @@ -934,16 +936,20 @@ int kvm_riscv_vcpu_aia_imsic_rmw(struct kvm_vcpu *=
vcpu, unsigned long isel,
>>                                            eix->eip);
>>                          }
>>                  }
>> +               if (wr_mask)
>> +                       __imsic_swfile_extirq_update(vcpu);
>=20
> The __imsic_swfile_extirq_update() also calls imsic_mrif_topei() so it is
> better to pass topei value to __imsic_swfile_extirq_update().=20

Hi Anup,

The topei value may have been changed before this=20
__imsic_swfile_extirq_update() is called. Would it be better to re-read=20
it in __imsic_swfile_extirq_update() as before rather than pass it in?

Here is the relevant code:

int kvm_riscv_vcpu_aia_imsic_rmw(struct kvm_vcpu *vcpu, unsigned long isel,
				 unsigned long *val, unsigned long new_val,
				 unsigned long wr_mask)
{
...

		/* Read pending and enabled interrupt with highest priority */
		topei =3D imsic_mrif_topei(imsic->swfile, imsic->nr_eix,
					 imsic->nr_msis);
		if (val)
			*val =3D topei;

		/* Writes ignore value and clear top pending interrupt */
		if (topei && wr_mask) {
			topei >>=3D TOPEI_ID_SHIFT;
			if (topei) {
				eix =3D &imsic->swfile->eix[topei /
							  BITS_PER_TYPE(u64)];
				clear_bit(topei & (BITS_PER_TYPE(u64) - 1),
					  eix->eip);
			}
		}
		if (wr_mask)
			__imsic_swfile_extirq_update(vcpu);

...
}

Regards,
Bill

>=20
>> +
>> +               raw_spin_unlock_irqrestore(&imsic->swfile_extirq_lock, f=
lags);
>>          } else {
>>                  r =3D imsic_mrif_rmw(imsic->swfile, imsic->nr_eix, isel=
,
>>                                     val, new_val, wr_mask);
>>                  /* Forward unknown IMSIC register to user-space */
>>                  if (r)
>>                          rc =3D (r =3D=3D -ENOENT) ? 0 : KVM_INSN_ILLEGA=
L_TRAP;
>> -       }
>>
>> -       if (wr_mask)
>> -               imsic_swfile_extirq_update(vcpu);
>> +               if (wr_mask)
>> +                       imsic_swfile_extirq_update(vcpu);
>> +       }
>>
>>          return rc;
>>   }
>> @@ -1050,9 +1056,17 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vc=
pu *vcpu,
>>          if (imsic->vsfile_cpu >=3D 0) {
>>                  writel(iid, imsic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);
>>          } else {
>> +               /*
>> +                * Serialize the EIP set + external-irq update against t=
he
>> +                * TOPEI read-and-clear path so that an injected interru=
pt
>> +                * cannot be silently lost when the guest acknowledges a
>> +                * different (or the same) interrupt concurrently.
>> +                */
>> +               raw_spin_lock(&imsic->swfile_extirq_lock);
>>                  eix =3D &imsic->swfile->eix[iid / BITS_PER_TYPE(u64)];
>>                  set_bit(iid & (BITS_PER_TYPE(u64) - 1), eix->eip);
>> -               imsic_swfile_extirq_update(vcpu);
>> +               __imsic_swfile_extirq_update(vcpu);
>> +               raw_spin_unlock(&imsic->swfile_extirq_lock);
>>          }
>>
>>          read_unlock_irqrestore(&imsic->vsfile_lock, flags);
>> --
>> 2.53.0
>=20
> Regards,
> Anup
