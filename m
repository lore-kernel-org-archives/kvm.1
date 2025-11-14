Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201F521ADB7
	for <kvm@vger.kernel.org>; Fri, 14 Nov 2025 00:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763081306; cv=none; b=hqHUxTYPV8hC8L6iI3g2TzA461Rt3RC9lvwk1lYfxCDZ6TZzNBtVuyGKbO8luqY9so7MlhmrsMQqaWou2sUNhi+zysYJAAUvM8xoNoqddZP5V4GnzyNSHiouR5bugUsAKYv1YKPDhoK4fpicPlnD2LhhWE7aKa3FavlazYQccuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763081306; c=relaxed/simple;
	bh=a4QXijgvqBr7v4vZWfQe+sv6VTbjhHi8C7mLEuG5cBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqAyJDtryTIVrXDKAZqWb1EPYL/kQ/sF9GJT1OMTaeyUtfFKWCWK6Tq0b+dfblbYoeHeFTfVC2XDeaPuAN4h8/8uBHWKl+dI8enK8oyCAONXgex8RLlPrdWkdUDOf7y3Ls1ESM9fK0gzwHZ4txSpCvXZ8U/QFKbAzXLVBrBiY+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h3gxrIWF; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h3gxrIWF"
Date: Fri, 14 Nov 2025 00:47:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763081301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=awKBPmBE8+R/sDQQkpEY6ofOBRFl9vt/VG/aDp1ugu4=;
	b=h3gxrIWF52TyPo2koaQbr3Mfw0YXsHHTczzQIaZthqET6fN4gEQu+OLreabU5f2XZq4wDF
	hRlR6n91P+cwfu8632R5AgqZKJ/qe3NPrUoxxpGI3QIIaeqqdnkiq6U18jjOKeKv+vjShB
	Cfev1W5EulwqNkBITaSI6l2W/OxLu/E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Cheng <chengkev@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/14] x86/vmx: Skip vmx_pf_exception_test_fep early
 if FEP is not available
Message-ID: <axcelxpkwmqht3lq7gpmp4idkcyujyr4jjtf5gh5usp7gxnl3v@rxckldu4iup7>
References: <20251110232642.633672-1-yosry.ahmed@linux.dev>
 <20251110232642.633672-3-yosry.ahmed@linux.dev>
 <aRZ6bM_yVo9-zyDT@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRZ6bM_yVo9-zyDT@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 13, 2025 at 04:40:12PM -0800, Sean Christopherson wrote:
> On Mon, Nov 10, 2025, Yosry Ahmed wrote:
> > The check to skip the test is currently performed in the guest code.
> > There a few TEST_ASSERTs that happen before the guest is run, which
> > internally call report_passed(). The latter increases the number of
> > passed tests.
> > 
> > Hence, when vmx_pf_exception_test_fep is run, report_summary() does not
> > return a "skip" error code because the total number of tests is larger
> > than the number of skipped tests.
> > 
> > Skip early if FEP is not available, before any assertions, such that
> > report_summary() finds exactly 1 skipped test and returns the
> > appropriate error code.
> > 
> > Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > ---
> >  x86/vmx_tests.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
> > index 0b3cfe50c6142..4f214ebdbe1d9 100644
> > --- a/x86/vmx_tests.c
> > +++ b/x86/vmx_tests.c
> > @@ -10644,7 +10644,10 @@ static void vmx_pf_exception_test(void)
> >  
> >  static void vmx_pf_exception_forced_emulation_test(void)
> >  {
> > -	__vmx_pf_exception_test(NULL, NULL, vmx_pf_exception_forced_emulation_test_guest);
> > +	if (is_fep_available)
> > +		__vmx_pf_exception_test(NULL, NULL, vmx_pf_exception_forced_emulation_test_guest);
> > +	else
> > +		report_skip("Forced emulation prefix (FEP) not available\n");
> 
> To be consistent with other tests, and the kernel's general pattern of:
> 
> 	if (<error>) {
> 		<react>
> 		return;
> 	}
> 
> 	<do useful stuff>
> 
> I'll tweak this to
> 
> 	if (!is_fep_available) {
> 		report_skip("Forced emulation prefix (FEP) not available\n");
> 		return;
> 	}
> 
> 	__vmx_pf_exception_test(NULL, NULL, vmx_pf_exception_forced_emulation_test_guest);
> 
> when applying.

LGTM, thanks!
