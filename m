Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CB21FCFEF;
	Thu,  4 Jun 2026 00:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780533639; cv=none; b=NoBRdv9yRNsABWn5hadogXgRc4Op1dCj8XPR9PreBonFMF/kcw1AkWqc99CDDCLhMiFn2a6L1F7VGeAPFq42dNEv5UWMJY4TdU75liobCzIZtauwnBsUyq8mJpD9RHZ8dkaX3aMPtbJH5L0EiOpfdBs4G2iriYsEUsmMiaNB4Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780533639; c=relaxed/simple;
	bh=NOFw+JBHm6Fvi2ee9FC27OJg7V0BnGKlIdOOuvsPE+Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WeG33+d2GE/T3kgFSYoeaO3vR2ZLd7uf1m4ONa9Y+1868y7N2vabkU7pzRZUmKjNSdgDXjmwWM7q21z0nyrc3RLdZudMFs5VtZo2TT81spwqw4YSITURknGI9HNw8CbP9DCQ0Okaom90veztQJPpTF7TY957liNPeczG+0ZQMhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 96E749200BB; Thu,  4 Jun 2026 02:40:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 8FE0E9200B3;
	Thu,  4 Jun 2026 01:40:29 +0100 (BST)
Date: Thu, 4 Jun 2026 01:40:29 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Sean Christopherson <seanjc@google.com>
cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Subject: Re: [PATCH v2 2/6] KVM: x86: Prioritize DR7.GD #DB over #GP due to
 illegal DR6/7 value
In-Reply-To: <20260603230718.1733483-3-seanjc@google.com>
Message-ID: <alpine.DEB.2.21.2606040048520.22659@angie.orcam.me.uk>
References: <20260603230718.1733483-1-seanjc@google.com> <20260603230718.1733483-3-seanjc@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 3 Jun 2026, Sean Christopherson wrote:

> When emulating a MOV DR, specifically a write to DR6 or DR7, treat a #DB
> due to DR7.GD (General Detect) as higher priority than a #GP due to an
> illegal value.  While neither Intel's SDM nor AMD's APM says anything
> about the relative priority, empirical testing on Intel and AMD shows that
> the #DB has higher priority.  

 It has to.  The primary reason for the existence of DR7.GD is to prevent 
software being debugged such as an OS kernel from clobbering the debug 
register state when executed under the control of an ICE or a JTAG (XDP) 
debug probe.  Under these circumstances #GP remains an ordinary exception 
routed via the IDT to a handler provided by the OS, however #DB traps into 
the ICE or SMM mode instead and the OS handler is never reached.

 This is also the reason why DR7.GD gets cleared at the same time -- so
that the debug firmware can then access the debug state rather than making 
the exception trigger again -- and for the existence of the ICEBP aka INT1 
instruction -- so that #DB can be triggered and control regained by the 
debug firmware via a software breakpoint, since the number of hardware 
breakpoints is limited (and #BP is an ordinary exception).

 It's unsurprising that the priority of these exceptions is not documented 
well in the processor developer's manuals given that x86 hardware debug 
features remain vaguely documented overall in public resources.  Though I 
note the Intel wording for the GD bit is "[it] causes a debug exception to 
be generated prior to any MOV instruction that accesses a debug register." 
so I think it actually implies no action resulting from the execution of 
the affected instruction happens, including in particular any exception it 
might otherwise trigger.

 FWIW,

  Maciej
