Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B5C33C1BD
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783375451; cv=none; b=RLfNOosttZxKUG0UgTiL3tLDVGkS+7fCAZnUq6fFd1dzpnNHI1RnCXLhk5ACYaCNgzKjcrVXN63upN7X8aNKPHyJtK19G9A+vYMpg1hjzJ9dgVvBPi4mFPcbafwSd1b6gx16fCpoNUo+cHYvOCm911G+A1fK7yUefo2PJcn9i2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783375451; c=relaxed/simple;
	bh=rLy/ysj5tbpERefiVlqo7Up7k2XPDa6wDyapX0dgtAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXtAynNg7Eue4IyXVwquESJXqdYc2bjXblaM1IKXR5POTn41yf4eGUIuZ7t3YtzJqzJ2A8QYE+sqE85pSdjVvMCl7uBUToW2q2OGXi+v1xrQvncEnYOX2P4Y1pMZTH/mz+TsH0c6i3JSvzWba5eEB3iwXQsrpjJC5Z574k8NXNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RFfpI5LL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RFfpI5LL"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cca0c5799eso14291675ad.0
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 15:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783375450; x=1783980250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ExF2e/cXpRQsXQR0TRuzWP6MSTLDs8ljOSl9uaYcPTU=;
        b=RFfpI5LL9CeFLidDrLl0FoW4hdPY0VRDS3QcnJ+clGW9WvEdLWCbXf5J92IQaigrL0
         Bp2yCFakukTmmVAeM6ZeL77QMcc1fuAoIEuR6crhbkkApmqw9D+jN7f1QHWJvW5OVEpH
         HMKrIENsTn+MC7NUTKuJDYjpGtSn++j3fihYwBAyAwtNYsWCciQQ2k35Qq/3TlLootZC
         QWk1MTX627gzw34S731LWLEO7OtwnWzZDfC4rJzuaQ4IBgCZzwQfoQjLBmdo9Fd5iEQu
         UuuCdoHxTO1Stpoqw4pKcg2hSFefko4jeIiEQyJjzXTXDAI3L21m66dCXTiOVDpnycmx
         vePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783375450; x=1783980250;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ExF2e/cXpRQsXQR0TRuzWP6MSTLDs8ljOSl9uaYcPTU=;
        b=qB84He5ULsM+vmB2Awpglk4NA+IXllp/T5QrJZ7eaKt6Bb3A+9dgnuMUvL5y0brfcO
         CCm8do/tYKgaq0XYIGOLIPbSsvkREHJ5r8Lh9tbmPwBV28GBRW5LGTGDsniABYRdW+/h
         F2QT88ix/2WePzbv41/r2RuWJWOOKaGVBWJznKl6E55TR8Feuw6TNmJ8FJiIRRZz+KVh
         aoz35w/Z1E2wpmqQjESqAt4uv2ZvIN4Vqx7rDZKpE2Da4ZMXE86MfuhJO+P1eWT3RZK0
         mMrtYEhu354jcAlAgTDe+oWN5q+vI6ws5gzNTmWQN4YUyPHZ7syVoW/v8ui+NvBXT6Dg
         oMug==
X-Forwarded-Encrypted: i=1; AHgh+RrNzk3fPqpNKbbDxAcFuB+FH3nDMYr20lvsDqr3qnc7PmOU2DbETDJHFBwyPOHwRb09gJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKpqVJCqYWEzWSl8cgEhgF7RE0QDz0L4B1CfMK6LDa1MLljr1o
	Y7jhZ1yWKkygJZ0/TNQgPkhIPRBDOu4dZqgpH7G69GIqA+EQBwQo08NG+WqWNgWIxA==
X-Gm-Gg: AfdE7cnNeqzB9GeW+XBA+k/se/ogNMohdZh8ddrff5cuXQpgnKI11Xk3g3qQGDY/Gbi
	UM3IbSlgWrmgUCq9djlzn4Rpg1NgxxxwLW/kMpqRKKGkF8BlpJNeSugphZH4qmEFS+mHBbZDZja
	aLlLH10ChpMuJIf9UQqyKB2nzRLbSpDZy2sDZKXPyU5WQ9Cq8CVfO1BF645t8VVUmTafi+nN7dR
	eqm8FWYWTaQMEa/Hn3PMzowLzpMb+FQddjrz17kEB5591bjUGuSh8jfEmN+bTaqlm/jQY/oi191
	P2E6YxTUyhWJFJjfvr8+HOyoCsNqEnCoBie5D81NTiygavDOvt34PpTvFYC9VmHRPawrVxF++LM
	1j5/KFNq9KVzpJvc6CuOGnf5mAlEiJcYau8kMeP20kVMXqSW5moEoYn8fpIZY4HoVTC7FZQnkOb
	IAbzZ7MVtxqA2GNdTyoRX7pBpbWioPWQxgqORfVNEQQlqi2RLXCLU=
X-Received: by 2002:a17:903:3d0f:b0:2c9:b48c:fdde with SMTP id d9443c01a7336-2ccbf057775mr26873645ad.26.1783375449431;
        Mon, 06 Jul 2026 15:04:09 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf8c12sm1075785ad.26.2026.07.06.15.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:04:08 -0700 (PDT)
Date: Mon, 6 Jul 2026 22:04:05 +0000
From: David Matlack <dmatlack@google.com>
To: Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: alex@shazbot.org, shuah@kernel.org, amastro@fb.com, rananta@google.com,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, vaibhav@linux.ibm.com,
	sbhat@linux.ibm.com, harshpb@linux.ibm.com
Subject: Re: [RFC PATCH 3/6] selftests/vfio: add sPAPR TCE v2 DMA window
 helpers
Message-ID: <akwmVUE6w_4mesUO@google.com>
References: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
 <20260703032806.40946-4-nnmlinux@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703032806.40946-4-nnmlinux@linux.ibm.com>

On 2026-07-02 11:28 PM, Narayana Murty N wrote:
> Add helper support for sPAPR TCE v2 DMA windows in the VFIO selftest
> library.
> 
> Track the platform default DMA window separately from selftest-created
> dynamic DMA windows. The default window is discovered with
> VFIO_IOMMU_SPAPR_TCE_GET_INFO and is not removed during cleanup.
> 
> Add helpers to create and remove DDWs, return the active IOVA range, and
> register/unregister memory around DMA map/unmap operations. Window
> selection is done before IOVA allocation; the map path only validates,
> registers memory, and calls VFIO_IOMMU_MAP_DMA.
> 
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>  .../vfio/lib/include/libvfio/iommu.h          |  18 ++
>  tools/testing/selftests/vfio/lib/iommu.c      | 273 +++++++++++++++++-
>  tools/testing/selftests/vfio/lib/libvfio.c    |   2 -

Let's move all the spapr code to its own .c file under lib and only
compile it on powerpc, and a new header file so that the code in iommu.c
can call into it as needed.

Please also avoid adding ifdefs within function bodies. The generic code
in iommu.c should unconditionally call spapr routines and those routines
should be stubbed out on non-powerpc architectures.
