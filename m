Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7481223BD05
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 22:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775167919; cv=none; b=N+L1k7gLDhBqdrv3hWqnkhMDxwOv24gQVR3uug4itEiS5C6kBwcAWwll9u39JTInWcZUx8upow7TX4mQD/2SaSgvuGyYq5KAQwQyStWYjwk8X2XtBNA4M4Qid4Q87xvoT3pRt05k+1G57wGxDPNLyyoA7vPbRm7WVuP0lCJFLpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775167919; c=relaxed/simple;
	bh=I0g8r73yWzm7kcY8rMT3itCMS+wgU6DaBYgJ4OqQHoU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QmScVC6xKZJFL0S0TN9PoO7+L1QjtToiDZ3posGNJ8gomVjxo/rTo7ba3v0fGwqbdv61zrZAW8xURaWZKCTgCREetExhTSMpVy9OR3urC88CYKXLOkiWy5sABFOBuqAm/hdANEgoV3hcUrEQPBof2ps2zh9V8XMpaDL1bml9+58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FdtzJgqM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FdtzJgqM"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2523e0299so33002245ad.3
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 15:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775167918; x=1775772718; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P+o8/jyKkg2oUZiMM6SRiYkZTX9z0qkVTAVB6Qh167E=;
        b=FdtzJgqMw2qXwumg5kNWzdMKEZZQS0Asht+yvUXgpp0ou3FwegG68B5hGBtO1pT9m/
         YJXoh3dJWR2oDVtHf2XF4pPQSL/NVW0yyVe2lqLhhu5saaM4cOTA8NAdJXk1bmTt1vDE
         4lF00YyDX1eyaFoMemrlgXvQwOpmlA9cr+0eFeWEyx5Rgwro+Mmw0WN7JaXMi0PtQ4Hr
         V5nKIHA5DoQTJtHCphB2NELkStQx1+u3TpFdnu1hpblVopTmJTjoabdKVaTm1Lpa9T9h
         yPz7N2V2eCTUWaAbK0hhLcGbI0aY7EsGLrUp9/G0/pyCKa4lAVoAglAS3zHI+3g7W58v
         3F2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775167918; x=1775772718;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+o8/jyKkg2oUZiMM6SRiYkZTX9z0qkVTAVB6Qh167E=;
        b=cjY6rZH6Wys3OthQBzgwrKuSRed1ysE62wnbf+pFAPMVzhfyzNStZszktg9bPuCJO9
         dczEJzbpSKnh+vvbxoefiX0wmttkLlmcSZfV/pvsiMItJo6e83Uct0khCAJqknNbk4JR
         guV2PbPX+dp40NsQxYURvbNSBmCwrEJNguhTK6lsOf2ITWycfyRDynsvpVxkmXdeLxsz
         I0psuM8RMpGa1vWBv5xruuqZesi1HsgiEhR1ZQziKvIGEtLIHfnsFfPEd14AnomvPBA+
         11uALCLDR9wOUf2IV6yRT3IYl2Ic5m6khfkq4l9TR27hHbW01pTR+Gvsz/CeLjfw+RZC
         rd1w==
X-Forwarded-Encrypted: i=1; AJvYcCV122vbAhoX76k+TlFWPoe6dCVmX3wzlBg0dirYxEj5ebQ5DYXBqCQLW5+j8nW4zwmST8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+RXbAPlHScPSha1LjC/KEx+6M4cws2N/zefSnk8wUuhmxwNrJ
	c77Gy1SW/mSArUuNiQIrgJyXsX7mrO6GWe7coyNoP1piSunMpGzeFudeAQeqB77PSVcYxY8D1zs
	W1ORVtg==
X-Received: from plpn3.prod.google.com ([2002:a17:902:9683:b0:2b2:458e:4d6a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32cd:b0:2b2:51e8:2c20
 with SMTP id d9443c01a7336-2b281760833mr8706375ad.21.1775167917665; Thu, 02
 Apr 2026 15:11:57 -0700 (PDT)
Date: Thu, 2 Apr 2026 15:11:56 -0700
In-Reply-To: <33adf49d-4937-413e-a594-830c11b2bed0@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319005605.8965-1-yan.y.zhao@intel.com> <20260319005703.8983-1-yan.y.zhao@intel.com>
 <a14531ab-f069-41f9-8c5c-9fe6f28a9454@intel.com> <ac7V0g2q2hN3dU5u@google.com>
 <33adf49d-4937-413e-a594-830c11b2bed0@intel.com>
Message-ID: <ac7prNS2HXH8YowS@google.com>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com, dave.hansen@linux.intel.com, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, kas@kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, kai.huang@intel.com, rick.p.edgecombe@intel.com, 
	yilun.xu@linux.intel.com, vannapurve@google.com, ackerleytng@google.com, 
	sagis@google.com, binbin.wu@linux.intel.com, xiaoyao.li@intel.com, 
	isaku.yamahata@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 02, 2026, Dave Hansen wrote:
> On 4/2/26 13:47, Sean Christopherson wrote:
> > On Thu, Mar 19, 2026, Dave Hansen wrote:
> >> On 3/18/26 17:57, Yan Zhao wrote:
> >>> Remove the completely unnecessary assumption that memory mapped into a TDX
> >>> guest is backed by refcounted struct page memory. From KVM's point of view,
> >>> TDH_MEM_PAGE_ADD and TDH_MEM_PAGE_AUG are glorified writes to PTEs, so they
> >>> have no business placing requirements on how KVM and guest_memfd manage
> >>> memory.
> >>
> >> I think this goes a bit too far.
> >>
> >> It's one thing to say that it's more convenient for KVM to stick with
> >> pfns because it's what KVM uses now. Or, that the goals of using 'struct
> >> page' can be accomplished other ways. It's quite another to say what
> >> other bits of the codebase have "business" doing.
> >>
> >> Sean, can we tone this down a _bit_ to help guide folks in the future?
> > 
> > I strongly disagree on this one.
> 
> I think I understand the motivation now. All I'm saying is that instead
> of something like:
> 
> 	Remove the completely unnecessary assumption that memory mapped
> 	into a TDX guest is backed by refcounted struct page memory.
> 
> I'd rather see something along the lines of
> 
> 	KVM's MMUs work with PFNs. This is very much an intentional
> 	design choice. It ensures that the KVM MMUs remains flexible
> 	and are not too tied to the regular CPU MMUs and the kernel code
> 	around	them.
> 
> 	Using 'struct page' for TDX memory is not a good fit anywhere
> 	near the KVM MMU code.
> 
> Would you disagree strongly with that kind of rewording?

Not at all, works for me.
