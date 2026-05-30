Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E802E738B;
	Sat, 30 May 2026 00:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102640; cv=none; b=LllSsEYjS4bumJ6coSX+mTLpFF/60/H1l+vtklXhAiT2CJExOeLX+PQIi2gtphHkNDjxBfQuFyYRdk+9P3iUAYuraKuMF3tFkFAoxJLzFYTC6w5ZRVcxUWG/lJiu57lkSiLdusIIvknMlbabVQSNr9CgIMmSPiACXklh+mbVYQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102640; c=relaxed/simple;
	bh=nHZ174pXGiMzzryG83Gu46lZpjp7m7SGfv84hA+215U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6YrZVQIa9NnBjul1vZPJd5GhSKpCKIDx/YOGgkV6ix9R7nCIUsEPcLc9f37FYwf/bMB/V9cLxBvZLNxEqL4gCxFQLtT8NLSC0WnCLOGETqiNvRpb5UmZfOZAt4I0nYpWTOePL7/+trfVmPBI8NiGIKn2RMc4luHWtnp1PFKoPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hik4ItVh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hik4ItVh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CCC1F00893;
	Sat, 30 May 2026 00:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102639;
	bh=EGNf6ds118fdttz9Zz3w/IOg2yfMQbT/yiprrJpGLfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hik4ItVhpx9L/7QfY/R4Xtd9o2vmt2lyEfzRfTzuR9RjxElQAd/MgX7b3CT+SZCK6
	 1NACpyaBzVbDHVWhqLQg16UfOjViY6qFQKzN15EFuOWVTTquBcO4dPUsvc0jNQpSQu
	 oV6PuT+ZbuRiw1iOPcfIWHMPYn/NKUd7wKPlO5LXfrMqMBzSgxRAggK6rjb8ZpFh71
	 /Xe6tAmZfROvtZjwHPU1yIsJVajsDFSU+8LFLEMN58HwqhF9hQeyDom+c5kox/7CUX
	 8xIlzVqQxlC89CZ5BxCTeCg/dp0NjoQGSe5RSPiRRiNbuxGJnI4csRLjwE/YUvUPBu
	 j09JbQ4BSPOtw==
Date: Sat, 30 May 2026 00:57:18 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 28/40] KVM: x86: Move kvm_{g,s}et_segment() to inline
 helpers in regs.h
Message-ID: <aho16vOWNK5vgFqf@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-29-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-29-seanjc@google.com>

On Fri, May 29, 2026 at 03:22:11PM -0700, Sean Christopherson wrote:
> Define kvm_{g,s}et_segment() as inline functions in regs.h, as they are
> literally one-line wrappers to invoke vendor code.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
