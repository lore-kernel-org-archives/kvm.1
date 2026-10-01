Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C03B42E8F4;
	Thu,  1 Oct 2026 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866017; cv=none; b=GUPTGQSmIF3t0XawtMmF1zBuSjiI2cuwLv9eeWqgqKQ1MDI7x82L0qbBNCIgekM/aeHoDTshAu2kHhAhROiezd2JCdgWW6uDgyOWV5PRhJAvz6inOQ8ShsiewAKZ3miRR25hWE8VHgcvMfqMtAb/gIthz2Kcvl4XmY5wPtnIxWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866017; c=relaxed/simple;
	bh=GhVWk4SPao9B105HUeFe+fyef8iI9rmX37XSkTrAels=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=m9iSZMgjJmaASelADtDWx6nmdikG76EMI+30HgobZU52nx/hwjvj0GrQc/fe4EVwZQnBR+xSUk7NGWx1I9QPlp4/PiFXKIaiLxwVFBoBW2473AQFIjj/TmqYQkutfzxvngh8YoJcsmq1QTOeAYLqYYflqrwJk2na3zNn3bAopDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fl2Dr44C; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fl2Dr44C"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A047497;
	Thu,  1 Oct 2026 07:46:52 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8965A3F85F;
	Thu,  1 Oct 2026 07:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790866015; bh=GhVWk4SPao9B105HUeFe+fyef8iI9rmX37XSkTrAels=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fl2Dr44CtoIET7Uf1dd2ORhUSUA5Ozi3uDyE+KzyOlexv+rqgzKHrF83+jDV670WB
	 HzjfeEL7cAW+GR2EySj6VzEX/5rA0MWNvThg8q4BxSEsovEeV1MSjEcdQeZCJbaKCg
	 HJpqBoxhtEmdjcBnSV6ANmIugXCk6CgaMhQUIzrI=
From: Leonardo Bras <leo.bras@arm.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Leonardo Bras <leo.bras@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Josh Hilke <jrhilke@google.com>,
	Oliver Upton <oupton@kernel.org>,
	Wu Fei <wu.fei9@sanechips.com.cn>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] KVM: selftests: Check dirty-ring size before enabling
Date: Thu,  1 Oct 2026 15:46:51 +0100
Message-ID: <ar5yW30S75THCfdV@LeoBrasDK>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <ar1xne00AHnJ-p_d@google.com>
References: <20260929113711.2064390-1-leo.bras@arm.com> <20260929113711.2064390-3-leo.bras@arm.com> <ar1xne00AHnJ-p_d@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Sep 30, 2026 at 01:31:25PM -0700, Sean Christopherson wrote:
> On Tue, Sep 29, 2026, Leonardo Bras wrote:
> > As of today, trying to enable dirty-ring with a size bigger than the
> > maximum will return an "argument list too long" error.
> > 
> > Change vm_enable_dirty_ring() to get the maximum size, then compare it to
> > the desired size before enabling. If the value is invalid, print a more
> > precise error message.
> > 
> > Signed-off-by: Leonardo Bras <leo.bras@arm.com>
> > ---
> >  tools/testing/selftests/kvm/lib/kvm_util.c | 21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > index 9ddc047d5c27..15a671b71553 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -168,24 +168,37 @@ unsigned int kvm_check_cap(long cap)
> >  	ret = __kvm_ioctl(kvm_fd, KVM_CHECK_EXTENSION, (void *)cap);
> >  	TEST_ASSERT(ret >= 0, KVM_IOCTL_ERROR(KVM_CHECK_EXTENSION, ret));
> >  
> >  	kvm_free_fd(kvm_fd);
> >  
> >  	return (unsigned int)ret;
> >  }
> >  
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
> > +	TEST_ASSERT(max_size > 0,
> 
> Rather than open code this, which is kinda sorta going to show up in multiple
> places, what if we do this as a prep patch?  Then vm_enable_dirty_ring() can use
> kvm_get_dirty_ring_cap() (completely untested).

Sure, if you think it's useful :)

> 
> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
> index af5eb0334a74..558a71d631da 100644
> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> @@ -291,8 +291,7 @@ static void default_after_vcpu_run(struct kvm_vcpu *vcpu)
>  
>  static bool dirty_ring_supported(void)
>  {
> -	return (kvm_has_cap(KVM_CAP_DIRTY_LOG_RING) ||
> -		kvm_has_cap(KVM_CAP_DIRTY_LOG_RING_ACQ_REL));
> +	return kvm_get_dirty_ring_cap();
>  }
>  
>  static void dirty_ring_create_vm_done(struct kvm_vm *vm)
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index e3b122719262..c08d1581221e 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -339,6 +339,17 @@ static inline bool kvm_has_cap(long cap)
>  	return kvm_check_cap(cap);
>  }
>  
> +static inline long kvm_get_dirty_ring_cap(void)
> +{
> +	if (kvm_has_cap(KVM_CAP_DIRTY_LOG_RING_ACQ_REL))
> +		return KVM_CAP_DIRTY_LOG_RING_ACQ_REL;
> +
> +	if (kvm_has_cap(KVM_CAP_DIRTY_LOG_RING))
> +		return KVM_CAP_DIRTY_LOG_RING;
> +
> +	return 0;	
> +}
> +
>  /*
>   * Use the "inner", double-underscore macro when reporting errors from within
>   * other macros so that the name of ioctl() and not its literal numeric value
> 
> 
> > "Dirty-ring not supported in this kernel\n");
> 
> "this kernel" could be misleading, some architectures simply don't support the
> dirty ring.

So, do you suggest keeping it simple by printing "Dirty-ring not supported"?


> 
> > +	TEST_ASSERT(ring_size <= max_size && is_power_of_2(ring_size) &&
> > +		    ring_size >= getpagesize(),
> > +		    "Invalid dirty-ring size: Should be a power of two "
> > +		    "between %lu and %lu entries\n",
> 
> Don't wrap strings.  The "Invalid dirty-ring size:" part is redudant with the
> expressions, just drop that to shorten things.  This should also spit out the
> requested ring_size.  Stating the range as a number of entries is also confusing;
> as a debugger, I don't want to have to go look at the size of kvm_dirty_gfn to
> understand why ring_size is invalid.
> 
> And maybe split up the asserts?  If the goal is to make it easier for developers
> to know when they messed up, might as well make it as easy as possible.  E.g.
> leaning on the above diff, something like this?
> 
> 	long cap = kvm_get_dirty_ring_cap();
> 
> 	TEST_ASSERT(cap, "Dirty-ring not supported");
> 
> 	TEST_ASSERT(is_power_of_2(ring_size),
> 		    "Dirty-ring size '0x%x' must be a power-of-2", ring_size);
> 	TEST_ASSERT(ring_size >= getpagesize(),
> 		    "Dirty-ring size '0x%x' must be at least one (host) page", ring_size);
> 	TEST_ASSERT(ring_size >= vm_check_cap(vm, cap),
> 		    "Dirty-ring size '0x%x' is larger than KVM's limit of '0x%x'",
> 		    ring_size, vm_check_cap(vm, cap));
> 
> 	vm_enable_cap(vm, cap, ring_size);
> 	vm->dirty_ring_size = ring_size;
> 

Humm, I see the point. 
Will do as suggested then, thanks!

Leo
