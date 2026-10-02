Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19DD4B487A
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790963143; cv=none; b=a/Ox7PWRUdQ8TGvSiHHaMDYGJm/8E4cQYzKTutQr/3qxrVCfHW6mTElck7wS4CcyR/URlVHhPS8u0qFIjA2P8nMiMjICweR4VYU2WXXLndCclBlkNOSmDi33VRGTd/otCBB/r8SLNgpeLw7u6Adq/MPxPWZ+GnAsixDIvk9N/Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790963143; c=relaxed/simple;
	bh=tuUKQXYkGnUCxDjJE1nQ+gDpYskdzNay7lbXkALLVfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7VwRRXvWOQ0Hyuq9ovbdm0QVz4gODf6JlexOrIBMgtJk5Pf7ZHXpfkTN1AIN4jzD8MC69Ba08dCcRvVIbjsI0+KFMg2vmUrtbk6XSKWMnks+e+oms627fXxl5U1Cx65sG5Bn7LkMg6JPdC5KJ4WcPNVxn36jQrvxTHXbq1Wanw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPe35Kgy; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPe35Kgy"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af0707d41so72093f8f.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 10:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790963125; x=1791567925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N1e269Lu4xtW2duTVHt20I/6VEWYe79hxf4w6LtBB3g=;
        b=QPe35KgyK+Gxw4mhW5bVABKyqTpTACMfdCdcK3+8MFTzVlTSZZH3fgy+SpIP/F2Wmr
         TcMpN5trX18Nc8ZVjnjyMqxbuH4CZPirvTLgRud3czi5e1sFv5W0c0qfUp1dSmEzMFQX
         ZbZBshmVFvcNreT+UbenThzeRuLsZG0QfvwINAgHCrY5fotVLTI54AdkqEFY8MgA3iu9
         RIlLT+W9R/LsSglYZDgqk/95yYgmADmRafwSwiZfnSLu2OKPwgpaxGHPSVp25DztLFFO
         IrIKY3d8uOHaXimDNVlrdRt5+qPw8ziIXP0q78BhPWtz33F6EdFGuM6y1JzuiNsI5SkT
         PnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790963125; x=1791567925;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N1e269Lu4xtW2duTVHt20I/6VEWYe79hxf4w6LtBB3g=;
        b=KLp3ka9EuoSg3k+M2Exvm9LLkbS9wNiip030sMf9aUbi9wN3GEOGerq2E1KdzPUnti
         KUu06KDhZLjGmWkLkSz7ICssLWa0NL+fVJzcL8Q4E14LtxvZaqAk0xyN7Y4KcnP9oVAx
         hHyYGClpXMCTpRISuleZ5K/R+SbcSjIMrAzGFIhLdCH1JiziQ4C23NuemjsM45XgAqqP
         xu2qUO25apUo8N+v48SvC+C8S9l3xmG8z69yZXqRW2MMEzkjak6kC+JA2xuPRNOKKXUH
         8BnVKpfhXmvdjuuLb0HUSV3410qIHjFbZ9mS61ad4vrDWimiepyE7yDFyZsqwN+12qFW
         TxNw==
X-Forwarded-Encrypted: i=1; AKwUvBz2iHjt9wos6hkT/oiIZ7E206nD3nMa5urAVpjUlJ55cyBfwM54QRqdPBW3OFeK7aHsG3o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjBB0u40+6nUz1qiKLRFCIrVx4e4bc58zG+BOPbSJNkRYKNDuh
	VTqwhSRNmHl23+HLpthm1XmN09lBEEnjlE1MBMCumA/Djk1aIjYbK9Eo
X-Gm-Gg: AYBFou0GjnJG1VYEo5kxJJngP1sFFFqKiJ9A1a1BQrmiO0sGfK4xjJdC/r3DcsuOc+e
	RYmlHHMwvenlFNUPmjzxW3gEMVLxPKoffNwk1I/VYMEPSb9pfc9a3E6iGqHYtVSawT1esc/bLnN
	8ScPNvztpxfEHpcctih8ePToVHE3vut4JFL2GDM3gIhst5/NniWl5O2T7amcZB7tfiMSd0eliwE
	HeB7NNSN+G8Ily7cOn0wvsKLGefJnU/Wyfqu+6DbdtSwvIgU806UNBLfn9FzlKQrd/9JiKOj5s9
	LlFpcTEmzxULe4XABHE6crUutqE7p1ZgXLaESHftCGulfID5RSExHzKfr2kWjkggTNTHtL7fQgd
	SMENtRXBpfHO/UShpVcC5G0H1Czo358cFVhTE/GRsyoJSH04g8jGFiDyUUolFFADoEHYa/129cQ
	eo4WWmaahHAdhYAX19/ycBruBnCuREQveb+/3hWL3FWiUR6pKL3pPh0oVsKe3EyS6I5Ktjx27jP
	MnJMFU32SzYSGR2NmQFgp6kNIVUnRjhkK6ekraJ4jRuHIvv0wUhikUAzsxk6McUvhw1MxG0Bq/D
	p4o24hKoSwwVTlufPQDnO8/M2viaSwxujzKUFaXZpuD+miv1bsv9xZbx5tqAOdK9qGcacmbNWx7
	BLBlftw==
X-Received: by 2002:a05:6000:260e:b0:48b:226:839 with SMTP id ffacd0b85a97d-48b1273bfcdmr6851497f8f.14.1790963124443;
        Fri, 02 Oct 2026 10:45:24 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-2a02-3100-af35-1901-81da-eee8-c2d0-ee3b.310.pool.telefonica.de. [2a02:3100:af35:1901:81da:eee8:c2d0:ee3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380f0661sm6839400f8f.14.2026.10.02.10.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 10:45:23 -0700 (PDT)
Date: Fri, 2 Oct 2026 19:45:21 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	kvmarm@lists.linux.dev
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
	Christoffer Dall <christoffer.dall@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/4] KVM: arm64: fix VGICv3 redistributor rollback
Message-ID: <ar_tdaYQO-t1K2F_@gmail.com>
References: <20260831081005.41346-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831081005.41346-1-kmehltretter@gmail.com>

On Mon, Aug 31, 2026 at 10:10:00AM +0100, Karl Mehltretter wrote:
> Changes since v3:
> - Dropped the REDIST/REDIST_REGION serialization and VGIC init/destroy
>   rework, keeping the fix close to v2. (Marc)
> - Limited rollback to assignments from the new region so an older-region
>   assignment cannot be missed during concurrent vCPU creation.
> - Added Fuad's Reviewed-by tags to patches 1, 3 and 4. These are otherwise
>   unchanged from v3 (formerly patches 1, 4 and 5).
> 
> Previous version:
> v3: https://lore.kernel.org/r/20260822095346.53882-1-kmehltretter@gmail.com
> 
> Karl Mehltretter (4):
>   KVM: arm64: vgic-v3: Undo assignment on iodev registration failure
>   KVM: arm64: vgic-v3: Roll back assignments from the new region
>   KVM: arm64: selftests: Pass guest code to vm_gic_create_with_vcpus()
>   KVM: arm64: selftests: Test VGICv3 redistributor region retry
> 
>  arch/arm64/kvm/vgic/vgic-mmio-v3.c            |  54 ++++++--
>  tools/testing/selftests/kvm/arm64/vgic_init.c | 116 ++++++++++++++++--
>  2 files changed, 151 insertions(+), 19 deletions(-)

A friendly ping on v4. Patches 1, 3, and 4 have Fuad's Reviewed-by;
patch 2 was revised following Marc's feedback.

Thanks,
Karl
