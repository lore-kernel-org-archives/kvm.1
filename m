Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB6524BBFD;
	Sat, 30 May 2026 00:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102020; cv=none; b=GRw/VQ5ydEnOw1WiTTy7X76DUNDe5X7J4SonBmv8k+/Da9Z3170Tu7Q/KmWUq9/IlYqb4w1RyZutOJTQuX2zj07+qsGaIo5vQgwj0zLz/DFeYW886LbTbEU/4+I3z4o2g6nqkodKxQWyED3U8xSGvX4iPH5VLPw3lUBmyrchxfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102020; c=relaxed/simple;
	bh=92R6sZe6Zb6+rhTrMOwzSE7wCQ/3IRA/JWmPZQ48H1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJIZZAt8zOGysII/q941yzwWJ3FzK5FVevPRDSZIT1ypXV8YFC5RvLdF7/fnShCjTuMe72p+R8fle/pl7tFlGCDAkxWStJbxLsegBS8oogE8cS2Zc4Ox2L3nwrBQQR4TQ0WeTFHIVlKmmAqTlwW+w4vXMO84QzLuMLjJrPf9XT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+deIH4M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+deIH4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074651F00899;
	Sat, 30 May 2026 00:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102019;
	bh=aRAO9r1hsSw9YPO6204yWOBfZjoqOAFn2awzoMo6wMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m+deIH4MP5akeZ8L2wo62TSG591G+2dv5ubRNV+H1w+Es4als4TmQHWKS6QR0aqN+
	 FwpV3OMtoFCCcIIVDGFzEIVLZhPZl7L6hAceyCpBIY/a5J7UieDanl3n8OShC7vxjp
	 yEuH84TUFb4MHymRNWmzE0NzTDbRU3djVci8q7beOF2rAAzM249i/sax0C2ZM+7Qaj
	 KmRLUCI3l9P43fT+Wr1CO09VlSkAVRL3vuAhXR4EueoWjZvgUCkU8NA+1t6MYt2uPn
	 I2ta+kBYqNbMsD00qIoSckbpeiN4QJDDCPK/0I1Ri2OK5MmdtWURpemqBPgpBjS4Nb
	 DA7ssp/fcMjBA==
Date: Sat, 30 May 2026 00:46:57 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 18/40] KVM: x86: Move kvm_caps and kvm_host_values to
 asm/kvm_host.h
Message-ID: <ahozfeMI2sj59Ltk@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-19-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-19-seanjc@google.com>

On Fri, May 29, 2026 at 03:22:01PM -0700, Sean Christopherson wrote:
> Relocate the kvm_caps and kvm_host_values struct definitions and their
> associated global variable declarations to asm/kvm_host.h to allow for a
> variety of cleanups in x86.h and mmu.h, and to establish a (hopefully)
> maintainable rule that asm/kvm_host.h's role is to define common
> structures (and declare any associated globals), and anything needed by
> arch-neutral KVM.
> 
> While it would be lovely to trim kvm_host.h down to the point where it
> *only* holds things needed by arch-neutral and/or non-KVM code, multiple
> attempts to do just that have failed miserably.  Trying to "hide" code
> from arch-neutral KVM is too restrictive (and ultimately pointless), and
> KVM x86 itself also needs a place to define common structures and their
> globals, e.g. to avoid inconsistent header include chains and/or misplaced
> helpers.
> 
> E.g. as pointed out by Kai, it's weird that x86.h, which is a kitchen sink
> of sorts, includes regs.h, but not mmu.h.  Literally the only reason that
> x86.h doesn't include mmu.h is that mmu.h references struct kvm_host, which
> is currently defined in x86.h.  As a result of odd include ordering, the
> very clearly MMU-specific helper mmu_is_nested() lives in x86.h, not mmu.h
> 
> "Fix" the kvm_host dependency so that x86.h can be the "central" include
> everyone expects it to be, and set KVM x86 on the path to having somewhat
> sensible "rules" for what goes where:
> 
>   - asm/kvm_host.h holds "common" structure definitions and associated key
>     global  variables, and things that are referenced by arch-neutral KVM.
>   - <thing>.{c,h} holds relevant declarations and definitions.
>   - x86.{c,h} is the kitchen sink for everything else.
> 
> Cc: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
