Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F863CAA55
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784788602; cv=none; b=Bt94yI6MA9+Tn+hDjUem/El+1uHCg7HwLz/ksfYf0dejczIAVdMacjVyrBkoWTu9KDXtdsvBYPb8fPhNjt+oi+ZkU9Yq4xqkpeEfCiKmHfcmv9dDZtb8nGLou+XSqWS0tS/yUsUMKK0w9a91isMEq2tgV/jUVDjblAN6VvlskwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784788602; c=relaxed/simple;
	bh=HncrykrRemgI5fAPmsexCTMiB2KmCqX9lrGam/r48AI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jpQJnV5jarBjOWAtwsLWHzqzT3WgtAW3IKSdzZxMKXhC0moU+yTEgpNmPrFgnAgmZ8qf9lkPUsaEQBRMjHoVF5H5RhQRkhmRo6cwnmQKASzkllpzXcMdnGGpAoIECNllDZQJkxfR0caGUM1P+P4Sdt6NwOiCAV++TKUjhdrw/4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L/FlX3PA; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L/FlX3PA"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8423f236418so191596b3a.1
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 23:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784788596; x=1785393396; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AXO1TEMJyOs3biZ4fK22mPvqvMv5jSJi6mC/UFO7sc4=;
        b=L/FlX3PARni/LiS8zMQgpMJXIyRWuU3TVrn6kio/qBhJo2gc6XLbp2SAwD0oI1c+xA
         qgcJxB4Ushw0m75gBAQCZmRHXysJKXIofV8S7HWKrxOLrXTVRDPdo8PFJ0AxWikL9FeU
         dy96KzV93Pdb3gNc9cTofczTW5dLQ9ZF/78fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784788596; x=1785393396;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AXO1TEMJyOs3biZ4fK22mPvqvMv5jSJi6mC/UFO7sc4=;
        b=DwzNvmGC3yVxWD1X5cAM26hhbz+dVc+4C/9wbT7ZWJOFL+n3JVZY0SnJJi0awE1N/1
         1ojBfQobmo/ON+QAKGVDYs7MuTwf0c5oErdojCsZ71kF7KSnJ1agMv2YKgnvIB1PX1wQ
         A2gX4lRQWBV1O0ILHHf6Pc7tM6xbvFQWGl4RimNpq/CYSUNNKZibn2YjjyMhPv1lcGia
         CrE+JmpqsP6ajoeWCh/ARjcYZjzUSIaE1MJXPjn4jq65OcnO5TF1/5jH6Z4FsmekEUYf
         iKNE7UzcyQMoC4lOKeoobPUpaNaoElKZpDWbWzKdOFf4vpkOMGyvMKejVpunhoVzZIwv
         Pv/A==
X-Gm-Message-State: AOJu0YwRX1tcv0nMZYJebWcHOKe5CErkQ04zdWhTSlkCGUadoOmcTab2
	3ZxssUwlRLVQyWySPdpO3AUtgjPDsCIPKso/o9xPlXfV+mktXWdohZYBsEnCI1+lsA==
X-Gm-Gg: AR+sD12V5O7ZVy4k2ks8B296R/S1uFFGeK2nhHWotgqFF7Yx83pnHURbVKxrp3kSc+f
	jKdH/Q3OgY9v3CTytK9urBfV+VmcH9gZwm8LPbxPdavpinaFfVWvzSlI0q8uifv2NLHRPP5ZuGS
	ZbDyxXIpeIs2UIxhCLaAd8mDgVL3AvDxEBvG4XD9BVlEv42Inbbo2KYrYOKpFHpOXtyWSYPRT0R
	fQYph0B7nyFbmTm0CIPO68BCuS+ZmkPu7/8tVFdhYaC+KAAu52dhZOBw3+Ozn2KJTPN9ktwBcWn
	Qn+uQkJoNEac5awzXFVNiQ9L/Y2yUdQR8s86v+TakvNQ/+udHae6ii0ABLp5KAQFX9KZhIlIPMt
	fBsOilrdwz45+sJPPUO2ulw7PCOEADMol5JiHUoHA3JVxQH57WmPaF7wcwgBll8cDNeWFF7h945
	wlclt5+cWMAiEdicjR8DwMqrKxm68XdYzDH+AOUdpwwwxZcJjYpNqd
X-Received: by 2002:a05:6a00:3d0c:b0:847:8b11:596d with SMTP id d2e1a72fcca58-84e2bb1c7efmr2182263b3a.41.1784788596566;
        Wed, 22 Jul 2026 23:36:36 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:2d0e:cfe6:a39f:d530])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17266107sm2512248b3a.17.2026.07.22.23.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 23:36:36 -0700 (PDT)
Date: Thu, 23 Jul 2026 15:36:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, senozhatsky@chromium.org
Subject: Re: [PATCH 5.15.y v2 0/8] KVM: fixes for CVE-2026-46113 and related
 issues
Message-ID: <amG2CyrA-yEUmHqV@google.com>
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
> this is the backport to 5.15 for the above CVE.  The fix was relatively
> simple upstream but only due to years of refactoring and cleaning up
> of the code; fixing from scratch is not really feasible so start by
> applying the patches that are needed.
> 
> Please apply this instead of v1, due to a missing line in the last
> patch.  Sorry about that.

Sorry for the noise, has this series stuck?
