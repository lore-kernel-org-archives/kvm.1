Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA953E276F
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775844610; cv=none; b=rg+oXP0avSo/e6YPeplR5vy8ZSmpoMJq+0x63I8mKBOwvyjvN0a+eSEtQZrrOElKpyHd+Dovb3Csv3AQ00Z7MZgfJVEZmoCnA93QmKkLtN/6V7M1ShmdreWhFyXGwDOOAyzh77zLSYoTmTZy12ykE1G27HHc4uiHXcIppq6nsIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775844610; c=relaxed/simple;
	bh=RiAMebESLDrerCCB8z1EG9HuC2bXXUuvqFJqYdbBxEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYU4Wf9SnWxmw0Ou5kfOJBOwyQMdkqmUw7/b9jQXkqFiMjMd9U6g2nMzEl4Y/NIlNe6MOw5AGFmJZr8uMmFMnevihqyuMloSpH50flf0JSSYFN/cQop3K+K+jBrNPGgPC6peZft5adckrAWdqLgD6KGS3lESx23dpsK2OIptsw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AeFrUdlk; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AeFrUdlk"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8a4b8c3a30bso26345426d6.3
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 11:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775844607; x=1776449407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6qcUdSYVXIPHlYutMHlgKYsq8bY8kP9mulymhE30xKo=;
        b=AeFrUdlkTUWparOrp/LLvrX2gTzgnnJjKnTLtA8SoBZvRgJUICoIyCLNsCA5nl7qrt
         2oY/fQIQj1pczKtCbLO8Q5J4jUjcj75aXnD6tH8xKPL14AgKh+MF8JJj5clQE9E238bx
         CWtDoGD47gzmF/HKFJyb6F9R5tjF+Cy1ZE/gMQpP0m19NKkZs14WlGN4I7QwE8zFiiEj
         1hiILgRugrHGsa7XP4MxUkbYgFFkxHo5cZBfX3foX3uhWFXmgzmuQ6fSgpbU9qX6wRHp
         veTcmZGl73SVPQEeHICJIXXuFJ6/8ZYL7tOHDfGB9mi7MCwqF+xTXlqWQiIphlVzyTkH
         F95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775844607; x=1776449407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qcUdSYVXIPHlYutMHlgKYsq8bY8kP9mulymhE30xKo=;
        b=WoPSB6M1kbIxkiQQECmqTe83aVcrfkZqlTj8Y/krOIma34svsNqbCKkkm2UpgXl45C
         GXPE1VQCcKm5O0/hRwCq3fnQKd9zy627htgRKQcdZH4PO0pYyPyJZ0tbfldOlXwq9ouk
         o3m7s1xO3k2DQeZSJwiCN4AVKYFCfWt+p9bPmD96XvnylQJxu8CLq7W8dI2gDErikXpL
         6w21Q4EzQZaAoT2QlehsxtBtRTtVrtt6cr0REKotSw1U+lZe8a2NaNTuu1NGGo5yHH7E
         z729FhxBzUbt3QqlY3f9uXvC+xRXsnF6kx7OAncCevIHm7KPcSDxEe/vesdgeGkmXyF/
         fCyg==
X-Forwarded-Encrypted: i=1; AJvYcCVmdUfIk0zeskoSWvcurLvQA6tdsJr85pbD7lbeb70KG7ccMBAbUocaVydd2ShWp7M9zFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXHvbt1//bjlhB+eFPfpn6qpGnOuU2VERID6o5ZNkrG4Ir7mMG
	+QdXRdHDLkoI2iPxhMTh5BqveFoPRIXOeoibn7vpHdlx7NEglVCIDHLcL2DFYIsf/bg=
X-Gm-Gg: AeBDietOb9DYYzEbpdAtqo1JTgm5Wy7JeXOyn+mQwWN57Qvaxri3RoGWzX9LI99/FwP
	74EvF6r3iuG4ToZ/AdtzVuyhzMq6YVb5UpsuCUMQbPM1N1niwFGw+A+0YBLEX5YgdvWjQRBsNlm
	T2ukO3Tx/5hgZgmjv5RuaCyEDo7NFeDBBvoDl4whlSA+XHPJaAMFORY2id88a7DSengz2Dqev6b
	A9XErj9J0ReY5tEiPoJuoWtGOrLIG2bn6FnBoSOwxzrh1LuL3lfekeKj9Rv53qScqCm9NV/Si/L
	Km290Dz4m4fmlEAIQxatoiGRHyjPE2SVNGYYvx6sWlwHT6+YDGGrkIo8fXHMdN7a7L+PczEpt7e
	Rfz8YkCfBnFjCIrL63kc4h57WZsC2wFtQHBnWPJgaOCFGGUCyIvJuT4BZJ5W6LTEPaZeqKWKWGF
	R3lCGYv63J5NFwnmrBoaIfc7gPAR2tFPLY8+Yem8zzRRvEfYNyr/5ZWT+cKjbx6xsQL+iZDQ==
X-Received: by 2002:a05:6214:311e:b0:8aa:7239:b027 with SMTP id 6a1803df08f44-8ac860eb50dmr69122416d6.14.1775844607550;
        Fri, 10 Apr 2026 11:10:07 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a4355esm29526906d6.19.2026.04.10.11.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 11:10:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBGIw-0000000FPVf-23hv;
	Fri, 10 Apr 2026 15:10:06 -0300
Date: Fri, 10 Apr 2026 15:10:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	akrowiak@linux.ibm.com, alex@shazbot.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH] VFIO: remove dead notifier code
Message-ID: <20260410181006.GF2551565@ziepe.ca>
References: <20260407175934.1602711-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407175934.1602711-1-pbonzini@redhat.com>

On Tue, Apr 07, 2026 at 07:59:34PM +0200, Paolo Bonzini wrote:
> group->notifier is dead code. VFIO initializes it and checks it for emptiness on
> teardown, but nobody ever registers on it or triggers it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Documentation/arch/s390/vfio-ap.rst | 18 ++++++------------
>  drivers/vfio/group.c                |  3 ---
>  drivers/vfio/vfio.h                 |  1 -
>  drivers/vfio/vfio_iommu_type1.c     |  1 -
>  4 files changed, 6 insertions(+), 17 deletions(-)

 Fixes: 421cfe6596f6 ("vfio: remove VFIO_GROUP_NOTIFY_SET_KVM")

?

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
