Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16DA4DBD92
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693625; cv=none; b=Jv0Kb6m7ucXOzb9qSV5JZiZsbHv/M+RmAxrhIz+lanBWiat6CugNshfIlSa9dqQN0uMS9UXYPh6PkctVJLF+7Gs2ltBRs9diMa0K2rGNAliK+KHpECBylBnAYRFLNaJCkUX5crW+xxFqeQDcKk3yS3VQS6qxVIOjV5Idua9vWiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693625; c=relaxed/simple;
	bh=CJp50SvW3F3PdE/C64WeRFCXqzQfatncfC6MnFv/FpU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M2sjMSigwzddej13Qlk4BgTlVkzcMrbTfmqq/ZJnDAIFBYNFKX35KqIlbuTyKnU6FnVPkegs0FysLJKnXyrdmqRU2wPuna/tn9xy6EEQIT2UNi+AElaXDDvdhRq8u1mG/4Q7Qq7TURMsIBa+o16YF1uEZ9TfwulItBeN516ItW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Trc70+dA; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Trc70+dA"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3663d5e9bf4so6701604a91.1
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 10:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778693623; x=1779298423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jMEgM1iZspGG7I35Q8gjdtCOP5swckX6p2O9sp5dK20=;
        b=Trc70+dAhsaoQAMPsghpGvl1MfIXgqhVwSs6JW5DidovJ1O2gWnUCooz02yOPYr9Cm
         pAHyIUMWWJMYhvvUuIl40ErbPkw5EdiF0UKnCX95ZdXIpfKhYvYKRf3q+SAihzE8HPyt
         xJmHXAzOIUU1PiqQVAhVNjALAp17Ju5NtaW0zXUkiW3T6h9IUCueACferyK/rljpdYjB
         EUNJty7o5noTib3+Xqny3Hruu3uzcwhjkLMT01dK2D+pPv6zyEPyxqhU2B3W71tjqZAS
         jRA8ty+PNNa3gSiJcBKFJFgS6mDQcePzTso+u3e/Yw4fkUuDuo1iPBePOKWmSYVxY08m
         uJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778693623; x=1779298423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMEgM1iZspGG7I35Q8gjdtCOP5swckX6p2O9sp5dK20=;
        b=U4isqW7WSY3Fk5zpURo8K4k9bq+G8cwMBvabV1c7qY08vmjX2CI6T/8nAvejddn36P
         WKXUFpe6YsQtQyhRECOUb00KVwPN4VRP8HoWOMqt8XSxlFYFV3PV0Bd1gCzFXXCMZPE8
         CZN7MbE8tEUGk/ikMyQeLQefFOkEGR0VnhYWUMbtjKKrwHqmtxjCI82CZQnP9YM+5zu9
         Jt4bAYjkYTEA3+/j4NjXdB3tYq5QTzkxu8rgCVsuG5xZoM6OAOnjyYz0rtBoA/QndpTT
         M/7SsVIJE/4rzaHQ93QgDt+Xb2jHCE0xRq6RpqxYHCxr268ZE1EsGoGXE92Tj1WIHKp3
         /Jpw==
X-Forwarded-Encrypted: i=1; AFNElJ87jLP2TrIJD4ReocBhsL69n0FXbymkkRhnKowt0ku0hT7Z87ATyyFG9G+Fm5eDgmOOBZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9PyAGnnHvcGgSdC8a78Db+/WMgOEd5F7VPncJLpBS8BTu86DS
	NDFvmhvNsACYwh+xk05ppbHZdnz8w+EIF5fgAo27TlPPuHCxZLvVJwt3+22yvpwr/uCWwj1cayu
	Z2D1zGA==
X-Received: from pgc19.prod.google.com ([2002:a05:6a02:2f93:b0:c79:83b3:cdf8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9982:b0:3a2:d79c:4161
 with SMTP id adf61e73a8af0-3af8248bdf4mr4453790637.47.1778693622726; Wed, 13
 May 2026 10:33:42 -0700 (PDT)
Date: Wed, 13 May 2026 10:33:42 -0700
In-Reply-To: <20260507081855.GA362060@pedri>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <c2fad21764d2561469151f5dd5d35833ae8f76e6.camel@infradead.org>
 <20260427080554.GD1733452@pedri> <afjeahNaSG0zsMgx@google.com> <20260507081855.GA362060@pedri>
Message-ID: <agS19k6eWBR9Xv3v@google.com>
Subject: Re: [PATCH v2 0/3] KVM: Fix and clean up kvm_vcpu_map[_readonly]() usages
From: Sean Christopherson <seanjc@google.com>
To: Peter Fang <peter.fang@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Fred Griffoul <fgriffo@amazon.com>, Yosry Ahmed <yosry@kernel.org>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 07, 2026, Peter Fang wrote:
> On Mon, May 04, 2026 at 10:59:06AM -0700, Sean Christopherson wrote:
> > On Mon, Apr 27, 2026, Peter Fang wrote:
> > 
> > > Thanks David!
> > > 
> > > I think I'd need at least input from the maintainers on this but just by
> > > code inspection, the kvm_vcpu_map() usage in sev.c seems a bit tricky.
> > > Unmapping doesn't happen until right before switching to the guest, so
> > > this might fall into the "keep the mapping around for a longer time"
> > > category [1].
> > 
> > It definitely falls into that category.  But that code is also rather gross, i.e.
> > could use some cleanup no matter what, so I don't think it's a good argument for
> > keeping kvm_vcpu_map() around.
> > 
> > To avoid a bunch of pointless work and churn, let's hold off on hardening and/or
> > renaming kvm_vcpu_map() for now.  I'll take this v2 as-is; even though taking a
> > gpa instead of a gfn will conflict with the nVMX series, it's dead simple and a
> > worthwhile cleanup even if some of the conversions get discarded shortly after.

I had a change of heart after looking at the applied code, and after going through
Fred's gpc+nVMX series.  I don't want to have a discrepancy between kvm_vcpu_map()
and __kvm_vcpu_map(), even for a "short" amount of time, and I do think it makes
sense to pursue switching to gpcs for the nested code.  But, I also agree with the
changelog's statement that __kvm_vcpu_map() fundamentally operates on gfns, i.e. I
don't want to "fix" the discrepancy.

The other thing that swayed me is patch 2; I have a separate patch (amusingly
related to gpc stuff) to extra gpa_to_gfn (and others) into kvm_types.h, and so
I don't want to take patch 2 either.

Long story short, I'm going to grab only patch 1.
