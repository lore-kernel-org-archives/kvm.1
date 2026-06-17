Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807E13B71B1;
	Wed, 17 Jun 2026 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678708; cv=none; b=Z1Ss5GW5MjVEtbRAyYuWOb1llpI6qZQ4jxupoNuZFuEFSNbsHQr8l7Q53LNGJ25RK0NStwlepGMQ8MTo1VSip4fZ3ehdQ5/lEygVzc2sWMWl4XUGuHQBh0rPvQkxEjCUAt7crWBbK6AHWqlEOWekHkDiIq+kQJNXqtQy0cf9IIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678708; c=relaxed/simple;
	bh=DmutdhUO/c88sgt+yzgSh02AJfjBqxbmcWpZi2FuhTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVH6pjBsV4vqsVaXlXcFpGJXp87AAA+LkBaT8oRPp4CTd7sbp+npOf0WXVr3Y6NVtiIT7RKmyDxKcAT70KpCoXUugqzw6ZlmLuyu0fCYD0zoZ4uq1O6577bf7K7LRdKMIjvNi9fAoiFDRPVD0zQ4Mw/jCgO0HQYfATiNNxKkcIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3D2FE2025BD;
	Wed, 17 Jun 2026 08:45:06 +0200 (CEST)
Date: Wed, 17 Jun 2026 08:45:04 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coconut-svsm@lists.linux.dev, 
	Joerg Roedel <joerg.roedel@amd.com>, Jethro Beekman <jethro@fortanix.com>
Subject: Re: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA at
 SNP_LAUNCH_UPDATE
Message-ID: <ajJAYZAPxNrrsiYp@8bytes.org>
References: <20260611123528.572255-1-joro@8bytes.org>
 <20260611123528.572255-5-joro@8bytes.org>
 <aiqtWVMqTK6vDoZ8@google.com>
 <aiqwjn2DVOumfr3T@8bytes.org>
 <ajGOELiYwKByXbVP@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajGOELiYwKByXbVP@google.com>

On Tue, Jun 16, 2026 at 10:55:28AM -0700, Sean Christopherson wrote:
> Isn't this essentially the same thing as hot-plugging vCPUs after launch?  I
> have yet to review it in depth (sorry Jethro), but it looks a *lot* simpler.

Replacing the VMSA after launch (as supported with the AP_CREATE GHCB call) is
different because this has no influence on the launch measurement.

The point of providing an initial VMSA is to get a predictable launch
measurement which is independent of the number of VCPUs the guest has.

With the current code KVM will create its own VMSA for each created VCPU and
measure it into the guests initial image. This makes predicting the initial
launch measurement difficult (as it depends on KVM internals) and fragile because
KVM-internal changes always carry a risk to change the launch measurement
(which has happened a couple of times already).


-Joerg
