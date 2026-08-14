Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862AE3D3CE5
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786738854; cv=none; b=pIvsHbZ63PcWH1+0jNOJ8gaxGaXrcOUpmMcW3QdgtM/ft+M6mvb2sjc9gnXrXTyu1cP6kI7gDTMypJBBm529q5Qf36PiAbqB13thWi7Du3BUiLWvP7v9VIhzsK5/UzZfRuBfPFwns2arMf/HsogDjtKgjJ45WYZ+V1iGK+8aN8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786738854; c=relaxed/simple;
	bh=gyt8s4Y+gLjv5xtRYpGnDkIk763rIztTA2DkN29pPxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAPhAAXEpytcJqqCMxF2N/wyr42RCe9Jwn9ztqtE9AXtOHKdmUdTJf2XG+J/aPhJOSl2xyGzP1m0Cx9BTTCAVkMxn6bsAN7yQyTaY3NJTUe2BcE8V/fBkz8y3NXBHrVX+9CZ6ZvfuwPZP3nAcQrf0oQK1MKbuO4RmS5rt1FsUoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hhhZbvaf; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hhhZbvaf"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e88b60121so1198480a91.3
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 13:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786738850; x=1787343650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=puXmlvfWiCOwM99mGRYuFubsmW3ob3fGY85iw9VPwME=;
        b=hhhZbvafk44Uh5rB2FmTSDVOuicyhvnNiEvhnkogPqxWhrA8+X/M6g+ZgD17dfk16b
         6DooVhwwxeEgcFEOVLFg/qaGkPRjB5Qgx4XBrvXUA8ps3Mg93TnrtYKKhNBMuev1N+fU
         6alEkyM3rHpGME87HjVsP1o/9JaArky+e0pXAVBikyE4Vv6BzTGpCZ0780PMQBHN764u
         ciSiYjHU2Gk2dt/4mPYwR1EHboCIK1+e0fvHQLNZuNJEbj9ewZF7CSnbGfeCUaLaLb//
         5jiDqgM4D9TihT/ZFuifRur1j3efq5QkrBkO7XmXl2jPovo8+TpaqCujt00mA1bMb6+j
         bGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786738850; x=1787343650;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=puXmlvfWiCOwM99mGRYuFubsmW3ob3fGY85iw9VPwME=;
        b=G/swIURkC5oKgdv4LpnO4as6WF2ehN4BfjD35FgQWgCd/PKtDryGT2uB1i7GZjUhxd
         daflsyoxW5ETxCASi6xvARpHDTZ0ykQDxsKX6Un2EreSLAE/A90wpYBdBdaBcxN82T/3
         7wSmPniLO+FeMtqEGgDjfqfTOQ0gT7VlwXtKnJkCG3lviz/jwx1Aq/2vfSr4xLFk+gwE
         yrRZHg+hzSwhgvC9xyj1AWvspZJ6Me+togP/AGOSIvW/Xa8IG5SYs07f5wEfjHWOrYBD
         k+ON+ymtOb6Os1bIgzksSiAOQ6WNSql1tWfW5/lrTjnh+Rl4hr5mNOoNwV3wUrlXH2AK
         0KQg==
X-Gm-Message-State: AOJu0Yyh915JzbZLaDLNL7C7QI9nVJE+AkDXEbMiH6P1PWK9ktqT1bHL
	ZycRgiQGYAnVgnByTkW6Zchu7R4QwYqXvsa3sbp8vkUiSNzx9dmOuMt9qgn1Ox3wIA==
X-Gm-Gg: AR+sD12buuHJjoksyT1QUYUmc5rB33eTub97LmwVECKYBrob5kEISonJRAuLD22A7+L
	OZHURANMops7PYK1eTgajK6GXTilhkU7AnbAeOqbWUab9HiEGwoCvJ5CMwjjkFwAEfPcByBYPe6
	fvVrxQH/EfoVpu0ZUKIWmiweIHZRZTBCKa3FLedRZYc+/iVmksUsBB9gVA6bXKX6Kf52XCIYAj8
	+x7zqiDbrMfzq4oSi25Yn+EFDGZPX41UwEl0yTyun6vGpw+1jf8g4sJGcyWcaTCDbuToFNcULx0
	RNPv9ikiwZs3nOfsjFLV65ypIRZV/6+5kUdEiri85POonOAetbWrBcjRXPoMwP1JaVLS+w2avB2
	DK81qbwpGo3ya6hVRRgltW0kM8cryRSohvO84CBhnpT1RNOu3ppsVAmtEeMd/ghSLDtyUiSW1Sw
	w8ntdXdbGwX3UU8HKbuBmhKAtd7xioRiGxIoBX9wHtWXaEl7py14cZn6HKcRvR0OFuR3a2h6Rfs
	iWhQgUVSJ0tf5i1Yy2RyaQFb8K1XQ==
X-Received: by 2002:a17:90b:1806:b0:38d:e0c4:c955 with SMTP id 98e67ed59e1d1-3933b8c918bmr9338176a91.15.1786738849773;
        Fri, 14 Aug 2026 13:20:49 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ebbcc34csm3876781a91.15.2026.08.14.13.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 13:20:48 -0700 (PDT)
Date: Fri, 14 Aug 2026 20:20:45 +0000
From: David Matlack <dmatlack@google.com>
To: Aaron Lewis <aaronlewis@google.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com
Subject: Re: [PATCH v2 1/4] vfio: selftests: Assert the region was unmapped
 in iommu_unmap()
Message-ID: <an94nfes33gFUcZW@google.com>
References: <20260804165748.1060476-1-aaronlewis@google.com>
 <20260804165748.1060476-2-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804165748.1060476-2-aaronlewis@google.com>

On 2026-08-04 04:57 PM, Aaron Lewis wrote:
> Add an assertion in iommu_unmap() to verify that the region was fully
> unmapped. Centralizing this check simplifies the selftests by removing
> the need for individual tests to handle the verification themselves.
> 
> Suggested-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Aaron Lewis <aaronlewis@google.com>

Reviewed-by: David Matlack <dmatlack@google.com>
