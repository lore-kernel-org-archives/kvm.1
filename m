Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7535C2BCF45;
	Fri, 29 May 2026 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044072; cv=none; b=mjl1VQI+zlGtBQXaTP19C7ExM2tNy25Exjf3F3w8o7fmXRUlTWVCGfcLUb3EVC+L6INNuzz9saDUSgJ6yUSPaXKTwfelqOyksV4sVX7vR2JOFZS6PiAQWDunFw6/WcIL4YKQA6L29w5xlzfyl00eLorKJt5Ae0zEaK+ZKOUomjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044072; c=relaxed/simple;
	bh=7ZOOnZ0LsxWu/V4l6cuXWju/geuBx0Ghn+hIvG09L44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=A3/aeyrTnOGafZMDRhcdJ4kF++nJF0pZwbGpX46jtlKt4lry8ZnEXiIz3fvRIzbc4/MBbd9eU9EUd/l7XS4FiWeB8Glpkm/Pg3m1RvVJsjbQc+6OlaaIg0FgJ7t+w45SCXKwd7sRJyIhv6faQJ2miOAMKdvvG+NaStnS39Ao2Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=kvRAtzob; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="kvRAtzob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1780044071; x=1811580071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uFT89SlVEX/0jI//PCM8qJr9ykfpa+z58mb97MEoSM0=;
  b=kvRAtzob7ldMlocHbpyPp/vokAUpSlqSGJaBfRQ2UGOz2jFA6CM3g+J4
   RfpLm8JmDNfqcVs3+BtJgGIwZA1B1TvRHya0HoZGcjCltE6/VXv4dqxgc
   5+8awTJfJSj/VOddfWuXA87TtGsgOFJ//J2a8UldtJFoC1xYns/MWlbKi
   bSDqijX+EPij2jafs2g84+Vp48Ed4Oj7mGCo8IvOuPzNK7u4Hf54K0hwe
   +M33ZdcErO2KLVTWdRJZp2zikhGl0Vr6+OwGBGKFjL3NSCmzOsX8l9GyP
   E9hLcdF02d7I4E8LHadHu0NApc5Lay0UIDVNzKzL716eN2hpz1kI8WaBl
   w==;
X-CSE-ConnectionGUID: otawseM6S+O32ZpDJTpEqg==
X-CSE-MsgGUID: HCOUtE5jR/elNDzli9Ambw==
X-IronPort-AV: E=Sophos;i="6.24,175,1774310400"; 
   d="scan'208";a="20493375"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 08:41:07 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:23966]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.245:2525] with esmtp (Farcaster)
 id 60c81e0b-e71d-4971-b825-decb01011d55; Fri, 29 May 2026 08:41:06 +0000 (UTC)
X-Farcaster-Flow-ID: 60c81e0b-e71d-4971-b825-decb01011d55
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 29 May 2026 08:41:06 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 29 May 2026 08:41:05 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: Sasha Levin <sashal@kernel.org>
CC: Bjoern Doebel <doebel@amazon.de>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, Sean Christopherson <seanjc@google.com>, "Alexander
 Bulekov" <bkov@amazon.com>, Fred Griffoul <fgriffo@amazon.co.uk>,
	<stable@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.1.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Fri, 29 May 2026 08:40:47 +0000
Message-ID: <ahlQ/m2bMK0yEYfQ@dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260509122858.475f3b407568.re-kvm-x86-shadow-paging-uaf-6.1@kernel.org>
References: <20260505070812.221568-1-pbonzini@redhat.com> <20260509122858.475f3b407568.re-kvm-x86-shadow-paging-uaf-6.1@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Transfer-Encoding: 7bit

Hi Sasha,

On Sat, May 09, 2026 at 08:46:50AM -0400, Sasha Levin wrote:
> > [PATCH 6.1.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
> 
> Queued for 6.1.y, thanks.

As I don't see that commit on the stable/linux-6.1.y branch, did this perhaps
get lost in the frenzy of the last weeks?

Best,
Bjoern




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

