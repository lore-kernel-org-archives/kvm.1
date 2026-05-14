Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C173FA5D6
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768991; cv=none; b=RmgfNoyKMBR5VeKQM79NxeZfiDxC3sqc0oyRQB5RGwRAcovZOv70jnYq6ZvPYioTLYPfg4cT2ijORwIWzx3idNj/jeaNMM5UPDf+dHMX3FFybN5gDi5T7VSUa4mZ7U2iKPtGcnoVLc0Oz0aJ3iRvwjH68fSrw89Zhcq6FQGNiDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768991; c=relaxed/simple;
	bh=a0u6ag6g7n/ymQNLPjjoPC5z8LyjStcR9mb1p+1QORE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUNVVRjpIo+1+C0XWFQfxLH6G/m1Fp1RcbsH54qhHQasSailr3UJbnmgWC0d5wItVJHF6Ztjnk4+edkIr+9spcb9tY2Vv9i26YEU2J4UJLusdQJw3zg5wkxnpKpxY1G9uiN871wvV5tHt2S5/250ErKNHoezoerejmCVAgWaZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQSPenHs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQSPenHs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B15C2BCB3;
	Thu, 14 May 2026 14:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778768990;
	bh=a0u6ag6g7n/ymQNLPjjoPC5z8LyjStcR9mb1p+1QORE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQSPenHsOSFOdtR1Ej+jSQhn6DgGDk4cLo4rj6XnDXd2kJ77OtWnmjIUoYQ+1imP3
	 nna/LiAmEUX9i5vKwBoJF8fIGvy4UwLnLgY7jtVwGrwEltjP1kVnPFWFdGFnbUp/My
	 BGUIGGvAis9PRPRk4fhldb84i+/fdlJ3Kobc9K4XiavYa8gYMrQj9r6evpg59Vt/AU
	 MvpZ09c25MZMFv+yNyRmnbTQSSBYpRTK60JRE+ITnjSch0/uIhpW+nmWt9XwJmEQeL
	 1Um0Pl0rs/z6VgVaYj7e1JJz6TEQa0yAMyy44JtbExw+F4RrE57AAia0a3m/sW7KuV
	 DKMgScD09XHKA==
Date: Thu, 14 May 2026 19:50:48 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Manali Shukla <manali.shukla@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, kvm@vger.kernel.org, x86@kernel.org, santosh.shukla@amd.com, 
	nikunj.dadhania@amd.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH v1 5/9] KVM: x86: Refactor APIC state get/set to accept
 variable-sized buffers
Message-ID: <agXZvLJid616ZIiu@blrnaveerao1>
References: <20260204074452.55453-1-manali.shukla@amd.com>
 <20260204074452.55453-6-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204074452.55453-6-manali.shukla@amd.com>

On Wed, Feb 04, 2026 at 07:44:48AM +0000, Manali Shukla wrote:
> Refactor kvm_apic_get_state() and kvm_apic_set_state() to accept a void
> pointer and explicit size parameter instead of struct kvm_lapic_state.
> This removes the hard-coded assumption about 1KB APIC register space and
> allows functions to work with both 1KB and 4KB APIC register space.
> 
> Existing callers of kvm_apic_get_state() and kvm_apic_set_state() pass
> `s->regs` and `sizeof(*s)` to maintain the current behavior with the 1KB
> kvm_lapic_state structure.  Subsequent patches will add KVM_GET_LAPIC2
> and KVM_SET_LAPIC2 IOCTLs that will also use these functions in order to
> save/restore 4KB APIC register space.
> 
> No functional change intended; existing KVM_GET_LAPIC and KVM_SET_LAPIC
> IOCTLs work exactly as before.
> 
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> ---
>  arch/x86/kvm/lapic.c | 32 ++++++++++++++++----------------
>  arch/x86/kvm/lapic.h |  4 ++--
>  arch/x86/kvm/x86.c   |  4 ++--
>  3 files changed, 20 insertions(+), 20 deletions(-)

How about having these functions instead always work with 
kvm_lapic_state2?

See my response to the next patch.

- Naveen

