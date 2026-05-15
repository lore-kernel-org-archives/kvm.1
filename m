Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3A33AB26D;
	Fri, 15 May 2026 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855019; cv=none; b=gWvI/8W1Kzs9zME5Bb0ygkWwXODzfr5B4sqfv03gk2MqM/PVDENUZHobShKv/ssq3mhyo42HHrdOLQr3LCvYEwsgBXgipLnWuMrAjzJdv9xw1HiF/Y1fcwrI/mOnQHPoofdDotacjDdQVCRD4C+gJ5jTdW2+/MApxjzxdQaORNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855019; c=relaxed/simple;
	bh=zdF8oTk+rT8s6/nNemapq2ROP6paHx9NzGDLnR0Bu3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFsUNsxshRvDArpeO0YgHqlPf9RsygD1sIFbqtEVSskolEPnwefZSJuyau/TEwZh+SFIHW0AfVMW4AN6tjXvcCYil5XQLe7R4kvuTfotVm2yFGnS9qZw+YtwhOLQQmYpJ0u/Ld+qxKkhkjmz4ByU99QjWuVy5BahMFEt/MPP2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEy+68Mr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEy+68Mr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A6AC2BCB8;
	Fri, 15 May 2026 14:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778855019;
	bh=zdF8oTk+rT8s6/nNemapq2ROP6paHx9NzGDLnR0Bu3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CEy+68Mr6DndMC/jlPoPqs4O+b7EEdgiSDVOCaTJKbz9WnfxYsF1/h07IuJ/NOG5x
	 AInRndsLqF55f9XIHFoMU5J/9GPx9zYwb2tTmsLOM+V5HO1u65AVgQXO18yW7k+CT6
	 YoIDX16jYsr8sXN6a3G0CCHAItyb3y/zRRCZBJlnN3YN2dsFB5tB2cu/KQ5bVfD7Pz
	 4JDH8lbrBRbYBj6fC3OaeDj5DchBjOkDy4grq7UmDIPUDEQ7dF+oc6BMCUOqSxtLfM
	 s2VnVF8+6HeCiZ0N/VIuwGmhzy01Bmyz7uv/JWGJAZ55CfQhs6IGDrkYSK3luahQNB
	 wR+RMPaRss/CA==
Date: Fri, 15 May 2026 19:48:20 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] KVM: x86: Add dedicated API for getting mask of
 accelerated x2APIC MSRs
Message-ID: <agcqzZnsYiN2BP6T@blrnaveerao1>
References: <20260514213115.1637082-1-seanjc@google.com>
 <20260514213115.1637082-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514213115.1637082-2-seanjc@google.com>

On Thu, May 14, 2026 at 02:31:13PM -0700, Sean Christopherson wrote:
> Add a dedicated local APIC API, kvm_x2apic_disable_intercept_reg_mask(),
> to provide the mask of x2APIC registers whose MSRs can and should be passed
> through to the guest when x2APIC virtualization is enable, and use it in
> lieu of the open-coded equivalent VMX logic.  Providing a common helper
> will allow sharing the logic with SVM (x2AVIC), and as a bonus eliminates
> the somewhat confusing code where KVM enables interception for MSR_TYPE_RW,
> even though only the READ case actually needs to be updated.

I thought you discarded this patch based on your response to v2. I now 
realize you were only referring to not unifying the WRMSR interception 
paths (d'uh!)

This LGTM.
Reviewed-by: Naveen N Rao (AMD) <naveen@kernel.org>


Thanks,
Naveen

