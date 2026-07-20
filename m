Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAB842A14D;
	Mon, 20 Jul 2026 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557462; cv=none; b=GM3Bav+gi3FXzNFqr4sB6p9xHc9IDaPW0fxLa5sBabZT4qACdbe4aaypS6lQbeOsgV+zj9XL2xUxLqFJ5LpnVNTaJvBpnNlrx1oZCiuRi5AIsjwhRLH3j0x5ycqCZtYI+HtGRh7Xdf/YMHnB30ByMqzov9/Z8ZjTJfWFkE0auo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557462; c=relaxed/simple;
	bh=qPtLQuvI61f+z64VhBdohmbC0tffn62+SOapkmMOlvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vb4XtPEfRourdf24TgVUdulk+pzNGCjFXeSbutEC+jAMBW2cpL4BUuD9SCGtfRtekb5DJG/zt8vkljg316NZk9xQYHP0oLXNMHxheZUt0XPGrZsjjmEDI1WfPJqk1UBEZJuwrlA5U9SDqogbZJ7DylA1E18WSGXLgq4c+MEYLiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDZXe5nm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDZXe5nm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BB41F000E9;
	Mon, 20 Jul 2026 14:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784557459;
	bh=sNgZKDfLkxdCEoyuZ32JG/iZfFSZC4LOzIXGHcL9tJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SDZXe5nmoA0UIpHMbuORT76j+s20SLfp8umFAMnADrLWUVzKWpHL2iz7yNsNSBTwX
	 /xLSmTj4wh3IZj4LCFz3eTWjIaxpP2eK6+Tk8RjzpriplQbTsPJRURtkw+oxKo+AKu
	 EogSHfC//gmf3hrD4K7prHcC5847K+Hd8oDp4kVEDoxY/2wSwqYYLNwiTReZsflh0S
	 fKCGHeg4vGdiduijATyfOdCedjzuCZMXrW0POsqxpoQT4ykCE2hh2euJbSP7dgcoT8
	 hnyt97Qi3tz/a7KGrD/TlH7pA6CZJLd6qJPXd2GLElflqtudS26sqLtmFc0gFmSWL6
	 leAL/+S5omQ8A==
Date: Mon, 20 Jul 2026 19:48:00 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Dmytro Maluka <dmaluka@chromium.org>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: VMX: Postpone IPIv setup after successful vCPU
 creation
Message-ID: <al4rNqpBYy8FGKPw@blrnaveerao1>
References: <20260716160801.3155582-1-dmaluka@chromium.org>
 <20260716162900.9D8131F000E9@smtp.kernel.org>
 <alkTuicE2ELcakS9@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alkTuicE2ELcakS9@google.com>

On Thu, Jul 16, 2026 at 07:24:10PM +0200, Dmytro Maluka wrote:
> On Thu, Jul 16, 2026 at 04:29:00PM +0000, sashiko-bot@kernel.org wrote:
> > [Severity: Critical]
> > This isn't a bug introduced by this patch, but does this exact same
> > vulnerability exist in the AMD SVM AVIC code?
> > 
> > It looks like the SVM code suffers from the same use-after-free pattern
> > when userspace creates a duplicate vCPU ID.
> 
> Seems plausible. Can someone with AMD expertise look into this?
> 
> > In arch/x86/kvm/svm/avic.c:avic_init_backing_page(), the newly allocated
> > APIC backing page address is written into the VM-wide hardware IPI table
> > before the vCPU ID duplicate check:
> > 
> >     WRITE_ONCE(kvm_svm->avic_physical_id_table[id], new_entry);

Yes, this write (or just setting AVIC_PHYSICAL_ID_ENTRY_VALID_MASK) will 
need to be delayed to a post-create phase similar to VMX.

The alternative is to simply skip setting the entry valid during vCPU 
creation and to instead do it unconditionally during vcpu_load(), where 
we anyway have to update the entry.

> > 
> > If the vCPU ID check later fails in kvm_vm_ioctl_create_vcpu(), the
> > new vCPU is destroyed and kvm_free_lapic() frees the backing page:
> > 
> >     free_page((unsigned long)apic->regs);
> > 
> > However, the AVIC table is never updated to revert the overwrite.
> > This leaves the physical address of the freed page in the hardware table,
> > which could cause a hardware use-after-free if a guest subsequently sends
> > an IPI to that ID.
> > 
> > Could we also implement vcpu_postcreate for SVM to postpone the AVIC
> > table update, or do we need a separate fix for AMD?

Thanks,
Naveen

