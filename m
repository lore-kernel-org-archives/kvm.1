Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E323938F927
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932531; cv=pass; b=u/Sm3v0Ui4fgxc0cq/1rXDyiiiJWi1W36NZ0WYJQAklZtBMIboufEZRAwgMA2f+075QLD5PS4RfPTEuGBtXxh2mwtqOgf4mk7NWY0F4//YMNBZ7vrzyqLGa9ek0q/BDfgREtCpx8cq4zVs1TAIILyJ8uweA1NdAb8gvP+00R7gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932531; c=relaxed/simple;
	bh=hWB1QcQGFZjdtaZ+WkrO/eQNuOSYDk3BPt9FwXfnsYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Veelq2mfWIJL85YD8YU8XAJ6fruRVL5t98K4FjJ7VPPvEecjO9z4A8+6LBHtiEZv2rjXHigcrJXqFXib7cUatDL8f2iB3YeA9NijfrpjUkMQxv2H2TBfDw6zW5YuvfgH3fcWCfRuMcaTXdtm7uhDy6xzuT0Enrb/c8vyQzmHOJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uUzsD/g3; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uUzsD/g3"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5ba40832934so4226e87.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 02:15:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790932528; cv=none;
        d=google.com; s=arc-20260327;
        b=fLwu0oPdp/rwSV7JOKrgPf0MDkBRMGIieZFHlvmnEmHohY5zhDgvLGks8ENpcRc46m
         M+9StPUID4MrdZ8Wtx56zZK2Q7yLuLEtQ+XmA4jLAWECVQe/NxTm38frBdPUQdblCSG0
         BY4db1iKu2WaKeuTwsueiIx90IyeXek0k7+QQJai8gcRVI6HEjwKMoInyHxwaCfvL9Id
         SVOzTg/jHB2nTlP5L4CVBR9XG8z6B6lzel0S1SYNq56MroKJ8ALIQo7PxGik/re+zn5x
         gy8azdaIDb897Q0iDf2zqflNULasq7zGHtqx2KP9a4FvQEyx2/HPZgt7tlvbMWVGVeJw
         Ua+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hWB1QcQGFZjdtaZ+WkrO/eQNuOSYDk3BPt9FwXfnsYM=;
        fh=rnIkUf6r+pm8oCQPQDOHPhdYLJEIYxB5Eh3hMNjkNs4=;
        b=gK+SowkIBW5I1tchv2/UAtInbruxiM8Wi/HWHhgUzlBRnvURu+pMHqlvWe/VfmPdFL
         +4WOy68e0cQNG3TYW23RYtUIQ8LA7fCawasyYZDvQjl38p5PULGzJpZQzjKi9LAbcUD5
         dAqUhDd+FAl7ncSCEPP9q89eLnCxYU7HctnxW2Pm08xixRvsmZVRK7jxiGo0U1twkXAk
         E7/odNv/uyOUXFL6Em95msjEKTIKtXjZxgGkI4Z/JUsg9+cyLclgvx87Dz66L6pElHZC
         8m70oxWWFN+z/qCQqM0oHcBdMTCaZ23Lj8E4p0Ik4gCYCzfesH1VHuALaxoeSsrBh3wo
         RWLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790932528; x=1791537328; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hWB1QcQGFZjdtaZ+WkrO/eQNuOSYDk3BPt9FwXfnsYM=;
        b=uUzsD/g3ZCSfjiq2wwk+OeHdkmNqrj2XGfzBopsyQtL/HuhTlxgdg1vl4ZpxJP3V7k
         NvRarQrw9c38y28HeOViljKliPt2YMaNcCzFkq1MV4g6z5fvpMnAg7H+Cz9pNluRtKuH
         3bvVFPiyfTJKbbGP10Yn7Cx1VaXJN0cXH6abldTN5ex7w1NbqgJ6ka4gobKRkS7Brrhk
         xkr9W3zRdhrjt9MqEihHv3YqkSctCU2KGSlrJZKuwZk12vj7WZjRWUqk9Q85y/520Gp7
         3EV7G9Trm8zgSNUePo5QeURb9LoMuKtsRtEf8lMiMeFLoGzcCq//QDQAKENeKqpLs5+E
         uqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790932528; x=1791537328;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hWB1QcQGFZjdtaZ+WkrO/eQNuOSYDk3BPt9FwXfnsYM=;
        b=IRkETNGV6GKgJ0PPtAOOWl1E3eOSKns8VS08ldiw87iREqPWizX3dRuR/1nwKBkxkz
         YPpwLd/7BDn92OGEfdI1wVWmCrMSbbXfOeeB3YfCiUUpknBcD3cEWd+xV5PkxGXA3nq0
         Aos4rdOfHYlpkEulswkz5BXfqj7zmC0+RVL14uCIAEigEKJ2K8H8O0dUgjORAPaFttod
         O7l1OIFcuzh3YpOPlUDJ9zHqMJRHr+Xn2WKB5nggeiS73vKqy21mnHleNxUirS7g9IFM
         w0SFz+8m3MGHEcnuJPMi4jFXx1rWyXzq5JuMQ0nIhv/Y2+xcfLIxNcUS3Q/cVDsMdMbm
         4npg==
X-Gm-Message-State: AFq9FYJbb8UOQHaFfazvqPDF/ygzaExz4aOJqjoxTUGgvhlc5ZjlyjzW
	Tv4rRRqbDmj3adm4o/6bIpwaikWdXBX3gkHlo4MJLlvgNJJh0Wf0QmXBAFLBeMNLg7FqbBqC76n
	2GBltRFnxByBx6wmEOwMRQslcmJA9pRBgherKpaVE
X-Gm-Gg: AYBFou1lXtJVH044KulGvrhcPktZ53i96wHGkChhRYW49GV1gQpf5YFQ1RYiElGS18m
	9rVm1bbU9+DktpM6DQKDIuTCJeGkDIAAKgABL1enu0sfPtc+xi/hGoxNcw4hNFryJcS+BpmG5nl
	ZbcpEJIVT3vMkdJzZZgR6ZjxM2WMVGohr2OClbmwGLNILxpSL0oVlwspz5tGso/Kbrm8u4qRbAI
	Ybh5IHL1V4oYJRmKoiOs44yNwW/Q3mKPx1cFEBjwqLNLz/mNGqpC+1SQacBmA/s33GOfmSZTQnJ
	4ugKSkw0OgZTRhrdVOpWRJ+M4iZwDHCjZDsA8PJ4j0TzPyQmhmBnihHtLtXUX9ulhIL+522KDVA
	FVLMxu6UPp6gP9A==
X-Received: by 2002:a05:6512:1153:b0:5ba:3797:2359 with SMTP id
 2adb3069b0e04-5bb7c8d2f8cmr108813e87.2.1790932527310; Fri, 02 Oct 2026
 02:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001210703.1597150-1-suzuki.poulose@arm.com> <20261001210703.1597150-12-suzuki.poulose@arm.com>
In-Reply-To: <20261001210703.1597150-12-suzuki.poulose@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 2 Oct 2026 10:14:51 +0100
X-Gm-Features: AclHuK81_w9T9KTmUVQvA6ovuNEn5Udf2ErB6CaTomYP4-WPob3E-hZqL0sp0qw
Message-ID: <CA+EHjTwM=5PXPVByVV75AuNVw5TJRiUqu5TNOcFNPOBmTiL-eg@mail.gmail.com>
Subject: Re: [PATCH v21 11/23] KVM: arm64: Use a local kvm pointer in kvm_handle_guest_abort()
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com, sudeep.holla@arm.com, 
	jonathan.cameron@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Oct 2026 at 22:08, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> kvm_handle_guest_abort() repeatedly obtains the VM from vcpu->kvm.
>
> Introduce a local kvm pointer and use it throughout the function. While
> touching the code, fix the missing whitespace in the
> kvm_is_nested_s2_mmu() call.
>
> Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
