Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE7A17A586;
	Sat, 30 May 2026 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780103523; cv=none; b=TLzKKmnogmOjM1SnW1AcNhOrVx46TGlstrG/LM062xRcMdLLCYVm78qjgkOoWj6nsc2rK9nlE+/7s0iALRKYLArIKrWBMvjG3AFdl6A0VnygMHy26Yf11A2sCb/LPyB0YzF5ClQWXCrM4HUG/fcJIyFrAuqFMM+fgHcpbIibJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780103523; c=relaxed/simple;
	bh=si1zJFMCrWDRjUGqH7GdPGPz9koAihoVS3BvkPXGOog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp6rG2/xqzhgbwv8R//dV/JcGU40CJV+nTpB0jXsDsqAKVnyVqpVo7pe3RFagDd6zZVfaLvWIYIwLzJt2MZ5/b0hbzo+Tx5YafJkb7PNrt3ixJqCzPkgfCPANA9/Pxhtlj+USSPwTHhX3zHcfdifOq6obQEtmsfEeoLwpvspVNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONWBk+vo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONWBk+vo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983B21F00898;
	Sat, 30 May 2026 01:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780103522;
	bh=L18yVgd3A/H3IUuyEn01FIKzqX21KCgH3KyGaYSEbQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ONWBk+vowc+D43tV+zHyb/4zkyAjjVPRVi3JGPYVm2ZVTNHWigrD55Pn3McwGyWNQ
	 mzgLxYZmxVqBXemUZ4RnvS70V9hBer+XHzROMgVB+K1sumjrKr4eGQg8dzo60/a954
	 osw4XMNRnrS2w9oVQn1WbIeLEA4iSxuTXlI8X8ENEp8Pd35dNqmcHOh+CveGuza12B
	 7ln/009odBvGzOma47urZH0HqZBlpv7v1fPwKqW+HZl6a7nTUOV1DTNCSFYC6DoUMY
	 N9SagOfkxwoVoejc5RZwczEEuvLjyTuNUq7BqzVdWw/jOIP93agUTOnumZyQYa5BTx
	 HIQOdXmpwfPOA==
Date: Sat, 30 May 2026 01:12:00 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 38/40] KVM: x86/mmu: Move kvm_arch_async_page_ready()
 below kvm_tdp_page_fault()
Message-ID: <aho5W-gefHUCQu36@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-39-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-39-seanjc@google.com>

On Fri, May 29, 2026 at 03:22:21PM -0700, Sean Christopherson wrote:
> Move the implementation of kvm_arch_async_page_ready() "down" in mmu.c so
> that it lives below kvm_tdp_page_fault().  This will allow moving
> kvm_mmu_do_page_fault() into mmu.c without needing a forward declaration.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
