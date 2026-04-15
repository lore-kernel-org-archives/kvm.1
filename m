Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D152EB860
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265093; cv=none; b=f/nx/N9OTgTi9GyXaV2v3QHvo4xfpv9PCE/82/wJgFuKX/gCXaPZ2YT07ADyssG9KXXpXSdgGf7sWXLnZPGcjQiUVGi77ca2Fm7wTU8bwTGs/qnHYvFJcENuy7tMI3g8pbAyul3sLW6KTvDx7eC+FQ90XiwDs5LYXOEYvnZ763w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265093; c=relaxed/simple;
	bh=hhpVlgr1lWiBFQHTKUk5XL9zUJCYVJtm1j7QAZOqmgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzBzOqCodRfMAkyH2wNn+Q2Oz9ll2OJ6fDKT9MZ9EwgIHonEGDhj+Ujm49OZJntst2PkSSPq2AMAIq+EpNdIhYkkgcEDqxep2m6frfCV8vRLCFPq83k0Q7En+raTMZFnikNRsYC/FdUUKyMw26gEC57Y7Nb7QaUWaz0NR4/5x7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ip6rm3vM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E7xVscb/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ip6rm3vM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7xVscb/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776265090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B4VS5yt8upz/23YAzmep+J+R8sobnc1RAYXC71CZn/A=;
	b=ip6rm3vMUF///8snK3HVQu2ety7v3qxrM02AMIrU9G1Ez+5KLt7/vVQm8WD4KBvEOCkGhg
	79JlGj5vKi7GQG2zTwn4EsF/0sXEUjOW54DtsahP0WIZx1/QuSG2+MKzPwzLiIqxdd9qiC
	s1bKBMzINdyN/cCBFgeebt+Hm12Ilyg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-BWZvg-0KOiKQr-s_xfMrYQ-1; Wed, 15 Apr 2026 10:58:09 -0400
X-MC-Unique: BWZvg-0KOiKQr-s_xfMrYQ-1
X-Mimecast-MFC-AGG-ID: BWZvg-0KOiKQr-s_xfMrYQ_1776265088
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8acb3daf2d5so86672466d6.1
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 07:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776265088; x=1776869888; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B4VS5yt8upz/23YAzmep+J+R8sobnc1RAYXC71CZn/A=;
        b=E7xVscb/jy9+e/N2tZWPImoBEIiSyTgRM/WcG8VvRReThckjTJH1PPZP6Biu8+Hs6M
         ZgEc1qphh2Y7ZLKl7+XwpQRj/xJEe3EopkgS0UEP//tFLr3fc4mcfSRxDzuZq+DeQtRl
         TGA1vOBZLxLDtmtMXyLV9mgWyrV7ten3Gp6ZXL0wKkky0m79dZj+Yoy3bAzkKvAJnRZ5
         u5R+BokoIoM6NhsmAerpvMV2Ibo3Vk4kdv9EJNK9NFU12116ZJVRVq47Kq1+FWTOKVg8
         4cmbT0azWK645JIWaWlcdB9DCCpmt9PO9KmrWIecsQbIfTD+235OvGH5gs/ktC/MMi4m
         6IFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776265088; x=1776869888;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4VS5yt8upz/23YAzmep+J+R8sobnc1RAYXC71CZn/A=;
        b=IuAeCOFGVQ0auQ18vEcWaFECYZ0CxVO5IMK5NPan54obc7Tw48Sj9mZ9yTam8Z79QW
         uRjrENUTnXB4SXdtoqkUEgQDGb0FEJ1pVFe5kZJz+GPSD6M0JHgPrIbtxLJ1d2F6RU9Z
         /Nrk0+5IqI/Kv0cedR03RDmIUlCUNTopkVYBAgrotHj6+4zdLr3RewLsmGwavlpZQows
         mLN8G5S2ythQUugNV9MLbzFp1Kq2iVteKMVCHSXb/tKjqcQhMC8YRC+Fos1UekyNTFOY
         KuQSAvEYtLkfdVrW3pC/v0IHB9MDErklWjNTWLNY6KhYhtBVbQABa4d4xLeysL2AaZnV
         wQtA==
X-Forwarded-Encrypted: i=1; AFNElJ+2o5iEZmnEJuFMq77xwCaeeVsSRFjm/CQsDBTcmL5IIS7gPt8qyqeRdD3UdkrfsCdFt8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1XDgdGJPPi6uAgJ3zQ3MpVpJI/o8tnUVBs5QAhCVh313QDiaK
	QBrETcEgCT0T69GVbxK06EUxRBcMGmUj6iA+vOojJqbBEIbLhMsn5ZONmsJM33F8J/xdLLUFjV1
	LjWZLLaio17qn3CTxT+er+n8r0bt8HQrdiEg5w0KxWiKdL8476+0oOw==
X-Gm-Gg: AeBDievAb2lrgCU2Eaxu/ieYJkqKopz64pd80fctpLBL2lC/1T/j92HLeu0ooKAqOP7
	sefF7+25HudHnWQWr9zVRbtx+Xrj9qk8RF7872CVSOikq8lelSH7pW/9Ux6b3qZbhaMIj0q3uFX
	UauO4gQs/DZel2QHeDFU7Uy4EBFSZjaWjVwvfftXmQTaKaPuHAdAPLT58G45Kmk9psSk9/5Rrh1
	bg8MxvmZLYlf7M3oo09o3vK+nEd+Moe2y200BYn1B29VJ7n3v1fL1giCRcHxb5IQxVaIeTYd1nt
	kkePDPerDEGJthGKfSz+DSmqiY6pKE4UfP8MozFLg0dkBrLHuqKVIFwFDlToBo2C1jNcX8ZzlZA
	MYrfWumWY77nEmV/Bp6cwBHZqBfw3dDEI1iUtGUa1oCk8jB2cNiBTilGmiQ==
X-Received: by 2002:ad4:4ee4:0:b0:8ac:abc5:8756 with SMTP id 6a1803df08f44-8acabc58ad5mr198988056d6.25.1776265088320;
        Wed, 15 Apr 2026 07:58:08 -0700 (PDT)
X-Received: by 2002:ad4:4ee4:0:b0:8ac:abc5:8756 with SMTP id 6a1803df08f44-8acabc58ad5mr198987466d6.25.1776265087695;
        Wed, 15 Apr 2026 07:58:07 -0700 (PDT)
Received: from x1.local ([142.189.10.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6c938368sm16845966d6.5.2026.04.15.07.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:58:07 -0700 (PDT)
Date: Wed, 15 Apr 2026 10:58:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
	"Dr. David Alan Gilbert" <dave@treblig.org>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-riscv@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	qemu-s390x@nongnu.org, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
	Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 14/27] monitor/meson: Use SPICE with migration HMP
 commands
Message-ID: <ad-nfXeL0OlIb6io@x1.local>
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-15-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410195323.17937-15-philmd@linaro.org>

On Fri, Apr 10, 2026 at 09:53:08PM +0200, Philippe Mathieu-Daudé wrote:
> When moving code around in commit 27be86351ec ("migration: Move
> the QMP command from monitor/ to migration/") we forgot to update
> the meson rule about SPICE pkg-config flags.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

