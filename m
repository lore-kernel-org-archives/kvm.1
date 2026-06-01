Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AEA31A045;
	Mon,  1 Jun 2026 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780356997; cv=none; b=rI0A6MH6l+Isv/maoczVtK8OUj6HUWAGW0mkpYe/XyYsK2gPE1v5gPvXAkI9RdjZFmYsnWTkdiLEKLH0mvPSMqvdSrczv2o+52CFV1P6iTiHT7k6n2aMu5xOa/2ueAGAi+A5AySZIPGEkUVorrGH8iH8O7yXTxSPxacnMmWX7vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780356997; c=relaxed/simple;
	bh=b2I/InEIW0QYvi1VqBtYk23WVyMIxdU2Po+9eLasH20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKIXLRJl2NfQa1Tv5fY75TPJK36LI4XDyRTjsSco/uDWgnnfJg8pC7sMr5BDQ7UnQqf9sKobvRDEcdtWuymCMBtoFHd/1ZofVV0J2E+nco+u6253BXi9Wmz1GVPA2XpHyTQMLh1Z8jkSzK347YyIhj2/F7m4D2ShYNe9CK9ArbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSdUuqXn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSdUuqXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4751F00893;
	Mon,  1 Jun 2026 23:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780356996;
	bh=//Egs3oy2BfWvfSyDEeiGvExnYTsNPb+vqOlPWXQ8/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OSdUuqXnNU2OXljYp4ywWEmhcg90YdLk2irHk9lJgf4lRSYjP/L+P7jlFiu5T/dA7
	 /QV01jwJXestmaymUTd4VMKCIfqxxtSFUVDysvCXRQHFmUr0MrtbtW2exczigyh19h
	 1jF+lEoNjosLE8oMhFa4zi7DxRLYVcM4yXT1k/m6laVpR+Ce0PfaqAf8oezSyI2Jh1
	 TNexAB1gPSmcd6dwIuBtAn3wC47NKWmkSLK9r88LOnvrJkK1NSDAEQ5vQBE5ASIr90
	 TfHNcqm0NwkSd7f3fpE6GHSDCAWU908DgUGsTzbU64YHNgX+dVMRwzPAlO2ocNOsbt
	 wcvP6MeO0EH7w==
Date: Mon, 1 Jun 2026 23:36:34 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 27/40] KVM: x86: Move register helper declarations
 from kvm_host.h => regs.h
Message-ID: <ah4XR_fmJA0ct7nu@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-28-seanjc@google.com>
 <aho1wgNn8pSgaBUU@google.com>
 <ah2WHuMMKDfpADHF@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah2WHuMMKDfpADHF@google.com>

On Mon, Jun 01, 2026 at 07:24:30AM -0700, Sean Christopherson wrote:
> On Sat, May 30, 2026, Yosry Ahmed wrote:
> > On Fri, May 29, 2026 at 03:22:10PM -0700, Sean Christopherson wrote:
> > > Relocate declarations of Control/Debug Register, EFLAGS and RIP helpers
> > > from x86's kvm_host.h to regs.h, to continue trimming down kvm_host.h.
> > > 
> > > No functional change intended.
> > > 
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/x86/include/asm/kvm_host.h | 17 -----------------
> > >  arch/x86/kvm/regs.h             | 17 +++++++++++++++++
> > >  2 files changed, 17 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > > index 19091d89d3cc..0f4b16b26a27 100644
> > > --- a/arch/x86/include/asm/kvm_host.h
> > > +++ b/arch/x86/include/asm/kvm_host.h
> > > @@ -2186,8 +2186,6 @@ void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen);
> > >  void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned long kvm_nr_mmu_pages);
> > >  void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
> > >  
> > > -int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
> > 
> > Why are pdptrs helpers bundled with register helpers?
> 
> Page Directory Pointer Table Registers
>                              ^^^^^^^^^

LOL I assumed PDPTR is just Page Directory Pointer (i.e. PTR is
pointer). Never mind then.

> 
> Or as the SDM initially describes them, "5.4.1 PDPTE Registers".  When using
> PAE paging (not 64-bit paging), they really are CPU registers, and their lifecycle
> is tied to CR{0,3,4}.  I.e. I was thinking of them as an extension of Control
> Registers.  I can explicitly call that out in the changelog?

I don't think that's needed, it was just me being uneducated.
