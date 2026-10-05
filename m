Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD5A42E8FA
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 22:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239644; cv=none; b=diki1rMqEEmanNxE38/o7r8jkUA5cItNnSTPPAJvjeARtviQN3lEVmhVX6Lkg/VeLuVsWIsJhAmo0rZaq/B28NIKNc99e0cEn/S+SAeG9nAq7LMsEXw7tmXIcOYQPHR+G8ClyJ7ZSLi5ptjY7P7oWGDKd6McNtWsoY3sRTCj2XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239644; c=relaxed/simple;
	bh=V1qsBrhvz7v25JC3ijOWpLP9V3s8Bt+LPOK287APpMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giYjUwdGuNvzT4UEVuu4eGYZ9gu561A49oDNS31XrLcQGMHlXaoCpM1xSBE7pilBT3mTrrIhv4AiqABgwMXQxyoCHUFvYeQjin0KQ1XP/iaw4csQkOhNj6yuUo4Omm1GxxJJQ1BY74YVb1TBRYby2NbLDNt1GiEMxXmHhZ1qEy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OuLgqaXL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OuLgqaXL"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so12775ad.1
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 15:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791239643; x=1791844443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OvVZJ9mVxE/RIGdj4jq/yHj7p5dyaauFgOlJsChu8aE=;
        b=OuLgqaXLfdhobFHLd6L+Yhmv2FFdW1EG+WhCStfvKK2SKcmEejINps9AISNNp1Oh0A
         9KXaHA7QyvzkMIW7pvrZqMGDUiWJ7rS4A3qGzzkk9zNDGALsQX9j6UjG8w1gHRXUOTmd
         IdXd1WcmPz28tLn8laV7mTfss/LTrmrOnCbSwb34Uk6BH1ZmUCoGTOu28dyeLx7OQcKQ
         bhcQqCdhPeHZLYA3dL32zd36oUV1sZzWVrRfCiGaUFV4A4CdDfS6uKDjTnHXBpa3w9GJ
         hrSkyPsdF4JvWG09kkYtbikj2N2iCMSXsw1J3pj4c3y3CdoP80RopWjuEa/1kIWVAyk5
         0I5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791239643; x=1791844443;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OvVZJ9mVxE/RIGdj4jq/yHj7p5dyaauFgOlJsChu8aE=;
        b=EWqz35XZfmIBVzNmxGy5DlW/TVKNmW6dsnTZl/GnA4e9/yaKExLm4hT1tyVkCbuGCZ
         EDaMRiKBSu53b6lWR/e+SPAsvfRilanXgSqIzrKrHWs8A3WLO/cDwxSRX2nPXhF5TH2W
         af9ksGHIZPhtjq8a5LlMWygoiIsWHl4mU3Xku57mdgf84+iXCnN3qyPlhH2I8vTk1cj1
         LydI4oZmo9ruMs8yUUqZ6xoYNTVXvKjG6bLL/3SghuOTuASPQKw+IKoz22erl2upmxa1
         pm737C0bxK7js7KcdqPZUvh2vdtMUhw/nRuFR5Bp2B0/OTQ97t8qxIgnysS9GEg/3MwB
         wEBg==
X-Gm-Message-State: AFq9FYJIcqVFycFplLyTdTkfnL29AbGi2dlGhSbr6EgVBFSM5dg/0xrs
	5UnJne/iAIGHws3NQQQl7K9v9KeHLs5O6N5zwW/SiCAftSYBm+Xo/+zbpk7MCTf0Rw==
X-Gm-Gg: AYBFou1gFrlNYzFc+TU7li1U+OK1XKS8r+FulLzpIbYYxD4HW2WVn0oLzafHbMLDXFh
	lECVouoo7EOcir1/lNhNCYX4UtFCQ009zszi84IDGnDZdDKfG+sQbFisetnMOMF5C7fIvh6e59v
	1rDz0wi2oMgYwVCZ0Rpfo8M6wUXCo4rAcCnWhp/mAOH98gfvF8X5YDimIvA1koM8JXfh7HPsnAk
	hL50FM6MXX/gTDy9zGzRyUdL7mxiwXY2xtXGO0wIdphOHsU33VR/OrAymvg8p4xuD4YnvxT76LV
	CEr/pcJZgdOHx5HkZE3eJAST8Idqer4FpRTWUk3y6gMv7UasxHoWa8z8ZmV6ZBMQypO3hqNpen8
	NrbZgS//Cm43dqfYzse73yJDORZWSc4nXPKgIgGpsTaYbHvCG0XNvFJ5ljkoiqczlHQ+MzCICSi
	/tlZXnGx3w3uCgMzAPH2KC7RIXubRsIH08IvqjI5/NCHriJ/cPWX/ukJX9JgJU6t57O42EESQGp
	kjHJuzJtoB3DybvvbWoK3VXFcKgd98b
X-Received: by 2002:a17:902:ea0c:b0:2df:8e89:3bff with SMTP id d9443c01a7336-2e5cd1f1170mr778865ad.17.1791239642076;
        Mon, 05 Oct 2026 15:34:02 -0700 (PDT)
Received: from google.com (230.0.127.34.bc.googleusercontent.com. [34.127.0.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853cb7cb3sm1489772a91.11.2026.10.05.15.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 15:34:01 -0700 (PDT)
Date: Mon, 5 Oct 2026 22:33:56 +0000
From: Lisa Wang <wyihan@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v15 10/23] KVM: selftests: Set up TDX boot parameters
 region
Message-ID: <asQl1OrH2vtnhHS4@google.com>
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-10-7c62a5d8a992@google.com>
 <20261002091329.9ACBE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002091329.9ACBE1F00893@smtp.kernel.org>

On Fri, Oct 02, 2026 at 09:13:29AM +0000, sashiko-bot@kernel.org wrote:
> [ ... ]
> > +	/* Set parameters! */
> > +	params->cr0 = kvm_get_default_cr0();
> > +	TEST_ASSERT(vm->mmu.pgd < (1ULL << 32),
> > +		    "PGD must be within 32-bit address space for 32-bit boot code");
> > +	params->cr3 = vm->mmu.pgd;
> > +	params->cr4 = cr4;
> > +	params->idtr.base = vm->arch.idt;
> > +	params->idtr.limit = kvm_get_default_idt_limit();
> > +	params->gdtr.base = vm->arch.gdt;
> > +	params->gdtr.limit = kvm_get_default_gdt_limit();
> > +
> > +	TEST_ASSERT(params->idtr.base < (1ULL << 32),
> > +		    "idt must be within 32-bit address space for 32-bit boot code");
> > +	TEST_ASSERT(params->gdtr.base < (1ULL << 32),
> > +		    "gdt must be within 32-bit address space for 32-bit boot code");
> 
> [Severity: Low]
> Does this assignment silently truncate the 64-bit vm->arch.idt and
> vm->arch.gdt addresses?
> 
> Since params->idtr.base and params->gdtr.base are 32-bit fields, the
> subsequent TEST_ASSERT checks evaluate the already-truncated values. If a
> test allocates an IDT or GDT address beyond 4GB, the assertions will
> always be trivially true because the upper 32 bits are lost before the
> check.
> 
> This could lead to confusing test failures during guest execution instead
> of properly failing the assertion here.
> 
> Should these assertions check vm->arch.idt and vm->arch.gdt directly
> before assigning them to the base fields?

Will update the assertions to check vm->arch.idt and vm->arch.gdt directly.

