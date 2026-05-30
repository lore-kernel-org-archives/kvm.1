Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D772EA481;
	Sat, 30 May 2026 01:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102970; cv=none; b=PxBEopmVny4DABEl9E+HzOFqvoCmPKLVdOwJND6OfonTXMcT5NxWYaLMdPruqUfGW74Lplpu1UcD5AuKLCqnF6l9ecCc7JW4kI7mlf0fA7VQmGcx//kTigztV9XAC5VwDYzNuxYsTPE1/lZgxGMd5KGIr7KO3Wwq8UDkJbmhSQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102970; c=relaxed/simple;
	bh=oWMIEeiOB2pjET2nDy2dSwuf4cDVKCbfKnm59zvV4g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzGT7jhzdvsURDwlrywW5ECx6lWptttfTe7X3U4NAFRsHlpTq7t0/smwTwbi/l3/blOhD578+Oy+2IIJjcu+EbDS/W0pikckUh1XsJ/CMGdasQvL+pFmaQ85XKG9BZm1yTCFI04QQLN6Yoo5Vu7vW7+vqYau+Lz7naEfzy8enus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzSb0BJV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzSb0BJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCB21F00893;
	Sat, 30 May 2026 01:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102967;
	bh=oWMIEeiOB2pjET2nDy2dSwuf4cDVKCbfKnm59zvV4g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OzSb0BJVtEccvB9X1yyueaDLeQJuWVL33PkM4GbhakTr+a0C5HMDd3eqIu76hSFBQ
	 L1jp+QOBmN70GMe8femg51OxTH3hG7azaZPSIVGgsUqzoBYR/96NEFULJ8rfOKm2eT
	 nELtswBRUX3zvOj4wAclCEQpWjqsXCMGhRHyk8cqn0bAOQNMbUaQtitctdxkqReqhC
	 CnmUnBp1PWrlQrSoZV0C3zpQ2mFEHUxYlKX7BhTo4Wr2kimEBxDyzMOu81qiumL+gU
	 6ftkBe15z5tGfKDaIbGWFcFyrruEXGGlw61DmxVJ9rSqMvR4EkjdndIKPtXkY3X+M8
	 wC2A/i+VFRJig==
Date: Sat, 30 May 2026 01:02:45 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 32/40] KVM: x86: Move LLDT assembly wrappers into VMX
Message-ID: <aho2qWoPvqJV_5Db@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-33-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-33-seanjc@google.com>

On Fri, May 29, 2026 at 03:22:15PM -0700, Sean Christopherson wrote:
> Move kvm_{load,read}_ldt() into vmx.c, as they are exclusively used by VMX
> to save/restore host state, and have no business being globally visible.

But they are generic helpers. I agree with mvoing them out of
kvm_host.h, but maybe into another header? They don't fit in regs.h or
msrs.h, so maybe x86.h? *ducks*
