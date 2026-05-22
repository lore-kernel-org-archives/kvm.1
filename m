Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB29C36402D
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472347; cv=pass; b=b/jmZS+10OeDKy3tGrFN2XbmW43um6LV49S1VAuITzUVm8NlLdbbCdJoQy9r5xgpq88ubv177GETIk9ImjClhpvY3FrksWyeljDyChOvpuAGCj09dlF5eD9brfHcRj4wLulrFd3AJSfT22Y47MHVMC9oH5ZE3BiJxZtLfT8RfVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472347; c=relaxed/simple;
	bh=rBXKrFCtqQn23NsGXenOxt58MnblgV0gD0Q1zX23u4k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t43Ti6+ejrOev/zDkFFr2XDpEhdaY8MT9ctcEiOY0NGb03/mVx1oWxXq3T0dcreu/vopvpX3ce6gRTri3oFlwOD4Kiiv5oE/rOpbiD9Ty6c8mMshgcvV6E4jvCLVDXlxVqOzgHBJ6pL+rHlmVuO+QctAjjkwVyZasEzJP3vQRiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ff1z2FDi; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ff1z2FDi"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-6329f0e0a16so4974704137.3
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 10:52:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779472344; cv=none;
        d=google.com; s=arc-20240605;
        b=dDBtap5aGn3DPGLxcu7RICnV8BEGi5LI5v2+DcEmn32jaBtzZhBUpXUmFEZoO9Jz8R
         O/5AfuQp3bB8BgaPZ+mj6MpxtjXzmthOrUbbM+bxyWI6Q0zEYmeODwj/Hak+YkaSKzMb
         0CsZ3j99JrZTlpGvGFobkhjh5v6C8wdZcFOkvy9C3F4q3c6iCG0HL83RlTlrz7pBuruo
         rUSDufaerDcW8fNsQRSfsM02dFRBqQUcatJNHDbRVOiowKQSkWzRzw8de9bwyK3wycsy
         2chxI8H41oWnCVKRW3KIJN7krH4zIFbASE2U3caWFNtgGOsjFIPwNaRixxhKki1TCj6b
         pKNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=H2RcXT/csKhGN2lVJmJG4zM8wrrdDzqA4ay1Hyt7J1k=;
        fh=HcRz61k/o2LND4Xjqebyo4y4I7uAWpbAQ1DEIT6vCQY=;
        b=FWMWu1VuIfy701WB6aupejzSdw2egYyJfbrizIVYzLWImoxjhz6bFPkA2hOe9YlAsy
         mXR2iquhLMPH0MgWlMLz02O0YLVm/Ow4lpZfRzGNnv2ScToncISJdFC+xv3yK62w+sJp
         mH1UTM7yHpAdRAxTFupe/XGZ+kbuvp/3+q4Q7Lq/JD+a2WltGd/1yB6UgIZwaP6I3g52
         VVAu0ZercJRU9VvM5e6nsBnrqzrkX3duioOVMUA0FKlL5RCUVqCOYw/6OKIp/H76aKu5
         49pceXLTBFzwZUmLF9jx2twE34pJM/wTBBI8GFPS2ZRJ7mrQvIIGdEEQDzLmr93n1Ank
         pGgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779472344; x=1780077144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=H2RcXT/csKhGN2lVJmJG4zM8wrrdDzqA4ay1Hyt7J1k=;
        b=ff1z2FDiaKwiNE6MyKYy7lgViFQeFM84H6G/F/vJor9U1ve2dr4BvXSFAFuiXWMtBp
         3QEIPlnX3bUvrudKLG7H6qslViPdL4Lq5IlGC7mHRDTs1FbdH7SZTo7nF3uIZUienun0
         PjHrMfVPCVA+onHDxGT8GjMLUzXUtYXNW35iMCiG7xDcefpIQSBMOZR4vH24OGPC5pNS
         fhPUpzQtMZKCuTSlmFYq4PRCX01i2wPRM4xEmbNDI3x028ekaJpiirKo23Voj/WL8HvU
         BXoWJq4f/M3NYxYKHnTnh04aFc9NcLhdYxeJ4uqkcANGDCzFgX9dAOc9js1sURGsr1nZ
         +VBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779472344; x=1780077144;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2RcXT/csKhGN2lVJmJG4zM8wrrdDzqA4ay1Hyt7J1k=;
        b=RHekB8Yome+oUHkMVEjFpCbfXzo7ppoeuCf9y+g+67Z/d2QhK6CmRKyTfLg/8TjVAy
         y0gXb8Bt6r+0e2CL6909EpDC7Ii/7IlgWVTsRHuUVHyRrinHzSHMYMKYYIpe9vjvRkjV
         AtBlGFDBkQ5T/yL0K5SYNYz5KaSNr3VKFlxW/NNg66IYZJJ6o/9b1HQEJRvwlBwwyoC1
         cuFMBCH2JrG9OSPLGRvdBxnRgaN5pD3GLIlGLk4pQ0l4Y78O/DYE9WWvHdWm4un6uYF6
         IhD91Gl4WFxTSHmBTdqAV+wZ0ZZPktLmac/PuIbteaZQOsWBqD3SG1WtGdO2MIL3QdYL
         hRAA==
X-Gm-Message-State: AOJu0YzdlGA7GQSi4mgd/j2AAFOYV9K59jaPC3iGhgUXVlAKidHJ+qBC
	rKpyUQ+1jMxY+gE5lisMRkccmVBVnq2Hy/LHCtq0Zrq1/gg3WE845SL8aM7rYTothosTIPumGLk
	55DDwNTD/jmF9Qr4LkKd83KAORKODgYAnG+f1YHWkn+zB3pH0w3rxtEO65+w=
X-Gm-Gg: Acq92OHkgYuYFz9+oNobaag18lBEY0AwKjtMmtxV9cdbRFJF+3CxHn3MSB4dmTfmg0G
	RnCE5nwk40PvXkXM7ltId5aCnIDuGAqMrwywFFXjiboiRtkHPgQV9AE79cKRowef+N8T3vpJDkn
	PiUCYKGLvcmno/YoStqgg01PG55F/Bg/2SJ6tI0kEVE5Xw0E48RoIXXqIu6uTLIDKj2qXaS+JiO
	H6/pvyO+c1gBpHmxVmgYKOxS4uDIINaM1TdAt1zFVTZABIhqaGthg6mps/6yUz+balSCsXNjief
	yip5213zTuXrhhVa9OltFKIVhczWhHNyy8Zgesui7Bn6kqYnc6ZQgAYv8myzsvqXhYXLs63dorv
	Wly2m
X-Received: by 2002:a05:6102:b07:b0:618:442a:9e76 with SMTP id
 ada2fe7eead31-67c7cee1428mr2834725137.10.1779472344143; Fri, 22 May 2026
 10:52:24 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 May 2026 10:52:23 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 May 2026 10:52:23 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260522172151.3530267-4-seanjc@google.com>
References: <20260522172151.3530267-1-seanjc@google.com> <20260522172151.3530267-4-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 May 2026 10:52:23 -0700
X-Gm-Features: AVHnY4KKvO2-aSgBR4j5I5rroPVPwYxV4MTlxwM2hI78BrmP8PdLCOoVktqneNk
Message-ID: <CAEvNRgGXmU-hWBPgETYg82D1j_YJZiAjX59fxq9pJNA4ftb=mw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] KVM: selftests: Remove unnecessary "%s" formatting
 of a constant string
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Drop superfluous %s formatting from assertions in the guest_memfd overlap
> testcases, as the string being printed doesn't require runtime formatting.
>
> No functional change intended.
>
> Reported-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/set_memory_region_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
> index be99c1ff5a5a..e0800bfb11eb 100644
> --- a/tools/testing/selftests/kvm/set_memory_region_test.c
> +++ b/tools/testing/selftests/kvm/set_memory_region_test.c
> @@ -554,7 +554,7 @@ static void test_add_overlapping_private_memory_regions(void)
>  					 MEM_REGION_GPA * 2 - MEM_REGION_SIZE,
>  					 MEM_REGION_SIZE * 2,
>  					 0, memfd, 0);
> -	TEST_ASSERT(r == -1 && errno == EEXIST, "%s",
> +	TEST_ASSERT(r == -1 && errno == EEXIST,
>  		    "Overlapping guest_memfd() bindings should fail with EEXIST");
>
>  	/* And now the back half of the other slot. */
> @@ -562,7 +562,7 @@ static void test_add_overlapping_private_memory_regions(void)
>  					 MEM_REGION_GPA * 2 + MEM_REGION_SIZE,
>  					 MEM_REGION_SIZE * 2,
>  					 0, memfd, 0);
> -	TEST_ASSERT(r == -1 && errno == EEXIST, "%s",
> +	TEST_ASSERT(r == -1 && errno == EEXIST,
>  		    "Overlapping guest_memfd() bindings should fail with EEXIST");
>
>  	close(memfd);
> --
> 2.54.0.794.g4f17f83d09-goog

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

Thanks!
