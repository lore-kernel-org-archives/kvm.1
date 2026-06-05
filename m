Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CFE2F261C
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 20:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691770; cv=none; b=eETmnXgL7T/v3hUlGPm1Oatz+aeDvTYtvzRlxKC73Tk/8MOHB/b4s+x784cRFwqdxFmqwvBithbdFNwplJqfEUZRIXUwIltclK1aNJATVNQanhCMH3sqHITgr19t/cHLaoKfmzhjYBzOOmeloK3f4Gl/1X0sEDH+zGIy7HBU3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691770; c=relaxed/simple;
	bh=LRXPOlIF1u0N+TP2apYKoNdo9UrvURThL2zIrUenu9Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F4Y5F2Ll8wwAIkvOx4ufTtsIAO/xm64iI7dVZUkEieRNKV17zK0Wuem+O1kK5X7sONSyM4l18gmpQAUI9KyD/XIzP0xXA6nABABEupy6KrkJpHrT9+Ct54Akjh9ovN4wEnDm12dKPiJLR9QmHu4LpXvc8KT9vRMsdO1Y+wkbL34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ekZNWBFZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ekZNWBFZ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0bfcd629eso29236135ad.2
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 13:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780691768; x=1781296568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hHafPAGDe/eWeaCKzfKDatL5cxrvc2D5TLAN5e2FWVM=;
        b=ekZNWBFZV+xBL/phRrUAW859Bx4Pk//rW5QNMaq5qLUHPWrcQzKW0K9Mj7U3vSDbD0
         stBEFcci+f8bddnEws04irIoKkEAoth+ccajhMvs0jj6AaX8unHKjq1rMI7VvgnNR3pt
         e6EZoLdwXJyra2NifFy/c5wRMCslNxn3Dvnj4l/EzLVckHF19prhV21PB+7xow/yXgyQ
         HChAN/jwN6HnVAO8n+IOT77DLfHIGVdjc36h7JKp9U4VfZUsaC/na7X9990FjMMEySXH
         FEtfdD6iNVC9pRZqqi/ybUCoxxjX5z1IqPrli/E1vVkPxQ/uimqj6KPgKaZAIFoaXB2f
         O2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780691768; x=1781296568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHafPAGDe/eWeaCKzfKDatL5cxrvc2D5TLAN5e2FWVM=;
        b=T3UORYUXUoSvGmV9HUwJ5HaLdrQXg7YeHOw4g1aCXghjlTuEBmPfopdC2DZPk7jTej
         oHftl0oBQFogtOVVu8IQo+ocnK2M/aPBs5o9O+4kFxgBDGhAgnLpORY3Xl+24aMPxYOL
         rp+29wicl9fpecjBro64JmaeZcrklsKmFF49lQsX3z4kQc1bETgj7HX0GDFpFFGVSeON
         +bMsxwUgD2w6g30oqd9tWkNbeXbAzwxqYPgF0Hxb0F2kPi9vZKOO6Vt317RXYmPej2Il
         jS0QSQAXoO/FFr4WqVT/pPuLOfPLHUab5Hgcwfj8cvyiQV2qY+yj/6vLqbyqNCuF014W
         8wYg==
X-Forwarded-Encrypted: i=1; AFNElJ9BWzliXVvtM1Ry4EBIc4mgW99KtlEtl+nWVltdU1wvaM1/Iyc4U76z1QsWmlLLUAasdas=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlvFOW3Eg7QVWy65Y9tl4f9GgwJCGs2nrpGbl+ovQywqUsLwq0
	s/Usj/Z/vcX1mxvjLKnXwM+SLiRw/QeeQy7+peDmPVChd2m9YU5Gt9ktfRDqU4r8AL3SFIQTjY+
	l/K58bw==
X-Received: from plbml16.prod.google.com ([2002:a17:903:34d0:b0:2bf:13ad:1b7a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce8f:b0:2c1:f262:4962
 with SMTP id d9443c01a7336-2c1f2624b85mr42401185ad.20.1780691768313; Fri, 05
 Jun 2026 13:36:08 -0700 (PDT)
Date: Fri, 5 Jun 2026 13:36:07 -0700
In-Reply-To: <c5b560bba3e41c2109df39214a9b72d4a2ddc307.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com> <20260529222223.870923-31-seanjc@google.com>
 <c5b560bba3e41c2109df39214a9b72d4a2ddc307.camel@intel.com>
Message-ID: <aiMzN9QVOuz7D-Bu@google.com>
Subject: Re: [PATCH v3 30/40] KVM: x86: Move MSR helper declarations from
 kvm_host.h => msrs.h
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
> > Relocate declarations of MSR helpers (and kvm_nr_uret_msrs) from x86's
> > x86's kvm_host.h to msrs, to continue trimming down kvm_host.h.
> 
> Double x86's
> 
> > 
> > Deliberately leave the funky read_msr() where it is, as it will hopefully
> > be removed entirely as part of a broader kernel-API cleanup.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> 
> Btw, not sure whether you like:
> 
> We can also move the body of 'struct msr_bitmap_range' and 'struct
> kvm_x86_msr_filter' to "msrs.h" too, if we put one 
> 
>   struct kvm_x86_msr_filter;
> 
> to <asm/kvm_host.h> before 'struct kvm_arch'.

Even better, we can move it all the way to msrs.c.  Same with the PMU event filter,
it can be moved to pmu.c.  I'll do those in separate patches.

Thanks!
