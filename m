Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F5C1F3B85
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 06:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788242609; cv=none; b=ZhEnvxElQcACV2aNgjsGlja0VzJvVqFbJiGGMqiMEE1Z62WoLm7S2qH9OJPiSzDUKNubzPhLq+35XrRB35k63WRm71rVTKMilp+OvvJXxAVomXZ2ME/iNslrJqmDtWvsnuxzvKWXeMGa6XaSAMdoG+i6mgSMkDeqM9A/CDg+3pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788242609; c=relaxed/simple;
	bh=ARmgaj61p3kmL6E2cd/ljeeaDDh/EdXOAT3NHk3aN9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMBwoL/TzSNlrQcVKExzrJEQvci1zv2kgQNxZBT6G3nhQSY211/U2MvVFz61X2Yh9SnUnknG4SDA5l1fIwBHUYOIw3Y9kZhyiGZDkoOdo3BNdAXnPZlQ4wx6ei4AGzuXULkBvYW7sDa4a77X/xW4B5dltKTma/PBF0FCHAdCuUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SaE3SZiX; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaE3SZiX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788242607; x=1819778607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ARmgaj61p3kmL6E2cd/ljeeaDDh/EdXOAT3NHk3aN9A=;
  b=SaE3SZiX+aLXn16Who3HmZxFuJBByktUxroayy0Wpho3lgL+JFxmseUa
   1o2Qr8YkW1w/aX380c6u9/+PoZJt23JFsXlwbe8hmIQ21OfpwVNX7t540
   n4ueyuGO6P6PcbpBzkxZTwujahq3J6Ba52K+cT+phITgBsK5KQV8yiGKE
   za62xTdRHsVQ4ZVoe6hP0NQS2+73FxDeavZ9OCbGmabWYMVLht8txHKXu
   Dj5ImWy6pwOX6tk/Hy5zfzSpxD3i9KdyvFltdlcB47EbYNVpN0UWM/+5d
   M77oHFB7IGAzuX3/8Bl+D61c2SY3BOPGc+XvVQ+TuHLhvhTAOl/IsRo43
   Q==;
X-CSE-ConnectionGUID: 0mD1wBbXQ7yLpEkTTEhIMA==
X-CSE-MsgGUID: luCCFM6GS0a7GDpp7hGn5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="91172903"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="91172903"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:03:26 -0700
X-CSE-ConnectionGUID: bYit0Gl3Riyd4gPOve6x6w==
X-CSE-MsgGUID: 1yQaa3xhSvmxjr9nZDoJXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="267675063"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.192])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:03:25 -0700
Date: Tue, 1 Sep 2026 09:03:22 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
Message-ID: <apZqqi0V-CEKgZbC@tlindgre-MOBL1>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
 <20260831072311.CF2DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831072311.CF2DA1F000E9@smtp.kernel.org>

On Mon, Aug 31, 2026 at 07:23:11AM +0000, sashiko-bot@kernel.org wrote:
> Author: Tony Lindgren <tony.lindgren@linux.intel.com>
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -7614,6 +7617,28 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
> >  		r = kvm_vm_ioctl_set_msr_filter(kvm, &filter);
> >  		break;
> >  	}
> > +	case KVM_MIGRATE_CMD: {
> > +		struct kvm_migrate_cmd cmd;
> > +
> > +		if (!kvm_x86_ops.migrate_cmd ||
> > +		    !kvm_x86_call(cap_live_migration)(kvm))
> > +			return -ENOTTY;
> > +
> > +		if (copy_from_user(&cmd, argp, sizeof(cmd)))
> > +			return -EFAULT;
> > +
> > +		if (cmd.reserved || cmd.buf.reserved)
> > +			return -EINVAL;
> 
> [Severity: High]
> Does this code also need to validate that the new flags field is zero?
> 
> If uninitialized memory or garbage is passed by userspace in cmd.flags, it
> will currently be silently ignored. When a future kernel introduces a new
> flag, old userspace applications passing uninitialized flags will inadvertently
> enable it, which could permanently break backwards compatibility.

Could be zero, or we could check for the known flags.

We are currently using the following flags for KVM_MIGRATE_CMD
sub-commands for TDX:

1. KVM_MIGRATE_SETUP
====================

TDX_MIGRATE_SETUP_SESSION       exchange the migration keys
TDX_MIGRATE_IMMUTABLE_STATE     transfer the TDX immutable state

2. KVM_MIGRATE_ITERATION
========================

TDX_MIGRATE_IN_ORDER_DONE       end the in-order migration

3. KVM_MIGRATE_STOP_AND_COPY
============================

TDX_MIGRATE_STOP_COPY_PAUSE     pause the TD
TDX_MIGRATE_STOP_COPY_TD_STATE  transfer the mutable TD state

4. KVM_MIGRATE_END
==================

TDX_MIGRATE_ABORT               abort migration

Maybe all the above TDX specific flags could be turned into generic
flags for the sub-commands.
