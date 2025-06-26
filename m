Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCD62ECEA5
	for <kvm@vger.kernel.org>; Thu, 26 Jun 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750953530; cv=none; b=UgSVXX3YWnEKftsol/odWTz/lshFkGxcMmaoc7aomSe/9CCZN/kJK0eQw57cIprzDur4+58m75WkYpuCS/PJp7+RYr0EOyNy74vsXmM+UPcyW4Paa1qgaJWVUoWNRxIlxVqJicTs3p8G+7yLU3eZ4hKT5lFaqxM/LrlPTh6qnOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750953530; c=relaxed/simple;
	bh=el/AG+soar+8I0TkRmmfkfbYJbFh89tUJ6cdwZ/nYww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j31tqqKd+b0CxBSA8kJqh+tW6Qe4xj9NxtcvpPc3E5xJ+rVp/4QBWWkF9e10tlrFjmMnIXaE5hhPGQbvDRlp55Qz25Im33H4zXjVQMjyHwYHaD5o9vOQY1NfrOyFN8rQktkbY2p2iKGndOGxfel+gjiKoR5BOCrUwSkEZ/DD9pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zxI8NzZn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zxI8NzZn"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3138e64b3f1so1335879a91.3
        for <kvm@vger.kernel.org>; Thu, 26 Jun 2025 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750953528; x=1751558328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S/uf9wxm2c0Qk14PYx/6WTgRiWmVdUxxJWQlP8qvxog=;
        b=zxI8NzZnGmfEfLhQnnjqAHkZi3Nr4rFE5qdZSyaFUGVxYAFHlwxBX0WLkqHLDaQ9vZ
         GegpeKQC+jg298Jjhshtsbs5vlWW6zSJy30ikRri+OR7bbqtweHtn1yF8lgEIjsTNFaf
         06U2F3SVYcTLTecKodYX6LcIiOdKCYSUVSyLBsUzzUYKr98AX0QQQnsevwBj5NKZZyUR
         nvtVPytXiyabSt84Vww+0WsXO7RCmr0WQ48YHdXyZSgsMcNWz9B+rgl0sfiG4bn0Tbyz
         IrB4AymM2cHUqeXJmE9DNB+255vEPRiXuCf8x2Yy/0SMUYmSfAXM/P78en3TyO8xushg
         SwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750953528; x=1751558328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/uf9wxm2c0Qk14PYx/6WTgRiWmVdUxxJWQlP8qvxog=;
        b=GSDIvByrI2elWhifRX66xu3hCKUEbg01+IFwYSrpbn2yFbsMUeahmNkmt9UtoYjLS5
         OtZqaw/X9Z5dOQZ0RZFH6jjBxPzUWlSGSHUCgmEmVhxSOtJvKg1wpDpPmn4C5ys4e384
         pIWHkORhv6Mbop65Ct2bssoxfhCBl7YvHZ2vVV/g8e6WOv/1heWhppa67q78dzznWNFA
         q0ExegjwMDmheuwGXSn7miML5og0qlz75RgH5NgHF0wImhQsOY2tp4GFI389HXQ3XRyL
         DI9AdfsUiR6MxzZTu8Gxu1zRDSV3E57Ghn207X6hVhSTxkSoL/YrZ01aTgkw8Gh79ZK+
         7ong==
X-Gm-Message-State: AOJu0YwknHvvU3jkqlgJqkPcgD9VF4bmNGYPBnvZLmbbhdp25ZWVwQj0
	w81OyCI53i7yUjGBf5uTN8LHogymp8zsuv5cwJeXL10YJzclgzUilogMNX/ko93dJuwc1CzR4xD
	PNOa0Kg==
X-Google-Smtp-Source: AGHT+IH50WR3atcLhwQ0vlBEx5F+Lmgv4Ol+UjK2rPEhZgeL6Il1fIW2Is6Y4r3eWAeV+oa9gEEziLGMYo4=
X-Received: from pjbsv14.prod.google.com ([2002:a17:90b:538e:b0:312:fb53:41c0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2642:b0:311:ffe8:20e2
 with SMTP id 98e67ed59e1d1-315f25edc7fmr10523268a91.4.1750953528194; Thu, 26
 Jun 2025 08:58:48 -0700 (PDT)
Date: Thu, 26 Jun 2025 08:58:46 -0700
In-Reply-To: <175088949072.720373.4112758062004721516.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611095158.19398-1-adrian.hunter@intel.com> <175088949072.720373.4112758062004721516.b4-ty@google.com>
Message-ID: <aF1uNonhK1rQ8ViZ@google.com>
Subject: Re: [PATCH V4 0/1] KVM: TDX: Decrease TDX VM shutdown time
From: Sean Christopherson <seanjc@google.com>
To: pbonzini@redhat.com, Adrian Hunter <adrian.hunter@intel.com>
Cc: kvm@vger.kernel.org, rick.p.edgecombe@intel.com, 
	kirill.shutemov@linux.intel.com, kai.huang@intel.com, 
	reinette.chatre@intel.com, xiaoyao.li@intel.com, 
	tony.lindgren@linux.intel.com, binbin.wu@linux.intel.com, 
	isaku.yamahata@intel.com, linux-kernel@vger.kernel.org, yan.y.zhao@intel.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 25, 2025, Sean Christopherson wrote:
> On Wed, 11 Jun 2025 12:51:57 +0300, Adrian Hunter wrote:
> > Changes in V4:
> > 
> > 	Drop TDX_FLUSHVP_NOT_DONE change.  It will be done separately.
> > 	Use KVM_BUG_ON() instead of WARN_ON().
> > 	Correct kvm_trylock_all_vcpus() return value.
> > 
> > Changes in V3:
> > 	Refer:
> >             https://lore.kernel.org/r/aAL4dT1pWG5dDDeo@google.com
> > 
> > [...]
> 
> Applied to kvm-x86 vmx, thanks!
> 
> [1/1] KVM: TDX: Add sub-ioctl KVM_TDX_TERMINATE_VM
>       https://github.com/kvm-x86/linux/commit/111a7311a016

Fixed up to address a docs goof[*], new hash:

      https://github.com/kvm-x86/linux/commit/e4775f57ad51

[*] https://lore.kernel.org/all/20250626171004.7a1a024b@canb.auug.org.au
