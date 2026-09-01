Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB5D2E62B7
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 06:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788243024; cv=none; b=qR3WiBTvxYnJtu9W0VbxokE9y+VPkBcGG4vX3dH2RM3BdDawhywNrzkaKZ5kV2tk5K9ws5s8wN8BFraHixW1I0cMKjkrO9HPZlZ8VxoZFmrq8V8Zf5h8f1ytD+20O95BJKPRQKqSQmIJrCB0gmGxtKqncq1Vxu8DGdnmahpiu6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788243024; c=relaxed/simple;
	bh=yOvKlDo+S/6i6LoKQQ4Za7PEM2VGUO3xsamj1AZ6pxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAQTYko441UfbkA/T0gY8F/1wmBbK/wbDtN3dQhOqKO+jFviQwUS+2b8EowC8rj/CxaPAkXgkQtxMxd703P27wr9xLUggQowItHIKuJNRuFOuDv9wYfcdiRBKKn6zVV2HxVcFlQghU+7frMX3LDa0NEiiJzdgs5MridYcqu4eM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XI9jPTwl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XI9jPTwl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788243023; x=1819779023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yOvKlDo+S/6i6LoKQQ4Za7PEM2VGUO3xsamj1AZ6pxQ=;
  b=XI9jPTwlAMMhfTUpMz+cLAVJQnFE4eyd53ieFKpY08b7yhzUW29IJYTD
   zUB1d2vH1QaOAjDkh76jE6tNc6yRb5uu2cuyOM/tlnzNz9gpi4LYPiTJ+
   xyU5Fm72d8VJAY/QOQYQUY+9OS4yYqvGjcoPP+MrbWU17Hx9NxgNLn815
   FKKMQS281nE0ovDHOeqz5xpKtknDrYtMShNDI2Y9lc0qCIwQAj+cQSX1F
   VFBA4KKot+mad/vyULjAnt+tWVnyYyYPpjAoNEmPwQMuPXXoIFTulYWCI
   E0VGk/vSRi7sY/LT/YyR4GIJYMfihlPos7phllqXgj25UZgIf1e6ubTDE
   A==;
X-CSE-ConnectionGUID: OgtrZGDMQkufyRkaEmZgWw==
X-CSE-MsgGUID: kGoFxRGWTi6Sq/p5I9w48w==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88586887"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="88586887"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:10:20 -0700
X-CSE-ConnectionGUID: HzvmyDXmQP2PgVQikVXoJw==
X-CSE-MsgGUID: Rg6f09M/QjaO8V7a53B3eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="298890893"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.192])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:10:18 -0700
Date: Tue, 1 Sep 2026 09:10:15 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] KVM: x86: Add optional KVM_EXPORT_MEMORY and
 KVM_IMPORT_MEMORY
Message-ID: <apZsR8xb-NFQQMFs@tlindgre-MOBL1>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-4-tony.lindgren@linux.intel.com>
 <20260831072347.8FD2E1F00ADF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831072347.8FD2E1F00ADF@smtp.kernel.org>

On Mon, Aug 31, 2026 at 07:23:47AM +0000, sashiko-bot@kernel.org wrote:
> commit b6f49e80a58eebaaa2a6d123950fd36709972a10
> Author: Tony Lindgren <tony.lindgren@linux.intel.com>
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> [ ... ]
> > @@ -7258,6 +7258,37 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
> >  	return -ENOIOCTLCMD;
> >  }
> >  
> > +static int kvm_vm_ioctl_transfer_memory(struct kvm *kvm, bool import,
> > +					void __user *argp)
> > +{
> > +	struct kvm_memory_transfer mem;
> > +	int r;
> > +
> > +	if (!kvm_x86_call(cap_live_migration)(kvm) ||
> > +	    (import && !kvm_x86_ops.import_memory) ||
> > +	    (!import && !kvm_x86_ops.export_memory))
> > +		return -ENOTTY;
> > +
> > +	if (copy_from_user(&mem, argp, sizeof(mem)))
> > +		return -EFAULT;
> > +
> > +	if (mem.reserved || mem.buf.reserved || !mem.nr_gfns)
> > +		return -EINVAL;
> 
> [Severity: Medium]
> Does this input validation for the kvm_memory_transfer UAPI struct miss
> checking mem.flags == 0 and mem.id == 0?

Yes flags is unused for memory transfers at least for TDX. The id TDX can
eventually use for the thread index for QEMU multifd transfers.
