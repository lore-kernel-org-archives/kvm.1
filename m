Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF88126E706
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775076951; cv=none; b=maHYOq1O8GJlrSIGDwCeAxf5KArGl7UAGgkuJNGHoARA5X8+mpSjDTY24rGuq7DyEO4URgDRPPJw7f47IT+dvrTdvxkcxGWNfdDs23QiZ+UVZVMmcH5/kSn3kvjDVSaNj8RoaUs5l4683ntt2G5XUTVJt7aPt6KrmO44OC88FCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775076951; c=relaxed/simple;
	bh=NpvwDk23uIaHCeK3yVRCiuJ3r9ceunuwiGrGOwiH+jA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V2wlMA1GM+Txwq31fVpOgDvgty3HPvXynsj0xOcjO6JTw+BzA/QMQNFQ/+PxbQeROfjzoxEpcsKn0T7yMFiz22MEpNJCKb7Ef6UDkvQ+mGN85Uhdn8KIyZqEAH6LARC7PynXGXt7E9zjCATyFlWI6ItlK6mQozXi62rEtnSkVDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A/PT21FM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/PT21FM"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82a855dc82aso93486b3a.2
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 13:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775076948; x=1775681748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PBu0DbYuV4o+iB7UUEswME7tXh/PWT1UOPPFS4CrV84=;
        b=A/PT21FM2tYilbztwGIy8WJlHNVgNPtlvaU9A1LzsfYy5KDesoTtZ8Bq8b1VrD0sJn
         vnGKtKs2gCWt9UhRBG97Hxij7FcFLNB9gopJ+HVSDbztGWkhxCMvp/aL4ohphBLUZyk1
         0BHz1V8AlMrmHwYVCMhJ5lcpqVnhaVZ775cc/x9syUrzf8hRkb6BKpQAArIU6g+wuDBW
         3ZLIpRR+ZYAn40o7BjvLYzNzBLzZPbZqxCahmMWuWWjvqcANOKBZvP5Krxxp4Iniv7h7
         Dg3Q/ewKMFHS0ijBTYndz4FW0657o7QU/q/Jh91yQODdjVfon2AchbpvLTs8bOxhYqA9
         xraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775076948; x=1775681748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBu0DbYuV4o+iB7UUEswME7tXh/PWT1UOPPFS4CrV84=;
        b=VtFVRvAK1B2CULDN4F3sNAT6wetVnl7PipciwKFQ9OCDYPnJOT4pJJKHXhBXjurbOq
         w7CkbgXdOwx749xCPLPQ6QRgdy5+hEe7uePsYB9E5nY2479zjxdGH3CTseUgWQxSUoRs
         pZwe9Yj06Fk47+agfiO7tmHUZzudFuKXmzHy34Ge+0zbRxYWq/IGNpGjF4a0tZS1A10G
         AeFiVU58gB/zJA0wFuRdjenAVDzFXy9MV9HVcxS5X0pKf/h8H0rEDOfMytCPytzKQiJO
         ItZV9dKcpnwOOajo1zw5/kanNe28rm0kjBt/4+ucRfnlPX4pn5A3e5MdZxt3mwAlx4HL
         CfHw==
X-Forwarded-Encrypted: i=1; AJvYcCWZy6NPcO7yZW45mP1Z7xDRNAG/mFAMK0GlV8bupe/lWE7qzXQm2fPLaQ7xpfXguTodM4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwABAZbgSFSyQbxZjjAxNfL5tZT6QsZrcCTWrw+/IZJyp7jiP3I
	kubxRR/DlEGGlrH6p37uHIFAHdiekzFtT/AT9xAbFapI0fxWtlR4Er0fByCETGEJircFLzABPu+
	h4ybsiQ==
X-Received: from pfde18.prod.google.com ([2002:aa7:8c52:0:b0:829:9f63:c89a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:22d4:b0:82c:da94:eb54
 with SMTP id d2e1a72fcca58-82ce8ae4c35mr5489486b3a.27.1775076948423; Wed, 01
 Apr 2026 13:55:48 -0700 (PDT)
Date: Wed, 1 Apr 2026 13:55:47 -0700
In-Reply-To: <20260331194033.3890309-12-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com> <20260331194033.3890309-12-jrhilke@google.com>
Message-ID: <ac2GU_u3tzyTIcls@google.com>
Subject: Re: [PATCH v2 11/14] KVM: selftests: Add support for vCPU pinning
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 31, 2026, Josh Hilke wrote:
> From: David Matlack <dmatlack@google.com>
> 
> Add the '-p' flag to vfio_pci_irq_test to pin vCPU threads to random
> physical CPUs throughout the test. This stresses the interaction between
> vCPU migration and interrupt delivery, ensuring that interrupts find
> their target even as the vCPU moves across the host's pCPUs.

This isn't "pinning" in the normal sense of the word in KVM-land.  Pinning in
KVM usually means affining a vCPU to _one_ pCPU and never changing that
affinity.  What you're doing here is *very* different; you're delibrately
mucking with affinity to force pCPU migrations.  That isn't bad by any means,
but calling it "pinning" is super confusing, and I would argue the use of '-p'
is flat out wrong.  I would suggest '-m' for migrate if it's available.

> Signed-off-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> Co-developed-by: Josh Hilke <jrhilke@google.com>
> ---
>  .../selftests/kvm/include/kvm_syscalls.h      |  7 ++
>  .../testing/selftests/kvm/vfio_pci_irq_test.c | 79 ++++++++++++++++++-
>  2 files changed, 83 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_syscalls.h b/tools/testing/selftests/kvm/include/kvm_syscalls.h
> index d4e613162bba..5f839f735640 100644
> --- a/tools/testing/selftests/kvm/include/kvm_syscalls.h
> +++ b/tools/testing/selftests/kvm/include/kvm_syscalls.h
> @@ -73,9 +73,16 @@ static inline int kvm_dup(int fd)
>  	return new_fd;
>  }
>  
> +static inline int gettid(void)
> +{
> +	return syscall(__NR_gettid);
> +}
> +
>  __KVM_SYSCALL_DEFINE(munmap, 2, void *, mem, size_t, size);
>  __KVM_SYSCALL_DEFINE(close, 1, int, fd);
>  __KVM_SYSCALL_DEFINE(fallocate, 4, int, fd, int, mode, loff_t, offset, loff_t, len);
>  __KVM_SYSCALL_DEFINE(ftruncate, 2, unsigned int, fd, off_t, length);
> +__KVM_SYSCALL_DEFINE(sched_setaffinity, 3, pid_t, pid, size_t, cpusetsize, const cpu_set_t *, mask);
> +__KVM_SYSCALL_DEFINE(sched_getaffinity, 3, pid_t, pid, size_t, cpusetsize, cpu_set_t *, mask);

Please add these separately and use then throughout, e.g. in rseq_test.c (which
doesn't very similar migration shenanigans).

>  #endif /* SELFTEST_KVM_SYSCALLS_H */
> diff --git a/tools/testing/selftests/kvm/vfio_pci_irq_test.c b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
> index fa77ce348251..c2f48c6710dd 100644
> --- a/tools/testing/selftests/kvm/vfio_pci_irq_test.c
> +++ b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
> @@ -22,6 +22,8 @@ static bool guest_ready_for_irqs[KVM_MAX_VCPUS];
>  static bool guest_received_irq[KVM_MAX_VCPUS];
>  static bool guest_received_nmi[KVM_MAX_VCPUS];
>  
> +static pid_t vcpu_tids[KVM_MAX_VCPUS];
> +
>  #define TIMEOUT_NS (2ULL * 1000 * 1000 * 1000)
>  
>  static u32 guest_get_vcpu_id(void)
> @@ -64,12 +66,64 @@ static void *vcpu_thread_main(void *arg)
>  	struct kvm_vcpu *vcpu = arg;
>  	struct ucall uc;
>  
> +	WRITE_ONCE(vcpu_tids[vcpu->id], syscall(__NR_gettid));

Heh, what's the point of adding gettid() if you don't use it?

> +
>  	vcpu_run(vcpu);
>  	TEST_ASSERT_EQ(UCALL_DONE, get_ucall(vcpu, &uc));
>  
>  	return NULL;
>  }
>  
> +static int get_cpu(struct kvm_vcpu *vcpu)
> +{
> +	pid_t tid = vcpu_tids[vcpu->id];
> +	cpu_set_t cpus;
> +	int cpu = -1;
> +	int i;
> +
> +	kvm_sched_getaffinity(tid, sizeof(cpus), &cpus);
> +
> +	for (i = 0; i < get_nprocs(); i++) {
> +		if (!CPU_ISSET(i, &cpus))
> +			continue;
> +
> +		if (cpu != -1) {
> +			cpu = i;
> +		} else {
> +			/* vCPU is pinned to multiple CPUs */
> +			return -1;

Given that this is for debugging failures, printing -1 isn't as helpful as it
could be.  Ideally the test would print something similar to the output of
`taskset -c -p <pid>`.

> +		}
> +	}
> +
> +	return cpu;
> +}
> +
> +static void pin_vcpu_threads(int nr_vcpus, int start_cpu, cpu_set_t *available_cpus)
> +{
> +	const size_t size = sizeof(cpu_set_t);
> +	int nr_cpus, cpu, vcpu_index = 0;
> +	cpu_set_t target_cpu;
> +
> +	nr_cpus = get_nprocs();
> +	CPU_ZERO(&target_cpu);
> +
> +	for (cpu = start_cpu;; cpu = (cpu + 1) % nr_cpus) {

Why round-robin the pCPUs?  If anything, that _reduces_ coverage because it
creates a single pattern for how vCPUs are affined.  And vCPUs will never be
affined to the same pCPU.

Why not fully randomize the affinity?  Again, this isn't pinning, it's forced
task migration.

> +		if (vcpu_index == nr_vcpus)
> +			break;
> +
> +		if (!CPU_ISSET(cpu, available_cpus))
> +			continue;
> +
> +		CPU_SET(cpu, &target_cpu);
> +
> +		kvm_sched_setaffinity(vcpu_tids[vcpu_index], size, &target_cpu);

If you're affining to _one_ pCPU, just use pin_task_to_cpu().  Actually, all
of this belongs in a helper, e.g. pin_task_to_random_cpu().

> +		CPU_CLR(cpu, &target_cpu);
> +
> +		vcpu_index++;
> +	}
> +}
