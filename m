Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816160;
	b=dkzxGFUJQ/S00HsaL4JyM8OHlAABhy1FWlP5ULpNPAR1PZ54ArRf5d8l3ALOoe/gRPei
	 E144MZkZfH0SR5KSheCLGoRBNFpsV/VoWB9nX03jZPps5akDH1honDERKHTc9ezJdrWrk
	 vwuJ3/yeE75ABnePb0bhBYDv/Z7v6WZZNLYLRpLnKUXaPrhocTo3/RyPwnwYsztOfKvKs
	 OS77SJ1Qb5UATK+VLj3pLfxpkhX/e7qW6qmHPzynwTcFrNmoOVlLszqal2LwQ2Ec+Acyl
	 4NClvohut4MAFIoLdCjlXaOUooGE2ZN7ltsOmSIwixoe1umJDn4CJTSSpB9vRLkctTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=DnkyCFwfTEyghMwBbYx5eIEahNaTNIOnK3R3J4LlqI0=;
	b=ToyV6sAz8PYiKyQHa1Dne8d1LGMvB1iuqWV4oSck59OK/5aU/7iCOzVMlSdPmVCS5ITy
	 3KivDDscG/re6MgAFUZK/UeetnWR33NIzOKOYusZZAiayMoFlj6j1ZCarkqH88NJwe53F
	 tF3wKO1d+4mDa6jHnWiiRT1Cpu7mmLClNt1LBkq6bJLwVeKGqYXQS5dJP66+liTPWoRaT
	 ftmswYSpApP8+07S3q+Gv032fVvbVVfm4agFlXoGibxT2bhCcnPuQEp/hppHI1bo2RON3
	 eHD4eBzp4RJiawLd+dyJgLJmyziZVDlWPtZ0/YOx1KMma/qhU0LXAxD6HWySab3GYcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dh++Upn4;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C195606A32D
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 18:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C195606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dh++Upn4
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a05e3f0d23so540407b3a.0
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 10:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793816160; x=1794420960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DnkyCFwfTEyghMwBbYx5eIEahNaTNIOnK3R3J4LlqI0=;
        b=dh++Upn4ZWf7TCTz0JkNT4qSQSDu2Uaew4OU6cXSrs7FN7XOMXZsdZov0rgiApzPdc
         j/ns2tZ0F2dx8nx41mTa8X6jql6kq29Him+xrNExnL/EM7kKeBV8ig+90HaAGgqZAnT0
         LMettOORnr9NA//uos5+vFkmDNagJBGWiOQsed3rCndc7d9bJkQuY7waS+JLgLTTTOOy
         mBOzI23pKm7CIAMKMPrEoPNirsQWVh5aoYVmAVqFVvbXlVpht9LmGTxRgpyaAIIXSUp/
         oTAYhipNNWLuQs/zyCPXYHTZAnXDgPYTakhqHWuy2hrQCEQL/YrC2pcCxPGbjZ7j36ME
         pQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816160; x=1794420960;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DnkyCFwfTEyghMwBbYx5eIEahNaTNIOnK3R3J4LlqI0=;
        b=uQSgv/Rp6WG418lxUgaGGWuVT0iXmIIRvLU09kdTd198p1mDNmYy9YSZvqgKQ7Y43U
         XhFUrfEYLDAFzUF1S5c4MN439oTAPM0VlVQTyahxTMFJtxVYU3KEvdIv2+MwVWq2/STU
         TFj6cxx7KuQG4YW3ZyzFjsXRZ/H2r1sFKLvxDLdZ2Aug/RhdTTjFuFTW23jN0NGLDRvD
         FSV/byZTYL7DZJEyHzVfNcLLfWudKq7w47d3R6+wFHeSBUVjCh3ySQ2n1ymT5WM9ne2h
         iVtpoLlOKf4O3pMYHL4BpRWiGUNfWw00hVS3cDTDApX8UHxviQwWbsdRZgFOMf20ReSx
         YFNQ==
X-Gm-Message-State: APuU4Z88idbRHfnbN3q5k3NdMxhaNYbTAEQy0d+uJP2EFLomlb7WNmzG
	WG3TpX7cEseCCRJ7sKlVTd8MfYDrwA8Nndnhcgtni71KNLKJKxP0zDFBna7AgKprvQ==
X-Gm-Gg: AYBFou2sNWOIFu9mNDujhAzqRrsBOlw4cPyEkhXCuRtpINX9KAMDeDQmj70jLcYwM80
	L8PHCaVKSoK/7BPemv6LTmtI++wtJwJ5c4YPiIy9QuY78DB5exPOENBPVUv+akacbrIdIxhyoI0
	dxWz7U88uKvQ+0jYryB7LazSXt4Umf4dy69K8of8nKBddDJ/aSVBL0PA7x7wigGxd5pNGxr+Yhh
	UEhgBpgJDT7TMJecEA8XF0LqQ0wGBi0U1h0W0Ap9qQmA7xhu3boR2bd8SHnyldCpsza+WDDZwTa
	sQq0Qw8ihmOXixhCygjmPYEpFdi44LG+qFvwh0ECR7eJhFWZd3yxDGgZ+2OXS6ZGoCDGIC9nXNG
	HJKfhQzghPmOn+ul+MGdZkGUbeYpgCYmf+bygYaxArqmD3MUA2jc7NrtL+u+QJxiVjo3PGiIAaW
	67DwTkt8O88PIiEVkwS4XAGpOEIG+SDZgVXGrRwN4Plp4R4cgPUFBce0Ac8TElcy5TiC5CIey47
	TtiJs/phgWfeEPOesPwg1PTXcIWryQR9jIoXm8u7n38Uuiacq4r0l1ELyxLfwZ9TZp1thN+xQBt
	TruPh8XHD/Lk5ZQPWl6G+umy7gexw/ezm8bRqpiP/ECt0jV1/hoRGDGZFS632FlW
X-Received: by 2002:a05:6a00:3c89:b0:886:46c:8a1f with SMTP id d2e1a72fcca58-8a9bf0466d7mr13529775b3a.35.1793816159117;
        Wed, 04 Nov 2026 10:15:59 -0800 (PST)
Received: from google.com (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09bd3ad6fsm1246841b3a.55.2026.11.04.10.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:15:58 -0800 (PST)
Date: Wed, 4 Nov 2026 18:15:54 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
	Abhishek Sahu <abhsahu@nvidia.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 5/5] vfio: selftests: Add test for device power state
 transitions
Message-ID: <aut2WmTGY9M8BM4U@google.com>
References: <20261029203324.1637772-1-dmatlack@google.com>
 <20261029203324.1637772-6-dmatlack@google.com>
 <20261103153553.6caa7d7d@shazbot.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103153553.6caa7d7d@shazbot.org>

On 2026-11-03 03:35 PM, Alex Williamson wrote:
> On Thu, 29 Oct 2026 20:33:24 +0000
> David Matlack <dmatlack@google.com> wrote:
> > +/*
> > + * Put the device into D3hot via config space and then close it. VFIO must
> > + * return the device to D0 when it is closed.
> > + */
> 
> But we're only testing that it's re-opened into D0, there are multiple
> ways that could have happened.  It's pretty common that a guest
> shutdown might put devices into a low power state and it's brought back
> to D0 on close, on reset, on the next open, or even on the reset in
> open.  So I don't think we're testing what we claim to test here.  I'm
> not sure this specific D0 transition is observable, even if we were to
> resort to pci-sysfs.

You are right, this comment is not accurate. The goal of this test is
to exercise closing a device while it is in D3hot. The close should
succeed and the device should be in D0 after it is next opened. The
transition from D3hot to D0 could happen during close, open, or anywhere
in the middle, without changing the uAPI.

I'll fixup the comment, changelog, and test name in v2.
