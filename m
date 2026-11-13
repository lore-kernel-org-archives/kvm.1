Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794548177;
	b=5VlBt5jdBLmHilTKZgCUitmE50Qyi8NWASDpfWktsliw+mqd+iTWSoJFCuC11oSKwliM
	 9MG++Vwo2v0E1wVXXzWvUR1Tcs5+cYRHiiLTuypolfwJiq/2fgLQgLNqX5v0TMljxyVyl
	 RD92nzL7AEhYKYoU9u/OU2gMJRqiZgVfF1Kga0oMfgiKAc8M3AHcwYV3458k0X/ieIfMg
	 OqLpPzcXJlvmlY3KrByswfZp/Rq1e9efVNW50/nj+WAS48HzjWXH1HJiWQQxpOW3ws3Ef
	 Q2pW7aaQbZKvi43OWPbwYEnCHFNzIcQg/d0D7y8x8Z1TnWtke9w+GtRXog0fLNkcltQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Asn5k3wB77QNm+ii4GqJgfJg46vBWMInhGMAcW/l5U0=;
	b=B0R08x31y1Ym79+sEipns8RxmwK+ZAcONcSk3cHRgk7ZY2wrkMjytNp+QHYYnJUWSx6X
	 m+xxae188utXYUxyaen1PytmHEw/uaMg1RjF1SVzKGEHV3I4Zjt4VTapJvYZRaLEPyg1V
	 xkh15NdFh2yXBmciAmOvcx2714efbLCXJUNWPw1oPIb9HC2B3SE68hvqSjhAkLcGn+6tA
	 jxCvEiu9hPZ0D213V614MHwLZ+S54u9K6hf5FxLDj+bkgUQhrLQ60H9+CEtmgnw1fnqz+
	 sAhFH1VXVk7WqdF0pHvUDrWdtz6J4JDjeh+WudMzXBfJRAKLkCeuu0L2coc5yB80iBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=QjTBOvyJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BAD606A32E
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0BAD606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=QjTBOvyJ
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so7138825e9.2
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 21:36:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794548175; cv=none;
        d=google.com; s=arc-20260327;
        b=jHEeAbzmTEmEAr9Yx16Z3qX3Dc0ifOq4SJQU0FZWnQoxzrt0xXQHg7CC/pmBhVdnEr
         2JtUCxQcwkn2ixbNi0mWokIjrPzwPJluOCOXdYZ57/cgBdSacGktW94cD2QE/gtNr2Of
         DbSejlGqfJ5LVPMjvMF6krpaQq2TT30RxG5GNE+ZH2fGEbFMDHZr5UJGw+NUfp4Hyfzg
         2TPkUlDOjLI0SI/HnCJpxm+i8Tq6bQ97Yu+wp4LV9Onv6+ncnnekC4mCjkNr6XzKGFY1
         1Py9YOW2zBRKrVyNkiHLbDCsPxPHu7y21z28vKu9Up1QYp0ixUNq6rTpLpgTg9tac+Dc
         o0eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Asn5k3wB77QNm+ii4GqJgfJg46vBWMInhGMAcW/l5U0=;
        fh=sFKRjREN0belhpz39/QG/ko5FSdG5siFbaDiE1qW/8w=;
        b=P8VP96U1P6K2PSIDzVnatgZBZOBHrmdTi3Mp+Rh0jPEx4+sa5XLsrHjY+kjR+RtuCd
         tpeLOFkue3Kq2uKVoWIMOEuuS0UYPap9BEVE/IEmZFYEHTACgCiPakqWL2VvEHHU3VEw
         gwjRuL5VlbFro8YSjyEfNlAeZSbNu8yNZvoMnXLxqkTdcpHKUfUIIAi5DWnnztIHnDoS
         afWgnLt2xh8SOthha5wFQVby4iR1i7Iyk5u9SJi9f2tF5YEv1LhofM2Immxo409SYUW6
         60DPXBC6b9ykZZsJZagD/5E+SLx4P5F6oXHOv2jDd/axfC6o8Vf3HmQMajaMQe3H7Kk4
         lWIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1794548175; x=1795152975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Asn5k3wB77QNm+ii4GqJgfJg46vBWMInhGMAcW/l5U0=;
        b=QjTBOvyJvwyTWvQ7fi5ObNrUO1Wr3gd+m3ES7oW4jzXaXXBxX9l5QSHSIPC3Kp6H4u
         z4/kLkujsOGxCPvgPxkhAg0o9G4SZbcID7VUSNZZeF83QaOM0JHWfT+CPS79Gkjy96aH
         GWWoC47j8ym5do2l9qTj1hA4NIbnbuIiQmYDGitUlr6wX87r+gQdsz4T+eMw69Ah/BBt
         IaCBgOvPmZDLJelqYV274qMHO4y9qWTVQGpOW3mSsXSs57uZPPDLq/5JeRz4cDXRW6ZM
         tnNIA06XvBV0hmbBP89yVhvaum/mA3+9IS8TpNpSvAd+xE+GKXNHtCFxLXBO8roJNp8O
         SIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794548175; x=1795152975;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Asn5k3wB77QNm+ii4GqJgfJg46vBWMInhGMAcW/l5U0=;
        b=WBLwYwJL1gnmFKNgvYCDR+n3KoSAqi2FG0kiy7xRlFoBX7tU7xrui7ZpjUMdxNrmtV
         modmSzOw+belg8Usol8RoMmsplmDP33MQ0tgE9ebIzJFMp8LPcvC0jCbdwvztrohWwZv
         amV1n0VUmhU+9aBYM7CPsqvXELCcvfKrdM9ZTzN7EGpeQlsQhH1Z53MZPwaRqba/TJr+
         Sqf8ziD4nLVLtXQJXkK9W0y/Oi+bKq8dD94yDaAlXppYv/mn5VEsaUAFIiYWTqAucNmf
         KgFXiFZx+KNGvOBNQQK3a3k6/7cPUeEue8I+jB9CqAKVsmbxlpBu/X8dMWOIYrs+Hz/G
         GIfw==
X-Forwarded-Encrypted: i=1; AL+hErGLQRs10sZXBHtNPWDPCy47eQ4jdryvYe8kow91vw/ANjYi3MOdj2w1AoHwVPNtQ0NW06g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rfnno2mOP7eaqpQ7a1jV25NaXwS7K/48m1usjnf+YOzu2wqc7
	WZi0aUI1FjQ84apmqXdAnLbCDmsPSMlDYgKV4mG/QYl9oFZVqaZ9WhFAEovcS2T/l0f0xby+aJK
	FL4s4ZE2LNyP92hJEY/XeYx+SzOQRHEpLWazBtFLSxw==
X-Gm-Gg: AYBFou1ZDK8015PAtGiOKNqmi2Y3V6Fl4aPaCsti211duynMNID8zDF7U5f0XlZlWjT
	YvTekX1gWp3AlWpjEIjhnofRF4J7o1CFKCwSCc0hTNt86oN/N+RI4YlgSyqZh36i107zxU0Agf0
	kZ17Lp9zt9MRcfsqV2RuK7ar1jXBNG5zQxfo8WDhmcd134pB1oVhEInM4Vds/bmJR80GGhJCon2
	B5T+8JNzehKQ469nonqfcZKjefz/wPReEf2yV6mKMa79J3+JRfE2asUysu138q4Ftnvsr6X7NDl
	rvjbjnxcxJ2Xk8IZqt2OYEPfXp+901xJiU+UEd9sHXMgijfEUvrjdltGWMv2ZE2gnZ/WBhl9MrW
	AA6aLbPAd0uyUGf4L4LQXDFuZmksuYvHMb83XUrtmFgXPK2IH7P7eS6VWeJVsTptQT0hBsz0nqP
	L1T5EQMhzotYK2TCqV/cc3ep7PsPvyuNAh4VndyZMMH/qwQ/zNni/PEdob
X-Received: by 2002:a05:600c:8909:b0:4a1:f720:74cd with SMTP id
 5b1f17b1804b1-4bb55a83e95mr22775035e9.24.1794548175140; Thu, 12 Nov 2026
 21:36:15 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260923091658.1421475-1-xiangwencheng@lanxincomputing.com>
In-Reply-To: <20260923091658.1421475-1-xiangwencheng@lanxincomputing.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 13 Nov 2026 11:06:03 +0530
X-Gm-Features: AclHuK-hB4uNWUkZ5GD6or_GmOhWyIPCmKZQ4zfjMNF_IuFbt8PDj-n3XQqHnik
Message-ID: <CAAhSdy0Fp5R9v1O7gEoVriBBfnSapTgQ52ZLn5+QJOMxnn1z3w@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: KVM: Serialize and atomize the IMSIC's TOPEI
 read-and-clear operation
To: BillXiang <xiangwencheng@lanxincomputing.com>
Cc: xb@ultrarisc.com, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, pbonzini@redhat.com, 
	graf@amazon.com, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 2:47=E2=80=AFPM BillXiang
<xiangwencheng@lanxincomputing.com> wrote:
>
> The TOPEI read-and-clear must be atomic with respect to
> interrupt injection (set_bit in EIP). Otherwise an
> interrupt injected between the topei read and the
> clear_bit could be silently dropped.
>
> v3:
>  - fix undefined eflags
>
> v2:
>  - fix patch file curruption
>
> v1: https://lore.kernel.org/kvm-riscv/20260923070332.1376132-1-xiangwench=
eng@lanxincomputing.com/
>
> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
> ---
>  arch/riscv/kvm/aia_imsic.c | 42 +++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
>
> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index c1af23e79ae0..c440088651ec 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c
> @@ -607,26 +607,25 @@ static void imsic_vsfile_cleanup(struct imsic *imsi=
c)
>                 kvm_riscv_aia_free_hgei(old_vsfile_cpu, old_vsfile_hgei);
>  }
>
> -static void imsic_swfile_extirq_update(struct kvm_vcpu *vcpu)
> +static void __imsic_swfile_extirq_update(struct kvm_vcpu *vcpu)
>  {
>         struct imsic *imsic =3D vcpu->arch.aia_context.imsic_state;
>         struct imsic_mrif *mrif =3D imsic->swfile;
> -       unsigned long flags;
> -
> -       /*
> -        * The critical section is necessary during external interrupt
> -        * updates to avoid the risk of losing interrupts due to potentia=
l
> -        * interruptions between reading topei and updating pending statu=
s.
> -        */
> -
> -       raw_spin_lock_irqsave(&imsic->swfile_extirq_lock, flags);
>
>         if (imsic_mrif_atomic_read(mrif, &mrif->eidelivery) &&
>             imsic_mrif_topei(mrif, imsic->nr_eix, imsic->nr_msis))
>                 kvm_riscv_vcpu_set_interrupt(vcpu, IRQ_VS_EXT);
>         else
>                 kvm_riscv_vcpu_unset_interrupt(vcpu, IRQ_VS_EXT);
> +}
> +
> +static void imsic_swfile_extirq_update(struct kvm_vcpu *vcpu)
> +{
> +       struct imsic *imsic =3D vcpu->arch.aia_context.imsic_state;
> +       unsigned long flags;
>
> +       raw_spin_lock_irqsave(&imsic->swfile_extirq_lock, flags);
> +       __imsic_swfile_extirq_update(vcpu);
>         raw_spin_unlock_irqrestore(&imsic->swfile_extirq_lock, flags);
>  }
>
> @@ -912,12 +911,15 @@ int kvm_riscv_vcpu_aia_imsic_rmw(struct kvm_vcpu *v=
cpu, unsigned long isel,
>         struct imsic_mrif_eix *eix;
>         int r, rc =3D KVM_INSN_CONTINUE_NEXT_SEPC;
>         struct imsic *imsic =3D vcpu->arch.aia_context.imsic_state;
> +       unsigned long flags;
>
>         /* If IMSIC vCPU state not initialized then forward to user space=
 */
>         if (!imsic)
>                 return KVM_INSN_EXIT_TO_USER_SPACE;
>
>         if (isel =3D=3D KVM_RISCV_AIA_IMSIC_TOPEI) {
> +               raw_spin_lock_irqsave(&imsic->swfile_extirq_lock, flags);
> +
>                 /* Read pending and enabled interrupt with highest priori=
ty */
>                 topei =3D imsic_mrif_topei(imsic->swfile, imsic->nr_eix,
>                                          imsic->nr_msis);
> @@ -934,16 +936,20 @@ int kvm_riscv_vcpu_aia_imsic_rmw(struct kvm_vcpu *v=
cpu, unsigned long isel,
>                                           eix->eip);
>                         }
>                 }
> +               if (wr_mask)
> +                       __imsic_swfile_extirq_update(vcpu);

The __imsic_swfile_extirq_update() also calls imsic_mrif_topei() so it is
better to pass topei value to __imsic_swfile_extirq_update().

> +
> +               raw_spin_unlock_irqrestore(&imsic->swfile_extirq_lock, fl=
ags);
>         } else {
>                 r =3D imsic_mrif_rmw(imsic->swfile, imsic->nr_eix, isel,
>                                    val, new_val, wr_mask);
>                 /* Forward unknown IMSIC register to user-space */
>                 if (r)
>                         rc =3D (r =3D=3D -ENOENT) ? 0 : KVM_INSN_ILLEGAL_=
TRAP;
> -       }
>
> -       if (wr_mask)
> -               imsic_swfile_extirq_update(vcpu);
> +               if (wr_mask)
> +                       imsic_swfile_extirq_update(vcpu);
> +       }
>
>         return rc;
>  }
> @@ -1050,9 +1056,17 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcp=
u *vcpu,
>         if (imsic->vsfile_cpu >=3D 0) {
>                 writel(iid, imsic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);
>         } else {
> +               /*
> +                * Serialize the EIP set + external-irq update against th=
e
> +                * TOPEI read-and-clear path so that an injected interrup=
t
> +                * cannot be silently lost when the guest acknowledges a
> +                * different (or the same) interrupt concurrently.
> +                */
> +               raw_spin_lock(&imsic->swfile_extirq_lock);
>                 eix =3D &imsic->swfile->eix[iid / BITS_PER_TYPE(u64)];
>                 set_bit(iid & (BITS_PER_TYPE(u64) - 1), eix->eip);
> -               imsic_swfile_extirq_update(vcpu);
> +               __imsic_swfile_extirq_update(vcpu);
> +               raw_spin_unlock(&imsic->swfile_extirq_lock);
>         }
>
>         read_unlock_irqrestore(&imsic->vsfile_lock, flags);
> --
> 2.53.0

Regards,
Anup
