Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A64B30F7FA
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576885; cv=none; b=Gd7GvHvWinVy1jYgplkezx79GPvyUfskvT+6Y7/NTolzWY9SR8Iuf4GZhHXYNH21uvjRrUHvkQpUHWerzGtMRO97pUpmRAvuEAVOpBZXOZqD4SHLIyPs8GTBRukiq/nX0Kbzksna41jjmKBb6W9mgrbaAyMI50wmv7umuojBWWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576885; c=relaxed/simple;
	bh=jBKIvvcbI3fXVhawc8Ua4dsKdGgdZIBwidjHTIGtinQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FiOMraBaPhEGDeRb3bBmI5LwlHu+hec/nLhmEBb7B62yDFk/YswGYSc5Qsa/KMSxTfyIjnEiRgPCSTb41QqVwZyv+Edpaxu2mWd0HI/A7F6Ftf39Tw1b6u/xeEPZykCw1NQFi0WALd2f0/nAiRT0Im9e27NUIFm3UoQrS5KWIkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VaoOWBPU; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VaoOWBPU"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce8a76df2dso190304395ad.2
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 12:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784576884; x=1785181684; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zUZr3AoZz7x+rnLocPWr3q7LF0Q0Xt33oDjZwWkJZmQ=;
        b=VaoOWBPU0bvSbgzwJD86RQScnnt+LuEs1okOlwb+I8RBcbyelf+xd55XjWLeV/FaLB
         4maGzEEN7s+QGHZWiomDAVoFS6ojjN8/iZVkHJ4tohpLlqkcaziiB8LnyKC/1pMKToCy
         KJMuzusXqi9pu81p/du2wEX0TRrm/SDKCDNUaKUNOSV5C137A+rjQscTqOn5D+xhesKX
         GFQPKId6boQzyZtyJKkRax35bjkx0K9tIhfdfx2dAAl7VoMkmi8Mq9XxZKlVKM2UGWfC
         zpv8mZQRi1bBQ3L8Aub0kIjoS+WuuO7q3lUSnLSxKXnhYvr8L8wUz0FO1Om5yV7mQMqX
         dSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576884; x=1785181684;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zUZr3AoZz7x+rnLocPWr3q7LF0Q0Xt33oDjZwWkJZmQ=;
        b=a8l5t1ypDpRRpPx72PM9o0tW3AyQ9xsA7rIVXRSCyhMVCZLJJ2ME7s6AxKg3dS+cgZ
         J2pgSgnAP5OeROL+zlqk9n3CRhtLVzgT44ocLomiAW1wLdgU//LPfaVQfwELrt5B7WQC
         IHOfnf1h/O2R+JzTSg3SxcPghFPueA/8P8jm24/ohL4mwe0PAWJ3221QbKB+F/53D6Hw
         TGZ3sYMaNoLgOPiaGRmrhLzhYGJepKRinV9l/LNhTvcgaJX+5xuqp4/zE3BCO2LqCJUK
         sZE6qC4FtqI0cIWwrjeCEgln1x15r4kKS6mTIud/+S4biSWUipcD2ayexdvL9KI9ksnN
         rFoA==
X-Forwarded-Encrypted: i=1; AHgh+RpVCefNe5/S5lcbGuUKVIzU8dnfDVlWoFWfUEFXur8KcgpF3UgvxelZ3JCUKoy+1Hm210s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs6zI1jRkJlVvVJ+5XE9kvyz359M0iUzFOVnT3KiEMoEpga6s0
	06sCNl+k0u249cO9zXPIPcYHBDT+GCenvL2XDFsEJO4q1n2oXJhRj5tDL6SeTld2po1Wj9K4NyS
	UD5KYbg==
X-Received: from plgn14.prod.google.com ([2002:a17:902:f60e:b0:2ca:ef0c:f8b2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce87:b0:2c9:bf82:dd11
 with SMTP id d9443c01a7336-2cf34895290mr160220765ad.7.1784576883533; Mon, 20
 Jul 2026 12:48:03 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:48:02 -0700
In-Reply-To: <20260715224030.3772948-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260715224030.3772948-1-jmattson@google.com>
Message-ID: <al57cigFjjvwi7nH@google.com>
Subject: Re: [PATCH] x86/cpufeatures: Make AVX512_BMM depend on AVX512F
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Yosry Ahmed <yosry@kernel.org>, Nikunj A Dadhania <nikunj@amd.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 15, 2026, Jim Mattson wrote:
> Add an explicit dependency between X86_FEATURE_AVX512_BMM and
> X86_FEATURE_AVX512F in the CPUID dependency table.
> 
> AVX512 Bit Matrix Multiply (BMM) instructions operate on vector registers
> and require AVX512 Foundation support. Declaring this dependency ensures
> that if AVX512F is disabled (e.g. via clearcpuid or host capabilities),
> AVX512_BMM will be automatically cleared as well.
> 
> Fixes: de0bfdc7137d ("KVM: x86: Advertise AVX512 Bit Matrix Multiply (BMM) to userspace")
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>

I assume this will go through the tip tree.
