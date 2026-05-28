Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00BF2D77E5
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779936910; cv=none; b=NPCh4FYG3Mz1ECCY5lNO5WMl+q1mCkzny8dVAziUPLejnlKI6je90doSRM5P7wEA4ry1cwuorE0MLw9vo34GkCNCslPuaBV8kwzNAzXW6PCCTMKaQvYDAm0qmfawYSXi7si3Ke8tSX18KlKBQke6VLRB0uqDpIpNmmX0uI6aw+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779936910; c=relaxed/simple;
	bh=nHtCmI+YXidDbVULi8HpVo9tIMrpKGxlalzC4eJ6hIs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vb5pTMAF7p0IT2TJYRIyDbwNEYl3aJjGhkvBhr/tQ1GskgjeqCIepKglU2acupvgWyvFavIIjHhrpYQlcdP2NhwmA35Ei4X8Wo+L6Sw2RCAbY6ce+3ygqsC42bdOzdCBs3AXLMbylUYN3acVXQBNehQ6BIAuHVcYKaXSCeQA+yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JgKOXCdh; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JgKOXCdh"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3662e7756f0so10021452a91.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 19:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779936908; x=1780541708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sNW6Dqzh+koTScsgmhHOBSGeHzYjxmRZWBDvvxJBZAg=;
        b=JgKOXCdhH6cl/9PbOW/pHTcf+GmgIrm+ZzJ3KaoLhxwXisb/ZMtGMEyPNQKHqGSjpV
         W/NN4u8llE9GDNkNlE2dSbcg2ftG5jXIUoLsECy6UMU43W48opYNg50TboSWQ49XBUce
         jLLHWkyZxytx3ZjN9O9Swh4xqZjCi/3vYkjhUEKNlDv28bi127LjiGhGGJElqstPz/G8
         ONgo1oQxONZFYSx90KXlVf5pIFnKcyiqvONK2wkZj6qGNBlQ2AjjOxQZlGt7q7YEJarG
         My8ZUwdyxctGxt+gAhwh2iWekoCBGnCIyh9PpaWcIC22eqScrAJwIE9zMFqRGQ3X2FpX
         mi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779936908; x=1780541708;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNW6Dqzh+koTScsgmhHOBSGeHzYjxmRZWBDvvxJBZAg=;
        b=sAuGd6mkna4tl2M5ybx4aUUARhgTChO5NT6hg9MhrxEoglckr8S55h92nhKNgnP3Xr
         +gFpBvkuMo+9AcfeJRRkJeMQ+NbzSHkna2HhuA38+BnMMpirceiTGthOBI/OEMFgcH5R
         FYOQP+aiV5l14HPMI6zWBJlsjH814CUNgZORN8dQy/zIDjYtgD8cYAobyywiBWojGYEx
         Lj/zjgcB+QVWpjozB61tKq3h97CAPcJ4ljV/qu/HBY0SlwlXes5h0DurJUJtvgSqGtnb
         pFmZRrXWkMtizIa+0FCCB/oqjmTHxpt3Na65Owk5urajQVaZ+sGAKV3lB44HmbK50gRG
         sc/A==
X-Forwarded-Encrypted: i=1; AFNElJ9vxcCDCUljA9EvEb71aMp+oJC8HI/jQl0eOrZmLWSic5lsK2AmeuQl8Gx6/UWWW0qJOqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUmqhNC2EYf2d4er2e5L9xHEZt1Ugyc4xGFPsWbwOzTbqaNjXl
	lKvQrwznqGYMjWeoTlPEaVvyEEFuTXibvUOyJLOTNvRkrm3GT7DIf0jtXtGVOXOyAwfmYV4c1Fw
	dl/Ne4g==
X-Received: from pjsi8.prod.google.com ([2002:a17:90a:65c8:b0:366:191:7105])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2cc4:b0:36a:35df:769c
 with SMTP id 98e67ed59e1d1-36a67505a3fmr25971862a91.15.1779936907804; Wed, 27
 May 2026 19:55:07 -0700 (PDT)
Date: Wed, 27 May 2026 19:55:07 -0700
In-Reply-To: <CAG2uPc6YKSHWgkxFNb2-AkD731rvU+w4umrKpXDApzHfjE+kFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513124846.1622462-1-ewandevelop@gmail.com>
 <20260513124846.1622462-2-ewandevelop@gmail.com> <aheLxW0meHNVhDvc@google.com>
 <CAG2uPc6YKSHWgkxFNb2-AkD731rvU+w4umrKpXDApzHfjE+kFA@mail.gmail.com>
Message-ID: <aheui4vnxpS7BPtn@google.com>
Subject: Re: [PATCH v1 1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
From: Sean Christopherson <seanjc@google.com>
To: Ewan Hai <ewandevelop@gmail.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, cobechen@zhaoxin.com, 
	tonywwang@zhaoxin.com
Content-Type: text/plain; charset="us-ascii"

On Thu, May 28, 2026, Ewan Hai wrote:
> Quick question before sending v2:
> 
> With the definitions moving to cpufeatures.h, there are two reasonable
> ways to organize the series. Which would you prefer?
> 
> Option A (6 patches, split by subsystem):
> 
> [PATCH v2 1/6] x86/cpufeatures: Add Zhaoxin SM2 feature
> [PATCH v2 2/6] x86/cpufeatures: Add Zhaoxin CCS (SM3 + SM4) feature
> [PATCH v2 3/6] x86/cpufeatures: Add Zhaoxin RNG2 feature
> [PATCH v2 4/6] x86/cpufeatures: Add Zhaoxin PHE2 feature
> [PATCH v2 5/6] x86/cpufeatures: Add Zhaoxin RSA feature
> [PATCH v2 6/6] KVM: x86: Advertise new Zhaoxin CPUID 0xC0000001 EDX bits
> 
> Option B (5 patches, each group end-to-end):
> 
> [PATCH v2 1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
> [PATCH v2 2/5] KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID feature
> [PATCH v2 3/5] KVM: x86: Expose Zhaoxin RNG2 CPUID feature
> [PATCH v2 4/5] KVM: x86: Expose Zhaoxin PHE2 CPUID feature
> [PATCH v2 5/5] KVM: x86: Expose Zhaoxin RSA CPUID feature
> (each patch adds both the cpufeatures.h entry and the KVM F() use)

Option B.  Thanks!

> Either way the total diff is the same; just want to do it in the form
> that's easiest to review. Any preference?
