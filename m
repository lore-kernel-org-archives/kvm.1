Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989280;
	b=1vdhXToyoXHAv63VE+9eeQg2Ji30Cpk9i5hqDddh+aToLsy9HWZRvIzW8u7F4ycrSNaX
	 BO9oCXBFOhTuJ6V3dt4MCa3T2K+4xSVL80HK2FUesA1MorPGhROUTJfhU/sYI+JOU8r8P
	 nxRaU8+ftElPd7takJEE5CmhmTMvs/cbzhp5NuYlDJNROJvd/vt9Apfz7oyb2x+hYg571
	 8iJMHLCH7Qv4ccCDwW976Suxo08pc3HMDk6lAeZXLDP9wkPo37sIoJ5o/cVBlEo6Qmnsc
	 nvlPyKkWeLLbpMZvHavuqdjzkgr5JShzPgVsUHgiTFkA6pT4B1EqOvxB9+dfY+Q2qAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989280;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bzTsikQIe0Lm5u/5x1GkaL87bNsKwsJpmNXeeOvE4T8=;
	b=UIQ3i6Wfm50GrgQuyWLX0dIIyNF+duHVuH9WvZ4PMUHMaVkvGhCOtzgfuCgi37eDbMED
	 k9Fm6ATKhQK8ol9TU9WBozTSycMhcjsKAYSicZMKVtUTSMK+ArIQtPeCz0WV6Pl/2+Zmj
	 55y1fZFmtwiIciZwEQGLdQK37HbKFli0jiuh+NVti2afXPmh6ApqGaUgkzwhv/wQBZDJj
	 mLwvKjLVqXqzVWeD1GPBSOwbF7G0wgvHsYwSYAft3jMlHDnAl9RhyvAmaVYP7uac9hXoi
	 F9hvasyAzRomGaR4RU3cnqa+L760nvGUJYQS8BaBeVCQGN0tGUFfXdfOBqoq+Ihvu/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIWXUC0Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D1606A336;
	Fri,  6 Nov 2026 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIWXUC0Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3841F008A5;
	Fri,  6 Nov 2026 18:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793989279;
	bh=bzTsikQIe0Lm5u/5x1GkaL87bNsKwsJpmNXeeOvE4T8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LIWXUC0Z60FM0SIxWrjPsUEnOqXdBR+ozF1HNGKwDSFSnaH+Tk6Yx6PQkAv1YM65N
	 Iht0pgYX8ZSweS3z2Sd+nw1X0OP37i8C28sqjHB/raL1GTgGZkSQoHhsIRbaN2z3Sh
	 38KEVe6Sb4KXoe2yohqx5V/KuxUSpI4QpEjMGJXxqUL4TNEWykwoerEHeXubuxCd+o
	 12HGVHivZHu/u6ojtdKCplfAgUQzsnufyDY/h3pob+DGo0qWdxnpx0V/uKsffAfuiU
	 uex7NjjuTenwifLBNs+0GYKeKiDLhYXe7tfWJ650UAfhRVivkrqVmr0npfOW4ClHrC
	 8wovP9d8NM1iA==
Date: Fri, 6 Nov 2026 18:21:17 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v3 02/18] KVM: x86/pmu: Rename all_valid_pmc_idx to
 pmc_exists
Message-ID: <au4akzNMjwzQV_ic@google.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-3-zide.chen@intel.com>
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
In-Reply-To: <20261106013927.166209-3-zide.chen@intel.com>

On Thu, Nov 05, 2026 at 06:39:11PM -0700, Zide Chen wrote:
> all_valid_pmc_idx is a bitmap of valid PMC indices, not an index
> itself; rename it to pmc_exists to better reflect what it holds and
> keep the name consistent with other fields in the same struct.
> 
> No functional change intended.
> 
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
