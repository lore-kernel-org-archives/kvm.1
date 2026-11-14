Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682436;
	b=OL9BLGJG0DlnL50UZhAXFPUW2or/uywUg8Gh1nzgfqN0AW7YzKTGHOy629xJHPdxJlEZ
	 pMs9Im4bL1lri+flZCawC+dFqbo84RAwWAAyeHcJVeBPuMle/03kMnyQtLqJYoONoa24b
	 9hyJcjDenqhJJRi/UozB3BJyPFfgtqppGAvKJGUCejfgp97XZ7nTl7UU7oTp3XFWXF6O1
	 kAiU/3+m5hRD4TJtxuXSd2KuD4h7QD+e82ZlSmJNmDwrolVQ1SUyQkt3hW688WFIIaux1
	 aR+8KOK2kezgWgNtcnKlNT/FNPCdc3TLckObPKS7vx7XEkF8H7Qg1fLupKxnqC1jedQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682436;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Jh9L3tZUpoVeaioTKpf02knTAO4fpBO1ee2zkx3jTls=;
	b=QdSrf1KB4A+ECWiTje5biYcGabTmQhln/lqWXalPHZuolYgw1BsMyBwX9LynteB+VoB5
	 AZEP4otCBrpU+nDJ2yhGXFTAzszlYUsXRaqR/Qp6mxhNAcXks1mCOj6z9O9ZDjsFw1b2s
	 aZy3y5rgP5s3e7Q4qCwxdgRTriy7gA/T1TUZ5TgbX9To4LHCRbn4nxP7k54AMsmCxSgzl
	 OrqAW74fED3lLHLOCGmxcXWpZDybR34lN20UdTYtjpw69TmZWZyMuKqCUYwSTSjSd3+e/
	 9AH/Vz5xzv3kegq5gKC/yraCbMAqx/I0qY768/I+9cgqFzAtdC6/5zBs5LsroaqEang==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WM/vitZg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1070606A323;
	Sat, 14 Nov 2026 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WM/vitZg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90091F000C4;
	Sat, 14 Nov 2026 18:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794682435;
	bh=Jh9L3tZUpoVeaioTKpf02knTAO4fpBO1ee2zkx3jTls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WM/vitZgYX1V97yPEd0ZNQRbFYFiF8yqg4IlwVTuIgCozh7dDa7k8MmDQBETWXOE+
	 LZ5O2RtmIgXVRd5yOa6+eqdJrkARuDSbQjruakhYX2aEIHDcGzvRSgzZ9xAF3TvZrc
	 lS5qf5dpllEywcaOatT9elRvtRE2s6zdl1zDFuyDuS4YnpF1y1f3LMf3kzgvjCV/Xs
	 +2F5FU8C6eEYethLs0nXDFJMXZDTJjwqucJK5YRT6FC6NOf4BrrNMQF28lH5Zfwvaf
	 X35fhQyfSVCPsLi2hNKi3aAMe3az0p1+I4T4n5Ctr2KaZxyZXROwo3RYHLaTw7n5Kh
	 nkqyJSaGd4xAw==
Date: Sat, 14 Nov 2026 18:53:53 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v4 05/21] KVM: x86/pmu: Use pmc_exists in PMC lookup
 helpers
Message-ID: <aviuEiOQtxj6xv7G@google.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
 <20261112203227.289379-6-zide.chen@intel.com>
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
In-Reply-To: <20261112203227.289379-6-zide.chen@intel.com>

On Thu, Nov 12, 2026 at 01:32:11PM -0700, Zide Chen wrote:
> pmu->nr_arch_{gp,fixed}_counters cannot represent non-contiguous GP or
> fixed counters.
> 
> Introduce kvm_is_{gp,fixed}_pmc_supported() to validate counter indices
> via pmu->pmc_exists, and switch the PMC lookup helpers to use them in
> preparation for dropping nr_arch_{gp,fixed}_counters.
> 
> No functional change intended.
> 
> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
