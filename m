Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC34314A98;
	Fri, 10 Jul 2026 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696156; cv=none; b=tKGvaxQnfZaW8zc9wA7Yk/I0tFvZx/ErbYe0qQMhcr0o+XFqqNSHku4Dy1Zxs8SVksMU4aA+IhapJTHCKM+tNH+n/cvoWDsdWaDgXLZ3d8UmUvu4jGceZEW78SLvWiZ1uubOIikd/hJtNORNxPtn161LFCW0LrMH+zkPG4jYRbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696156; c=relaxed/simple;
	bh=FpOr1GaszCdpwTvoSh5FZyHHmZYVt0LLcF7/ChkyCuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCEwIIWV3IN0n5GxaeRiWZWYvXD+pSKw5n8/7kBEVQkuhAsOtHOqhP29ttc7+N7sjAwolXM0uqvoqzwgHkbPMKUgPTbfC3Qm1X1NWTDjrWn32fN2gL24koRQaTmFBZNkcORX/VtdXHU0Dyz8W3+iG+PpLe9q2siSN5hOGV2+mgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkQE6acn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkQE6acn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5644D1F00ACF;
	Fri, 10 Jul 2026 15:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783696155;
	bh=H1KU3JgRYTtdKyHozQMFvDQumqN7c+hAQ5BiGJajdoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KkQE6acnNJlsTiPdD0rPt/eE9locYRb/4lDIMi4yWsj3R8A4zTcQpkm1/vuC9Oa8r
	 mhi0gVdkHY8e2ha/r0hIkYoh905sUvfXpkxBUdshelsU5T0ORf7KW5DN7kZ8XunEcw
	 6ipaiI9MawB548xGhri537izjZ82QihLNVXzv/PZTXLgltKno0NS94/YNQaJG0Gh7T
	 FIZXBxn63JwtuVuA9VqggasRm/TzY9IvkAjvvaYIcs5AOpalaKfJ+kz8p2maCjw0MN
	 HGe+c1xHc5SCD6FDpsdFLL0/BBBg3gLqMgj0qnHjXKbba3gJSreCXv8/wEWtirnZBj
	 zkMOeE56rdStw==
Date: Fri, 10 Jul 2026 20:32:23 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>, Tianyu Lan <tiala@microsoft.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [RFC PATCH v3 01/27] x86/apic: Propagate APIC_SPIV writes to hv
 for Secure AVIC
Message-ID: <alEEqV6NshD-T2K9@blrnaveerao1>
References: <cover.1783490022.git.naveen@kernel.org>
 <891e7c5b74a9c027bc417a2dd32e23c0d4d0c336.1783490022.git.naveen@kernel.org>
 <20260710020349.GAalBTBSz6pX3FA_fd@fat_crate.local>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710020349.GAalBTBSz6pX3FA_fd@fat_crate.local>

On Thu, Jul 09, 2026 at 07:03:49PM -0700, Borislav Petkov wrote:
> On Wed, Jul 08, 2026 at 12:01:59PM +0530, Naveen N Rao (AMD) wrote:
> > From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> > 
> > Hypervisor needs to be aware of the VAPIC's APIC_SPIV state for
> > LVT masking/unmasking. So, propagate the guest's APIC_SPIV
> > writes to the hypervisor.
> > 
> > Fixes: c822f58a4fab ("x86/apic: Populate .read()/.write() callbacks of Secure AVIC driver")
> 
> What is that patch actually fixing?

Guest doesn't boot without this change.

> 
> Does it need to go to stable?

Yes. I will tag stable on this.

> 
> SPIV needs to be masked and unmasked by the guest?
> 
> Doesn't seem too earth-shattering to me but what do I know...

APIC_SPIV has a bit to (soft-)disable the APIC. It starts off disabled 
and the kernel has to write to it to enable the APIC. If writes from the 
guest are not propagated to KVM, KVM does not deliver interrupts to the 
guest since the APIC is disabled as far as it is concerned.

I will update the commit log with these details.

> 
> > Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> 
> verify_tags: WARNING: Sender ["Naveen N Rao (AMD)" <naveen@kernel.org>] hasn't signed off on the patch!
> 
> When you send someone else's patch, you *must* put you SOB after hers/his.

I was genuinely unaware of this. Just so I get this right:
- Add just the 'Sob:' for patches from others that I post un-modified 
  (without a Co-developed-by: tag)
- Add 'Co-developed-by:' if I make any changes to the patch (commit log 
  included?)


Thanks,
Naveen

