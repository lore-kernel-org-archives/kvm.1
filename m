Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D908639F19C;
	Thu, 28 May 2026 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959652; cv=none; b=Ur50P9Zst8hqK+LmQo85VZyOkFxJiLh292EzJhztUvbNlTem+Mg2TKr7RmAxV1K+iNBRGV1v1wGvG6rjk9aEXvtIY8J7Xud6xqYuDPcOL/5Ef94vN9Y/3FnDA9Ce3E71X0FYrIX++nmH2AO3rnxdvFEW2eaZnM1vHmzYC1Ij4+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959652; c=relaxed/simple;
	bh=w28/NLSOinSMPP+1tvL9Dl5oRjwyEiLhpPelKf+xu+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiGioGFGDhWTHUSrmOg+rjmuImq47bIrOUrVgll3AqwdZiJpl4YLSapgOZWgn7ZYsB3uIxWP6YTYsZ/pSvWoQ1p/jq/nM7s1NNCFIpVANLUr2fWNTlG0vHNSERFJbPCQ7M/fLrk1THPZ2hnlHO2v46SYXEowViCVAER3RyKS4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FN+ny1hK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FN+ny1hK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hGZwpCwXYSSUIy+25+lFmaLZVZeriPO/Fr8Ud8SrJCM=; b=FN+ny1hKdlDKUxYy+mqduuhAfZ
	g1DdAU8U+PGpawqej/rSpEpQq6Cr3s9EyDsaMDorQCOH7VGdrLJIcRFadMGK/JXiPfkRzozdR1Pju
	EXuuOuoKk4KRqtGA5gBN/F6Wc4r/ii7G/7YKhEv5Rx1Eeji1seny50A3Oj23CxBjgh6+xD6MY8NtQ
	IjfO9LTkPJrclIhAFkpGlSWHWGhlKfWXXKrBVLl/O0797ODhQDT1VbE4hDsWWY3fQQ6wewRTOyJ6W
	CeR2QTYPJ5kcnuudNd8PnsXrtDMF0TkeVIBRQHkXIUIuNXpN1oD1mmnwMeU5hnXj3ekPfXDldRYom
	dk+EYW8A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSWoQ-0000000FxZM-1RPH;
	Thu, 28 May 2026 09:13:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 56B26300CDE; Thu, 28 May 2026 11:13:57 +0200 (CEST)
Date: Thu, 28 May 2026 11:13:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jim Mattson <jmattson@google.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, shuah@kernel.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, ctpence@google.com,
	David.Kaplan@amd.com, binbin.wu@linux.intel.com
Subject: Re: [PATCH v4 1/5] KVM: x86: Consolidate CPUID fault handling for
 emulator and interception logic
Message-ID: <20260528091357.GB343181@noisy.programming.kicks-ass.net>
References: <20260527174347.2356165-1-jmattson@google.com>
 <20260527174347.2356165-2-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527174347.2356165-2-jmattson@google.com>

On Wed, May 27, 2026 at 10:43:43AM -0700, Jim Mattson wrote:

> [jim: Add EXPORT_STATIC_CALL_GPL(kvm_x86_get_cpl) so that KVM vendor
> modules can call kvm_is_cpuid_allowed(). Fix typo in commit message.]

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 1578c0ecbbd1..72bd3cddb026 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -151,6 +151,7 @@ struct kvm_x86_ops kvm_x86_ops __read_mostly;
>  #include <asm/kvm-x86-ops.h>
>  EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
>  EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
> +EXPORT_STATIC_CALL_GPL(kvm_x86_get_cpl);

Are you aware of the distinction between EXPORT_STATIC_CALL_GPL() and
EXPORT_STATIC_CALL_TRAMP_GPL() ?

Specifically, the former allows modules to do static_call_update(),
while the latter does not. Whenever possible use the TRAMP thing, this
allows modules to *call* the static_call, but not to redirect it.
