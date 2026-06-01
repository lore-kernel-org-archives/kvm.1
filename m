Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE29226B971;
	Mon,  1 Jun 2026 23:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780356930; cv=none; b=GicvawwtmZqZPHrAoPerWBGLtNxCf/mvQiWebDMtHjMUEeU0lRBKrJ9xICFNBDv9QoxxzBDNLekLgqBqRU2ienGVm5rV2G3hCnROawL56sC9xmGFxmoVdOk8vEqGl0DO24I6OqeS+G1Fd2MGJ9fwzHFEd9UoaUvYiMeMeUxoTzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780356930; c=relaxed/simple;
	bh=9m7mL6bC3C87LcHYebPdY4BRl+1cSAZCn0620VelXZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUa5ee8stYJ9A1Lc6QfDJMRoi2FTdvphxQwp+Nw2yjuNUTlec8TVTEAS9d4eY9+CjwFy2DAizbJovffwX77YR6du48NvLeEWG6r7sgi7uDsPyG9qOFcGwPIvINCIvTHpEXaGgzGlzMosZStF9aVQ29oRnzuCd7ZYz6wKqgnIn/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKWqntXY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKWqntXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E321F00893;
	Mon,  1 Jun 2026 23:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780356929;
	bh=wwxFAFPP2LO2UbmwgvVzg1QcE9y5aMo1pLVRgJb9DAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dKWqntXY3YjWTmVxUYe4MAXt7bOjJLdgo49wrmuNrsW0GSGm/4fC8rhUYr00fz3zh
	 E8MJo1Yc/qHDx7Ho8bvhAcMG8iMZzI8Bm3+KOiDMdvJHAo4j6hpsgZjl2yjcaVkp55
	 Hxcp8iP2dclgXs13WTxzm/WOvnDg0+gIRIcERFNFesucrR8aI6URvYSavaeu8vzMZW
	 Vhaili4hWJBRNWURBjV8+YHdOrGozwe4ZDgQriPb/op93lHjzsnHGj6P73eFpYYgbS
	 sBI9MyCJirRMxiSlJ6St+95q1bq1APaANu6nVvOlT4lkmcGOF63DlS3rlgnauXjq9D
	 Fw8Eeu6BYtHog==
Date: Mon, 1 Jun 2026 23:35:27 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 15/40] KVM: x86: Move the bulk of register specific
 code from x86.c to regs.c
Message-ID: <ah4XNYVZyLLKjWG6@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-16-seanjc@google.com>
 <ahoyE72rGb1dPrSC@google.com>
 <ah2UCaDJdfTwlMTU@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah2UCaDJdfTwlMTU@google.com>

On Mon, Jun 01, 2026 at 07:15:37AM -0700, Sean Christopherson wrote:
> On Sat, May 30, 2026, Yosry Ahmed wrote:
> > On Fri, May 29, 2026 at 03:21:58PM -0700, Sean Christopherson wrote:
> > > Introduce regs.c, and move the vast majority of register specific code out
> > > of x86.c and into regs.c.  Deliberately leave behind MSR code (except for
> > > EFER, which can hardly be called an MSR), as KVM's MSR support is complex
> > > enough to warrant its own compilation unit, and doesn't have much in common
> > > with the other register code.
> > > 
> > > No functional change intended.
> > > 
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > 
> > This is not just code movement. You're also renaming and introducing new
> > helpers in the process, making the patch not so easy to review.
> > 
> > A wise mine once told me not to do this:
> > https://lore.kernel.org/kvm/aYU87QeMg8_kTM-G@google.com/
> > 
> > I have been waiting a few months for this, so here goes:
> > 
> > Stop. Bundling. Things. Together.
> 
> Gooood.  Use your aggressive feelings, boy.  Let the hate flow through you!

I guess I did turn to the dark side after all.
