Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E053D37AA81;
	Tue, 21 Apr 2026 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776812735; cv=none; b=UoaX4wDbLrYuuVobmvzsAOQ0WdktT0une4IUl6uKpkNz/bXCDKcVEH8x7XcrKP49TDG8NSo5mvy/62fAcGaGvipDZARMRX2yvjyufp9BOWVMSfro9x2seknZlso5oSbgw3bcCXhcBkZpp5KOznvQa+jdNfq0P291Too6zIzKLLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776812735; c=relaxed/simple;
	bh=z1GjpyCzOqlqSWUtL6FZ2ZzqvyWbTkYx0VfbXFhH2ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APlAARIGl4Ygjl2e/me/wivpfVpERqo+ShsuCyy/6+nJYAIidrI+l8iq9Xl+8uBMD/3XoLMAOzc2EFEXn3OUD15K5jpzqaKeNPC1fH4taxyQu+xAO40xlvbV4KC3p8sfT/zbLg1wW8ZDY+9dczpKF2l5E5uRZ5z4YNTMVSFXCco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNn2AdNS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNn2AdNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0715C2BCB0;
	Tue, 21 Apr 2026 23:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776812734;
	bh=z1GjpyCzOqlqSWUtL6FZ2ZzqvyWbTkYx0VfbXFhH2ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNn2AdNSNu9pm+CpZmzNYnVdWGsUx4ElgwpwT5tyl3ZbxBXnR3W5caZotDQ8KW+77
	 Qb4Oq/GPi9+1HPO5dM7vjMJcEgx1uwcesf2m9dtjLR2lRAcl/DgAZFPeWnclcMvzfK
	 1S622cN1WegX6iUDG2CyagYoyZQUGGv2bWoGwEz3VfY/ScmVOTrJoy5ZZYr9FhAIO5
	 wSYQnhTbnBKD0seKDLwGIcLBb/0DYZMM47da/y0tLsHyof+ExyAkHGqx+DPNjZyklo
	 YebH/drrNRznIMOqumn30sGDrUX/pEixBgJR4l9XmJto0B843W5vuoAOjVlZbfIA3i
	 /VhMygYk5ZZsg==
Date: Tue, 21 Apr 2026 23:05:32 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Peter Fang <peter.fang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	KarimAllah Ahmed <karahmed@amazon.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v2 1/3] KVM: Fix kvm_vcpu_map[_readonly]() function
 prototypes
Message-ID: <aegCsnPq3-P6XBWp@google.com>
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-2-peter.fang@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408001137.3290444-2-peter.fang@intel.com>

On Tue, Apr 07, 2026 at 05:11:28PM -0700, Peter Fang wrote:
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
> ---

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
