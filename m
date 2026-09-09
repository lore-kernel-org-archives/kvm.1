Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11F13C1D63
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990157; cv=none; b=lvjgNhc/0JP6ndnp/rJnFUYGfPvzC5Ztb5E5XM8/fHR1XgiI91ZvvepgMwK70vFfZK1FCb2PLbxJnFtHghPWXNlGFNAAfD9hcjsRw+fnGDTSRZw4x/GP2c6pTtAejdjQy/QdD3gUG3fX48dQ73+EVltgyV4iI94xZKmPTBIeDM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990157; c=relaxed/simple;
	bh=+IKffq9pprORu/KuX01+OiN5RXzgXZE/Rip7wpReN3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/k/QLCFe8fPWqRhQFFQ0ZJYufL3+5Mlxb2b+29tHNJv4/Cpw97jtOiX1dColb7S9rx/yEgqtKydHKY4vDB0HJRwFZXIbb3A/qVtE/Yr3YPM6VcwrF/6YRYuemZ+dPe02PA5gF66lg3oouAzfP/OUjk2SvMqayk2i5aoyz9hQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vS/j6iG8; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vS/j6iG8"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db22383fe8so7084815ad.2
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 14:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788990147; x=1789594947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qfRs/dMSlypvbxykgYdrURTYGjZtEsKfNPrWbGMlcPA=;
        b=vS/j6iG8qRxU9peeTkAmySsmp/RWuH0vYV5eFq1bgbrKisXYGbKuie/1/EdTUpOypw
         +E7UgYJFyE9EHFMWEbE9obC68U+g/LdltFLbMBUiTJEtpgJ0gGh6kTlUHl2fbPZd7qfe
         3YjN48sGoWaUbaML8G1jsNzt1GZ5MuRPgh41ChKBlC+mfWx7TVR5/BTArLwhftwArq2q
         z8D5kFoFqQb4dRb+6C7ddDZymeTdWjSSlgtqOji7Hq9kU6xT8ZvKdpsMNdEUkBs9og0l
         4PbTS7zIDiKX7VIBJXHu1IAbFwTlbAU+pCV0PeSiannWerJK+OOtGF5/EwWHluOBHQqT
         R2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788990147; x=1789594947;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qfRs/dMSlypvbxykgYdrURTYGjZtEsKfNPrWbGMlcPA=;
        b=Dwn9f/4w9qNvDUbq06TBRycdYCjJ+9dnCzfch8QtMznmkoLslZIBOMWsOyCZigx36V
         Ch6jYmSq8mvnQY8+qNsuXi79O0ukMf638kqfZKejLxqxkppVCbHsRVmaC2niMsd8C5ws
         Vhzm7CmMhMOX5I4qZrh4EbBFLQ5M4i9VccnbKTkwx8vQF0jlsR9pV7XS/FS8wM55HUFk
         ALGZzDk49Dxwz8986WtiH2QHKMGv0XrCzH9aMu1Dhw1ubSiCMsxq2AGs3TwYQbtyeJoO
         RqSJ0xVbCqF+bDJsihohRVAcbRnxovBgpD3kIEYUpUrmNa3nTQSOD8BnczEuYntX1kfD
         kjGQ==
X-Forwarded-Encrypted: i=1; AKwUvByvL47e+JrdhCLCukIUs6nUMekbUH40s2Raf0rINtfGEgT6h3X8BPmgBU+NWU03Rh6jXQY=@vger.kernel.org
X-Gm-Message-State: AFuF++mj4TaAnfgOO9oCpTetAzjcDKojQUXIRmlLPOqlakDE2ay3LggO
	H/lZ0N3K9Ww/6ZGv8PwP7zxVwGR3sHWjZ3Fgfl4LtE3tY28DIa/m2nIURB41ivsI0w==
X-Gm-Gg: AYBFou31P1Kgl5W9zCsTO9XoHjzTbqTWySg8v2fYNB6ZJvZ+e5FomJ6ZnDdmyYRGMo8
	lesADkVdMMW52IZUAKwjOdRV0b+kJildN1gRS9aFUt9Dw0jy7A3YTxJB9qnxusoJO9lIDbXjWJO
	KZaj71SKRt5KaAUqQIy5XU7HFvA5JyzJUekJKeCWJ5z7x8dJQfQ9h4U0Tt4dRmnFI3J6Lg5PdBY
	Olgb/3AZyGPd3MZ07T+iSTmc+mhKXnjzQTyDluCNYpzQonK+KTNBreBJbjjljbXdRSTfo98vIMY
	3Gxyj53REJ24aKdUDkuXLtrmMM0lqcI8OsSd6HxgBhavnuXEFlj5iF2YO2dtGoacWbWsULt4jBD
	8PxdkDlj6eBeP1Z3Xc0H/+9ARcwT5A1/VhsEXxllzzSIhFA1Kimvw7rwj/nYPQocUg+G9IDaWXA
	GaINaqrVL/xOMmdy+agS+MC8boTOnLYJiWyAtDd/UicG+FNmVWXDYFNSJRA4dmGPbhth5UToYKa
	vvS96Ady9k4TXcg3Ovi7mt3MbUoBL972ciuZ90g+zUwInhTVsA=
X-Received: by 2002:a17:90b:1d0d:b0:37f:fdc8:71b4 with SMTP id 98e67ed59e1d1-39d709e6ed4mr5411396a91.2.1788990146322;
        Wed, 09 Sep 2026 14:42:26 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d7738ce41sm1430549a91.3.2026.09.09.14.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 14:42:22 -0700 (PDT)
Date: Wed, 9 Sep 2026 21:42:18 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm <kvm@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 3/4] selftests/vfio: Extend mix_and_match timeout to 90s
Message-ID: <aqHSuljynlgmVxmN@google.com>
References: <20260901215358.2421359-1-alex.williamson@nvidia.com>
 <20260901215358.2421359-4-alex.williamson@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901215358.2421359-4-alex.williamson@nvidia.com>

On 2026-09-01 03:53 PM, Alex Williamson wrote:
> Systems with firmware first error handling can see heavy SMM load
> as a result of the mix_and_match induced IOMMU errors.  For devices
> like igb that get wedged on these errors, the resulting FLR is delayed
> waiting for the transaction pending register to clear, which never
> occurs.  However, due to the background SMM, the backoff delays in
> PCI code wildly exceed their timeouts.  As a result, the whole test
> can report failure.
> 
> Extend the mix_and_match timeout to a value shown to complete reliably
> on such systems, with ~2x margin.
> 
> Assisted-by: Qwen3.8-27B
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>

With the caveat that shortlog should be "vfio: selftests: ...",

Reviewed-by: David Matlack <dmatlack@google.com>

> ---
>  tools/testing/selftests/vfio/vfio_pci_driver_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
> index 761bf117d624..1d532f944cee 100644
> --- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
> +++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
> @@ -190,7 +190,7 @@ TEST_F(vfio_pci_driver_test, send_msi)
>  	ASSERT_EQ(1, value);
>  }
>  
> -TEST_F(vfio_pci_driver_test, mix_and_match)
> +TEST_F_TIMEOUT(vfio_pci_driver_test, mix_and_match, 90)
>  {
>  	u64 value;
>  	int i;
> -- 
> 2.53.0
> 
