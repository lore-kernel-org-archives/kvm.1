Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793993823;
	b=zepkKIvpZGgDLwGGpCuslcZWHd4sZBaMyizqmpyUkoftRCz4JHyAInOPN7N87/FaeNsU
	 KcEi9pUmhNrO08DveErn17eYtNlwwLWsvL4Mdn1j7GWaiEamRBK3xspiTMqmnIO1Pycdw
	 UNYE26myW/Fd7BG3O9bosaj4prSMB/drmapWN50kLu1K6lHln2h2+4l2iqF15CV/ffp1W
	 zmU0GTsIsLwkRM29/vuY0/u+P8Z2Vu7i302xOQYD/RJ/UvCiaRsYz+CPy6+BaOIkS7rna
	 X+7zXZYKWRTobBNwrrJDMpBgNlx4eJWwcU8zIXAdZluwahDn9R9nLbuRpk75kREY2Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993823;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=t9ccNo3JLxUGkfk4w9Wp2nbCA1GddPtEwfNoICfeH6I=;
	b=T0F8S9yhGJK91LICLihKduiyau80/cnYeu9QkXEJSq9gwLLk57zfQxezDzSiEBSX5z67
	 VopviS+iAEyjI7vuQ43qgtkQKtmLyGPMZesdBR7HAIQ8BohnVCtkxe/6c+Zwt4mUbSt32
	 NeBmOnbJmMN+TxdpD0ddfDPMvKuwQmeVld7ZV1RDXQpvMjWR9x4n92B7mzAarrvhe0Pje
	 Nv5R0J5vU09XS/ASeQVv3AtK01jSpionPETIKiVCITvnngO34nnNu5KW1gXU8kKyPG1vl
	 BLmWj5S6VVIAKt7uLKZi+ySIv+ibgLauRJAtuk9zD4urAC8BXrampPlasA6Odb6Xktg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoyN8vLj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166E2606A326;
	Fri,  6 Nov 2026 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoyN8vLj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B5A1F0089F;
	Fri,  6 Nov 2026 19:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793993822;
	bh=t9ccNo3JLxUGkfk4w9Wp2nbCA1GddPtEwfNoICfeH6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UoyN8vLjbBi/X9YmePN/O+UB7auy0MS1xWnr9O9MdkwiJc6atvgiorHbjxPeAHbMp
	 1r4R9KfVGgoBRTU2vEKtq8RuUDegk4wHTplDtQoB4LIJ2wSRKYgdCzLJLSsEK0Lnb1
	 UfQrngDSgYgxab2sDydq3SQWuaknpSIYd0RROSt3QrcrT5r1RNwIQP513Bc93CH4B9
	 316lms4Y/wccOrNsWnQ4vZdFu5VFhK59+Deog44ZZjxfJYuCuKdIqOjhg2aPLHXshW
	 Tzd7lX6XR7Lb84k1W6amLwG3h/C2WCoL63nCKdZmSS/hAxNRACKhhJox42tlxXMTMi
	 /AuBG7UUE7neA==
Date: Fri, 6 Nov 2026 19:37:01 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v3 06/18] KVM: x86/pmu: Expose kvm_host_pmu to vendor
 modules
Message-ID: <au4sVx7xzzGjVHST@google.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-7-zide.chen@intel.com>
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
In-Reply-To: <20261106013927.166209-7-zide.chen@intel.com>

On Thu, Nov 05, 2026 at 06:39:15PM -0700, Zide Chen wrote:
> kvm_host_pmu holds the unadulterated host PMU capabilities, which
> can be used to compare against guest capabilities to determine whether
> certain MSRs should be intercepted by KVM.
> 
> Exposing it directly avoids the need to introduce per-field accessors,
> which would add boilerplate without hiding any implementation detail
> worth encapsulating.
> 
> Opportunistically, fix typo "Unadultered" in the comment.
> 
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
