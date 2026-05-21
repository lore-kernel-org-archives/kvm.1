Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CEF36D9F5
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779389236; cv=none; b=Xobir1wSLYW0QywwmyF/WoX+DntSAUcNxzGGfl7K4ifRl26nl7OpFUgTJ+D9Og3f9SOO3IVJNGQXq/fT4zE3YW7sfvOK7bbVUPor4cBp1PPes1Di9FgeWj4ae0OOw3Bal09J5vU+j1sGsyvpmBiYMhkkhJKSyONhl/slrGFCv/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779389236; c=relaxed/simple;
	bh=/DG/MIpaMO6i0+S7NwYK+Xz+X5EesI4A/a+bCuZYdfQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gYlochqtiu2H0Yg/vcX92a7dqAvwSRtdrxOq5I4weaGjdLut2Qs4xdg34OcufWuLQzC08J23nvdE7nRdnwKaXNmB6MnxuaU00yv9E+HcgRsqyB6gMUdpnDOi85zNJNQTNs6JQTFXoxKNBuy8udhkg8kWLBSqD2h5zKaBQ06EFvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eP9I9n3/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eP9I9n3/"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3663d5e9bf4so5802527a91.1
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 11:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779389234; x=1779994034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zotDUcTetMeKkyO7KMKZKkLO0bGRKwkihUsxk7vpQAQ=;
        b=eP9I9n3/HD/qlX+wbK0JUpVUxbyuVhy0d+Q8JsUAUgtl57ZxZogCxkKRZ5p2yjDfl1
         rZWXNaWX1m8+UcmfbP/+2qeI93WJFsa97n94P/8IqjO35vf/tm3HxfwW+Nj8Bj/2fPqn
         HtMxNPr+ulYsxrSkqVXqf9RwOyhyHvYNraWYoFPnAvXkjrWSrgFbX2A7oZAmmDK0DGqn
         nBSGnaJjQQY64251c8qynoeAelvNd0jWA0xCMdBZ0FAo1IjDwaB20KdLrbsHOK0c6NfP
         tx2rvy1yOu4UR9xyhj7RSpRY9SO0by47noCVGT2lwBdvIYcqjkjjSH461W/GrnhZrrNR
         8ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779389234; x=1779994034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zotDUcTetMeKkyO7KMKZKkLO0bGRKwkihUsxk7vpQAQ=;
        b=DgrMx2XrVR4deq6L+IxCFjoMaJ0e2sPaO/q0THmxXA9FvEWeFWmF0GfZynZOHdHF/N
         Kz94lqbkumRncG7/1ThLwFe5K8Gq7JuRix7uF3OVvBFIz3g9GeYN74tUhVqcLdVFdNJC
         LmxWPqaV0ceq3XxC0nvPNnJ11erbbfDjXTQFurlBvNCGVGmRD9/acsWlr2DXz7N6pOvW
         FAuOUfoDAU+fGoJPi/a7ERCLNEC8sFKK8ThK96xdzg5XD/J+sPBllsJ7ORHPXQuxkEfu
         G1r383Ao1p8REqwu11Ugf0T1HcCLIhZRN13eiUan+bkSKflmsKMKn9xK3ifgMqse7EJ9
         cS2A==
X-Forwarded-Encrypted: i=1; AFNElJ/XOYRauC5F6B6pnjEU/iE5mffsO6gprRShc79LtEi+bV5UeTVGdQO6eedwHcCChUadzX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7nc1zHgteuUoDSys11lSH2eVdAWvc/BuFylj24ZCm9/6FSDeq
	RyQw2vz5yfjgwgdkbekcdUAG+t4HRCWAv07qQizoB5/NRB5gnlhuhHLXpHMoWnxyuCBvmcH09VV
	EVMvpRQ==
X-Received: from pggg7.prod.google.com ([2002:a63:2007:0:b0:c73:ef4d:6a16])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fc2:b0:368:3854:3a2e
 with SMTP id 98e67ed59e1d1-36a676d2e82mr471785a91.26.1779389233672; Thu, 21
 May 2026 11:47:13 -0700 (PDT)
Date: Thu, 21 May 2026 11:47:13 -0700
In-Reply-To: <0ed747418eaef45a8c161ab5a9e28a12c604f9ea.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514215355.1648463-1-seanjc@google.com> <20260514215355.1648463-16-seanjc@google.com>
 <074e209fe4c78a735868099f13d76b9dde2c88e3.camel@intel.com>
 <agx77QB3UVmJr5xP@google.com> <729c4191d16e4c768c231ffb9bb8420306039210.camel@intel.com>
 <ag0NlJ2FEIL7GJIj@google.com> <4a918cb38dccd4ef7a2d84d16f5044472d069f7c.camel@intel.com>
 <ag35RgwowvR9Q4hA@google.com> <0ed747418eaef45a8c161ab5a9e28a12c604f9ea.camel@intel.com>
Message-ID: <ag9TMaaeX1aU7w0q@google.com>
Subject: Re: [PATCH v2 15/15] KVM: x86: Move the bulk of register specific
 code from x86.c to regs.c
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"paul@xen.org" <paul@xen.org>, "yosry@kernel.org" <yosry@kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 20, 2026, Kai Huang wrote:
> On Wed, 2026-05-20 at 11:11 -0700, Sean Christopherson wrote:
> > On Wed, May 20, 2026, Kai Huang wrote:
> > > But if we want to hide KVM internal structures, I don't see any other options
> > > except virt/kvm/include/ is the place to go?
> > 
> > arch/$(ARCH)/kvm/kvm_arch.h is the obvious approach.  Code in virt/kvm can reach
> > arch/$(ARCH)/kvm, we just need to add it to the include path.  That's why I was
> > working on unifying the include definitions.
> 
> Yeah, for asm/kvm_host.h.
> 
> But if I am still following you we still need a place for linux/kvm_host.h, for
> which I thought virt/kvm/include/ would be the place at first glance.

Oh, yes, the KVM-internal pieces of linuy/kvm_host.h would live in virt/kvm.
