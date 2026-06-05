Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86D640BCCF
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686795; cv=none; b=kxj6zGJup4I4h6hTUIa4bOxD72Y4t75B6A9FhUza8EwLMkRG+pNsSQbz5PTBpmVi2WqwdXu2+I/ZOATUaQID48d+lS4Gp1T0OU5+HpkjleXoAAgziGVC4PvHKuNYQFDyCeriwuPslzx2YdggFmovOzEXh0BDH8QWQ+QlnK9P2aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686795; c=relaxed/simple;
	bh=SQ7QPRPdbPZv/T5AAju/y/bu/C61FvfOIaP+zt0fvW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PLImFPnrlQJSzB61O4qYikRwa4BgfmpdpyZ+umUfsrrdzbBm3OO8RtsyWCHwE+nI9wJfhynV2OHv0FdKny4RJ4QakfVPIjideTbj+Nx56FZnTvRV0tXTbVI95b/Mclf0FiNzU5zT7WPcGl5B6BsezDenImFy6s5bSh7vr2WyPUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SexkMOct; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SexkMOct"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85a2ed88c8so2529690a12.3
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 12:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780686792; x=1781291592; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WvoGZI67lTbahhlhPlgGTMsoNGoCWmjZUongFfl/a4M=;
        b=SexkMOctpqqVkmOYn1hfUZ8UGobAdzfQ5Lth5SZ99VFgUYFI8SBT68EUvO0xP+NQaO
         CkgJoMZ5gztyp0ud3mOwW7HZlMfbPyNjHaBtCBM9SBMcQrzQ3tA5ROAuaDJTYYQ4cx/b
         tLX4qO/C4WSMB0sA4DkKkT+wIdCvKvditzU9iP5AE8fFRc+gLOy91+4lMrw4wqD5ahDt
         D/V6vXXTVGT+VXACvMzDYeDMSURIpmQbIYGVunBy+afqKprLv3OemKgaM1vST0QBSGOC
         Iq52B7+AT2dltEiaXLcRZZz94Ha9vYbVQln5woyGp/8ia34KdLhtFycojtXJIBcliUes
         EdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780686792; x=1781291592;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WvoGZI67lTbahhlhPlgGTMsoNGoCWmjZUongFfl/a4M=;
        b=A47HH5W73pVn0ygGpV/GBkLvtdWm+V2YcSOnAoXRvHLV9zPYAcvZboQmhSUIDxt9eG
         NKBxNZ0tOK/LTJM9cOUq551z3bcX3O13bryhuK6SskxbT9vkVuuSVf4KVfZ21AV2RbZX
         d4d8ba4NuLIc0tS77JvxBch06qQQVytugq+yJMTerPxGD+huuzi6hM0puFXTZPCO1MA+
         L6EMThfFGmZ7yTRwv2VnblAL7bK5dYbmF7gkygMkFQUtYPLE248RYqRSx6VMtyxhHMn8
         5VNOvHtVZG3Yy/k2vFaDVD0wUPrlpaLc1xtiPVDiN+TP3rsObiAnD+QLKCOxeRsgxJp9
         KR9w==
X-Forwarded-Encrypted: i=1; AFNElJ+zMh6Q2fXnTmWSjrVBcG+pVYu1uLZp3Bf/8RIxxQDS2YVodJ/TA3KQ8utlJdVhCrtb6Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6SJQ+z+v5qCHPiuqcfa3vqo33e17KzckD2xN2vrWAyJlZOlNq
	BEsFAhIkHcHd5zfDbdbw/8OTjH0lBE48YKb0FQSF9NU8azV+SNsLEnR6DQXt3BUFUoEKRRW9rMP
	qg16CBA==
X-Received: from pfst39.prod.google.com ([2002:aa7:8fa7:0:b0:842:35fe:fc95])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2449:b0:842:38d2:a358
 with SMTP id d2e1a72fcca58-842b0e3c6c8mr5144242b3a.26.1780686791436; Fri, 05
 Jun 2026 12:13:11 -0700 (PDT)
Date: Fri, 5 Jun 2026 12:13:10 -0700
In-Reply-To: <0372a31369575b2c782dba7e6dd09f7e3863c9ab.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com> <20260529222223.870923-28-seanjc@google.com>
 <0372a31369575b2c782dba7e6dd09f7e3863c9ab.camel@intel.com>
Message-ID: <aiMfxvgk_PwjU3p6@google.com>
Subject: Re: [PATCH v3 27/40] KVM: x86: Move register helper declarations from
 kvm_host.h => regs.h
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, Kai Huang wrote:
> On Fri, 2026-05-29 at 15:22 -0700, Sean Christopherson wrote:
> >  void __kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
> > +void kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
> > 
> 
> :-)
> 
> Seems a candidate of making kvm_set_rflags() a 'static inline' ?

I actually don't want to, even though it seems like a no-brainer at first glance,
because it would require exporting __kvm_set_rflags() to vendor code.  Which
wouldn't be terrible, but it seems like an unnecessary "risk", e.g. of folks
trying to micro-optimize vendor flows to avoid the KVM_REQ_EVENT.
