Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4190A3921C8
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122505; cv=none; b=rRueibpew2UsisEqmbg+A+RqcVGyUGxIyfp+Nomsy9EWDY6gKe/4RKmPET9j66sJNDXYhEH7Wm3REcuF94pogR9IACUYed41syJqHTgIUoKU/OJp1TSDbgVMm0pwf18v9UcmpiCTlbsPxi+UdLtEi2qHegVTbbtv4FNASY2roEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122505; c=relaxed/simple;
	bh=0/TGp3mL/zf8reME5kYkhYaPhOH91jl/0E7euIeuEBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JL7sy8xdXqKYZeSxgvGreLTD66OpFXXa++AkiqfQl8M1JMUgURyrJnmvwv9G+ZKd5tvZ/1k6yQDO2sr8VVarwUV45BGIOFMQn4FA0YtNFxZoDX44zq04r8n0wiaZvM0lzkiGyH59VI8+xnZb3dvwAdM3UD8WS3q2FYoaJgw7E/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kgv8Fy27; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kgv8Fy27"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8423610ec93so5633231b3a.2
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 13:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781122502; x=1781727302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xNT9caAsP3Naf8qE0f2/dE5BKFFF9+5h248zDPqxkMc=;
        b=kgv8Fy27q7WMJGSgHiBq+cPZ4oIc8bg16diBEKm/M28RAjphfCvSe4rAHYY6aWH6Ra
         KzkQUbfgaDZ++GVaiDRgBJujhcT3GzNjMs/8JkksSrdLN744fLNXf1ZjYhGgLCDUf5Wf
         D2u279xiuAarIXHCH+/ER+cUHnuBiTJUFM5ijwubnYUEBErWegBPY/ghFXWhcAvsJWad
         2XUasWiaulHHSZPufjJWCfTRQieFGH9xN60dufuGpRrYiUg9sBBGoxeodhchbaTzzTNs
         waMmYN4TyDM4upttpXD6UYsEmpyELmDocWwGgMW386cc0XRSHoKBHQMLoAXfRg/5urKa
         RhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781122502; x=1781727302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNT9caAsP3Naf8qE0f2/dE5BKFFF9+5h248zDPqxkMc=;
        b=cN2UXpHN6DI5HYcpLU2sCtEDyVZxw2qpucDtKNK0GTNZ/hhCbshd6vL3Geww3M7AJk
         9F4EosvCfjgz85Jwitogz5zJfzZYsqVXIylo1+IuvXK2lPQYqOO5GxZOnfKk7GrtNaEK
         DiPIzt2J/AF9WnT1tMOyQtDLrA6BxXhFfY+VLi5r58RGUwnHveV4oaLhnjb4S2HgHZnL
         MOd52m7zvLjsVEVvJK17mk7zhRcrSsWqxigfgreNebOqzoTmgwt6BwjA42nkml9g1NlW
         UoqziqOKHus4uEYWTP9pw17sLc4mvlBo61aakGddpD2aSp26BXI/qsgvFWk900rxFnZ/
         YfmQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dAQwfB2ER1D3nVJk7w2JOTdj49S8zLBv1BDLzbhbc9/DE+/J/4Tgr9bM7knsDsyX7HNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS/WlNDWhtI1woYLNodXHZjMXnf+pXl7ZL12WRCjR3nWo61O/k
	G3GEFZ6ogj9zO8eEb2G4m9W+Ik1mdVqpDm7Xpx0fDdoJ/TBs7W/fJBGQWAWrzKi4bA==
X-Gm-Gg: Acq92OHAThlnOtS1V4YSANrP5jHkWygfiZHykQ7YDCwj9nNnBPTKO5p8i4VJgWyy51y
	R3cUNNoVMLS/h0mL6buU/HsToM1EhchaW6fbOdA5R27nDi54MzxBOevnVypxYZs8+iLJEN5XGs8
	aIupkuNvKiogQCft7ZslfY0GD2VNPebxyUMvJ/mY5BPuqYu+hD3A15i7o5revm02oia8R4KYKhL
	Y8rTdJ3soCUAtY+fawGnlOhvNqUQwbwKqwF06hUbRKmZZN6aNaLAbmFmYRJsIK40v6Ompq7ZgKZ
	rUIs2I+SRktZghYbzZc++WxL/kDmqsPYG72xUh2W3AEErG5HU1iCtB3p9ke2W8o6sIrow5AqjWS
	Wm0rb77yt/VvUMJ+E4Lu3Bs6nTpBSiELVB6AbOx7UbSe4Yp+sJH3xi8rl5VDIv1ytfM5oBssk4+
	BmGciRNpwV8TgPIsxLNAq4MfX35UBP9UvK239Fq/IdhGD8qMAmN422nh+P3YPKiY+WlikrUd7e
X-Received: by 2002:a05:6a00:b90b:b0:82f:280a:d888 with SMTP id d2e1a72fcca58-842b0db894cmr26207134b3a.12.1781122502162;
        Wed, 10 Jun 2026 13:15:02 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e21c8sm30824970b3a.49.2026.06.10.13.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 13:15:01 -0700 (PDT)
Date: Wed, 10 Jun 2026 20:14:57 +0000
From: David Matlack <dmatlack@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org,
	Josh Hilke <jrhilke@google.com>
Subject: Re: [PATCH v6 01/18] KVM: selftests: Build and link
 selftests/vfio/lib into KVM selftests
Message-ID: <ainFwSTb5-8itT9y@google.com>
References: <20260610005338.2967132-2-seanjc@google.com>
 <20260610010314.DB8861F00893@smtp.kernel.org>
 <aim4lld49oqLrthg@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aim4lld49oqLrthg@google.com>

On 2026-06-10 12:18 PM, Sean Christopherson wrote:
> On Wed, Jun 10, 2026, sashiko-bot@kernel.org wrote:
> > > diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> > > index e0ddd3ff9472d..14316358fd9fb 100644
> > > --- a/tools/testing/selftests/kvm/Makefile.kvm
> > > +++ b/tools/testing/selftests/kvm/Makefile.kvm
> > > @@ -257,6 +257,7 @@ OVERRIDE_TARGETS = 1
> > >  # which causes the environment variable to override the makefile).
> > >  include ../lib.mk
> > >  include ../cgroup/lib/libcgroup.mk
> > > +include ../vfio/lib/libvfio.mk
> > 
> > [Severity: Low]
> > Does including libvfio.mk here break the "make clean all" sequence for KVM 
> > selftests?
> 
> David and/or Josh, can you verify whether Sashiko is hallucinating or has a
> legitimate concern?

That is a legitimate bug in libvfio.mk. Want me to send a separate patch
to fix (see below) or do you want to include as part of your series?

diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
index 9f47bceed16f..1f1ab180f42d 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.mk
+++ b/tools/testing/selftests/vfio/lib/libvfio.mk
@@ -21,9 +21,12 @@ LIBVFIO_O := $(patsubst %.c, $(LIBVFIO_OUTPUT)/%.o, $(LIBVFIO_C))
 LIBVFIO_O_DIRS := $(shell dirname $(LIBVFIO_O) | uniq)
 $(shell mkdir -p $(LIBVFIO_O_DIRS))

+$(LIBVFIO_O_DIRS):
+       mkdir -p $@
+
 CFLAGS += -I$(LIBVFIO_SRCDIR)/include

-$(LIBVFIO_O): $(LIBVFIO_OUTPUT)/%.o : $(LIBVFIO_SRCDIR)/%.c
+$(LIBVFIO_O): $(LIBVFIO_OUTPUT)/%.o : $(LIBVFIO_SRCDIR)/%.c $(LIBVFIO_O_DIRS)
        $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@

 EXTRA_CLEAN += $(LIBVFIO_OUTPUT)

