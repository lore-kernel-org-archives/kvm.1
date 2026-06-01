Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847D26D4CA;
	Mon,  1 Jun 2026 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780357303; cv=none; b=lIT0Hg6loAd96edNfOA28h7vPkWCR64+cGZMXkDf0IcIAL2JfVBpYM7124UoOwbBV3vgZmDGAgiPEJ8KYR0AZbuSfZ7z9jWuGNgIjqnzH84KFwegf3IczgSom+66lcY0pYpoa7dzgyBfPrXnR4EJSLpLGFwsbqUlTHJXjAPhW+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780357303; c=relaxed/simple;
	bh=dZsBg52gmaAww3KMq8XeVdFmzT9ixbo8AIjkWPZcVDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGE7b0r9nqUWqcWp3EzJVOkKVZM2Qvi9hIi9TxTuqPQiKE5RB5UvjC5Fpy0H2e/NRz5EeGMvz083YmJSqepaPt0X5sHBiAzhTIx7ChXY22V3NQP9r8HkPIzva/cTI26US7SH/bvRG2t9iO7l5vxMDNtc2ZzmOW6euXBAgikUvlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTbVNPb3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTbVNPb3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A5E1F00893;
	Mon,  1 Jun 2026 23:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780357302;
	bh=iVn1+nawVzCroljUkjtsGMvxG3CUeS68gzw1OtM0RxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VTbVNPb3gDjaC/VKuUfyrGfDf2fKRowU632TYSNH0L8Mml/MtwAvIH9q4sEsIigM/
	 wteN4PRj41DSlkHKFmoUvVBsXd5HNKbg1XqQamA6Cak8Snpm8SMrOEnsi151Z+Dwoc
	 nnrhPs0EYoQU604EXs2mYCrUSeOIBKyDo/xOmDdg3cOZaSXAB2GMiZilNk32h7G1Nb
	 C7PKGmyHq+6TjZiHikrJB/D65fPYjMGffSYlcofPhWTcZ8xRDXEH8ouHj14tfbrq0/
	 mqD7KnUFGkDBdfBhCwZK1M79a2+SdtPOHrHpG+NiT+Lu+z0VFa1hAMtJY0fXEDA4pJ
	 beouXbeOsE6dw==
Date: Mon, 1 Jun 2026 23:41:40 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 32/40] KVM: x86: Move LLDT assembly wrappers into VMX
Message-ID: <ah4YETFB3Yq7j4nY@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-33-seanjc@google.com>
 <aho2qWoPvqJV_5Db@google.com>
 <ah2ioxvvx1-Jgjup@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah2ioxvvx1-Jgjup@google.com>

On Mon, Jun 01, 2026 at 08:17:55AM -0700, Sean Christopherson wrote:
> On Sat, May 30, 2026, Yosry Ahmed wrote:
> > On Fri, May 29, 2026 at 03:22:15PM -0700, Sean Christopherson wrote:
> > > Move kvm_{load,read}_ldt() into vmx.c, as they are exclusively used by VMX
> > > to save/restore host state, and have no business being globally visible.
> > 
> > But they are generic helpers. I agree with mvoing them out of
> > kvm_host.h, but maybe into another header? 
> 
> No, absolutely not.  The fact that KVM has to manually save, and conditionally
> restore, LDT is a quirk of the VMX architecture.  If it weren't for the fact that
> VMX's segment_base() also needs to query the LDT, I would just open code the asm().
> 
> If it's a naming concern, I'll happily rename them to vmx_{load,store}_ldt().

I was actually going to suggest those exact names initially, so yeah
this looks better.

> 
> Hmm, arch/x86/include/asm/desc.h provides {load,store}_ldt(), but load_ldt()
> is only available for CONFIG_PARAVIRT_XXL=n builds, and both #define unnecessarily
> constrain the output to memory.  Those are both fixable, e.g. load_ldt() isn't
> used _anywhere_ AFAICT, so burying it under CONFIG_PARAVIRT_XXL=n is just some
> weird historical quirk, and I can't show_fault_oops() would care store_ldt() were
> allowed to store to a register.
> 
> So after the dust settles, it probably makes sense to improve desc.h's versions
> and then use those in KVM.  But I don't want to do that in this series, because
> it will be challenging enough to land all of this code movement without also
> having to coordinate with the tip tree.

Even better, makes sense for a separate cleanup. Thanks.
