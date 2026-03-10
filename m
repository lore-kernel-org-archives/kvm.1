Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2F93CD8B0;
	Tue, 10 Mar 2026 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165664; cv=none; b=ZaWmyg5XDn8AakAhjmstV0/eb0sbtgnz8CHiDFeNRZi4G69LtFvCDStm8pUSXnui+eLqzLwGTgAulT3ii5fzN6EbDkXGS5dgUWdu1IzRH4PAv/h+ooAhEVGPIF1S43AzxHvncu/I2OhaL9gmxeh8sgVhDoDG2+dDc55HA2JeL/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165664; c=relaxed/simple;
	bh=moFeGxjO8gUyiN6MUtJi5otHVovnP02XQX8M/YDH9QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ar64CJh4Gd8EzX8gn5taL3sw0XvN/nNKwtO0F37x8qyR/IPk/xbbt+mPnBZ+rI9Jt6InOo1AEir/5ldfC12i/fwEwFRHV3FpRZjYdadAYnu21IpcHJoXiAjJejHIletLmizrA6QE4IPcaEwAYUixJiBKIGyPpXuslmppI0S/EDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hk7jV6LF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk7jV6LF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFB6C19423;
	Tue, 10 Mar 2026 18:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773165664;
	bh=moFeGxjO8gUyiN6MUtJi5otHVovnP02XQX8M/YDH9QQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hk7jV6LFDI/DdSH6DlLGzygzlBCzjsfBN7Y3scCmHMpwzjIrb85T16m955YYEPUjq
	 MFyFc366bqDgejTouQ6dPdfEdmqUC38y4R1169CFdGLid1zpt3znFzYZawRvt2DJ34
	 ZJyFumuh+bVNF5Lko5XzDcj7MvE+cT9wrTg5PvwpsigVW9mUSITXnfWbJiftQJBbYF
	 NU9PevIAwQ6Z+w3FbkCcdhoDThG8KHj4mCT/jIMiO4RIZZ6HuSfqfmtRQ9peoP4O+e
	 5GjFynLEAG87PR3KP9mw5cVn91KTTRBEaAiu2GUOBrhyvocBeztk3yHcJ/qvyPaQHo
	 2RW7NFzhpSPrQ==
Date: Tue, 10 Mar 2026 23:30:32 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Srikanth Aithal <sraithal@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	"Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
Subject: Re: [PATCH 2/2] KVM: SVM: Set/clear CR8 write interception when AVIC
 is (de)activated
Message-ID: <abBbD1ybIbup-u3p@blrnaveerao1>
References: <20260203190711.458413-1-seanjc@google.com>
 <20260203190711.458413-3-seanjc@google.com>
 <19935696-36cf-411b-af90-aabe6a98d7e7@amd.com>
 <abBSPkKmMiFCfKek@google.com>
 <947bf241-d149-4933-874a-de96aeb73dff@amd.com>
 <abBYiODdL4405KbB@blrnaveerao1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abBYiODdL4405KbB@blrnaveerao1>

On Tue, Mar 10, 2026 at 11:18:16PM +0530, Naveen N Rao wrote:
> On Tue, Mar 10, 2026 at 12:36:09PM -0500, Tom Lendacky wrote:
> > On 3/10/26 12:17, Sean Christopherson wrote:
> > > On Tue, Mar 10, 2026, Srikanth Aithal wrote:
> > >>
> > >> Hello Sean,
> > >>
> > >> From next-20260304 onwards [1], including recent next kernel next-20260309,
> > >> booting an SEV-ES guest on AMD EPYC Turin and AMD EPYC Genoa has been
> > >> failing. However, on EPYC Milan, the SEV-ES guest boots fine.
> > > 
> > > ...
> > > 
> > >> Bisecting shows that this commit is the first bad one. When I revert it, I
> > >> am able to boot the SEV-ES guest successfully on both Turin and Genoa
> > >> platforms:
> > >>
> > >> e992bf67bcbab07a7f59963b2c4ed32ef65c8431 is the first bad commit
> > >> commit e992bf67bcbab07a7f59963b2c4ed32ef65c8431
> > >> Author: Sean Christopherson <seanjc@google.com>
> > >> Date:   Tue Feb 3 11:07:10 2026 -0800
> > > 
> > > Gah, I hate how KVM manages intercepts for SEV-ES+.  Though to a large extent I
> > > blame the architecture for not simply making CR{0,4,8} intercept trap-like.
> > > Side topic, is the host actually allowed to trap CR3 writes?  That seems like a
> > > huge gaping security flaw, especially for SNP+.
> > > 
> > > Anyways, this should fix the immediate problem.
> > > 
> > > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> > > index 33172f0e986b..b6072872b785 100644
> > > --- a/arch/x86/kvm/svm/avic.c
> > > +++ b/arch/x86/kvm/svm/avic.c
> > > @@ -237,7 +237,8 @@ static void avic_deactivate_vmcb(struct vcpu_svm *svm)
> > >         vmcb->control.int_ctl &= ~(AVIC_ENABLE_MASK | X2APIC_MODE_MASK);
> > >         vmcb->control.avic_physical_id &= ~AVIC_PHYSICAL_MAX_INDEX_MASK;
> > >  
> > > -       svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
> > > +       if (!sev_es_guest(svm->vcpu.kvm))
> > > +               svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
> > >  
> > >         /*
> > >          * If running nested and the guest uses its own MSR bitmap, there

I arrived at the same fix and it works for me, so FWIW:
Acked-by: Naveen N Rao (AMD) <naveen@kernel.org>

> > > 
> > > Argh!  The more I look at this code, the more frustrated I get.  
> > > The unconditional
> > > setting of TRAP_CR8_WRITE for SEV-ES+ is flawed.  When AVIC is enabled, KVM doesn't
> > 
> > AVIC is disabled for SEV guests (see __sev_guest_init() and the
> > kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_SEV) call at the end of
> > the function).
> 
> AVIC gets inhibited globally, but continues to be enabled on 
> vcpu_create() opportunistically -- see kvm_create_lapic(). It only gets 
> disabled later during vcpu setup via 
> vcpu_reset()->svm_vcpu_reset()->init_vmcb()->avic_init_vmcb()

... which explains why this issue is showing up.

But reading your response again, I guess you were pointing out that the 
intercepts are not a problem for SEV-ES guests since AVIC is inhibited, 
which totally makes sense.

Thanks,
Naveen

