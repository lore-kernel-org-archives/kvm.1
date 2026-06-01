Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9B7340401;
	Mon,  1 Jun 2026 20:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780345668; cv=none; b=c5N4lQqGA61yNWGH8ouEN6HD41bV8O7Jy46MogYwyuS1ATI3feDWZUPBTyljnttMrwV853nUrNj+UB33+1tJ0qSaTN54KdQQsgSIXa6NPvAFoZwfpZBt4jxqKzek6iDeon4G16dyh/8WBDUHcWwDkIIBrVbcnv59w3Z6wwwBBWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780345668; c=relaxed/simple;
	bh=+Y2wqvweHCiGUUOwqdw0VHOg9ArvIvlrafzlD6LknfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2B3bbgL0dMhymQD1UKHccdze8wm2igiRdzC87GcBYHIesboc9OV4GvF1NLAptzLmUUzXrG0IEmgwqcJ6/4h/0BFLpWiDpdFpLrM+Gx2CZ+In/cQMeH/9muI6ZG+mi8uaKYEpNX3txxP/NBUgLD+fkjO1vTPk0VVHrDZwG07AvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhGZUzMC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhGZUzMC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCC41F00893;
	Mon,  1 Jun 2026 20:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780345667;
	bh=4Ri0VlbH5QYskRoprN+3pmaTXpxIRdF2Vfb44NSCqw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WhGZUzMCbbNGUq0TBAC4zY/xw5NzEWOgXqJpug43j3p2nm94UCD6cNzR4JZt0hAcs
	 VRRsWJIsoIrk9ETIchrHLN5xZ1acBP5/DOxLhzmcfmutM3vsanEARA3yUb9tBvQdwt
	 57EjTnUkSJeoIIJVp711t5SBjsdEKqbKYBp7YkdSjGC6gplduwN/YXEGl7vrgZ8qPT
	 wrjVBtKSVbKHNwKPvIDmB/5Pa6Yioxsn+Bz7YxhmffewDex0pCYXhgIWY0tdOZcZnw
	 EBARJCrU3X1ItF+sTCNux0TER0qPfKp76TBZvxSSr3aac/Y2b497Z0jsQBwWi7LGOj
	 0jM5p6+FTBYAg==
Date: Mon, 1 Jun 2026 20:27:45 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 19/40] KVM: x86: Swap the include order between x86.h
 and mmu.h
Message-ID: <ah3q7ftEUTRmrBSf@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-20-seanjc@google.com>
 <ahozqrW-YUAOEZls@google.com>
 <ah2dYFrhUc-v3tLR@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah2dYFrhUc-v3tLR@google.com>

On Mon, Jun 01, 2026 at 07:55:28AM -0700, Sean Christopherson wrote:
> On Sat, May 30, 2026, Yosry Ahmed wrote:
> > On Fri, May 29, 2026 at 03:22:02PM -0700, Sean Christopherson wrote:
> > > Invert the include ordering between x86.h and mmu.h, so that x86.h is the
> > > "top-level" include for KVM x86.
> > 
> > You're also silently moving mmu_is_nested().
> 
> I'll explicitly call that out.
> 
> > Aside from that, I thought top-level include means that other headers
> > will include it, and it will include fewer headers. Seems like this is
> > doing the opposite?
> 
> Yeah, I'm probably using confusing terminology.  I could quite figure out how
> to concisely describe this.  I like my pyramid visualation, so about:
> 
>   Invert the include ordering between x86.h and mmu.h, and move
>   mmu_is_nested() to mmu.h where it belongs (mmu_is_nested()'s placement in
>   x86.h was solely responsible for the existing ordering), so that x86.h is
>   the top of KVM x86's "include pyramid".

Not to be pedantic, but I still can't quite figure out this
analogy/visualization.

How about just spelling it out:

  so that x86.h is not included by most headers (but includes them).
