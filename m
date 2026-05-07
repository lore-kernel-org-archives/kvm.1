Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A0E3FA5F9;
	Thu,  7 May 2026 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778162367; cv=none; b=DVX1uVkDUDW7gajlerVJFf37KA3QtHi6RQenPZO6TwahN33cRK36cboLtq8xq5I/PiqAVcni02W7UBgT7nsjed7U1xgcH1Fb8kbIneCTozY2A+pBGRvLcHCJD2rZg0fA4LErTV9QODM85Vn+ObdTmONY1PmpcX/fWC9AC7H50BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778162367; c=relaxed/simple;
	bh=fWApH8Yb/LDFcEUCyuPTArn56L6Nuy5R10LIPMN3rng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1tTNKBca1o7IE0lghtKWyccIRYsznsoHjbtO17Prk4Y17fauIpT+xcNf6KlEkx5676Mq99+PMYIIZOPhmMNoLhiSr48pgQxD8bH+Ova7qdnRqfs1i5nNaL+/9qL6CGtP39wzj556DpZFKfuKOWuPNEjQQ0MZS8Q3pO8+Cr1xj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oihRDRU1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oihRDRU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FEAC2BCB2;
	Thu,  7 May 2026 13:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778162367;
	bh=fWApH8Yb/LDFcEUCyuPTArn56L6Nuy5R10LIPMN3rng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oihRDRU14CibYieJfCt+QEKjDEcnJsvIp6s9uuqrCJ65lj9/ujED8LDqb3MGl+xwv
	 OjNJduckOexeQkPnCLi6s3f4bx9WEennNSsh+fkLEgRp1bLISAgMF1A/rsXpKvyo9q
	 UtG155qVAxWGCHUaKT/PaFroKVHxN/RFOCmjzq/EIfx2n2UHaEgGSm/NhS2BKH22NJ
	 Vt7YqQfy5r0Gru5ehuptxABmtI0ZQ7XrPkikquHMf8wtRKox2iFXD5DDpOy/t0zyPt
	 F+ePCiBr6T+RMOqXvbVBqpUl6ijz640Y7O5g/IOerzGYzHG4tqbAZlqcbzNKekwLcU
	 J9cgp2ifRuNUA==
Date: Thu, 7 May 2026 19:26:17 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] KVM: SVM: Disable x2AVIC RDMSR interception for
 MSRs KVM actually supports
Message-ID: <afx7eh2ghy1_Nd34@blrnaveerao1>
References: <20260506184746.2719880-1-seanjc@google.com>
 <20260506184746.2719880-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506184746.2719880-2-seanjc@google.com>

On Wed, May 06, 2026 at 11:47:42AM -0700, Sean Christopherson wrote:
> Fix multiple (classes of) bugs with one stone by using KVM's mask of
> readable local APIC registers to determine which x2APIC MSRs to pass
> through (or not) when toggling x2AVIC on/off.  The existing hand-coded
> list of MSRs is wrong on multiple fronts:
> 
>  - ARBPRI isn't supported by x2APIC, but its unaccelerated AVIC intercept
								  ^^^^^^^^^ 
								  access/exit?

>    is fault-like; disabling interception is nonsensical and suboptimal as
>    the access generates a #VMEXIT that requires decoding the instruction.

As far as I can tell, it looks like ARBPRI is actually "supported" in 
x2APIC mode on AMD processors. APM lists this in the x2APIC register 
list (Section 16.11.1 x2APIC Register Address Space Table 16-6. x2APIC 
Register), as well as in the AVIC chapter (15.29.3.1, table 15-22).

This is probably not relevant though, since it looks like KVM has never 
supported this.

> 
>  - DFR and ICR2 aren't supported by x2APIC and so don't need their
>    intercepts disabled for performance reasons.  While the #GP due to
>    x2APIC being abled has higher priority than the trap-like #VMEXIT,
		  ^^^^^ enabled
		  
>    disabling interception of unsupported MSRs is confusing and 
>    unnecessary.
> 
>  - RRR is completely unsupported.

Would be good to also call out change to EOI and LVTT handling. LVTT 
reads will now be allowed and should be returned from the backing page.  
I'm guessing this is fine and that the hardware won't validate it as 
LVTT may have TSC Deadline enabled (for emulation).


- Naveen

