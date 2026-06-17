Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B740C4071DD;
	Wed, 17 Jun 2026 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702739; cv=none; b=mA8lswYYckFFvgS1/KMBHkiA7mYXq77T3chuUbvlCJUZW6Iqbu+ODDHpHUuwqSQwwFE9aX9s6o18t5dvQF+b6cVxNSCWof1QHlzRVsl68kYP9180tDL5Ij6Kjl8Aef4MXGf38g+UMPHTQlTmmJcKiQkjkLpjFymDz7ZGuem1+XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702739; c=relaxed/simple;
	bh=XINN7vIdLMo7fIJ5n9tqpWgjsi/FnBRKoyQpSip5384=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwT9njQMWnHvD33ZDlpomyREhxn/HDveYtqNde07lOC5kAsZ2+NaMp+utE4vJKaoJ7svX8ODs0Tv/f2E6ypY7TtPFzX17y2FchzxL73Hs0GLUAIdEqEul/ti2oR1tr//FtOhazc39U/3IP/xIPfXxvc9H0endd3akycsSyBE4R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4D2122027B6;
	Wed, 17 Jun 2026 15:25:35 +0200 (CEST)
Date: Wed, 17 Jun 2026 15:25:34 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coconut-svsm@lists.linux.dev, 
	Joerg Roedel <joerg.roedel@amd.com>, Jethro Beekman <jethro@fortanix.com>
Subject: Re: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA at
 SNP_LAUNCH_UPDATE
Message-ID: <ajKe-oboTRowcO_i@8bytes.org>
References: <20260611123528.572255-1-joro@8bytes.org>
 <20260611123528.572255-5-joro@8bytes.org>
 <aiqtWVMqTK6vDoZ8@google.com>
 <aiqwjn2DVOumfr3T@8bytes.org>
 <ajGOELiYwKByXbVP@google.com>
 <ajJAYZAPxNrrsiYp@8bytes.org>
 <ajKadxZEMI253AoT@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajKadxZEMI253AoT@google.com>

On Wed, Jun 17, 2026 at 06:00:39AM -0700, Sean Christopherson wrote:
> On Wed, Jun 17, 2026, Jörg Rödel wrote:
> > With the current code KVM will create its own VMSA for each created VCPU and
> > measure it into the guests initial image. This makes predicting the initial
> > launch measurement difficult (as it depends on KVM internals) and fragile because
> > KVM-internal changes always carry a risk to change the launch measurement
> 
> The same holds true for userspace.

Right, but if user-space breaks the launch measurement it must be a problem in
the IGVM loader, as the IGVM-file contains all necessary state from which the
launch measurement can be derived, including the initial VMSA for the BSP.

> > (which has happened a couple of times already).
> 
> Examples?  The SEV features thing jumps to mind, but I don't recall any others
> off the top of my head.

I was referring to KVM-induced changes to SEV features, but thought this
happened more than once?


-Joerg
