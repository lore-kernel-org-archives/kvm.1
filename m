Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FD23D3D15;
	Wed, 13 May 2026 06:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778654136; cv=none; b=YjbjTJy+GPSXYej9W5WN4zTMEgeO17nUILEzhTh/71ejBb+BKk/PyYIsQH5ljpJ9A9FJkuXreaHm7lCLrhcQu/URadWBVxK1LzP9xlIqhxHA0H1mHgXSSDVxUrbcVQiDE9KDW68mmZUgnxI+RATSbmzubwFrASCheSfe4CtX3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778654136; c=relaxed/simple;
	bh=IAtQt9XJAxWCq1fOQbZ3l8tlNnaOP8cqwO/8STamx2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WE5XTPiqiTPX1qQne1rVcJv3W1gkPIQpoSkSzXNuMuWZIR7+2zuIyhdK4StNDTLC2lCeLcDR+rNo7E/BBGyk23KYUbVIyVSeFi2TIBZQq1487SVaWYDZHWHq/99I31pR/fDImNOQiRl6xsW5xjrT58OsfhFo7iSJYTE9o88tnkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvlntJBx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvlntJBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A3FC2BCB7;
	Wed, 13 May 2026 06:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778654136;
	bh=IAtQt9XJAxWCq1fOQbZ3l8tlNnaOP8cqwO/8STamx2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gvlntJBxEylbcwwc/qBvqoGrcHgelWU8QiX0aoEAp2Z2WNu1Ov1pRKbOF5oG2Ksbb
	 npWiUUP6+t4AnEd60tOCLk3gpdgUj1qk4Z6AUQo+nTjRw+i0INnVNT39P33TP5HUAp
	 K85i09ROj+EcMItGmlb2SbwYeLkOuOqY6gb22nN4BEWaaBk4lsYId/9rsQMywbyHm8
	 JmCpyMOMGpFT3e9/QPfwPbg7tdJglyTFVAV0tZrr3UVhhArN1T+aCGOHKABsh9si7+
	 IqYtFeYgYhTsmBhQOL2IUYHaDKgRMJaDsjAc3VF0Wud9Ge9PEZvDSZISXZQsfRIw1U
	 vHKcq6qWpedmA==
Date: Wed, 13 May 2026 11:59:13 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] KVM: SVM: Only disable x2AVIC WRMSR interception
 for MSRs that are accelerated
Message-ID: <agQKffJ5Mp-5ussq@blrnaveerao1>
References: <20260506184746.2719880-1-seanjc@google.com>
 <20260506184746.2719880-4-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506184746.2719880-4-seanjc@google.com>

On Wed, May 06, 2026 at 11:47:44AM -0700, Sean Christopherson wrote:
> When x2AVIC is enabled, disable WRMSR interception only for MSRs that are
> actually accelerated by hardware.  Disabling interception for MSRs that
> aren't accelerated is functionally "fine", and in some cases a weird "win"
> for performance, but only for cases that should never be triggered by a
> well-behaved VM (writes to read-only registers; the #GP will typically
> occur in the guest without taking a #VMEXIT, even for fault-like exits).
> 
> But overall, disabling interception for MSRs that aren't accelerated is at
> best confusing and unintuitive, and at worst introduces avoidable risk, as
> the effective guest-visible behavior depends on the whims of the CPU (the
> behavior of x2APIC MSR writes on at least Zen4 doesn't match the behavior
> documented in the table in "15.29.3.1 Virtual APIC Register Accesses" of
> the APM).

Revisiting this:
- As far as I can tell, the guest-visible behavior looks to be the same 
  with/without MSR interception? Did you see different behavior for 
  specific APIC MSRs or across Zen processor families?
- The main difference with x2AVIC looks to be about invalid APIC MSR 
  accesses generating #GP directly in the guest (but that wouldn't be 
  guest-visible). I was pointed to this statement in the APM Section 
  15.29.10 x2AVIC:
	x2APIC MSR intercept checks and access checks have higher 
	priority than AVIC access permission checks.

Note the "access checks" qualifier, which covers the #GP seen for 
invalid MSR accesses.

- Naveen
