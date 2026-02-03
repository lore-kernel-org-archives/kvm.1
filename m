Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9FD2628D
	for <kvm@vger.kernel.org>; Tue,  3 Feb 2026 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770145145; cv=none; b=MucL1AanwUiCtZBzDL6G8/lSBvwexQCtwasmwq/F3MikA46PvK1jNiYsYu9gpBWpygg+XFccOxI+NCndqF+mL5N3SjevbJJ/BCMRtz4RjLTLoFEd7x1VrLFraXkjXw1sneUUTtWlDAi8BLguAEzlKXwEjTjcO2+ln6H8HzF8QAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770145145; c=relaxed/simple;
	bh=j0FKW+6je1pmTp/m273InQlbgMIkbZKpL2nlzvL2fvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNBqY2ATjsqxztbU2p8A0IV53BxcycMSPMlVYo36ZJCfNbNwVpdGdi0YM8Sa34xRIdbN5B+ZK/c7H4eEGTKbnPV+aS5a7o1k3jZvNjM7r1jhbHpOEUFFHykNi/d7ZunDNRt5IAXx+5qV0plooZGNInI0kU5wyG8H8KgQ4p3Qy1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ba/YH1ME; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ba/YH1ME"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770145144; x=1801681144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j0FKW+6je1pmTp/m273InQlbgMIkbZKpL2nlzvL2fvk=;
  b=Ba/YH1ME8Y8MYnOlDnwevbJsvfkxvN+AchB1/e93FXw6A4oM9+KSUM70
   kuc+eKrSYbgVja1eQ1cs6gGQJvpQX/Cjfm45cly4SGjCps/PfAlRIT35+
   5vPyj6gbj/je0GDidb8KbYYP0w9718vlVmV8MexpkatkFdeVD1ew+CQwH
   5HsHmrIiPRHR7ZWQHKdJYmvHKC/+HY9joOiUZ28mm5KBBDM0yWNmZTAIr
   9Q+XWEt1jlGFwifxPFMOAiDuYXArjfQsTgrQySSsGJSj7ybx8XnH5zgdr
   9TM7Us6NAgGEwClqvvsvMCDG+JrkoVFotmytB537dDbI9Hk1D783vk9rY
   A==;
X-CSE-ConnectionGUID: WEZebeZAS5+P8AHfEEmg7g==
X-CSE-MsgGUID: sAvei9YUSomDoj+DdnKHCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71362660"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="71362660"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 10:59:03 -0800
X-CSE-ConnectionGUID: 5BKBsOCJRs6huoK8Yx0/mw==
X-CSE-MsgGUID: PouOOi0sSguiyR+Ig2NcOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="240618972"
Received: from khuang2-desk.gar.corp.intel.com (HELO localhost) ([10.124.221.188])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 10:59:03 -0800
Date: Tue, 3 Feb 2026 10:59:02 -0800
From: Isaku Yamahata <isaku.yamahata@intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: isaku.yamahata@intel.com, kvm@vger.kernel.org, isaku.yamahata@gmail.com,
	Paolo Bonzini <pbonzini@redhat.com>, isaku.yamahata@linux.intel.com
Subject: Re: [kvm-unit-tests PATCH] x86: apic, vmexit: replace nop with
 serialize to wait for deadline timer
Message-ID: <aYJFdgUxYWXkavfi@iyamahat-desk>
References: <7acdd9974effabe5dc461aa755eacf9fb0697467.1770116601.git.isaku.yamahata@intel.com>
 <aYI-rqFnqJeAb_mB@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYI-rqFnqJeAb_mB@google.com>

On Tue, Feb 03, 2026 at 10:30:06AM -0800,
Sean Christopherson <seanjc@google.com> wrote:

> > +static inline void serialize(void)
> > +{
> > +	/* serialize instruction. It needs binutils >= 2.35. */
> 
> And a CPU that supports it...  I don't see any point in using SERIALIZE.  To check
> for support, this code would need to do CPUID to query X86_FEATURE_SERIALIZE, and
> CPUID itself is serializing (the big reason to favor SERIALIZE over CPUID is to
> avoid a VM-Exit for performance reasons).

Thank you for pointing it out. I'll replace it with raw_cpuid(0, 0).
Or do you want to opencode cpuid() in each places?
-- 
Isaku Yamahata <isaku.yamahata@intel.com>
