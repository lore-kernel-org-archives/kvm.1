Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A656258EF3
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 02:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784860479; cv=none; b=ATp1LcDB/kbQLfp3r+tuVlvj1r3QYEDzkXUQhTtvw4zz7hfSoIuAMHUSqXHMkUJQ+yZedaxCC4Eya4mld0/5K1Y1/GzSoWtY0022V7HHkRkMiRuGjJM/Xf8I7ivedj4EqmWfQBEnVvHY4/aulJIbhqQA92+1Kl6RmBsb38jhsJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784860479; c=relaxed/simple;
	bh=hDdb+BfrNmihaIG42QuS7bydA/wmuRj4+pccWXdcvzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbIMfPIoiab8uL9R+zFdnwMtxnzoNbWkvcjugRrVt1DDH/Q9DjVILpBrNo+ipMckn7nYUimkUa3z92gry1pTYlqsgY60fjw3kwpENhrtXMafsqSXtTLHMdBpucxaAHGImSy8UmQSig05Wg27+pfMizgw9oho2uLhU1ZiFW8zrFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m7MYqQrS; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m7MYqQrS"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso1364601b3a.1
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 19:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784860478; x=1785465278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hao9oq14JeRrVBA4B79UShues+P6GguVhU59pwJO/cQ=;
        b=m7MYqQrSu27+jooVqqX+he+fFuxitBScGhhCib64hwguc5Sx5z/cu/cMI0tnguciZ9
         zJyKXWea1CkjfgILeWX0khe6nnAm0Wm5PfmwUdPug55XRC/eG+bZoL7LFaYhVGCknLkf
         sL0MP0H9XMXlkaxf6DWO1xQi9G3IuzMMeXnPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784860478; x=1785465278;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hao9oq14JeRrVBA4B79UShues+P6GguVhU59pwJO/cQ=;
        b=HRmKy8bdoMSrLlJCzQNg0e7NpyM4kpn+MqiBX196eVpaFMQUqVeDdO0h/Nt9Y3G81Z
         nsauzUNb1WxpjYSiG0YN0QkBsbWTfN6teVMGu26+UkCE3l7yCfeGlJDyA6BW7CL5RJbi
         IQPxq4NtHP2tOvl11NHM6BU7dpe/GkSO9De51eyg4PGdUplec6vKos9OQVFQN3k6b66J
         mi+ho0QAtZcFkJNREQGqO7rUcW46kM+SiXRxwPu2Cff8JFwS+oe+X4Lp7eQddjYNecoo
         fcg8WCNN1BaLNi6/lVUzbJH3qHN9Vq+qZr249gHgirrF1Il2xAID5BAYyhUj8JEFMHYT
         cNHw==
X-Forwarded-Encrypted: i=1; AHgh+RpIR6ba6TAt2LYKbjgqOBkVQunhsU4HbrS9RR2PGu1RJDwStcwj+L5r38wSCteEn0riXTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOOtJLVtU/Fatnko9lxq9xo8P13VAmrjWDBoJvJKEbnln4jFZl
	ewjWigwt1wQV2HQOoXeUExf12eW2UqxOeshm9sihlIMyLSEJx4Tf7YyCchqffCwgl7Ej0dwvob5
	rluM=
X-Gm-Gg: AR+sD10INxy6fWH7PnILBmu1u7uw89WyH4D9cH6xc6ldzUKNmEQ85LTmq/zOiAyVvoZ
	fgYJVxLrmWRc5i0GftkfzeA3jU8ckMGlq/Hir3lO0EydYYi6/gRgzM++4z5nGQJLUs5Zlv6GCmD
	kEIXvtmUvQ+avRkGSs0BekwLPDuE4hBlAkA1Dwkz1iGse5FzFEGaEekhZzOq2IImoMrKegoEyR4
	8EfXWwc0lmN1OVOqlmbHMM6fV/0s+Yf0XIk+f80Q1MFu14XkTEO2gqRUWotgg8hUv5VAYqA832M
	8Mo+pVCG50VK3/RpvHlbUqvdje59jgP/F0K8Cgh3kYVvU6EyLWs7kUfj/VfnRkcdKI5S4G4r1w+
	OsmVf7HASoHqJ3c3ht/u5M4XOx3zD8Mhj0gi1X/e5zpfT3E55GwqeDTRp5XGhXwxFnibHKNebyT
	5+CaoK5DwVPZQnBCTSWg7PGqLHRFB0AoPCF7jYEU3vYA==
X-Received: by 2002:a05:6a00:1913:b0:847:8b1d:230d with SMTP id d2e1a72fcca58-84e2b7e5dcfmr6519653b3a.3.1784860477746;
        Thu, 23 Jul 2026 19:34:37 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:c102:f12d:5168:6be5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17292c31sm3825061b3a.26.2026.07.23.19.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 19:34:37 -0700 (PDT)
Date: Fri, 24 Jul 2026 11:34:33 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y v2 0/8] KVM: fixes for CVE-2026-46113 and related
 issues
Message-ID: <amLOOOMHjEO4GlgR@google.com>
References: <20260626112634.1778506-1-pbonzini@redhat.com>
 <amG2jCgWugrVroyZ@google.com>
 <2026072336-stout-tartar-f586@gregkh>
 <066fa1c9-8b2e-47ed-8b0b-6b0ff0663aed@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <066fa1c9-8b2e-47ed-8b0b-6b0ff0663aed@redhat.com>

Hello,
sorry for the delay,

On (26/07/23 15:36), Paolo Bonzini wrote:
> > > Sorry, forgot to set proper In-Reply-To [1]
> > > 
> > > https://lore.kernel.org/stable/20260626174620.1819772-1-pbonzini@redhat.com/
> > > 
> > 
> > It needs backports for newer kernels first, right?
> 
> Backports up to 6.1 are trivial, if anyone posts them I'll ack them in a
> second.

6.1, 6.6, 6.12 (and 7.x) already have

commit b1337aae5e194324e4810d561764e7793f8b3864
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri Jun 26 13:24:36 2026 +0200

    KVM: x86: Fix shadow paging use-after-free due to unexpected role

commit e9d4ea13aa2b6400bb10ec64b370ba3dadcd22f0
Author: Sean Christopherson <seanjc@google.com>
Date:   Tue May 5 09:08:12 2026 +0200

    KVM: x86: Fix shadow paging use-after-free due to unexpected GFN

I suppose these patches are enough to address the vulnerability?


I can take a look at 5.10 and 5.15 backports but I likely will need
some help.
