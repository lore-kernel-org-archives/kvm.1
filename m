Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519572848BA
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 19:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576104; cv=pass; b=Jlj3hJQs+4Y6+Yw87nEwDLabaSRKTAmmFU+Ws3daiEojlxtECXaiF4U88npzmK444n0rBtHIbIJ3nedLkG8+47ZFOeyBxnztdT2bIVyZEXtppIxVK0C/YDNi7kVs/gg6sF0+93/kP/bOfvTE5LfoTI6UoAi5YVFhB6QcTOBJGCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576104; c=relaxed/simple;
	bh=BcFSBFNjfiqdmSv1NgIPmx2ysvOwK+8OOiEJsqg5Jfg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlO/NEw/GDoyxBkSK8kIevuBLz7BDYclEAh5YXfZka749jPk5/j1sO2rZt6SepYIIoc/eUQ4Y2VOkynT5DDNdX4RcqWsGIRBWIZXMQDVcv9BzqcDeOPhKeIEcmAIyQRgZjA71N4jZAAeRiRfhPRW8lpxHI0MT2WgVk8LsyTzaAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kRLWFc12; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRLWFc12"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-6055a0414d7so372366137.2
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 12:08:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777576102; cv=none;
        d=google.com; s=arc-20240605;
        b=HUMPHIJKtvUbuMIyDpnMI0bsHBSUypcVbgWKnKwWU5WaygzY7PlYC9iR0Z4wtyZPW4
         r3gsx9LchR4LgkeZyn9aLFyV+oPqBHzqRYbJ2aG9fUKPyzX8sEfzQd63flXKIooihdtG
         TbliN2iNi99CkNRTbFRSdU6zPEWxy+5KiPbNtar8VtmYZ4MPUP4korFTf89e6ty1Az1B
         oQrmA5Qmey5VMwSdxf7OPTOZ6ZcHzbLPm+rcdIyXmUNNRNS3PCXE1I1t25IGHLP3K1l+
         xJF9kJFel+Jryx70k35UHLyIqn0G1GkSp1XesE00ayir+u72JK7Tkl+Ql5MB4IrbbzeH
         ju1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=VV5WEE2tzDHG1+/C0I3LGwTNWRiPwqZD3JqM7IwkNpg=;
        fh=LsNjSU7DxAt65Gq0uVg8ESxOCG0volxo65KcDraRecQ=;
        b=UkoTSyIbpBkUfudqLzwPGtlCu9wqnhPHVrPoVhiZ4HhNowtdV54j39h7Rixoc2BS+5
         EJp2uI6Xubv9lcb83r9UufTr3t1fHfMmXH1evEI2ZLzc07z0crXIE/pgFY88FPtjbvJ5
         VMd+17pxQjs2TyhzyFJerm9tgmIq7Av8GYEGj/spHMuJBp//xKuZcGmqz9ylnA6x2c5U
         82JctRKFbkFj82znNQwc0NxPSYVr4kdd+1JLy1udUOXra7B7BTQLEL6ETIUfmSBvcdir
         zeQRXLt4bS2rUZpZkUD4HydUM33lng1UHlIJ2BJOD90JmY3PsIV/lsJ73OL8Anoab2oJ
         p2kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777576102; x=1778180902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VV5WEE2tzDHG1+/C0I3LGwTNWRiPwqZD3JqM7IwkNpg=;
        b=kRLWFc12Bhiu0O5JHGGXOEbGdigbJluNB/ttXXJCVawCjLliLsS13hZhlmWFfjRQIT
         KOG/LwYVlfRoS7sk1Lngw3yDx43I5QWlsMxBi8ST+RIVZQIFfpeKcZe/WD9+W2AAZ27H
         g9MhYnY3YbFqFSto58JDYCeWfnk4iG2Sk4CcBXhglIi3fiPaqsDwN3GT5APM/7UlGNfz
         06l1LluQUADFVf5k22YTVe/sNEGzWZTKLMOUQRgkFUGCUqOpaGRUXZ8w81EGlUedDri7
         a5A9o/IU4VlgBv5H9DfkU0znUTT0iEsQt13gchALZhdds1preBFk6bZoMw6vRLJ7IUh/
         W9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777576102; x=1778180902;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VV5WEE2tzDHG1+/C0I3LGwTNWRiPwqZD3JqM7IwkNpg=;
        b=PPKLywveQhtHRq3/t+5S7OcQda0z0dN42vDEub4PbsLoBMHB0T8uw0beQ2qrHvnvDo
         Iy7qjOMLpUPgsKDukyfpqkmW6nvqJfGwDoEhwskIx7MYhneAuY7xvHpF1ZfmT5BJfIyd
         4A0d1HCZcU7VMwJWpXVg6VFA++J6vakk2HMDS/KuxQfDM0yKW5yMl9x4iC2AtOXekX8t
         XhDiCFiFakG1lw3XdtXXu8/nKR9ZJKLyKXLNoZUizRTyLEt3hsu9X5R7Cwn3zrbPlus4
         /sRLMCxiK9ilXRkMWZ7Flg8Ed4hmDPOHyKY6WLjMgN/EmMhNT3lGikQqrvkkmU3wBdfB
         fwMw==
X-Forwarded-Encrypted: i=1; AFNElJ8d+NrHWxglB8prQvV2VxMDoZPdhz9aGt+m7pHUgOQc+Ad2r2G/IYHOrDixeio/kKmTsBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdy+qbjVc3Wwj6bU4FGkjrhKX4ItOouuVXboq5346PeBIGJUy1
	Es2qCcVuYvrzEMfRt0LZWkhIDJLFt55LsSM7clD2cmP38HrChOjPC81OF4PSWIjlEM+OVWgzRv5
	7IE/jJxgE6fF5nu08Rm37MRhl6+TMtAg+t9N5GENj
X-Gm-Gg: AeBDiesRVvTGjYUkVbfYhjMuqCTrlqw89TkvpKs2SHHBKPiG+AQpNSaf1S2RL17agKL
	vTI3YNsIQeUOYS//63r4/PiUA/FtDi4f/wyEMUMHjJvLjV7p1Q0vUd5stn2zYFiBJvS58ci1+Z6
	BiZkcdRFIa6vf3dASDd1RVyJu6f207QA89v8s60XyT7xU2d8FRO2PoNzzpZE404DV3DKLIDB6Z4
	w8vekDnqrUc9k9w5W37YMJnR1XhmCpYOgcz13/CPooHmnMCY+LYQR6yPx0x2+kutNJseBdfDAxL
	olwEpKVA+p+m/RGdRTym0VEaeYqj1N6te6eehsSnPFCcirRHfhrfUePypndMWbVggXa+cC/U1tz
	xh2gljVA7yTZgr1DNbr6eZJ8g0A==
X-Received: by 2002:a05:6102:2928:b0:628:1e7b:cd0e with SMTP id
 ada2fe7eead31-62ad234315amr2616765137.11.1777576101731; Thu, 30 Apr 2026
 12:08:21 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Apr 2026 12:08:21 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Apr 2026 12:08:21 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260428171541.1342335-4-seanjc@google.com>
References: <20260428171541.1342335-1-seanjc@google.com> <20260428171541.1342335-4-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Apr 2026 12:08:21 -0700
X-Gm-Features: AVHnY4KiaGrNK76uQ2DQK9xgBP5GUa3HxCak0xILGKcq83W_QWWNbmpTGiA_vco
Message-ID: <CAEvNRgEL32Jc_FfKGqYvYJ3WZGz=PnGwwmxviCOHWaDXm6KX-A@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] MAINTAINERS: Add an entry for KVM's guest_memfd
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> To better reflect how guest_memfd has been maintained for the last few
> years, and to prepare for significant upcoming growth and expansion, add a
> dedicated MAINTAINERS entry for KVM's guest_memfd, with Paolo and myself
> (Sean) as co-maintainers.
>
> List both the KVM and KVM x86 git trees as authoritative repositories, as
> any given guest_memfd change has a equal odds of hitting KVM x86 or not.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 89b470db22de..9eceeb6f699d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14396,6 +14396,15 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
>  F:	drivers/video/backlight/ktz8866.c
>
> +KVM GUEST_MEMFD
> +M:	Sean Christopherson <seanjc@google.com>
> +M:	Paolo Bonzini <pbonzini@redhat.com>
> +L:	kvm@vger.kernel.org
> +S:	Supported
> +T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
> +T:	git https://github.com/kvm-x86/linux.git
> +F:	virt/kvm/guest_memfd.*

Should selftests for guest_memfd be added here too?

> +
>  KVM PARAVIRT (KVM/paravirt)
>  M:	Paolo Bonzini <pbonzini@redhat.com>
>  R:	Vitaly Kuznetsov <vkuznets@redhat.com>
> --
> 2.54.0.545.g6539524ca2-goog
