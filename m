Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863172F8E8A
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 19:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341562; cv=none; b=KtSkT4hxHrz3L9GnQSOemOWVkyYpVcaXgvnZhaytjFzeEyee5wZ6awQdECDlzLGelaI867JQCoswNS8GMQhbcnbudoyie47hBu4KCet5wNuTnAmpdlP5GvBGyyA2uKs0MbmA9kphB+IuZXTK3Cj6yiyhJxqXWvI19hP3SE1avfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341562; c=relaxed/simple;
	bh=zEfIVR2+wL4qd2lKvL0S/1//r+Ri4UYei4VxKDi0rks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dFt/1COee+mFF/Ks7bQq8JmZZGKVAs0j0IjkHxbAmr0ddHX8Jj3fFy+DMkz/M3n5WMoEmhD4K5yZzvfZuAIP5UCzbLeT20Yfstu+5L91+ABUGgqya5Jcl6hxh/P8ox8NdN6Nu8qsspnN3U0hABpirFYyaIRrSyYbuvIu6Wz0sXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jCIsZauq; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCIsZauq"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8531d89e59so6484590a12.0
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 12:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780341561; x=1780946361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QSXKKPWPQigwDqxR7LXaP/zXZRziHbHIgw2WNqNefEo=;
        b=jCIsZauqbSgEAdxctf2WJ9zA3raZTvMAiwfFvmZ7Uvbz0QYAAn70moZk9gLDDb8E/U
         waVGqYTQISzBJ7sQp1alOTB8rrXD4WbKFcV3hbzUepSDnj9jbjmeGPiPoHgAnbZESw3Q
         U0SDtei0pqjmlAxZgjOZWXo6//Esy9/znErfWZRIf5mo3ChpIXvLLOZynYqzfml3uh2s
         ORHbOzJYqgzbQcAJ1PsAY5LeZ6yf1zpXspJraStcENHekfRAMSFlmUk+3BzatzHHL7iO
         3yVc24Am/JitwRp0gl/qdYiXs18gZzog7p5R7PBa5sXoFyMp6+MfRrgrTe/BQv5zvE4W
         ukwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780341561; x=1780946361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSXKKPWPQigwDqxR7LXaP/zXZRziHbHIgw2WNqNefEo=;
        b=hq68t/1NeRjQFBFTLHyk0xYfLkSdcH4pOJA4JimUpbRI77FqTVqFW+W4Tw1TzXGxVf
         3DN3XPK3nzxc0gQZDbvxYrMQAtOYERnssP2wa3Y5xyj+uyz56ZaG38WDZVIEQGWkY2Dx
         9jPbuZ7a8c7Np4Ff0lZ7pWnTiYNfGcC3jF53Ym0Oiu3fQI3f33tRVlNF5xlSa6hupWq0
         QLJo0BEdlWb7NZctBh/DirLOWYHWNwns0mhNfDFPv2CcNCSuhmmeuLGiaF4lVSt0v6jk
         2vIu/CTTTsRlr7gJvbhU8fPt5rbGMXnc+AABuDifl30K8RMZpWaA2mKQDSYn3KLwXWZr
         VM2g==
X-Forwarded-Encrypted: i=1; AFNElJ/fP6pRjPF6itbcgcwH+khUtqq9KvB5N9GZG5zPUklUqMNHn3DXOb4E3m2hD1R8ErJoCCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgAbMPX/aNWXgXyq/3PyJT4lYPilQSwj1aKK5KY1JjnGhRIaPF
	DEjSZ7nl07UQhRwyieo+LDB730zMe7TeO2vZ16A4cLeL1Dx/hNXlVQFoj1fsUyw8ysXwZcLZ5DO
	K+rEudw==
X-Received: from pfbcz12.prod.google.com ([2002:aa7:930c:0:b0:83e:c835:edc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a257:b0:842:5bc8:ccf7
 with SMTP id d2e1a72fcca58-8426a97fe80mr579633b3a.34.1780341560531; Mon, 01
 Jun 2026 12:19:20 -0700 (PDT)
Date: Mon, 1 Jun 2026 12:19:19 -0700
In-Reply-To: <20260530002134.558837-3-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com> <20260530002134.558837-3-jrhilke@google.com>
Message-ID: <ah3bN2G7fsaI4zN1@google.com>
Subject: Re: [PATCH v4 02/19] KVM: selftests: Add /proc/interrupts parsing
 helpers for IRQ test
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="us-ascii"

On Sat, May 30, 2026, Josh Hilke wrote:
> index 000000000000..7c465e8584e2
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/proc_util.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTEST_KVM_PROC_UTIL_H
> +#define SELFTEST_KVM_PROC_UTIL_H
> +
> +#include <stdint.h>
> +
> +int get_proc_vfio_irq_number(const char *vfio_device_bdf, int msi);

I feel like the "proc" is confusing and unintesting.  How the utility gets the
information is an implementation detail that I don't think the caller particular
cares about.

"irq_number" is also vague.  There are myriad IRQ "numbers" in play.  "virtual
IRQ", as they're sometimes described by the IRQ subsystem, is unfortunately
terrible terminology for KVM+VFIO.  host_irq and linux_irq are the two names I
can think of that are fairly specific without too much potential for confusion.
I'd probably vote for host_irq?

I also think the function needs to have msix in the name, because within VFIO,
there are multiple flavors of interrupts that can be wired up, and this _only_
works for MSI-X.  And The param should be @msix.

I also think it might make sense to return an "unsigned int", to communicate that
it guarantees a valid IRQ was found, but I don't care terribly either way.

Maybe something like this?

  unsigned int vfio_msix_to_host_irq(const char *vfio_device_bdf, int msix)

or

  unsigned int vfio_get_msix_host_irq(const char *vfio_device_bdf, int msix)

or

  unsigned int vfio_get_host_irq_for_msix(const char *vfio_device_bdf, int msix)

I'd probably vote for the first one, vfio_msix_to_host_irq(), as it's more
obviously "just" a translation helper, e.g. isn't allocating an IRQ or anything.
