Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14F1332604;
	Mon, 18 May 2026 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127297; cv=none; b=giqKPY/u2nuKFtp6OpsTie/JgfX7TnYbxcgCdgQOvr1ImhjmjqgsDaSnx5bznHNnZCNnEehrqe4bDNpxcHtLupkcUKaMzu8K/YbADkw/ijUx/7a+iJq3eCawqe9N7wfn+iDNzhmzdiUBefmvusE4RYcPh6a8hW+1iRr9pY3jD1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127297; c=relaxed/simple;
	bh=NfstgrZ/sOStx6nz2DtXuuCKK9jSppbKaYpdNUwtlAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzIfoX+k0UBhQEXcBXfMBXp/YLK6JEVszXDPg03FUTAZqEvGpGYIt50PXQNZIB063NfNzvAnPbUIatD4Ot2fMnZRUAyRxomZ8WjooSzUJ4K2CEa4t6jp68lEvO1KVlVxWWTm4mFn28rW9P/uY/sgftrDpnNyYoFtyJw6MFO6X+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1VdnyWa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1VdnyWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DD0C2BCB7;
	Mon, 18 May 2026 18:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779127297;
	bh=NfstgrZ/sOStx6nz2DtXuuCKK9jSppbKaYpdNUwtlAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1VdnyWajM9Mxpq3WrXZsBjno3NHK5TpdxuPPUcVbMIdl9NtDmMy6taUL0/EOtwJK
	 MzRXO7ARP5/wUrmvGxDMIe6ov/ramC2XW8w1aleCoFXjPKziiTKDxhAgbzs7JDu3Od
	 zLK/nhRGzcGRbXmG9XM8R555gvVVriwhTi0R2ojPOGzGXhx0ANI/qLd48bclq1Q0m2
	 3WgGVcZ5BBBjTMRoaGLWRPHEOB9+j5hiCnR1Gnsc4/V0tJpGw0CnsyTf2GG2cqnFrL
	 m9Uqs4UySYgYwcurJPBFtHuEL4UUrf8Qv9JJ2AWgTL+ugcyDzNRmaFKI+ISaeHObsj
	 q1Xj0TjdXSsLw==
Date: Mon, 18 May 2026 18:01:35 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH v3 02/10] KVM: x86: Capture "struct x86_exception" in
 inject_emulated_exception()
Message-ID: <agtT9E1k-WIzvB9t@google.com>
References: <20260515222638.1949982-1-seanjc@google.com>
 <20260515222638.1949982-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515222638.1949982-3-seanjc@google.com>

On Fri, May 15, 2026 at 03:26:30PM -0700, Sean Christopherson wrote:
> From: Hou Wenlong <houwenlong.hwl@antgroup.com>
> 
> As all callers in inject_emulated_exception() use "struct x86_exception"
> directly, capture it locally instead of using the context.
> 
> No functional change intended.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
