Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558392;
	b=vy3sCQESyERxgHZdHDTLoxVo/jp5ko2tWOVLv+WaNXZY2GEmPccFM2raKPDRROM4tFhx
	 HjVnd+1YtU08ORV1Si9tncHpc8E6qzdI35yF+zQdJ/vl9t912Qv/7ar7dfgGLtnis2/K/
	 5UNRJFMbq18HG3fFRuqdYowkGyCtXMytrBBc/c7UNwn+JRjQYSoJb5KNcYVOySEhALjTC
	 Mu4nUxQ2acWr04MWZ4tU/3aivfp60vrph0Z5RaS9qhVcBC8LIrFVuvRDxx2eYWNJs682z
	 mq/2crsh1JNP5ibqrXP+BmLgV4hHrZsdk/W2tI5bihmVziucqxDrFDW345qfYnm5Mzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558392;
	h=DMARC-Filter:DKIM-Signature:From:Message-Id:
	 Content-Transfer-Encoding:Subject:Received:References:X-Original-From:
	 User-Agent:To:Cc:Date:Mime-Version:Content-Language:X-Lms-Return-Path:
	 Content-Type:In-Reply-To;
	bh=8ix6MDEBpxMuClm/bHkXYW8egmY9AdoXZ7WOLRic6sg=;
	b=EWYSudmsqJGFawbft8SsYbP3K5y2p0TMU+xQOASiBYbdreGP2YXk9wDZJnjQ3y+CjPIq
	 u6+p1J+9VFroja/DSNGufqlL/epKrMOD1+5oj1z45Pk2rg5uoZtqsisXPAYgr+yFJ0iQm
	 tbQRXqwDt65lOMvhfNcsDBzkkkhn5CU9FJB6IG51VbQjSPSZcofLlfpLjM23O5XPEnxKD
	 LHSwCzQOf+3lh870SWVOdfdvrl5SfUpXerY7fXbG/b6wRKTQA1wv61xDpsxVbi7baSQFq
	 KuYAP3KcvGnd0oDwwABBA9CUvjbkJx0M1fuiLagT6LY+eUphYHq3s4uuuLWQLkHQYTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=lanxincomputing.com;
	spf=pass smtp.mailfrom=lanxincomputing.com;
	dkim=pass header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=mf38MYzA;
	arc=none smtp.remote-ip=209.127.231.60
Received: from va-2-60.ptr.blmpb.com (va-2-60.ptr.blmpb.com [209.127.231.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFE5606BDCC
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 08:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DFE5606BDCC
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=mf38MYzA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1794558387;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=8ix6MDEBpxMuClm/bHkXYW8egmY9AdoXZ7WOLRic6sg=;
 b=mf38MYzAzl0pibYpc0j8nPR+w19nWeetphEHkx3iDPIV+m6GvX6obct1Ps7eCYeyxruUrm
 W2tXXTBOj/gSK12lrR4LYiqSOT5plkGGrwRe+KBYEsN08T10zXpaWlrqMvukez/95/1vrH
 ZQZdvfJgPQtevdDqvAoPbTTH2EYan5csnsRP2a0W1TjaxTp6be9J2W+X1vvQBq7gHmzbpg
 n2n0mLiX+Qum8POFRUmt5hLuXpwu1llRKvDpUssuia9UHQLfSpwqJB4MAZYIrjjpXJGMh1
 3kvVBj/hIDSzm6hzWvKjsW9bEdyyUJe4sRsm13echE0t6v7Z40fa8YNqu2XNng==
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Message-Id: <7434d1a7-c5d8-4d97-a8f6-ab9bf881d299@lanxincomputing.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] RISC-V: KVM: Serialize and atomize the IMSIC's TOPEI read-and-clear operation
Received: from [127.0.0.1] ([123.120.4.67]) by smtp.feishu.cn with ESMTPS; Fri, 13 Nov 2026 16:26:15 +0800
References: <20260923091658.1421475-1-xiangwencheng@lanxincomputing.com> <CAAhSdy0Fp5R9v1O7gEoVriBBfnSapTgQ52ZLn5+QJOMxnn1z3w@mail.gmail.com>
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
User-Agent: Mozilla Thunderbird
To: "Anup Patel" <anup@brainfault.org>
Cc: <xb@ultrarisc.com>, <atish.patra@linux.dev>, <pjw@kernel.org>, 
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, 
	<pbonzini@redhat.com>, <graf@amazon.com>, 
	<kvm-riscv@lists.infradead.org>, <kvm@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date: Fri, 13 Nov 2026 16:26:13 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Language: en-US
X-Lms-Return-Path: <lba+26af6c9a9+b8342a+vger.kernel.org+xiangwencheng@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAAhSdy0Fp5R9v1O7gEoVriBBfnSapTgQ52ZLn5+QJOMxnn1z3w@mail.gmail.com>

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
> better to pass topei value to __imsic_swfile_extirq_update().

Thanks for the review. I'll incorporate it into v4.

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
