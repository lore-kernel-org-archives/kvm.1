Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5405F3002CF
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258158; cv=none; b=lFy+C8yyBIGv9jILJLz8GWhAdWLfRfYroPiQpMhsd0Ua7QxTfvUqvZrmeuh+pm8yHPhKORkWwwGiE2t8s7ZHohSZNN7PA0F119ZWQiIhWssO7cnj+rFr5x8sea43m8AYRpq6CP1zV4psoeujUM6oKgZbF5A/Siin3RWxfC11aE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258158; c=relaxed/simple;
	bh=7CDtzh4z0CdqypNI8DxFycAekERpE8E986pd4O2J03c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VSwPxwXwgEAweU3ddD6ROWsUSPg1GHU2ixi2ALW8rEOWakendGbWqxgpr+0S0/+l/oBWz1SVqrLgviLxNU81PgeM5NvlNwpTmVq59ArVKvqyehNeAVmNrMy5dCGFoKZsamdL6iW2Sz+A8+Kv0HIU5d5rFcvn265pkpseKabU8fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZIgz69T7; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZIgz69T7"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso14765655ad.0
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 06:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790258156; x=1790862956; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KkxGGQAcZQfF96GEV0BfePCSivvqi5OVjJFPctkp1vk=;
        b=ZIgz69T72VRjYmeOGg3jTSzTSVVRfI2esIxCZtXA2q71RUJAB9oxhH57bZrSaQhXz3
         QBegtAo+IkrQV2Wo+qaHod5STXp9clM1h39wc7zOZ5E2LTUhkj8acroVohKmjy4dkCcR
         LclkGl6e518uCASlDkIBjRbx6XHllklP99S1TzszvYWQyatu/JRfeIYuMFUWKbZqiHIQ
         HyEpY0IfzAIJW1BrBYvRpf6eK2/UQi3hiKggPxEKRX10tU4rS8Lh8BEiCwEl/KRHWqMD
         DPrM1LcmVuPdVCyaodOrAWTbEo/kUvhhDIVWYNZLxhH044c/9zMfOWnunxESp/lAjuz8
         BRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790258156; x=1790862956;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KkxGGQAcZQfF96GEV0BfePCSivvqi5OVjJFPctkp1vk=;
        b=p/+KWieeNU5CnaVKNrtI2hNGV3wDymrGREt+BK8zhw7VCxDxmCNYroUS7ZPmK0XFaa
         HGBgoU/pxvcjZswtyY5jzVHO1JSerODo6KV5c6PN7WVYpE9TzFjovr5kIN1tf+4rfcL3
         0q7R4o0G5QMBYXiRx90Udl7LgolbVhKMXH9O3Ax62coz2z+t32CMIUx1MKDwr7swfsTM
         hSOY/geE41DKSPEerwgcjK7zQpTKiKRVwi0ysKbCoJbtbCBiZuOQ+a+FOaOMTTlTMKW8
         gcoPmrdNAPvS9m0jrJyr05EQUryiOKqh+bPI/gvM2B1taiR7MBYHQGAyTxHjFd90oe8J
         8vQw==
X-Forwarded-Encrypted: i=1; AKwUvBzw2fPxF9Yov+4uvBzJ6MCiGnuPvmKz7bFs6IDLIB7ywUswuCthOZnBbwKqgyJawnV39vY=@vger.kernel.org
X-Gm-Message-State: AFuF++kb1odMlL/y7zywjY/psLs7lHqJ4nAOA1j/TIW/oD+ySIpUZ0E5
	lIRVpoNg5hO5WGwt0+j3YR1y8AFkj5SLEJsI8xjsx8R6FQeQICzuRbhwLsy8zQOFTuCTipwEM/f
	X3DcXuQ==
X-Received: from plbm10.prod.google.com ([2002:a17:902:d18a:b0:2df:69be:94b6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2310:b0:2dd:ad73:5b74
 with SMTP id d9443c01a7336-2df7dc36d85mr22967295ad.36.1790258156375; Thu, 24
 Sep 2026 06:55:56 -0700 (PDT)
Date: Thu, 24 Sep 2026 06:55:55 -0700
In-Reply-To: <arUGoepfp97GY8aK@blrnaveerao1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923155108.1550622-1-seanjc@google.com> <20260923155108.1550622-4-seanjc@google.com>
 <arUGoepfp97GY8aK@blrnaveerao1>
Message-ID: <arUr6xuC2d7A_ZI7@google.com>
Subject: Re: [PATCH v2 3/3] KVM: SVM: Clear AVIC Physical ID table entry if
 vCPU creation fails
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Atish Patra <atishp@meta.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 24, 2026, Naveen N Rao wrote:
> On Wed, Sep 23, 2026 at 08:51:08AM -0700, Sean Christopherson wrote:
> > From: Naveen N Rao <naveen@kernel.org>
> 
> Nit: I noticed this because I thought I had fixed it, but the From: tag 
> above does not seem to carry (AMD) attribution even though the patch I 
> posted seems to have the correct form. I checked 'b4 am' and that seems 
> to be doing the right thing too. Anything I'm missing?

Nope, the problem was on my end.  I was running an older version of b4, and it
was dropping the "(AMD)" part.  I'll manually fixup this one when applying.
