Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8F36A008;
	Fri,  9 Oct 2026 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560792; cv=none; b=LNopYkHmCl5SGBPsP4cXLw9WW4q4jcvX2j6M7GcrHI5zRpbbGTJV0kwsj82H/Q5xUdvZ74hkBQPEQfMH0QrypYsDC950PRu+RiE7vzNogKgdIYTwjMK9+V1Pkjt7VTiQTvxMXgf0dkBqvJJBBu7wFyANnEY74PLpwiLdO5df+/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560792; c=relaxed/simple;
	bh=aP/7GkrBn3jrEG6AQgFvgj8B9nedRMizD3Vx+hrgWCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEuoshbeig9nFajbHK0ygIXyt6U59hh3t6o5mCpD1ZU9WnOUXAG0s39fjnA26zttLYGa5VqrUqWyFLRu5o36uvm7/Od+3Cd9BlO5VYk8+pO6oZ/6jI0e4IFiO436hQBdhn0yGn93rnNI0MZRXHrnaYSwoJj75c8SYE+H3Q0g4L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3Rg1HT3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3Rg1HT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4CE1F000FF;
	Fri,  9 Oct 2026 15:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791560790;
	bh=Adl9oKzEQ1qpTvFbUDgNEZejDAB5DaE0VzXfwBnxvgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d3Rg1HT3TOCR4bjLIBDaceFeNyJb0u8k5JGM6/Kqyj9/3ZmscBbRJIIt93k5jMz/o
	 XZqqVI04JKQtCQ0SixRLZHSjpW3XZfawy8bUpLcoR4wgS7sx536an83UKdPfKaAunR
	 EHiWQifaz3b6xpx2AWWo3qfcx4Zn6le8ZPauC0wrONPUspjGe2glYETIqJGT1S6HYG
	 nOFogzR0cZMKq/yed3Urtm4dEybJSmvDO+U5oCY7w2ZuEuPZxGcS6rQjbEXRymmq83
	 uHqoB//Pkmg6+JAerEoGb0V2SlMxnbij7RF7tvMUFVKftpTnLIqVeqiBa349ox0251
	 EjlB67VX+BeRA==
Date: Fri, 9 Oct 2026 15:46:29 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v2 21/29] KVM: nSVM: Handle nested TLB flush requests
 through TLB_CONTROL
Message-ID: <askL_UupgvYqNRKW@google.com>
References: <20261008001425.2458927-1-yosry@kernel.org>
 <20261008001425.2458927-22-yosry@kernel.org>
 <sashiko-outbox-163476@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-163476@kernel.org>

On Thu, Oct 08, 2026 at 12:36:21AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kvm: nSVM: Failure to clear vmcb12->control.tlb_ctl on nested VMRUN causes sticky flushes
> --
> 
> commit a1eb425c937534a8aa46b2b08b4187a40adeac38
> Author: Yosry Ahmed <yosry@kernel.org>
> Subject: KVM: nSVM: Handle nested TLB flush requests through TLB_CONTROL
> 
> This commit handles L1 requests to flush L2 TLBs using the TLB_CONTROL
> field of VMCB12. It triggers ASID flushes and NPT syncs on nested VM-Enter
> or VM-Exit depending on the type of flush requested.
> 
> [Severity: High]
> According to the AMD APM Volume 2, Section 15.15.1, the VMRUN instruction
> processes the TLB_CONTROL field of the VMCB and then clears it to zero.

I am surprised by Sashiko's inability to correctly parse the manuals,
this isn't the first time it quoted something that's plain wrong.

AMD APM Volume 2, Section 15.16.1 (it was 15.15.1 in older versions)
say:

  The VMRUN instruction reads, but does not change, the
  value of the TLB_CONTROL field.

So this is a hallucination AFAICT.

> 
> Looking at the implementation in arch/x86/kvm/svm/nested.c, specifically
> within nested_svm_entry_tlb_flush() at line 710, the new logic requests
> KVM_REQ_MMU_SYNC_ALL_ROOTS and KVM_REQ_TLB_FLUSH_GUEST whenever
> svm->nested.ctl.tlb_ctl is not TLB_CONTROL_DO_NOTHING.
> 
> However, it appears KVM never clears tlb_ctl to 0 in vmcb12 during the
> nested entry sequence, nor during VM-Exit in
> nested_svm_vmexit_update_vmcb12() at line 1582 where other
> hardware-cleared fields like event_inj are reset.
> 
> Because KVM fails to emulate the hardware behavior of clearing the field,
> will L1 hypervisors that rely on hardware to clear it unknowingly reuse
> vmcb12 with tlb_ctl permanently stuck at a non-zero value?
> 
> If so, does this introduce a regression that traps the VM in a persistent
> loop of heavy MMU root syncs and TLB flushes on every single subsequent
> VMRUN, resulting in severe performance degradation for the nested VM?
> 
> Could we add a step to clear tlb_ctl in vmcb12 to prevent these sticky
> flushes?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261008001425.2458927-1-yosry@kernel.org?part=21
