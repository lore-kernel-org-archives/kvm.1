Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D1A1C695
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775036162; cv=none; b=plKsjYPhy8BfhbUr/b9eFCW+wDHmnuAAs//IuZK/0QU9tfyUe4NYIdy11HwnAkYGCmPJtQsz99j07EphnmodFup1Gjhd/AnkWRf5TOzBfZbroq9h6H8EE65Ns3d9eZkTAQE7D8S2rYeTHkxBc3EI26ED16Cal8B7p8VKqyvQPEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775036162; c=relaxed/simple;
	bh=4V/FW6fK6X5i2m7UgvuVEcz+vvW5eTftn0cz50oh42M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2vvz5Dwe9HKjCCoY+2qZzx7h/FYH6BfUuXvkgJVTMVtWC0zemtAHSexJbXFCRMKGCZC1RW8SBoZGdsSCgyNdyCFGzILQLI1JMiDOoJyyOThrVPNzDmj20Whlx341Hva/LqJMrd5BziTCmtb8Js0Z8IByLme9xBxZ3QittxvBjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TXW42sFa; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TXW42sFa"
Message-ID: <5194cf52-f8a8-4479-a95e-233104272839@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775036148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FA42hI52ujEO2ZvjmTzgrIggej28Ooo69DQnS/txLtU=;
	b=TXW42sFanZADGvoENLxUoMiviEyVXa/layMETVbX2HzYh8Zzks5ZKL0I1bfuc9Htc6+z49
	/VRnEfpdy+FW/jSiFaU0w2cU2YzBsQRAv94FnzJZK8TLfiCKY2VLkSpxjcHVd/gPxbDGPr
	+voT42sxaqnWmYyBHl2PgXLZBVxuyHI=
Date: Wed, 1 Apr 2026 17:34:58 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] KVM: irqfd: fix deadlock by moving synchronize_srcu
 out of resampler_lock
To: Sonam Sanju <sonam.sanju@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Vineeth Pillai <vineeth@bitbyteword.org>, Sonam Sanju
 <sonam.sanju@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Vineeth Pillai <vineeth@bitbyteword.org>
Cc: Dmitry Maluka <dmaluka@chromium.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260323053353.805336-1-sonam.sanju@intel.com>
 <20260323064248.1660757-1-sonam.sanju@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <20260323064248.1660757-1-sonam.sanju@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/23/26 14:42, Sonam Sanju wrote:
> irqfd_resampler_shutdown() and kvm_irqfd_assign() both call
> synchronize_srcu_expedited() while holding kvm->irqfds.resampler_lock.
> This can deadlock when multiple irqfd workers run concurrently on the
> kvm-irqfd-cleanup workqueue during VM teardown or when VMs are rapidly
> created and destroyed:
>
>   CPU A (mutex holder)               CPU B/C/D (mutex waiters)
>   irqfd_shutdown()                   irqfd_shutdown() / kvm_irqfd_assign()
>    irqfd_resampler_shutdown()         irqfd_resampler_shutdown()
>     mutex_lock(resampler_lock)  <---- mutex_lock(resampler_lock) //BLOCKED
>     list_del_rcu(...)                     ...blocked...
>     synchronize_srcu_expedited()      // Waiters block workqueue,
>       // waits for SRCU grace            preventing SRCU grace
>       // period which requires            period from completing
>       // workqueue progress          --- DEADLOCK ---
>
> In irqfd_resampler_shutdown(), the synchronize_srcu_expedited() in
> the else branch is called directly within the mutex.  In the if-last
> branch, kvm_unregister_irq_ack_notifier() also calls
> synchronize_srcu_expedited() internally.  In kvm_irqfd_assign(),
> synchronize_srcu_expedited() is called after list_add_rcu() but
> before mutex_unlock().  All paths can block indefinitely because:
>
>   1. synchronize_srcu_expedited() waits for an SRCU grace period
>   2. SRCU grace period completion needs workqueue workers to run
>   3. The blocked mutex waiters occupy workqueue slots preventing progress
>   4. The mutex holder never releases the lock -> deadlock
>
> Fix both paths by releasing the mutex before calling
> synchronize_srcu_expedited().
>
> In irqfd_resampler_shutdown(), use a bool last flag to track whether
> this is the final irqfd for the resampler, then release the mutex
> before the SRCU synchronization.  This is safe because list_del_rcu()
> already removed the entries under the mutex, and
> kvm_unregister_irq_ack_notifier() uses its own locking (kvm->irq_lock).
>
> In kvm_irqfd_assign(), simply move synchronize_srcu_expedited() after
> mutex_unlock().  The SRCU grace period still completes before the irqfd
> goes live (the subsequent srcu_read_lock() ensures ordering).
>
> Signed-off-by: Sonam Sanju <sonam.sanju@intel.com>
> ---
> v2:
>  - Fix the same deadlock in kvm_irqfd_assign() (Vineeth Pillai)
>
>  virt/kvm/eventfd.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index 0e8b8a2c5b79..8ae9f81f8bb3 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -93,6 +93,7 @@ irqfd_resampler_shutdown(struct kvm_kernel_irqfd *irqfd)
>  {
>  	struct kvm_kernel_irqfd_resampler *resampler = irqfd->resampler;
>  	struct kvm *kvm = resampler->kvm;
> +	bool last = false;
>  
>  	mutex_lock(&kvm->irqfds.resampler_lock);
>  
> @@ -100,19 +101,27 @@ irqfd_resampler_shutdown(struct kvm_kernel_irqfd *irqfd)
>  
>  	if (list_empty(&resampler->list)) {
>  		list_del_rcu(&resampler->link);
> +		last = true;
> +	}
> +
> +	mutex_unlock(&kvm->irqfds.resampler_lock);
> +
> +	/*
> +	 * synchronize_srcu_expedited() (called explicitly below, or internally
> +	 * by kvm_unregister_irq_ack_notifier()) must not be invoked under
> +	 * resampler_lock.  Holding the mutex while waiting for an SRCU grace
> +	 * period creates a deadlock: the blocked mutex waiters occupy workqueue
> +	 * slots that the SRCU grace period machinery needs to make forward
> +	 * progress.
> +	 */
> +	if (last) {
>  		kvm_unregister_irq_ack_notifier(kvm, &resampler->notifier);
> -		/*
> -		 * synchronize_srcu_expedited(&kvm->irq_srcu) already called
> -		 * in kvm_unregister_irq_ack_notifier().
> -		 */
>  		kvm_set_irq(kvm, KVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID,
>  			    resampler->notifier.gsi, 0, false);
>  		kfree(resampler);
>  	} else {
>  		synchronize_srcu_expedited(&kvm->irq_srcu);
>  	}
> -
> -	mutex_unlock(&kvm->irqfds.resampler_lock);
>  }
>  
>  /*
> @@ -450,9 +459,16 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
>  		}
>  
>  		list_add_rcu(&irqfd->resampler_link, &irqfd->resampler->list);
> -		synchronize_srcu_expedited(&kvm->irq_srcu);
>  
>  		mutex_unlock(&kvm->irqfds.resampler_lock);
> +
> +		/*
> +		 * Ensure the resampler_link is SRCU-visible before the irqfd
> +		 * itself goes live.  Moving synchronize_srcu_expedited() outside
> +		 * the resampler_lock avoids deadlock with shutdown workers waiting
> +		 * for the mutex while SRCU waits for workqueue progress.
> +		 */
> +		synchronize_srcu_expedited(&kvm->irq_srcu);
>  	}
>  
>  	/*

Building on the discussion so far, it would be helpful from the SRCU
side to gather a bit more evidence to classify the issue.

Calling synchronize_srcu_expedited() while holding a mutex is generally
valid, so the observed behavior may be workload-dependent.

The reported deadlock seems to rely on the assumption that SRCU grace
period progress is indirectly blocked by irqfd workqueue saturation.
It would be good to confirm whether that assumption actually holds.

In particular:

1) Are SRCU GP kthreads/workers still making forward progress when
the system is stuck?

2) How many irqfd workers are active in the reported scenario, and
can they saturate CPU or worker pools?

3) Do we have a concrete wait-for cycle showing that tasks blocked
on resampler_lock are in turn preventing SRCU GP completion?

4) Is the behavior reproducible in both irqfd_resampler_shutdown()
and kvm_irqfd_assign() paths?

If SRCU GP remains independent, it would help distinguish whether
this is a strict deadlock or a form of workqueue starvation / lock
contention.

A timestamp-correlated dump (blocked stacks + workqueue state +
SRCU GP activity) would likely be sufficient to classify this.

Happy to help look at traces if available.

Thanx, Kunwu

