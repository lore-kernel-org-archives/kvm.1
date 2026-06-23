Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F633D3D00;
	Tue, 23 Jun 2026 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214006; cv=none; b=F3wF2/nyL05KLLlolGNugIgOsxCNmcpbdNojYMmTMXuVgYuEtbWb1vL5xjRGUH9bM+I6fskS+q3CUOs0UB13QM3EkIg09fNI8mp6SrqwJfEYq4eJ8VBjXXiqKtRW6zaJkssGMyK4utAMW/ZRZ+2tPwB9rBYl36A51qI+Hxii6KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214006; c=relaxed/simple;
	bh=Dq4BzBdG6dMydBXIj09KpdzVBZNLOnqtzvOQVjLIMXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltEondmXQUZR7Ark0ankcFQIRAMxJwYtlwFfTVnx5D6qXDlGs19hNQK7MzMDuaYJO7TmAwzCMKon4IR0RXHx+wQU92PxxXNRIcX5590UZS8YuoOdmh39vLNmr3ZOS4qp9FzDdUID1TmXdB6HpWYKwaTUkTSowfxPVqVKTkqNeug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc500d0ea9295aeb63767.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:d0ea:9295:aeb6:3767])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 64622203E04;
	Tue, 23 Jun 2026 13:26:44 +0200 (CEST)
Date: Tue, 23 Jun 2026 13:26:43 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, Michael Roth <michael.roth@amd.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, coconut-svsm@lists.linux.dev, 
	Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH 2/4] kvm: svm: Defer VMSA allocation to LAUNCH_FINISH
 stage
Message-ID: <ajptFeM5gFYpPChl@8bytes.org>
References: <20260611123528.572255-1-joro@8bytes.org>
 <20260611123528.572255-3-joro@8bytes.org>
 <50db7538-317d-478f-b897-e7b73c5ba094@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50db7538-317d-478f-b897-e7b73c5ba094@amd.com>

On Tue, Jun 16, 2026 at 04:33:56PM -0500, Tom Lendacky wrote:
> On 6/11/26 07:35, Jörg Rödel wrote:
> > @@ -1209,6 +1215,8 @@ static int __sev_launch_update_vmsa(struct kvm *kvm, struct kvm_vcpu *vcpu,
> >  	if (ret)
> >  		return ret;
> >  
> > +	vmsa_ref = sev_es_vmsa_ref(vcpu);
> 
> Maybe just a comment above this that indicates if the sync was
> successful then a VMSA has been allocated and only now can you get a
> pointer to it ?

Makes sense, added a comment here and to __snp_launch_update_vmsa().

> > -	if (!is_sev_es_guest(vcpu))
> > -		return 0;
> 
> If you leave this here, it might make it easier to add things in the
> future should something be needed. Just tack them on at the bottom. Not
> necessary, though.

Right, that is better, changed it back.

-Joerg
