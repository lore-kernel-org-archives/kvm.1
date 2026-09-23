Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF82440DB4A
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790146876; cv=none; b=oXLWeYW3g5Y3bPwNbZX4NX8h2kJebbSkfsmSGf3Y/uJCggAOc4DiO69o/NhAZOPsGvvTN9EHNknkIWkEUl83TNCuI9mwAENQjId6LA/bZMEh6F2j1wtE4c86oBlff145f8alVxSKihDPhVPK6U0esPuULNpEh5DgWTZbqFQprmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790146876; c=relaxed/simple;
	bh=BFeM2Z0uvJWReEb4TmxjLVTHw6ANNaWo9dqQG/8wOZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ty28KxcadbFyHfCmSkKIijWRIUlSNlsjmOWNaDu/NdpsDwOJZ9DKouOg/5iApj1C3U3f71SCXidxPUOr7ZQkY/uBVanlHOCuDwypyRnx4pzVDJjMksNAWc8L3vMftI5+6Hw1tMC9LdS63xjh6C8L86KFRHdh/ruNP0OG7pPL8+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3wiTz36; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3wiTz36"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-3396cec93b6so655826eec.3
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 00:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790146874; x=1790751674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I70/VAGdGqE8d4iO1uNSWkA0vYBN0PWe+5KOdFzj+lU=;
        b=K3wiTz36/owfLmOD4LjzxL6d3zcgQCL/nbwFpWKpS/QZsqbOw49nRPHVGnqkVth4EK
         kOGxyJzVY+1uxyCOC470GLoOn+5eMhwzzYYvBf/6iIVtKvY/lSYzmlQ3fGqX80SUcMx4
         gd6vC3yZxLhbhdrYRwAXiSOIO7Gm/FxxEfAra6W7V5px/YhbQVTc+/I294Sl/bG4v/0e
         wdZ+pWfIuhGFgjircJjZ/QDwwOZhUI0aybHkdKPnKglvwd0t8Bs85xrT9FCkbiox5+fq
         0tanHSuYikD+Um610Bvqq0WGeb3y0kJpvpTGV8ywsMenHFTSMAsnCQa/vdpfcPV4gkp1
         x8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790146874; x=1790751674;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I70/VAGdGqE8d4iO1uNSWkA0vYBN0PWe+5KOdFzj+lU=;
        b=Mkyei1elAYAg1r0isI3mAHkGVn3fzaK/SPjxRc5K4IAm+7ExZNbRzlXGz2pyO2VAH9
         K6Wiz5NgBz9G3l/NBUqUnnPjkRHBuWgwvyMuoOMPvglg9OUHK/I5OZDDXJVf5INARQ4L
         TQZ9NlPcgb1V6kehB551xKyS53McGY2FR4FUfQPtWa0cGJopG3C2tpr5Ildw3mmcB1+v
         LQ26lyO0JEhGMyyvmV0dJdMts3Ds6H1uzKCLGa7t3XVmznT42K2jCoADRPDUc6xiVtlc
         XLimKubM5Li4i92lljS55HNoyoQQixWQhY50Yh2UT/iaUc5CBFSEtsfcuHxFcUgfncMa
         hybg==
X-Forwarded-Encrypted: i=1; AKwUvBytt84FMPU2678Z4bL//TWk12jVtJGLp1zRuZfQi+ICkN93mx7vL5bktrtW1ebGL0OLHPo=@vger.kernel.org
X-Gm-Message-State: AFuF++n8/QqAbG9c6N8zaMRm/MRvgFl5J9d+1loUB7MoGhxpasv+yvo4
	9u8SqboMfZcPQzb9zzKOLFB37jSLKIdsmRN3wAKnDR2LClDp2DHxaY75
X-Gm-Gg: AYBFou2UMQDOU6GL3xGI2hcn4CtkSSzyAk9UBMlqQBUvyppL+x2BtDrCRJfqF9+JUoK
	p1abAtwDJZdLEUy9hb69c2hpC5EcSFNdPrOP65yoGILo/aZKOJ8bNu0EFQV+MAw+UAYNBaNq4NC
	Y0I+IthB2pUO4APtRD+15oYdZwtH+Teg/2ZtMqYCYE/7tQln8bLC44/4FgDsdlNbv/b3U0bfFaV
	BmK/gJy0r6Qu7O11kg/kYOqeIy/NTSrk/uqIbYRFnH9NsRq45GHaBrOgpNxl4KvEKfXpsuM0rq2
	WV864A1MrZP+HRWCpK+Bwbj+BnLOwW4Y813P1MvZTUlRCqlQ0FB4GuDmfe2nMmtihJYTApOksJ+
	C0BzCxzRBIerri6W0cyraPIuNd1Qn6B/Do28SOKdinZqi1TRsR9Tk1l4ori8S27sUL4Jg2tYUgz
	kjpPtndLQPFv2XvS3nhoY6iUmPCavPl/LE98Z3QTdepdWTUmS/pjCTTAHDysd+s5E/ZzSJr9sfM
	B0oBUVA6hgpI1aAPJcO4pHpZELCqhyb7YRa/JKDcB0=
X-Received: by 2002:a05:7022:7e81:b0:144:ddf7:256e with SMTP id a92af1059eb24-144f9179543mr2364369c88.29.1790146873779;
        Wed, 23 Sep 2026 00:01:13 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f98209ffsm3646819c88.4.2026.09.23.00.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 00:01:13 -0700 (PDT)
Date: Wed, 23 Sep 2026 12:31:05 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, 
	nnmlinux@linux.ibm.com, amachhiw@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Avoid spurious interrupts caused
 by LPCR_MER bit
Message-ID: <arN5AY73k0fRh9VQ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260921111043.49825-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921111043.49825-1-gautam@linux.ibm.com>

On Mon, Sep 21, 2026 at 04:40:42PM +0530, Gautam Menghani wrote:
> A huge number of spurious interrupts can be seen immediately after a KVM
> on PowerNV guest boots up in XIVE mode.
> 
> $ cat /proc/interrupts  | grep SPU
> SPU:     223705     192439     273526     147623   Spurious interrupts
> 
> This bug was introduced by commit ecd10702baae5 ("KVM: PPC: Book3S HV:
> Handle pending exceptions on guest entry with MSR_EE"). The root cause
> is that once LPCR_MER bit is set, it is supposed to be reset by
> software. But when a vCPU starts running with LPCR_MER set, the vCPU does
> not exit back to the host until the decrementer expires or there is an
> hcall, etc. This is because KVM on PowerNV guests have support for
> native XIVE, so they are not dependent on host for interrupt emulation.
> Due to this behaviour, a huge number of spurious interrupts are seen
> since LPCR_MER continues to be set and LPCR_MER cannot be reset until the
> vCPU exits to the host.
> 
> Fix this behaviour by not using the LPCR_MER bit whenever native XIVE is
> available (currently in case of KVM on PowerNV only), as the XIVE hardware
> can present interrupts to the KVM guest vCPU directly. So the LPCR_MER
> functionality is not required. This reduces the number of spurious
> interrupts drastically.
Hey Gautam,

Thanks for this. Can you also share the numbers after the change.

Regards,
Mukesh
[...]
