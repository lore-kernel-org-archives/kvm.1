Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F15940DFA8
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773944993; cv=none; b=RNhfUwmEG2uvViIyPh0IUPlNfZ5j+jIm+aJ3ngNCAW4eDENnhiv8xzwvn7ahz0IxD6q+uiIPr/qTWypMuYAHZn/BCFEaV2LvCWRsTOyJk+3lNrpF58N7qbNtuj5teyRUo2PQ2RSooHpFMa+HAhUdmCg3NgH5x+BMeemAD63Fpgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773944993; c=relaxed/simple;
	bh=l+b+ARBQj3dJ/ZowWqKuBa047ok7XkTYvsb110E9hQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVLD0F+xlD4Sr7/+LmLiWCi9wKw8V1MNQvg3X9KgmGCaZfX8fMbVQhf849eXCETrbWJIPK+B5LDHHSKApEy/Q4O6lWPZlsPdmr8m+02O+7XDXOqjT9Rwpc9Vy7lwIS3WuocXDMCOKVFC7lJ7cRH+pU1IY8VTQV9NGjO3cB6DZ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fkyBdYg0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fkyBdYg0"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b05761bec1so10544985ad.1
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 11:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773944992; x=1774549792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l+b+ARBQj3dJ/ZowWqKuBa047ok7XkTYvsb110E9hQE=;
        b=fkyBdYg0UYYEFTzz1iHXDkP6Jtbl4V51bg5x3MNQ2RlDKz9pn84MncTxSyv7z5Fwn7
         l7Gta53hEyPyVojun9uERa3KXcf8xe89B8cK217SHwLghp4WgQUtfnml0eMaBOSjyo1j
         idvIlr3V329B7RVMekLhMQsS5BS1cg4+tGZVVXs92US9hdYAkpp+36o/3jUFc+3GHEiR
         cDDs9sGcy9NLCDPEIdOw2NNzhNA0iR18KE68Z8D6Adi0BcsDITQZTtzmAgx3Rv0SJjsY
         jt3yngYp7jImpI5IuCeU6EgUg1Nq4KoFUR+Uy/VX0AM8qa6O5BuTm5YvtpG5epHYu72D
         TZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773944992; x=1774549792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+b+ARBQj3dJ/ZowWqKuBa047ok7XkTYvsb110E9hQE=;
        b=kemYwl1p4/MsG5QXOCdtssg9culbfISKlsRSHRlPlp4BokHPBFlzEaiyy1m0eYRyi6
         MUxNW4LlAmAOdZeqv/s6z4t4yieRMWsn9ncYgfeDcLE+Y+XYegs7j3p4m4R32pTDEB0J
         qIvJX4SPShTsZHmQDGAHnmizsO5Z/yBsNVa5oNsemhp6QM83TTOcN6fJsUCggcXU3dCE
         Kvz0OuLwb1Z4E82BAEHLtBieIxIXhrMTOUfNxCtagmPUY4oK8Hixsc7cOAcskiS6f2JN
         z7y5j5eUhY2Vak3xSoNBw2cItBIiKPkkg1McMlSd2Eow6rcl2dWakgPeM2igF2QpHYg1
         oYGg==
X-Forwarded-Encrypted: i=1; AJvYcCWCI1Y7v3jB6akYOGqX5LWp6RNcvefj812yZChvylcivVMkWWuHYrIz7TLEx7ofYmaAoqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4kPFNFKTR6ELRihSVlldjJs6cADPP6fYG2EVufXvA4bDChq9b
	6y4baP5r6NmXFdOWoOcXf8g776xfJ1f2hGLQfi3/7RfPo+5UxO8E/JfWB1sb3Sk+4Q==
X-Gm-Gg: ATEYQzy46La8e8xvaXFjWNY1PqT1zdkU56SR65qtk9F0Jgut+J+ODzYFr2BqPbscyjR
	TxJrWCAmfmDvbhjaXYfy8ivQ4MFQ9BGOY/EeaxrkqvG7yKSb8/ueGfZTzuT86BecK+7EUz/2sYF
	hxCKwW0zfIP6D1iIswSSAHJoiqygzaX+UhNHC7/fAo2d+Aj+PB73OjyHac9iQ6L6UrokgFJmnAS
	FcA6Exw4wWkeTGeVCNzgnIKcWJoHSBu9teyqTLcBcfP05ZLJgWzl2s/oKszUh65UdtJVIE+MPx4
	M04wi4762TxuXnl8mqYW4qiWSBWgWO83ayT7POzHXI3e7DZO+MCPLEPYiIMmBfhEEKVbb1ViTOX
	rSLnzQZBfiagOnboDvkGrrWcdh0tpacL/AMUg7bTWZixVNyKG4pIsGKpTOCWncyWZlzMKf7fc4Q
	ShCGDXApScqxwaiB8oi06mHu/GRi1rluEJjfRK1B+F/oBdYy+FyWn1y2SLzu+YVQ==
X-Received: by 2002:a17:903:11c9:b0:2ae:5ab4:f4c0 with SMTP id d9443c01a7336-2b0827bcf04mr2347095ad.13.1773944991550;
        Thu, 19 Mar 2026 11:29:51 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e5f12d9sm62873345ad.39.2026.03.19.11.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:29:50 -0700 (PDT)
Date: Thu, 19 Mar 2026 18:29:46 +0000
From: David Matlack <dmatlack@google.com>
To: Rubin Du <rubind@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/2] selftests/vfio: Skip MSI tests for drivers that
 cannot raise interrupts
Message-ID: <abxAmnZ6yncRVCIY@google.com>
References: <20260317214239.124857-1-rubind@nvidia.com>
 <20260317214239.124857-2-rubind@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317214239.124857-2-rubind@nvidia.com>

On 2026-03-17 02:42 PM, Rubin Du wrote:
> Some device drivers may not have the capability to trigger MSI/MSI-X
> interrupts from software. Add checks to skip the send_msi test and
> the MSI portion of the mix_and_match test when the driver's send_msi
> callback is NULL, allowing these drivers to still run the DMA tests.

I would prefer not to make send_msi() optional if possible. We sould
need changes like this in all future tests that want to use send_msi().

Is there really no way for the nv_falcon to do something to cause the NV
GPU to send an MSI?
