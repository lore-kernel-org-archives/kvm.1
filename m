Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44547347503;
	Wed, 17 Jun 2026 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708036; cv=none; b=SEWSuhcF7HMQbCFp5AXx0uoKMSjmlVKk5UhomCnzw38TRz5nux68ZtDzoiodoUL6SV8eDUu0W5rShQ6aBuWE71T9jR3DFBJsbllw6hnn0bqoWb0tcY5AOd4ulXjV+hzaRAQXI+xgj6gFEVvNYeDAXShNBoT2xHn4K9si7uCQgeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708036; c=relaxed/simple;
	bh=BbG0d5zBTQaWYPcv8idvXM7W0156PtqL5VivcflcHhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZY6qJRNjOtDq9nc38jd+lmML7k/dEOnyHmsf6LHtqZxWwnmqzBAioLzx4EwzcnMcoik5TckVbCK1U/0jQDJApVYvAg77Pe1cLb8hr36xfYr2v0R9fdxuEQCfkkWtSNQBlMWO9snqSqKq6DqnPRgNeewflHKPKJ2BewMzsuxX+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3FE6E202816;
	Wed, 17 Jun 2026 16:53:54 +0200 (CEST)
Date: Wed, 17 Jun 2026 16:53:53 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	coconut-svsm@lists.linux.dev, Joerg Roedel <joerg.roedel@amd.com>, 
	Jethro Beekman <jethro@fortanix.com>
Subject: Re: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA at
 SNP_LAUNCH_UPDATE
Message-ID: <ajKzxF_F7UQ55lGw@8bytes.org>
References: <20260611123528.572255-1-joro@8bytes.org>
 <20260611123528.572255-5-joro@8bytes.org>
 <aiqtWVMqTK6vDoZ8@google.com>
 <aiqwjn2DVOumfr3T@8bytes.org>
 <ajGOELiYwKByXbVP@google.com>
 <ajJAYZAPxNrrsiYp@8bytes.org>
 <64383a438eb79a30588f2737a6df84f9d4cd5b7d.camel@HansenPartnership.com>
 <ajKgbpVpMMP2a5nG@8bytes.org>
 <ce27a795148335f50cd7f11a0f24da8b63f751a9.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce27a795148335f50cd7f11a0f24da8b63f751a9.camel@HansenPartnership.com>

On Wed, Jun 17, 2026 at 09:45:46AM -0400, James Bottomley wrote:
> Well if the guest policy is I don't care how many CPUs you give me then
> certainly, yes.  However, if the guest does care, they may want an
> attestable record of it somewhere.  Since clouds do charge somewhat
> per-vCPU I can see this mattering to some tenants.

Yes, the number of VCPUs certainly matters to most tenants. But I doubt there
is much value in including this information into any measurment, as the
measurement does not guarantee the tenant that the host actually executes the
VCPU. The best proof for the existence of any given VCPU is the fact that it
executes code.

Regards,

	Joerg
