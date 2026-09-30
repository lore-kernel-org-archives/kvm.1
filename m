Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3653A4ABBA5
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800288; cv=none; b=j6sAPAM4MUoQjXxxwmOslXSYNYZEcn885+287nm6otPd+Le1Ru8n+ON8CkNfiRopo/KeJR/d7DkYzONNwwyMBWw01cPhIaIIQVm6eMaxLcA2rL0sbnRVfeBlMNlz9yHBDCUAl9VTQmRkTJFL4pF42MjCC8t9ijKDmlvFvPGmH5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800288; c=relaxed/simple;
	bh=LJ2FwQpwObWh271AdoFSJE+GxXItZd5CsHQDkzEL0JM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a8jJmP15DE6wZjOXfhS8hmWt7zJFD0Rgia+ACd2kBISz5pSQewNOMUq1unBFpts4tYydj+TYS11d0gdzVg9pavW+iYDBcwHz4WTnp+ZYF+WvilNdCVVrZ8E70cQ7/mlTfxRzaucXF/t0J0oBNFDPzPqM7ibH8M13EmUL3DjD2ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BDoGZRHc; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BDoGZRHc"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e2dc7312e5so11616335ad.1
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 13:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790800287; x=1791405087; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cbH/iIJC3eRQ5JnQest1F4rR/Bil/2nGEuST9AeVkzY=;
        b=BDoGZRHcVIocnuqYEz/RkAiJnU7/2n7JD2ocZxBDGLvF7SLGjZ2exMsDeyC+wkgXdX
         R651CFqbv5Zk6C9yFot2WIX7aMnrVGLiTPHY8t04AH9Wvq0TGgnKBX/aAjlPzCUuibTR
         tY36h2VY1cAv1pnK0jLU67lLWLQfYLAlTzDhlO4Gy2RdRhc46I7ZDs64nJtr7XSgci+T
         LMyaNpghrPeVEsqe1dUVhzovGgJLpujczwUJlUn2N0kHmNt/8bu6x8c+WYxVR8HhxgZ+
         8wSrbROV/M942dlpc30oQAqeR1UGDsppiABaCTJw7i50MMdz/mGdFS6D/qabxe+IyNp5
         C3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790800287; x=1791405087;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cbH/iIJC3eRQ5JnQest1F4rR/Bil/2nGEuST9AeVkzY=;
        b=c9oLYVQY4k5N5NYAz11p8+DAG795OErHMK7DQmdCyyqmwf4G/0ztvan52eVKxEE4XV
         6CrYXOB9xzvn5hNRSc4tp0bv4ooshMVVDF9qLVSR/kO4J//jLSFxHGjU49enZk7g9bRI
         fls3Rdklzs6DjVKOpno0CbL1SQJ5oXBcrk4mjXy6uko523cQCh9KEXaOiaqg3vJIXSR9
         CmM+FXYoOUMCRntzsDGOq06ighL6X3NHKe9hAgQm6MyahEjkSUF6l1BeJd/vdR0fSqxp
         eZ7lv6ouyNrnoRJKDwyyGA6VzTVEOG6LjED8WP+kZ/7Utg/AiRq7ksqo8rYbv190amrl
         1ggA==
X-Forwarded-Encrypted: i=1; AKwUvByZJZbSY4qwHnjTdu92Qm4TRUtLI8wu162Fh4z0y5ey3512nvpXRTWfRP7ezv2PCh7QhN8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIy6IH+grhLn0mj/CpXM/odzw0I799N5KhxUcz3hFxdwvQVnyFE
	KM9vioGhnna2vYcF6dWKIC79NfCdyLXf8DZyfHt8ueh8Ws92kUlcCmhWYntvOCfey9osxzJ8gUr
	mHRQv8w==
X-Received: from pllk3.prod.google.com ([2002:a17:902:7603:b0:2df:80bc:73c7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e54d:b0:2dd:b83b:fe1e
 with SMTP id d9443c01a7336-2e2e4a299a3mr18780185ad.22.1790800286226; Wed, 30
 Sep 2026 13:31:26 -0700 (PDT)
Date: Wed, 30 Sep 2026 13:31:25 -0700
In-Reply-To: <20260929113711.2064390-3-leo.bras@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929113711.2064390-1-leo.bras@arm.com> <20260929113711.2064390-3-leo.bras@arm.com>
Message-ID: <ar1xne00AHnJ-p_d@google.com>
Subject: Re: [PATCH v1 2/3] KVM: selftests: Check dirty-ring size before enabling
From: Sean Christopherson <seanjc@google.com>
To: Leonardo Bras <leo.bras@arm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	David Matlack <dmatlack@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Marc Zyngier <maz@kernel.org>, Josh Hilke <jrhilke@google.com>, Oliver Upton <oupton@kernel.org>, 
	Wu Fei <wu.fei9@sanechips.com.cn>, Steffen Eiden <seiden@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 29, 2026, Leonardo Bras wrote:
> As of today, trying to enable dirty-ring with a size bigger than the
> maximum will return an "argument list too long" error.
> 
> Change vm_enable_dirty_ring() to get the maximum size, then compare it to
> the desired size before enabling. If the value is invalid, print a more
> precise error message.
> 
> Signed-off-by: Leonardo Bras <leo.bras@arm.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 9ddc047d5c27..15a671b71553 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -168,24 +168,37 @@ unsigned int kvm_check_cap(long cap)
>  	ret = __kvm_ioctl(kvm_fd, KVM_CHECK_EXTENSION, (void *)cap);
>  	TEST_ASSERT(ret >= 0, KVM_IOCTL_ERROR(KVM_CHECK_EXTENSION, ret));
>  
>  	kvm_free_fd(kvm_fd);
>  
>  	return (unsigned int)ret;
>  }
>  
>  void vm_enable_dirty_ring(struct kvm_vm *vm, u32 ring_size)
>  {
> -	if (vm_check_cap(vm, KVM_CAP_DIRTY_LOG_RING_ACQ_REL))
> -		vm_enable_cap(vm, KVM_CAP_DIRTY_LOG_RING_ACQ_REL, ring_size);
> -	else
> -		vm_enable_cap(vm, KVM_CAP_DIRTY_LOG_RING, ring_size);
> +	long cap = KVM_CAP_DIRTY_LOG_RING_ACQ_REL;
> +	int max_size = vm_check_cap(vm, cap);
> +
> +	if (!max_size) {
> +		cap = KVM_CAP_DIRTY_LOG_RING;
> +		max_size = vm_check_cap(vm, cap);
> +	}
> +
> +	TEST_ASSERT(max_size > 0,

Rather than open code this, which is kinda sorta going to show up in multiple
places, what if we do this as a prep patch?  Then vm_enable_dirty_ring() can use
kvm_get_dirty_ring_cap() (completely untested).

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index af5eb0334a74..558a71d631da 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -291,8 +291,7 @@ static void default_after_vcpu_run(struct kvm_vcpu *vcpu)
 
 static bool dirty_ring_supported(void)
 {
-	return (kvm_has_cap(KVM_CAP_DIRTY_LOG_RING) ||
-		kvm_has_cap(KVM_CAP_DIRTY_LOG_RING_ACQ_REL));
+	return kvm_get_dirty_ring_cap();
 }
 
 static void dirty_ring_create_vm_done(struct kvm_vm *vm)
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index e3b122719262..c08d1581221e 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -339,6 +339,17 @@ static inline bool kvm_has_cap(long cap)
 	return kvm_check_cap(cap);
 }
 
+static inline long kvm_get_dirty_ring_cap(void)
+{
+	if (kvm_has_cap(KVM_CAP_DIRTY_LOG_RING_ACQ_REL))
+		return KVM_CAP_DIRTY_LOG_RING_ACQ_REL;
+
+	if (kvm_has_cap(KVM_CAP_DIRTY_LOG_RING))
+		return KVM_CAP_DIRTY_LOG_RING;
+
+	return 0;	
+}
+
 /*
  * Use the "inner", double-underscore macro when reporting errors from within
  * other macros so that the name of ioctl() and not its literal numeric value


> "Dirty-ring not supported in this kernel\n");

"this kernel" could be misleading, some architectures simply don't support the
dirty ring.

> +	TEST_ASSERT(ring_size <= max_size && is_power_of_2(ring_size) &&
> +		    ring_size >= getpagesize(),
> +		    "Invalid dirty-ring size: Should be a power of two "
> +		    "between %lu and %lu entries\n",

Don't wrap strings.  The "Invalid dirty-ring size:" part is redudant with the
expressions, just drop that to shorten things.  This should also spit out the
requested ring_size.  Stating the range as a number of entries is also confusing;
as a debugger, I don't want to have to go look at the size of kvm_dirty_gfn to
understand why ring_size is invalid.

And maybe split up the asserts?  If the goal is to make it easier for developers
to know when they messed up, might as well make it as easy as possible.  E.g.
leaning on the above diff, something like this?

	long cap = kvm_get_dirty_ring_cap();

	TEST_ASSERT(cap, "Dirty-ring not supported");

	TEST_ASSERT(is_power_of_2(ring_size),
		    "Dirty-ring size '0x%x' must be a power-of-2", ring_size);
	TEST_ASSERT(ring_size >= getpagesize(),
		    "Dirty-ring size '0x%x' must be at least one (host) page", ring_size);
	TEST_ASSERT(ring_size >= vm_check_cap(vm, cap),
		    "Dirty-ring size '0x%x' is larger than KVM's limit of '0x%x'",
		    ring_size, vm_check_cap(vm, cap));

	vm_enable_cap(vm, cap, ring_size);
	vm->dirty_ring_size = ring_size;

> +		    getpagesize() / sizeof(struct kvm_dirty_gfn),
> +		    max_size / sizeof(struct kvm_dirty_gfn));
> +
> +	vm_enable_cap(vm, cap, ring_size);
>  	vm->dirty_ring_size = ring_size;
>  }
>  
>  static void vm_open(struct kvm_vm *vm)
>  {
>  	vm->kvm_fd = _open_kvm_dev_path_or_exit(O_RDWR);
>  
>  	TEST_REQUIRE(kvm_has_cap(KVM_CAP_IMMEDIATE_EXIT));
>  
>  	vm->fd = __kvm_ioctl(vm->kvm_fd, KVM_CREATE_VM, (void *)vm->type);
> -- 
> 2.55.0
> 
