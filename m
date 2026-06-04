Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5EF384CC4
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602781; cv=none; b=Aawpor/zfo36erQklhBsubNI5KTKgrtWHQ/1jPAJxOwG1lAvo2Cq8eK+GjF760ipK1x7Q5Ed3x+COgQlbkPG0G940xKwJydCvOsbKAuy3n0dVqQXY0/vC02N1fIKel1KIRhJUOGHeMzSYv9uGWRK8YNUZlXAopnBx5hj9rvjmIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602781; c=relaxed/simple;
	bh=Y028cuKR6FYoyxdBLZixo2Z7j4FqlKA2dWY8G2E9U8A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f86hQjpmYl2LEPY/X3dkXSMjVqDlDLlWg02zCSVMLYyhjgVvu3NUS5nXLqOzpVCcFgltcuh9CO+AP8MFyyXu/t7YNcIOOMpBR7i1sccMOTRl7hPtt1dbDh9i8GYOmncG08kVPsDydj84ZnliPPs4N4t9Uze3gbnnF5kUWkaOSCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E5cPE5eY; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E5cPE5eY"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0a99db8dfso12226195ad.3
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 12:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780602778; x=1781207578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sDFg7hairTTD7rHZDg8/KR6emBzfhwen7rYcm2WIInM=;
        b=E5cPE5eY9xehnR4JcbmGalHkc39rOunIbrQ67RnC04tPcv71+1QFt9l8O9tis1FXN3
         i+8WW4AcvQf3a/9IXwY2eVn5cQ9aqMdZ3hg4hvWvDa0SgOn2rcbZ6fhgYAwc++I0rLE6
         PLlOY6E80GAs5LQds9PWmwT9s0F2lwi8yJhtQVXVOW4cZnHVHOvwbTAjy330marRw4AF
         fY5LcgtX/KbiNJw7BM2QpqCvJq8RIGrwr7G3fsvx5b8I+E8tFHuUbbo5Rv245nISDSFg
         THrOpklcqAIwIIAQowV+r75n0Jloh0yCkqWRuYTvqsFSwA3X0QiS9jgLoVZKa+1dfWXR
         x3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780602778; x=1781207578;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDFg7hairTTD7rHZDg8/KR6emBzfhwen7rYcm2WIInM=;
        b=lnwID8TnnfydM5FJb/npGxu6YdvtrwlGHAVsFz38ck5pkiRc6+pL9dYfdI8IKfiv4Z
         iDnAFX+NznHnM2Hpzby2e2jLvbTLEJqYjzMIGJH9tNA3CIsL57Dy4mIbfq7oRovos3sL
         QWfB0i1cs2Abg3Qjnp/OHwpq8YobaeUfNpOCUwHZ7v+7n4r+o4qeVgbyFr0RReqalK+D
         gD9AnChqWEW58YcZzKwKrs2OwFJwURF1Vp9c/qnJFNj/2JaSPa7Q5K0IVpV/7ZB8NQag
         /Am/kUwdLF7yNxJAKynMGc5qmEbR+mv5kFAJAN9dZf+OdCGufcnnUx5PVd1+YppYWiWp
         efyQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5dkE05IccSWK3rBH9zRanVqmgFeYOq6mnxHA1M3t8VMPCBKVUJwH4wZVYYD4QxMevARA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Dtm6pyTjNU4s7tKDIE6ioOUY5PVkkr9F+aOjf6vux9fEla8i
	fpMdo0v5U69wog80oci5tH6MyFpLI4/uKZ7uqcvgjUyz23Iyl1H+PjRxiQES2Q2NA/bY/CbRyEA
	sBgqFBw==
X-Received: from plau10.prod.google.com ([2002:a17:903:304a:b0:2ba:67f8:6257])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:13ce:b0:2c0:c0fa:1659
 with SMTP id d9443c01a7336-2c1e8207360mr576395ad.33.1780602778199; Thu, 04
 Jun 2026 12:52:58 -0700 (PDT)
Date: Thu, 4 Jun 2026 12:52:57 -0700
In-Reply-To: <aiHRIhxgBCy1TVfQ@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com> <20260604020143.748245-8-jrhilke@google.com>
 <aiG8Q31nF2L1gNwa@google.com> <aiHRIhxgBCy1TVfQ@google.com>
Message-ID: <aiHXmTMs81HGfbyT@google.com>
Subject: Re: [PATCH v5 07/21] KVM: selftests: Verify IRQ bypass works in IRQ test
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, Sean Christopherson wrote:
> On Thu, Jun 04, 2026, Sean Christopherson wrote:
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
> 
> And to make matters worse, if I enable CONFIG_IOMMUFD, but don't enable
> CONFIG_VFIO_DEVICE_CDEV, then AFAICT, I can't do a damn thing with VFIO.  I dunno,
> I can't get IOMMUFD to work even with that.
> 
> Worst of all, the changelog SAYS BLOODY NOTHING ABOUT THIS.
> </rant>

Turns out the DSA SPR device is on VFIO's naughty list:

  vfio-pci 0000:6a:01.0: 8086:0b25 exists in vfio-pci device denylist, driver probing disallowed.
  vfio-pci 0000:6a:01.0: probe with driver vfio-pci failed with error -22

Reloading vfio-pci with disable_denylist=1 got things working.
