Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2C5309EE7
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 20:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691398; cv=none; b=Vnw6R/KqanYBMXfWSZV+eu/z4W3ZLq+btn+eTlP/CH/5AsatPnydMareXgqdcS7bJ1zAGzK2neY6sONi/WKB3t4ZEPEBMEa/L6Dsf5Fg0f2KPmN5y0ZcagVNeu8XIHVsece2kV3mfSMNl5xKKzsiX+cW3ejip+4uWgNWG9/Wifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691398; c=relaxed/simple;
	bh=7al36cHo3BDtHFQYQ08gLrpOS4J2fFoCoT+d8jqHRo0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TxuhiIkqlXQjwczR1yaHg/eOFMhV44LfYtMw0FfxoFJ7MhT3LifGu88qF3xq8g665cLbCklBxzjnAWb33J/QRR9BKdIWNEZR4+nlZybZFx697kqs4Qa5yjxL5jk3C0jhtk4hqCGOiLRrpOJaZ98B01xPnP0s0DuOX1ymWa7+H90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nO7zffms; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nO7zffms"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c858e0cbc89so1419757a12.0
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 13:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780691395; x=1781296195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2PAYaiZVnbp+27NnF9Bl6rTCI8Ayo8ev30bWFSCGO6k=;
        b=nO7zffmsGhZWxqOhNPTlta/QVfkHANQkM7SuhLLYZWmIxM+IxhLa20rQJaDGY+wtX9
         Ostr6Dj/GKoNTW/3EX2bGlve3PR0d49cbDvsja/eiULewjr4iAIFv04mH3LhdVsP84Zh
         BzclKRUiFYxsfHGW44/ihkoFZK2VlrUIO8ay06g+pf8oBJJ3/nkll6yv369jTzkCRXdu
         +In3KKIbPkT1c02jCjL0RmXFQ8feZY7OuErt28gbld+X/Ls8lTVVw3HLvSAEh7iVtmW1
         jPs/iI0tXi/U9c7rLsN0gWYTzXy0wNlqhhSqeRXLTXWLBEoFgiZPpOmKUtVmieO1gSwL
         QmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780691395; x=1781296195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2PAYaiZVnbp+27NnF9Bl6rTCI8Ayo8ev30bWFSCGO6k=;
        b=ZbHLJ1MK6bIyHfNJxg3sK5phTQ7asflduKSkXNJptKqLrXoNl9NzuHqDZIHh+0HSzF
         yDCRlp+vuhLUAwOy4zNyQXQH8GEeF+yiT2vGOeIr+KD1+f/FwePtYO0EnKzZMcTXjWJ4
         zhdyqIp4izDY3T/92Wq7ztWQXK+sqn2DQjiAMw/glrrVNhsYpA93QUG3/mor1wmOf+Uo
         +fNU8atN2KGz1oYkJJIQocfeCFJpBeI+RCXDBTqQ5XKghJnAwlRBlZi6imFCN9+c8pGN
         isUWJjMOQXZYeP/aYy1j6rYFHjiuEeAejYE197aG+J9og0c7qKJKyPMysZROWNbZ0ME4
         4DJQ==
X-Forwarded-Encrypted: i=1; AFNElJ81KGKf0O5YXJ33iynCD6304WPV4xDtXx3IpcVwTlJgsnsvppOuIGuGWn8eD3fDeHIe+pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxwqB5iDo8tEqIMBvKPOwHhnZJdrLGBtijm/zXrDIEec9zUPQi
	iZSSD/GBHTbeEBLeHTRBVuF2rtEqeEW2wCUpCSJjNiyPXCLBF6jKusrBtLCX+mPd+gPm1z2skx/
	Ch2JZkg==
X-Received: from pgvq15.prod.google.com ([2002:a65:624f:0:b0:c82:7af9:6a4b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:69b:b0:3b4:6f7e:d107
 with SMTP id adf61e73a8af0-3b4ccd4c8b5mr7257822637.14.1780691395017; Fri, 05
 Jun 2026 13:29:55 -0700 (PDT)
Date: Fri, 5 Jun 2026 13:29:54 -0700
In-Reply-To: <652e8b73f2264316eaf72a604b89446df4874a2a.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com> <20260529222223.870923-34-seanjc@google.com>
 <652e8b73f2264316eaf72a604b89446df4874a2a.camel@intel.com>
Message-ID: <aiMxwgwxgtRkSZ8V@google.com>
Subject: Re: [PATCH v3 33/40] KVM: x86: Move kvm_cpu_get_apicid() from
 kvm_host.h => avic.c
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 05, 2026, Kai Huang wrote:
> On Fri, 2026-05-29 at 15:22 -0700, Sean Christopherson wrote:
> >  #define KVM_CLOCK_VALID_FLAGS						\
> > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> > index b7083cd692ad..9264c8ef1fa1 100644
> > --- a/arch/x86/kvm/svm/avic.c
> > +++ b/arch/x86/kvm/svm/avic.c
> > @@ -146,6 +146,11 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
> >  	svm->x2avic_msrs_intercepted = intercept;
> >  }
> >  
> > +static int kvm_cpu_get_apicid(int mps_cpu)
> > +{
> > +	return default_cpu_present_to_apicid(mps_cpu);
> > +}
> > +
> > 
> 
> Looks it is only used by AMD (svm/avic.c).  I don't know why, but it would be
> nice if you can mention this in changelog, since this function seems pretty
> common to both Intel and AMD.

Huh, right, VMX posted interrupts needs the APIC ID too.  Gah, posted_intr.c uses
cpu_physical_id():

  #define cpu_physical_id(cpu)	per_cpu(x86_cpu_to_apicid, cpu)

which is basically the same thing as default_cpu_present_to_apicid():

  u32 default_cpu_present_to_apicid(int mps_cpu)
  {
	if (mps_cpu < nr_cpu_ids && cpu_present(mps_cpu))
		return (int)per_cpu(x86_cpu_to_apicid, mps_cpu);
	else
		return BAD_APICID;
  }
  EXPORT_SYMBOL_FOR_KVM(default_cpu_present_to_apicid);

Given that AVIC uses kvm_cpu_get_apicid() only when getting the pCPU for a loaded
vCPU, it darn well should be impossible for the CPU to be offline, let alone not
even present.

I'll drop this patch, and instead send a separate patch to have AVIC use
cpu_physical_id(), and kill off both kvm_cpu_get_apicid() and the above EXPORT.

Thanks!
