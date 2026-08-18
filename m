Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288D637F306;
	Tue, 18 Aug 2026 23:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787095361; cv=none; b=KjzNog7UH/ohnP9W/fh6CfbZaZg/0suphK1cwx01uhRGW+YitwDwR+9t5TF2WyndnrpKVTlZMA0tqiGhcfmTWvoSfe210Q9xjDPYJA09sFyml7M6rqxmMlIzfNE/JZbK8tBz/AszeP2PUkwN+25gOmHad5fCTytOD1Wr6s7acXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787095361; c=relaxed/simple;
	bh=V+RPYf5DW2LkIBuQPf0Ys5M8MaI+39ameaXCm3qXI1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdZU49tX0kZZrlkC1+QP3Pl4S8TCxDrK0HuCFm4c+tfx228O31shkS4imt1HbG2ok+7tA/iXx+q/9yGqWnOJ4s4gwJLYxa3Hr9GRU66WRlfsdA4jhUnkVJoqAH9NSmz2zC/ir5zwdMcb3nnQhkqIJ3+V6n0/Z7f9l4Or/b5xVS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IM3hmMoJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IM3hmMoJ"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9E6AD40E0406;
	Tue, 18 Aug 2026 23:22:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jNIFcsukPwEN; Tue, 18 Aug 2026 23:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1787095345; bh=6F9NJ06zTaDaftKmfYqFUJhweqBOh2WtQJJmduFwiHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IM3hmMoJhIWxLzLwhIkDJYhr2RmSU00H8NvctG1QpC67pHMXvTGjuiVs2yA/0jCrt
	 51/2BKdh39tXU62eprFSompCdqAykUZM2emCkknaemYsBBoOYlTiSsuktP67sVzVfG
	 GWNRjPUY8SilF58nQwWBPJ0V76pOoHc4WvVgtrnJI8Xlk6Kr8NmwYEZvlMl3k+v2RS
	 rFA4KUxE+QC6jHv7UsMuvXhgc1H0D6Wj33Bae5DZGDV/Aov+fYMHgp6mRXZ5jC8T5s
	 q8Pf+qXcnvjoX5xCQz9tazfHiKk70g8al4Ccmk6D8JuDqynV6HWl3tYg7OigcrZaoL
	 DpNkVG68X8vM3DPhx+r3OFYQtSmQFdBE1nlufJPsEVdyc4eOQZ6Nz2Ppm+FKHYHyI/
	 ncYb7zuiOn/gmEKeW3P9y9i5joVOuD2GiU57CTGThqKeQaeFHswwhUJ7xMYH8y6Hlp
	 q0lS+GTFF+Vfn8UOivSR1azSx4PKBb8NhBAFpkmo3gdcu7C9n45oWQXr7/GAvktoJm
	 fmZW0UfRXetEpWo9x5CPtGDLK8L48IChW3UHdiG0ewsfHV68edloP6QPO0fvMQMe2N
	 R5Lp6CUnPjqlZZ53qYN7Dmdg/a0oM23WvO1G3Ag5W+nlQN9KdVQIrIsH64kqYq1tVF
	 UYK7XFORZhv4BS8ePrKXZMHc=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9C08740E03FF;
	Tue, 18 Aug 2026 23:22:07 +0000 (UTC)
Date: Tue, 18 Aug 2026 16:22:04 -0700
From: Borislav Petkov <bp@alien8.de>
To: Kim Phillips <kim.phillips@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-coco@lists.linux.dev, x86@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Naveen Rao <naveen.rao@amd.com>,
	David Kaplan <david.kaplan@amd.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, stable@kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 02/10] cpu/bugs: Allow forcing Automatic IBRS with SNP
 active using spectre_v2=eibrs
Message-ID: <20260818232204.GBaoTpHK8k7wD9mMk4@fat_crate.local>
References: <20260804235611.4053375-1-kim.phillips@amd.com>
 <20260804235611.4053375-3-kim.phillips@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260804235611.4053375-3-kim.phillips@amd.com>

On Tue, Aug 04, 2026 at 06:56:03PM -0500, Kim Phillips wrote:

Please fix all your subject prefixes: it should be "x86/bugs:"

The tip tree preferred format for patch subject prefixes is
'subsys/component:', e.g. 'x86/apic:', 'x86/mm/fault:', 'sched/fair:',
'genirq/core:'. Please do not use file names or complete file paths as
prefix. 'git log path/to/file' should give you a reasonable hint in most
cases.

> spectre_v2=eibrs currently enables retpolines when SNP is enabled,
> instead of AutoIBRS (EIBRS) because the commit that disabled
> AutoIBRS if SNP is enabled stopped short of enabling
> X86_FEATURE_IBRS_ENHANCED.
> 
> Change the logic to enable X86_FEATURE_IBRS_ENHANCED, and move the
> decision to switch to retpolines in the default/"auto" case in
> spectre_v2_select_mitigation().  This allows the existing
> spectre_v2=eibrs logic to work as intended.

So this whole hoopla is just to be able to select =eibrs in SNP guests, *and*,
in doing so, cause a performance loss. I.e., shoot oneself in the foot.

Or is there another, better reason which wants this?

> Fixes: acaa4b5c4c85 ("x86/speculation: Do not enable Automatic IBRS if SEV-SNP is enabled")
> Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: stable@kernel.org

Definitely not stable material. If at all.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603121136.bc8zNsHS-lkp@intel.com/

It doesn't close that - that link points to something which is not upstream.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
