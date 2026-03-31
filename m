Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E77436F430
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984425; cv=none; b=uIuQ/sYkAdveaQdmNpnzbKPqnKHMJXRx9cRfHgHs+VzZqLC4cpYaRz5OQ5xrZeCAeknawTluX/RaK8FyVdbSlXcOQHAS+99a9JzdVdr1BXmkKz5eH53l7o5TevF3f6qS4NTYggNh+Nfu6dS+0n+A9jYuRXBMjwk/jkF/73SXD54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984425; c=relaxed/simple;
	bh=JwIOSwMZt26fkLD8+ealZ4vso2YTqrr5jBlFqKa29fY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LLrtQSkFthAyMXzPf88IO2W3NwSlY9zO8ZPN0jOSnUXa82JcA6AHziVXMxBFz3wa+t8CKj924k6zVL6oUR6A56tQ3J42tzDR2CEaPWR19gRXq5bVjsqerbMF1w5Kr2mmjwlVfbMeYTq+OzpZVpI4DJ/84Jy93QicyBxfsW7VFps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eAMApFrU; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eAMApFrU"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c70d1f56eso3721382b3a.0
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774984424; x=1775589224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wPFb8gmW1pUOsvxSl8LLmBIFYkh0IuYqfsVEay082zo=;
        b=eAMApFrUik0K+hhHqNng2ZRnqkR5qXsBle6vXAABGlHpRweHVKwpiwT6SswHeRisfM
         hUhyEkcAECa5aOJBtfqaB5V4d0P8fmSrSAEpxJgLdkAg+83KMeDujOrNskkTKKUVAGQh
         MT+9iFF8mtoBC3Z3NxreudQ0Y+XvU8dYUUMCIfHTfbZR56ctRTx6o+tatqkBp7CdOcIH
         lRg8tH84VIVVdZUeXnoYFS3Rk5zUF/IWT55f7NK+vlnYWQFMpbDXGDeVOab8OTbrHY0/
         nQ7Cuy5m6B7fvp2Dn2mF7CerA+KH/AxmYeh4VWZ8GiIis+oxL5lydaNmjGuGYDS5X1nv
         prDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774984424; x=1775589224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPFb8gmW1pUOsvxSl8LLmBIFYkh0IuYqfsVEay082zo=;
        b=moJEaySpLhYI3Cda+xRVB0+cDieiZSrsWDa0Vnn4GxD29Vr+OXIKDdiUw3uKXBj5op
         rCsDqAfK48fKQ23mR/V6l81kXQv3/HNxF2z3/ZaopVioGEzrlV+AztXXGlIJPTxcxA6V
         oD3rONPqCKwCsPamCcuDHalQu1065ojgvIwcYjF6oH7c1nVJdiGH2pwlgHDikeEFOB4d
         NWjliv72vg0/A2o7QfJkAQEFepPEv5elFr+KoGQF2q4RA//yqqlPOFRbAwruXP1D3uo6
         ICSpt1gDMp3mB4Nh09i6cNNoDzFnrfZdIFFfXCUqgrPBcVkKUvNh6l5QYOnk1Pijx3hb
         J0DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDwW6So5ZYgk0KfNvEfT/bDOQrDpYSZ3EATsQuMBKGZobqjV3BXdZy8zRyqHt7QEjRPFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc2X+ceIFPxdGFypQQi3T9l5YIE5a97VaJYCIxCB/QhZ0fNXab
	pQWE09/35pVm6XSB2mzPGh5W7JqdcEz5bL1WHVMaUt272xhKneSehb3wiuzYZWa76bagBrhnGF3
	GoYp+2Q==
X-Received: from pfud5.prod.google.com ([2002:a05:6a00:10c5:b0:829:9b56:fe32])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:230b:b0:781:2291:1045
 with SMTP id d2e1a72fcca58-82ce88c0d33mr744086b3a.8.1774984423697; Tue, 31
 Mar 2026 12:13:43 -0700 (PDT)
Date: Tue, 31 Mar 2026 12:13:42 -0700
In-Reply-To: <acYrxIxoENyZhKCV@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319005605.8965-1-yan.y.zhao@intel.com> <20260319005703.8983-1-yan.y.zhao@intel.com>
 <a14531ab-f069-41f9-8c5c-9fe6f28a9454@intel.com> <acOmoOP2fFUyOByC@yzhao56-desk.sh.intel.com>
 <189f00877360117ab91ec3a6cb8b8239f4fff06a.camel@intel.com> <acYrxIxoENyZhKCV@yzhao56-desk.sh.intel.com>
Message-ID: <acwc5sDHFbHJGG4O@google.com>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Kai Huang <kai.huang@intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"sagis@google.com" <sagis@google.com>, Vishal Annapurve <vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, 
	"tglx@kernel.org" <tglx@kernel.org>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 27, 2026, Yan Zhao wrote:
> On Thu, Mar 26, 2026 at 12:57:26AM +0800, Edgecombe, Rick P wrote:
> > On Wed, 2026-03-25 at 17:10 +0800, Yan Zhao wrote:
> > > > I don't really understand what this is saying.
> > > > 
> > > > Is the concern that KVM might want to set up page tables for memory
> > > > that differ from how it was allocated? I'm a bit worried that this
> > > > assumes something about folios that doesn't always hold.
> > > > 
> > > > I think the hugetlbfs gigantic support uses folios in at least a
> > > > few spots today.
> > > Below is the background of this problem. I'll try to include a short
> > > summary in the next version's patch logs.
> > 
> > While this patchset is kind of pre-work for TDX huge pages, the reason
> > to separate it out and push it earlier is because it has some value on
> > it's own. So I'd think to focus mostly on the impact of the change
> > today.
> > 
> > How about this justification:
> > 1. Because KVM handles guest memory as PFNs, and the SEAMCALLs under
> > discussion are only used there, PFN is more natural.
> > 
> > 2. The struct page was partly making sure we didn't pass a wrong arg
> > (typical type safety) and partly ensuring that KVM doesn't pass non-
> > convertible memory, however the SEAMCALLs themselves can check this for
> > the kernel. So the case is already covered by warnings.
> > 
> > In conclusion, the PFN is more natural and the original purpose of
> > struct page is already covered.

Most importantly, having core TDX make assumptions based on the struct page and/or
folio will create subtle dependencies that are easily avoided.

> > Sean said somewhere IIRC that he would have NAKed the struct page thing
> > if he had seen it, for even the base support.

Yes.

> > And the two points above don't actually require discussion of even huge
> > pages. So does it actually add any value to dive into the issues you list
> > below?
> I wanted to mention the issues listed below because I'm not sure if anyone has
> the same question as me: why do we have to convert struct page to PFN if they
> can both achieve the same purpose, given that currently all private memory
> allocated by gmem has struct page backing?

From https://lore.kernel.org/all/aWgyhmTJphGQqO0Y@google.com:

 : I'm not at all opposed to backing guest_memfd with "struct page", quite the
 : opposite.  What I don't want is to bake assumptions into KVM code that doesn't
 : _require_ struct page, because that has cause KVM immense pain in the past.
 : 
 : And I'm strongly opposed to KVM special-casing TDX or anything else, precisely
 : because we struggled through all that pain so that KVM would work better with
 : memory that isn't backed by "struct page", or more specifically, memory that has
 : an associated "struct page", but isn't managed by core MM, e.g. isn't refcounted.
