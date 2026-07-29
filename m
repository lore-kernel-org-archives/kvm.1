Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF3043CEE9
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314702; cv=none; b=s9RQrhcN+dKAj3DqMUp6L61iWKRppG3EUoo0Fs4XPNSat+OZrT9Th2iNp/iPhUvxgRpyDz7ldpo6GEMdjCDaLW5Z+zoIOR9T8jvHC6uuppdETBktqA4ooW2OpiyHOkTL1NzVeTQt9Q0Hpxi5wjgB/82hTSIiYkZxAvguVndC0Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314702; c=relaxed/simple;
	bh=yIw6OKboj0oYZ4wBCF+AvbEyU5EHbzJU0A0UnfBUyxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw/bHM+eZfumMbmQ7YkZjerY68QFNpoOcf205tdayUWEIPoycJOZ4rIQ43snkmwfGk4NHTO3N/EhXGTYJfMFjrsJq2/CMucbza75K5W0t2Yr0Ay7ux9dYjtlxD2TRAzHwWaj5W3n0M+IZl5MENEq4/p4QXjJNSvCbbAAhPjFVjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YQcR/QHG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YQcR/QHG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8A51F000E9;
	Wed, 29 Jul 2026 08:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785314700;
	bh=D0CluIGc1MVu89QcquHLZ/G/m76BWe29aW2jG65T4pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YQcR/QHGSnsEURic9iO4rpfgSpZLgQHaO7nqi29hGP04hwld3n0v4VkrB9yduZs4X
	 WBGk3lpCOh7oq5F0Y2tcBwISt3hlJvWf3Pvg+MgIOcSXbQTo+0Jwlxxk0YQehqj/6R
	 gzZiY7NQ+WAvtvd8FzZIk5xx8XHbX3NTghgp9ckY=
Date: Wed, 29 Jul 2026 10:44:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: anup@brainfault.org, atish.patra@linux.dev, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	security@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Synchronize hrtimer callback during teardown
Message-ID: <2026072959-penpal-petroleum-bf6e@gregkh>
References: <CAGEsz8GNHFCOZ=-_y56rK1aX+Ze7w8qVqZSQ-OuGo_dPC4bXCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGEsz8GNHFCOZ=-_y56rK1aX+Ze7w8qVqZSQ-OuGo_dPC4bXCw@mail.gmail.com>

On Wed, Jul 29, 2026 at 01:42:24AM +0900, Myeonghun Pak wrote:
> The non-Sstc hrtimer callback clears next_set before its final uses of
> the enclosing vCPU.  If teardown observes next_set as false while the
> callback is still running, kvm_riscv_vcpu_timer_cancel() skips
> hrtimer_cancel() and kvm_destroy_vcpus() can free the vCPU before the
> callback enters kvm_riscv_vcpu_set_interrupt().
> 
> A guest can arm the timer with SBI TIME and request shutdown with SBI
> legacy shutdown or SRST.  A VMM that honors KVM_EXIT_SYSTEM_EVENT and
> destroys the VM supplies the teardown side of the race; no post-launch
> host ioctl is needed to arm or request teardown.
> 
> On upstream master 62cc90241548, generic KASAN reported:
> 
>   BUG: KASAN: slab-use-after-free in do_raw_spin_lock
>   Write of size 4 at addr ff60000005e58898
> 
>   kvm_riscv_vcpu_set_interrupt
>   kvm_riscv_vcpu_hrtimer_expired
>   __hrtimer_run_queues
>   hrtimer_interrupt
> 
> The object was allocated by KVM_CREATE_VCPU and freed concurrently by:
> 
>   kvm_destroy_vcpus
>   kvm_arch_destroy_vm
>   kvm_destroy_vm
>   __fput
> 
> For deterministic validation, I added mdelay(1000) immediately after
> the existing next_set = false assignment.  This only widens the
> existing post-clear callback window.  A no-delay trace build naturally
> reached the callback-after-teardown-start/before-deinit ordering in 12
> of 200 runs, but 1,500 stock-kernel stress iterations did not produce a
> KASAN report, so natural reproduction is timing-sensitive.
> 
> Always invoke hrtimer_cancel() for an initialized timer.  Preserve the
> existing -EINVAL result when the timer is no longer set, but only after
> synchronizing with a running callback.
> 
> With this patch, hrtimer_cancel() blocked for the full widened callback
> window before vCPU destruction.  KASAN reported no error in 100
> fixed-and-widened runs or 200 fix-only timing-sweep runs.
> 
> Fixes: 3a9f66cb25e1 ("RISC-V: KVM: Add timer functionality")
> Cc: stable@vger.kernel.org
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  arch/riscv/kvm/vcpu_timer.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> AI disclosure: I used AI assistance during the audit and am treating the
> issue as public as required by Documentation/process/security-bugs.rst.
> The reproducer and full KASAN trace have not been posted publicly and
> are available on request.

Then don't you need to add an "Assisted-by:" line to your patch?

And as you posted this publicly, no need to cc: security@kernel.org.

thanks,

greg k-h
