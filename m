Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35083FDC0A;
	Thu, 28 May 2026 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996318; cv=none; b=EPzF5JtzmtaioSSuva5qckfelhC/126LpCmEjXIFb6Fy1JMjn2MZNmbK1O0pDeQGb8eNv24vERdzvrzbHpxGjMUZzbvqTk4iyu4f9Zq9qivuyE53aSRCOAl2m8nXBJkgGmsiuMmEmjlHGNzU4il/oQmxAy7lmgSlwbnRAkHfU9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996318; c=relaxed/simple;
	bh=BCVZQw57OGHRgOm+XrG09HVAqNbj1Ydq2Twf70boT/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnX5JXTPSQUBES8PEMxkFZROgmmCzywEcQR6jJf5/Ym6VNRWmeK3TktHOhCyhzqSca4RpOO3ElRqJC2Ozq3IINglqBcPUHZPLsnmDaq2L0XYPR5EM4pS6fl4QE+1nHfwHREkOPOELnLTmbXj7dW1po+NDF8mGYhgMzIEO5vWlgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd+gUxwv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd+gUxwv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482571F00A3C;
	Thu, 28 May 2026 19:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779996317;
	bh=ThQPiui0qAmRPADjVza9H5dcFizNlcLmVlDeBNo4AMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qd+gUxwvr99vCoaerTlCFbard0LNbQmyW9rCrFCwyWDRMBOXQzcMkPakGEXaKEpdH
	 94q4snKS3g7D5lJs2UDnDhNOMaNqyTU6iHDF7AAMdWfjQJ7SVnJQt21/O2+LO0MWIV
	 zuve9OIDnTl9t0OKqorJeogBPX5hTfjio2awzbtD66eYqxs4V8LNfsKPQgpv6xfddd
	 2ht7AK1zBzNtfQmZOGQst8LvbUItnuf9PmuO1YoYii/MFfE86K6VYp45rC4HchaxtA
	 IPWOOsVMuR9Q1tKjMH9WQFaeYax/FW6f3xWNiDTUlo1HQO24ejIm/i8VH7eu3ieYym
	 5x8r5RORmYWVQ==
Date: Thu, 28 May 2026 19:25:14 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ackerley Tng <ackerleytng@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Ira Weiny <ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>, 
	Sagi Shahar <sagis@google.com>, Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v13 07/22] KVM: selftests: Introduce structures for TDX
 guest boot parameters
Message-ID: <ahiVwxm2kD0TVqxj@google.com>
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-7-6983ae4c3a4d@google.com>
 <CAO9r8zMY6i+TWoZPWzj8zB+Xw3rONbK-Nee1kSFwDkT3hy66zg@mail.gmail.com>
 <ahDhQJI7xBOQpnjg@google.com>
 <CAO9r8zMaiGL8v=f72EAwWbwofoUHOkH8r6Se22k2TVxnUCQLOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9r8zMaiGL8v=f72EAwWbwofoUHOkH8r6Se22k2TVxnUCQLOQ@mail.gmail.com>

On Fri, May 22, 2026 at 04:50:07PM -0700, Yosry Ahmed wrote:
> > > Sean, is this the preferred way to expose offsets to asm files (or asm
> > > code blocks) -- as opposed to say using .equ [*]?
> >
> > For actual .S assembly, yes.  For inline asm, maybe?  If it looks prettier, go
> > for it.
> >
> > > If yes, I can rework my nVMX GPR fixes to use the same approach for
> > > register offsets. I wonder if the non-TDX part of this patch (i.e.
> > > Makefile stuff) can be split, then patch 6 and the Makefile stuff can
> > > land independently and allow development on top.
> > >
> > > I can also split them out and include them in the next version of my
> > > series, then whichever series lands first will land the offsets
> > > support.
> > >
> > > WDYT?
> >
> > Hmm, I'd say keep your series as-is for now.  The OFFSET() infrastructure really
> > shines for proper assembly.  For what you're doing, AFAICT it's only marginally
> > better.  So I don't think it's worth juggling dependencies to use it right away,
> > we can always convert if/when the TDX series lands the fancy stuff.
> 
> Ack. We can do the switch later like you say.

I take this back. My series builds with the internal toolchain, but not
when I just use make with LLVM. Probably different compiler versions or
build options, but the fact the .equ thing doesn't always work means I
can't use it.

I would paste the error here, but the compiler literally spits out
incomprehensible garbage.

Lisa, if you will send a new version of this series for other reasons,
do you mind splitting out the non-TDX parts of this patch? Ideally we'd
have 1-2 patches that introduce the OFFSET() infrastructure without any
TDX parts, which should make it easier to pick up separately or include
with other series.

If a new version won't be needed anyway, I will just wait for this to
land before refreshing my series on top.
