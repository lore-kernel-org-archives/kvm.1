Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194A032571D
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775067482; cv=none; b=S9w5aSjep88UWG1X+qWISOTr4PNJj6KXA6tswUmfEXTP8EZXoaKeNqxbchNryQUuZmdoJO5BhBQgTRgs6Jd2Bc3K+1Stk/2rpB3Ou99qmd7/Y8nfPqykQTbCf6vcFV8R//4FHUbhBlDMsdG2da6S7/LnOnTZCCP0ee0D0KymbAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775067482; c=relaxed/simple;
	bh=glz3k+gyPLuzvasdrwJBVWDXlemPVyAnLmd9LpwnCqY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LxO/d21NgRfQTaUxQ/lw0CFU4xQQQJ43KBUz5NeyZmoVHBTfxJ8CvZ1Lm/xTy5y/JyY6OsjFjFTeC9vuugI+dqGtF8ZdfslWSq/9zXbFC0TzZgRnszZ3vZETp5ygJKkJ7lXIGo/RMLChWW4n7DKOBqMtsCrt04PYdTsSKgTfYxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k8o1pJON; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k8o1pJON"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c70d1f56eso25428b3a.0
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 11:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775067479; x=1775672279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CljaTPS+tRVJdi6ueIMvi/stDAUnYu9C0llyC1h/W/I=;
        b=k8o1pJON6EOoySpfDgBAToqS9vUXpSHUfquQb+bnpIhppVzhT2Hu98LPXtokhgc29T
         W46lBh2Zsfycn1/fGXDgVOj5MXAxggIraU0qj4BvKNsFilmHYWFf+P3QSOqprACWJNMV
         LW593kcMDTMu0TToUjr5KeqxNEysAip8r2yQxILnYWK9x0+Yz+xd35TqdkQc0O9HDW9E
         vG2DqqtE1bZcxC6tmASwtN4CNU5xg8G6PYIoOeAsgDdFDJhKYsUwJLtMOo1AgB1b5tgg
         z2+rb3yLYAoUd0q3UhUqQW+Sdo0BBjBiNVUKs8vqIn0k5uyONaOW0Rr9Gefqs/vcJTFW
         SGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775067479; x=1775672279;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CljaTPS+tRVJdi6ueIMvi/stDAUnYu9C0llyC1h/W/I=;
        b=gGZdeDziYVSZQp1n74gV8WK+zFnEoC4KfQy2vZkyxOViKuHl5e6PVBQbuMt0dnonPf
         lWZQymORJYkzcRdwOY88h+PXZrTW+aXw/PznJSJr4XRFnzBIAaMkN38vYyAjALMD9ynB
         cc1jJWyyjFoxt3ptK4qQblIEPaOuFnVugBgJAbj1r3bCQWp8vmYdtUqkybFZC10DH8eM
         sZUhwAnyqaB/wUbtijusl1AzdyuyxvqWyWu4S33/hKTsOVT3KGOAg8znhR+ady6mGmRd
         1tBIXDK0PJzf32zJM+463LJN2/4a/83Z+HKBMoA+8kzRIvK7WCscmnv3j44xZj6tvvvz
         gAuw==
X-Forwarded-Encrypted: i=1; AJvYcCXAEyzBqiyDTf3DU+Y+awKv8rdrz5tbem5Ip1/suDfl5vQHJlG9eEV490BY3UZzPrxb74Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlY25+jQCe+IHM2KEEioVvZ7aJpICqpct621EQ8FK8tUg2hx9v
	XMnzPpka103lY+lcelKs31gRcFZyuC0AE/D1xN8QvmeBWE2ceQkp4DNtC/K/yvC8sGazrJVzIwG
	iw9RWwg==
X-Received: from pfbhc17.prod.google.com ([2002:a05:6a00:6511:b0:82c:e080:9bbb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:aa82:b0:829:8990:3f86
 with SMTP id d2e1a72fcca58-82ce89979d0mr4791141b3a.35.1775067479089; Wed, 01
 Apr 2026 11:17:59 -0700 (PDT)
Date: Wed, 1 Apr 2026 11:17:56 -0700
In-Reply-To: <20260331194033.3890309-2-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com> <20260331194033.3890309-2-jrhilke@google.com>
Message-ID: <ac1hVBR9qxp6whvJ@google.com>
Subject: Re: [PATCH v2 01/14] KVM: selftests: Build and link
 sefltests/vfio/lib into KVM selftests
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, 
	Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 31, 2026, Josh Hilke wrote:
> From: David Matlack <dmatlack@google.com>
> 
> Include libvfio.mk into the KVM selftests Makefile and link it into all
> KVM selftests by adding it to LIBKVM_OBJS.
> 
> Note that KVM selftests build their own copy of sefltests/vfio/lib and
> the resulting object files are placed in $(OUTPUT)/lib. This allows the
> KVM and VFIO selftests to apply different CFLAGS when building without
> conflicting with each other.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
> Change-Id: Ib76374497945025fff60f77e6c72308e900b33f0

Please drop gerrit's garbage before posting.
