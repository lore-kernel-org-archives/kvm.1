Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64143815D9
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 23:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778629284; cv=none; b=iKPKzg/2ZltXGAeNMBf/W4jOc9ZAIgeKtj+r4NhCFcFE8kGudkMrY82lUirZ8oUhyyiR3h7NNsukMidAcClVT3VPYjcwTdvGgJs3kEr99TFJGND4dX4IXIKa8ljpOXios2BpOqeRloHyRNSSwb2kK/I/f9ngcA+GLR5mV+hTvoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778629284; c=relaxed/simple;
	bh=k6glw0fa1xZbNCk2CI4tGQalB7KYR7msKvRtehm/sOc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HHsfAnJZdpBKpETiYo2egLbQkH+9ZT4OVjipbq1A2yjRzuVPy36MmpLKGTTs2H1HCEItdE7c0/axVLSlvs7Wnak4JYAAlv5NuyEgq/uDQj9dgt4ZKSxyKxD34WNh2wtJuP0ppC0I9f2dJyXSath3tQA49Cr6I8aK+NxZVGmn2cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eeqjakIH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eeqjakIH"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b9a3c3c4eeso66182615ad.3
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 16:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778629281; x=1779234081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4JJQhnqYlnKPfDWfphBogFKjvhlthhr+yORGRRz1NM=;
        b=eeqjakIHRSXldr3Pwxv2NfbIN17luRsYkUf3KAQCLkSBxYdPLZF5SEPAeZD4XQ8RSs
         K/4uF5q44nOdn+bYVFi03Iwl1CKuCHelH36Nf8yDHJs0x9ZMrZbdluA39HnvqHQNkXFh
         te1q/jXa09fsLU7rykCDmLMzXfmoAhTmp6Tv3DUFhG7I0vfIXs2FY2DTZYaruAkQkfaQ
         4K9gAOdJm4st8gb/wEbb+RDERXpRgkBqCei1a0z0qOjoo6LbyhwFVJ8sQWvOajj0vni+
         Wt/hywSPPMlLhB7DzRF+13EyOUmcp4o4LV5Z3iLo92C+hgbX470s8CYjhiGHJHle/8M1
         hmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778629281; x=1779234081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4JJQhnqYlnKPfDWfphBogFKjvhlthhr+yORGRRz1NM=;
        b=OthMnErg/Fp4heHhP0Tu+x/OIZvw03deRU5X95AI5LHB+4XAa+q+nlOwAqfAh0YQHx
         ZBI9sgeJj3Yv3mUVJTYWxCe6rZlf+9ESxXEpLSHuRm/sJTo4x+qZRlT1MDwc2BDqMevv
         cFFF09D6bFk8NEBGmKCDRGzU8dYGTcnkVTDcC2YYxMJj6dtQuZHBlAbIbuifnIiE03O5
         +Jweg2SEcm+eKe+Ompt9AX/E1EyN4i+iRAlE3uXNJvsWaW1vZxYuRT1LRy3A2BzcmubF
         qPwymA0bzlWNb5gHHmKSOhaJXiWI1aPK1C7FKdEY9w1z1k1Qdh2POhYHXy/deM4sA8Nt
         VWcQ==
X-Forwarded-Encrypted: i=1; AFNElJ/QgAxG3RCzSBvBgrJ3mlPYpSzKiapnPFQ9/VBC0als/90FxSF42PPjgdUVHjnhRw987JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbguovhJb5RacXa4nitDYp4pqX5YwcnMWf6xT8UAqkR+jf+e0k
	GxKZPGtHEUqdrd9WFTLrM61eWI+35lUXIikZi17w5ODdBTDx0XYpokQQ9XaBUQsXBY/VC8T0pHt
	+88FObA==
X-Received: from plhv6.prod.google.com ([2002:a17:903:2386:b0:2ba:b55d:244c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d585:b0:2bc:ffe1:c380
 with SMTP id d9443c01a7336-2bd2f4dbbbcmr3504675ad.8.1778629280961; Tue, 12
 May 2026 16:41:20 -0700 (PDT)
Date: Tue, 12 May 2026 16:41:20 -0700
In-Reply-To: <20260508015013.4108345-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508015013.4108345-1-maobibo@loongson.cn>
Message-ID: <agO6oLqQYQG14x6D@google.com>
Subject: Re: [PATCH] KVM: selftests: Check guest memfd validity with flags
From: Sean Christopherson <seanjc@google.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Oliver Upton <oupton@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, May 08, 2026, Bibo Mao wrote:
> The type of guest_memfd in structure kvm_userspace_memory_region2
> is __u32, it is not correct to assign it with -1 and check whether
> it is smaller than 0. Here check flags with KVM_MEM_GUEST_MEMFD
> set.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 2a76eca7029d..9d3553f7e6a5 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -817,7 +817,7 @@ static void __vm_mem_region_delete(struct kvm_vm *vm,
>  		kvm_munmap(region->mmap_alias, region->mmap_size);
>  		close(region->fd);
>  	}
> -	if (region->region.guest_memfd >= 0)
> +	if (region->region.flags & KVM_MEM_GUEST_MEMFD)

Hmm, it's a bit gross, but this is probably more robust?

	if ((int)region->region.guest_memfd < 0)

E.g. if we somehow end up in a state where KVM_MEM_GUEST_MEMFD is either stale
or the guest_memfd file was already closed.  I highly doubt either of those things
will happen, but logically it's the correct fix (the only reason guest_memfd is
a u32 is being it's part of the kernel's uAPI). 
