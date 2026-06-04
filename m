Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EAC3BE141
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 05:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780550966; cv=pass; b=OxQqYmJPPjsp9F9Rru2wYSKw4N+dUx6fbszufUzVqWwzoyfa7Dp4BOZwTiUaSBp9fZFoGqg1Jb7jbsGr4w/rakUrAXSEHAJqMzdUNQkUVzblKIXXp3/vRm7BSSPhDXYv2EvBIfif3fxxS7y8YlYuAZRsRfUo+jPlak39HJTTaRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780550966; c=relaxed/simple;
	bh=XFuSIYtqSD9TXvTkNY0qObnr9YDBMpJIGV63uJtVGlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxMdcl6Scj6DIVihOb5VyYwDpudIs4PMuLj1bjNkdauve21WuotFNPT1ggzs6QVytyUA9Rz6foFAgaWZfvmicpZYqaBDIMKogPLp+1nReJYGQXUNGHum1M59uOeMFi1ZUcBWRalx4tR+BTy2w1HxV6i5+ZxCRpF7VmLGxJ0/4xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=GNNaGIaW; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="GNNaGIaW"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-69de4000a57so254002eaf.0
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 22:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780550963; cv=none;
        d=google.com; s=arc-20240605;
        b=Zed/HOhpnd5BYtc7SEfi4NMgzvgq9+OUeH+3Vq3bQAb5Gsx5RTARw0zW6HpHHkktM1
         GUxRv0JSD6tseA+r+NxwjOd7qvJAfWageSQepMpKTtEWWGD/7qoJk29+Zm0vK1gALN2x
         PM9ryYVT9k8E0YEQx34KH/cxrJ0s4KbbH/XgX94iJpJtT9A+Ih7ZbraLd4TvezSlrdMv
         RCTVf9/VoXg3LHrmD1gwl8YHBTCViNjazqM00rb6zKevfuPsrabhAX1dtto2jjvpJT++
         b6MJ2o02Yq9HlbWYc12LPNSxb5IKQCaluIqTDHGKm/7jxALvXgpgtmRqNDLbWk210h+t
         LebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6eJLtMesZ3Q1hzBJwaPeyhA7+N/7eDzJFF12buX3frw=;
        fh=WgK390XnyqlgnbZN0McuLA8IVEu38wz7IAJ/a/U/wkQ=;
        b=Pi/VUIPW+EtOuY0hl131P/OuQ2wFtYPQjYbwK2dl/ZvX1m2C7jdiw8Oq2QeX3eIHDd
         uPpZOVe1EvcFja07tri3oNHgmPtiGmvZkiBeuNYDJGzq7Ybq60sS9t+TTZCiionh0LdS
         uHAB+9qDKpvkb6KibbpG3EvqHmrRcVYLSyvNbRt/TxkZsFCAlKoQgpqBcwIDsko1xl2T
         CIhXUlgeJNHUWrHaiwye3B6CP8itrQiCvor+G0KkhUgSW0pCRUCB0X+Y0FAfofYQlcbX
         Cokc5bkzVOMN3E6CCRPvM/Qewk67dC4ETYvCA3b56v5CzZ0uovc50iRGMSCv2Nu6oFt2
         Hpow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780550963; x=1781155763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6eJLtMesZ3Q1hzBJwaPeyhA7+N/7eDzJFF12buX3frw=;
        b=GNNaGIaWwyTX4Hx7RLknvjD8iqrclMPk3P3mc1AXjl1rOgH5ENMSiLZzIaOaWiUftZ
         ad8wPZ2zkpiVZKjuWt6Sb4uXIAQApY0KxJD3WyBZgchyXGG3E6cVpAL1ednsdcB442M6
         l904lpBb0iVyxgeOtyPRFEWMhqhX9xWeMQgUWmJ1ZZngZWY1wfTg1bSqoRhBGVoP5Qvb
         +esIYpxd0EDRD6qaUwOKE6LPjgP0HjE3B5Uwr6vMSGlH7xVwzRdqNAvKiVPxiXHYlumw
         r7O7K6l4nuuIdGaU8lfHwSYYiG76m3T1VYjhsCmx0znlQxH3O1Phc83DckPrL5XcJ9WR
         pY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780550963; x=1781155763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6eJLtMesZ3Q1hzBJwaPeyhA7+N/7eDzJFF12buX3frw=;
        b=US9P8nwWpdOTwV8kfBQobLhIGmaD6EmRqh5Fu/BUfd2ALLvXej+LYXZIZ3rfLe7aQu
         1VIZtyE99xMMXneaaUVDC8PN1TrJRa/trpz0lgsQ00KUz7KPz0ztikOngq8mRv0Ofq8+
         a4JcyvxqWmPAtMJ/DVoIqyge8mCOBIPgw5ZkouS9GqXwncnMkm7FlVh22uS5zh71wLwk
         oTYvVFbwF5RdJ12vAc9k8pnQGNN8KdxkHgCrVzIv28T8+eIGkeDW/NQqZ30yu6x3i6yo
         T4qebfzyE5ylLQI7qiy7DJT24tda95S49qhgayl/YxVK+kahUCQQd2UWJjKyEN5nzXsu
         +cRg==
X-Forwarded-Encrypted: i=1; AFNElJ9BYSEezJ/t7wxXRWVyHJdElgTqLlBJ2caN3jmXsx6EpnIpG0kX6COmwXthxexlJYiPU0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrNB88a4rUzOdPxu3GhD3XfDAcUlaL1ZNxpBjzFw3ejBcQ/o+i
	OdnkVFSpmqXlC7p8OPROyLH2TmTxIXHxVhlJOW344HAz+53r0yh0GyzX8XBG2qs3VA8bNjQ7rC8
	GfjKBemhsNfnHofW3KL3LSm+vnLNkH0NhhJSGXsbdNyzCwsRmXud01xbcDAHq
X-Gm-Gg: Acq92OHGJ57lhKJ+YL/f3GsuxA5IlUxm7P6wZfrtXXyWY4WodPd3Nwfc6jdNL+8OgWh
	A7zwc1DKNg/RdVfMFdggzurZ84YE4+lZFnJGm1lshRXlV+Sa4aDW9FNtIQqH87wJuofuvDwr3kO
	FIXugPy2i+K6Bzi18oWFS1+y+dLM/I9ColwYCYRcXcZPTAlJwsQdkvA0vF2zysLGV8dohL0GGbN
	+fr6O+fi4VUlXQyBkk0Y0/iN9MsGqeXbbv65AFsU4+00nP7B+uKxKIIWh99DM2MNYDAjhi0djvj
	oeJp5AMXdGGObtpV+QJVz77hc62ylQ/BKzMJ/ZQs7Cu595foCmIx+Preiw4Wt+j+8EF6rmBQnOt
	I8jmlopD+XlRoyNDf6MVqc2lfLi7225GCYwwGhwCbDFpMz3M=
X-Received: by 2002:a4a:edc5:0:b0:69e:37c2:ee40 with SMTP id
 006d021491bc7-69e590840f2mr1121677eaf.25.1780550963395; Wed, 03 Jun 2026
 22:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520152148.131272-1-tjytimi@163.com> <20260520152148.131272-2-tjytimi@163.com>
In-Reply-To: <20260520152148.131272-2-tjytimi@163.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 4 Jun 2026 10:59:12 +0530
X-Gm-Features: AVHnY4LhQpAd0LZlTlkonza5lJoQ6SqIXgKpTOBU1Ixa9QqtgjTNHVCis501JRA
Message-ID: <CAAhSdy14_aMXR6ztaQySOxQqaUNTARfhuZd=pTS=52nXrTQrEw@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: riscv: Pass the target size to huge G-stage checks
To: Jinyu Tang <tjytimi@163.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, kvm <kvm@vger.kernel.org>, 
	kvm-riscv <kvm-riscv@lists.infradead.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Yong-Xuan Wang <yongxuan.wang@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 8:52=E2=80=AFPM Jinyu Tang <tjytimi@163.com> wrote:
>
> fault_supports_gstage_huge_mapping() already contains the two checks
> needed before installing a G-stage block mapping: the userspace address
> and GPA must have matching offsets within the block, and the whole block
> must be contained within the memslot.
>
> The helper currently hard-codes PMD_SIZE because its only caller is the
> transparent hugepage path. The hugetlb path needs the same checks, but
> the target block size can be either PMD_SIZE or PUD_SIZE depending on the
> hugetlb VMA.
>
> So pass the target mapping size into the helper and use it for the
> alignment and bounds checks. This keeps the existing THP PMD behavior
> unchanged and prepares the helper to be reused for the following hugetlb
> fix.
>
> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> ---
>  arch/riscv/kvm/mmu.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 2d3def024..10be8f683 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -286,7 +286,8 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn=
_range *range)
>  }
>
>  static bool fault_supports_gstage_huge_mapping(struct kvm_memory_slot *m=
emslot,
> -                                              unsigned long hva)
> +                                              unsigned long hva,
> +                                              unsigned long map_size)
>  {
>         hva_t uaddr_start, uaddr_end;
>         gpa_t gpa_start;
> @@ -300,8 +301,8 @@ static bool fault_supports_gstage_huge_mapping(struct=
 kvm_memory_slot *memslot,
>
>         /*
>          * Pages belonging to memslots that don't have the same alignment
> -        * within a PMD for userspace and GPA cannot be mapped with g-sta=
ge
> -        * PMD entries, because we'll end up mapping the wrong pages.
> +        * within a huge page for userspace and GPA cannot be mapped with
> +        * g-stage block entries, because we'll end up mapping the wrong =
pages.
>          *
>          * Consider a layout like the following:
>          *
> @@ -321,7 +322,7 @@ static bool fault_supports_gstage_huge_mapping(struct=
 kvm_memory_slot *memslot,
>          *   e -> g
>          *   f -> h
>          */
> -       if ((gpa_start & (PMD_SIZE - 1)) !=3D (uaddr_start & (PMD_SIZE - =
1)))
> +       if ((gpa_start & (map_size - 1)) !=3D (uaddr_start & (map_size - =
1)))
>                 return false;
>
>         /*
> @@ -336,7 +337,8 @@ static bool fault_supports_gstage_huge_mapping(struct=
 kvm_memory_slot *memslot,
>          * userspace_addr or the base_gfn, as both are equally aligned (p=
er
>          * the check above) and equally sized.
>          */
> -       return (hva >=3D ALIGN(uaddr_start, PMD_SIZE)) && (hva < ALIGN_DO=
WN(uaddr_end, PMD_SIZE));
> +       return (hva & ~(map_size - 1)) >=3D uaddr_start &&
> +              (hva & ~(map_size - 1)) + map_size <=3D uaddr_end;

This looks counter intuitive.
Why not have "(hva >=3D ALIGN(uaddr_start, map_size)) && (hva <
ALIGN_DOWN(uaddr_end, map_size))" ?

>  }
>
>  static int get_hva_mapping_size(struct kvm *kvm,
> @@ -404,7 +406,7 @@ static unsigned long transparent_hugepage_adjust(stru=
ct kvm *kvm,
>          * sure that the HVA and GPA are sufficiently aligned and that th=
e
>          * block map is contained within the memslot.
>          */
> -       if (fault_supports_gstage_huge_mapping(memslot, hva)) {
> +       if (fault_supports_gstage_huge_mapping(memslot, hva, PMD_SIZE)) {
>                 int sz;
>
>                 sz =3D get_hva_mapping_size(kvm, hva);
> --
> 2.43.0
>

Regards,
Anup
