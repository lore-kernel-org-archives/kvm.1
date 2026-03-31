Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817EF27FB25;
	Tue, 31 Mar 2026 02:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774923769; cv=none; b=EkYujW9rxyNGyF/FkosmvMb/+lo8iQNPmHDHYAcgED8KNYCuVsjMUAw9pXvzSJqaqoZGv73VhMcO5maGzR/HMyFFa5JbOsC1/q+oVmahywCkxSTeJOCmgJBsGDCEJ8asq2iZ1pR8y7gJaEcjg5Whps+9ZV/hHMpGF+yspu+qtsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774923769; c=relaxed/simple;
	bh=l7yJ68saVTwIij/720EHHZQ7SKACJi+dA14H4Iz/0NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIu+hStoHGOtpzwAgDre/ES3ZPT22rXyglKQ8Bc5uNUZ5Tig9AAcDvF+5fnchTgzrQTnkuS3vlCauTEXmtxK+aC38o/iBWSkqXbqLlKqj+RT+4XukEIuh7Irrf/aKD2RH82NIgRUD3SrPc88Hl8UnxNFUQj3FVTb3YLxLMntXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKyITreC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKyITreC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3C9C4CEF7;
	Tue, 31 Mar 2026 02:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774923769;
	bh=l7yJ68saVTwIij/720EHHZQ7SKACJi+dA14H4Iz/0NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKyITreCFvpgzleJDzSfojc1RUx0rh933wIM/DxrEJcU+2OMUZsSJeZEjJ5Zo7ccc
	 Jv9xUS9s0iBiOl801QOPyyG/eWFZhYPkYbZIRoqnG9Bb4x9JtmCE38Uq5hzk4d1by+
	 cPfDSMyTh2b8VZtaYu92AD4ejaU1OVCp9HoB7V9wOZJsbrsd/bu05xczdY4/8JVyCE
	 zLi89KFGZKVjXNAPN5d4jQ1a+ife3KXkJbyrEJSdiLm1I11ZLaHwY716c8Ffng+FWr
	 FNtFkKfbbOY6866B8SBRM+HuAYzBzP+rO607pNwTQIKnB/DKGGKG/LHN/odixoKzYh
	 7fc3cDep3FpAQ==
Date: Tue, 31 Mar 2026 02:22:47 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Peter Fang <peter.fang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, KarimAllah Ahmed <karahmed@amazon.de>, 
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] KVM: Fix kvm_vcpu_map[_readonly]() function prototypes
Message-ID: <acsvbxIdtlQzUw4q@google.com>
References: <20260325092001.613025-1-peter.fang@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325092001.613025-1-peter.fang@intel.com>

On Wed, Mar 25, 2026 at 02:15:11AM -0700, Peter Fang wrote:
> kvm_vcpu_map() and kvm_vcpu_map_readonly() should take a gfn instead of
> a gpa. This appears to be a result of the original kvm_vcpu_map() being
> declared with the wrong function prototype in kvm_host.h, even though
> it was correct in the actual implementation in kvm_main.c.
> 
> No actual harm has been done yet as all of the call sites are correctly
> passing in a gfn. Plus, both gfn_t and gpa_t are typedef'd to u64 so
> this change shouldn't have any functional impact.
> 
> Compile-tested on x86 and ppc, which are the current users of these
> interfaces.
> 
> Fixes: e45adf665a53 ("KVM: Introduce a new guest mapping API")
> Cc: KarimAllah Ahmed <karahmed@amazon.de>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: Peter Fang <peter.fang@intel.com>

Most callers are converting a GPA to a GFN, I wonder if we should make
the function take in a GPA instead? But then we'll need to the GPA not
being aligned to a page boundary (either do gpa_to_gfn() in
__kvm_vcpu_map() or fail if it's not aligned).

Not sure if that's a net improvement, mostly thinking out loud here.
