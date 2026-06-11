Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B46E401A1F;
	Thu, 11 Jun 2026 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184191; cv=none; b=sppUqGdYDXBfxq0BJoIdDMDXB00yXJISIBNT0BDzQ70DeaT7bOukNVJZZ3SI2LfFWUmyZbo2hClJtq9A/Qi//EaljoFd8emwETnKxIL0DK4XyzTrqu/2Gw2BMbunoKgROKP6CG7lU8QseNCg/58nCOrOYihm9V80NtznSPHm70w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184191; c=relaxed/simple;
	bh=hixCuOP+ySBCzckKfNibOuF23IbnYUBHKudx2i0G3Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCVTR0z6ZU9KvB6xaYs3OYSIN9WBjv5qN8RWnhfFzArLxj8SCb5Ivzehk71YryBjr2hBk8IEBiV7RckJ+phW5XzgAQqY36ZGyvrCyRWVh9saNiX2d1E1PUJ5v7o+bk8Q+3sJA0cX/w211i+wbe4CRoYt38wf7R3vNEvGSpTBAQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3E6181C0ED1;
	Thu, 11 Jun 2026 15:23:07 +0200 (CEST)
Date: Thu, 11 Jun 2026 15:23:06 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coconut-svsm@lists.linux.dev, 
	Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA at
 SNP_LAUNCH_UPDATE
Message-ID: <aiqwjn2DVOumfr3T@8bytes.org>
References: <20260611123528.572255-1-joro@8bytes.org>
 <20260611123528.572255-5-joro@8bytes.org>
 <aiqtWVMqTK6vDoZ8@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiqtWVMqTK6vDoZ8@google.com>

Hi Sean,

On Thu, Jun 11, 2026 at 05:43:05AM -0700, Sean Christopherson wrote:
> On Thu, Jun 11, 2026, Jörg Rödel wrote:
> > From: Joerg Roedel <joerg.roedel@amd.com>
> > 
> > Support setting a VMSA in guest physical memory during the SEV-SNP
> > launch process. Only one VMSA can be provided which will then be used
> > for the BSP. All of the APs will not have a VMSA allocated or assigned
> > when this feature is used.
> >
> > This ensures stable launch measurements on SEV-SNP which are
> > independent of the number of VCPUs the VM is launched with.
> 
> This needs a *much* longer explanation and more justification for exactly why
> this needs to be handled in KVM.  I understand most of the words and acronyms,
> but that's about where my understanding stops.

Sure, how about:

For SEV-SNP VMs KVM currently allocates and measures one VMSA per VCPU into the
initial memory image.  Historically this behavior comes from the SEV-ES
implementation, which has no concept of a guest-provided or guest-owned VMSA.
So on SEV-ES there is no other choice than allocating the VMSAs in KVM.

In contrast, on SEV-SNP each VMSA has a GPA assigned and is (in theory)
guest-owned, so that the old SEV-ES behavior of letting KVM manage the
VMSAs causes several problems (especially together with IGVM-loading)
and inefficiencies:

	1. With the current KVM behavior the initial launch measurement depends
	   on the number of VCPUs the VM has assigned.

	2. Current SEV-SNP guest code will not use the KVM-allocated VMSAs for
	   APs. Both EDK2 and the Linux kernel will allocate and provide their
	   own VMSA pages for every AP. So the current allocation dance KVM is
	   doing is useless for the APs.

	3. The current behavior makes it impossible to implement the
	   IGVM-promise of a predictable launch measurement derived from only
	   the IGVM file and the target platform.

To solve these problems this patch adds support to measure an IGVM-provided
VMSA page into the initial SEV-SNP memory image. Only one VMSA page is
supported for now, which aligns with the IGVM requirement that each file can
only provide one VP-context. The VMSA will be checked by KVM for supported SEV
features and VMPL0 before being accepted.

When a VMSA page is measured in this way it will be used as the launch VMSA of
the BSP for the VM. For all other VCPUs KVM will not allocate or measure VMSA
pages, keeping the launch measurement in sync with the IGVM image. The guest
has to provide VMSAs for all APs it intends to use, which common guest
components already do anyway.

When the feature is not used the current behavior is preserved. The changes
have been tested together with the KVM planes patches and COCONUT-SVSM and
showed that using this feature leads to a launch measurement matching the
IGVM-prediction. 

?

-Joerg
