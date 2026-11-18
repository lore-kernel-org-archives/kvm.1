Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018811;
	b=xTFpm/jnA7FJnADFDAsyYILSIulle2Fgpz31xk+nQrpNd7Dx4A8BXOpIkhA35pn/PEPn
	 d9CmU3t3MJ53Po/tCdmMyOzLa6prrSKv8HkQuPLjsG17I5VhW7dCsWOXoWCMyT+uY1ODY
	 pkTDZNUjvXDuZdUP3jAjTuk7K7Dx3H9z/8zsR2oSfcUTqdLK0om4zvB81jbVE0+ucQG0d
	 JhJnaugE5ZIEV7W4kj+1tfFWbwEdSCSOEpE5HwiPc2tv4LPtz/3e5mZExDu1Xm7DVwNVW
	 DcY36+DgNlBwONpjTwD0BcUwn+CUPlbw8/ZkV+czhVgnIgbYjBSasUkk1sV+Lu+VeHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018811;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sFa+8osRr+Td7hjHKGRDX6/RLhBxSgDFK1+pCtkm/bE=;
	b=emHKTqt/iy0A7ibt05AxlZvNx7HzdoV4OI6+OHAj06BWXtZLet261dDwJCrnkVmIAwKR
	 b9XeAIj5XFCulRucRI3JSYQqJzZ+OM/b6rJUtxE/RsNYhVnPVuuftQiaekP7N89zJKWwW
	 5TvacP3kXjgw6nirzOxICC3VIPBW72HdGMVKit/zFcMvVMTUJay7Fyn3FdHEWY4a1VxUN
	 igbhQcuzWnz+jts3xL0bc9eYmpRTSLGPcGfLJvJywrTlKF7pQrMKA+S2IMvWr3CrAQdpC
	 +BxMqZxJ+RsaPNV0T1LXIC6brBwdwSFS1MKu+ctEVIegJjfN1f6bA00o9+l/VAzmB+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cdh1H2XA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A30A606A31C;
	Wed, 18 Nov 2026 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cdh1H2XA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7592F1F000C4;
	Wed, 18 Nov 2026 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795018811;
	bh=sFa+8osRr+Td7hjHKGRDX6/RLhBxSgDFK1+pCtkm/bE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cdh1H2XAj1xjH2KEEe3ICZCx5l57Qg63s3AqU20OTD9L8rf3gUC1Nxat3vjQXIFmc
	 s15EV6o2NaQCZw+AamDvR45fPzTN78lKBU5AUILSc+w9j9Y5qd5ZQ17MinomUPVmSr
	 wwgf8nB7TPqn0B8HnkFYSCpjxj5/Dc36f176cRzpC7oeNtpxjR/gBtIgsYtD1mL7Qs
	 qQJB2RpOyX/G9SzpFbdnuKu7Jj//tDxqRpa1zQ5UOxr3GQ6s2kePwN0DVzkjCqaNCG
	 SqkZPtCSx9Ag7V2LxVRc2BCzPYgo0Q9RZBhk7DoU+KQPFDpvRqn97trAf2NWo8NB/r
	 ybBz6m8s8A1Hw==
Date: Wed, 18 Nov 2026 16:20:09 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v4 17/21] KVM: x86/pmu: Factor out fixed counter control
 bit calculation
Message-ID: <av3QM4Mj2KidNro3@google.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
 <20261112203227.289379-18-zide.chen@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112203227.289379-18-zide.chen@intel.com>

On Thu, Nov 12, 2026 at 01:32:23PM -0700, Zide Chen wrote:
> Rename intel_pmu_enable_fixed_counter_bits() to
> intel_pmu_fixed_ctrl_bits() and have it return the computed fixed
> counter control mask instead of updating fixed_ctr_ctrl_rsvd directly.
> 
> Accumulate the desired fixed counter control bits during PMU setup and
> apply them once in intel_pmu_refresh().
> 
> Move the helper earlier in the file so it can also be reused for
> upcoming ANYTHREAD_DEPRECATION emulation.
> 
> No functional change intended.
> 
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
