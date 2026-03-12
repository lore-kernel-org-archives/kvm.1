Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAAE40148E
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773342576; cv=none; b=kzer8dzXKYnfFhpQItho7F1FHgh91ZlWtbHmCyALxqR2l1a7kKHDxPt2l5RajXct3NQ9UW2Ppw+lizsyqnSJzRreRYh5WP4n4BdLWeSxrnD9cGzQsxKVzDETiVwMRw24LK+fCNp0n29OCVkqejaKJMVhWZq6Ii3J4/zOyU9R9DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773342576; c=relaxed/simple;
	bh=qWEfWIxC7t9sRsODkoA1wVLz7TEdDUoLpqykWc97PAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeNCyzPkxn/m9bkHAUqTL/Yd67t5zv6pX66lNg0R35YyTcX9R3v82BTCTe+64k/G4jWWcZZk576Eif/jfcQpO3RIqZcQsWeyiTI1944UW5Phzy6nHusyAhDdDr1xfs/43t+jCdQ30VmAdQuex6Zzd1WrJanMHFk8dwyqZ7CqeRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MMCPhTO6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MMCPhTO6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773342574; x=1804878574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qWEfWIxC7t9sRsODkoA1wVLz7TEdDUoLpqykWc97PAE=;
  b=MMCPhTO6lq3QXU1VePauLTmojCkDNtHkZhu11Y3W4l1MsdYvuohCuvEn
   JxaL019iGC7ue9BwsdZ0RpQFMlqkf8p0U+tB0OLZkzsya2SdvGSLc+9Oa
   VoDn3QrNaUPRT0SrQN4U5ChenL+JoyYnZgMbYwutR7Ym3Ncv1mOmtpbeY
   nDPgk+sWnmjiF/JgNvabJDIr0T1HYkxxIJ/xD/mR5u1aJaSyYiFVrqF8i
   GeMqVaagvkfHNBgWI3ZLYOTb7mvEnv373igVaE6lDECvc4aSpBE2EkaQ4
   4xH6TM/b8HcD4sHliyOg6f08UNnXjjg6BZTJfAbvOZRmSgsleI6oIb64P
   A==;
X-CSE-ConnectionGUID: ZhesWY6OQ968JdG+jcYuwg==
X-CSE-MsgGUID: Tb80ShAPQSS1UxMl/voJHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74633962"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74633962"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 12:09:33 -0700
X-CSE-ConnectionGUID: /oJtTzcoSjOLgIRfyD4qOw==
X-CSE-MsgGUID: jcrVEvuBRtKSai/ZLyT+pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="221101545"
Received: from inaky-mobl1.amr.corp.intel.com (HELO localhost) ([10.124.222.182])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 12:09:32 -0700
Date: Thu, 12 Mar 2026 12:09:30 -0700
From: Isaku Yamahata <isaku.yamahata@intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: isaku.yamahata@intel.com, kvm@vger.kernel.org, isaku.yamahata@gmail.com,
	Paolo Bonzini <pbonzini@redhat.com>,
	kernel test robot <lkp@intel.com>, isaku.yamahata@linux.intel.com
Subject: Re: [PATCH] KVM: VMX: Eliminate warnings by sparse in vmcs12.c and
 hyperv_evmcs.c
Message-ID: <abMPalre2fRykkvK@iyamahat-desk>
References: <47e4570a1db6f68eacdde989c6cf4f53175cea75.1773193126.git.isaku.yamahata@intel.com>
 <abL8nHNYkUCcS73O@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abL8nHNYkUCcS73O@google.com>

On Thu, Mar 12, 2026 at 10:49:16AM -0700,
Sean Christopherson <seanjc@google.com> wrote:

> On Tue, Mar 10, 2026, isaku.yamahata@intel.com wrote:
> > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > 
> > Make ROL16() explicitly mask instead of the truncation by u16 cast.
> > Sparse complains as follows for vmcs12.c and hyperv_evmcs.c.
> >   > vmcs12.c:17:9: warning: cast truncates bits from constant value
> >   > (20002 becomes 2)
> > 
> > It is because ROL16(val, n) includes "(u16)(val) << (n)" whose type is int,
> > not u16, due to integer promotion even with a u16 cast.  The outermost u16
> > cast in ROL16() may truncate it.  Explicitly mask it to avoid truncation by
> > the u16 cast.
> 
> Honestly, I'm inclined to ignore sparse.  The code is correct as-is, and adding
> the GENMASK just makes it less readable IMO.

Ok, I'm fine with ignoring those warnings. I just wanted to silence
kernel test robot and avoid sparse "too many warnings" to stop more
warnings.  (No other warning found with this change.)
-- 
Isaku Yamahata <isaku.yamahata@intel.com>
