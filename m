Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F0A3C73EA
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 06:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784788897; cv=none; b=S4DzLaH3ByawxmLJwUlhfDgAX5q8TN6+QfontIDwrlPYMlEKN9MY/b9FWbq0tHRinGZMsyOZFnL5aYpnct/HLhkcch2lyPSdxUhTXZWl6cieXFRl+Vsb/cFUy4UE/M3n3qrqmaQbkcvhcExJdFNwz3rkusaQRb6c8o6xrYz48MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784788897; c=relaxed/simple;
	bh=86EaQ71H9wrBDpHi1TuDx7jIxfZCbuF6tqGwKMFU0vk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CgVAkyzAWcIv1DQKhEali6+qbbLbL5sM6phuSU4ZLhRHzIWTBQ14uz2QYC7hRULe9bskLPf+l123fuYnEQRNDCKYMO19OZIYrMu9l78+jzU6v9HPBpZQr8UNIBxHExf5UGpP6fejUyjpu0UObhF0DyIzcohSR29kisOU26TzuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QnZXsL8e; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QnZXsL8e"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cee9b74ee1so2340405ad.3
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 23:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784788896; x=1785393696; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QOSspY99PS95XYy3k/Cm2lnCOhDLD+Y8WEKL3nl/jIo=;
        b=QnZXsL8eB4WHe7wOnfWHc6PuK7vgML7+aYCkAdSywWwdCiRg8TNu8EA/kvFJXPKnV1
         bEx+PpIVUT5t/Wectv8X8l8M1djpTB/2vqij7hTGEdzqnnHNoAiZmehDLFNC33Ti0D9p
         4PiTfkojicFb5imFF84Kugtb62yAEYRCtbIkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784788896; x=1785393696;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QOSspY99PS95XYy3k/Cm2lnCOhDLD+Y8WEKL3nl/jIo=;
        b=OFxQ3NvQ2CREKo+DoJc2EteRXH3RdzxvYzMxZg+Zn7k7TEWhsUWYgWHy37Ip8P858/
         DLXT8LyTXcibwkSc4WoC4RS4Jj1dmZEls62n+P2KXDuR0NdgPFmPRuC1LV9I0JNfRwvH
         Rg75AgD51V/lhhiMVrShk7WDbcW15IV3FUATjuAraqcChsS4YXu3x4TWGLIx5eyDaa+Z
         EIoEWHjFPe10QJUWZ9Ux1ahzZ7OTiit4yc4VxdA3Zf1/IZe2/6AKNBz+zng5IHSOQH1L
         MzlLzwWoJqQFl2toFjQO5s5K2VNyVoyWuzkzeZ4ISYW7wqdT7uvtF2XEPSF19mlXHRKY
         4b5A==
X-Gm-Message-State: AOJu0Yy/uFRmOnOsK2TnkZ31E6HGOGQZXcBbBgy2lxVfEw74s8+ivTfF
	+Rqrk+Rb/FqPoGtiW0fAAXD2GN51sLtTI3E0iqW8/oOx33zIbbPCb5pJ/oNT7plpXg==
X-Gm-Gg: AR+sD10QtR+nvluYkK8/o2+176x06Yb/a0ss2ztcVaTzhkwPB3pq2O7oSTXV1DIm4W3
	gp2Fn43CsLrmMMjiLobI+LigtOUNdgjYS5DdYt/IqZTNeQ8xAFeFdsd2xxLv2A9EmxSvDMo2PEp
	WuqMEkZQib7daBg83Yb+uSM7euHn/roAzIE5z77kqjyiSotT7tdM2e6FvJl3GBUUau8FXyw3BM/
	BkeFREmySccU441VKyxNfagllwCmd2miNWbZJvPfXfUpli2CRmAPBdKyA9QOJ9ZWPDi/cPqktms
	AeQS3/DwBDEBowlWQQEKjML7XHUMu9n8LjbuAyFQ1Pv7EY5uzHRrTVI4hLCWDtxTTqf+yOUJBim
	HW68qV8HIA7XCLkAqrh7BklUcD/m1qGGEyc7hL+9o49m37uwOyTK8AoMnqP8deiFqmvOUTauDys
	F3qgRDIZKKIRpGQcQ1a5zTY4wKJQLNXE/CXW5dqe4ihg==
X-Received: by 2002:a17:902:ce89:b0:2cc:6817:d9b1 with SMTP id d9443c01a7336-2cfa74bc9f2mr21950805ad.41.1784788895650;
        Wed, 22 Jul 2026 23:41:35 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:2d0e:cfe6:a39f:d530])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd8b6esm27685815ad.26.2026.07.22.23.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 23:41:35 -0700 (PDT)
Date: Thu, 23 Jul 2026 15:41:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, senozhatsky@chromium.org
Subject: Re: [PATCH 5.10.y 00/17] KVM: fixes for CVE-2026-46113 and related
 issues
Message-ID: <amG3L3Tkmxuz_7S3@google.com>
Reply-To: 20260626112634.1778506-1-pbonzini@redhat.com
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Sasha, Greg,
> 
> this is the backport to 5.10 for the above CVE.  Similar to 5.15, the
> fix was relatively simple upstream but only due to years of refactoring
> and cleaning up of the code; fixing from scratch is not really feasible
> so start by applying the patches that are needed.

Similary to 5.15 patchset, has this series stuck?
