Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CBA4A23;
	Tue, 21 Apr 2026 23:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776814330; cv=none; b=CARoe30oroMI1rLgSVuCO6Wmo8hLXGIiEtRxV++A1UXyBEOAh2tSmi41vg887qZVC1txl5h0HsFdhBb+738VPNAXu20A0qT4j48JPZC7NHXPo457A38MQUwWGrHoToX0pHQpxaGN6bfKQv4OYQxFseig3/PQYe3lsixxI28nEPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776814330; c=relaxed/simple;
	bh=q1D5SMCNzWViZ20I3r4uKlRvyHo9NptwrP0Gh3oIxcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=go3fW3lX5yG5CsektpU2DsuUJHYxB/MYaYCPQmUlGRhS55GDPQxQwLu++o/3HL5BNnY5ruw1nc9B0Z5T6BMJzT/LwGVWcx3oinbQXSFET5AFZfNNlYqJ87GTk74+t5XSYkAyV/zX6HIAtb99QeG34YR5henbhPnlsLA/nmtcn1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnWATvzF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnWATvzF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AFBC2BCB0;
	Tue, 21 Apr 2026 23:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776814329;
	bh=q1D5SMCNzWViZ20I3r4uKlRvyHo9NptwrP0Gh3oIxcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TnWATvzFxr6KgSTBPG9NS6OG0e+ZpQq74Jey2e7yRY0RWvTXHdmNvKYJl4GdqInk+
	 MTIDt+zDmCZuCDq0VQ7VF8OnoXr8sPkBo7mVkVR7yZr3Y/S+4WU2bhlbHwFdyBWUj0
	 hE8TlXJCEmEszlQz7BOgVV/D8HXTYUm5MuH5duOPKS7JZ6t8PbxXc9sDyaFThhBmbD
	 9iTbGhESV0wnKj/z4M/rVupZTBZA8RCscDGCaeYa7OA5ttziPCYyR6adQfiEb14tQR
	 i7spdkgctBwVPjfzHs2aPNMLEUQ1tsUDqizAqCgqLO+nLdOB5S9elzM30ZXEY3xrCB
	 aIOcr0VOs6r/g==
Date: Tue, 21 Apr 2026 23:32:08 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] KVM: x86: Move kvm_<reg>_{read,write}()
 definitions to x86.h
Message-ID: <aegIHrL1pqnRkhDh@google.com>
References: <20260409235622.2052730-1-seanjc@google.com>
 <20260409235622.2052730-7-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409235622.2052730-7-seanjc@google.com>

On Thu, Apr 09, 2026 at 04:56:17PM -0700, Sean Christopherson wrote:
> Move the direct GPR accessors to x86.h so that they can use
> is_64_bit_mode().
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/kvm_cache_regs.h | 34 ----------------------------------
>  arch/x86/kvm/x86.h            | 34 ++++++++++++++++++++++++++++++++++

That's a shame, register accessors semantically fit in kvm_cache_regs.h,
but taking a step back.. is it even worth having kvm_cache_regs.h
anymore?

At some point I needed to move guest mode helpers out of there too (as
they should be):

https://lore.kernel.org/kvm/20260326031150.3774017-3-yosry@kernel.org/

With this patch and that one, we'd have <200 lines left. Is there a
reason why it can't just be merged with x86.h? I don't see any of the
headers included by x86.h including kvm_cache_regs.h.

