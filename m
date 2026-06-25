Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97E935028D
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385908; cv=none; b=cHvsV4Gbp9gb6ES2FQkssD55hjlmPOtZ5wjh5oR96/QhVeNtucCJoZOQf48VFa9TYV9wutfumY1WKSTljLk5Lf3xH3HDaKFZe5eOu4FNBPzmUTbpOpoN74JTJuG+JhrWhHdsBBkt+nXO9lDMTARb89DUcZHfOSwxO2Mbjternh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385908; c=relaxed/simple;
	bh=6pZvrfdpYAnh+T+yppe7WikgLE8YjBok1CzsaWSmg60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=GqAmfPiJIcrXA7bpd4sE5+zgll8pZNx+SPQM4vEWlZ5mdc5AAynqWJQJjH+wjjo4LXTkuTa1H6FoyJhpxm2wVjgzYFrSa0HctfIif84/n6Sz3OiNrxhXVT+ujTtwFsd0ZH9PxSP/khlo+5ItDjz6rw+qOUBozrnc8As/m59WytM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NCYjaanS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NCYjaanS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 679BE2BCE;
	Thu, 25 Jun 2026 04:11:41 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8800C3F62B;
	Thu, 25 Jun 2026 04:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782385905; bh=6pZvrfdpYAnh+T+yppe7WikgLE8YjBok1CzsaWSmg60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NCYjaanS8bxit/pI+ZXTgcKZOeQFMghUQAa3/K6pjHkCdyQe4sRKnOTrQofOQdV5N
	 87EIYaDoLFyX7/6B6y+WZwSw6ffwUpegjQeqoNh0+qThFY02eOiWdIC7+2ChH4QfEM
	 1SneP7h+7ugz3/YBCWEiLQJq26aYo2cz6KGci2uc=
From: Leonardo Bras <leo.bras@arm.com>
To: kvm@vger.kernel.org
Cc: Leonardo Bras <leo.bras@arm.com>
Subject: Re: [RFC PATCH 2/3] KVM: selftests: Check dirty-ring size before enabling
Date: Thu, 25 Jun 2026 12:11:36 +0100
Message-ID: <aj0M6ISwZFL6E-ib@LeoBrasDK>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624172808.190341F000E9@smtp.kernel.org>
References: <20260624171656.1737580-1-leo.bras@arm.com> <20260624171656.1737580-3-leo.bras@arm.com> <20260624172808.190341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jun 24, 2026 at 05:28:07PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Low] Format string type mismatch causing undefined behavior on 64-bit big-endian architectures
> - [Low] Misleading error message contradicts inclusive boundary check
> - [Low] Misleading assertion failure when dirty ring capabilities are unsupported
> --
> 
> commit 8555e295b2631adeaf18b3b867988e6adc58eb4c
> Author: Leonardo Bras <leo.bras@arm.com>
> 
> KVM: selftests: Check dirty-ring size before enabling
> 
> This commit changes vm_enable_dirty_ring() to dynamically fetch the maximum
> dirty-ring size via KVM_CAP_DIRTY_LOG_RING_ACQ_REL or KVM_CAP_DIRTY_LOG_RING.
> It then validates that the requested ring size is less than or equal to this
> maximum and is a power of two, printing a specific error message if the check
> fails.
> 
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> 
> [ ... ]
> 
> >  void vm_enable_dirty_ring(struct kvm_vm *vm, u32 ring_size)
> >  {
> > -	if (vm_check_cap(vm, KVM_CAP_DIRTY_LOG_RING_ACQ_REL))
> > -		vm_enable_cap(vm, KVM_CAP_DIRTY_LOG_RING_ACQ_REL, ring_size);
> > -	else
> > -		vm_enable_cap(vm, KVM_CAP_DIRTY_LOG_RING, ring_size);
> > +	long cap = KVM_CAP_DIRTY_LOG_RING_ACQ_REL;
> > +	int max_size = vm_check_cap(vm, cap);
> > +
> > +	if (!max_size) {
> > +		cap = KVM_CAP_DIRTY_LOG_RING;
> > +		max_size = vm_check_cap(vm, cap);
> > +	}
> > +
> 
> [Severity: Low]
> If the host KVM subsystem does not support these capabilities, max_size
> will evaluate to 0.
> 
> Since the assertion below will then fail for any positive ring_size, does
> this create a misleading error message about "smaller than 0 entries"
> rather than indicating the feature is unsupported?

Being <= 0 entries is a good sign that the feature is unsupported.
But fine, will add an assert for this as well.
 

> 
> > +	TEST_ASSERT(ring_size <= max_size && is_power_of_2(ring_size),
> > +		    "Invalid dirty-ring size: Should be a power of two "
> > +		    "smaller than %d entries\n",
> 
> [Severity: Low]
> The condition checks if ring_size is less than or equal to max_size, but the
> error message text specifies it must be "smaller than".
> 
> Does this mismatch make it confusing to debug failures when the requested size
> is exactly equal to the maximum size?

Fair, changing this as well.

> 
> > +		    max_size / sizeof(struct kvm_dirty_gfn));
> 
> [Severity: Low]
> The expression max_size / sizeof(struct kvm_dirty_gfn) evaluates to a size_t,
> but the format string uses %d.
> 
> Can this cause format warnings, and result in incorrectly printing 0 on
> 64-bit big-endian architectures since the format parsing will read the most
> significant 32 bits?

Ahrg, right, the result is promoted to size_t on the division.
Changing it to %lu 

Thanks!
Leo

