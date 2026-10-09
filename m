Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AF641A92C
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791583045; cv=none; b=hvw6qCVrONePppf+0FepAi8H0fXKG7VDduu2OyG5Y7unG0n8S7RrY8KCoyRVDx71tzQzJg0mdKqZOIZFHhPQW51vTMV9tW1/S+7/eavO+dlgTq1qyQAnQd12165cfqEdSfffC8qpxZrTEBbL3ATsPqmEfoeeHIq3yIIMEuAsc2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791583045; c=relaxed/simple;
	bh=iF2sXZqGfO4jQUm35BKOgVu0zexVp871qIjrHtY4KnY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSmhHAjsa5n/UqgNXkNjJAsdgp4mSHfI35tRMW/DkkqCbvf0Hty42WRUGq+Rty+jsbjQGydizu94e9pPEZy6cKfuN/yMpyoJaBhcBmstf5X0aomVSUDFT2qfnPrFXyIxc6PEqb1gyE5P9vs3lwSMSWoWdwjGVk/KMvp2TLYzlIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=e9y5nh4k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AfY5l5mK; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="e9y5nh4k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AfY5l5mK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A7E981400133
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 17:57:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 09 Oct 2026 17:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791583037;
	 x=1791669437; bh=2Ey8gNGJimA3SJeWCVn5TNUyz/dpaVi41GMxpwOJ+Ac=; b=
	e9y5nh4kPJH/AjMISfuthjG1J6MZ63bpQt3+WLRIQtRmsKA/XDP1g0eApDm0S//4
	ntL/eTBKXRYFBt76Fi2scyhB7rCriK4YLn3iM0w2VX1hEwgcenyuqnkj8Y5LgH6t
	f0ftfQQR1Z5Klc2Sch5SQVXkr0fkMNIQt4i8TEX+EvWXoBZ5lKgAcusWbeFgI01Q
	GDmjQjV2A74j76bKunCbWNysvlkWs3Bj3j0dCLMuKLaPCjq4SPBYgwybmXV/YStq
	e8lf/i9yhJmZVA5SMAx3axLiAWrnRPUP/FHr9QKnrFCrF479UZwjztFCVjrUp0vU
	/zP5qQRfltgHza9C0ERUJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791583037; x=
	1791669437; bh=2Ey8gNGJimA3SJeWCVn5TNUyz/dpaVi41GMxpwOJ+Ac=; b=A
	fY5l5mKz7dT3F0knbjH+QDd2/MTHEcJsdJICx6j0r7ZZGJ7xeXJ9aj4DCZfyLH+k
	+eDXraQXFZMBPdatJ0BdD9EKyClJah28Sbxr+BSh3IQIqA9EcNSpdkb/O+i0EQHH
	VbjCLuIhr/T4eE5Z4XYq80ck9YV8fRmjlBoMhrlsX8bct2sNrSqa99ULK73hqATn
	ttT72Ck1C9B5HWm1CcK6pUgEdAdwmryT/pjzT8uq7jR/ua7lAwhtlSJAQXq0q/0y
	EMLZF6eAB/6hhcYQ13LJeZnS6I2Jeu8J5gQz5imec6XUSL397t/FKAKaS2FcFZaS
	SZKEnCoauuwTOJy8ENixw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791583037; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Y9Ah8yoBplrH8DuT10jVUBwBOxFzCXiYwk8pb92kVLC45S+
	UPIXZ56o6Ydg+l+9dEOZ7dHNchgeT5Z8MujMK1zygoMIo1W1IR4GY1qRytimOcU4
	f78GqXGM2qJ3a29HlQ3Ngzi03Z9VE4q1j1Z0RkKeKuz+V+cWtweh4eS28j6Qa55u
	AoPI1dqSlgUdGKowdOJrOndqBrn/iH/Fmbm+6FJAqo48RN/+tdDIIk31Cg92DR/e
	lRvFC9P6YPREAbYSuGemWfu/NxDCYNi4b2UpUYi2f7LNsj+zG8MwwmpeTzIKoGVm
	+Pm7xdjwImCUJ34sFV3uaFZtPG0KGcxo7nLAFAA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:A2Jjuux8HdmkF3pcMH1UpxTrRagF1ILPnsXFt3vFWr0=:iF2sXZqGfO4jQUm35BKOgVu0zexVp871qIjrHtY4KnY=;
X-ME-Sender: <xms:PWPJaq5TIhuH_9WYWDIyVzTYI63r9VvrXEJ2BPOTxzL61D4HxOV1iA>
    <xme:PWPJalYf1fI3JYaMMAJSE9NRql37q4R-O15-A8c0wEVpzJL9VH3snf48soU-kr75i
    dGeAFrIh434lyqbdNV3OnWyoTQP_QQXba-MD9Vxp_uDKVfsh5txO64>
X-ME-Received: <xmr:PWPJaphYQ4tH0o76OXghKhVZckvZmtcD8x8Cf5ey62QpJic2xZ49CXe3bJFzkg>
X-ME-Proxy-Cause: dmFkZTEnPLv1HHRGsKW5ZpzYE4wz7Cp7J/3rqyGexIB/NLQOUlqD84ZyUl9CVaezW7m4NK
    A67Aez6IFISyowqJnfMw9IefjtH3h6md08rm/wY2st8ROpK8rfDgS6gqF1r9BIiFyDF37Z
    LJVvJU2YComtaJeG9Sx6cjpyHvvIGhKFOCDe9YQSseuFvKGkMQuqEZg2NN6klOFjJZ2dig
    SjZTn8aUKxMVLYHC4syQF3Yv6SNcQqYKhTKWlrJFWDv3B2J2aaVjKUAS5oBWJNS5jIKmPC
    StZio2EDRFOLeQmEvqH6e4ShVNw8DCVicI4XIV7yX17hf7JpRRBoOrZko16QUrk6qB+vrF
    XQvKa/uJfbmqX+EGvlxltFHvmXz3Tt6xB9zyI9sN5YQC2+QvyZsRilWoxXoL+Fb/+67+12
    8bb4F8ULdXS0/LjJXFMRdqOYsfGoz3r6UB8rgAbkS1PmhvecaErwPgiPq5vGak/38AETHn
    QgPjuv1EXSO5h1OcphIMNB4UMEokr4HNHShApUSDjjSqnpjNrwqimZsLo5FpBBdmZ3gox6
    riX9Uqzyr3vcGASSJErjaHzsd1nWVpQ0E3ZfOCzYxDZMlnWgF64M4hoGb9Fy5F0tWfFZ2x
    dPeVd77/9mxfeQ1nJk14I+gPCIH9qNWMzVc8UC0iXbUUBIX0Pbi4vBtQzQlA
X-ME-Proxy: <xmx:PWPJam-iYU2tL5OMC2qqMlZbKu4oBeYHkqaW__usIFnUZuBOmxPFEQ>
    <xmx:PWPJakorDwGVjcDletXf30snuZj3upni9UZa15iPBZEq3seQAQwAjw>
    <xmx:PWPJauUrAyD9VuN6dJno1Qyrg2ysCKkd0TU3eJbJOZLYMex32Ln5vw>
    <xmx:PWPJajDJqNBDBFGFjtkUfFLY6NMMWeXE2lXzburTpBDaGDAfiRMyYg>
    <xmx:PWPJatZDw1tz1w8FhjD6HHwQWH2Cr6551twXAiNCH6C3togUZ2H_gwpI>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 17:57:16 -0400 (EDT)
Date: Fri, 9 Oct 2026 15:57:15 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] vfio/pci: Drain eventfd RCU callbacks on module exit
Message-ID: <20261009155715.11f6d974@shazbot.org>
In-Reply-To: <20261003093806.544631-1-yaojiale02@163.com>
References: <20261003093806.544631-1-yaojiale02@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  3 Oct 2026 17:38:06 +0800
Jiale Yao <yaojiale02@163.com> wrote:

> vfio_pci_eventfd_replace_locked() defers freeing replaced eventfds to
> vfio_pci_eventfd_rcu_free(). A callback can remain queued after
> close_device() returns and the device driver module reference is dropped.
> Once the dependent driver is removed, vfio-pci-core can be unloaded while
> the callback still points into its module text.
> 
> Wait for outstanding RCU callbacks before vfio-pci-core exits.
> 
> Fixes: 98693e0897f7 ("vfio/pci: Use RCU for error/request triggers to avoid circular locking")
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 6757054e9d87..9bce419c52c8 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2675,6 +2675,7 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
>  static void vfio_pci_core_cleanup(void)
>  {
>  	vfio_pci_uninit_perm_bits();
> +	rcu_barrier();
>  }
>  
>  static int __init vfio_pci_core_init(void)

Applied to vfio next branch for v7.4.  Thanks,

Alex
