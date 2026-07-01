Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0524C3783AA
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925956; cv=none; b=TMGEWnyQXVidB4bzEWqeGZMMBe0TqiMl53IK8b0ikmyE3rMzVeoLrHFkROrQ6J03lUW1N0qwev1JrwxijCoPd5jQkFJay7NGrf2kBpmMFgGkxDy8bX+gZsTKLo88R+wU+oECDUWCXRrPfBv21jbMHx4CWFUZ9gNfWm+rUDbmmuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925956; c=relaxed/simple;
	bh=Q/dh2h+abeH+DlLMMwqaF/gPfGsZ6kyRE8rRul6qj4A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XExZS586FMt7U06RKQs2zIq20yXLWqylFm58gC8whq+5E4sH4iRuibdaGGsWTDZpawRYi9DOk8y5e2aCTMEHvKSXky0ijp1oh3FG514yuQ9ucbjZOqiqcKyHbIu7kXLkyA/bzzqvnZQ1fj7+vK0wifkACSQsrES3Cfyw1PfhNiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wSzooCSL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wSzooCSL"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ca53c486f2so11052735ad.3
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 10:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782925954; x=1783530754; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DlW/Tw9gcgb1xINl+uo7R0Y4UPZxe1yGcJU8p6oXzuI=;
        b=wSzooCSLycVzMHoFB/LSixr4lTnbHnnxqifrwXHNzxiK2vM6zNOcjqUbu3yA5nIFWS
         eIOJ8U+3/0uAqmMbTnEoB+wY3UFvTcntWWfhzCteE3b4TsAy0zih4ba9bmEdM8mWvevx
         I0QWUn70/yz5hGJJV//qg0PMg1oRjfkmXaF3ksOyLIDXrn1K5Sxo4dbewcJSYvo6I6s6
         WsN1stiipGHgRzLDWKPyEEZOzVXEuvFSwzMOGLCA7KWZyoqwScwTSj91MfPxdTC6cChf
         zIWEI+FTIoMq+C2A3mgRV9p1JG5WjM/ehHLgj4HKLmciE5gpmayuKtk8HjDmzWxfnC/Q
         xKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782925954; x=1783530754;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DlW/Tw9gcgb1xINl+uo7R0Y4UPZxe1yGcJU8p6oXzuI=;
        b=MkxRMzvmfn+KoAfHFtrYHcC2K7W70v1PRa012WggddpbcKHNK9acNRXfJpC3w0yLvK
         i8C2OU7bTNUX52B//QDZNw2R2zEQ8L6UgjJbPbyL02vw41O8gOapwfbFwL6EjZMfAxOT
         uLD0EqczxEoowHbeQkcZb13nnAqBrasI5n3BRtzvymnR83KhWMcLepOtfMHVfl4omTTp
         ZNYkX7tR8RKfKDGNE8si+90aG5nEdcefSSkdjVFNUuPRXte6t9lBl2Dl8ZxzQKCyAjoY
         6TP72/p8eJz2BDxZZC8OZS66jopv958mfibVOe7tQwwyvmMu3CrofVqHhSWZPaNeNkQ0
         ky1g==
X-Forwarded-Encrypted: i=1; AHgh+RqPPqSALyrC9xRRJBn7ZXn+PVOwmnyFczkjWndk/2VrsBhP8K9UsiKez3M3I86mxGlVlvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6pToXKRx6JcqB/fqk/v+eDNEYrwVqWMFC3wPcymtUKD4Vg0SZ
	3htEuobQ1RX253dk4LkY51pjF/qneD1MvZsE5mq6TW4aEjDAE/Y8Bi5v0+7uUHHdRulyk8kCmyD
	5lV/P2w==
X-Received: from plef18.prod.google.com ([2002:a17:902:f392:b0:2c7:eb53:9c06])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a90:b0:2ca:eea:eb5c
 with SMTP id d9443c01a7336-2ca9114efb0mr15378875ad.18.1782925954124; Wed, 01
 Jul 2026 10:12:34 -0700 (PDT)
Date: Wed, 1 Jul 2026 10:12:33 -0700
In-Reply-To: <323a9a1a-6cf9-4a68-b92a-867f497b3d34@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630213711.479692-1-seanjc@google.com> <20260630213711.479692-3-seanjc@google.com>
 <323a9a1a-6cf9-4a68-b92a-867f497b3d34@linux.intel.com>
Message-ID: <akVKgY6JK9im5aDZ@google.com>
Subject: Re: [PATCH v2 2/2] KVM: TDX: Return EINVAL, not EOPNOTSUPP, for NULL
 INIT_MEM_REGION source
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sashiko Bot <sashiko-bot@kernel.org>, 
	Joerg Roedel <joerg.roedel@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 01, 2026, Binbin Wu wrote:
> On 7/1/2026 5:37 AM, Sean Christopherson wrote:
> > Return EINVAL instead of EOPNOTSUPP if userspace attempts to pass a NULL
> > pointer for the source page of INIT_MEM_REGION, so that KVM's ABI is
> > consistent between TDX and SNP (for LAUNCH_UPDATE).  EOPNOTSUPP was chosen
> > to be a forward-looking error code for when guest_memfd supports in-place
> > conversion, but even when in-place conversion comes along, it's an awkward
> > error code as KVM is deliberately choosing to disallow virtual address '0',
> > which is technically a legal userspace address.  I.e. it's not so much a
> > lack of support as it is that KVM reserves address '0' to simplify KVM's
> > internal implementation.
> 
> Nit:
> Do you think it's worth calling this out in the documentation?

Yes, though that can be done separate since this series doesn't change ABI.
E.g. we can probably do it opportunistically as part of the in-place conversion
series?
