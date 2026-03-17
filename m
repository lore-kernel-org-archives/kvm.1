Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CF03DCD9B;
	Tue, 17 Mar 2026 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773757611; cv=none; b=u80VyUnfN72AabzccX1I5Nnby0+c6/3eK7VcxIBwzTX26UNerhrGgvkj/iF/GXjlMdSXYjhvXa5/tYoquX9oynqBEpe0V2ZuFfPizQ1/VwoPFeCec+P6lxQxnt9xbNSYIBhjkgHj73AJjXHzdhaZAOIgyOVdI738nE6Wnbb8lPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773757611; c=relaxed/simple;
	bh=UjydKJlj34kUol4ppfDG3TiHRRFoAGPYagH63svj1Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCq2WWolmSz8t3pGbZgt5+gc3aTLByI49zIBfog7qlYzLKg6hn/nm5ui9aqtpf45QePcSCCN1sf5LcAombL63XZw32snsgmL7pygXuJlZd0RCtn8M5pP2vtHZxD2mjb9JY38xPmEeQQB48vRi75PANsijZcRJxLB0GLBBZlbIh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=c+7kqts/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="c+7kqts/"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7BF7740E0223;
	Tue, 17 Mar 2026 14:26:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vraSQyI_RtED; Tue, 17 Mar 2026 14:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1773757596; bh=+7TqwGaUPI0mDCNsaN/lVPSsy28cxzljEg0Em52BW84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+7kqts/tbSrI166TbhJ2XzXL+JhUTxxzQC1RUD4bwJKhqJo/8wMqGlvD0AgVFDNq
	 OzrMzSyzJFsW+0quEChItc5iopWvgMXyfIPVH9ZrvJc9f2ZG+YnGvakFu2hspWUr1K
	 EMdjHOp5NgKxNEsaB/a13xmdCxeN3uQUhXiJyot5fUP0cbpyjJbjflxrP42MPPgRuV
	 0pM5P1VNJPkCjBtIkB/Ah47iXO0m2zLZkXW/YOJmWc/MfIwhmTvYVpOydqi36yptNy
	 dwl/r4qYmhU6LW0ESE6wOSPdE0XhSQ27r6QU+AAI3N524Lj+60IKCKn3tp+UyLbXMA
	 vkk3LxOuJKXLXRmuZtlDBsLn2/IbYsJn7iE4xbJZLCYn8ESJPHXB19sxW7yPaMGAZR
	 MWrlo6I49DneJxk1D0jbackxSZ+jvd8Lb5VT5odgHCY4XRqiHsy5/lqCxykqHd5rEy
	 MF4w9PyNUOeJTyiC+5rIaSOkDP7FmkdCabyGG2bVoPyUZEG7nX1n3m+RLkqyIo6wt1
	 KdotFrAqJ+csTIp93xE//xjFpADl/VA7AOGMWIqds88O/irrsvD6CGg0NG1RUqSyAa
	 VoXgGr5u7lPlDXHYLeOHA7jm4ymo9M9l4x66/emwftZJ7Vbsu0wXO0CvXjH0Sm1WAh
	 EppfQ0NUPlICW0arVEvKdCiQ=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7777840E0222;
	Tue, 17 Mar 2026 14:26:20 +0000 (UTC)
Date: Tue, 17 Mar 2026 15:26:14 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Nikunj A. Dadhania" <nikunj@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, tglx@kernel.org,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	xin@zytor.com, seanjc@google.com, pbonzini@redhat.com,
	x86@kernel.org, sohil.mehta@intel.com, jon.grimm@amd.com
Subject: Re: [PATCH v2 1/2] x86/cpu: Disable CR pinning during CPU bringup
Message-ID: <20260317142614.GBablkhuOGxFY7BRF5@fat_crate.local>
References: <505a6bbd-3ecf-4de9-8fb9-0b21c3435a96@intel.com>
 <9fa61b80-0e16-4a87-a0e7-3c3dfcda8f7e@amd.com>
 <55a98b6d-e831-47a6-aa5a-8fe357334f67@intel.com>
 <d0eba3fe-2938-4856-bd9b-0e13972e8313@amd.com>
 <cb492a37-3517-4738-b435-73311402e820@intel.com>
 <ddf407e9-359d-4d4e-827d-98f212589e9f@amd.com>
 <ab5bf7bb-6511-49dc-a65d-86911e0f7091@intel.com>
 <c13736a1-3151-476b-a91c-035383d2a29e@intel.com>
 <541cddbb-22b3-4865-a374-49ba3ba48a5e@intel.com>
 <2b33bf8e-5f19-46c7-b1eb-89fcf74d74f8@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b33bf8e-5f19-46c7-b1eb-89fcf74d74f8@amd.com>

On Tue, Mar 17, 2026 at 09:42:58AM +0530, Nikunj A. Dadhania wrote:
> 
> 
> On 3/17/2026 3:13 AM, Dave Hansen wrote: 
> > Either we change how alternatives patching works, we use some other
> > exception code, or we try and get CR4.FSGSBASE established as early as
> > possible on the secondaries.
> 
> Right, I moved FSGSBASE enablement to cpu_init_exception_handling() to 
> establish it early:
> 
> https://lore.kernel.org/all/1439b4f4-ff0c-4b6a-ac86-5c0da2d26cf5@amd.com

So this thing does the following here.

CPU0 goes first, the APs follow.

I think that should be good as a stable fix, unless I'm missing something.

We can then do our rework ontop of unifying the CR4 init and pinning but that
will be future work which doesn't need stable anyway...

[    0.132839] cpu_init_exception_handling: CPU0: Set X86_CR4_FSGSBASE
[    0.240204] cr4_init: CPU2, CR4: 0x3100f0
[    0.240204] cpu_init_exception_handling: CPU2: Set X86_CR4_FSGSBASE
[    0.240204] cr4_init: CPU4, CR4: 0x3100f0
[    0.240204] cpu_init_exception_handling: CPU4: Set X86_CR4_FSGSBASE
[    0.240204] cr4_init: CPU6, CR4: 0x3100f0
[    0.240204] cr4_init: CPU8, CR4: 0x3100f0
[    0.240204] cpu_init_exception_handling: CPU8: Set X86_CR4_FSGSBASE
[    0.240204] cr4_init: CPU10, CR4: 0x3100f0
[    0.240204] cpu_init_exception_handling: CPU10: Set X86_CR4_FSGSBASE
[    0.240204] cr4_init: CPU12, CR4: 0x3100f0
[    0.240204] cpu_init_exception_handling: CPU12: Set X86_CR4_FSGSBASE
[    0.240204] cr4_init: CPU14, CR4: 0x3100f0
[    0.240204] cpu_init_exception_handling: CPU14: Set X86_CR4_FSGSBASE
[    0.240204] cpu_init_exception_handling: CPU6: Set X86_CR4_FSGSBASE
[    0.240204] cr4_init: CPU1, CR4: 0x3100f0
[    0.240204] cpu_init_exception_handling: CPU1: Set X86_CR4_FSGSBASE
[    0.240204] cr4_init: CPU3, CR4: 0x3100f0
[    0.240204] cpu_init_exception_handling: CPU3: Set X86_CR4_FSGSBASE
[    0.240204] cr4_init: CPU5, CR4: 0x3100f0
[    0.240204] cr4_init: CPU7, CR4: 0x3100f0
[    0.240204] cpu_init_exception_handling: CPU7: Set X86_CR4_FSGSBASE
[    0.240204] cr4_init: CPU9, CR4: 0x3100f0
[    0.240204] cpu_init_exception_handling: CPU9: Set X86_CR4_FSGSBASE
[    0.240204] cr4_init: CPU11, CR4: 0x3100f0
[    0.240204] cpu_init_exception_handling: CPU11: Set X86_CR4_FSGSBASE
[    0.240204] cr4_init: CPU13, CR4: 0x3100f0
[    0.240204] cpu_init_exception_handling: CPU13: Set X86_CR4_FSGSBASE
[    0.240204] cr4_init: CPU15, CR4: 0x3100f0
[    0.240204] cpu_init_exception_handling: CPU5: Set X86_CR4_FSGSBASE
[    0.240204] cpu_init_exception_handling: CPU15: Set X86_CR4_FSGSBASE

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
