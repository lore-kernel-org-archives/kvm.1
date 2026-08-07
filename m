Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA0F399890
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120839; cv=pass; b=YsPaW+DnuZNjfp6VOUASrrfDbOBAIBC6JaWKkJm6VpX29NCF5j/mQe+YhdBoDBVxqDJ7Y24cYCoDddZTe5a42FAZAsZsBZXwubP2w6MaFMQUXz04lEtswHhaCfYyPeFPchlTuWkL7h9xFenodkvzZeri53ru5tYLU6cq52fJk0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120839; c=relaxed/simple;
	bh=F50iQH4e1nAqdZbITtJdiKr4PRC5QvkQr88iUCNw6Hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZ48C5YlGKOBqFU/9/ba9keXflX5SWwx93Cy1ALr6W767zpFgxtSnYLWj8HoeavOBvxFDJMkpyqOfJrrQ1p9UsqyEgqzZBAjPZAymZbu2oRk0AHbU2pJyecDTzUCVCHLMoqlDEAs/iifxPNYOJReRVtZO+ohGKOIVjKnaBiACdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=jWavrccF; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="jWavrccF"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso2241870f8f.1
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 09:40:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786120832; cv=none;
        d=google.com; s=arc-20260327;
        b=TQLR1c1TB5k7Ll9h54fMe7k9JaffJAuV7I+zBq3UMRvvZ23X8VPph8GgVN+yLJWeXR
         Qf/54GwCaHnw919ZlpEtmXfy4KvM7DvxPJNvgjH3rFLK9AinWbusWVyOyN1SX7edi8W1
         cIhlDEIysxwgJxBuRBTHa4xc0hlr2mVPZDkJRApE7QCQ+1WJ7IXjvw0FOAxjRoCl4mnZ
         EAv02SjxUTMVsXt8jdcAcSrnx+GWnnvEX+RCiLNZvPvD03On+4dek7z7SHNeTbidPTxp
         rMEDHfllYOgK37gdfGmg9uv6GpjO1fm2tqTBJDKmXoBau/q9cc6T2FDjrgDQeSgdOxYd
         Nrfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M3ZQ4lwGybEnFTTAAMTdnaC/1E614SavXr5HowXfnfg=;
        fh=yLfRJnM9Lz9jtpzhKAXTsWkUUj6QNIKhDgQ2u6+9b/k=;
        b=G8AAf8uy0P+Po9J9/FwztoCUbabHCf96aKPeFvIEuRxUuOd83hxwQQPaDP7a54Xmiv
         JLOkJSZxROlM75rnhUkOTI41MIvgjRcvxidE7DViilICyHr81a9uug/+X6VC/x5lEQi9
         zw5px8xhk3qwmY6QRq+ehTzKwmmHBX4/Qf6co82NHUu13BkpbvczNgsFdkxCBG+tlufa
         oTGWZDSxPsK5gnUYkUGsiui/GcZUey3PKpCvgpgI3fMOwFXY0u8Ednk3JyufIjR2z2yV
         2xZHnjpC2xDCwW2L7covwllL6vGAj670jqravNLKpwTxh+td15dPrjoVhgcjAkg+cRBf
         em3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1786120832; x=1786725632; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M3ZQ4lwGybEnFTTAAMTdnaC/1E614SavXr5HowXfnfg=;
        b=jWavrccFQYzpeewCm1/91PAdK0Lal/3LFAbUGNPH631rit2yPi6JVqbO1eGNCkn9X1
         yed7UY/R78wdxV3kV988nC6bITufaqlexR2oJnlpHYTHWdB44XWjG99AyREOs9ynYY8S
         Mtb7o6XOOXzMmRmcHKqSFnTjpX+2APRpjKOnLg+qVTiGqBpaQkxxJE4EAbBLE9mdZXaH
         /2tszc1HPwwLEjU42Kp5oTTt128y/6UdAjeVCl8ozI+JkyoKi999eAe8QmH2x39s8LI8
         sX954aoX/JGM/SR8OshZAAEzxTr96T/ofmoaRYLAyPfhDvgKdHKlLfYC0ZuzLHko6niH
         ibzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786120832; x=1786725632;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M3ZQ4lwGybEnFTTAAMTdnaC/1E614SavXr5HowXfnfg=;
        b=jBxMFX19IjK7s6hcVcEznIh7rNJ0u1ZmlAdMrSKdpZocYoTJ2NbSiHE+pbA7AygJqC
         GmI5BENADBTNVWHRBRWHgzKOXum62LtBpYotNLPHbgtFRWqQq6Kmn0RyRMJOlyhepfq9
         cF35whhgFod/jtb1p5H2R0NWyeTpq5q6ad9TQZ8MvRFSo9sv5Y277e+PyliPHgYefT2o
         eKzE3G9CzIEf0JCdFecaID2MY1sNiDiGlx8dJchLKhXibj8WOFFpz8/ivahQOFZkNaye
         4po1ui2f/Kpiq4f76i4nYS723ntl/0lCK0JtKCggHc2MUe3m6XAnPXwBYgMmrg+4o9F5
         CecQ==
X-Forwarded-Encrypted: i=1; AHgh+RoWGkz6dvJqavyQzuX+A9NL9jLMDlQOmAv14Oj969sPjOcSjEddhxfUHkMvHovLl43LB/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5K4Kfe0cSR+DRM/d/i//T0Z8kQi88mVA7+gubj8R2QHm58EpU
	GZERGEIbbGFtAmiBegPQ067YPeiWxZUVETkacMZBuZd9BXtuoESISbJbTWjFUxVsyuldAQyXod1
	MPSp9nKvCFMHnxYZOz08S3SQUN78nWoffnCQQYiez99Tcra+curfqR5M=
X-Gm-Gg: AR+sD107RSPfVT8RebaOF7wZvRpXwXW3+msFkoFv3SH5gAC5KPNXiDdy1OZ734EXe1t
	wIrYCV/DVxUNWyIkV2XI1XVaTSUpmq+Gfis25W3LLru0vgy5xD2Ab0UWbZWXmQAlv/78IuxZd8t
	rRoYsIwtw3b95RSZbQ7ZgDG4yXhDA64vFVnCUpNU+CmnR4KC7kwMY6pJmRw3LSsGh2xl1P6Rtjc
	LXCdz0NUrCRUQw3rgvDBnhAngikmWo29yCSV77ZXx+nzf47D21TCY2e1C8isMENQQP1GvnYS5Iz
	nW81UiY7M04H9ILqlILWZsvkqRRN2WqbCAJhiGiyod6+gLnl6LKAMVeLLKLRVx030ea18S17Hf/
	trUailHQXD0DcqtSicH+ioKzZqv3qbdGlXkFbk5iSURCXfXKFvmDWV/o1nBhaZN9a
X-Received: by 2002:adf:ec0e:0:b0:47f:4dfc:ca1e with SMTP id
 ffacd0b85a97d-48130e7e846mr1247509f8f.5.1786120832608; Fri, 07 Aug 2026
 09:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718033646.002.31dc89f2-caplitmus-rv@iscas.ac.cn>
In-Reply-To: <20260718033646.002.31dc89f2-caplitmus-rv@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 7 Aug 2026 22:10:20 +0530
X-Gm-Features: AUfX_mxaKOttqZ90LkDJu3zXy0Nxt0iXONOyY8DEizW4DWkuOLmRJN7Yk8VckPQ
Message-ID: <CAAhSdy1pw+g84HFq9okYcfmG9_nV=Te8q0YHt5yNtf6zsYP9sQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Allow memslots ending at the GPA limit
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Paolo Bonzini <pbonzini@redhat.com>, Yifei Jiang <jiangyifei@huawei.com>, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 9:22=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn>=
 wrote:
>
> KVM memslots describe half-open ranges [base_gfn, base_gfn + npages). A
> slot ending exactly at the guest physical-address limit has its final pag=
e
> below that limit and is valid.
>
> The current greater-than-or-equal comparison rejects a valid boundary cas=
e.
> Use a strict greater-than comparison, matching equivalent KVM architectur=
e
> checks.
>
> Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programmin=
g")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.3

Thanks,
Anup


> ---
>  arch/riscv/kvm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 082f9b2617338..d3c0c699adb60 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -184,7 +184,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>          * Prevent userspace from creating a memory region outside of the=
 GPA
>          * space addressable by the KVM guest GPA space.
>          */
> -       if ((new->base_gfn + new->npages) >=3D
> +       if ((new->base_gfn + new->npages) >
>              kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels) >> PAGE_SHIF=
T)
>                 return -EFAULT;
>
> --
> 2.43.0
>
