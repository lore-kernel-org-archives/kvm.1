Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC39B262FD0
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991451; cv=none; b=jUKHu8eutcmYCzs8/L+Kb4fRDMBoVh4/TI4iGSnD5I+++JwxBrcUspV2kgBs8zTcdY3cUVGYZoeMyjKDM6srjIl8sW7PU9rZXZA5FRLjqtGhDTSt5U59dxcrU3z7j10ehhLa62PXG52DK3wq1B0lirr0317kPHuHBDaHRrDHWcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991451; c=relaxed/simple;
	bh=ZF+fSn96Jves+govxD2BwBKRuJ1MlR6otbMWwwoFSiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+jeKJxmFyfNwVNeMEQfScsHe3E2mvE02Q0/P6Vn3sL/0r/h2TraUHFUtI3744OXFgff7Q0i062Aw7G0vV2qpjujnOSE+LCsmML6P73g3FQZovYQl/xCVhabo3fFtlCBv7qkElM2wj4t1KqKdSlHAc2oEn3fmrrRp1YcYsMLn/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIfMyYYR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIfMyYYR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958BD1F00A3C
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 18:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779991450;
	bh=q6dQ+j57RYv1QYnEcvP6clIoY+ZXAKPn6BcXZBz/XwQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AIfMyYYRiSvxk3MMrBzY9PJo2x4WVpZO0d50Ssmy4LQS1BHC1Yl26AnPHKlUXxHhS
	 BQyOt27cwmgJUKbMD68qJOGXtc2O1G68OkwxhaO7VMsdWGPFRZIT4mDY4Vg/c401S4
	 MbVihGcFd9Sb6QyFuuXnUafXQJfP+fzQffC/Sk5bt7SirFxuvu0j8kx9y54ifMPLcW
	 yKbRyrAKsfQ0C22xzSffulsY/441DQEUGI1m9c2NxmitGsSwGmeQDduwBV6itCZn93
	 tcEi9YqH0Uhrh4s2kAfqqSc9yq0v+Z9lM5j4Wfzr1QRmS8d2pLoDvs1hd3gk+6S0nP
	 BUzZYWXRB2bSg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67b32c695efso23912846a12.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:04:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+NcXehxp4KuCH6i1DKVqqPhOm8BKjZrorouf7Pz+0arywnrqqr63BPlP7gRS9wbrV3A/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc4lWgBZoacTIqVBn/jVhnjaRsSv4FgMjPudlvqUh2EXNrFtzX
	vr2fzV73i8m6uAVFGwcgiFrk9+QG2+oBODEONtFt6lsxS8azSBEwNv+9DB1fGSrmfq1+LrJXnLe
	lrxRblNAFZdTpOdWk72/bDsyHActjiSo=
X-Received: by 2002:a17:907:7b9d:b0:be3:96e0:95cf with SMTP id
 a640c23a62f3a-be87c9224c9mr164383566b.31.1779991449579; Thu, 28 May 2026
 11:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527234711.4175166-1-yosry@kernel.org> <20260527234711.4175166-16-yosry@kernel.org>
 <aheu-KReRnd7qK1l@google.com> <CAO9r8zNw+iFdZn3uE6p7cCZYVPNeBxAwKhGtKgTErWQ3WL9tWw@mail.gmail.com>
 <ahiDAiyU6M2iNJJH@google.com>
In-Reply-To: <ahiDAiyU6M2iNJJH@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 28 May 2026 11:03:58 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNqZaeqq24DZfLYshgLrkP7ow=Smb18SMrzSSbcnHEmHA@mail.gmail.com>
X-Gm-Features: AVHnY4K0xv4OD0hjG41ekvb5tHtVQ1RFw6pU6egX2aaThfOxq8ygl6IqygyO9cI
Message-ID: <CAO9r8zNqZaeqq24DZfLYshgLrkP7ow=Smb18SMrzSSbcnHEmHA@mail.gmail.com>
Subject: Re: [PATCH v7 15/17] KVM: selftests: Allocate a dedicated guest page
 for x86 L2 guest stack
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Generally speaking, the tdp_identity_map_default_memslots() API sucks.
> > It has to be called after all mappings/allocations are done, which is
> > soooo user unfriendly and when it breaks it takes time to figure out
> > what's going on.
> >
> > I think it should go away. Ideally either:
> > (a) When TDP is enabled in the VM, tdp_identity_map_default_memslots()
> > is called, and then every time we create a new mapping in the VM we
> > mirror it in TDP page tables.
> >
> > (b) Every time we update guest mappings, we mark the TDP page tables
> > as "out of sync", and we "resync" on vCPU run as needed.
> >
> > Either way, it is not as straightforward as just calling
> > tdp_identity_map_default_memslots(), because the current code reuses
> > the same logic as stage-1 mappings, and it fails if there's already a
> > PTE. So consecutive calls will fail if they try to map the whole thing
> > -- unless we free all TDP page tables first.
> >
> > I don't think I have time to spend on this right now, mainly
> > documenting my thoughts, and putting this out here in case you (or
> > anyone else) has enough hatred for the API to go do this before I get
> > the time to.
>
> We're on the same page, this probably doesn't even crack my Top 10 list of things
> I want to fix in selftests.  Ok, it's probably in the Top 10, but not the Top 5.

I suspect at some point I won't be able to help myself, just because I
am curious how this turns out :)

>
> I responded on-list mostly to point out the problem in case someone else happens
> to have in-flight code that will be affected.
>
