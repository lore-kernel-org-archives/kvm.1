Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278E32AF1D
	for <kvm@vger.kernel.org>; Thu, 20 Nov 2025 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677848; cv=none; b=pJXLeBeN9eOuCBPNQ0HP/GMWYyPrlFCJ7cti5h/YoRA1HCC1dViQAo+swrgumBDy/0K/QbmM+l+6h6lxd5BK7jaFcA/ySVxnFJp6Rejb7S83+itM3WAKPKn9i2V890FoAWQkhudSZdV0NqMpKRWWG2Xs7ioB28FzSDv7TgHg79k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677848; c=relaxed/simple;
	bh=XM3oHd+NqVO+9+JBUhqkVxk9E1Ox4uBtA/JZ4oZsiW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PdmPDUAck0erLLZmHbSntFPrHF3WORja4WnZGdXjlc9cGQsL/mG5P3y0U/qK58JFb9zT7FopiQiAo7PXO8L/RDQlanZ54S51W0zk3xUjSgsYEmnhKGnDS3E/nMAw1asuXtm5glXMaUFRG3uduFUYm5WMGUiRoEZdQ0ovPJ2xMho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fvwdlgLc; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvwdlgLc"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-340c261fb38so2502669a91.0
        for <kvm@vger.kernel.org>; Thu, 20 Nov 2025 14:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763677845; x=1764282645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JEByTRD2u24DuAHKArK5iKfifkedyslZaW5KBzyqml8=;
        b=fvwdlgLcIEfB7aDNobBz79MA4gAvIVR5ull88cNU/lwW1Ygf0U3d0fWiJvdXA6+C8n
         6MrE+4llfcUAlFLnvlk7u+C7ATQEYvO5Z1DeMfbE3VSeJNVWzMOUtE696+/vYFu0XzUk
         2nmuRYxIT2kMW17x+Oon574kV55hgmTttkTbzeG7cki25KYlQrFgi1+1BGLx6r0gvcxa
         oocgBqw4tMZUvyV+CKh9/uQXjA2qWWAuLobeeDzeF7lwDXFITl5jSOToTk+VOjClbUe0
         3M7+LgLL8CJfIi4Kn4S11gzrkOPMXXyVorA2R9wnPsje00HO85zGUVWNb8YdzkNqXWDK
         25Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763677845; x=1764282645;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEByTRD2u24DuAHKArK5iKfifkedyslZaW5KBzyqml8=;
        b=TSWW41V7D0f3zcW33u+e25WywmvrSHUzArjtbx0PnLoRA41EBPy1RHuZ0z1BAjeXa2
         rRDIBXG7M2clr2Mbaj3caB9az2lSCjVXs23166l/NjzHXrkZ5MVT7Hb46V1CXRXhdZie
         A6l1x8jJtAwfu11v413mwmp4R/l80MU5uDdDcsNXVDCiZGi76gZE9um2epTJmD+HuoMn
         ieOQjcrSPIVIp8+c98QJiF+/YnkQzuh67DuBhvseHPsWPpCJCfnYeEKwgu0mHif7xXyo
         b3l/eiiDi7klfTxAMmkug5TltD9kH7/XAQg0YL4kvrY2lnJc8tLd4eBVKIXfZIW9wieK
         nsEw==
X-Forwarded-Encrypted: i=1; AJvYcCU6d1v/+Vy9KpcETfzv0+RQF7SdtTOYJRjz1+U1jycvFf5EHVKUdkDdDpNh2miV3x8yUPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw6iz0JIM3kjcI3HLYyrMcFCWSJu4YtpPKXG9RGAiGIT/WSMci
	goLwsKYy1eGVZT159ymqA+UsuVXAzNs1+ankViT2h37QKvxRDKxj0WBp40l2YcVHPLf8At+K0Z1
	PxKOPpg==
X-Google-Smtp-Source: AGHT+IGOHUMOhLjbJL5wUB9ExfxNpdm/8Fi4EmS6SFCFMc4zyuG3C+3CszgvpWEqiat1Yy4ggNtUAhO4taw=
X-Received: from pjst15.prod.google.com ([2002:a17:90b:18f:b0:340:a575:55db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f42:b0:32d:d5f1:fe7f
 with SMTP id 98e67ed59e1d1-34733e937bdmr80623a91.15.1763677845413; Thu, 20
 Nov 2025 14:30:45 -0800 (PST)
Date: Thu, 20 Nov 2025 14:30:44 -0800
In-Reply-To: <20250903064601.32131-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250903064601.32131-1-dapeng1.mi@linux.intel.com>
Message-ID: <aR-WlHq5HKeLa6Pc@google.com>
Subject: Re: [kvm-unit-tests patch v3 0/8] Fix pmu test errors on GNR/SRF/CWF
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Zide Chen <zide.chen@intel.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 03, 2025, Dapeng Mi wrote:
> Dapeng Mi (3):
>   x86/pmu: Relax precise count check for emulated instructions tests
>   x86: pmu_pebs: Remove abundant data_cfg_match calculation
>   x86: pmu_pebs: Support to validate timed PEBS record on GNR/SRF
> 
> dongsheng (5):
>   x86/pmu: Add helper to detect Intel overcount issues
>   x86/pmu: Relax precise count validation for Intel overcounted
>     platforms
>   x86/pmu: Fix incorrect masking of fixed counters
>   x86/pmu: Handle instruction overcount issue in overflow test
>   x86/pmu: Expand "llc references" upper limit for broader compatibility
> 
>  lib/x86/pmu.h       |  6 +++
>  lib/x86/processor.h | 27 +++++++++++++
>  x86/pmu.c           | 95 ++++++++++++++++++++++++++++++++++++++-------
>  x86/pmu_pebs.c      |  9 +++--
>  4 files changed, 120 insertions(+), 17 deletions(-)

Some minor issues, but otherwise looks good.  I'll take care of all the issues
(though I'll still post a v4 so that there's a paper trail for what I'm applying).
