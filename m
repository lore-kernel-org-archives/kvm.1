Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED943B4EAF
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784228388; cv=none; b=qZyFKKkBz0TNaC5PtKscnIqACqg+TsFUjpu87NenxWf+n+T5PZP6sS6TND2HL4HaGfMqFFfvGNH6NugvLjBEFxOQRyfaUhUmN+gy3OWEJBROUlKKaJZUKQNA0W5qlkjDfD45GKJAVF5Zn+hHW44+2A84bEJsso2hLm9Q7UWvog8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784228388; c=relaxed/simple;
	bh=+vx12DnbrH1jEO3hyC82AQB3qS5V7/xSoVL7LiHkQ68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQMSXguwbZokGTKJSJFIu2r4+dZCBdTwmhNAH1MIZ3+6VctezVIhdP5Ujso4V2N/Jt3R4SSf5wwENvC8TMCuOEIEX8g/gDdSAPZ5SMjAWNpDsqCRaDvqw5h0EZH3RapMwZ2ST9iQbNxs4AHmK7xMuhvQAc5kihhCyr6MMwbCb2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeuEGCcQ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeuEGCcQ"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so10225641a12.2
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 11:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784228386; x=1784833186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bpwBCMUqOktawB/a/lGWrgRdo+N7QGVrFJhgBZS8dP4=;
        b=GeuEGCcQH3ItJLJJTIj/+a1WALF+NjLPuhoIZJL8l5/Euwiksom+cCq6BnzZ+qP+Dw
         IOeN5tP5J4BLyEtQqRBr38NG8S7E35jnjjT/NU8xuJd9z80PraCDdlrB0w4CEdwYrSEJ
         Q7CpjyvH7ttp4Z2wm64U4i0+ghDUkhiyhHv+t9EnYsEywcjYug08ryPiqNsHt257pofb
         1dU/9JxR+IQGaZUVxyMBejvvnyNKwnmhlFxk7MT7Vpnn+sNLaTI0f8CI0OBsR5pZBAGW
         UsElyW7awjPGXMSa1+2coHfDjunNo6gpqT8gZA3aqStcvcWzQ/Jo/WNUO2pjGN3iTNVF
         wQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784228386; x=1784833186;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bpwBCMUqOktawB/a/lGWrgRdo+N7QGVrFJhgBZS8dP4=;
        b=JUQNmKgvJtJxYhxgi1cr+KSZuZDj9vnXGX0QkpUP3G63LcJkGCvmBGpVXvegfCHc2v
         64puKem8Hogc9C9g7aO9oh9zeyK06YadBsjwd0VQUSXRJWPsw5Eoe7Y1NraLeLkQcUyL
         OoICvunwrAsz9Pbi3vV+JsnTpyPh5itSupMsLzvfNxMmIcD/Cw91LjWwoFjsnMQT62+i
         mkPt/+aBQ+1eaU19lUY/62ecy6//pq6Xt1HaWmQFYnip0ilYtkB5B16ayjtwvxBCTh6e
         N+Cf01bj+RC+FPLWYWTj+/TzPlFehoeilaxUhojK4rHmWRoNu9HyNGJV+PXCKbeEPhFg
         NnsQ==
X-Gm-Message-State: AOJu0YyBX9uQO4IB0iMbQa/lK1eUS5Fg3wCHB79VIsQSF6iMOR8mBHDZ
	zaJmX9nfRc4I4TgD8fji5plukbtKW56ny1ZAguudkUysb9NhFeC82EJD
X-Gm-Gg: AfdE7clxeFyPb2wUN7p8hJfm6JdY1GdTPG4dDCzT8bthllY3Qq/zWP1Xckg71TWJ0V6
	df9wLBvqv9tW+aKPcdFnEeK1/YqU8UPqjieCgI9PgbzgHau8Js2iiqboVrdbirwxTv8x6lHdkTT
	xI0y9xqCQAbFfyNwsszeHwh/bxx2qGve3CODoCIttuei95uIWyYXxZvGrWklJiN/UhqWl80qHBK
	bOb7I2tpAaoNW5zBNtmp4WNmqInZUsDN67g27uM7eKDjbkdKh17fBS7cauHJOnnT3JpTdYo6erJ
	UCnvNIaejrBT23RL5AzAUxC6PIc+XKMiRe+qPvVocYkmD6qyWQe+g3noZrwtY4ZVr+K/OiZJgaG
	g3ALOm7AwRCSuflgc+xViKJ5z2eKKGdT0LoCX6QKGwefBM+gMQetI5e3XxBia2hA0j0mLsgo7sj
	+xWz4bl3LRE4cz0SMO5fsgVjnMijlNfpmMfmsv7JuQxnprXfyPJPegxS47A10fG/E=
X-Received: by 2002:a17:907:9485:b0:c16:5867:e098 with SMTP id a640c23a62f3a-c1667ad9fe4mr699209666b.40.1784228385516;
        Thu, 16 Jul 2026 11:59:45 -0700 (PDT)
Received: from localhost (226.55.classcom.pl. [195.150.55.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1687126353sm269375566b.13.2026.07.16.11.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 11:59:44 -0700 (PDT)
Date: Thu, 16 Jul 2026 21:00:13 +0200
From: Piotr Zarycki <piotr.zarycki@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	vkuznets@redhat.com, shuah@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selftests: add swap() macro to kselftest.h
Message-ID: <alkp6pv1Z-zHTka6@arch-piotr>
References: <20260528154003.3594107-1-piotr.zarycki@gmail.com>
 <20260625070914.2175124-1-piotr.zarycki@gmail.com>
 <ak-2To4F5tNjyolt@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak-2To4F5tNjyolt@google.com>

O Thu, Jul 09, 2026 at 07:55:10AM -0700, Sean Christopherson wrote:
> On Thu, Jun 25, 2026, Piotr Zarycki wrote:
> > Add swap() to tools/testing/selftests/kselftest.h with an #ifndef guard.
> > 
> > Guard the local swap() definition in mm/uffd-stress.c with #ifndef to
> > prevent a redefinition warning.
> > 
> > Use swap() in hyperv_tlb_flush.c to replace the open-coded PTE swap and
> > remove the TODO comment.
> > 
> > Signed-off-by: Piotr Zarycki <piotr.zarycki@gmail.com>
> > ---
> > Changes in v3:
> > - Add #ifndef guard to mm/uffd-stress.c to fix a redefinition warning;
> >   uffd-stress.c defines its own swap() without a guard, which conflicts
> >   when kselftest.h is included first via uffd-common.h.
> 
> Why not explicitly include kselftest.h in mm/uffd-stress.c and drop uffd-stress.c's
> version of swap()?

Dropped the local definition entirely. Sending v4.
