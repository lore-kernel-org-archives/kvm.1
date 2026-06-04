Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D85F314D06
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601125; cv=none; b=Pm2ggj9jiLr1q89N2iLIgg/ylDqanM50VdzPRvjDPUvFl88pOieyjQ73tBU7ylZtLD9WHgOfNjZaHNCCJyA+yXG8ZtaUaFsm2ld47vXUYcxepHwd8qW6z/gJ5Bnn/bjd6x7lTWAMyHdVkMuYzVZ/BaKH/60ZBuFwoK0+PQRWU5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601125; c=relaxed/simple;
	bh=L/qPSoCGOV61t2VOU6VVNzyHj3wvzTgu4C4avnokKvY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SVsibCaQVYBMQYej2yaaBzDY9uJG4d9xR7Jfcpb3skib4lDwAxP+faZcREcuhV6COur1WoV0/MK9gT6wKIWdc6Rt/R3JkyJyA94Bz1dUs8ZEenR9RHgeU5sqTPrNU3LJtNK3/0fpTkw0dpcQ6+Egr/o2PY7n8uYjZW7gVwUOjo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gyidbGqP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gyidbGqP"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36b982ec27aso845198a91.1
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 12:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780601124; x=1781205924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ynr9RIwBP5Pl/8p+4aWx2v/BAwSvZs2jJzCTuS4p7H0=;
        b=gyidbGqPRThYjcarB/tfGlHv2LASXCw21orrkBN70JOrU5lba+6smLTogFX2rWD7IX
         RsANM1aL5E4fBBh/OI31CJOTXgCUbO4z3HGeW7BoFOPatTCUvB3cgNrKx6vysQHKFDGi
         VrYsnuVDTKw5Nr0MQoUplkkZ72+WheR1E5Zn2p/D7sUKdr38xjoV03YN3MuWh+eO5Ew9
         fVZgZzA/aVR/tFeO2jqEO0adGWioN3UcCRpFM6MBqFQgPOLtHASXII0pVlZO03EjfdqU
         bONm4FtUvXzRWcqXYyzrE2e8iZSjFWbsrOFaQsROdOT+iLvaKeixGhfd8X2JeqBkTMTF
         eQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780601124; x=1781205924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynr9RIwBP5Pl/8p+4aWx2v/BAwSvZs2jJzCTuS4p7H0=;
        b=E5flIhy2zvwyrjCxiNcuBinlZXSwx5cP8zxNFDAlgrgwPCTpPBkGNhzDcBx9HecUfW
         b1aFxApmV00x3RcCJBbdG+pXjtJ3hXSf7AdKeuKpdUQfHTisgZ9cm/2s4y8l0HmuKC2z
         niGZPj2+iytQNiC70PcIhRkSfFxLUawSP+2+cQ6xAQPFALz5Tb5cqIBzvAQ8dwRXVMN3
         ybGCdVVxHta7Gm/Y/EoB+yFBfYZm0AXEOCzXnfTFEqxfQAWRQNlMBpM0IzvV1WAlfjbR
         2gTHNhH4oxdX5WhKqhZ07L2LBFhjVjvota8YWkjYFf7LE610sYNV5GMRXCFVseg7hbc2
         P49Q==
X-Forwarded-Encrypted: i=1; AFNElJ/IT4h5UU0RVcxFoMjkqT+Mb7tivWYC0z22EsILlSfAd6K0cgRAd0/aAneb3AXY8wxwlY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7q5VyrWGwOCbAJ7IOMw7OWSgIczPd30adcwOw7omy711FMhV
	0lfRHwGu5qTH/+u3JG9jzyRYZHSrFUK06wU6e6NLLAThfVFWF/LehEObZQOvM5g2myarAs9ckfp
	tkX22PA==
X-Received: from pgnp18.prod.google.com ([2002:a63:7f52:0:b0:c85:1159:ffb2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a394:b0:3b4:87b3:913c
 with SMTP id adf61e73a8af0-3b4ccd782b0mr491614637.14.1780601123586; Thu, 04
 Jun 2026 12:25:23 -0700 (PDT)
Date: Thu, 4 Jun 2026 12:25:22 -0700
In-Reply-To: <aiG8Q31nF2L1gNwa@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com> <20260604020143.748245-8-jrhilke@google.com>
 <aiG8Q31nF2L1gNwa@google.com>
Message-ID: <aiHRIhxgBCy1TVfQ@google.com>
Subject: Re: [PATCH v5 07/21] KVM: selftests: Verify IRQ bypass works in IRQ test
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, Sean Christopherson wrote:
> The shortlog is at best misleading.  There are zero guarantees that IRQ bypass
> is supported and enabled.
> 
> On Thu, Jun 04, 2026, Josh Hilke wrote:
> > From: David Matlack <dmatlack@google.com>
> > 
> > Trigger interrupts from a VFIO device instead of emulating interrupts
> 
> It's not emulating, it's synthesizing.  Emulating implies there's a device of
> some kind that the test is mimicking.
> 
> > using KVM eventfds. This verifies that guests receive interrupts via IRQ
> > bypass.
> 
> No, it verifies that delivery of a VFIO MSI-X through VFIO=>KVM works, and *may*
> verify IRQ bypass.  And all of that very much relies on the eventfds to be in
> place.
> 
> > @@ -119,7 +160,17 @@ int main(int argc, char **argv)
> >  	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
> >  	vm_install_exception_handler(vm, vector, guest_irq_handler);
> >  
> > -	eventfd = kvm_new_eventfd();
> > +	if (device_bdf) {
> > +		iommu = iommu_init(default_iommu_mode);
> 
> This needs:
> 
> diff --git tools/testing/selftests/kvm/irq_test.c tools/testing/selftests/kvm/irq_test.c
> index cf4568718cee..2e7e100d4815 100644
> --- tools/testing/selftests/kvm/irq_test.c
> +++ tools/testing/selftests/kvm/irq_test.c
> @@ -235,6 +235,8 @@ int main(int argc, char **argv)
>         }
>  
>         if (device_bdf) {
> +               __open_path_or_exit("/dev/iommu", O_RDONLY, "Is IOMMUFD available?");
> +
>                 iommu = iommu_init(default_iommu_mode);

*sigh* 

<rant>
This is beyond frustating.  I have A PERFECTLY FUNCTIONAL KERNEL, but this test
VERY SUBTLY "defaults" to IOMMUFD.  ARGH!!!!!

And to make matters worse, if I enable CONFIG_IOMMUFD, but don't enable
CONFIG_VFIO_DEVICE_CDEV, then AFAICT, I can't do a damn thing with VFIO.  I dunno,
I can't get IOMMUFD to work even with that.

Worst of all, the changelog SAYS BLOODY NOTHING ABOUT THIS.
</rant>

Please, for the love of all that is holy, when sending stuff upstream, think about
how your code will impact people and environments outside the world of Google.
And more importantly, *test* your code beyond Google's highly curated environment.
