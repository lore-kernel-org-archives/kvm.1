Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E2737C920;
	Wed, 20 May 2026 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779311550; cv=none; b=MPNXXCLG7XvjqpinPp4TKz7DemAH437slYIaMOanJeBY8+1j6u0rBUszHzRm3wVMo4kSTsGHiqQZKXs6oJOVGRiQXO/n9bq8E7gWFlgOyB/wVxtrgdM4ANMjc6bibH/Zm3I/QkkO00JvJsQrSsY/SKEc4gJp8JSMKUXz+fqaUkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779311550; c=relaxed/simple;
	bh=08vLQLWnuhRKKLlm5wyjGyt68cNhf+3R3K3L/adyWrw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEF49but44Dqhrf8Tv/4J+djlVU5DYzK26//z0ZeLOG/Sm/vjlWqzen0p0Wc5YQSzwG2S11fcJuQsh1VONcNjen+E7trVXKUWnOiscoTnhi7mMjC1O2E8GxdlAwGcuPV4dOZM2MtRKLTAxPLeuOWFh9b/NuASffoAxgklNNYBkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=pWx1ug3o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cUth50R4; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="pWx1ug3o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cUth50R4"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A2D307A0074;
	Wed, 20 May 2026 17:12:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 20 May 2026 17:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779311548;
	 x=1779397948; bh=BhujxrjIpcFU6LgEEWIyVRjY+ePnpDnNAjlScJ/34+k=; b=
	pWx1ug3omRi86eFiFO0xNWVtrAGQ9rAvQe4KwRYO8TMhanqEaZejEUFV0iaTBrdD
	valRsaGdiPI4CHZedvk57B56Z8Kqq+RvhD7P/47RuKBdcth9y6tSvsr4OFDXdfWj
	NwRe5hKbtxGNxTMtV1d/phDbde1s3iopPAJdLC1M7MPr6STh7VyZoENwCSjWVKyE
	UcVo2H0fRygQAbTzBAdkn89X3p+B8kyZw+6HWldf0gECuRPkW77ua36y88X9Wjdp
	XjRGp9/USTbg1znUSkJfS4zWl/Px1Ww495sg09OjdyexQAVtJX9JIehR44XVGm62
	kgIQ4qxR/pYp4U+E7pU7uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779311548; x=
	1779397948; bh=BhujxrjIpcFU6LgEEWIyVRjY+ePnpDnNAjlScJ/34+k=; b=c
	Uth50R4Gau3u6pFn6OsCZcj6KrgXSQvGWNHD3FAG4QlVMszzEntuwHLrLWJ2KZbF
	P10ayfX6oimlpp8NlvMCJ41iwjbqi3/UnLRBtZLt/Lv1x4oSTvpBB8ZS/XofSKxb
	+DY6hwNkjvR98gFoPL2Iaj0JwpCvPw477ECChshAlTy+MntCij3H11fDWo9p03z1
	bxCPYZtay70Mbk5dMxyUBB9IWCs7/Drdz/2GNMaJ4flvu7JPkwp4IenL6p+LhfU9
	91R4p7rMTZ4FEuuZWWT8kE2OuOfVdz+ZIHNF40XPsnybgsqAe7d5sDDlAOgqYg0o
	rEAUj3CYAG3R/elYL7teQ==
X-ME-Sender: <xms:vCMOaqI4aEv-G5-PVdVwQlsXUTys5AjZ7vsyc611iXjl3E4mcjJGHg>
    <xme:vCMOai0XSf4iFq02sDEa3ufxdJhDRbmt_uS0JLKCWA1r6Y87Zwvcbb3L6ozhbxK35
    l3YFq4Koq79obTcn1PIAZHMBoDkK1oLAiYsZLzzK-ogytxOnWD7Yw>
X-ME-Received: <xmr:vCMOao4gIpvKKTZ48Y8p1tPmOlt5D5GSJ5axljdFF3KTwSiZcN-TiFvrt9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedukedtjefggeetudefffdvgfejtdevgeektdfhieeftdetvdeileeivedt
    gfeiudenucffohhmrghinhepvhhfihhopghthihpvgdupghiohhmmhhupghsrghmvggpuh
    huihgurdhpfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegrlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepjedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrnhgrnhhtrgesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepughmrghtlhgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hvihhpihhnshhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrhhhihhlkhgvsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghlvgigsehshhgriigsohhtrdhorhhg
X-ME-Proxy: <xmx:vCMOaj_Q_C8JNog95jSnY3SVqOFwOzcx4m53rqYBgLPPEaLs52dufA>
    <xmx:vCMOanWgq6FEJJ-cKGMn83tNibXAzTkdeuQ-_qXrJhLK0eZ-rsWUsw>
    <xmx:vCMOaupqgfiXOaGUg56AZ0vGc_8FvlXVH89jXVYOTd4SkUj-QOg06Q>
    <xmx:vCMOapl_bSQIerRdzd5Cf3LEgtmog5u7GwOp02bnQqI4TWNjuGwj6Q>
    <xmx:vCMOasogV7aeHqjEh3_2aa8jFugMKa_1uTRqwQDKm1Qk29kVCzjZmGCH>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 17:12:27 -0400 (EDT)
Date: Wed, 20 May 2026 15:11:54 -0600
From: Alex Williamson <alex@shazbot.org>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: David Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>,
 Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v8 0/8] vfio: selftest: Add SR-IOV UAPI test
Message-ID: <20260520151154.0ab57ded@shazbot.org>
In-Reply-To: <20260505212838.1698034-1-rananta@google.com>
References: <20260505212838.1698034-1-rananta@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 May 2026 21:28:30 +0000
Raghavendra Rao Ananta <rananta@google.com> wrote:

> Hello,
> 
> This series adds a vfio selftest, vfio_pci_sriov_uapi_test.c, to get some
> coverage on SR-IOV UAPI handling. Specifically, it includes the
> following cases that iterates over all the iommu modes:
>  - Setting correct/incorrect/NULL tokens during device init.
>  - Close the PF device immediately after setting the token.
>  - Change/override the PF's token after device init.
> 
> The test takes care of creating/setting up the VF device, and hence, it
> can be executed like any other test, simply by passing the PF's BDF to
> run.sh. For example,
> 
> $ ./scripts/setup.sh 0000:16:00.1
> $ ./scripts/run.sh ./vfio_pci_sriov_uapi_test
> 
> Created 1 VF (0000:1a:00.0) under the PF: 0000:16:00.1
> TAP version 13
> 1..45
> # Starting 45 tests from 15 test cases.
> #  RUN           vfio_pci_sriov_uapi_test.vfio_type1_iommu_same_uuid.init_token_match ...
> #            OK  vfio_pci_sriov_uapi_test.vfio_type1_iommu_same_uuid.init_token_match
> ok 1 vfio_pci_sriov_uapi_test.vfio_type1_iommu_same_uuid.init_token_match
> #  RUN           vfio_pci_sriov_uapi_test.vfio_type1_iommu_same_uuid.pf_early_close ...
> #            OK  vfio_pci_sriov_uapi_test.vfio_type1_iommu_same_uuid.pf_early_close
> ok 2 vfio_pci_sriov_uapi_test.vfio_type1_iommu_same_uuid.pf_early_close
> [...]
> #  RUN           vfio_pci_sriov_uapi_test.iommufd_null_uuid.override_token ...
> #            OK  vfio_pci_sriov_uapi_test.iommufd_null_uuid.override_token
> ok 45 vfio_pci_sriov_uapi_test.iommufd_null_uuid.override_token
> # PASSED: 45 / 45 tests passed.
> # Totals: pass:45 fail:0 xfail:0 xpass:0 skip:0 error:0

Applied to vfio next branch for v7.2.  Thanks,

Alex
