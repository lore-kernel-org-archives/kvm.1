Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B8129B78B;
	Sat, 30 May 2026 00:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102547; cv=none; b=WK16XiXVkFER3Z+imhiH0vNcYnXDEkB/jNdvhPBHRoRYVgftInE8Vyc91lDXQCrrFMWjPao6qn4XSZRbkqP6FVbR+cApVuh+xzkpuCahvx3fgrbXxyQUpkLK7BZcHPh8rCluZjQ79GJpCT8VdDOxQ6zQVigdm+bbmxW34EhmcPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102547; c=relaxed/simple;
	bh=7wpWA4uIRiJ9v6iKnnL6nXwGfRItZEbWFMFe/KMV9/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgJrElFV8z5w1H1d8yrREoCD7uUuSYcJrvlqNx5kKaUv4mPxWf/56A6G9uSQ8JPtcN/bgJNxNufkAR/KlL5uwzP8hGLBPW52ovxPsJZS2ZMHGKx6uL3IsjBGrir7nBLF/B4Lh4ukKd5estHiQmOPhSaT11j7L1ZkRwwRtMWrTSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNbGrpbs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNbGrpbs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808CB1F00893;
	Sat, 30 May 2026 00:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102546;
	bh=xVX6XObK4mCJuP4g1LTQtbRDfzi+wCd1Nsq3IJtXu1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dNbGrpbsS7D/WBqE2lJwojA/wWH1A6/sYvngfE6wAwmNSuf+TUXgIsZlREoTMmtSi
	 XHDYG0tY60I9uRcmYKL1RL6y7BsOTHytyp9miCS904M0x3e8BPfxXauvIPPZa6PCf5
	 5nEPVgfjQpXzjvMBIx/K/8wyH/wzmT8cMcaFWMV55SMDmPTP3JpVlh/uGgTt3EXzOE
	 6aMk03Wa3a2E3p/1OPkns9jsFObemADfO7ytyr2y1cePZ85Q+yRQUfmE//hbwXZu1G
	 9t4qhyWfo4oqzroV3ACTB2/e+Qr4ppzxGbbjoZqzeRoV+cFbURlyeT7Z+vHZrS8Yig
	 3Q4vLpkztfTCA==
Date: Sat, 30 May 2026 00:55:45 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 24/40] KVM: x86: Extract get/set MSR (list) ioctl
 logic to helpers
Message-ID: <aho1bopJWVy1QL5n@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-25-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-25-seanjc@google.com>

On Fri, May 29, 2026 at 03:22:07PM -0700, Sean Christopherson wrote:
> Extract the code for getting/setting MSRs and MSR lists to dedicated
> helpers in anticipation of moving the MSR code to a new msrs.c.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

This is nice. Aside from the spring cleaning, it makes parsing the
return values easier for KVM_GET_MSR_INDEX_LIST and KVM_GET_MSRS.

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
