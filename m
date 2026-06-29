Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA327456
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738313; cv=none; b=ga8NsBdqAe7p8CVSNtlYTnI70UtCiEYjhiJEb42P5YkmdYLD7NiHsPrPETLPL3v6jStnoHCvdgz9gEuTb5lzkkSMMkJ+4E9O8LNIs5FszJ+FTSSxhuRosJQLMnjJCxHQmQTwLMROYDxoy2zBIhrerKi3BjxpYJiLS1skZ89q2ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738313; c=relaxed/simple;
	bh=SmHChhPPrRwmFRXL3d/cQDjPOH5mEw1Vkz85NnNn4fo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NM8Jw2x/nFws8FYZCVf5Sp2o7M0iflAYYIqLbikS12IbA3Epd1pFcJ8NXF10knWGb+up3FiC2V82vsuJZmFow+4H0MoMlDYSQZcyygXtlGWQbMa/pZWKv/PCBsVIwGOxYWTfAYVts67gQQo7kh6TJ6VFYLhbsCN1GLVhUb3I3Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wHrC4j12; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wHrC4j12"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-846f50381a6so778864b3a.0
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 06:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782738312; x=1783343112; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WH9u6HyF9XwULk0p/Mweq6whobt66AKoe8vGrDQxEik=;
        b=wHrC4j12k1vhchOsCJgnH8zn+hNMFBKc9wy8zByrzpToasZ9GcrctpE++QWE/ZEbzK
         Pz9614anw9+h5iIyAttM5HrlgpQ5dyupH/DoR6gGlHOjUMJespyOqI7tNePAIUXfCe5W
         3okLvB4JldRXBjNn/8N0RfkKnpzVaD5tdn2cz9s+HP9uKEEjx9o4QaD83TfBaxQWnbPX
         NeoglmVCKORoTPV58b+fTfZsn0OjHuTQMk13wh43T2WMPsc1hmsrqnDinYRN/ofNVwDZ
         HAuZ6kUhKi7IIB8sqhZjvzDzPsOcmBkVf8RiA+Oh1sVy2strgQ95GtrkNTJa0sANznCz
         ERJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782738312; x=1783343112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WH9u6HyF9XwULk0p/Mweq6whobt66AKoe8vGrDQxEik=;
        b=XebbEab9h0icVoBniMN0NZzEsraHHyR44IUqGocXdPIQxMwczg2AmRtmtREdXIZHYC
         jVeOuszX7HEqkE2IWL0AsKQIxWERhSv9rtT/SqBj1NyjRvsDEgWld6RgpWdwMfGqiPaK
         n6R8hkReX7XUT7FuOXs7qjbJAyrMNtY8EBS0YS0uvoFAmmmD0aTMqRnW6SIIdhhU+p4M
         QdPwZeGx6YguO619WWOKLt9LN7jCuYMdRVOSXgSvmDyTYgg+RkF6xtewRgu71de/k2hX
         TTnJzlRyOv9Pwbr2cJDVOJGBagm72gW0J/nLqREiPfkxkdsn3TGmP3CXrqt8MUVdkmiK
         /mPA==
X-Gm-Message-State: AOJu0YzIFY2byWA4u1qt3TadUd1O4CbMSXqORkxFtC1F4xIJGw+RQBTM
	swuSKA/kc2bJ5HU/MTCDY38eiCF67EFKBcRAHTalmnnLJPquUbTblCfoT3xQbW1F24sxQSVaYbF
	I0ATSIw==
X-Received: from pfbfd21.prod.google.com ([2002:a05:6a00:2e95:b0:847:823c:d265])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3385:b0:847:438f:500c
 with SMTP id d2e1a72fcca58-847438f6703mr4084742b3a.60.1782738311498; Mon, 29
 Jun 2026 06:05:11 -0700 (PDT)
Date: Mon, 29 Jun 2026 05:51:42 -0700
In-Reply-To: <3c0f96a316a968e5e0301f355bc05962c4b975ad.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624220516.3033391-1-seanjc@google.com> <c4ce0b3ebc40384afef7895909df3d00370b3e1d.camel@intel.com>
 <aj1KP2h49GzfNHFz@google.com> <20320c7b5e6e9a01f2607761c934bf47ec8e2f64.camel@intel.com>
 <aj66ZyxVdLjF_0dc@google.com> <3c0f96a316a968e5e0301f355bc05962c4b975ad.camel@intel.com>
Message-ID: <akJqXur5Nl6ZanAM@google.com>
Subject: Re: [PATCH] KVM: x86: Ignore pending PV EOI if the vCPU has since
 disabled PV EOIs
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 29, 2026, Kai Huang wrote:
> On Fri, 2026-06-26 at 10:44 -0700, Sean Christopherson wrote:
> > On Thu, Jun 25, 2026, Kai Huang wrote:
> > and because KVM needs to know
> > precisely when the pending IRQ is unblocked, i.e. can't lazily wait until the
> > next VM-Exit.
> 
> Thus KVM needs to make sure guest will actually write EOI to APIC (thus PV EOI
> must be disabled)?

Yep, KVM needs the guest to trigger a VM-Exit.
