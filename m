Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF69381AFA;
	Mon, 18 May 2026 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128534; cv=none; b=ixyhSTI1Oj8pV/IGKpShRyb5o0VBCHhp8wlD5BV1Dt95L7LGutfhFDXOM6TAuBvSCnFBkI2u1X5nsKznIvOxfanhHD/aCvsifdnSo9qkxpuzvzEPrOlWOK2MX/W3wWV+X17dp6EBLoNhSaO3lcRw4J0M6+IZHITDmFKcQziNMbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128534; c=relaxed/simple;
	bh=+NvXvC+YT48JL6Rgv50EnOnPJbE6ITLsaol+8fLu5t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqvw2G8cDkx7mOfwTcAAcHQohuu24jO2VbXc73J5YwFqWPkd+BFOG85S5cDp0XyOTejNHqMb5HVGv1Cj3IQmeiQWHVIV0SpYBJBEYl8U/92KgmHNJS2uy910MSF2q97fEfxOdN1hJkxd0Q4R1JUxsd85gqEaLceYf7Lvoa6IghA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzOjik5f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzOjik5f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16E2C2BCB7;
	Mon, 18 May 2026 18:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779128533;
	bh=+NvXvC+YT48JL6Rgv50EnOnPJbE6ITLsaol+8fLu5t8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gzOjik5f4gV6ctKrvo25vRFlndJifXR2+Y9Xr4WS5RmH2Uza0IdC9A9VwlIjkMeLO
	 rTNmpf6XGZyV4tynA8RG1By6PEX5dWbbmWvhCXDmiacHw6o70TaEZA8TlckmlErhBK
	 r8a8+hDkFyNiBdzmPhlR9TWUFyvFTrCDvjXxtAnKf8uNj5+jEZXDLIKkEtzK8zF1xN
	 UVLATyUUzFclVHMhdz+jCg9PGBctxJYkP/CSxPuAk9XkkoZ8rDZpZdd0G35uw/55/e
	 +38UiUdzzJJjPyOZWy7WMBtUqJXaLPRo31FBT72KSnbxJvBndsky2WWWSJ1HP+Xfgi
	 jyXRnlyp40e/Q==
Date: Mon, 18 May 2026 18:22:12 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH v3 06/10] KVM: x86: Move KVM_GUESTDBG_SINGLESTEP handling
 into kvm_inject_emulated_db()
Message-ID: <agtYzStJRB3z1gki@google.com>
References: <20260515222638.1949982-1-seanjc@google.com>
 <20260515222638.1949982-7-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515222638.1949982-7-seanjc@google.com>

On Fri, May 15, 2026 at 03:26:34PM -0700, Sean Christopherson wrote:
> From: Hou Wenlong <houwenlong.hwl@antgroup.com>
> 
> Move KVM_GUESTDBG_SINGLESTEP handling from kvm_vcpu_do_singlestep() into
> kvm_inject_emulated_db() to dedup the USE_HW_BP vs. SINGLESTEP logic, and
> to allow for removing kvm_vcpu_do_singlestep() entirely.
> 
> No functional change intended.
> 
> Suggested-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> [sean: massage changelog]
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
