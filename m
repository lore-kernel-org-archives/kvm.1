Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5EB23ED5B;
	Fri,  8 May 2026 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778260961; cv=none; b=hs8SsRei1S3VW/xiL2syihX1tWqrYth+8vRbQC/hx+3PJ6hkQO4rTv8DKTwW0Aqm29M6x19y5iq5AsSyR3X84QhF2n8b/nS5ng8K99lc1HAouTcPHXtvi+scxLmrKTkoG4Lt+dSUEym+g6T0tECQxJs56cwY6WzU7U3pitZcIrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778260961; c=relaxed/simple;
	bh=1J98FZNeG0wJh1d24RHpuQ7/4iIzrGiVR0KD0PgvBJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEqIqayVz8DlahEWIsM+HXUOaOxDV/h3kxynmnUQrLYJXseC233v2lwHa7QD1d3z9vr4JxBsXS87c51y6bv4r3lujjOizN00k+uFyFN71habOIcx/UQvIbe72fOtPByHHW+suarAHqCeExYFw6iD/Pb9xPCMTGOYLNa3t8JASy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmT0hdzg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmT0hdzg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DD9C2BCB0;
	Fri,  8 May 2026 17:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778260961;
	bh=1J98FZNeG0wJh1d24RHpuQ7/4iIzrGiVR0KD0PgvBJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mmT0hdzg+nreTvPyyLG/QWl15hwM7epGunXpsI3BkK0hSmEcWeoqEJBoiPuEd2EOr
	 FmGoKVgUDhoaZNuDMsuOJz9GqjOxv+uZpswq3OKPUZVptu6arPqntx0g2JhJ9W835h
	 trgxDNrdUcIPwXb1GP4YQ67FA7eq2QHrfC+x+eF50oYsSdiKUT7gszntv9ZKSyVUx9
	 985WhRQcXXhPIXAqQMJTsQNijbQN1gqbPYmm59V6xjKfQlz85oNM3RbE0dBJZDnomC
	 z8i3u75JHjDfVwzGGbdW554mWhKdEkv2wl3LsbowMp+gLc1SpH1eFcd9SN4LSlcr1B
	 kioBsWgEYlUng==
Date: Fri, 8 May 2026 22:44:06 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] *** DO NOT MERGE *** KVM: x86: Hack in a stat to
 track guest-induced exits (for testing)
Message-ID: <af4YUUCJfp_X-bcu@blrnaveerao1>
References: <20260506184746.2719880-1-seanjc@google.com>
 <20260506184746.2719880-5-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506184746.2719880-5-seanjc@google.com>

On Wed, May 06, 2026 at 11:47:45AM -0700, Sean Christopherson wrote:
> Not-signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 +
>  arch/x86/kvm/svm/svm.c          | 81 +++++++++++++++++++++++++++++++++
>  arch/x86/kvm/vmx/vmx.c          | 79 ++++++++++++++++++++++++++++++++
>  arch/x86/kvm/x86.c              |  2 +
>  4 files changed, 164 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index c470e40a00aa..bff534bd00dc 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1703,6 +1703,8 @@ struct kvm_vcpu_stat {
>  	u64 invlpg;
>  
>  	u64 exits;
> +	u64 guest_induced_exits;
> +	u64 msr_exits;
>  	u64 io_exits;
>  	u64 mmio_exits;
>  	u64 signal_exits;

This looks promising. I'm assuming 'hack' in the title is only meant to 
indicate the PoC nature of this?

Taking this forward, introducing a similar bucket for all AVIC/APICv 
related exits might help with a few tests.


- Naveen

