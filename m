Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235F724E4B5;
	Fri,  8 May 2026 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778258616; cv=none; b=P6IjAofvAsGkp5VTGtgFBln+qTENbpHkJ3O9wyt2PymaaebBIyQjdiF+12xQFU1n8HZOYGwh20amPspXYM3plQXvB8GDC5+6l+NpgpiMhllFnBWXjqDVgiuJ4WhLC3OD/SOvXs4tAk4Aghiim404AwaeSdB30Q21CWhk/F5bXM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778258616; c=relaxed/simple;
	bh=ge4u/4nqH9HkWbjsfP37zR77jmwBcs7cnA6PiUK6Iuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzodMPvmSyroS4+5klo6fiVqvYc2qFMuZWMilx9QsxFfVdjW24eF5s6EXZwOfE+dCdTpg9wxYLEmQWAK49i+FE8EzPaVPezVcb1UiWj2puE053/G08qf7XamGxx3hTka92DDUSW35UlFyGj3751qiPHRe1gOcEJ5SDCkW0bMtm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQViXLUk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQViXLUk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280A9C2BCB0;
	Fri,  8 May 2026 16:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778258615;
	bh=ge4u/4nqH9HkWbjsfP37zR77jmwBcs7cnA6PiUK6Iuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQViXLUk7NWmDTeBmu3Z76GAhbsdP/BlNGKPcQJPpgEpEUgZQeCcNTn33lq75HEhv
	 ki6TcdJ0cdP/wt2qWlxr85DKYw/G4Inn3mtxP5+ewDXrSst6ByKShU5asP7l4iGea+
	 cu1dScSKMsWYCNiWF0MIO24EgkOMk4gigbiiFnP7BXD5v10mAhlx+JFuo5OWY7L2Cv
	 Nl55wbf0krSxG7CtyaYbA4WSo/f+/Pjn3F132r/oVn8hTBUolYFCP554+uYUo5PZtw
	 eNT//ggrXXAT+MnIGj4hxUmMYQD1GR0eZiZZe1vaDUSPfJOb1AXrXQ2tzfsVJZO0aT
	 jT+SJpGCZaVjg==
Date: Fri, 8 May 2026 22:05:28 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] KVM: SVM: Disable x2AVIC RDMSR interception for
 MSRs KVM actually supports
Message-ID: <af4PfTGfBv1gDTb_@blrnaveerao1>
References: <20260506184746.2719880-1-seanjc@google.com>
 <20260506184746.2719880-2-seanjc@google.com>
 <afx7eh2ghy1_Nd34@blrnaveerao1>
 <afyhP1dx7kzUV-D-@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afyhP1dx7kzUV-D-@google.com>

On Thu, May 07, 2026 at 07:27:11AM -0700, Sean Christopherson wrote:
> On Thu, May 07, 2026, Naveen N Rao wrote:
> > On Wed, May 06, 2026 at 11:47:42AM -0700, Sean Christopherson wrote:
> 
> > LVTT reads will now be allowed and should be returned from the backing page.  
> > I'm guessing this is fine and that the hardware won't validate it as 
> > LVTT may have TSC Deadline enabled (for emulation).
> 
> Ya, confirmed via the KUT test:
> 
> diff --git x86/apic.c x86/apic.c
> index 0a52e9a4..b91e8500 100644
> --- x86/apic.c
> +++ x86/apic.c
> @@ -569,6 +569,9 @@ static inline void apic_change_mode(unsigned long new_mode)
>  
>         lvtt = apic_read(APIC_LVTT);
>         apic_write(APIC_LVTT, (lvtt & ~APIC_LVT_TIMER_MASK) | new_mode);
> +
> +       lvtt = apic_read(APIC_LVTT);
> +       report((lvtt & APIC_LVT_TIMER_MASK) == new_mode, "LVTT mode switch");
>  }
>  
>  static void test_apic_change_mode(void)
> 
> And given that AVIC (!x2APIC mode) says that reads are allowed, I don't see how
> hardware could do anything differently.

Indeed, I additionally did:

diff --git a/x86/apic.c b/x86/apic.c
index b45fc9c1..b0902b2d 100644
--- a/x86/apic.c
+++ b/x86/apic.c
@@ -42,11 +42,13 @@ static void __test_tsc_deadline_timer(void)

 static int enable_tsc_deadline_timer(void)
 {
-       uint32_t lvtt;
+       uint32_t lvtt, new_mode;

        if (this_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER)) {
                lvtt = APIC_LVT_TIMER_TSCDEADLINE | TSC_DEADLINE_TIMER_VECTOR;
                apic_write(APIC_LVTT, lvtt);
+               new_mode = apic_read(APIC_LVTT);
+               report((new_mode & APIC_LVT_TIMER_MASK) == (lvtt & APIC_LVT_TIMER_MASK), "LVTT TSC Deadline mode");
                return 1;
        } else {
                return 0;


... and that works fine.


Thanks,
Naveen
