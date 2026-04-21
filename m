Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBFA3A1D1B;
	Tue, 21 Apr 2026 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813953; cv=none; b=tO6hTNpDpzhDxA/p/2/IA/haYxjeNmsLJ1aL3eYj8NdGErtpJ3Kv55w9kv7jwqzeR0s6p2xeI8ZP4Z3+QQsPzG1KW1W6YmaMVkDMDIRU6gTvzXPLFICj6bElTJ4RKd8Gk1ACvYh680b7EHaflzNgE45rykxe7QwdvKRJRLRKmu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813953; c=relaxed/simple;
	bh=elyV3lZqAtgWQ4j9hhssoiVA6LYW5W2kDn6tN9c0c6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sdwlunn51NJUleYZOUoyY8i2Q1Zg4L2JWtba2u+0PtqWfHRWpzbeE7DxsWylhviNXH9v6fd1eR99nUIKirXFHTf55XZzFAPcmH7b8PWxlL7g9FP4AaWrGLW0nsl2C0wBQHkbTsNlDqi/6UmMKT1lVkEML/J0tvq8AEBTu2M3fyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izyOuPOR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izyOuPOR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45BEC2BCB0;
	Tue, 21 Apr 2026 23:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776813952;
	bh=elyV3lZqAtgWQ4j9hhssoiVA6LYW5W2kDn6tN9c0c6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=izyOuPORTuxjKW5U2mdSF+VAOnjQQgG69VP+OVa5FCQ53AEaa/fE3VfMzK1CHYfmt
	 /F5YMUPGIxO1UaoG0ax3A3jDZaAAX9ASTu030KHSqpGriuZLxJf7bm1qBzKq3G+hvb
	 4N7f70lQFNJPX9CsdlFFl0+iMOcRFnXglJhSu+c9Jgp1VKqATuKJzvKpJYd5k1VqcL
	 ngHDPCLoiz/Iu7XbuMXfqfnR0RsW5UsvsQpKUbB1LKMVaVVgf1t54f+kYKo6xDEdTh
	 KV9eI2uzuAbPTpIQe0VGETkyHxbFYWnjvbw35KQxZykWCOKZKnk0ZkKQNkLQ3j4WHK
	 w6CkKROwLQx+g==
Date: Tue, 21 Apr 2026 23:25:50 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Fang <peter.fang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] KVM: Take gpa_t in kvm_vcpu_map[_readonly]()
Message-ID: <aegHZrDn3GouTpZf@google.com>
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-4-peter.fang@intel.com>
 <aegDJssx-ZvbfggI@google.com>
 <aegF59gToidudIUC@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aegF59gToidudIUC@google.com>

On Tue, Apr 21, 2026 at 04:19:03PM -0700, Sean Christopherson wrote:
> On Tue, Apr 21, 2026, Yosry Ahmed wrote:
> > On Tue, Apr 07, 2026 at 05:11:30PM -0700, Peter Fang wrote:
> > > Move the conversion from a gpa_t to a gfn_t into kvm_vcpu_map() and
> > > kvm_vcpu_map_readonly() so that they take a gpa_t directly, reducing
> > > boilerplate at call sites.
> > > 
> > > __kvm_vcpu_map() still takes a gfn_t because guest page mapping is
> > > fundamentally GFN-based.
> > > 
> > > No functional change intended.
> > > 
> > > Compile-tested on x86 and ppc, which are the current users of these
> > > interfaces.
> > > 
> > > Suggested-by: Yosry Ahmed <yosry@kernel.org>
> > > Signed-off-by: Peter Fang <peter.fang@intel.com>
> > > ---
> > 
> > I was going to suggest a WARN in kvm_vcpu_map() and
> > kvm_vcpu_map_readonly() if the passed GPA is not page-aligned, but Sean
> > usually hates my paranoid WARN suggestions.
> 
> Heh, for good reason.  Adding such a WARN would be triggered by this code:
> 
>                 if (!kvm_vcpu_map(vcpu, vmcs12->posted_intr_desc_addr, map)) {
>                         vmx->nested.pi_desc =
>                                 (struct pi_desc *)(((void *)map->hva) +
>                                 offset_in_page(vmcs12->posted_intr_desc_addr));
> 
> The PI descriptor only needs to be 64-bit aligned, not page-aligned.

I didn't know that, thanks for pointing out. You meant 64-byte aligned
though, right?
