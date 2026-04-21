Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C305E36AB57;
	Tue, 21 Apr 2026 23:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776812767; cv=none; b=lZlL9g0upVqteQedjSsSzQ4JOANQKMBf0l/HbyCbjfbRfI8suEUGbtHVLB/LungRNpxXG6fsmY76O1yVUrb8BeUTdRHko3CgvhDv63QSYSGENv1dXtq5RcSKqZJn5lDuvkBlquQbOpL+KvApJqji7oIRej+wDYKNnUG87/GiHPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776812767; c=relaxed/simple;
	bh=gUOrA+M0eFDlj+4WAivTq7ytG3D4fdUcuYjNEftzc+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuE6UqNamBkWBFcz1Or0FIwrdbyFErpzXmm2svtE6O6/obUGT5Wl2VCdjoxNJWTY2G1hdQMRPFXuu51qs3TuBth1XZoi+mVz/7mCOjLbYcBoWuaiA9+UyoxO7RlETigIxC1APE1RpMNunoe3j0pAMpOSQVWQ6jGET32hICFBER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSj+0VTw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSj+0VTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD04DC2BCB0;
	Tue, 21 Apr 2026 23:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776812767;
	bh=gUOrA+M0eFDlj+4WAivTq7ytG3D4fdUcuYjNEftzc+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MSj+0VTwb0esKAJE8jTRYdvwem8owfsQeuNUbdBCA0mASigg5aM/ZfLOYSxCYsfk1
	 eFjaQLMZfdh0X3WGysk21K7k2PIzscSMSDkNsZATjXaML7fPbHlcNMUPAsbBBbjm8M
	 veQ8RZmlwvO/REju1uSNBE8AMplYve51cS+ZtFQT7Mf5XAp/eRvZFhDRjztO5X8Qgk
	 Qq4456aHr4YRMIfSHYuIFAznsus83YUSnAUUzpDm6HSrBzP9U2shpmNmZXvTzPYVxm
	 HkLHbpdHbeyWE0FbY/NORE4zT/8rP1p/2QokfM24MFm1sNBvHQUkOGcIsClAK45qhQ
	 BCv9Y9pLlvuEw==
Date: Tue, 21 Apr 2026 23:06:05 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Peter Fang <peter.fang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] KVM: Move page mapping/unmapping APIs in
 kvm_host.h
Message-ID: <aegC2AONVg7PVf2T@google.com>
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-3-peter.fang@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408001137.3290444-3-peter.fang@intel.com>

On Tue, Apr 07, 2026 at 05:11:29PM -0700, Peter Fang wrote:
> Move kvm_vcpu_map*() and kvm_vcpu_unmap() so that a subsequent refactor
> can use gpa_to_gfn() without a forward declaration.
> 
> No functional change intended.
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> ---

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
