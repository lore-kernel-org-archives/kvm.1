Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826546;
	b=0O7FP/ceFMG8vWqDcEcFMYOt1EqcKwWXBF744wlDhqQb3MyxcEzPiHS9mroHM/F5EtS3
	 oIciav+hbYB8jSpUdjFQvWYv2Lo1sr2ttGo228Px48NDBX7VjTs4pAvipwY5UI6wHVi6p
	 6t1vwHY/zZEt6sBOmmXhnJOjwdamdj4kvXueFt3CTASitKK7BTgAqTkOG+S9QrcCXT8ed
	 mL5aI8N3N+sDwCkQJZsSqdqX3lMDJO1mH4LOu16MG/ArmzHxmik4G94zkcgrzWJVxVJa9
	 VIfqO9bqs99M8tlU2abhE3oWBRUiOi9jj+r3Y/MGHiUBKVx0PtKK5jpCdoxyxDOaz5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=yDPvcxyyAFu2o0bBlGBxdTvgOqGA8W9gBnR8fryqjt4=;
	b=po8+A7f/4r2taD3pDauf4tGoIUWjDjxMOWc7fnKDPtyd3r3nrH7/kfvBkfstLgjN44fo
	 /Zjk3rqJtlDPpMUSRpZQ1UgfqcOMjwAPXJLpfw5CBISlrEFN98pixCmQi9zkjh8wWTIpu
	 W11q6JbyM3jbP5piORX9PVs0a6gb8RtpdzkRSs1gI/lEKU6hGuIEFR8YlnzYWAj6ZVeVo
	 /3M7YW7hw8lFdtc0nM6NaiXR3V9ck/cHa5pcGoMz1xsBeRbDtRZvcEzffO8TAgcHfSY+k
	 XAy7qdW59MSKIue/pfYcEhXJlfCtHT5jIeg1WNe+/b+ad+AuuuOmLOBjsBt6PTpgl5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Pr6A0HKM;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7610D60A16C8
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 21:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7610D60A16C8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Pr6A0HKM
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdaefe02d5dso726243a12.1
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 13:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793826546; x=1794431346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yDPvcxyyAFu2o0bBlGBxdTvgOqGA8W9gBnR8fryqjt4=;
        b=Pr6A0HKMR+uacVoDnXqObCt7qtZxWvHFtdVrtZp/Hzd2nIVLH9iN4ZoAMZQJx452RL
         yb1CrGhUxcRSrysdnqKgt+cJcwB1t9GaqEu+plJDv9PLO/k9h6aaFGOb+XpuyMZCmbxz
         u9tVCymVpq3MZFEfnyb04nwaJd8pMf5vCSIKrzRCh5gl8LPnKig9qdtExSW+JGSavch6
         SVwYcqt8THLnEU7mpwJPtPzxGwqCkdzVZwBlQx+sIWghElVmdyWN9sa/htWBxJuJAyLr
         AjI4n96YJJ0FeU6f/5rDHlght4AY5M7c0WHNXkEMeMTW2BYhGAtay3zKpI9aJdNvpjci
         8njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826546; x=1794431346;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yDPvcxyyAFu2o0bBlGBxdTvgOqGA8W9gBnR8fryqjt4=;
        b=QxsGL3jlgJGA1blZ9oguZfn65Uag2W0ecUWTuoAjaxGoeCybIjIVUHkW0x377fhNUf
         yfJZ6KwFfCcOnZkHXx71OXIK/5RcyXHG6KZgLR5GmW8hdvR6mJmDAbMGko+YTf99tfOt
         NNRWK6aWGqv1EiC8RPZntuFL+/aPhptKtY0t5zirxJMmn/t9Ryz6vGD9MppCE78Ez+4D
         j/XLM+DRBMetFowJUDUhRoq6MxBC8+wqqb4gCR1jfB2Gw5DMh9cma2EzJWYjHZNsH/7X
         Hsnf670mj/AAdFnLKMA8YPNXg8FID+M3yKOYLKYmqxOpVzWb4IstVGOid5k1EXcl1aEv
         bSow==
X-Gm-Message-State: APuU4Z8ic8r5EcaYLRbomVNaWosKBC+dChkE0s6WKubQILrfpEQiYBBt
	udNqCZkjImenwkesBh0+uNtEG2DdzexmsBnUuz74xKe4tWet+oiOY/gbqDlzR72YvA==
X-Gm-Gg: AYBFou2phWYGMDBlHWrX/9TYbnZFl+dTvsSRGTMMywyrjMyWA4bAvZpG9BFpQSt/328
	3c2Vt6FQMm+ucJLq+ze4CbDTr6GqIYPdlorbRCQkPA6ht4a6xbZHmaEMOubYl0TLU0AC2kIs1e2
	e7XW8vbSpiK3kyrLbyTK8Jul+v6bq51C4eZUyMf0mMeEt6Z2JDGq+e5TRELzsg63ifFvJpvw2Zt
	e2zyflEH5KyeiBkFtqK3bdFZMvJQqYL2vJoRibrDqE/467sLdAK2TV9MPcfPW/arC5R7ZzPKl/z
	Ri2g++64VkDKT6RhA9IDdbRFHP26aBE2eufzRfwEcrD79YUcBPPvyxC3zbUSKYQuf0NDfG8mGW8
	EIz3dzW1xRVRj6xuHZXsaUAkJ4IRANUE0rbfkofkQGJVuAu/AqGtsLmLKIkTxdsVjSSJ7A1lok7
	U6QtMvBCt0RInINUSlq8z5dq+nC8/WvkS8322EyDpxJaGQTFs/4yMNLTn4lGkxg07pPudpfXeF4
	F1aX48xCBahbtI/7BuaOCOBXeOr1VVRb1M5vKZ9Rt+h95Vv6xSH1tNEKSFqemFKEzm2MQgze2hj
	YOXQ9+NwfVQLFB2Oi1514NEaI1LeEo+HpeZ6QJiE5bu/bdtZxJS3CT8+OYwiG4qk
X-Received: by 2002:a17:90b:4c81:b0:3ab:188b:c5bf with SMTP id 98e67ed59e1d1-3ae897c85e6mr14503462a91.18.1793826545271;
        Wed, 04 Nov 2026 13:09:05 -0800 (PST)
Received: from google.com (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b312e45dsm668723a91.3.2026.11.04.13.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:04 -0800 (PST)
Date: Wed, 4 Nov 2026 21:09:01 +0000
From: David Matlack <dmatlack@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Alex Williamson <alex@shazbot.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2 5/5] KVM: selftests: List the known IOMMU modes in
 irq_test's help output
Message-ID: <auue7S_vdnGtTM3c@google.com>
References: <20261103002205.3348519-1-dmatlack@google.com>
 <20261103002205.3348519-6-dmatlack@google.com>
 <autHA6aNrg4s5PkV@google.com>
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
In-Reply-To: <autHA6aNrg4s5PkV@google.com>

On 2026-11-04 06:53 AM, Sean Christopherson wrote:
> On Tue, Nov 03, 2026, David Matlack wrote:
> > @@ -159,7 +159,8 @@ static void help(const char *name)
> 
> If you're going to do s/type/mode below, then the initial help lines should also
> use iommu_mode.

Will do. I'll also rename the iommu_type variable in main() to
iommu_mode.

> > -	printf("-t	Override the IOMMU type to use (vfio_type1_iommu or iommufd)\n");
> > +	printf("-t	Override the IOMMU mode to use instead of auto-detecting it (%s)\n",
> 
> IMO, the "auto-detecting" blurb does more harm than good.  It makes the code harder
> to read, and for me at least it's just extra noise in understanding what the '-t'
> option does.  It also makes the line reaaaaaaally long.
> 
> I know the parentheses are pre-existing, but that was somewhat ok when there were
> only two options.  With a big list, it's again noisy to reach the end and have to
> think about that the closing ')' is terminating.

Agreed that the auto-detect blurb and the parentheses are just noise.
I went with a slight variation, see below.

> This really should spit out only the available modes.  For the internal assert,
> it makes sense to print all modes since that's just doing a lookup, but it's
> annoying to have to manually probe to see what's available.
> 
> Juggling all vs. available is mildly tricky to avoid having to dynamically
> allocate, but not that hard in the end.  And IMO, it's totally ok to print a
> misleading message if a mode becomes (un)available mid-test, especially since
> this helper is unlikely to be used except in terminal situations.
> 
> E.g.
> 
> static const char *__iommu_mode_names(bool include_unavailable)
> {
> 	static char all_names[256];
> 	static char avl_names[sizeof(all_names)];
> 	char *names = include_unavailable ? all_names : avl_names;
> 	int i, len = 0;
> 
> 	if (names[0])
> 		return names;
> 
> 	for (i = 0; i < ARRAY_SIZE(iommu_modes); i++) {
> 		if (!include_unavailable && !iommu_mode_probe(&iommu_modes[i]))
> 			continue;
> 
> 		len += snprintf(names + len, sizeof(all_names) - len, "%s%s",
> 				names[0] ? ", " : "", iommu_modes[i].name);
> 		VFIO_ASSERT_LT(len, (int)sizeof(all_names));
> 	}
> 
> 	if (!names[0])
> 		return NO_IOMMU_MODE_AVAILABLE_MSG;
> 
> 	return names;
> }
> 
> const char *iommu_mode_names(void)
> {
> 	return __iommu_mode_names(false);
> }

How about listing both? That keeps -h consistent with how other KVM
selftests list the options for their arguments (e.g. backing_src_help()
lists every backing src type), while also showing which modes can
actually be used. e.g. on a system with only the legacy VFIO container:

  # ./irq_test -h
  ...
  -t	Override the IOMMU mode to use
  	Options: iommufd, vfio_type1v2_iommu, vfio_type1_iommu, iommufd_compat_type1v2, iommufd_compat_type1
  	Available: vfio_type1v2_iommu, vfio_type1_iommu

The available modes also get printed when the requested mode is not
available, i.e. when the __TEST_REQUIRE() fails:

  # ./irq_test -d 0000:01:00.0 -t iommufd
  1..0 # SKIP - IOMMU mode 'iommufd' is not available.  Available modes: vfio_type1v2_iommu, vfio_type1_iommu.

libvfio exposes iommu_mode_names_all() and iommu_mode_names_available()
for this, built on your helper for juggling all vs. available.

> Coupled with the above, how about this:
> 
> 	VFIO_FAIL("Unrecognized IOMMU mode '%s'.  Known modes: %s.\n",
> 		  iommu_mode, __iommu_mode_names(true));

Will do.

Thanks!
