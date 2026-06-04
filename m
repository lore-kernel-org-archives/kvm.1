Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D642BD59C
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780614875; cv=none; b=DTKI9hpA0aO0Sghd7sx5SstfOQA0nABmD76FEHoSyKwJ3Nc5jVQzlSSQb8fCAJpUTPsUyaOFC6S86U/0Di3JTcSCTaxIAHFMU2Dt+gTmU8FeRuxYvDxJEJu+pDqjlYPv+N0scgNPLZ+UPLa0Dp02SaZKmHcs7tlhK7t2RpoEER8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780614875; c=relaxed/simple;
	bh=KbIBD6Typey6Tj7uJR/pDL/KpVHmXj3HB1WG71/DbgA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XJBVcIkGgrLLlFWMiObHF+DlNO+LFuI00lu6sZ67OGKD7ioGzIpEyXnBbfobRfy3YFzB0qNsIpL4LSOkySNRRUeOA0GoyTl0SWv5M5UUm1nq3lSEEcnLQLQtAJe6dQ8fugc+PDN5QLw9zklOkMvVcrdN5z7WFf/LsnF+CpSr43s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uP/Osk2f; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uP/Osk2f"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d98b828c8so507020a91.2
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 16:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780614874; x=1781219674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mS9MJ5kCrWOlM6ucjjTqvWj1HBAg+22TNTpHduIiXcE=;
        b=uP/Osk2fEuGVQvcQoZRPIVfLIy9uORK3Ra4um+6wpTSWHZjXaRLgVhtyRmX7ja+Tug
         6lxR1+9j9JpohGLmm7jyXdpexNf3/gYyXMuEiJE/mrTcNY2OFeaXbJgkRGxWh7RXn8ek
         YRI/8Q3FG7TfdYRFUG6b9fcXGz2cvYD7ViYIoX/lfT4IqWKLYz6tYGmNnbOSWPL88/d5
         LgPudn99ggM4Lzdgc5NcUeaxEVJBf9Ggur+mwj45SGbWqmeCETTYysgdicTvdVdOt7k/
         G2xkDhjOk8RmoP+36LG5Os2GPhabpA18i/3oYKrQHHAdDzy7HzSdv9rGKbgIypQZZJCM
         /PXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780614874; x=1781219674;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mS9MJ5kCrWOlM6ucjjTqvWj1HBAg+22TNTpHduIiXcE=;
        b=Wti4ruGIlIc8Nj74VFbVhhk62uGBtTaKD21st05DTcNar/aO8CUxJQ1izm46b9rNZw
         sPGMXSYd5HHApRH8cz4HdXFRSrIZK6yxpAfFbB+ZKssSszQrKfc1JUzbCfUJNDrCHUWg
         jF+JswYggPxdxcnxtfxiwQKyrcHhH83dWRNgn9t17+26V3jWxwMw5/CpMWUf8Y2J3kRF
         Dsvf+gaUx4cS3VNJ04WNICHK4lYkzrjPwTuYRgPJnmHolN4Yzl31aDFD+6usnWpd1X1d
         q7tTuFhKTM3m53khd6wf+cRaX6HIJIQH5F45SKSGsto82Kxvju80A7Pn4+26/pFg0+U3
         ciEQ==
X-Forwarded-Encrypted: i=1; AFNElJ8a896xV+2vYMAWkjdhkSiG7zNUcPQbxgnh7G5f/vo/mbgZmEfUDr1MRNRY6BOv/CrbTrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx09stn1bMEA5BKDUV51ejoddBO51PJrP9PaNz+BJYi0owzdM62
	kEBK+T7WwUGU5zqwrSJyz5v00ut15zxIETBq9ja6Vzwyox0wYxpdwJL2WNggZtEFWR/Dl02rlHb
	IWMCpLw==
X-Received: from pjbbo10.prod.google.com ([2002:a17:90b:90a:b0:36b:d248:5f89])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:394e:b0:36a:aeaf:ab2a
 with SMTP id 98e67ed59e1d1-370f0d4c33emr986368a91.19.1780614873561; Thu, 04
 Jun 2026 16:14:33 -0700 (PDT)
Date: Thu, 4 Jun 2026 16:14:32 -0700
In-Reply-To: <aiHRIhxgBCy1TVfQ@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com> <20260604020143.748245-8-jrhilke@google.com>
 <aiG8Q31nF2L1gNwa@google.com> <aiHRIhxgBCy1TVfQ@google.com>
Message-ID: <aiIG2L_KdPwuxYA1@google.com>
Subject: Re: [PATCH v5 07/21] KVM: selftests: Verify IRQ bypass works in IRQ test
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, Sean Christopherson wrote:
> On Thu, Jun 04, 2026, Sean Christopherson wrote:
> > The shortlog is at best misleading.  There are zero guarantees that IRQ bypass
> > is supported and enabled.
> > 
> > On Thu, Jun 04, 2026, Josh Hilke wrote:
> > > From: David Matlack <dmatlack@google.com>
> > > 
> > > Trigger interrupts from a VFIO device instead of emulating interrupts
> > 
> > It's not emulating, it's synthesizing.  Emulating implies there's a device of
> > some kind that the test is mimicking.
> > 
> > > using KVM eventfds. This verifies that guests receive interrupts via IRQ
> > > bypass.
> > 
> > No, it verifies that delivery of a VFIO MSI-X through VFIO=>KVM works, and *may*
> > verify IRQ bypass.  And all of that very much relies on the eventfds to be in
> > place.
> > 
> > > @@ -119,7 +160,17 @@ int main(int argc, char **argv)
> > >  	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
> > >  	vm_install_exception_handler(vm, vector, guest_irq_handler);
> > >  
> > > -	eventfd = kvm_new_eventfd();
> > > +	if (device_bdf) {
> > > +		iommu = iommu_init(default_iommu_mode);
> > 
> > This needs:
> > 
> > diff --git tools/testing/selftests/kvm/irq_test.c tools/testing/selftests/kvm/irq_test.c
> > index cf4568718cee..2e7e100d4815 100644
> > --- tools/testing/selftests/kvm/irq_test.c
> > +++ tools/testing/selftests/kvm/irq_test.c
> > @@ -235,6 +235,8 @@ int main(int argc, char **argv)
> >         }
> >  
> >         if (device_bdf) {
> > +               __open_path_or_exit("/dev/iommu", O_RDONLY, "Is IOMMUFD available?");
> > +
> >                 iommu = iommu_init(default_iommu_mode);
> 
> *sigh* 
> 
> <rant>
> This is beyond frustating.  I have A PERFECTLY FUNCTIONAL KERNEL, but this test
> VERY SUBTLY "defaults" to IOMMUFD.  ARGH!!!!!

Ok, here's what I ended up with.  A param to let the user force a specific type:

	printf("-t	Override the IOMMU type to use (vfio_type1_iommu or iommufd)\n");


And then auto-probe logic to make a halfway decent guess as to which type/mode
to use.

  static const char *probe_iommu_type(void)
  {
	int io_fd;

	io_fd = open("/dev/iommu", O_RDONLY);
	if (io_fd >= 0) {
		close(io_fd);
		return MODE_IOMMUFD;
	}

	io_fd = __open_path_or_exit("/dev/vfio", O_RDONLY,
				    "Is VFIO (or IOMMUFD) loaded and enabled?");
	close(io_fd);
	return MODE_VFIO_TYPE1_IOMMU;
  }

...

		if (!iommu_type)
			iommu_type = probe_iommu_type();

I'll probably throw a TODO in there, because the VFIO/IOMMU infrastructure really
needs to handle this, *especially* since "default_iommu_mode" is globally visible.
Hardcoding a "default" to an entirely optional thing is just evil.

E.g. instead of iommu_init() => lookup_iommu_mode() using default_iommu_mode when
passed a NULL pointer, have it choose the type that's most likely to work.  Then
the IRQ test can drop its probing logic.
