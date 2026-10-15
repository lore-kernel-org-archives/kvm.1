Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E08B45D915
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108444; cv=none; b=iufvLJKr+qcao/RkmnbrPrnXPR1EnwRdyofGPRQhQCsngzpASehjN3Oax3rFifP7qVV1O+UCPOxwbeGBvldwCs2X3UZb4F5vM/xLVPNnbURMrFWibejgeOStrl+RgiSaKuQmuHW7ayX9s4jgxaWAwGdmXQf7nWNYomeHpjnXa2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108444; c=relaxed/simple;
	bh=O9I7s0SiZTNmPSjPh1Npkb7UZEefmXjtj9RzEUi5lqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuLSKefbp5XfIckJkeT95O+3U2/OF5D4GFwuaa9MHdqcOaeUtZGnqwOylQFfVUvs2hmicibGutn8WDUOIYfxGlK28et7p40XJR+ldjHDVxj+g7NZX0mx779uVjJl5F5eZlN1HlnV4TvNxsqmig8S9wp+7MtEjGnyD+sILyzVXsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=O/oYrUTS; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O/oYrUTS"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93efc0452b5so144949085a.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 16:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792108442; x=1792713242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WmHIZZgl56SndGmE7ZHoozI3Bjh3H3Lm9ikaXzIGcaI=;
        b=O/oYrUTSbqZbPkKd7/8mCnhpKatAQepktYFKZnsFoTPsmWiH2g4R5Gl0Wv0JVlKrTZ
         QzP4NN5AEovHsZUE//KZ/XSCxux7YkWVMeo0i8byGlBQzEkizYCanW3zTXLae4G6WYT/
         2uKGNu3KOLEWjF1/40qGEbhh76C7NCPVHfURyNG+GHcYufA5XeRSnAXF7IBYLx+hPSKz
         h+MQUyhG1f810fgLQVwNJWCE4Bb5Vp5efgi29i/RPwnw3ddDk/6j0c+rvLo3Plroc8Qh
         et/abuX8df3hd/Hd3tm5NdieeyGgqzlHmG5WergOJBkf9eaNBmk1WCB41MK83ANBuM/7
         cDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792108442; x=1792713242;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WmHIZZgl56SndGmE7ZHoozI3Bjh3H3Lm9ikaXzIGcaI=;
        b=b6KOWRDh2+ZqD5AC4n+xj854jPcEsHSVmkvwpyh3N/1i3N91DYdih8Lu6FrTkx9PE+
         rjcgiq249Ok2ZigCAn7ZTd1gLzGQ1vnH2OrJpzmGI2QtaKRAzJSGictGgwTbYrnB6jzl
         g07BWj5YMmg96wJFdFf61xLwAFKOEQjyr9G0bVnFDtk/1Nx3CV7cGUUWoyTUBPTeXZ5B
         253JEpnDBmFhAvpa+mMv68pt3Ky0m5RRYYD9BidZT3YdLyrra0DyMgbiSnMXSGVYAfW1
         BvCx3KsZRa12jxsrgeTHEOOGvqghq4KYE/j+zLKDan3OAmQzVOMpZ02+fa2kjJi9nMao
         ykiw==
X-Gm-Message-State: AFq9FYIpSXXgbT1BM7dCpHtZuINcXfkQMn8HxCgP2VeO46D6fZeOTM0e
	LQYZOnqX4FOfbcmHWw9we6LF3Eaj51DSPGMce6E7FkZIYO6LAKUuJ69+et+e7N0CoPA=
X-Gm-Gg: AYBFou2E4YsurK3yaeAj6V+Tomv0qt9Sfgn5JDfm/lDtDw6MAQqSZx506uVKAXp9pkp
	y+huthimcWdZZ3RspH8l4XyPtIAPzQXtBVC1+wAtJx7h6qDgic+p4BiA1gE3scxWdZl9RE0TX1l
	uioFCOsehkfy1uAOVCi++sgBM9ElHg42nrA4XPak0IKPoaqy14xd6mhvLZoDJNHSRWxIj2D/yas
	LlZegWhBTIpkGh/seiro9ycFGlYYz1fbCPihVxFo0uxE/E5lW5QdHCcDeJQ+o2zm98+RfsN1t1M
	43ozvH4BJlSkj4kv+XVa032mtc8U6elGfwBuiyZ9dTWtqqK9XJ6zZFSj0ET1OCAiHBKM9vaQiMh
	jJjJ3K+i6dBW1Mbj6QmPWUXKCwazrVz1BPQMgL/JNw+CjdLQGfXda2JsqJEWC0hJPbHLDQgAKO+
	olcK7UzMnD9OQMLh0BEUJsAj3IcS0sZiPD3l2NrgiXt96GgwJ15SxPPdPt6cYRjKbRDeeRtorfI
	7ClseuyII/hSbnqQ4tCaLVVuUcPERW1/Cm3bg99IN3BJcUZso1kz90s2gCBrlaRufg=
X-Received: by 2002:a05:620a:6086:b0:93c:b7f3:9f5b with SMTP id af79cd13be357-93ebd24cda0mr3455302785a.45.1792108442214;
        Thu, 15 Oct 2026 16:54:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a19bb32sm62233685a.33.2026.10.15.16.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:54:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xHVGq-00000000GRr-1dQk;
	Thu, 15 Oct 2026 20:54:00 -0300
Date: Thu, 15 Oct 2026 20:54:00 -0300
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
Subject: Re: [RFC PATCH 02/12] iommufd: Add RISC-V IOMMU hwpt and vIOMMU types
Message-ID: <20261015235400.GZ14213@ziepe.ca>
References: <20261015065232.604503-1-gong.shuai@sanechips.com.cn>
 <20261015065232.604503-3-gong.shuai@sanechips.com.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015065232.604503-3-gong.shuai@sanechips.com.cn>

On Thu, Oct 15, 2026 at 02:52:22PM +0800, Gong Shuai wrote:

> +/**
> + * struct iommu_hwpt_riscv - RISC-V IOMMU stage-1 page table data
> + *			     (IOMMU_HWPT_DATA_RISCV_S1)
> + * @tc: Guest device context translation control
> + * @iosatp: Guest device context stage-1 root page table pointer
> + */
> +struct iommu_hwpt_riscv {
> +	__aligned_u64 tc;
> +	__aligned_u64 iosatp;
> +};

Like the others you need a spec reference explaining exactly what
these fields are.

Usually it should be the entire guest structure, is it only 16 bytes?

But this looks broadly right otherwise

Jason
