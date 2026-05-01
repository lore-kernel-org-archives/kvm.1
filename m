Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00D136405F
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 21:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777671519; cv=pass; b=OHt8EToRozqhjkai8YG6981Fzvhgl0o6yWfC28c6wI/2TCAzvtAPQTKGyk8kvHZ/1zgmtZRhjEBbjlcWiuc5Ryiuwn0AKq2cAjeo+jVcSQ0joVJ30Y3IjARiNPSWdIZXqzRnvpSIGISf8295zgHKfiGeF7csZKL4MC50edLDzBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777671519; c=relaxed/simple;
	bh=IsxhEFYc7F/yvKtqdMC5WH+ccssIFOu7BslLvcPFdvk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIO+lJTt7xxGkSFFkNVUqBrDKy1OpUEpdbqWziH4lNu2a5sh7SqT3KnvQgByMDK7s9k7lgp6mr1o5P1JlP/WRy3yP8TY2S9rqdkV8Zn8g8O29w4vc/OwikzikV+GvopkM0ETwuweLJ94zVQ1ACNX30QwafgMy4NgyyJc3THdOHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kbDJd1Tx; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbDJd1Tx"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a40b2d268bso1770111e87.3
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 14:38:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777671516; cv=none;
        d=google.com; s=arc-20240605;
        b=A6f1dEdDBrt1jd/RkXvA7n82v1CqRvtzfdROYyeCpIX7OvAR9n/o+z/4w4nQhiTJ34
         a1laJr29id9x2vM8UjzULfHwD1OdEslwxfsBt2LylQbyFiU+5Vxe8V62lLhbD76M2LFs
         4xNYeSdXS+308rgF1TXE/VfReqTzmmeCawOAt42TEdkNBqF9DIX0wfZegawMfiLdh/PY
         Yjv7yhFqrW1i9vWgC4KDXojyi4IdXPev0qQ0g0arZkO3/RKI2A6Ex8R7vZ6Fl+IVWZkQ
         tzMc/avaFaWqZ1TlgUnqBD8h9cuinlXwGptvhoM74mOhlBXdXSfqEVvvTfaczBJWXbYv
         Bvrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Ni2d0LbUZ2o7gUpH8hKfEsWiqYP55d33OCQeStuA1JQ=;
        fh=Z+l9Got+brlJKuwgkwvVTDLT19TbYV29K1eNZPZBWLU=;
        b=ThzNkHFxREnD02STTr4a2r2rOTTTCtxUhERsoxhcwC7VxWP/MSqM2xKNRTRDsG7WML
         RD0q55ztVq5Cz0FY8UKTV85zNATCaaHtEvi+lzZWRqeoaEVWxRhI2dykGienyp93V8JG
         BPBJh+wFj1QINTrlz62Wq0qSy8T/ioJzxvaTXhpqY2HLeDlRNVVMhiMmO/yQ16Vv6Imz
         y3hXfgEctGVLeBwDxOR/l0tsEJiPCrbUSLuO04IoMa4rBznrASWrLQRcC0cIyvlR8eFG
         jzvBnSPJsC1UIBVkM6Ny77LxtNW1/RM8v2UM5X+KNCdVyrjVxeJBAzu9sovaX4Oi6mtY
         4cqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777671516; x=1778276316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ni2d0LbUZ2o7gUpH8hKfEsWiqYP55d33OCQeStuA1JQ=;
        b=kbDJd1Tx2BeULDmWOMYSjDy95EFmXKMPydnhFA/hlO4PSNY/BHPBWGZNG1Tr2xiiN8
         GF9mr1OLnXeYpfuByeMKlqWJitV/bnkMEAkSRMrz5BXFnXmNcJ9SmwPG7QJNnRkber9d
         auSGinCmrWnXAXIs+pml3NZU18T+pVaTv1l46WYd8Bt7JL4RDMRsrAPwAsdUZ4BBFLiu
         XEMH1utU92g+F5vKpsUSqYE/rClvhjCO9qdStPcmobOK/Rf7eXrQRE9JrPBHk7vWvo36
         5SjYbzJQq4R+g4YPJF57u0Otd4cRGdWAeaDmleTAxHUQGiJ7ZzdKV77j0rWaU5fAYpi8
         nPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777671516; x=1778276316;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ni2d0LbUZ2o7gUpH8hKfEsWiqYP55d33OCQeStuA1JQ=;
        b=KALkdMMC5t9b6pE3cLet9B6wqMP/I6bzJkWThGbYyNgCS7uVkQ3A03IZ25J14+VD4R
         9RoZ2o2eePoVBN0PPdRssvngJEgwn/AtfiLpv5e/nhhZkjxoqXJIvtJnWkYhkzYFPF/x
         J7z3J391zb/asyX+kkFMI+kwGat7t270FWh8WmZ6KvQNlilK68/kXXItxX40bYZqJONj
         lVoniXvamRbDmk/fwXyAAPTm4QkM5Zv9OBwziDrohdxwWWePdDl9cnYrbgeg+/XKpckJ
         76LYChq5yusMSHd16YAsh0NvAhpad5AA5GoOGVnB7bqECjxiUNUECAHzzMxmhD4lSAn5
         MAOw==
X-Forwarded-Encrypted: i=1; AFNElJ+oRLNg7y3KeKIESQj7QYMP7zjvBjS5fuoad4D4sx9p32U9fQNlIcPz0NF7QhDLfhr9m/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOlt8rw1Ic2QojOA9laGCOAHtHtkY0pAleIxdiviV3v5AY0AKa
	0HPSjIiNpvYoL2JP8nFcuWEGUH+r7hUHX/uq0/M/+vY4aGO62224gNoAC2J6/EnJo9jgOpQi3GQ
	ZMQhOKD9MXEeyQzNEhRawxNJi2x4Hoevm43NJmYCE
X-Gm-Gg: AeBDies7Gp/gK5unKhegsWjfkdCrLD1KJokpLd9YkdQG6dsn+ykSXOe1G4a7E4MuPgh
	HAvtXf8nZ8a684h6yuFef4H8sqRqLKR10EnYrPxfGYyIUsY0EkwZi8wFSpU+OyXi4GPQrokOB1r
	SMaclYTjzgy75sxdCeuUIynStlWZNgLaH+zoB3bH8AeAWLEg3uNiJMUcdpE6yJFAYMtoLy6qCdf
	PENJtcVcW/nPjMCTJOCqkYNK5fZU0qhyBE4VDy41ULnGBxaf5W7q6xCBFBQ4oNnJCqH8Syo1KV3
	cigYBgS7BsW/O2EqLWYifDau5VYBPnB6diUn5n55I9Mvqv7Ae0+YwU14QVCJ1einUGrtp7z1t/V
	Dt30gw2kNpJYUluY=
X-Received: by 2002:a05:6512:15a9:b0:5a3:e5f3:daec with SMTP id
 2adb3069b0e04-5a8631bab7fmr193323e87.21.1777671515322; Fri, 01 May 2026
 14:38:35 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 May 2026 14:38:32 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 May 2026 14:38:32 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260420154720.29012-5-itazur@amazon.com>
References: <20260420154720.29012-1-itazur@amazon.com> <20260420154720.29012-5-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 1 May 2026 14:38:32 -0700
X-Gm-Features: AVHnY4LHKaRfkeyyclR0x3pvx3k4KLTmPeVAluuurJhrHDeNcYU6XnHXfiB5juE
Message-ID: <CAEvNRgGvjD7TtyHKm==55XaTQtSPCTyF89c-UROe5Q=yXEjtpw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 4/7] KVM: pfncache: Rename invalidate_start() helper
To: Takahiro Itazuri <itazur@amazon.com>, kvm@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Brendan Jackman <jackmanb@google.com>, David Hildenbrand <david@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <pdurrant@amazon.com>, 
	Nikita Kalyazin <nikita.kalyazin@linux.dev>, Patrick Roy <patrick.roy@campus.lmu.de>, 
	Patrick Roy <patrick.roy@linux.dev>, Derek Manwaring <derekmn@amazon.com>, 
	Alina Cernea <acernea@amazon.com>, Michael Zoumboulakis <zoumboul@amazon.com>, 
	Takahiro Itazuri <zulinx86@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Takahiro Itazuri <itazur@amazon.com> writes:

> Rename gfn_to_pfn_cache_invalidate_start() to
> gpc_invalidate_hva_range_start() to explicitly indicate that it takes a
> range of HVA range.
>
> No functional changes intended.
>
> Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
> ---
>  virt/kvm/kvm_main.c |  2 +-
>  virt/kvm/kvm_mm.h   | 12 ++++++------
>  virt/kvm/pfncache.c |  4 ++--
>  3 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 5871882ff1db..d64e70f8e8e3 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -763,7 +763,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>  	 * mn_active_invalidate_count (see above) instead of
>  	 * mmu_invalidate_in_progress.
>  	 */
> -	gfn_to_pfn_cache_invalidate_start(kvm, range->start, range->end);
> +	gpc_invalidate_hva_range_start(kvm, range->start, range->end);

Is this actually not specific to the start? It may be called from the
MMU notifier's .invalidate_range_start hook, but since we're renaming
it, perhaps just gpc_invalidate_hva_range() would be more suitable.

>
>  	/*
>  	 * If one or more memslots were found and thus zapped, notify arch code
>
> [...snip...]
>
