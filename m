Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E174D9F71
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108811; cv=none; b=WV3NJILJj11rgmstY9xy6eNS9jpiZK8tQBK9EmwRnPBwYClJkEnEP02iun9b5T+gRpbca5G2Q8HE+paQXnNa+rSdJw7rHz7xbtbF76HqCkhPsb3i+GC3Ohlwh2ANj7eJgxgu8lgAwCzs0uyAKKxCLB5Jm/416zQnV1CctbqiSA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108811; c=relaxed/simple;
	bh=QqEHOCux09a0Q8vXL7DmpuXdHbLuTIeeYNtJksyQERU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJEXO09cm4m8+wQsxrjreg0mb+kn/6MM5PVRJkB1E2R+9Vtst3Xxae0cu5jaJsKowSaL9PuEOWQxyb3tsftTPPaNZBBaYcMN5jiiNLj3DeZ/E29J0DzMW9DJO3KdhJuuSGMwS1PBVbcZV0UMiMMF69+28trqtz2o6TIX/KNOW5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oeES/4ls; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oeES/4ls"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-917c04630c2so71295626d6.3
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 17:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792108809; x=1792713609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QqEHOCux09a0Q8vXL7DmpuXdHbLuTIeeYNtJksyQERU=;
        b=oeES/4lsLOyq6iDysQyL1B5xi59UWJQzeHHnLneDcRPAWcIVAeM6vJwv8xnwV4Y6kP
         F3yvNOgN8dKsbw6t3xX2J7hcHZJ3sDKz0+cYxpGrog5avZV1zKm64X4+ubIuuvzelovr
         4QAT7mPUDntexW6b63ykRbtEoYBSjQPAcE85i7diDm8xG1rcUgXyDwKf3AUYoA7WGyKK
         5CGcyacBMCik2W4awvlskERMgndl3J+qFtCSKO9PSuVV0c7M0dTGYFuzJCSH0Ts28yiY
         qqeQW0UbHn426QXsfzBX9viYYFRPjTuCTBxyLXFhSJQLRjYurxzDQ/chGlrLbjJytHTA
         9DmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792108809; x=1792713609;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QqEHOCux09a0Q8vXL7DmpuXdHbLuTIeeYNtJksyQERU=;
        b=BbJ/UeZBiA8Ua4NS8k5jiFyXEuIHvRxITqxkZSXmSomdObvYO0uSj4KAc9I8vgSFva
         LUfXmMglhxQL6XfTdgY60ShPvvDmjRgOGZohEtoNI65KNFPB+qVGTllwSyidfwcAFhDJ
         esNbZkd+7kunGx24dQ7FCQnnZzFYhcwX5q/vK3xliFYH1EBEY6ZGncWv1LFRJ7xGHTfp
         5fsxqmyXk1tbUzsHu7SCCUq8JhD1ZvYcQhSREkOp0QvA6cYIXf+6D3ZL9xQh2rktg5gX
         YhiVJhAlhCDil+XVKFX+RJUm1i+OV9mSsgpWB4/LSLdj2hbOhjenuDIQ2LuEhmHb9jYz
         1ZVQ==
X-Gm-Message-State: AFq9FYJ1NWBKZqVJluHOGzoRu6Agw+w8kHMLD5c9mGT7IQhyxT4SgixO
	LnZRk/skW5hbDqG6LlB8ka7gPil+bWlhkcbF9RrWE1b/Wkf4ReXUdsSQuBoWvqXrf+A=
X-Gm-Gg: AYBFou2gFhfw/cxGmExPbSrvyrx6oIXwMh/DoqBffe4+bI23LthmlvLK6cdQ5DwC4cJ
	tp4XH+3fh01MmywZiYng5qalCz0vRT5EeEnhcQ/0O2QF30EyZyYtJNjB4EAh+cS+zznYMYiHFXl
	p4SgUMxA1YqsSMgfX4reaKSSpVda7eRXaTf2gnj28jIfJyOF5HriIP6gKUHZMRNZ5qCwDj+81iq
	n0JWP15xI+WXXsofHHCOX3irxu1WooX9jhzlxAvkbqbmyRZPMh3mhlJ0Muele5XULS2r/1TL3yX
	fTf7+Lqs/JDHD8JwvbBVSdRTY3w38DlF3AJ/GQ0laXv+hr1A42Ix31vcsvCUE3etCVmrPP6mMpQ
	T7eX2Wl23yX+Sq9Drup+FX9wCVLd8t7GII+BWSB7RgcZoEliGOr0WcsqWWNoFbHTGD8vboyeew1
	xfCpAOey3aUb8JhgYzn0QQGG8GU4qymQB//svJTJI9FMg0pryllxWc0VckcJTk6Org3HRG+YYbe
	eVCGxZsJWLuIMIrIsnsJhNPOOA42LdnGapSH40aNA==
X-Received: by 2002:ad4:5deb:0:b0:917:bbf1:5323 with SMTP id 6a1803df08f44-91b55793527mr367860846d6.38.1792108808237;
        Thu, 15 Oct 2026 17:00:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bce8918bdsm4228956d6.48.2026.10.15.17.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 17:00:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xHVMi-00000000H7g-17qS;
	Thu, 15 Oct 2026 21:00:04 -0300
Date: Thu, 15 Oct 2026 21:00:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Gong Shuai <gong.shuai@sanechips.com.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Tomasz Jeznach <tomasz.jeznach@linux.dev>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>,
	Wu Fei <wu.fei9@sanechips.com.cn>,
	Zhao Qingye <zhao.qingye@sanechips.com.cn>,
	Gong Shuai <gsh517025@gmail.com>
Subject: Re: [RFC PATCH 0/12] iommu/riscv: Add nested translation (vIOMMU)
 support
Message-ID: <20261016000004.GB14213@ziepe.ca>
References: <20261015065232.604503-1-gong.shuai@sanechips.com.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015065232.604503-1-gong.shuai@sanechips.com.cn>

On Thu, Oct 15, 2026 at 02:52:20PM +0800, Gong Shuai wrote:
> Add nested translation support to the RISC-V IOMMU driver, so a KVM guest
> with its own vIOMMU can own the first stage of a device context while the
> host keeps the second stage, and add the interrupt support. This is an RFC
> and comments on the design are welcome.

The iommufd parts looked reasonable to me

I feel some mild skepticism about all the MSI parts, it would be good
to get more of the interrupt stuff actually landed before posting this
again.

Please try harder on the commit messages, do not use AI to write them
like this. They need to explain why this patch exists and what problem
it is solving not some inscrutible description of what it contains.

You'll need other riscv people to help you with reviewing it.

Jason
