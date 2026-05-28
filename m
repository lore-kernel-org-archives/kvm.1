Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0F2278156
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977254; cv=none; b=ogdDjFS70oo9QdHisWcmsPT9GAbix5YBO0OWIqQBlzNSHX45ntvn21I7A3ZLRAsMh80Vjm1rJexwYhxMkauQrMVKz5VMDDtV51z65pSwsqalXWvy1dyApcWwBbHuXSgGNStHYnwt6q6LrWh5lQ80o08LUpV45MnWCKCtQ9XKEIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977254; c=relaxed/simple;
	bh=2pkvGxgADbS7lN7SVev/d7FTofxmy+WcMJdhfAc2WkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DscL7Ua5dqoYwkp5qcCOaSjIiC2agp/T7FT/pB4GiV0WRLXeRjI6wtMD/UThb5ZmzmzHdlpBvdZAtusbYxjr+RQdfnPqf0jGBa/tHBqt5NPMkR7Sv1X8Wtvv3WIH9SNdPx7AkcNPGzsWdpdsZzYiVi3pFPam9fLsuVr/FipXqaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0kmtYDF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0kmtYDF"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bce386d5b85so1928839866b.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779977251; x=1780582051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DqwQ43i5UxZnypk4nLtxsv3svle94X+tfPaE030Lwh4=;
        b=S0kmtYDF+9wzUWTVK/IVqBoO49W9vx4z1IctqLO7EV1jYurGYHpEnFMeUZRgDHTZN8
         JOgY1gFpaM3YDPjg70hjOKMHFElGLkkJAziRdUbAJq9/5Qok20oWMBWb+RiIkM2sPVv6
         +4OxnKDlbpBILa4Af/LPPKXdRQdUDk6pfVcDVahqnq0rYyC685CeljImDjHYcM3cZwEa
         max0EUzsSgYfjjwaqraqfPWul1rwzji9zCGOlzvm7coZXptuPL34Je1qW6Yhs1/7Xgko
         5t8VJ8M7CZDy/mxBNwhpWpcsxWKBtLNqwa5YQ3gNKUkeDfNlj7NnLwdFQrAqU1uHKL8q
         +H4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779977251; x=1780582051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqwQ43i5UxZnypk4nLtxsv3svle94X+tfPaE030Lwh4=;
        b=q5Sw1HzP0ib3+bxs2HwIEkbYhLP3vPTKUVUWxIKSRckbuYNWgJ7IzszfGKTy0wdTs8
         XwldzoARBDByuUOTsPjmdGj9BxlDL2T+vv9S5CRON8u+3m0zdPQQ+SDaz8kCEHzl+UyR
         jkuV+UIaIgfbykv5ynLIg5jLTnCJ3Atk/7fvoGs+9RTLvQySH13ROsskIZ2QI/qcq5sX
         K3unnhxb8riT0vz/TNkQ0tTEEY1XQFefnci8+cO/NI2HYSm5jEufOt9U5rQy2HEAQfL+
         7/FLgLaIEUKuh1fqNUURvmfzi0HACsKA/TCBRiIe+bxn+wOoU21HInFA4HmJwCcATO8i
         x57A==
X-Forwarded-Encrypted: i=1; AFNElJ9ZTsrGGn/3usRiWL/Pq9RuVnySD+8g5kVxdxs/UCxDDjLaHbbJXfufUTvXqltKdxj7viU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUsYbBN3cfTQtSgyFL+a6lDQltVKdfVDZVvg55regw502NXlNz
	TasisraAccxQm0yqtn7Up5nQ0ZHQZUlKAcJgkFFGkqRZerWSQHe3DDpP
X-Gm-Gg: Acq92OEb6kJenmLJz3/cbH41hafH+3U0qtrYtyfRs3NO9prVSaOb9RS7UOiiRNHQyUs
	PIGFVJcY0b4OW197itzClaxtP3tMDwgYEh45/o2LDX4L12vi2jiz1v5ozFT1kyARpGt9aDXs0MK
	e0qHcfeSnQHUMxV9pcWf7Lpl6L5qL0VGXoMivkMceqq2wmAJTi/exwPyapgHEsra5dVzhhtP4DV
	xu9jxeRzqtO6eKHg+V65vBCZEBElX3EsuHYOg5yA77kt38GPO/khF3ZBwtBUJ3bEmYI91KILkFO
	GwVr5pdG7gAzTBzUMpQDW+WkXYtIlVZskdxVw+1ujbTpfiJlPgWcTamtucomH3E16fxxZvH/Eg5
	JoKmeXyVAy/dz3tPC350QlIP0Fd1vJpP9RmuH9GANgEShg2z08Ks3ZC1L/kvNwBD5CJ5vE7M4Oq
	YDM51dnhv7SUPycg3iEEYyhpYGVfrg57sM+IfIojLcuNL9e0DGEXFgdPO75v9cBLfA+cayY9rIk
	22WRN52zdc+
X-Received: by 2002:a17:907:75cd:b0:bd3:897c:7800 with SMTP id a640c23a62f3a-bdd25cee478mr1301782666b.15.1779977250862;
        Thu, 28 May 2026 07:07:30 -0700 (PDT)
Received: from localhost (226.55.classcom.pl. [195.150.55.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be8a8637bb1sm45031366b.39.2026.05.28.07.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:07:30 -0700 (PDT)
Date: Thu, 28 May 2026 16:07:37 +0200
From: Piotr Zarycki <piotr.zarycki@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, shuah@kernel.org, dmatlack@google.com, 
	vkuznets@redhat.com, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: hyperv_tlb_flush: use swap() to swap PTEs
Message-ID: <ahhL42X1g76o5AXN@arch-piotr>
References: <20260528094542.2529735-1-piotr.zarycki@gmail.com>
 <ahg_bNoktd0XOKV8@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahg_bNoktd0XOKV8@google.com>

On Thu, May 28, 2026 at 06:13:16AM -0700, Sean Christopherson wrote:
> On Thu, May 28, 2026, Piotr Zarycki wrote:
> > Replace the open-coded swap with the swap() macro.
> > 
> > Signed-off-by: Piotr Zarycki <piotr.zarycki@gmail.com>
> > ---
> >  tools/testing/selftests/kvm/include/test_util.h    | 2 ++
> >  tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c | 6 +-----
> >  2 files changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
> > index d9b433b834f1..a66bc9ccba65 100644
> > --- a/tools/testing/selftests/kvm/include/test_util.h
> > +++ b/tools/testing/selftests/kvm/include/test_util.h
> > @@ -26,6 +26,8 @@
> >  
> >  #define msecs_to_usecs(msec)    ((msec) * 1000ULL)
> >  
> > +#define swap(a, b)  do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
> 
> This belongs in a common tools/ header, not in KVM's test_util.h.  I don't see
> an obvious place, maybe tools/include/linux/kernel.h?
Good point, v2 below.
