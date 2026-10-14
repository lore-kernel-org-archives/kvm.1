Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097474E36D0
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988846; cv=pass; b=VBWWXZOYpuGonehzPgcf0jMFfSZxZD5ZT1dqu9kAGd4bESeidNg7pNo/f/wToSNV6oHeAGadCtz801cWMJyHVUh3ePTbNTAdRup8jB6QtkYj24Dmc0xMm6YpfxF44g7HRPFcxyKsk17P4NFy+VibPKekXyYcvIRe9pDceZMg0WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988846; c=relaxed/simple;
	bh=MxFG1mZktrMoElvMC0UlvjvWr6avtnQPc6bd059hWM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/VLunms/dUoFfU4Hcgv9zyLIyBcfiud0SfCJxGqN/nS4+kIo2mQ32o6o7iEAXZ81eQSlTQHtyNNeTiaJHCwn4oPz6W+W7VFKe3L8kfqi99z5r1pGh607/2TbZsSb9cpIF1n6/ZWF6mu/V3su0TeDOuwjrSJf2hXTmlB/8z54ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UCCBpXnH; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UCCBpXnH"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso40466a12.0
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 07:40:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791988842; cv=none;
        d=google.com; s=arc-20260327;
        b=bBfLGEnicTXCYf7D3B3kK6kDG0m6VlxZTe8oNvH4j9oiHZyxJUnexx+2r6re0Y5dU1
         FaiK9LfdDFaDdngo8iUQduXS3Fn7dZ6bCPe7Dcul2vhBy/vzBbKfwLiRXMxsPdhFJTaH
         kqkuGwwCyGWZQLYsYjVrwuOoB/46CUcdS+FI3GswCbapstrMaJL/9Ov5EeDt7RMV+iOP
         BC/qI5hxm7WZlN45fE2VsuCLjMguPx66BU0h00Wu0pp34VXlqTeKreORQ4k139sQom7K
         1xtf8N8hbeQMpyMWpGMQ+uYUQDheccIdZNwvIMkJV5Cv70G7zWapH7dxi9W9sq9j/33J
         STWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o+kqtSVBBM78ciUCA58cO4YtlpbL6uVSQYurfCH4pKc=;
        fh=njNSVFqUjxUUyMBQm5veb+f92Hc9mkNYBtSN9Ai6vkY=;
        b=f35Mct103pf5ehl84fSkNZ6H856ZBM6GiCgctjCibJHVntkAN/ckyVLFz/C6XO7h/B
         9oDIBP1M4W/MoDOmMjs9abONtZJWAhRuM6+Z1Jrzp1j0wwMNssk6yd16QSfLbJ3Ew9og
         jPTdl1gSe2GqzT4Y1bH2meG9NQ69/lefHuMi7qPEwpE6cZvd8PjvXBfrOT/a77NlPVu/
         26dqDM0uCIk9O6K3jEfjt0XA1UeZKmZd03YsQZ/ucEgObK7Omz2k96Ipze7wlkBpI9bD
         c+gQzHIaA6oDwE1EraAAh7aQvFpGcFK9zSe4UQfWQ86OYbnLoxribAc9tQXDgNufhFLJ
         kUFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791988842; x=1792593642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o+kqtSVBBM78ciUCA58cO4YtlpbL6uVSQYurfCH4pKc=;
        b=UCCBpXnHIIaZ0glcDUn+ikmOb3uFCXkJL0A+3AG6yTHyAwIipUmN0Qknyn5K/suHfp
         dRyqS1teWFl3PaQ0BoEn+ht0Xq3tRn8c8LseRiDLppaKomsYLwPwhZQqfniMHOWuBZh/
         lyG4IY8ScwWFlPS1CcpaFxUO4S2ZRkkt+w5YBoTwRuXdZ1l4V1Np/pZ3XPbEFcp+yrrh
         VpFX49/jFCQU9KCYBC/G7rAhn4jhZ1eIXm88N2qAkZb21jKIiFJK6Y8zAAZLN6Xn/fel
         99YGc4oRGQYBp07ptKINC/YavnkJx/7mPcuIt53KT3larzcg5ZfbfvOrFw9Zq6nckHKr
         w7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791988842; x=1792593642;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o+kqtSVBBM78ciUCA58cO4YtlpbL6uVSQYurfCH4pKc=;
        b=IasX/19lnjvU+tHNYDIVaF1T9uHgcRPMCg2bL+V69/whIs8D8KRNezsbx3NmfRoSKU
         nJlmUFJ2ag2mu6rm+3MF5LlB7LZGcTV+i5sKiFR+eNE36Dp9qwcyYPsuy+RzMM02PPXn
         +ge9Yjgu8i0XZTD1yNIBvM7F1fJB41tLhK/CWw43nrIUNdId0vQcEctj6sdH4x9PyFfu
         HTly5uP7rbkv4w5jheHGivQlyU+UrDeGqGubxoCqDEQDjVhNL2LhtvcbmI1lq7HZq8LI
         XgLGV2aht/BiLejqclCt3MpKZQq7RZRQK4TBEky4ylbhWgZuwgkhoJy8eFxqGQDgKZwh
         Idsw==
X-Forwarded-Encrypted: i=1; AKwUvBznwI4ZZf2IJbTHmLuHi4fk6rvzyTyXmH59FQCBSuUX53zTO/JYuCcWhMhLva5K4jvSCQg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJih4jJYhv3W25CJkc6ErNMy6TZQtXhumElDGMqPBpNbmfp4Wcm
	z4Rndt+s7TGRiQzh0pGg38YHggFvRnXrPIJ2TSRE9s0hcNweRmBSHAgmR1fSTuYe5Jk3xNQiHdA
	YOIbcjvjKe8Cy7nbAx69iOilRuBJ0RZHOojor74Qo
X-Gm-Gg: AYBFou0gUEygK6WXR0++9PD4/5MYmXgrFpKjVeGT4mIHRLgVWf8fOSabx6/bwwLCmqz
	sOuNku3CmGqVUIIMiGjMkokfiCoAI44U1qj6B4N8cXVABaFqP8ZRVYtqs8KQGcTG6Dtfhw4uWMI
	6qy1ZRbCWZ09mDmcU5HRsssYRkFD2axk51PG3/CSAWcGhpOeyiHa1VFye3RAfX+8mXNI9s4UxDU
	IsthxBJd4qL6RzvObN09Pf8yY2+vHekiYDYJLUZGxDYkdZhxHEC9FQCoFQkPHF3YkmTL0a+2s8i
	GlJl5I7wxvLEfDmvtYjZVruBsSRc1j1V42e6OQH/7kjSYbItBL1AU5HI
X-Received: by 2002:a05:6402:22c5:b0:6b1:c3f3:225 with SMTP id
 4fb4d7f45d1cf-6b209504430mr53244a12.0.1791988841607; Wed, 14 Oct 2026
 07:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013231728.883001-1-yosry@kernel.org> <20261013231728.883001-2-yosry@kernel.org>
 <CALMp9eQ3mz_EiV4AcmMC2CQZ47s_uf7XCbhnn7pfvVjHwsXdTA@mail.gmail.com> <CAO9r8zMYj=Bxc_8bWh=G__2C0ouiarg-WMtVCdziCvccZTugPw@mail.gmail.com>
In-Reply-To: <CAO9r8zMYj=Bxc_8bWh=G__2C0ouiarg-WMtVCdziCvccZTugPw@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 14 Oct 2026 07:40:28 -0700
X-Gm-Features: AclHuK8QvSQV5JIun9Aw8Aiber8CAgmIN8b8u5LQUwGXpdAYDUmRDzVbMQGTfj8
Message-ID: <CALMp9eQtcCMYiQKKyA+L-rNN9kjNZDhTqtQWF=8VmiaqqSEw7w@mail.gmail.com>
Subject: Re: [PATCH 1/4] KVM: x86/mmu: WARN, don't BUG, when walking a cached
 root with a PAE MMU
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 7:27=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Wed, Oct 14, 2026 at 5:48=E2=80=AFAM Jim Mattson <jmattson@google.com>=
 wrote:
> >
> > On Tue, Oct 13, 2026 at 4:17=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
> > > Replace the BUG_ON() in shadow_walk_init_using_root() that guards aga=
inst
> > > walking a cached (previous) root while the MMU is configured for PAE
> > > paging with a WARN_ON_ONCE(), and terminate the walk if the WARN fire=
s.
> > > Walking a cached root with a PAE MMU is a KVM bug, as PAE roots are n=
ever
> > > cached, but there's no need to bring down the host, as KVM can simply
> > > bail from the walk.
> > >
> > > Note, the BUG_ON() is currently reachable by a guest if TDP is disabl=
ed,
> > > as KVM walks cached roots even if they were created for a different M=
MU
> > > context, e.g. if L2 executes INVLPG while using PAE paging, L1 doesn'=
t
> > > intercept INVLPG, and L1's 64-bit root is cached.
> > >
> > > Add a common error label for terminating the walk, and use it for the
> > > existing invalid/dummy root check as well.
> > >
> > > Fixes: 7eb77e9f5fcf ("kvm: x86: Add a root_hpa parameter to kvm_mmu->=
invlpg()")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: LLM
> > > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > > ---
> > >  arch/x86/kvm/mmu/mmu.c | 13 ++++++++-----
> > >  1 file changed, 8 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > index aadd5bdc2c97a..126faef5a6476 100644
> > > --- a/arch/x86/kvm/mmu/mmu.c
> > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > @@ -2558,10 +2558,8 @@ static void shadow_walk_init_using_root(struct=
 kvm_shadow_walk_iterator *iterato
> > >         iterator->addr =3D addr;
> > >         iterator->shadow_addr =3D root;
> > >
> > > -       if (WARN_ON_ONCE(!VALID_PAGE(root)) || kvm_mmu_is_dummy_root(=
root)) {
> > > -               iterator->level =3D 0;
> > > -               return;
> > > -       }
> > > +       if (WARN_ON_ONCE(!VALID_PAGE(root)) || kvm_mmu_is_dummy_root(=
root))
> > > +               goto error;
> > >
> > >         iterator->level =3D vcpu->arch.mmu->root_role.level;
> > >
> > > @@ -2575,7 +2573,8 @@ static void shadow_walk_init_using_root(struct =
kvm_shadow_walk_iterator *iterato
> > >                  * prev_root is currently only used for 64-bit hosts.=
 So only
> > >                  * the active root_hpa is valid here.
> > >                  */
> >
> > Can you please rewrite this poorly worded comment that now explains
> > your code below? What do 64-bit *hosts* have to do with this
> > bug/warning? I assume that should be 64-bit *guests*. But, even that's
> > imprecise. Aren't prev_roots tied to 4- or 5- level paging (i.e. long m=
ode)?
>
> I believe it should say that PAE roots are not cached, so only the
> current root should reach here. Right?

Right, that's my understanding.

> I can reword when I respin.

Ta!
