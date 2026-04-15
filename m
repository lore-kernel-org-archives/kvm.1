Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592B6199FAB
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265753; cv=none; b=irBiEm9vu9Lf+VnHjrIoPvU/Bc/4DabcX2h2tqhuVGlY0+fOhGtMeufUT2U8qnrQ2Q03+A3EcvvLmbOfcvM+7UOYdqvh+OVY2G22GA65hlB6CNVAyKVWuq9M7YoFSKkzdO1t2Sxy8lPLfI2rTCZKeoysShZU8DzvURbRfTSbQ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265753; c=relaxed/simple;
	bh=ljVeei6DMsz6nzfdao3nHxblLqi1rjyRizXz36J4w6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTEHCNQBhZKalMAK2k+P1eCztYYH3342r1aU97KLTi66AZ+t2CGnT/suwPdTQbyT2l8wSLfsntBMwALTL9iDfsSBUtMt5mmmFqfsjs+dKcoVWJhCymz00GznIQxZmX8Te/RkA6BMe+11K5DUWi9urZrmmFU3Bcm92JCd7/7g3PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kfffJOx8; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kfffJOx8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776265749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTbY8XYoOMeANO+YssI33JYga8YW2EPuDPwZbcUAWPk=;
	b=kfffJOx8g7JzNZwe9Fiqdzaa6C6hGPqjhhrXVRjHDnF8Ra3s2/OdzCkJzg72YQimCBXAfI
	sL8ZbD4ggGqW/rEAomv9YVvV8fxRck5UOZVgMZnXyXHjYUskEOUghCCpQ0UJoJkQQpFMR+
	/4fm+CMCquFDmFEyMWl5/YxhxkBfhEE=
From: Usama Arif <usama.arif@linux.dev>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [RFC, PATCH 10/12] userfaultfd: add UFFDIO_SET_MODE for runtime sync/async toggle
Date: Wed, 15 Apr 2026 08:08:59 -0700
Message-ID: <20260415150900.3660575-1-usama.arif@linux.dev>
In-Reply-To: <20260414142354.1465950-11-kas@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Tue, 14 Apr 2026 15:23:44 +0100 "Kiryl Shutsemau (Meta)" <kas@kernel.org> wrote:

> Add UFFDIO_SET_MODE ioctl to toggle UFFD_FEATURE_MINOR_ASYNC at
> runtime. Takes mmap_write_lock for serialization against all in-flight
> faults. On sync-to-async transition, wake threads blocked in
> handle_userfault() so they retry and auto-resolve.
> 
> Since ctx->features can now be modified concurrently, add
> userfaultfd_features() helper that wraps READ_ONCE() and convert
> all ctx->features reads to use it.
> 
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Assisted-by: Claude:claude-opus-4-6
> ---
>  fs/userfaultfd.c                 | 95 ++++++++++++++++++++++++++++----
>  include/uapi/linux/userfaultfd.h | 13 +++++
>  2 files changed, 96 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 43064238fd8d..0edb33599491 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -79,24 +79,33 @@ struct userfaultfd_wake_range {
>  /* internal indication that UFFD_API ioctl was successfully executed */
>  #define UFFD_FEATURE_INITIALIZED		(1u << 31)
>  
> +/*
> + * Read ctx->features with READ_ONCE() since UFFDIO_SET_MODE can
> + * modify it concurrently.
> + */
> +static unsigned int userfaultfd_features(struct userfaultfd_ctx *ctx)
> +{
> +	return READ_ONCE(ctx->features);
> +}
> +
>  static bool userfaultfd_is_initialized(struct userfaultfd_ctx *ctx)
>  {
> -	return ctx->features & UFFD_FEATURE_INITIALIZED;
> +	return userfaultfd_features(ctx) & UFFD_FEATURE_INITIALIZED;
>  }
>  
>  static bool userfaultfd_wp_async_ctx(struct userfaultfd_ctx *ctx)
>  {
> -	return ctx && (ctx->features & UFFD_FEATURE_WP_ASYNC);
> +	return ctx && (userfaultfd_features(ctx) & UFFD_FEATURE_WP_ASYNC);
>  }
>  
>  static bool userfaultfd_minor_anon_ctx(struct userfaultfd_ctx *ctx)
>  {
> -	return ctx && (ctx->features & UFFD_FEATURE_MINOR_ANON);
> +	return ctx && (userfaultfd_features(ctx) & UFFD_FEATURE_MINOR_ANON);
>  }
>  
>  static bool userfaultfd_minor_async_ctx(struct userfaultfd_ctx *ctx)
>  {
> -	return ctx && (ctx->features & UFFD_FEATURE_MINOR_ASYNC);
> +	return ctx && (userfaultfd_features(ctx) & UFFD_FEATURE_MINOR_ASYNC);
>  }
>  
>  static unsigned int userfaultfd_ctx_flags(struct userfaultfd_ctx *ctx)
> @@ -122,7 +131,7 @@ bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma)
>  	if (!ctx)
>  		return false;
>  
> -	return ctx->features & UFFD_FEATURE_WP_UNPOPULATED;
> +	return userfaultfd_features(ctx) & UFFD_FEATURE_WP_UNPOPULATED;
>  }
>  
>  static int userfaultfd_wake_function(wait_queue_entry_t *wq, unsigned mode,
> @@ -435,7 +444,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>  	/* 0 or > 1 flags set is a bug; we expect exactly 1. */
>  	VM_WARN_ON_ONCE(!reason || (reason & (reason - 1)));
>  
> -	if (ctx->features & UFFD_FEATURE_SIGBUS)
> +	if (userfaultfd_features(ctx) & UFFD_FEATURE_SIGBUS)
>  		goto out;
>  	if (!(vmf->flags & FAULT_FLAG_USER) && (ctx->flags & UFFD_USER_MODE_ONLY))
>  		goto out;
> @@ -506,7 +515,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>  	init_waitqueue_func_entry(&uwq.wq, userfaultfd_wake_function);
>  	uwq.wq.private = current;
>  	uwq.msg = userfault_msg(vmf->address, vmf->real_address, vmf->flags,
> -				reason, ctx->features);
> +				reason, userfaultfd_features(ctx));
>  	uwq.ctx = ctx;
>  	uwq.waken = false;
>  
> @@ -668,7 +677,7 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
>  	if (!octx)
>  		return 0;
>  
> -	if (!(octx->features & UFFD_FEATURE_EVENT_FORK)) {
> +	if (!(userfaultfd_features(octx) & UFFD_FEATURE_EVENT_FORK)) {
>  		userfaultfd_reset_ctx(vma);
>  		return 0;
>  	}
> @@ -774,7 +783,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
>  	if (!ctx)
>  		return;
>  
> -	if (ctx->features & UFFD_FEATURE_EVENT_REMAP) {
> +	if (userfaultfd_features(ctx) & UFFD_FEATURE_EVENT_REMAP) {
>  		vm_ctx->ctx = ctx;
>  		userfaultfd_ctx_get(ctx);
>  		down_write(&ctx->map_changing_lock);
> @@ -824,7 +833,7 @@ bool userfaultfd_remove(struct vm_area_struct *vma,
>  	struct userfaultfd_wait_queue ewq;
>  
>  	ctx = vma->vm_userfaultfd_ctx.ctx;
> -	if (!ctx || !(ctx->features & UFFD_FEATURE_EVENT_REMOVE))
> +	if (!ctx || !(userfaultfd_features(ctx) & UFFD_FEATURE_EVENT_REMOVE))
>  		return true;
>  
>  	userfaultfd_ctx_get(ctx);
> @@ -863,7 +872,7 @@ int userfaultfd_unmap_prep(struct vm_area_struct *vma, unsigned long start,
>  	struct userfaultfd_unmap_ctx *unmap_ctx;
>  	struct userfaultfd_ctx *ctx = vma->vm_userfaultfd_ctx.ctx;
>  
> -	if (!ctx || !(ctx->features & UFFD_FEATURE_EVENT_UNMAP) ||
> +	if (!ctx || !(userfaultfd_features(ctx) & UFFD_FEATURE_EVENT_UNMAP) ||
>  	    has_unmap_ctx(ctx, unmaps, start, end))
>  		return 0;
>  
> @@ -1826,6 +1835,65 @@ static int userfaultfd_deactivate(struct userfaultfd_ctx *ctx,
>  	return ret;
>  }
>  
> +/*
> + * Features that can be toggled at runtime via UFFDIO_SET_MODE.
> + * Only async features that were enabled at UFFDIO_API time may be toggled.
> + */
> +#define UFFD_FEATURE_TOGGLEABLE	(UFFD_FEATURE_MINOR_ASYNC)
> +
> +static int userfaultfd_set_mode(struct userfaultfd_ctx *ctx,
> +				  unsigned long arg)
> +{
> +	struct uffdio_set_mode mode;
> +	struct mm_struct *mm = ctx->mm;
> +
> +	if (copy_from_user(&mode, (void __user *)arg, sizeof(mode)))
> +		return -EFAULT;
> +
> +	/* enable and disable must not overlap */
> +	if (mode.enable & mode.disable)
> +		return -EINVAL;
> +
> +	/* only toggleable features are allowed */
> +	if ((mode.enable | mode.disable) & ~UFFD_FEATURE_TOGGLEABLE)
> +		return -EINVAL;

The commit message states "Only async features that were enabled at
UFFDIO_API time may be toggled."  However, the code only checks that
the requested feature is in UFFD_FEATURE_TOGGLEABLE.

Is it intentional that a user who opened a uffd without
UFFD_FEATURE_MINOR_ASYNC can still enable it later via
UFFDIO_SET_MODE? 

> +
> +	if (!mmget_not_zero(mm))
> +		return -ESRCH;
> +
> +	/*
> +	 * mmap_write_lock serializes against all page faults.
> +	 * After we release, no in-flight faults from the old mode exist.
> +	 */
> +	{
> +		unsigned int new_features;
> +
> +		mmap_write_lock(mm);
> +		new_features = userfaultfd_features(ctx);
> +		new_features |= mode.enable;
> +		new_features &= ~mode.disable;
> +		WRITE_ONCE(ctx->features, new_features);
> +		mmap_write_unlock(mm);
> +	}
> +
> +	/*
> +	 * If switching to async, wake threads blocked in handle_userfault().
> +	 * They will retry the fault and auto-resolve under the new mode.
> +	 * len=0 means wake all pending faults on this context.
> +	 */
> +	if (mode.enable & UFFD_FEATURE_MINOR_ASYNC) {
> +		struct userfaultfd_wake_range range = { .len = 0 };
> +
> +		spin_lock_irq(&ctx->fault_pending_wqh.lock);
> +		__wake_up_locked_key(&ctx->fault_pending_wqh, TASK_NORMAL,
> +				     &range);
> +		__wake_up(&ctx->fault_wqh, TASK_NORMAL, 1, &range);
> +		spin_unlock_irq(&ctx->fault_pending_wqh.lock);
> +	}
> +
> +	mmput(mm);
> +	return 0;
> +}
>  
>  static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
>  {
> @@ -2150,6 +2218,9 @@ static long userfaultfd_ioctl(struct file *file, unsigned cmd,
>  	case UFFDIO_DEACTIVATE:
>  		ret = userfaultfd_deactivate(ctx, arg);
>  		break;
> +	case UFFDIO_SET_MODE:
> +		ret = userfaultfd_set_mode(ctx, arg);
> +		break;
>  	}
>  	return ret;
>  }
> @@ -2177,7 +2248,7 @@ static void userfaultfd_show_fdinfo(struct seq_file *m, struct file *f)
>  	 *	protocols: aa:... bb:...
>  	 */
>  	seq_printf(m, "pending:\t%lu\ntotal:\t%lu\nAPI:\t%Lx:%x:%Lx\n",
> -		   pending, total, UFFD_API, ctx->features,
> +		   pending, total, UFFD_API, userfaultfd_features(ctx),
>  		   UFFD_API_IOCTLS|UFFD_API_RANGE_IOCTLS);
>  }
>  #endif
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> index 775825da2596..f0f14f9db06c 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -84,6 +84,7 @@
>  #define _UFFDIO_CONTINUE		(0x07)
>  #define _UFFDIO_POISON			(0x08)
>  #define _UFFDIO_DEACTIVATE		(0x09)
> +#define _UFFDIO_SET_MODE		(0x0A)
>  #define _UFFDIO_API			(0x3F)
>  
>  /* userfaultfd ioctl ids */
> @@ -110,6 +111,8 @@
>  				      struct uffdio_poison)
>  #define UFFDIO_DEACTIVATE	_IOR(UFFDIO, _UFFDIO_DEACTIVATE,	\
>  				     struct uffdio_range)
> +#define UFFDIO_SET_MODE		_IOW(UFFDIO, _UFFDIO_SET_MODE,	\
> +				     struct uffdio_set_mode)
>  
>  /* read() structure */
>  struct uffd_msg {
> @@ -395,6 +398,16 @@ struct uffdio_move {
>  	__s64 move;
>  };
>  
> +struct uffdio_set_mode {
> +	/*
> +	 * Toggle async mode for features at runtime.
> +	 * Supported: UFFD_FEATURE_MINOR_ASYNC.
> +	 * Setting a bit in both enable and disable is invalid.
> +	 */
> +	__u64 enable;
> +	__u64 disable;
> +};
> +
>  /*
>   * Flags for the userfaultfd(2) system call itself.
>   */
> -- 
> 2.51.2
> 
> 
