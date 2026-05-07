Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA473FB7FB;
	Thu,  7 May 2026 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164108; cv=none; b=fZKR7YUwuyryca3kvO8oGZnuNLrdtgjP8ctWU1HgpqPjoHEW41+RjI11e07ZULUG3BkyHhdV5hXoHlscELgjbQYR8c4lkc8PKCMi9+vIz/zCm6JBEnY0d/+UbPIJTNbgujcvD5Bw5GKYpe3qImfe6hZEZtto9xsVikT4dlF0ouA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164108; c=relaxed/simple;
	bh=l1+K0XRcJUJLvYzlP5bqOnq1t3prmSAhE7KTsuXU5mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhqoOX5HhEO2pJCfkqIT+EeR9iC5j5lmYJhB9LgXH75Tz+t7aEfllIHaNXrLtRjB5JYctNSDTGkYEn9inqkDWAncl8cry6Yp32XPmyy9obmB4bMqtJq6xfoqZCrL/bowUTa4f6qaJCA5Wc6XYz4DYl4ExPbenlBx5Dkx7m83eXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na5DK7US; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na5DK7US"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7301C2BCB8;
	Thu,  7 May 2026 14:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778164108;
	bh=l1+K0XRcJUJLvYzlP5bqOnq1t3prmSAhE7KTsuXU5mQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=na5DK7USrTP9bwboesc4XKK5o9ShCodo+RffsPq0f6rZsEaruqMHPhuI2D6a0/6Vo
	 ErjDGyXW9odombs1iarufBF5j7+v3ng8XfKNLfmKL+TTknJv0gNTI2U6PcYhJEbiit
	 RoBBa96MUEvSqKIEHUUiH8RWBmJDNbfJlYZwuHLjG5NzynOJlVHa7VQS3kMFv4qGFZ
	 18dZ6cOiGTg8GBK6exqTGsUM2873/fQg0IsaBmmgWgwOs8k3hd9XqYlSRiTLcTlLUz
	 dZiXlFpS7cp++Q8C7d1ajojOs1zTthRHEDRslvj3Ccku8GjDEA92kgkkpf8OByFAUW
	 yTIogOMigMfyw==
Date: Thu, 7 May 2026 19:49:53 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] KVM: SVM: Always intercept RDMSR for TMCCT
 (current APIC timer count)
Message-ID: <afyfFRkUIHuodvG2@blrnaveerao1>
References: <20260506184746.2719880-1-seanjc@google.com>
 <20260506184746.2719880-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506184746.2719880-3-seanjc@google.com>

On Wed, May 06, 2026 at 11:47:43AM -0700, Sean Christopherson wrote:
> Explicitly intercept RDMSR for TMMCT, a.k.a. the current APIC timer count,
> when x2AVIC is enabled, as TMMCT reads aren't accelerated by hardware.

s/TMMCT/TMCCT for the above two lines.

> Disabling interception is suboptimal as the RDMSR generates an
> AVIC_UNACCELERATED_ACCESS fault #VMEXIT, which forces KVM to decode the
> instruction to figure out what the guest was trying to access.
> 
> Note, the only reason this isn't a fatal bug is that the AVIC architecture
> had the foresight to guard against buggy hypervisors.  E.g. if hardware
> simply read from the virtual APIC page, the guest would get garbage.
> 
> Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
> Cc: stable@vger.kernel.org
> Cc: Naveen N Rao (AMD) <naveen@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/avic.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 4f203e503e8e..d693c9ff9f18 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -172,6 +172,9 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
>  		svm_set_intercept_for_msr(vcpu, APIC_BASE_MSR + i,
>  					  MSR_TYPE_R, intercept);
>  
> +	if (!intercept)
> +		svm_enable_intercept_for_msr(vcpu, X2APIC_MSR(APIC_TMCCT), MSR_TYPE_R);
> +

Nit: I'm thinking it might be better to roll this into the previous 
loop. That way, all MSR_TYPE_R intercepts are setup in one place and we 
don't need to parse the if (!intercept) condition..

Something like this?

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index c5d46c0d2403..f292cba45e07 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -136,11 +136,9 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,

        for_each_set_bit(i, (unsigned long *)&x2apic_readable_mask,
                         BITS_PER_TYPE(x2apic_readable_mask))
-               svm_set_intercept_for_msr(vcpu, APIC_BASE_MSR + i,
-                                         MSR_TYPE_R, intercept);
-
-       if (!intercept)
-               svm_enable_intercept_for_msr(vcpu, X2APIC_MSR(APIC_TMCCT), MSR_TYPE_R);
+               if (APIC_BASE_MSR + i != X2APIC_MSR(APIC_TMCCT))
+                       svm_set_intercept_for_msr(vcpu, APIC_BASE_MSR + i,
+                                                 MSR_TYPE_R, intercept);


- Naveen

