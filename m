Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B6B36197B
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 05:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789970299; cv=none; b=V2PhdbyGE4ehe0E6OO/fEBC2vl0UFyvW4uf2xIIzhdlyE28Q9EXoqU5vucYEjWs18N7r5PqiYEmK0PsXWuk+wLmmtAKwYFBWFCiwVo9SfgYzyPKzL/sTIGOj5/0vGQmOkMd0zkswIWSGN1KI1j0xcUWSQAJge5XIPMv/gDgCozM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789970299; c=relaxed/simple;
	bh=bdTbBlRWQDK8jCNNEaihenXcF9Ysecbf5xBOqRbbB20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXkm98u3cakOLa++KbHKUFv7AkvBNvhVu8uVj9+DY/cdgYDrGhTQDS14a2gA55dhFH+qheyWXRiG8u4d5G6SmzAuaRjkq1v5GvFbkttgnhNN9baQol1MDE/jnLE4XPqdPMGQBLL+u9KtO6SZ0HONi1QZKDDzwBE4qBfhIaiEO6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZ3pcDQj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZ3pcDQj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789970297; x=1821506297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bdTbBlRWQDK8jCNNEaihenXcF9Ysecbf5xBOqRbbB20=;
  b=FZ3pcDQj7v8Jm7slBwv50u8itlyawtGiu7Hgcs1D4O2UM87GpmItzvob
   EyBYwmMA7JTYTz7h4beLPn/Ag2HsxZN1cN4rXzMbexe0C+5o09qNH5JTZ
   874R0E9eSJtewu6nkirBucJVTxkTXMUCHRKXFA8YnaMnIb+Nf3CyHnKgn
   eFv6wXQZchjpdOdZQ8GD4N4rOB/tXz2voGbcqvIN5AjV9mtmE06NZknSz
   136sR3DNZQY0Ja6JXBwWIJhk+rCXiMK3VR8vf3hIP02TuzYFU2HzXKKRJ
   xDWBNKNyFgr9qfAuPyAN3MmyBZfCoQCfncOO02rAgeAo5saHTBjWiNxhx
   Q==;
X-CSE-ConnectionGUID: Ou2P0JfuTbGwUandnUqQng==
X-CSE-MsgGUID: OoAVGGe+RueOydXym9BIxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="89599453"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="89599453"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 22:58:16 -0700
X-CSE-ConnectionGUID: pJegh9V4R8y2fBX/wtAEsQ==
X-CSE-MsgGUID: vI8mHHkpRAiixdGtfoU+RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="298766364"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.168])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 22:58:09 -0700
Date: Mon, 21 Sep 2026 08:58:06 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Xu <peterx@redhat.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Fabiano Rosas <farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <steven.price@arm.com>,
	Anup Patel <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	Jakub =?utf-8?B?UsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
Message-ID: <arDHbjcwaRFcHb08@tlindgre-MOBL1>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
 <ab3c9e32-ab34-49bf-937a-4d3d736fb4dc@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab3c9e32-ab34-49bf-937a-4d3d736fb4dc@intel.com>

On Thu, Sep 17, 2026 at 09:33:18PM -0700, Kishen Maloor wrote:
> On 8/31/26 12:13 AM, Tony Lindgren wrote:
> 
> I was wondering how a vendor would use kvm_transfer_buffer for a command that
> passes an input and also returns an output. size can describe the input
> length or the space available for output, not both, so the kernel has no way to
> know how much it may write.
> 
> Two suggestions below. They're orthogonal.
> 
> > ...
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index 5f6c1ce9673b7..d9291a8a97bb1 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -2010,6 +2010,8 @@ struct kvm_x86_ops {
> >  	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> >  	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
> >  	int (*gmem_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
> > +	bool (*cap_live_migration)(struct kvm *kvm);
> 
> Should this return an 'int' specifying the maximum buffer size that the vendor impl
> requires/uses? Userspace can then learn this once.

OK that sounds good to me. I assume you are thinking the maximum hardware
specific buffer size per thread? As in 512 * 4096 bytes for the TDX case?

> > +
> > +struct kvm_transfer_buffer {
> > +	__u64 address;
> > +	__u32 size;
> > +	__u32 reserved;
> > +};
> 
> Should this struct include a 'capacity' field (u32) that is set on each command?
> It would be the number of bytes writable at address.
> size would be the input length on entry (0 if the command passes none), and the
> number of bytes produced on return (0 if none).

Hmm so the transfer command return value can return how many bytes were
written of the input. But yeah we don't know how many bytes were written
back to the transfer buffer as result of the transfer command.

How about if we add the bytes returned to the transfer struct? Then the
kvm_transfer_buffer can stay as just a buffer. 
