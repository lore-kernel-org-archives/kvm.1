Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB782E8B64;
	Fri,  2 Oct 2026 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939672; cv=none; b=ORocxMx9eIqp3kTtuX9uKcqPnVo0ba0G2KqSvsK4izD6vJ2Max7rfFJV0qKgBjHEFYHZgCYU9/n8TUtIBeEewVtrGwmS3nCnNPZBadSnjKFV7hFfr6bFc2EGZy0lUr/Yj9aGx9uP/MY5q/Kd5I/VexM9HMs8AY8fdtfbAk/hHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939672; c=relaxed/simple;
	bh=W2Hmxi+s93iFNrhdbv2gdnA0AexPn4miXdEMsN0lpQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=E75Csq+jcULDMhb9fgdsAhHYjPgkR2nHeSI0IU6TpXYg5qVo84s/xFMtFIUbsCRcieHM6EDxLjp1MVZeZ7bV6Jn2dFsEDuJr6WNwyBogrY4OJvdvF/axu8N8OcVCK/sNXxlyc2q6hNELVmRFUelac1PFfNxE8FvR+bsdKDuA+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=m5xU/Mpg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="m5xU/Mpg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8FB9497;
	Fri,  2 Oct 2026 04:14:26 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A4803F85F;
	Fri,  2 Oct 2026 04:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790939670; bh=W2Hmxi+s93iFNrhdbv2gdnA0AexPn4miXdEMsN0lpQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m5xU/MpgU6umZSRKZKmvQkjaeAgcQkBqaG1OB1IM28VEY/2CgT7lF4mLXKKhtQ0IK
	 paZrqGOWOQFHAsyOjDWOitQdpiUhya5oXkxjDTPrh0PlAm5vr5hbN2FfxDnpudlMr9
	 Emn/briwJaFoaZavY1afGDCZlNQyMHLHaxBvaizY=
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
Date: Fri,  2 Oct 2026 12:14:22 +0100
Message-ID: <ar-SDkBLBV0GDCDV@LeoBrasDK>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <ar7XFr51N_oK7hN-@google.com>
References: <20260929113711.2064390-1-leo.bras@arm.com> <20260929113711.2064390-3-leo.bras@arm.com> <ar1xne00AHnJ-p_d@google.com> <ar5yW30S75THCfdV@LeoBrasDK> <ar6SHjnMYNqiEpVa@LeoBrasDK> <ar7XFr51N_oK7hN-@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Oct 01, 2026 at 02:56:38PM -0700, Sean Christopherson wrote:
> On Thu, Oct 01, 2026, Leonardo Bras wrote:
> > On Thu, Oct 01, 2026 at 03:46:51PM +0100, Leonardo Bras wrote:
> > > On Wed, Sep 30, 2026 at 01:31:25PM -0700, Sean Christopherson wrote:
> > > > On Tue, Sep 29, 2026, Leonardo Bras wrote:
> > > > >  void vm_enable_dirty_ring(struct kvm_vm *vm, u32 ring_size)
> > > > >  {
> > > > > -	if (vm_check_cap(vm, KVM_CAP_DIRTY_LOG_RING_ACQ_REL))
> > > > > -		vm_enable_cap(vm, KVM_CAP_DIRTY_LOG_RING_ACQ_REL, ring_size);
> > > > > -	else
> > > > > -		vm_enable_cap(vm, KVM_CAP_DIRTY_LOG_RING, ring_size);
> > > > > +	long cap = KVM_CAP_DIRTY_LOG_RING_ACQ_REL;
> > > > > +	int max_size = vm_check_cap(vm, cap);
> > > > > +
> > > > > +	if (!max_size) {
> > > > > +		cap = KVM_CAP_DIRTY_LOG_RING;
> > > > > +		max_size = vm_check_cap(vm, cap);
> > > > > +	}
> > > > > +
> > > > > +	TEST_ASSERT(max_size > 0,
> > > > 
> > > > Rather than open code this, which is kinda sorta going to show up in multiple
> > > > places, what if we do this as a prep patch?  Then vm_enable_dirty_ring() can use
> > > > kvm_get_dirty_ring_cap() (completely untested).
> > > 
> > > Sure, if you think it's useful :)
> > 
> > Oh, vm_check_cap() is different than kvm_has_cap()/kvm_check_cap():
> > IIUC, the vm* version will check if the extension is enabled in the current 
> > VM,
> 
> No, the VM-scoped version checks if the VM *can* support the capability in its
> current configuration, e.g. some capabilities are fundamentally incompatible with
> certain VM types.
> 
> > while the kvm* version will open a new /dev/kvm fd and check the 
> > extension there, probably meaning the CAP is available in the system.
> > 
> > So, maybe we would need a slightly different approach?
> > I.E. have the kvm_get_dirty_ring_cap() to use the VM version, and 
> > have dirty_ring_supported() to start the new /dev/kvm fd and free it later?
> > 
> > What do you think?
> 
> It's not necessary in this case.  All KVM_CHECK_EXTENSION calls feed into
> kvm_vm_ioctl_check_extension_generic(), the only difference is that the @kvm
> pointer will be NULL when called on /dev/kvm.  While some capabilities do behave
> differently if @kvm is valid, the majority do not, including the dirty ring ones:
> 
> 	case KVM_CAP_DIRTY_LOG_RING:
> #ifdef CONFIG_HAVE_KVM_DIRTY_RING_TSO
> 		return KVM_DIRTY_RING_MAX_ENTRIES * sizeof(struct kvm_dirty_gfn);
> #else
> 		return 0;
> #endif
> 	case KVM_CAP_DIRTY_LOG_RING_ACQ_REL:
> #ifdef CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL
> 		return KVM_DIRTY_RING_MAX_ENTRIES * sizeof(struct kvm_dirty_gfn);
> #else
> 		return 0;
> #endif
> 
> I.e. the VM version and /dev/kvm version will always yield the same result.  Very
> theoretically that could change, but it's unlikely.  And we can always update
> KVM selftests in the unlikely case a specific VM type comes along that doesn't
> support the dirty ring even when the broader architectures does.

All right then, thanks!
Leo
