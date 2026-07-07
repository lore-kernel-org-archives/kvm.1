Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA364D98E6;
	Tue,  7 Jul 2026 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783463689; cv=none; b=jKxfgzfENX6oVuWNCvdVBsX80ZN4R2gXwIFwONe0bYF922OW0FcaxJXITAUDV+iqF8oQBItM55Ilftdh6tQv4xwR71zzLnsCIJl2yc6Z0WP1es66+Uwi65Kuct9sK3S/FxqNmGgZatg+THV2QcaPAFECHLm0Mb2967a1O5pa73E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783463689; c=relaxed/simple;
	bh=bFzFZIrgvScmQOfBlKGtj1Un8PzPUgnSxbixr9vJ92Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPw8n5zkgJ/sgR6MzaSYrbzB6AANcd2WhBvsuEflKWSp9NRUR83HM3bWN71CE6BjAGtKLUCxA4vn9pB0uilCl+bAnRyZ6ojEpyTDlAArzilGGDxHNiEJXvG4l2PcPeYaar2HZE2R6rbSBFAknchefVxlkCq5/U5IYcyxkcRSh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSwQFQOZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSwQFQOZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2314F1F000E9;
	Tue,  7 Jul 2026 22:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783463688;
	bh=w2I3+NzokwBuBeybC2iHSFJtH/AgD6ldKaO+dRqR4Hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OSwQFQOZq1xAeN9omkNaS0sXXxhA0FcLXvBOgjaIayyORDy0a+3TeKukLIHg1wJjY
	 2YNYGqVB+af4562g9m2wBneexd6/sa+q9bqCcsxY+coWgQ+wbPGg6uVoVImSOrJQOl
	 2L/l/vFD3uwpRqb9tlyzvi8iXOtv0ipbZFvcm4QAXaTMkW7faghlt+5XRrnAIk+CVK
	 aP+THCgciI+/RyGR4EAIdlixBr7GrrqkORw/0vCJnGTYH1Iq2v0dOiTKD+3ht4HVBK
	 bZAlHaMzbsjhdVBZ+UtXX6gAJRdgipfBJlYeY9GXTpTbZNlLrDfdEB0Cfc7a4GeAXB
	 LMsRriWy+THww==
Date: Tue, 7 Jul 2026 22:34:46 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, 
	Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
Message-ID: <ak1-vF3qUjeszzSC@google.com>
References: <20260629125205.52394-1-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629125205.52394-1-zhang_wei@open-hieco.net>

On Mon, Jun 29, 2026 at 08:52:03PM +0800, Tina Zhang wrote:
> The SVM DecodeAssists feature is reported in CPUID
> Fn8000_000A_EDX[7].  When available, hardware provides the length and bytes
> of the intercepted instruction in the VMCB, allowing a hypervisor to consume
> the decode information directly instead of re-decoding the instruction in
> software on relevant VM-Exit paths.
> 
> KVM currently does not expose DecodeAssists to nested SVM guests, even when
> the host supports it, and does not propagate the hardware-provided
> instruction length and bytes from VMCB02 to VMCB12 on nested VM-Exit.  This
> leaves L1 with an incomplete virtual SVM CPUID model and prevents L1 from
> using the same hardware-assisted decode information that KVM receives for
> L2 exits.
> 
> The missing virtualization was observed in practice with Hyper-V as L1,
> where the absence of DecodeAssists prevented nested SVM from being made
> available to L2 guests.  The fix is not Hyper-V specific.  Complete nested
> SVM virtualization of DecodeAssists by advertising the feature to L1 when
> supported by hardware, and by copying the decode-assist fields into VMCB12
> on nested VM-Exit.
> 
> Add a selftest that triggers a nested page fault from L2 and verifies that
> L1 sees a non-zero instruction length and instruction bytes matching the
> faulting instruction.

Taking a large step back from all the discussions in the other replies:
Is there a measurable performance improvement? Not trying to say we
shouldn't do this, but we should at least see what we're trading this
complexity for, it's obviously not straigtforward to fully virtualize
decode assists.
