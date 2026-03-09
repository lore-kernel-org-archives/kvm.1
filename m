Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A9D256C84;
	Mon,  9 Mar 2026 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773095383; cv=none; b=k+DG6ltRVFXoNWZxhRbuUVHcHKJxvGzN1NW6ZhdML2732hTxqUVSGnFeoy1/9rpXiwaQfOZPF9wXfAPYCn6n5DRw5X+SIbYe3T+mBAOuZ+Nv8yAYOL4dNckywabpqHM1xpQpOBkN/1hfWb7r2f5AnvbwBFGPXJpM30co7RNy6G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773095383; c=relaxed/simple;
	bh=V2wdr7cTcTPUcgee1WyP7BSbVoqbGWoQdWvtSHidEeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPEE5fkcgKn+wQLerdARZZ3P4gI6vALJr8Tt/daiaA/qPST6vu6zd9wV89bQoFdioNW6/N/xbfxwaudO0z3uUs5KBHe1KytdWdfTPdusvFA9ve0GW3a+Ki8aTDncNAkyJPR1xuuYFz0CGkHjwmowLsSCfPPi+iXVELc6kQgmv6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBJ1c+Zx; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBJ1c+Zx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773095383; x=1804631383;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=V2wdr7cTcTPUcgee1WyP7BSbVoqbGWoQdWvtSHidEeo=;
  b=CBJ1c+ZxenpviBC5OX5PkXE4cMQgzVoEJ45RmhYuEs9X2742hnQoP7LP
   4iLMwNiln97PVs+q5LDml7a/re7Cul4JLv2ruSeIjeLWGNzdUKXy4a0u4
   A1ftCoRVsvxhxpypWMmV8ULHjkMMYdyzX0oZFkXowUfHmEe/L1/Kpiu9T
   s/hIQO2t7Mw6TB/8mKjB8R73861jul2xuj6jy0uf2/f1yD/1eHdtjT9rf
   vINuHAlf3B7rpBdDzLXMlLUHeqQuqK7nlsWC22AZtfjS/EdBx3RaMFx9D
   owZLXn+wmU1hZoCIzhIocvY2GwzKls50+CQles00aLtyZOMxCQIRRJItm
   w==;
X-CSE-ConnectionGUID: rO/9auUiQXOGx7rZu8ZTmg==
X-CSE-MsgGUID: 93qtJG9aQsOE1+7fLYZzAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="85606300"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="85606300"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 15:29:42 -0700
X-CSE-ConnectionGUID: i6y54SdsQUupYrNhHv6IsQ==
X-CSE-MsgGUID: c/094YonSR2B5Mg31Kx4mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="219844844"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 15:29:41 -0700
Date: Mon, 9 Mar 2026 15:29:35 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jim Mattson <jmattson@google.com>
Cc: x86@kernel.org, David Kaplan <david.kaplan@amd.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, David Dunn <daviddunn@google.com>,
	chao.gao@intel.com
Subject: Re: [PATCH v4 04/11] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260309222935.2wu6xhydsgikkjpn@desk>
References: <20251119-vmscape-bhb-v4-4-1adad4e69ddc@linux.intel.com>
 <CALMp9eQNBZsJNdfCVwbJ4v1DgCNqRV3DVcEeCPFt=dd29+qy-A@mail.gmail.com>
 <20260306223225.l2beapz3nvmqefou@desk>
 <CALMp9eQoE13d1cqD3PNJtvdKUGZeVm1g-9TWh+M+MJj_sm9CzA@mail.gmail.com>
 <20260306232920.dja5n7cngrsyj6tk@desk>
 <CALMp9eSoNaifKyppbjJjNx1YEw9KFv0LGAJ6xD-ko0zJnNXEbw@mail.gmail.com>
 <20260307010051.u4ugg3nyvsu6hwbg@desk>
 <CALMp9eQGZcekQ3QtL=J7TqHJ9YfZ+SbrgY5P8fp14p4KNThYmw@mail.gmail.com>
 <20260307024132.wleqtpovzd6wtvm7@desk>
 <CALMp9eTO0irFX9sZaVU84r1aW5E7Q2B3bE8uWfgViSug6Hx+og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMp9eTO0irFX9sZaVU84r1aW5E7Q2B3bE8uWfgViSug6Hx+og@mail.gmail.com>

On Fri, Mar 06, 2026 at 09:05:01PM -0800, Jim Mattson wrote:
> On Fri, Mar 6, 2026 at 6:41 PM Pawan Gupta
> <pawan.kumar.gupta@linux.intel.com> wrote:
> >
> > On Fri, Mar 06, 2026 at 05:10:23PM -0800, Jim Mattson wrote:
> > > On Fri, Mar 6, 2026 at 5:01 PM Pawan Gupta
> > > <pawan.kumar.gupta@linux.intel.com> wrote:
> > > >
> > > > +Chao
> > > >
> > > > On Fri, Mar 06, 2026 at 04:35:49PM -0800, Jim Mattson wrote:
> > > > > > > > > I think we need an explicit CPUID bit that a hypervisor can set to
> > > > > > > > > indicate that the underlying hardware might be SPR or later.
> > > > > > > >
> > > > > > > > Something similar was attempted via virtual-MSRs in the below series:
> > > > > > > >
> > > > > > > > [RFC PATCH v3 09/10] KVM: VMX: Advertise MITI_CTRL_BHB_CLEAR_SEQ_S_SUPPORT
> > > > > > > > https://lore.kernel.org/lkml/20240410143446.797262-10-chao.gao@intel.com/
> > > > > > > >
> > > > > > > > Do you think a rework of this approach would help?
> > > > > > >
> > > > > > > No, I think that whole idea is ill-conceived.  As I said above, the
> > > > > > > hypervisor should just set IA32_SPEC_CTRL.BHI_DIS_S on the guest's
> > > > > > > behalf when BHI_CTRL is not advertised to the guest. I don't see any
> > > > > > > value in predicating this mitigation on guest usage of the short BHB
> > > > > > > clearing sequence. Just do it.
> > > > > >
> > > > > > There are cases where this would be detrimental:
> > > > > >
> > > > > > 1. A guest disabling the mitigation in favor of performance.
> > > > > > 2. A guest deploying the long SW sequence would suffer from two mitigations
> > > > > >    for the same vulnerability.
> > > > >
> > > > > The guest is already getting a performance boost from the newer
> > > > > microarchitecture, so I think this argument is moot.
> > > >
> > > > For a Linux guest this is mostly true. IIRC, there is atleast one major
> > > > non-Linux OS that suffers heavily from BHI_DIS_S.
> > >
> > > Presumably, this guest OS wants to deploy the long sequence (if it may
> > > run on SPR and later) and doesn't want BHI_DIS_S foisted on it. I
> > > don't recall that negotiation being possible with
> > > MSR_VIRTUAL_MITIGATION_CTRL.
> >
> > Patch 4/10 of that series is about BHI_DIS_S negotiation. A guest had to
> > set MITI_CTRL_BHB_CLEAR_SEQ_S_USED to indicate that it isn't aware of the
> > BHI_DIS_S control and is using the short sequence (ya, there is nothing
> > about the long sequence). When KVM sees this bit set, it deploys BHI_DIS_S
> > for that guest.
> >
> > x86/bugs: Use Virtual MSRs to request BHI_DIS_S
> > https://lore.kernel.org/lkml/20240410143446.797262-5-chao.gao@intel.com/
> 
> Ah. I see now. I missed this part of the specification: "Guest OSes
> that are using long or TSX sequences can optionally clear
> BHB_CLEAR_SEQ_S_USED bit in order to communicate this to the VMM."
> 
> Maybe this would be less confusing if BHB_CLEAR_SEQ_S_USED were named
> more clearly. Perhaps something like "SET_BHI_DIS_S_FOR_ME"?

Ya, that would have been clearer.

> Is it reasonable to assume that without the presence of BHI_CTRL, the
> non-Linux OS we've been discussing will (ironically) only use the long
> sequence if the hypervisor advertises BHB_CLEAR_SEQ_S_SUPPORT? That
> is, without BHB_CLEAR_SEQ_S_SUPPORT, does it assume the short sequence
> is adequate?

I don't know. But, it doesn't seem logical to assume short sequence is
adequate when the guest can't ensure that VMM would do BHI_DIS_S for it. It
should be the other way around.
