Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEEF39A047;
	Wed, 17 Jun 2026 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702942; cv=none; b=cXfY0dbWVMx17iIbD7ZAey1Uc826c+hnpqbug//gA5pGXZs117GgSIMq30Ue7WO9hn1VS1qaOjOebawrAHpV1VSas55cSzpF5SoO4jxiT4CDWgMTti2fbBUlAgRLKRRTRCBjYNa0BohEMZkMIzVnoYmQs8RH9ehFVXhSTbH96vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702942; c=relaxed/simple;
	bh=rTAbV5IExdhEhSxmWypiQA+mir1L/AOaYj4qmQwcrWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QU+IidUaYbJwN2DeDC2cj+7tT1XRDwsv5PgrV9MAI67G59iLW3RyTmDj6Mt12hCAF440MburLwXCtS1wUiENS/dwDjm+owcMj8UQ9nSsv8hR1kk5ZN3easgD+gWffxit/XRY/ZmWRlx4/FmUaCig8FUOd25En3HbA9Uqnd749hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 2D2722027B6;
	Wed, 17 Jun 2026 15:28:58 +0200 (CEST)
Date: Wed, 17 Jun 2026 15:28:57 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	coconut-svsm@lists.linux.dev, Joerg Roedel <joerg.roedel@amd.com>, 
	Jethro Beekman <jethro@fortanix.com>
Subject: Re: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA at
 SNP_LAUNCH_UPDATE
Message-ID: <ajKgbpVpMMP2a5nG@8bytes.org>
References: <20260611123528.572255-1-joro@8bytes.org>
 <20260611123528.572255-5-joro@8bytes.org>
 <aiqtWVMqTK6vDoZ8@google.com>
 <aiqwjn2DVOumfr3T@8bytes.org>
 <ajGOELiYwKByXbVP@google.com>
 <ajJAYZAPxNrrsiYp@8bytes.org>
 <64383a438eb79a30588f2737a6df84f9d4cd5b7d.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64383a438eb79a30588f2737a6df84f9d4cd5b7d.camel@HansenPartnership.com>

Hi James,

On Wed, Jun 17, 2026 at 09:18:14AM -0400, James Bottomley wrote:
> That's true for the launch measure, but you do have a vTPM inside the
> SVSM which you could use to measure an updated GHCB if we could decide
> on a PCR to use (and a logging specification).

I guess you mean an updated VMSA? The guest-created VMSAs are trusted because
they are created by trusted code from within the TEE. There is no need to
runtime-measure their content, no?


-Joerg
