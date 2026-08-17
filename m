Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399A544470E
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786990759; cv=none; b=uQL2cl9Ud3J5WjTfBaDVnn7ji8sTexlHq6tluYqYU3e6rYAOrEXmPp3AxyOgXb3Euxxifn7E8jSY1Zx20F3nS9cfU+l29722zYmGN7zZbx1kBBut0iT+75a0RyYxl5TOnwfea+PrdFprB00PIrpxDIf4wkREx79iYlNoo00FFGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786990759; c=relaxed/simple;
	bh=61l/vR22wAGj+G5ncDTVr+gQ+Yzx1sQDDhvKkefO+PM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vsaj6oIXjqSQFoh/Is2Bqo1P6O/M2Q0uCLw9RPZIK8VgZE2guOYUdzv3xpXCX8CYKD83WzG+zCidYjQgOPg+PPGYRunVzoxZEPIXNLAO6UYImGFrjRUPzkc4yamMk/Q/CR5OL1pcAZ/utO2ARrWSTS7lx+fu/Zl//R+s4zygwIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PAX8+OuF; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PAX8+OuF"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cccfa32670so51773125ad.2
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 11:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786990757; x=1787595557; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BhiYLD9VDgA0P+vwZ8hZo0EEnFAN1wOjxc6IU0ZbmYw=;
        b=PAX8+OuFoyDJ3I7uwxmk9sEB6/WzTw6owNaqNvD51Da5+3YzpR/KVLeP7xiC8sd80/
         FH0ypm8ZGOxOMElGLvWbJbMF7v1EXmFaFnG3VOlikdLiGo18mxlf1EH4QeYDU0JOkUVV
         JjPEC8pJS8r+RsTdBwm3KZiOxiF5ycmha8JFBU6SS2hPVqWpvZAJfHoBU47NKL9aOoCW
         6Q4X6YbVFcrg9W9GNA9WPNPVfT33QRmqxJRhBd17oPjBWs79nNz6humL3so8qqAfHp7I
         TdIIWIEADh8bgyd5yapVSg2IydEMnse40oJKjcMGcjUDkXcDDkhpMO5FeRuBGtjOe/bW
         P/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786990757; x=1787595557;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BhiYLD9VDgA0P+vwZ8hZo0EEnFAN1wOjxc6IU0ZbmYw=;
        b=NWig2SAuKM+mIMLXFkt8nFF4bcA2+rKdSaKVyTkZXxGVqLanoKQBk9+7V0toDAqf5y
         8JuUDB1Mbe+Cdz7E7vlf1GEjJrrKWlIy5AThntC6VQOvu1v7p0Tic17qz/hjKrs/srYP
         CcF6Hnv0fBiyyWWDRPhvbU+tKMpHvjKaPDtqroqr2vFOtlt3c3RGIbKv0/mWCbQzAiql
         bHQbtsDjiuQDoWOGDN8ZJK4qEuEp0FfSJoksXXTf6CSm/+bXB481wnGF70X2z7XMm5sY
         vKDRzCiT0QZSILLx66BW13aEsGRLiaSVlC7ySkLQiqfVnxQqmtgaRhGiugsWhBMjjYBT
         M/6A==
X-Forwarded-Encrypted: i=1; AHgh+Rowh5VgqvR8V4a5CTq4rlBHjpCml6qRoyBztXcrtaYEJkPSc6ilqvgXLK8trV1LDjKV1fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU2ySIQsMt/1RlQZuA+tp0CNbj0sHsDHzadVUS5541zZeD7sW7
	obsEjxdtYOMgIMbob+AeBwGsoBodYjAqR4gjdrrDYvYf6Dhr5LR9dzuXRKo27RDv6ROaeT/Gtom
	eJO0vsQ==
X-Received: from plbmm15.prod.google.com ([2002:a17:903:a0f:b0:2d1:4ca3:d32b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1ab0:b0:2c0:a555:80d6
 with SMTP id d9443c01a7336-2d3b0d780e9mr288678215ad.2.1786990757388; Mon, 17
 Aug 2026 11:19:17 -0700 (PDT)
Date: Mon, 17 Aug 2026 11:19:16 -0700
In-Reply-To: <d67eb097-1223-4b68-92d4-1510d3d7be7c@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
 <20260812080229.2481439-4-xiaoyao.li@intel.com> <20260812082306.11E8B1F000E9@smtp.kernel.org>
 <8b05ead1-ef2c-472f-a613-bcd1a65b64e1@intel.com> <138969948dac13369ddebd72bf523dda4dda6b85.camel@intel.com>
 <an5W5XC97HK229MX@google.com> <eddf28d4-c211-41fb-b0a3-586e5afde030@intel.com>
 <an8wUfZ9JxvEhtHS@google.com> <d67eb097-1223-4b68-92d4-1510d3d7be7c@intel.com>
Message-ID: <aoNQpP-BQKiZL47O@google.com>
Subject: Re: [PATCH v3 3/4] KVM: TDX: Don't assume exit_reason[31:16] as all-0
 in tdx_to_vmx_exit_reason()
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 17, 2026, Xiaoyao Li wrote:
> On 8/14/2026 11:12 PM, Sean Christopherson wrote:
> > On Fri, Aug 14, 2026, Xiaoyao Li wrote:
> > > On 8/14/2026 7:44 AM, Sean Christopherson wrote:
> > > > On Wed, Aug 12, 2026, Rick P Edgecombe wrote:
> > > > > Side note. I really dislike how tangled this area is for something that seems
> > > > > like it should be much more straightforward. Deriving partially I think from the
> > > > > overloading of the TDVMCALL leafs with the exit reasons. So we have things like:
> > > > > ...
> > > > > 	case EXIT_REASON_EPT_VIOLATION:
> > > > > 		return EXIT_REASON_EPT_MISCONFIG;
> > > > > ...
> > > > 
> > > > I peeked at that code again, and FWIW I still think swizzling the exit_reason for
> > > > TDVMCALL is the least awful solution.  If we don't do that, then we'll have to
> > > > update every single use of the exit_reason to demux TDVMCALL into the "real" exit
> > > > reason, which will be a mess.
> > > 
> > > I'm not sure if you read my idea[1]?
> > > 
> > > I think there is only one place KVM cares about the exit_reason TDVMCALL,
> > > just the
> > > 
> > > 	case EXIT_REASON_TDCALL:
> > 
> > No, the massaged exit_reason is also subtley consumed via trace_kvm_exit().
> 
> yeah. This is exactly the one I don't like, it looks like trace_kvm_exit()
> is tracing the wrong exit reason, though it is by intentional.
> 
> > It's also consumed by tdx_complete_emulated_msr():
> > 
> > 	if (vmx_get_exit_reason(vcpu).basic == EXIT_REASON_MSR_READ)
> > 
> > and by tdx_interrupt_allowed()
> > 
> > 	return vmx_get_exit_reason(vcpu).basic != EXIT_REASON_HLT ||
> > 	       !to_tdx(vcpu)->vp_enter_args.r12;
> > 
> > and by tdx_protected_apic_has_interrupt():
> > 
> > 	if (vmx_get_exit_reason(vcpu).basic != EXIT_REASON_HLT ||
> > 	    to_tdx(vcpu)->vp_enter_args.r12)
> > 		return false;
> 
> Ah, I really should have checked the code more carefully.
> 
> > > in tdx_handle_exit().
> > > [1]
> > > https://lore.kernel.org/all/646f9595-459f-4224-b4e5-4ec2eecc0bc6@intel.com/
> > > > And once we track the exit_reason separately from vp_enter_ret, IMO it all becomes
> > > > more logical and easier to follow.  vp_enter_ret holds the information about why
> > > > VP.ENTER returned/exited, while exit_reason holds information about why the _guest_
> > > > exited.  Obviously it's imperfect since we're still fudging EXIT_REASON_EPT_MISCONFIG,
> > > > but again, I think that's a better alternative than demuxing exit_reason in multiple
> > > > locations.
> > > 
> > > The question do we really need to swizzle EXIT_REASON_TDCALL to other exit
> > > reasons ahead? why cannot them just be handled in the central handler for
> > > EXIT_REASON_TDCALL?
> > 
> > Because as above, it's not as central as you think.  If we want to not swizzle
> > the exit_reason, then IMO the only sane way to do that is to not track exit_reason
> > for TDX vCPUs, i.e. move vcpu_vt.exit_reason back to vcpu_vmx and force TDX to
> > always demux vp_enter_ret every time.
> 
> How about adding a specific field to track the TDVMCALL leaf? Full diff as
> below (the EPT MISCONFIG part can be split into a separate one)

I like it even less than demuxing vp_enter_ret on demand.  It has all the same
flaws as demuxing vp_enter_ret, because it's effectively just a cache of the
result of demuxing vp_enter_ret.  And caching values on entry/exit boundaries
adds additional risk;  I can point you at a number of bugs in the past where KVM
consumed stale data, e.g. because some chunk of code got moved to run before a
cached field was refreshed.  That's unlikekly to be a problem here, but anytime
data is cached it introduces risk of consuming stale data.

And the cost of demuxing vp_enter_ret every time doesn't concern me, at all.
What I don't like is relying on call sites to know that the exit_reason needs to
be demuxed in the first place, because that will be brittle and error prone.
That's why I'd be ok if vcpu_vt.exit_reason simply didn't exist: it becomes
impossible to check the wrong exit field because there's only one such field.

I'm ok caching the fully processed vcpu_vt.exit_reason, i.e. with the code now,
because only the TDVMCALL path needs to be aware that it may have undergone
processing, *and* KVM can WARN if that processing didn't happen as expected.

Whereas checking the "right" exit reason requires doing so in multiple paths and
doesn't have a natural sanity check.
