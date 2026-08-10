Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929D63A7F6B;
	Mon, 10 Aug 2026 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786351520; cv=none; b=rTgCv/9jwm4qAOV0TmwdJ8M5bF+QlaU9nJ7KLLMexnvL2zKabKX+ImL45GurD3WDx4l2l5jTj/vcsgPKGL3R2lWOaKfU2J/ykd5vhmfHSTgkB8Z0yfkUo6WC9o0SOeOBmKn6sRORg8M85wKqlGJWIr6+K1+x5QpXvzaiMh2CpYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786351520; c=relaxed/simple;
	bh=t+XRwRInjn6+9o+4yej1CTQA2uO18u2BwvsKbEgBCFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uL/mTcWg1qIm52I4meHBKe7i7nTXEnmNV9mHWqfHk6ia9OXOiOmtU02yvfZJMNaKszxyYw5xDey5PJRxN64pW8cOyla5aoJu2sxfJn7hgqP0B3izietZGXN4HTBWlDUxZtYF23v5aVxV+u+6sjXGn4C1ZxDz57ch1Y3m3KN7qps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kF9rwRxb; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kF9rwRxb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786351518; x=1817887518;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t+XRwRInjn6+9o+4yej1CTQA2uO18u2BwvsKbEgBCFs=;
  b=kF9rwRxbKYGgS69gS8uNrMxXTO0SQHBPRk2dq68ZNu7yV9mneD3Z7QY4
   qU1Bj2tG/cKikHr506iyl35JzLsDgu8V25QYt7ZmUOBh7cjQbd0S/Ygir
   3GM1ZEfu+ASADhCKmKdBedKiDjHP6TopI8AoC65UxMvvDzGZ00pqUqI6R
   cdetKWlraURc6RcDKa5msfprLimqTAUnf+ifTs4SD1rODqqhXXkE6WKzF
   jnYLPG+9JPkDN4jEpVlR5PZ3rB8UdJtg0kmphU81+15z67eLNRWcK7ce/
   WcRuGog8PSm48JmgItlv5x2THeB1lhQlaiSh3evO5hqkQdR6dtIqyF77c
   g==;
X-CSE-ConnectionGUID: KHhKdN26SLubJ8N/rdhv3Q==
X-CSE-MsgGUID: wiTEO8zZRYi2WQvzjc1NCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="98219536"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="98219536"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:45:17 -0700
X-CSE-ConnectionGUID: 1/Ef87CeTV6HhbUCCm7sxQ==
X-CSE-MsgGUID: GyEshiYeSEi+JiaYsbLMtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="268140359"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.242.118]) ([10.124.242.118])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:45:14 -0700
Message-ID: <6e324f65-f0e4-4862-a3c0-001af5cbec0a@linux.intel.com>
Date: Mon, 10 Aug 2026 16:45:11 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] KVM: TDX: Reject INIT_MEM_REGION if number of
 bytes would overflow a u64
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko Bot <sashiko-bot@kernel.org>,
 Yan Zhao <yan.y.zhao@intel.com>, Ackerley Tng <ackerleytng@google.com>,
 Haotian Jiang <jianghaotian.sunday@gmail.com>
References: <20260806170602.4112602-1-seanjc@google.com>
 <20260806170602.4112602-2-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260806170602.4112602-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/2026 1:06 AM, Sean Christopherson wrote:
> From: Haotian Jiang <jianghaotian.sunday@gmail.com>
> 
> The nr_pages field in struct kvm_tdx_init_mem_region is a u64 that comes
> directly from userspace via copy_from_user().  The current validation
> uses a manual overflow check:
> 
>   region.gpa + (region.nr_pages << PAGE_SHIFT) <= region.gpa
> 
> When nr_pages >= 2^52, the shift (nr_pages << PAGE_SHIFT) wraps around
> to a small value, bypassing the wrap check.  While downstream protections
> (gfn_to_memslot() returning NULL for GFNs outside any memslot, and
> kvm_slot_has_gmem() checking for NULL) prevent any actual out-of-bounds
> access, the overflow itself is a real bug that should be caught at the
> validation layer.
> 
> Replace the manual overflow check with check_shl_overflow() to correctly
> detect the wrap-around.
> 
> Note, the manual wrap-around check on the gpa+size technically has a benign
> off-by-one bug, and can also use check_add_overflow().  Those flaws will be
> addressed shortly.
> 
> Opportunistically separate the initial sanity checks from the more involved
> checks to try and make the code easier to read.
> 
> Fixes: c846b451d3c5 ("KVM: TDX: Add an ioctl to create initial guest memory")
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260630214952.98C851F000E9@smtp.kernel.org
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Binbin Wu <binbin.wu@linux.intel.com>
> Cc: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
> [sean: use gpa_t, isolate check_shl_overflow() change, tweak changelog]
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
