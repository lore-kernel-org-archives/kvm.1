Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2775736AB57;
	Tue, 21 Apr 2026 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776812900; cv=none; b=L0rWxDriJiBKkGT8kHKCGGMJ9cQTi6QiXiNaM1T9LxX3yYQw4JR8O5vQnAJaK+zJrrkKfaQlHfdmVgU5bawA/AkqFlkaEqLh4V/3EKOsWv9d68CxgwMzLXgdpvjoyQDbP3niK7jf/qdJQje9szKPGdZscQHfHXLFVA1I4Ys+68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776812900; c=relaxed/simple;
	bh=3haRLR32clrUrLelGZTHqQcAvYqt3tzlUROwSRS6gLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSL2M5nGSbK76DQLbuM1IrPE4m26SIzvY/OfcelvJpahHVRf6ex7oeYCil58otDudvpae28zZeBNQXb62usJfzWIr9oe7a3CVt8LKfPg8yP2ROIWELk3GOo35CGCmX5ag9CD6whF1S+1f1beQg0iNDRWSXinX4XKTTmzsHGwbEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QimX6+fh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QimX6+fh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31973C2BCB0;
	Tue, 21 Apr 2026 23:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776812899;
	bh=3haRLR32clrUrLelGZTHqQcAvYqt3tzlUROwSRS6gLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QimX6+fhUsP2TXEKtnM74nt1kfQkSnbLJfPabpsF5HVm6D93J8N5hjDfq0rDA1mvu
	 RYu+cQ7APnPg+82feP1kAsBIU17u6sY3fhQJUfOB2XCMcBG2b/WUdTDtYNk0zFOkBe
	 lR78a/fkmg5zTECg2FwXISf5diqacoDRSIKAX3DlC04Hy5JhaQ4QupCj9bfMa5yOnm
	 3OfkL+r1PU8Yu9XI67xU/B7AFPxe4IHSd3bzP/Bb7SQ+WD6dgeGeLbGutcVXUbobUm
	 7Aah1UVsPUFWMbtO3K+vKkjKzMYTNcDqXDfbqQA5HX6V+yJZHnm3/iIA+nvje//Tgr
	 4a3icoU8O+Nbw==
Date: Tue, 21 Apr 2026 23:08:17 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Peter Fang <peter.fang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] KVM: Take gpa_t in kvm_vcpu_map[_readonly]()
Message-ID: <aegDJssx-ZvbfggI@google.com>
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-4-peter.fang@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408001137.3290444-4-peter.fang@intel.com>

On Tue, Apr 07, 2026 at 05:11:30PM -0700, Peter Fang wrote:
> Move the conversion from a gpa_t to a gfn_t into kvm_vcpu_map() and
> kvm_vcpu_map_readonly() so that they take a gpa_t directly, reducing
> boilerplate at call sites.
> 
> __kvm_vcpu_map() still takes a gfn_t because guest page mapping is
> fundamentally GFN-based.
> 
> No functional change intended.
> 
> Compile-tested on x86 and ppc, which are the current users of these
> interfaces.
> 
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> ---

I was going to suggest a WARN in kvm_vcpu_map() and
kvm_vcpu_map_readonly() if the passed GPA is not page-aligned, but Sean
usually hates my paranoid WARN suggestions.

Anyway:
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
