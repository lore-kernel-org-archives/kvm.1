Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939013E40F1;
	Thu,  8 Oct 2026 21:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791496384; cv=none; b=PzHCBYYRDeqFPP3lXB8fnNIfiDiWbROmPQ+TWkGc1N68SWt7O7fmtm84dLV0udxgP1Rx5ag0sIz92KQMGAl85FU/cyrsawT5t2rENpz1zB+qHGym5lKJocXf3LGF8k4ra8cC/ccaw42Wp/8hXwSEoD1byeo8DD8CQGCH/b90z28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791496384; c=relaxed/simple;
	bh=HdJXHUJSl05H9HRxACob+wmjuUW2BDvqp1g6GveXDVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcstPqHYyYREM7hUc+oaTc2jz52ny1EVvaTpID9T0RLxQt4rhrG9UNtsjZVaEhP3SAh9EvBQfP95eBIkLDc7mXx/5J30Xj0LVb1ZjTwsjpG7gacOVjHFgVgiMS+1dG1kJ5Rul5OYeI87IUAqylNo1A8o1iN4YKynOVKJRMEqKQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIPoumQO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIPoumQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C461F000FF;
	Thu,  8 Oct 2026 21:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791496383;
	bh=rRJnvrW2elwr9RydW0bg7UXg8K/jRsUa5Ss8laICJHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fIPoumQOjmgu0SRC8ItrWbvia+RKqEmqfT7993ZtLxf9Ym/sm+aCyjBwlThqbQ+j9
	 jCyv0tUefahYSFj3oKHBu7Xri9Xk3f5XYdc50cvqJ7Q12AuMsZfd+70zoqOI+ZnQ8m
	 QsoEouUMLTPCmsDI/nL+i8but75YjDO+sr3vkKzpMlrlcAz9LsHhLqJ9ZO4QPyuXn0
	 oxVTclhv17teOHl6bc4shHpkVBGAm3mVBT+7F/CDVVaKct6CeMJOk0Ysr5HKlND1tD
	 xiMoUGysfCckRriTbytHYQFx6N2JM8pdMfFRZgvuD7S1tXJhpNRVbAPCSUHemcfJih
	 t3Y36odroGUxA==
Date: Thu, 8 Oct 2026 21:53:01 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v2 03/29] KVM: VMX: Generalize VPID allocation to be
 vendor-neutral
Message-ID: <asgQfP5VPSZJEDyB@google.com>
References: <20261008001425.2458927-1-yosry@kernel.org>
 <20261008001425.2458927-4-yosry@kernel.org>
 <sashiko-outbox-163472@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-163472@kernel.org>

On Thu, Oct 08, 2026 at 12:30:27AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] kvm: x86: memory leak of tlb_tags.bitmap on TDX setup failure
> --
> 
> commit e4dabbc78aa00d0293ef8965888f054d5ea676ef
> Author: Yosry Ahmed <yosry@kernel.org>
> 
> KVM: VMX: Generalize VPID allocation to be vendor-neutral
> 
> This commit generalizes the VMX VPID allocation code to a common TLB
> tags allocator and allocates the bitmap dynamically. It also bounds the
> number of allowed tags to VMX's hardware cap and introduces wrapper
> functions for initialization and destruction.
> 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index aadd5bdc2c97a..97d49247d9d82 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> [ ... ]
> > @@ -8178,6 +8178,84 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
> >  		vhost_task_stop(kvm->arch.nx_huge_page_recovery_thread);
> >  }
> >  
> > +static struct {
> > +	spinlock_t	lock;
> > +	unsigned long	*bitmap;
> > +	unsigned int	nr;
> > +} tlb_tags;
> > +
> > +int kvm_init_tlb_tags(unsigned int nr)
> > +{
> > +	/*
> > +	 * Limit the number of TLB tags to VMX's hardcoded maximum of 0x10000
> > +	 * to avoid wasting memory for the bitmap in the unlikely scenario the
> > +	 * CPU supports an inordinate number of ASIDs (on AMD).  If userspace
> > +	 * wants to concurrently run tens of thousands of vCPUs, they'll likely
> > +	 * need a solution that works for both Intel and AMD.
> > +	 */
> > +	const unsigned int MAX_NR_TLB_TAGS = VMX_NR_VPIDS;
> > +
> > +	if (!nr)
> > +		return 0;
> > +
> > +	if (nr > MAX_NR_TLB_TAGS) {
> > +		pr_warn_once("Number of TLB tags capped (%u instead of %u)\n",
> > +			     MAX_NR_TLB_TAGS, nr);
> > +		nr = MAX_NR_TLB_TAGS;
> > +	}
> > +
> > +	tlb_tags.bitmap = bitmap_zalloc(nr, GFP_KERNEL);
> > +	if (!tlb_tags.bitmap)
> > +		return -ENOMEM;
> 
> [Severity: Medium]
> Does this code leak the tlb_tags.bitmap on TDX setup failure?
> 
> The patch converts the static VPID bitmap to a dynamically allocated
> tlb_tags.bitmap in kvm_init_tlb_tags(), which is called by
> vmx_hardware_setup().
> 
> In arch/x86/kvm/vmx/main.c:vt_hardware_setup(), it sequentially calls
> vmx_hardware_setup() and then tdx_hardware_setup():
> 
> arch/x86/kvm/vmx/main.c:vt_hardware_setup() {
> 	ret = vmx_hardware_setup();
> 	if (ret)
> 		return ret;
> 
> 	return enable_tdx ? tdx_hardware_setup() : 0;
> }
> 
> If tdx_hardware_setup() returns an error, vt_hardware_setup() returns the
> error directly without invoking vmx_hardware_unsetup() to undo
> vmx_hardware_setup()'s allocations.
> 
> KVM's generic module initialization explicitly skips calling
> ops->hardware_unsetup() if ops->hardware_setup() fails.
> 
> Does this permanently leak the newly dynamically allocated tlb_tags.bitmap?

Yes, but I think this is a pre-existing issue. I can find at least one
other allocation that would get leaked due to lack of cleanup if
vmx_hardware_setup() succeeds and tdx_hardware_setup() fails:
vmx_bitmap[] allocated by nested_vmx_hardware_setup().

So unless someone feels strongly, I'd rather avoid growing this series
by fixing this as well.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261008001425.2458927-1-yosry@kernel.org?part=3
