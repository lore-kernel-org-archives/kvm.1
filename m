Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989184;
	b=XJhBs7xZZ5Le7WBagY84TvtY2layg63zBxpKrpAI4uxLzD8mEwoHcWkHTfwS8ofc1eAj
	 sKXlMqEXp0mCaU1Z6yhvpP27hwqrTf2Fa/QkHXHoZGurN3iJPUqgCLzCagXu/SA1cHNeh
	 SJ0gITAh6t8ueSfzNg+0q6Bl2+NscffmnP5MZIbdltWw175YObhF85GQCrrHDW48xZCFc
	 XL57R3BPe4LYWqjYAShalbmiAMP93iVSI1fWIfI+ogATzWt39hkBpoKw71YuSWbsI71yh
	 iez8FiSU3/9mskdn540JtZOwYzuaWMfsnyw+stUh91SdOrH1d5SHe067p8w1ukFCnUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989184;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MTuiUC1h2NKtHU7YdcHmw2Q8zH5iW4pR7cbqMM6/21Y=;
	b=d246shtUixxO29bAQo7Zd/xzNK/YafdHM6f/RhVN6hXwwIWoLJRl4M0RcXiu1sIcellr
	 xre7z/syMDrZe2Uyjfn/EF9LDabyydALAihTfW8joLcZ5iGEZIRC8joedf2NGqQ1Uxc+K
	 5oHlpV3fX2sDGSOTZC5vcHE09N8qvBvWw1d+2F8hTV7vR6H7BA5KKZPIuZWlFrhO5ta64
	 +BcFFua7OcnTIJXAXz5peZizmw8OA/YiaiWzfjOOff+EymycE6kFTmchWjES/qNO21KqY
	 0t1P3ySMBUKANjzbYtGfclVG+hCTpn9hD567wtZ2Xro59pEjfYXhjhIXZfbegCeUrgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QqP5S3XG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B834D606A326;
	Fri,  6 Nov 2026 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QqP5S3XG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD07E1F0089F;
	Fri,  6 Nov 2026 18:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793989183;
	bh=MTuiUC1h2NKtHU7YdcHmw2Q8zH5iW4pR7cbqMM6/21Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QqP5S3XGUj2ZwvX2Es2VLLvLdx4x3A2ps7jURNmpp9X/d0adxJ+KHzzuLTEHTWDre
	 Z1oHxlBhVxAqYa1/APjOf29t/Q9B6G1cNn0PKxPwgeMvgLkY4CC+zNFfbllYxvFP7e
	 stlUgU8s9eBMa3eX+wiHBCZnBDTBWZDkDL2LKaZSE+J1LD/d/XllwamIaJoB0UTd5o
	 4vCs0JBAKgQVUBqeYyHV3bCiA/Ib6PydzSWnSL8h2vlz8tZsBKD+5vhN5JKrs8xWcD
	 D74smc4svBJncjKVtnig6UcxRGX5LruNEZIf8/NGiqy37WMtkWeCg7IMq7B66uVUJI
	 Rg0GMAlju2+GQ==
Date: Fri, 6 Nov 2026 18:19:41 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v3 01/18] KVM: x86/pmu: Remove redundant Perf Global
 Status MSR bit definitions
Message-ID: <au4aNg22tUx2o4at@google.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-2-zide.chen@intel.com>
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
In-Reply-To: <20261106013927.166209-2-zide.chen@intel.com>

On Thu, Nov 05, 2026 at 06:39:10PM -0700, Zide Chen wrote:
> IA32_PERF_GLOBAL_STATUS and its SET/RESET counterparts share bit
> definitions with perf_event.h, which is the canonical home for Intel
> PMU bit definitions (e.g., PERFEVTSEL, FIXED_CTR_CTRL, GLOBAL_STATUS).
> Drop the duplicate definitions from msr-index.h and update KVM code to
> use the macros from perf_event.h.
> 
> Drop the comment as well, since the macros now match the MSR
> naming.
> 
> No functional change intended.
> 
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
