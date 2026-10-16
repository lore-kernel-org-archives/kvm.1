Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD4A3290C5
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160740; cv=none; b=YAQDhaY30V6H6mb6V+yDuY0+ILMw3SJNEfToh9IXS4YAp2GcfOk50gejATKSVph1zNVfSWf4INF2cluv9zdvzHeAFsYYDrqXwk+aVY15EhhYad8iRfWNJkKw4/ot/zWLO2YFgvGMvTh5IRuyabX0EFd/jmPTQ2HhAT/nlf7ySaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160740; c=relaxed/simple;
	bh=2vGcDzsdpNp3kRCn75jM79nFrKB+2GlocvrWcAHxSGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY5ch69tpbl5OC607LcaizM8h/VSWatmbzm6I8DbSxWPumN7vXH3K7xybZ/aCMvefP10G5ZrEBpZ9h55Ofyf2THnwKLGDJEGnUxSV9jr9tNfw6Jeo6YFMXcsSRMy3V78KmHZGmuAxN67Z8Exa+kZWGFoXFoFDUcroZXPze+CrgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kvURZYWD; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kvURZYWD"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91791ec1b83so460166d6.1
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 07:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792160738; x=1792765538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J9B4QGdToSnYzAqwiubGkyqZ40Y9TYft35PK0Z/WSHI=;
        b=kvURZYWDvgTYLkFx7XuMDIdQbk+MKxRxGjg2UBYsrcwP/o5fI+hjXSaJ8IGTYm2Bcu
         EZFlzZonKMQ0U8yGEtvMDMLfL3cCeYMtK60HZK5NqZRwObNwq9YdxxkFJw1w81L/uY1O
         fZk3tknIxo72h9YH10hJ+qsZ5LRFhMMp4bUMQczPjDIoPnNQaHNxOpQmBYi2WrLHZgCq
         83SOdMy7RJOK6UwN5Tp5EaBguAu8alDujax0CE8XdkS4ncI6oJXySHbxeshgGWHUABCQ
         4YHCXZuZFEMDwDSeUAqyAiq1xQqVpfqpzAUVQYBENwNTHYPlGXGGbMlFxKnwxK8tAapC
         XJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792160738; x=1792765538;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J9B4QGdToSnYzAqwiubGkyqZ40Y9TYft35PK0Z/WSHI=;
        b=lSUVzgF6mcGup41GZV68odnx+BucqtTQYHXZkEKHx+uZmYk3kzXv9hHwUa0bgKpJu7
         0yYW0bvcg46svfTeZPxwVPaf8x0G7w7r++kUGseZiSX0Vavts1rh4cXJm265tbHRzzLf
         5mn/U2STA5GFXw1xC4cJ83+OQGe58X4lcoYMKaFwtxH+Awq6LkjjVts6g0CVCzxEwpib
         R1ISYmctvplT+GBe7em8/pb3VvIDyoU0aAKhua1ysOZFYDWNjPLc5npxT55Zz6F9ENha
         7yBUk1l238eH77yqY6y32lh1NojpSWz0UxsB/8wlt0likwOpkV+4FokwciPA/C9nUXLz
         Q1DQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJppe2IOlEZedTSX2BtBXsy4mdA9hVTa34xfApcfs/DO7plEuVvfH2Ub1lyBdrmYqDo9s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVpzI94hlkMJTl4dU80bgr46x/JJRCZpRrxGjNDEzE/tmj2b5p
	aDx8JiXp/hY9E5vPejEZMYTsQHgFAhpzEXKV51gizjnWMUWFCGAIlGHnB+dEPB7UKDQX1uN4ADV
	cluC4
X-Gm-Gg: AYBFou2ait22tlGpdXi5eDVpwtTAVx8/MsgIXfwCX9z4bS2S7DyUxPbxma6DALQhgI4
	iLSXjZNeD/Ja5PrGTL7ZhTfQZlS/LHA0puztYaaGACa+5GWzBDaNX3i0W7KriXEau60sSBxqDrX
	Yzl5jIM2mE8efQmYamTYx3nINZRzL0t8SKq0IhH5ABwrb9ac5L358QVM6CmP4ArSwpioPYc6CZJ
	SwkKmNcPh3jaVrCJsxgzIn9FQ9wnOywdDVNjdQvvK8UyvyxG8APKlSpTRIApsOJwrL5qatNvXrh
	St9ZFinSrLmpyP0N5YzlInQl7U1X3TzmU+rZDjvxzb8Nsmupj6JJlUGS+Jp4ORkdb+IZuZ5c2+o
	jGW/yoORHfZMJ+zAe25q2YSTj68OMExG2zt6s7DlLaOtLJnODQ2KDws+d2vWC2Gv1RWfvheiWi8
	hdz0IzqQ2Le/NgY5BIvNkFBbvLmcxzbMVQTtPmCrBztkSeIsY8rBPF2E0KrP5AaPVYqnMK/JS4P
	ugIa3RC1hfCghtg8S1lyc2NBKHRLuGCXYUOa0ZgJqQsvimCNmFAXYkH
X-Received: by 2002:a05:620a:3947:b0:93e:78b7:fa4e with SMTP id af79cd13be357-93ebd24b2fcmr3934753985a.37.1792160737536;
        Fri, 16 Oct 2026 07:25:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcba3e3a0sm23953506d6.9.2026.10.16.07.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:25:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xHisJ-00000001pql-49O3;
	Fri, 16 Oct 2026 11:25:35 -0300
Date: Fri, 16 Oct 2026 11:25:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Gong Shuai <gong.shuai@sanechips.com.cn>
Cc: alex@ghiti.fr, andrew.jones@oss.qualcomm.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, atish.patra@linux.dev,
	fangyu.yu@linux.alibaba.com, gsh517025@gmail.com,
	iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	palmer@dabbelt.com, pbonzini@redhat.com, pjw@kernel.org,
	robin.murphy@arm.com, seanjc@google.com, tomasz.jeznach@linux.dev,
	will@kernel.org, wu.fei9@sanechips.com.cn,
	zhao.qingye@sanechips.com.cn
Subject: Re: [RFC PATCH 0/12] iommu/riscv: Add nested translation (vIOMMU)
 support
Message-ID: <20261016142535.GD14213@ziepe.ca>
References: <20261016000004.GB14213@ziepe.ca>
 <20261016091610.13912-1-gong.shuai@sanechips.com.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016091610.13912-1-gong.shuai@sanechips.com.cn>

On Fri, Oct 16, 2026 at 05:16:10PM +0800, Gong Shuai wrote:
> Hi Jason,
> 
> Thanks for the review again.
> 
> > > Add nested translation support to the RISC-V IOMMU driver, so a KVM guest
> > > with its own vIOMMU can own the first stage of a device context while the
> > > host keeps the second stage, and add the interrupt support. This is an RFC
> > > and comments on the design are welcome.
> >
> > The iommufd parts looked reasonable to me
> >
> > I feel some mild skepticism about all the MSI parts, it would be good
> > to get more of the interrupt stuff actually landed before posting this
> > again.
> 
> Agreed on the MSI parts. They are a working proof to exercise the
> nested flow end to end, not a finished design. The reason they are
> in this series at all is that the NVMe device we use for testing
> depends on MSI interrupts. Without this support, DMA succeeds but
> the MSIs fault, so the driver ends up polling for completions after
> timeouts.
> 
> We will keep following the irqbypass groundwork as it evolves, and
> continue this work once it has landed.

It seems to me the riscv interrupt architecture is a terrible fit for
Linux, so I would prefer you keep that out of a viommu series and try
to address interrupt support in VFIO through the other series.

viommu shouldn't change anything about how interrupts work..

Without the msi stuff I think you could get this merged without a big
trouble.

Jason
