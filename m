Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E530C4AE8DE
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013546; cv=none; b=AiUkH+eyLUYFVaLHXMtJS19HwH/Znj67V5U99vESr/HEJvGj5K656Y3PfinhX/fRtqx9MP4S6nQLy6oiMwgJ6e2VFLQIUIWjEbj8BwLq4zjCii3WHk7JB7XLBCRNQMVzEuOp3KPRxBrHmHXGUbPAzugP521Yww0yp88BevV3C48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013546; c=relaxed/simple;
	bh=MVjVmWMqrrzTkc3sU4u6lv+1ct/WLn8eqK9zeyowpPc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fq/u0Evo/CnXDa8I6+YVc8XTUJZkJtNj7u8xyG4zdp3OxuGHnsSizFyjq9oBQou+1iX4SASJFgCEgMUSQc7hTcWCbuelEUdPwdh6KMQLHiY1F6FqafeoxAHM90btHsYUsdDhMLexJGWJSrMlif2JFV2bLnaxnX1exabfpBwli9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kd0Kw0RB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kd0Kw0RB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FD91F000FF;
	Mon, 21 Sep 2026 17:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790013544;
	bh=KeAoPxQzTwmu1nEo8I/kNSPEBHVGhRrxR2nWJWZOAb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kd0Kw0RBw8NASTpX5SfYO1WtpvOAiaVnZKqSyc/7r2QPlLYhey0XgqpsuWq4V/sln
	 gqo/IQ1ZJ57rfmKynHOQwPp3zwPa50Oj5zn33VYj3ddFT0mvK1yvY/OGRzNSJ7UzOd
	 K31FgCFd9GoeC41HyWzNbXkOkPkX5pL4ZQsiVW4p980vqyl67ECKbfjyCB8DLwPNda
	 7yB9IHoShDP4x05MxUXQpxsYjILrK0iz9gNCvPvSQre+Hb5/YWkAQ07r1O+qWYuo3M
	 RVVs71+ui6mAM/1+kDiusAGPv+S9MzSRNnumHUcw7bSuXfQBH30IogzpskZuys0mXl
	 xIP8yTAQ6Shtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] KVM: Protect all of kvm_vm_ioctl_create_vcpu()
 with kvm->lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260921174445.911676-5-seanjc@google.com>
References: <20260921174445.911676-1-seanjc@google.com>
 <20260921174445.911676-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 17:59:03 +0000
Message-Id: <20260921175904.40FD91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kvm: mixing goto-based error handling with guard() in kvm_vm_ioctl_=
create_vcpu
--

commit 01402bb146d901e6f480f96bad9c9a7b5314ecb9
Author: Sean Christopherson <seanjc@google.com>

KVM: Protect all of kvm_vm_ioctl_create_vcpu() with kvm->lock

This commit serializes vCPU creation by holding the kvm->lock for the
entirety of kvm_vm_ioctl_create_vcpu(). It removes the manual lock/unlock c=
alls
that previously existed around parts of the creation process and replaces t=
hem
with a scoped guard.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4165,6 +4165,8 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm=
, unsigned long id)
>  	struct kvm_vcpu *vcpu;
>  	struct page *page;
> =20
> +	guard(mutex)(&kvm->lock);
> +
>  	/*
>  	 * KVM tracks vCPU IDs as 'int', be kind to userspace and reject

[ ... ]

> @@ -4287,10 +4277,8 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kv=
m, unsigned long id)
>  vcpu_free:
>  	kmem_cache_free(kvm_vcpu_cache, vcpu);
>  vcpu_decrement:
> -	mutex_lock(&kvm->lock);
>  	kvm->created_vcpus--;
>  	__clear_bit(id, kvm->vcpu_ids);
> -	mutex_unlock(&kvm->lock);
>  	return r;
>  }

[Severity: Low]
Does kvm_vm_ioctl_create_vcpu() in virt/kvm/kvm_main.c mix goto-based error
handling with the new scope-based guard()?

The cleanup subsystem guidelines forbid mixing scope-based guard() with
legacy goto error handling in the same function, as it creates confusing
ownership semantics and risks future double-free or resource leak bugs
during maintenance.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921174445.9116=
76-1-seanjc@google.com?part=3D4
