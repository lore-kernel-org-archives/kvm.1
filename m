Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7850F35CB6E
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249709; cv=none; b=BJng4Uf62Ic9yiIBLs4QmUl2qXAE3QOLV4MAhiGdeiWtky6oworJmD3pBYUVLwWiWxSVyyejBIciDMMwYmsM585SDngHOMnwWKM8vIWWRNs59wY3Tdi2cQV9BSE5PKGlNHr7vtKgmqqmZTeeD2MY0mhjWtKhuxVALm/Ayh2mk7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249709; c=relaxed/simple;
	bh=I7JQd27zGB4Ebig8E/VetdYeJzIIxW73/4qeDzntcGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAZR68i2rUWsjMOpk8Pxr0qKL0lVnmij4gEPnKbvOh2vGQrgrS2BG27GTTULHFEnQ5yqU621ibSyugglQyuWAntsiOyISQ+8cRec1Bz2Rw9xw2rLw8iOo6uTh05l0wVMHtmcQvEEfDyTzfi6C7+ntWJUGIO6OljSgHcbsmDN500=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3s7iWR8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3s7iWR8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497C9C2BCB6
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 07:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774249709;
	bh=I7JQd27zGB4Ebig8E/VetdYeJzIIxW73/4qeDzntcGc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D3s7iWR89wZfyatx1Fh5dUeZdUxS8P6DQQ3ZkW5I1Q65GQ8H1LdtlByB19m7kQDJ3
	 4JoJL885zZGoy7sJla+xMexKeiefAJCYQ2/CZ9eJqy2LsEb+qLuuDoTFCs/pIQ6F2+
	 pksprdLMfEjbQCW0y3VrBuEEseA3I9xFAaBHNwE8xE00pu46A7ey8vFoA+qWCy9JMw
	 3vSlC2vjUm5o8ke5+N/Ay2pK6l9jRXuctaTt4i1d9KlT32MStteP8oT8RcHyeLp3P6
	 AGLaUfBMnEcdSHg4McTGbte01FosRCJJfZ0mQ7B4IUWN4sJ4wuJBs/IB1p/AdFgV9M
	 sMUDNrIWdCXoA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so609133466b.2
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 00:08:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXogshPI24Pm3SfVk6y6OBXPsZWEivOWHhLx36tJfPfD6BJ1sgQ8GmwjjqgHvLRH0AlOlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVhkSLAbbu9tNSkbkozJw4+qUe4k/0FzoFVzJJIsn8QWF4AKr8
	U5RUaGyWrEcK5QO/8ysJm67GO8ywXd5qFfD3ngMwi2iB2aA2rb5NlNqv+l+ngnZZ6M8Uap1kTmz
	M8Qdcm6yTB+kCZYrdMeaycxq3n/BmBjY=
X-Received: by 2002:a17:907:86a7:b0:b98:3b5d:e147 with SMTP id
 a640c23a62f3a-b983b5df9a2mr718350666b.3.1774249707731; Mon, 23 Mar 2026
 00:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322135346.3720577-1-chenhuacai@loongson.cn> <676198e5-78e4-ab41-e447-4a9d24655890@loongson.cn>
In-Reply-To: <676198e5-78e4-ab41-e447-4a9d24655890@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 23 Mar 2026 15:08:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7rFtju3k=NYkAy6-O7f8U=CTNiryu2_Kr57pScjeH-yQ@mail.gmail.com>
X-Gm-Features: AaiRm50Nqh46-k27BJ4OMuRIjKm603Sh-BaWcnA_C07nYZe0hy1pIZa-KVIqTeA
Message-ID: <CAAhV-H7rFtju3k=NYkAy6-O7f8U=CTNiryu2_Kr57pScjeH-yQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] LoongArch: KVM: Make kvm_get_vcpu_by_cpuid() more robust
To: Bibo Mao <maobibo@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org, 
	Aurelien Jarno <aurel32@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 11:16=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
>
>
> On 2026/3/22 =E4=B8=8B=E5=8D=889:53, Huacai Chen wrote:
> > kvm_get_vcpu_by_cpuid() takes a cpuid parameter whose type is int, so
> > cpuid can be negative. Let kvm_get_vcpu_by_cpuid() return NULL for this
> > case so as to make it more robust.
> >
> > This fix an out-of-bounds access to kvm_arch::phyid_map::phys_map[].
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: 73516e9da512adc ("LoongArch: KVM: Add vcpu mapping from physical=
 cpuid")
> > Reported-by: Aurelien Jarno <aurel32@debian.org>
> > Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1131431
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/kvm/vcpu.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> > index 8ffd50a470e6..831f381a8fd1 100644
> > --- a/arch/loongarch/kvm/vcpu.c
> > +++ b/arch/loongarch/kvm/vcpu.c
> > @@ -588,6 +588,9 @@ struct kvm_vcpu *kvm_get_vcpu_by_cpuid(struct kvm *=
kvm, int cpuid)
> >   {
> >       struct kvm_phyid_map *map;
> >
> > +     if (cpuid < 0)
> > +             return NULL;
> > +
> >       if (cpuid >=3D KVM_MAX_PHYID)
> >               return NULL;
> >
> >
>
> if (cpuid < 0 || cpuid >=3D KVM_MAX_PHYID)?
> however both are OK for me.
I use a similar style as kvm_get_vcpu_by_id(). :)

But there is another warning which can't be solved by this series (and
I doubt whether it can be solved unless revert 01a8e68396a6d51f5b).
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1131431

Huacai

>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>
