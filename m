Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F4230B525
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777449054; cv=pass; b=UAfhGEEAmkIsl7BjjwICn/GUDYSdv+G1IuhY0BxDEpzbdS+DdKtTCbEEu2ddGPqzlQ/N6G3CHfhONytd5EmpHZT8nLpdOoKaVky5Im4PeY3/rJOq8XynFCcl3MJ5EbQmVIFgg/CLwlfa9TEI4f9Toj4DBfYmd3D1ZvMyWIrx1xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777449054; c=relaxed/simple;
	bh=5oGfP1CK+T7BtF/H8oVuh10E0upA8xqiMEQy84c/s8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7BW+R5w4ZixfZSqpBt8Dm/HDg5uYaddK6qxng23pXYTj7I8qGMv3ELmMD2Sz2yT9vGAKoONVYekjWoGDCh6AS0AdMIYKuIJVl7xx5pA9buYWvOLo2DXOdVoNH6L8IZPFlJJr22xuMcVviFyqRb9u38NFdgw7I0VJf3CrhmO/h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ROklb5gr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpLmP3H1; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROklb5gr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpLmP3H1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777449052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ksLBVehtFHHLiR0KtMVjgdkZVMmaOTDo6Lxsl/DgE0A=;
	b=ROklb5grJSKJS+oUW4HmIveCbg6xmY3XIxI2Nj4Bc3WzAqRKb8W+4sI1JzbSMKyUMfPsn7
	q01EX8gsMQMMDPLfMTN26T994cLFqsva0UVckwnGUvhqXi3aH371vh9CBhqlT5e8QgNaQw
	F0grydMHHFNEz7jGjbJ4+XaNVPgezTs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-4Mpy9iGZNfePEc-QLx5r1A-1; Wed, 29 Apr 2026 03:50:49 -0400
X-MC-Unique: 4Mpy9iGZNfePEc-QLx5r1A-1
X-Mimecast-MFC-AGG-ID: 4Mpy9iGZNfePEc-QLx5r1A_1777449048
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b24cd2e2b3so112905465ad.0
        for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 00:50:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777449048; cv=none;
        d=google.com; s=arc-20240605;
        b=AFTxD+I8poREeapUemg/Zan//bbj4c8Ts21a4+q7boGpvtXjBB80i85/D7qMST3YCy
         64iMzCI3O7kqBXfuiwcU/yWL8P4Z2o1Seifmouq63FQUIsKmyDKrXoo+H8hRb/8ABPwK
         wc8g1MkM5HmWPZoU9ol2558ckLZQn8AB3+W8JcVsTbJ3QYpxs3cXjV564bL7Mn8JX5vt
         j+3NOLw2j4v5GEhiDXiCAjHppEUI0HdARjcIMLvqqHpkMetr0La2foGYpImGcrM7O+AB
         Lp1bg97GMwv0HHB21DHmrRZUFPP8SxgSg9jy0PKhLHxdJI5R5eiUOupK4byUHGAMdskW
         E6lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ksLBVehtFHHLiR0KtMVjgdkZVMmaOTDo6Lxsl/DgE0A=;
        fh=oyx9pWeZz99WQ+13uUZpVBRwr5PIuHPyz0tJwG6CV5Q=;
        b=I3C8zJwEoqb9ZzkNi+zjbHejp5Hy2IslgDA3WX8bJh70QM3XV2SLdxgHWfKCUhMRYA
         FYQL43YYyfdOVD1aAif/SL8B1/6DwLNxV6ZbIvhirSC34mZNdzMu3LNi4JYnzBOkuWCp
         2zYFT4XF0XZzgiRwxl2+xCLyoHMkNw4tmya1WQKz2TdinTKj6SlGqq+AD3dLgFUQx/3M
         wDd0odqE4drSm6SpKJEoYCJibIj8MrGqIzzivDU+kvTEYtD6FSbpp+nziShCjP3375y6
         XrxO8cvvH4obrs5RSQgRkn9Uy50Uq9WXcx0U1P5t0AvQo+WlkBxqBQUaS9p6Hij1C39l
         QkkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777449048; x=1778053848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksLBVehtFHHLiR0KtMVjgdkZVMmaOTDo6Lxsl/DgE0A=;
        b=fpLmP3H1HQSerH/0ptyQa2dWq9N1lldwIsWhphKZjPM43tqKS2vZu+jDiIjpZ4+ONs
         PgNJb9mBxctR8SWCsX0PSf/5SJarJrgbXm5DIV282ElTgPgyzB08csVMBYIbSMb8FQQD
         chX6XwG8M2SGmhPY6k2YVoeQInRHQ8GpUYVdIaoDma7TuJr5GBZ7FqWxX/bQt+b4SsLf
         zX2tYSpR8ii1RYuRdu8WoSc0F/KCAExd8nuepVKR6OOAPp4tBZuaYzoHYYY3m9MPc9mO
         O+qJSJCuvQLCYlWwEVYdVPd+CKn6xUNn3kGFG4+EtcYnQtzL9ku/TgGZ0lWe8szjiNtA
         iLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777449048; x=1778053848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ksLBVehtFHHLiR0KtMVjgdkZVMmaOTDo6Lxsl/DgE0A=;
        b=U5QFXr22W8xHaAun6m3NeXNmNpe1UVSq6gqdy52mBB8qusVvmSXFGuhX4Ch2cEyHLv
         wRV5uDkO6W++JnjpZ38GtMMAZwBljBOsMCb++DBEaJxpTYOhOxpp/IhLI7YgS/oCz9HP
         K0CoqdNdSKvUgo3funIwO+rwRxWbuqQp2cIEHC6neOhrDZSa99vn/jWE/tZijldTvzVY
         ifSTe3YCebbdDPQkQ5F8TlOqMTg6TKPwcdHTDxEfTI0ULlobmJK7HaDphetyd8cYHvSk
         d6nHMn8lKseV3jQyq9UB2N2HpefuOeYsFUTICGZo+yvta92csEjNFRmZOmEgN1E7wbjq
         VrgA==
X-Forwarded-Encrypted: i=1; AFNElJ+kecYwUPLdssu6p+5n4OdUUcgbo9elC+KjEM0XsTQLATLozrENEQeGRLU+RoNkBZ3Kb+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAbsR/Tz0lRclEjSxPfcylMGxrQAVWsNVnpruEsYWHJgyZVGJt
	LUt+11OSlvimvWutXhfAThsU8savmjUlbkGxSql/ypBFdIdNa5oBnaYPcIhPFaZAZk6+t2F1k2W
	AiJOP7XJrqGx/menbZI455+SraBx1YEwDiAiKSrD6Rlo65HVFTfhzWOPUNGqo1OnmKcGZHfUplj
	STAdL8eRuJlnMMpbXN7qM9boEZAqAe
X-Gm-Gg: AeBDiesX4oQuaI2GH36Un4ZIXfOaeI/Pbnoul/+5XtNSGibrXm+KyJ/Eok4sGn7oXUY
	WAzXUt4Pdz5l2zm5lTBBPI10BGPK5XhqtNqEDl9ZviguI3zUQLyL1lPCqEg4kpHpRwL4xdDE78N
	hwFLbouT5tWMGW6BXmPMrEdw+/rD8lxUFT7idRhsAgknBa5bIf2AN9T34nh6gQt9iHNCl0lOUM7
	cuEqSNXyTGj0nDhrasIghdkaD3HMHAMs6a9DQpXAP1HpmfV7iqtI6fh1DbQSfF8Vuht9XcKbxnf
	DkfJyvZ77IogVD4=
X-Received: by 2002:a17:903:283:b0:2b2:b117:1e1b with SMTP id d9443c01a7336-2b97c41faacmr70109025ad.17.1777449047902;
        Wed, 29 Apr 2026 00:50:47 -0700 (PDT)
X-Received: by 2002:a17:903:283:b0:2b2:b117:1e1b with SMTP id
 d9443c01a7336-2b97c41faacmr70108755ad.17.1777449047451; Wed, 29 Apr 2026
 00:50:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428050111.39323-1-chang.seok.bae@intel.com>
 <20260428050111.39323-2-chang.seok.bae@intel.com> <6e67df0e-e5f0-43f5-aa86-22e8b01b75d2@redhat.com>
 <c87d863b-e053-416f-bae2-6960b4b9d0fb@intel.com>
In-Reply-To: <c87d863b-e053-416f-bae2-6960b4b9d0fb@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 29 Apr 2026 09:50:33 +0200
X-Gm-Features: AVHnY4IxYI7oSGTYgBH2ha5fgC_OMxrOhW9MwjtJaqDmfvCjiv_ybICx-f1W7_0
Message-ID: <CABgObfbgt35yN+o4w_D5U8A7QKRWxiwEtUuzzK39eScXNa4EfQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/20] KVM: VMX: Macrofy 64-bit GPR swapping in __vmx_vcpu_run()
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: seanjc@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 10:12=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel=
.com> wrote:
> On 4/28/2026 2:03 AM, Paolo Bonzini wrote:
> > I would also consider using inst.h's name-to-index conversion:
> >
> > .macro LOAD_GPRS src:req, regs_ofs:req, regs:vararg
> > .irp reg, \regs
> > #ifdef CONFIG_X86_64
> >      R64_NUM reg_num \reg
> > #else
> >      R32_NUM reg_num \reg
> > #endif
> >      .if \reg_num <> REG_NUM_INVALID
> >      mov (\regs_ofs + \reg_num * WORD_SIZE)(%_ASM_DI), \reg
> >      .else
> >      .err invalid register \reg
> >      .endif
> > .endr
> > .endm
> Yup! Also, looks like still needs the REG_TYPE macro:

I don't think so, you can (and should) assume that \reg has WORD_SIZE
size (i.e. disallow %eax if CONFIG_X86_64 is set).  Only CLEAR_REGS
uses smaller registers but it does not need the reg_num.

Paolo

> .macro LOAD_REGS src:req, regs_ofs:req, regs:vararg
> .irp reg, \regs
>         REG_TYPE reg_type \reg
>         .if reg_type =3D=3D REG_TYPE_R64
>         R64_NUM reg_num \reg
>         .else
>         R32_NUM reg_num \reg
>         .endif
>         .if reg_num <> REG_NUM_INVALID
>         mov (\regs_ofs + reg_num * WORD_SIZE)(\src), \reg
>         .else
>         .err invalid register \reg
>         .endif
> .endr
> .endm
>
> Thanks,
> Chang
>

