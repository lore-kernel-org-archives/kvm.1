Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7CF3E40F4
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990734; cv=none; b=mqToyKIhu5ezAEjpBVupjkoEudkdCFVciHBoklPVr4h4/2m9sZi2U4fuaNGUuAdabTCf6E/12G1rhFsDFKQsU9VMkJDu2kyXtfsg1nqfu1c0n6/d6CdQSyx2vuTgqZHNkJDKi1qMRLefzM2vMhzv7QuK4AT55BqJTDRC817IFMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990734; c=relaxed/simple;
	bh=qQbPsCR7zQtDIHPUVuibU2H+q8UKY7xlBbVL4dX7Wy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfx1EZKJtCJK+yyxj/UCqZKZkRc7OJCcLsDxL6Mk8dCQ81px2WxyPr74VMHih/0GT8nGDYxp8R5nEM+HLp02AbINc8/iaKzIUWdZBsb1C9TYifkkdiRbsY8ISksdvCSDZRe6pe5QroNZXxqRyWTjse+WVVoIbJ5H/YUJC20yBo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tkSZ3yG0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tkSZ3yG0"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d8f265cbe6so54955225ad.0
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 14:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788990723; x=1789595523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bCamGyjjkDxfDn1PqRtYYcfreXW3ECF8AiZuRQhHSQo=;
        b=tkSZ3yG03OeuR6jJKSDNfi1a4ayqiLdL2cRKDuMckJQhM/Qr0UtsnMfOvSiAnnSDen
         LGkgnIskP9l65sUNndGW5pi3sy+7n5xq3WXCzGuewYLoU9BGqdbCZq0CCZSLsGrxgpCj
         UNaItggDMNiUTFqpWKkDe+n6RXDvk6lGjpq7Ef1OEScrIa91/VVun9SuYaOIoEt8qYCB
         rRGK6D+vsasCbw8wcU9Yjhr81TjzJpC1Ze2MqJKQsrKCzKMx0xS96vyosDvBlYuP4XMs
         VMGowAZ9jYAqnElWIUKJ2L/AvFRgWs+v3FuMHQVs6RLfQ+JvkZLEI3FR5BRHMPovfeS6
         jmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788990723; x=1789595523;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bCamGyjjkDxfDn1PqRtYYcfreXW3ECF8AiZuRQhHSQo=;
        b=kHdkw3V6hSl2O8yoDcqp57ib2Jz4ljU2L55TRhj4yjjTMKZp7KuD7839OkiVq1UzVo
         FkTFH3GLO1EredlCoz6xGr43ATm4OQKVqxMlIO9tXIuk1yLuz32gF29fADOeuInd3nPN
         NysQcEq1yUffHy7CQ0ltDgthvfBsONz5gtunpXcotYEGYXWXZf5mD5MzX0EHeBrE2QWD
         ovY3Kx9EFFuMSm7gSzhLhyIi9Ae1HmUMz+Bv30Ob/Rm5tMFsDO3xJ+Lv89iNvX2xfO4I
         CbhQrKBkbme2Lyu8+1YBt5b50yJGrP0gr1QgsaysfG32NbCzhlws6HH+votkgln3/ggc
         wADA==
X-Forwarded-Encrypted: i=1; AKwUvBwtOUirrq8oqZMsK5ctSB4GxlD1mLW+2yBrw0P6jt5SJWZYio2KxHhKaUEOHBcgrY9OOzQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mvlBfI9TLr5YT3AeWZTcxKHJw1N5v7m8x3TvPi0JKmH2vlvV/c
	ReDUUp6ladjS6bitFLsaUEgEr9M8L7Z0nFQ1dB/38dA1AjVj/w9ufu1YunMCGFq0DA==
X-Gm-Gg: AYBFou1XfAi0TyHjwkZgAUi0+tH2imRi3IsW+9znF2OVDG4+T/uFIo4Ik6PwKHnn3hN
	YQ48RqEeHrm7buSFzPPF4DJO0IZb6x5wXQK4J1qmn7y/KEDZtXW9b1BQJqe4Bn2RAMyc2eaqOgw
	QA1HXEpz+dgiwERpU0ZNXnSzqocv6ONLO94CKkmIZ73sHUnOjxgmF74fDkw8FdqgaD9XdpUmiJe
	jeFdigqPTIxGpGjDmQY155omd6PDEHbMxcZNSBfB/KSWjiCZMr8mJ88cgC1crBJAdsrullelWCi
	Ny7yTcd3SAalHZ8TSahECMUui8rB76AL6gbV6XNmcJwqwSy639JwHxwZ/OkKvfjApC5/1YrCNOw
	a+sLbQOVmNEL6TgfyULjTAMsdPHhBmhA1K3K02SR4KrKS3AdzBrIasbaFi9DLOWP+HDkdZ3CMwG
	IXE4Pouupbl196sIrJyQII5eoECL0JNuglj8J3DmqrpQwquH+sCHCLty07v1+NysbnihqpS0e1a
	8miA9MWDg12QyfkFJW6XFhLUP/lj0f1zYxiHVIB
X-Received: by 2002:a17:902:da4d:b0:2dd:8e5:28d with SMTP id d9443c01a7336-2dd08e5053bmr43507235ad.8.1788990722587;
        Wed, 09 Sep 2026 14:52:02 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dcffa9827dsm15047155ad.66.2026.09.09.14.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 14:52:01 -0700 (PDT)
Date: Wed, 9 Sep 2026 21:51:58 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm <kvm@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 4/4] selftests/vfio: Extend timeout for runner executions
Message-ID: <aqHU_nqICBENMI7B@google.com>
References: <20260901215358.2421359-1-alex.williamson@nvidia.com>
 <20260901215358.2421359-5-alex.williamson@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901215358.2421359-5-alex.williamson@nvidia.com>

On 2026-09-01 03:53 PM, Alex Williamson wrote:
> When executed via the runner, ie. run_kselftest.sh, tests are subject
> to a default 45s timeout.  None of the igb, ioatdma, or nv_falcon
> drivers can run the vfio_pci_driver_test within this window.
> 
> The igb driver is the worst due to the device getting wedged from bad
> DMAs in mix_and_match and requiring the full transaction pending
> delay prior to FLR.
> 
> This is even further exacerbated when the system implements
> firmware-first error handling and the transaction pending scheduled
> delays are preempted beyond expectations by SMIs.
> 
> Worst case observed runtime for the whole vfio_pci_driver_test on
> such a setup is 450s.  Round up to 600s.
> 
> Assisted-by: GPT-5.5
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>

Reviewed-by: David Matlack <dmatlack@google.com>
