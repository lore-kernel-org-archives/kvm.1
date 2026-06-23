Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735503D565B;
	Tue, 23 Jun 2026 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215287; cv=none; b=DUL2E/3wgdwrsVT6/pZlu4+fDEwaN8daLh7bKIhKxx6giAkVLcS5j6VUX6QGG+VA2qcaViSi97RqqvwiKhcnptMABVzvq+XF7vU0/WTcxnjKYDImD1T8SpbHMmVkSzv3t1cacaGzS7/qKnFVzX/QyqZnylVXlIySCkCQT97vqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215287; c=relaxed/simple;
	bh=JJSOiCQ5QtqRoTj4QP2zwCTFW/ttRH3FLosb81UuCUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXRg/pUFjUTa36werzw7wZZdQMKoyF6H43oR4VTAEmUQDhi8rse5w3Qqd5i/ydpP1usehS74nwV8X98iNxl/Nf3rPax71Xw0mSMcM9mrIm1MwdNbN8zCniQQjJIN5jFtXH0ao2642wKftlI8qM7bTWKPB/fmSFQmdAlYIJq6b1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc500d0ea9295aeb63767.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:d0ea:9295:aeb6:3767])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 95F5F203E83;
	Tue, 23 Jun 2026 13:48:03 +0200 (CEST)
Date: Tue, 23 Jun 2026 13:48:02 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, Michael Roth <michael.roth@amd.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, coconut-svsm@lists.linux.dev, 
	Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA at
 SNP_LAUNCH_UPDATE
Message-ID: <ajpxFlsInL4daacA@8bytes.org>
References: <20260611123528.572255-1-joro@8bytes.org>
 <20260611123528.572255-5-joro@8bytes.org>
 <ffd2a573-0287-4801-8963-f49761e70e28@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffd2a573-0287-4801-8963-f49761e70e28@amd.com>

On Tue, Jun 16, 2026 at 05:11:59PM -0500, Tom Lendacky wrote:
> On 6/11/26 07:35, Jörg Rödel wrote:
> > +		if (sev_populate_args->type == KVM_SEV_SNP_PAGE_TYPE_VMSA) {
> > +			accept_page = snp_check_launch_vmsa(sev, vmsa);
> > +			if (accept_page)
> > +				sev_features = vmsa->sev_features;
> > +		}
> 
> I don't think there is a race here given the way guest_memfd works
> today. I haven't followed in-place conversion closely, but will that
> result in a race between when the snp_check_launch_vmsa() check is
> performed and before the page is made a firmware page?

I don't know too much about the in-place conversion changes, but when they
directly pass user-memory to the PSP for encryption the code still needs to
make sure it is not mapped to user-space anymore once it is made private.

So with in-place conversion this might need changing so that the sev_features
check is placed after the page has been unmapped from user-mode and before it
is passed to the PSP.

> > +	if (ret == 0 && sev_populate_args->type == KVM_SEV_SNP_PAGE_TYPE_VMSA)
> 
> s/ret == 0/!ret/

Updated.

Thanks,

	Joerg
