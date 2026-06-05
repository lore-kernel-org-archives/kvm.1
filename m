Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD443DE45F
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671277; cv=pass; b=Yvk9U/1t/nf0lT3xfazD+Z9L8vU2wRQ4HHdRYCCgpIDHxK/UlTR1i2y3sRLzzJg5vvuVj+NVfMMuzZT56BKbwLxdHh15GQ1KmdfhEl4pdD6o3gsmp2CJBEfKJOQ8pdJo5YaQpyxt52eRhBa2fElFKt5HXa9hwvNwZrQIhAWIhj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671277; c=relaxed/simple;
	bh=Onh6JMCJb+kqntalCng9fBD9fxJJVLVPC+C9vyMVV18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UoquO8aVM0Vp1KiUcg1Kqr4QJTfT/nP242PxKX2AYk3IRXbbO3JMztPN2J7AIzVy7bV5OWK/r7QFByEcelpnBPJFP+5ghV1xTBd5WrEYgJjOgogTHOrMSkX6ThhiLP+nCyVrwXalCJlJzpYv8bS+bQm1j9rBXtti5IEV0hygsRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=c3852jrO; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="c3852jrO"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51790c0a692so16887451cf.2
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 07:54:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780671275; cv=none;
        d=google.com; s=arc-20240605;
        b=j460307Vh+zJOn5JN4Od03sc4ssXnUL2hYEJpSKNk6FZZLqo70kRh+mbVq/NpSsOkE
         4fZCZzwBps8DN8m3Zj2UHiBxSGsJwyDZGyZ8nqlOr+9XMXXcJDqh5s3T7UpKcYgpKmXx
         WsSOGYhjqL8EW+CRMKA9rRD7BbsAIsFh83ToqZq9ZwpUkdktNgx3udSSbw0IKMNQovps
         JaVSa4inrzMwRWZfTyZRM8ZP4uib5QinNdSrp7ZdECn1oqSmdkLRz5dqkJ/Pe1fFfBq9
         OE8CibgvJEajdXByPGZYx9YdKUJIr3NhKUWEYtrdLTaOYwAmcrtxq9sCW4SF4nXTYv5T
         S5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QjX98Uht19FjoE2NcL+rrjlJpfTyguEM6t6ATWltAqU=;
        fh=j2Xk3t2gU1sw+ckCJAh9BrN8s4Hyci6RWTCwEauPC3U=;
        b=QkbVTf35J7XKcczibuovio4lG1l8InUtuJoNm/vNvLwkgD19A4FfndUwe2LKZFiPrP
         0rcoGBbsE0B/Nv/4JFOfmmBdyvQaUdCqYtHiV33TyqW9B3kBnDS+Q0SqPSlNjfa5cyK4
         aMkADzQVVFViLuQTFwn33xIddUJDZttKurycjW07zQDXyqI/GBwC6l4YDG3Dcm0p9KYd
         30VqiiwgHvUsmiTIzN4QmLGjDhS8N2oVGwKsHo0q+MfKUENg0jHEWtIDc/KH4hItTbWA
         f2PRliR5luyA/ItWNLTnj+qcnMbPM8byJ3byR7IMwdyc0FxUQFESYFVXinVbgyW5T8+h
         T+EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780671275; x=1781276075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjX98Uht19FjoE2NcL+rrjlJpfTyguEM6t6ATWltAqU=;
        b=c3852jrONFKhDCbSFGSnuLdWxo/GSSlJ4MHtt4ILyveqfhTcOMPgBUM3Zbxj4CCuw8
         mlvAKjFOde52G2qfYyD1OjdCCbFRBkT34a1y5ktyfi+ddOf9hiu765isJ5yNtyxgaNIa
         rikQf5du4yieAnxrI/A83EN7UnF0ICTQRiVocyttH/08l3Fjhbrp1AvBg+1uSuMxwc5K
         34OqgbDZWsLxg2K00whx373dB1SRnyTkEr3qZiehhhGExacPbrsrf3UJi99lv67pFHmK
         5E1XupwE86SJUsrTNdIGC/ILp/iBW9XNv/1mQ9+25fqbXTdjcd1BRGy6SNH2/vy1ytD0
         DXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780671275; x=1781276075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QjX98Uht19FjoE2NcL+rrjlJpfTyguEM6t6ATWltAqU=;
        b=goKwOMnFXvCPAxHmLK8oHv3/Gw6O3RLhPFvwkAI0IhGKMaI15YtIgVdfrCwV2WDOR5
         /yDM5saCgFktUchv8x1P0QnFPvPfBFQ4HxhqVs/y+0jVDkTJ9hMIf8JAYkP2xfwS8BEL
         Hb6bQK0/77OdVqynBz2bVyjmPXjUSOV1cTg7hWVMVuxnF3glg91xBidAIXJ7yv5RK6cf
         AvdDw22/JZEhXVA5FAiXgCLGMmdHaAS0r79qbonFV6j8ZgEpUOAXcQgaUhXad15mIo2o
         Y4Kdcm3rjHJFrKrRcY2so+H3Xj5a+nAGOS6cqimcxEXk/yvS9mUGQubGa3QE6eB8V8jT
         09qA==
X-Forwarded-Encrypted: i=1; AFNElJ+4KQECoNA1dREmFdt68LHDyQzaSOfpM9sv9wvquZxj7UUErrPRCS6T2qz70hS1hweKgW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuGOVMkP2j19vqmiXlp4GkxioXMIx0Y+z412qOLicUM3fGpPrU
	lFxApDadIO3/KryNUEDqOa+LH1pNMfR2lELkeDO+78fcPRFITvF9hN/I7J1SYQTeHyXvesC2+ef
	YvxhKuXf+WXjAsrMI6j0FbX/yvWm5R7kAEg1YfUu58g==
X-Gm-Gg: Acq92OFP121DpN9Mckgt/zw/cAVyWsnEHvh1BIIGaOgwi/otTj03ld6gNKEIXlFuI3q
	TP2byIWmcFo3HhvyjcDR45vU3UYKMhhFEWZwBipZDmW/JdBNFrYj0K8SsQNKr0wJ7Yij3YmYrD0
	n8w9qyHOrLYXjZc9XOgUlDd5yj50eKBemUcN+YFs8lwKwOVvPQYzSWHPyhUqoOXyHHtWIhG1qmT
	GJ/WvxAwzVNsekVQYJrFqwCTaFCFfslMiv9VILq8o2hchTS3CZo/OKIPDhhvTbDzMcrWMby/4dj
	q0FYRvAuQRga0vQmERmPUbFXWCJ/KEeXEkRR2oSKA2wUyb09TuwdaULRsTSnZ4ZsNhC4o+Cz9Rn
	keUQj1tAGOLXiwAD8lLUwjGwCaFBpoCdevU88qw==
X-Received: by 2002:ac8:41cc:0:b0:517:9648:f71f with SMTP id
 d75a77b69052e-5179648fc59mr42366971cf.45.1780671275119; Fri, 05 Jun 2026
 07:54:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528113840.2629186-1-inochiama@gmail.com>
In-Reply-To: <20260528113840.2629186-1-inochiama@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 5 Jun 2026 20:24:21 +0530
X-Gm-Features: AVHnY4KB369R15pBBirZiowSu3UvfNZTrfqaGWoeJbgD61ZJLwhslkozizsMbN0
Message-ID: <CAAhSdy1svqDsgNSMhawR4xJN0=LLpRv2dkTu54oc9S7BmqfVzg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Enhance the logging check for mmu mapping
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 5:08=E2=80=AFPM Inochi Amaoto <inochiama@gmail.com>=
 wrote:
>
> When enabling dirty ring, the dirty bitmap is disable, and the logging
> check is always false as the RISC-V architecture does not select
> "NEED_KVM_DIRTY_RING_WITH_BITMAP". Although the dirty log is recorded
> since the write path already trying to add the dirty log, the logic for
> logging check is broken and some side effect will occurs.
>
> Enhance the logging check for mmu mapping so it can check both the dirty
> ring and the dirty bitmap.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.2

Thanks,
Anup

> ---
>  arch/riscv/kvm/mmu.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 2d3def024270..b5873bca9dce 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -142,9 +142,8 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>                                 enum kvm_mr_change change)
>  {
>         /*
> -        * At this point memslot has been committed and there is an
> -        * allocated dirty_bitmap[], dirty pages will be tracked while
> -        * the memory slot is write protected.
> +        * At this point memslot has been committed and dirty pages will =
be
> +        * tracked while the memory slot is write protected.
>          */
>         if (change !=3D KVM_MR_DELETE && new->flags & KVM_MEM_LOG_DIRTY_P=
AGES) {
>                 if (kvm_dirty_log_manual_protect_and_init_set(kvm))
> @@ -433,8 +432,8 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>         struct vm_area_struct *vma;
>         struct kvm *kvm =3D vcpu->kvm;
>         struct kvm_mmu_memory_cache *pcache =3D &vcpu->arch.mmu_page_cach=
e;
> -       bool logging =3D (memslot->dirty_bitmap &&
> -                       !(memslot->flags & KVM_MEM_READONLY)) ? true : fa=
lse;
> +       bool logging =3D kvm_slot_dirty_track_enabled(memslot) &&
> +                      !(memslot->flags & KVM_MEM_READONLY);
>         unsigned long vma_pagesize, mmu_seq;
>         struct kvm_gstage gstage;
>         struct page *page;
> --
> 2.54.0
>
