Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A60D3750D6
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380749; cv=none; b=RsYG5XWmc1v+LG0iwGf4UvEKkXg6LQSntxYF+qhbCe3//2BTDS5Hwc57Hi56P+uS3oKQsAmwKHyHrKOmsBGF/1fvZYgwF2e/u0VPBPi9wm2GKCSRJmJxDG+cxUwtauneHmwa40uzQvmKqncpVa6fooEP3URO942U+bAQIZMCjaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380749; c=relaxed/simple;
	bh=MzxU/J1awrDR1UlPUmHqYbpDoHpLyAXy1DUUfKLMUgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fI+2iywiIBd/Dr2G9fapFAo9R048jw3bCd7zh93PHB+8DFVO7HmbCR1UocwVu3vIu3MknSnL4vUhQXbcvaxJP1Bg/tpKlYJJiJvztBl1E1qRyUVzvWjSuBpAr8mpx1w2370tc8kIHch0apHpNISVymwyf2LayWEVRgFoiooRaEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XvmpkF/Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wh/rsvap; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvmpkF/Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wh/rsvap"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779380747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=piptpT6soEok/x87g5hkXEwk5cb85gwGRHFVO4bjzTM=;
	b=XvmpkF/YA4Qsvzhoa/UstIwxDpii8Xti4q8bT3ClWbATU65kCej8kJtYLDrWLk7T5D9Yor
	KVp+tldh1V/X2ycJzq7W0g9Dk6MeR22hVAP9nNaWJ9fkCkewrxt4NQ/O+fmX6y88X9/cKC
	qmY39feSAfkWCyOPQJMJPGHrU1g2mD0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-8C4JRZ6vOMqlu-CoR9O0qg-1; Thu, 21 May 2026 12:25:46 -0400
X-MC-Unique: 8C4JRZ6vOMqlu-CoR9O0qg-1
X-Mimecast-MFC-AGG-ID: 8C4JRZ6vOMqlu-CoR9O0qg_1779380745
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fd233d1e2so58040835e9.1
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 09:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779380745; x=1779985545; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=piptpT6soEok/x87g5hkXEwk5cb85gwGRHFVO4bjzTM=;
        b=Wh/rsvapY8njOT6Xkw/rwJ40iks+Gcb+MiUgZ0YixIhKm/UMFdQjDkq8hTVG6oYXWa
         ErNEO0QO3fGT8NK+V89UJP0M72avdeTBZmMTjSX45OnPT/K2WfDbbm27JtgfRd71uegw
         gQFN2ktnNXuiualu7Op4LRTuSfLH3ZBmsYqv9CGN/EfeP5ody3fkOQ5xrj5WA8Z1UBrP
         kI4+InEvFCcishoq5VsmBhy8rbqPUdQ+w8SrUHi8aavHsp50jSIBxcrkODb2k4C8UNzt
         25ijlUslVJRx3lOa9cC/6sXGIQleE4/KwsKhIF4rZik9ZOtEN6agup/FCO0o0kUG3jt/
         90NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779380745; x=1779985545;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=piptpT6soEok/x87g5hkXEwk5cb85gwGRHFVO4bjzTM=;
        b=dm1CPLlchpnE3VK9XkcB1dUtcNEBFRqp+bELTsURDai688AQsj3s6aYWNl1+GtX8QF
         YK6WgFb6G5Zyw2oJB/vogrxwz2BWMBQ560OXDYISl0H025V8ggnTqySVM0XV0OmPkgfm
         nLnD57t6IrL0g9ffv5iX4Bl6UAf+UcTJNwPsrlj4muNDu8eQPpF/qmr5S8q62RvVj1eD
         9wfKcc+KrouWJLnvXCv3O4Kg56hWrUa/61UVMM8VlXZQHcl2MIMEOy338AgeAyTtqyZL
         AV5F80oekJG3uGyMoaNe+2kzpgWOcSYKTgPYmpxYDJMtfsChWCRGXYNIuU5ZHsJLL214
         au7A==
X-Forwarded-Encrypted: i=1; AFNElJ+bi3QoBZ0PmVTz3IgXHsv4BJ3ZjZcS1Aeb3xJQ4Sm+n38P+HpkiGi1t4bjq/yUpw3Hi4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrvT9JmwO9yem1SaqqBMSpwYSBPdZAYYdPwo/gBHcHVdb78Yuf
	0SsmJUPHfqAohwuba60TYp5WvcAIjrfCDTXUKmCzjvEkxCl0LdI4kt5TGMe4EbKB8gYm4XDNULo
	NHZDO6szhTwhgRsovrwKwMEzzAL5BQljlxFHzdLVAd/iAJSXnSokNzg==
X-Gm-Gg: Acq92OELm4Q2lGWa9xeQOxv94QpHMjCAlYG2JqLQ7QTZOkieHhtwVK6r0L1xK8SwQMN
	zsgVIR3YSwU3N9naxJjcbvORu43h/k4lhs4aYwDJCc61shBy8U5A7s7B7CiU1vJxrTKUxWzD1JP
	GHP0Mfl+dbnSVwGF9T+uxRJqQxoUwxpO7K2dKk/4Qpi43SO47MYe9aw6li4wAx4FpC70pIDE7Zt
	BNqTl+7y5wMC8hBRZCIsPyuYFLT5kxAVvcVJx9GK87Y42LUpDtuKBf31gH9iEVpMNrYYgbSLeiT
	42Hv0XLMLmk4OLvQkJI+gjJUirniYLx+8Xgt7uZeA01U0wMcnDtsCx+YPFw80UyaaXNtO7U7BuA
	XKu3QGTAv7tefjd3Po+rcEKkOHQrHjl/T6PZa69blawC8gTs=
X-Received: by 2002:a05:600c:888b:b0:48a:568f:ae6d with SMTP id 5b1f17b1804b1-49036041d5fmr39410355e9.8.1779380744635;
        Thu, 21 May 2026 09:25:44 -0700 (PDT)
X-Received: by 2002:a05:600c:888b:b0:48a:568f:ae6d with SMTP id 5b1f17b1804b1-49036041d5fmr39410045e9.8.1779380744194;
        Thu, 21 May 2026 09:25:44 -0700 (PDT)
Received: from x1.local ([142.189.10.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49041740c10sm101515e9.1.2026.05.21.09.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:25:43 -0700 (PDT)
Date: Thu, 21 May 2026 12:25:40 -0400
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Zhao Liu <zhao1.liu@intel.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"open list:X86 KVM CPUs" <kvm@vger.kernel.org>
Subject: Re: [PATCH] target/i386/sev: fix MemoryRegion reference leaks in
 gpa2hva callers
Message-ID: <ag8yBA7jpCo9dYR_@x1.local>
References: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521145451.1831984-1-marcandre.lureau@redhat.com>

On Thu, May 21, 2026 at 06:54:51PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> gpa2hva() returns a referenced MemoryRegion via its p_mr out-parameter
> (inherited from memory_region_find()), but both SEV callers were failing
> to release it.
> 
> Fixes: c7f7e6970d3b ("sev: add sev-inject-launch-secret")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

