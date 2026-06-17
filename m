Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5232DEA75;
	Wed, 17 Jun 2026 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707498; cv=none; b=rSvlxFMmcFVcVriomXtkiQps9u/L5W0w9VYPywvGzRB3/AYuN3opKKPBDKZnxYUXCSbN0PEyPCr69LZzgymQZhtdRWg+jMrEFF2VwlvpYppOhKh85OvKlZ1K4EmUQkZSdevzfVaW1H7P0aa0k187mvwub3huVWhXr9JyVzyIjn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707498; c=relaxed/simple;
	bh=RLEgHEDXzHNW7FwmiSVWkAW/EZIVgxKRer19wh3NgRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCMvlLlKdBB0I4kh75wxbHsw6ImNPF2tG8rptvhZBSGzm/r/ZHTDrWirU+anPaRqsq5TjsP5woAsWmlhFUVB70pJrVi5dM4Xcj5p2YuIFZqrxtGidxSrcbvoQi2UVtetXZDRkWjZl9tvyaF6FSVnMNTUPUJuoToOgkeNe7voR/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id EEF362027AC;
	Wed, 17 Jun 2026 16:44:55 +0200 (CEST)
Date: Wed, 17 Jun 2026 16:44:54 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coconut-svsm@lists.linux.dev, 
	Joerg Roedel <joerg.roedel@amd.com>, Jethro Beekman <jethro@fortanix.com>
Subject: Re: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA at
 SNP_LAUNCH_UPDATE
Message-ID: <ajKnKeo1FV3zbjEt@8bytes.org>
References: <20260611123528.572255-1-joro@8bytes.org>
 <20260611123528.572255-5-joro@8bytes.org>
 <aiqtWVMqTK6vDoZ8@google.com>
 <aiqwjn2DVOumfr3T@8bytes.org>
 <ajGOELiYwKByXbVP@google.com>
 <ajJAYZAPxNrrsiYp@8bytes.org>
 <ajKadxZEMI253AoT@google.com>
 <ajKe-oboTRowcO_i@8bytes.org>
 <ajKjMIBb21qB46fh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajKjMIBb21qB46fh@google.com>

On Wed, Jun 17, 2026 at 06:37:52AM -0700, Sean Christopherson wrote:
> Ok, so it took us a few times to learn our lesson.  I still don't see that as a
> strong argument for new uAPI, especially not for VMSA pages.  I am very firmly
> of the opinion that letting anything but the host kernel configure the VMSA is
> beyond stupid, but unfortunately we're stuck with AP_CREATION.  Expanding that
> surface has a very, very, VERY high bar to get over.

The strongest argument in my view (and the main reason we are doing this) is
actually the predictable launch measurement. On SEV-SNP this is a requirement
to use platform VM-identity features like the ID Block.

-Joerg
