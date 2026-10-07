Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA183FF886
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791400041; cv=none; b=F26zITXoakCr74VzYRHelV6cvD6sD/eRzt+VPIlEUGwfm2gyW9/c1aMY/xCoB7/XOgfzIqoB8b3UqbrMAlCeNWbSGyF06BtGKy0QpXJ+F69cawMBBwDiGVWYolvY2zlgrOjN7YXYvEgzGbPDKFWFUU4Bb04azDa7XEsUUhE1Q4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791400041; c=relaxed/simple;
	bh=Ykg5vHgeEHWQd7nv6+S7HdDvP8w3znf9GlqBCmXgna0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiM0yeblXJJg3yeybuyztGHGeCej9kqT8pRNUkOTOfvaaReJu3fBwP+gGLZKdDOo7bm6FCbxjR4aSDa1iwunD36Muwp/CxSJ2AoxntgQEFtmeAkwcW45Deu5sLMu92B3zIucL+OVRWanUMtpx9ekZJn1y7DuCIiCkiCyt/mhKco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rR58Un0I; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rR58Un0I"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2db33db4de9so12575ad.0
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 12:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791400039; x=1792004839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZpO++Lww0t5scaL6GXCwbq0i6uN65L3PPvCT34stxvw=;
        b=rR58Un0IVli6NQBIwRb688bFqc8W+ZrVL1UsE9iDWp0Tp66K0t4fAwovi6yOF4adRL
         WSdYonkVkfNU4GRgOtD+d3KlYuHNem3dg+aK/nZIUKFxE5/tmUmNfOPO/T97YrWmB65N
         q3y6hiuNVvvcmkNA44PDA5z9AyIE4jcK9qNKLwNifE1+MvABAjBNFEinnUOlQfjLDpSk
         ATmEuphhieTZQXefda1RDvog0q/UiNg2A1O2pMe0bYHNcwZuNJVUNoyrmF4tw1wfoFEP
         h7XkVQG4t7bo5biwMDx33iT/xFuVhghI2iGgbmyU9Vw24R93hmo52o1zseDmi+b7uFSb
         318A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791400039; x=1792004839;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZpO++Lww0t5scaL6GXCwbq0i6uN65L3PPvCT34stxvw=;
        b=ZshJP8K0uRmwr+HaR1JXBSCMfdLRP2GRW3u/t7JgCNsydI1ti+C4hFzZiSh3P/11h3
         Uvq3pR1vEBc/a/gTL8TfmzbZxm68GyUIOALm63AAO9bUudLNHhkvTGNwPii06aQobW7+
         zEeyUMdbi8tHOtYnJz7rP1fYH1zhpAdnrbOQHgI91lBS0a5b89H9ZV63OI4wB4cbNAas
         tI3rFzdRy18SNvf6BFKQXgNpG7aYZe0SEy1OM5sFHpIYw02l/F75g05z1pyfTahD5Jl+
         KHwFvc2j5MLEPC+8sfCRBaYKS7DcsEsA86VZw+FXvHEYAyz3x3S5Y3QLC7/H4fhRF9m0
         CsKw==
X-Gm-Message-State: AFq9FYKXh1VDsn8wu7lQ75EmJaMWsu58c/+s+lbsJMoPc2JhNisvZueF
	QSb1t4j0GJc45uyZ3rGy6G5Lk6km1xU7lSUn4wsUQyLcC52EyhipKfa9v+drmanKSFk5TYO4pmh
	GqBffUw==
X-Gm-Gg: AYBFou0SpB+o1jauQz1CYQ1ftO8Q/6Fz/oAPb4q+n/iZWRfuiLJyn13gGQrBF8zAqS9
	orsD1fqLxKaENZ7EeWVeeruzpod6zhRW/O2Li/0/TBaEcGPcox98oSa+yOU5aAu5tUMe7eT4yBp
	wmv6bFzUyOxxPsxEVZ8D2Seu9LStxt0X5vVU20m4CO0sWsfQ2KnXNM94V8LXsyi6z9BsrACSWN2
	Qsz7nh+B+AyiSZVvNV/zN9taPDwJ1JRsigPUbOogbjbv/kKmZPNQ6DW04fQ7uSYp58Ow6U8D5zu
	lGPZ83urGqHWQSqq/J+1IBqk8iCJveFh9colETKl2+SNTGk8XsetKvabNZFx5UNEOBFyFGlgtsg
	fRoyt8ITA87V2aDPTYKbOgZk1xn3JMoZBpXGpwfC3bzo0W1oWKypKy6FQzOtoGpzo5VhKNiaLQj
	j6Xo45WSBC+m8ilK3xxiw2gxpZIIfRy2SugUrd0dgm50f4bnoWUA1P8y9M8co/D5MznmfDmFZyl
	Qtpk0QNFS3l56nwJsW1Xp2dwk+Y6fU4
X-Received: by 2002:a17:903:40c6:b0:2e6:f400:5655 with SMTP id d9443c01a7336-2e7ff4c6f84mr638965ad.3.1791400038714;
        Wed, 07 Oct 2026 12:07:18 -0700 (PDT)
Received: from google.com (230.0.127.34.bc.googleusercontent.com. [34.127.0.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd0a9ba4f24sm2048447a12.23.2026.10.07.12.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 12:07:15 -0700 (PDT)
Date: Wed, 7 Oct 2026 19:07:11 +0000
From: Lisa Wang <wyihan@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v15 16/23] KVM: selftests: Load per-vCPU guest stack in
 TDX boot parameters
Message-ID: <asaYX9uk48uWISHx@google.com>
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-16-7c62a5d8a992@google.com>
 <20261002091336.EA00B1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002091336.EA00B1F00899@smtp.kernel.org>

On Fri, Oct 02, 2026 at 09:13:36AM +0000, sashiko-bot@kernel.org wrote:
> > +void tdx_vcpu_load_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> > +{
> > +	struct td_boot_parameters *params =
> > +		addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA);
> > +	struct td_per_vcpu_parameters *vcpu_params =
> > +		&params->per_vcpu[vcpu->id];
> 
> [Severity: Medium]
> Will this lead to an out-of-bounds array access in
> tdx_vcpu_load_boot_parameters() if a test uses a sparse vcpu->id?
> 
> The boot parameters region appears to allocate memory for exactly
> nr_runnable_vcpus instances of struct td_per_vcpu_parameters in
> tdx_vm_setup_boot_parameters_region():
> 
>     size_t boot_params_size = sizeof(struct td_boot_parameters) +
>         nr_runnable_vcpus * sizeof(struct td_per_vcpu_parameters);
> 
> Since vcpu->id represents the KVM vCPU ID (which can be the APIC ID on x86)
> and can be larger than or equal to nr_runnable_vcpus, could this write beyond
> the allocated bounds and corrupt adjacent host memory and guest physical pages?
> 
> This could be triggered if a selftest creating a TDX VM specifies a sparse
> vcpu->id that is larger than or equal to the total number of runnable vCPUs
> passed to vm_create().

In KVM selftests, VMs already create vCPUs sequentially with vcpu->id
(via __vm_create_with_vcpus()). TDX selftests will not test sparse vCPU
IDs either, because TDH.VP.INIT always initializes %esi to the sequential
0-based vCPU index.

> > +
> > +	vcpu_params->esp_gva = kvm_allocate_vcpu_stack(vm);
> > +	TEST_ASSERT(vcpu_params->esp_gva < (1ULL << 32),
> > +		    "ESP GVA must be within 32-bit address space for 32-bit boot code");
> 
> [Severity: Medium]
> Does this bounds check in tdx_vcpu_load_boot_parameters() actually work, or is
> the value silently truncated before the check?
> 
> Because kvm_allocate_vcpu_stack() returns a 64-bit gva_t, assigning it
> to vcpu_params->esp_gva truncates the value to 32 bits since esp_gva is
> declared as a u32.
> 
> The TEST_ASSERT then evaluates the already truncated 32-bit value against
> (1ULL << 32), which will always be true. Could this bypass the intended
> safety check and cause silent stack corruption and test failures instead of
> an explicit assertion failure?
> 
> This could be triggered if a selftest allocates enough memory such that the
> guest stack virtual address exceeds 4GB.

Yes, will fix in the next series.
