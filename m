Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2337C37755A;
	Tue, 23 Jun 2026 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214615; cv=none; b=ROd8pvB333HMOBW4mkz/WcpfSpyZquw7sIPmZBvu3bTt+VMp2rji4gwzD1x87jzwLdEmMZr9v0kliyQONsheR0v6b5mzDbdH9ostFXPu9b61a6Emd8spcZQ28Cmup5UZOhLifb9IyXCghNUPw/pQseT07aeB3JQFOGaDVQQazWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214615; c=relaxed/simple;
	bh=J7HeE0/TvFGpDDvdOoROjlenIn1RN/E13O8H32BUwws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBzfPOt3CXGrLb6QxJ55Ufj7DWdUI9WX6lF/pWSJWgUUVdAuRQR/O1CrlGJuQh3Y4g+2LW1Ph7JbSyWGXduhvip2Cmz+GKtQ5J9jMUduAun8++s4j8d1i5heUBErTP/Oh7vPDVfVLfkQvtr1BqROX8d80dd/4BfrPsHiAfzqhnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc500d0ea9295aeb63767.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:d0ea:9295:aeb6:3767])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1D32A203E21;
	Tue, 23 Jun 2026 13:36:53 +0200 (CEST)
Date: Tue, 23 Jun 2026 13:36:52 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, Michael Roth <michael.roth@amd.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, coconut-svsm@lists.linux.dev, 
	Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH 3/4] kvm: svm: Support guest-provided VMSA for launching
Message-ID: <ajpvaYDwLhDX80aE@8bytes.org>
References: <20260611123528.572255-1-joro@8bytes.org>
 <20260611123528.572255-4-joro@8bytes.org>
 <1035a0d2-9239-4cf9-8606-6b1d34efbf00@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1035a0d2-9239-4cf9-8606-6b1d34efbf00@amd.com>

On Tue, Jun 16, 2026 at 04:48:20PM -0500, Tom Lendacky wrote:
> On 6/11/26 07:35, Jörg Rödel wrote:
> > +static int snp_init_guest_vmsa(struct kvm_vcpu *vcpu, gpa_t vmsa_gpa)
> > +{
> > +	/* Only one initial guest VMSA can exist (per IGVM) - so it belongs to the BSP */
> 
> Maybe expand this comment to indicate that none of the other vCPU VMSAs
> are created by KVM, that the guest is responsible for creating them for
> the first time.

Okay, updated the comment.

> Which reminds me that you will need to provide the GHCB APIC ID List NAE
> event support. If OVMF was ever to be built as an IGVM file, then
> without that GHCB event support it will perform a broadcast INIT-SIPI
> for the first AP startup, which will fail because no VMSAs will have
> been created. If OVMF sees that the HV has advertised the event, then it
> will create all the VMSAs itself and use the GHCB AP Create NAE event
> for initial startup of the APs.

Right. Currently the GHCB APIC ID List NAE patch is part of the KVM planes
patch-set, so whichever patch-set is accepted first should include it. I will
add this patch here as well when posting v2.

> > +	gpa_t initial_vmsa_gpa; /* Optinal GPA of BSP VMSA - SEV-SNP only */
> 
> s/Optinal/Optional/
> 
> Should it be called bsp_vmsa_gpa ?

Yes, that is better, changed it.

-Joerg
