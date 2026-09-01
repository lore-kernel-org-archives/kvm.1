Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAFA367B8C
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 06:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788243191; cv=none; b=aplAwh+LnlZ/WClqzHgvI4vSZkieMNkNUjn7uCTpWzI1xktUD9uPNJfOrTQmwwjPOTrzBhzNuQzBRwJHL60y8+Mp/fLDj+NCfvX72PF4k6eMxN7XsGUh+AYp79vPF2qm8hDltsD8B3OCbNu1H+vdWHfAjBijVQGVhRCqWF+kfAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788243191; c=relaxed/simple;
	bh=8vQuIlIQlArQCmlM75ppck/s64O6MTWpubJEkWhnQrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pnmr1c4bOI1IrqvlUUENy1vJpW8YU0DuvKHheNxuvbwXJbW8/Ghf70y2VXLY3TEj7oqQeek+Cigq8QesS3wGPaxCF7H4fhH77Ge3KPnsH4+q72FXeguPoDy7nrjaYLMrzph49WqV+u6oxciM8hDlTfV3tmHlhjGUBi0QBvbMsRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j10+mg4E; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j10+mg4E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788243189; x=1819779189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8vQuIlIQlArQCmlM75ppck/s64O6MTWpubJEkWhnQrw=;
  b=j10+mg4EMGtQ/flNXt3yL4fm8G7Z2CrKsSdtBLTnAb8oR408omZhYUVk
   fe+q8Dv1jQ9TtUwb0LW58i8rMY4aXAMx2iGSRJgRpbYbghKqBZJVVNike
   IaS+4VMWOMuiGKIfr/jnw0bDY5aXRDsxJ957WBMUdqkEV6Uv/E+r6qp9N
   7VWBvlcIMLOyNgMef//JLDmtkSFqOIpHI6WoyqNecdOt+CffQjYCLslDj
   2ZMV6RGC7y854f+Pbk3ODxjvDY6xWuf6uVpIQ/XIpecbRelZblbq+HfaB
   Wmi4KEsfJtIBT+JlVe4hEFQvcvAouk/V2k5dHqR8IVPNdWT+l10fV/IEW
   Q==;
X-CSE-ConnectionGUID: +WKrNZqVTGaKiD/7cVlZbg==
X-CSE-MsgGUID: jNXdZAQ0R5Cp8+dScy3+yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="87797629"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="87797629"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:13:00 -0700
X-CSE-ConnectionGUID: YM6g6UVbRBGC0HIlWdPlnQ==
X-CSE-MsgGUID: GJUahYSgSOmfGLMCkGCdpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="262866544"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.192])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:12:59 -0700
Date: Tue, 1 Sep 2026 09:12:56 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/4] KVM: x86: Add optional KVM_EXPORT_VCPU and
 KVM_IMPORT_VCPU
Message-ID: <apZs6K0rn_pEa8V6@tlindgre-MOBL1>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-5-tony.lindgren@linux.intel.com>
 <20260831072353.D1FED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831072353.D1FED1F000E9@smtp.kernel.org>

On Mon, Aug 31, 2026 at 07:23:53AM +0000, sashiko-bot@kernel.org wrote:
> commit 4d7dccde0750ca7fd34158829ad4120d967ac2c3
> Author: Tony Lindgren <tony.lindgren@linux.intel.com>
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> 
> [ ... ]
> 
> > @@ -6189,6 +6189,38 @@ static int kvm_get_reg_list(struct kvm_vcpu *vcpu,
> >  	return 0;
> >  }
> >  
> > +static int kvm_vcpu_ioctl_transfer_vcpu(struct kvm_vcpu *vcpu, bool import,
> > +					void __user *argp)
> > +{
> > +	struct kvm_vcpu_transfer vcpu_state;
> > +	struct kvm *kvm = vcpu->kvm;
> > +	int r;
> 
> [ ... ]
> 
> > +	if (copy_from_user(&vcpu_state, argp, sizeof(vcpu_state)))
> > +		return -EFAULT;
> > +
> > +	if (vcpu_state.reserved || vcpu_state.buf.reserved)
> > +		return -EINVAL;
> 
> [Severity: High]
> Should we also validate the flags field here to ensure forward compatibility?
> 
> The new kvm_vcpu_transfer structure introduces a flags field, but this
> validation step only explicitly rejects non-zero reserved fields.
> 
> If the kernel silently ignores non-zero flags, userspace might
> inadvertently pass uninitialized or arbitrary values without receiving
> an error. If KVM later assigns meaning to these flags, old userspace
> programs that have been unknowingly passing garbage could unexpectedly
> trigger new behaviors or break.
> 
> Would it be appropriate to require that vcpu_state.flags is zero for now?

Yes flags is unused for vCPU transfers at least for TDX and can be zero
for now.
