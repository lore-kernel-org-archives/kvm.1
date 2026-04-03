Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0283890E2
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775207145; cv=pass; b=NnLkRXJ88VU38ye+f8XFmRvOQywAHKGH1hEgNlCPkhnngA5dMUioMF6+K82JY66JL2oaOnkI0rRl8jtdt8lE4Ik5WK0YnzEXjndaxCJaL/iDm63ogJduriB3Ii5OWgMq2jhLwSEN1i5otdmQ6pHn5G/coziV85pIwSyxa6s67Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775207145; c=relaxed/simple;
	bh=3+E5CeFt5DfngY9jyCj6sN+5947QN8ZJ0RESVzhTnAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3SbYy7lilhjSZw+nQQGjzxrMDkO4LHEMRfpCsOLJnxuLPzTjFubBbPxuFZSCllr0OIvHhUI1YHuzclxgkf59GOujoiU7C1io9yeGZc3e3ax3i4rctdZCkGDzLpmdiPgTG8ABbc98T9BwvRbShQ2g2OP2Ii6S6JgF2m3dRXitOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=Gu9rbtMD; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="Gu9rbtMD"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dbba5076c8so198990a34.0
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 02:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775207142; cv=none;
        d=google.com; s=arc-20240605;
        b=NwWJhyzkJrcqWrgny9McGXhHtfzx6PkQU0XTrZfPppbDXn8tWvH7hHLiCcc+W+/k+S
         8Xenih+D6Edy3/9ma5PsvldAnIGX6GyagJxOabf8Do1LOvtEVY7K38EI3Hf86OVzYCRe
         LkjjergmMP8/ra+V0MIslDu0jGoDit9SG1Ef4wi+zMpAY/UOuqNZHW1lJJkUYGEFFT6Q
         ZBHydll1O70J54tZyxWatbWTNqvcW0jNZTIq89gPME3PMm28tnIlqzbX9nrIgsHqxomR
         rs8x+Lq55L5EwPMdT5AyKjbP2besWaQW0JePAwDAIVEhSsnkmKT/OMiPnHnisR/gRlkh
         8Yrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CCm4AYakB9dKG7bybl0vV8lp+2k4EkmvPsl1dYhbfsg=;
        fh=JErJUczLX8acfVYFkWPYkDB1vDCbsaBSzYkD0A7a32U=;
        b=CXPUXAqKfDeMA3EkOdQGEVxTdcRYLo39KrvyV9C7ZYv3S9aKPFbYZi8TFouFInkTfL
         GjyU3sdEq6ym/5DXUenoVDRdewP6M5NNvGFAUVWUQazCMvbLZreP11AQZQEcxRKV60lV
         XRld/IHJjyYiV8JQOkn+DdvHrZEY4CU6iGb7EsD92Pcp+A5L8A2ppEoIGTeAfAHVaXL2
         ctCNaXmiQ99FPHMCjk5KmrgJ5TmOlYUoCYFTp+sWOC4FqLeNwUhp97i3IMwFNN7xlLMl
         TiGE3PsByiFFqWcZYe4gsuu7K8tGaheDhhM3qHOUDxGcZYYUPTAXy6uKVqp0A18Sscut
         3eiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1775207142; x=1775811942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCm4AYakB9dKG7bybl0vV8lp+2k4EkmvPsl1dYhbfsg=;
        b=Gu9rbtMDwsCe8l0Nmn03iwDdOFnpsEnBlHe6jZK34by9N/z2+aY+oUiS5d1ISeKfPR
         ZtvA2HDlCjyMdGbLEbQVMg+5Fw8rGNvDHuLL8uuvmyuE2a7J3ag73ea9/xFOjKvNHohr
         fyzQXn2BJ17yTLpI9yC1ACGVwqAlA+pKVSMshiBa3bNdPzRyH+wXM83Qx4pgXXt1cdjC
         wsCFGeZ7nJ2lZOuNJpecjO4WUZy4Byyz512YlTKvJaclb1/sVc/v4OXzC+IAqG1mwV4X
         EcG5atcKMYdM2QNJSxtnVPA/YG2bLxAUj9pUOPsnERr8lNqJIhFb1v4bACJ6krRk3OB9
         zAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775207142; x=1775811942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CCm4AYakB9dKG7bybl0vV8lp+2k4EkmvPsl1dYhbfsg=;
        b=aSklRnDMhnF7L6hTc5naZfs4q9JCzdtEjxX/7gBd06HqrFDfiG8uzoqHWRJen6tfcp
         cEjOva4y3FOdOV2K4p/TmGNzP8M4r9V/QLyFg2NyX7QEXWzApeBW3bNdbqcXBTngpau5
         oDPv4ITGVpMG+cVYZcIZ9yyHO8UbYBGiLa8qymUGtKJBz44JFe3hqDYhot2rMYhRd27D
         aRZvqBTe+dRnF7Gp2mAuMkD3MCB50AapknFsMbnmrZnIAXxyhR1CuKb47ff/CVruO0j3
         7udDjZp0ab8T80s2rAwaBjpVtOhiCdFE6vmfZ2ehm2BtjGOaMuvEck7tnYgeLQLekXdD
         pkTA==
X-Forwarded-Encrypted: i=1; AJvYcCVLyGOul1MvcwauvkBE/OsMi56CtUpvAHOioqtihSifqrfnHe+lYVw+UeOJA6vEgyPydnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYQoskHZN7UTGDY5VeP0jcZHLx+2EdaSKlgRea+F/I8pIWVK1h
	liqD93k0rLtlkfRJNYh+5+BIL1JGcCA4z7dpHLxOtW0D3RFJxI/yqu4mANBEMYwQ3cAxGhVwRKM
	jgQeD216VxTH8doDAS7MOvVJ7Eu7V7xifr6GOblzyhA==
X-Gm-Gg: ATEYQzyRPMFGnrSPUdZJf1Tp58xHdppnbyab/wjQkkDz6GSwTzEcqZtKGhWs4Q9hyjK
	8zvAN+nFmQy4jhi+UkDHGrkNA4+lGlFRsKZarqmntpofNfIZydNvcXUc5i6HUxidbcoc3K8oGaB
	9euAGcWteXm2mR8UOGMZwmBbMmUdnZjQDaENzeJ7wVWwG4ztmE9poActRcuRIytyMIBIzkqSrx4
	MZnKSUmbXUsuAWHxgxk6T4c50r3YEpjTYq9t7W8C/MMTWh7vU8zsVMy+4zH+3H6py+GIdmnpJA6
	k6QHMVliZXSEx2WKJGPMVwKNo+2Y/1VYyRWKCO0qooIcXifiyAgVhIxwh/GgxDsAA63k4zvmXQP
	Vpw3fd8760e7V2kltAA4hOevxHw==
X-Received: by 2002:a05:6820:81d4:b0:67e:cf9:ea19 with SMTP id
 006d021491bc7-68221fffcb0mr1063073eaf.59.1775207141789; Fri, 03 Apr 2026
 02:05:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402101818.2982071-1-mayuresh.chitale@oss.qualcomm.com>
In-Reply-To: <20260402101818.2982071-1-mayuresh.chitale@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 3 Apr 2026 14:35:29 +0530
X-Gm-Features: AQROBzB9KrI_BrZ8TmyJzBaJ6ObiJnp2kmnWownjmY2mr4UtyY1LfTWXeuUiIwY
Message-ID: <CAAhSdy3dqmamQX6dtxhXasFmYhS=j3YheSLnBv_sh7A3FZJLVw@mail.gmail.com>
Subject: Re: [PATCH] KVM: riscv: selftests: Implement kvm_arch_has_default_irqchip
To: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 3:53=E2=80=AFPM Mayuresh Chitale
<mayuresh.chitale@oss.qualcomm.com> wrote:
>
> kvm_arch_has_default_irqchip is required for irqfd_test and returns
> true if an in-kernel interrupt controller is supported.
>
> Fixes: a133052666bed ("KVM: selftests: Fix irqfd_test for non-x86 archite=
ctures")
> Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>

Queued this patch for Linux-7.1

Thanks,
Anup

> ---
>  tools/testing/selftests/kvm/lib/riscv/processor.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/te=
sting/selftests/kvm/lib/riscv/processor.c
> index 51dd455ff52c..067c6b2c15b0 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -566,3 +566,8 @@ unsigned long riscv64_get_satp_mode(void)
>
>         return val;
>  }
> +
> +bool kvm_arch_has_default_irqchip(void)
> +{
> +       return kvm_check_cap(KVM_CAP_IRQCHIP);
> +}
> --
> 2.43.0
>
