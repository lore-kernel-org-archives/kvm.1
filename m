Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDEE3AB26D;
	Fri, 15 May 2026 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855023; cv=none; b=WR+HSbMv7y3Euc05TtyggvYt7qkZDFsmlVHY+U8Th3gypfw/o5Zj4cAaWlFeG1YHu8WpporvIVyIjjZTxWlYhlZw0ih2uDaR7JosrJwtgjaE1QSO7xujrzQxE6y0K2ckEd9EUS7eYXfZMsBic3vjcvlK2ikumPbIj8j4gJzmC80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855023; c=relaxed/simple;
	bh=K0zGyPT3GJnIMpoD1nqDlzefGkmVWuDXpA5Jt2sXZyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kG/4wX7+biWLR14RyqaY3GeAbji1XHIJJ3aTKH6nidRLm1/NZlFgXUj850waQGAQdoOwDYLknn3xESuZMQQUQ+azy4pVbJwEXZVaXuuKvyKK7TyJd1SdgbXulRWKdDmDKngizvTfG8cZOsGFN6wdoyph7P0FJQbA38uaUDy7kjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPYmINNx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPYmINNx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04111C2BCB0;
	Fri, 15 May 2026 14:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778855023;
	bh=K0zGyPT3GJnIMpoD1nqDlzefGkmVWuDXpA5Jt2sXZyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPYmINNxek0Gkf865ZHOAbCOIrOq9+qz1uP8JrnkR6yeiYhOq1Klq/fglSPODAcq+
	 KBiDFmV3RBb8W54mFAcCyZYx9cHFt3Y/UITsiwbag46NWFsA64KU7oGEPDCKmfmJDv
	 sGCEmSUhIMSb3ZD57iGtb88ZFnJw/0psxc3m0r0n5WhmKS60xkoZR9Eh0hiisLFZu/
	 uDA+p4E+UGzDlm7v2wZ0QLj1za5H0BR00aUVDuu4r8VLQfXnYDvnHkGLu9N6D5qBAU
	 v4dMEkyD2lIwHubLSOLUyD/H5niOMMp4OuIs+zsDx0+dh403uzoIhgSK8rR/IWjemZ
	 PoKsnQmCAiQ5A==
Date: Fri, 15 May 2026 19:49:30 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] KVM: SVM: Disable x2AVIC RDMSR interception for
 MSRs KVM actually supports
Message-ID: <agcrLnljmHrXm7T5@blrnaveerao1>
References: <20260514213115.1637082-1-seanjc@google.com>
 <20260514213115.1637082-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514213115.1637082-3-seanjc@google.com>

On Thu, May 14, 2026 at 02:31:14PM -0700, Sean Christopherson wrote:
> When toggling x2AVIC on/off, use KVM's curated mask of x2APIC MSRs that
> can/should be passed through to the guest (or not) when 2AVIC is enabled.
> Using the effective list provided by the local APIC emulation fixes
> multiple (classes of) bugs, as the existing hand-coded list of MSRs is
> wrong on multiple fronts:
> 
>  - ARBPRI isn't supported by x2APIC, but its unaccelerated AVIC intercept
>    is fault-like; disabling interception is nonsensical and suboptimal as
>    the access generates a #VMEXIT that requires decoding the instruction.

Nit: unless you decided against incorporating the changes we discussed 
in v2, please update this part while applying.


- Naveen

