Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB731FECBA;
	Fri,  3 Jul 2026 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783099028; cv=none; b=AhGLjQYt6Y5vm3zYLdQFpFRPAN8QKN0we/XseuUgtoE8jtnc4YRfc9LnkTBFcTjxq2+Hj5G8q+jTDmixwMA6T5xoW3tBfzkg1wMmwo4UG/GwpxATPC0ac6VtjtUsq2apeY9fMEx/IQI/mq3BxfeQHMzJga95q3zBSoJswcOfmHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783099028; c=relaxed/simple;
	bh=yS4NHdu0+z0xYffZ00SVcTXabRgGcakj+8pkrdQPbAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K96I9V+LyMw9g2V97Zojfa90k26fMmBTJZi/9bYMH0zzw1uO+f528xqduQMdVWkhchy1P5gvMkwjphBpIco93H+2DyD7gFmTrwPCaMWyJoNNIf1Q/Ec4PusDVwSWrTpK0nbQxDWyUuosxls42gtbueqxHVeAPFx2nqzNZs5USiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKEDZiXc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKEDZiXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1411F1F000E9;
	Fri,  3 Jul 2026 17:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783099027;
	bh=pWKNjWKNN7AulpE+nN8XzlhA7/Uy5NwiHpEbL4wejqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YKEDZiXcN7O2cy1LnHAZAYPNDzjVIoaruILO+g7aKw/4W2a97Bi3zvVgYpJdbf6gz
	 QMClbtL4MdAKXVpLhBrlOn0TsHbR9raQkm4A8Hyz8Hi6tUbbfZsJejuvcqs+gO0Qae
	 gFuDcKxMZ7QcZfiPAZfsuqpYzOSQYyxOyqHMGCj4hQ97Pqo8STFDYwno+uEroPO5Eo
	 /Rio4v05n/9eYw0bzlwJoripoTvk16X9UIn3gj8UqoUwrG5BfxZzdWEDTtKb1aWopy
	 Cz/+IQ04pxMoT5oPe+iMJ0uDQh79bEH+9IIhORhpdSKA+R+h4FVL8xOvXWLBXZ25m0
	 vwyzTaf3utiWQ==
Date: Fri, 3 Jul 2026 22:44:35 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiao Wu <xiaowu.417@qq.com>
Subject: Re: [PATCH v2 2/3] KVM: SVM: Do all per-VM AVIC initialization
 during vCPU precreation phase
Message-ID: <akftfnSy41TkeB4h@blrnaveerao1>
References: <20260630210156.457151-1-seanjc@google.com>
 <20260630210156.457151-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630210156.457151-3-seanjc@google.com>

On Tue, Jun 30, 2026 at 02:01:55PM -0700, Sean Christopherson wrote:
> Move all per-VM AVIC initialization from VM creation to vCPU pre-creation,
> i.e. defer allocating the logical ID table and adding the VM to the GA Log
> list until vCPUs are created.  This will allow removing the VM from the GA
> Log list before vCPUs are destroyed without needing yet another kvm_x86_ops
> hook (.vm_pre_destroy() is very intentionally called if and only if VM
> creation fully succeeds).
> 
> As a bonus, this re-unites physical and logic table allocation, and avoids
> allocating a logical table in the unlikely scenario that userspace creates
> a VM without an in-kernel local APIC.
> 
> Another bonus to hooking .vcpu_precreate() is that there is no need to
> unwind on failure, as the VM has already been created, i.e. KVM will run
> through all phases of VM destruction.  In fact, unwinding is undesirable,
> as KVM tries to keep VM-wide behavior idempotent/sticky across creaton of
> multiple vCPUs.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/avic.c | 94 +++++++++++++++++++++++++----------------
>  arch/x86/kvm/svm/svm.c  |  6 ---
>  2 files changed, 57 insertions(+), 43 deletions(-)

This takes the cleanup one step ahead by removing avic_vm_init(). Good!

With the prototype for avic_vm_init() removed:
Reviewed-by: Naveen N Rao (AMD) <naveen@kernel.org>


- Naveen

