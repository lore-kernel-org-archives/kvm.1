Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8A24477E3;
	Fri, 16 Oct 2026 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136642; cv=none; b=Ucfq8GEv+x6l5+Eec7mW0xclrh79tjTsRW/QA44jHwFoaAUkpOF9rff8i2PBpy71cvLtQRQR8UrDi53segLqsaDLQ1A1Dg0nvblW/XdGBLb9YaMfpLI57kywY3PnWLo1/0c60Wp5YXTT/jpBJrEFDZ9iM2wFlSJ+sFNPRVllJhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136642; c=relaxed/simple;
	bh=u+LEkQxQ0wgjk2QghwnJWo+kHAjecfErXpoNjItRCyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0FdNhcmbXliLLtg9UphRhJWd+ci8dzYoKi/eOpEDXn4dcjoq3dPRAfUzpmE25rLGPpQc/A5uuIsenbddoZQh3F6MdG1Lyg+CH1ZPRgMbFonLU+HSChN3fW6POoaRXhquBxgY/YYJVV9IG392Pk7Zj7W506dKfYF1nHWLlzVBMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn; spf=pass smtp.mailfrom=sanechips.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j5cQ00PmPz8XrrJ;
	Fri, 16 Oct 2026 15:43:52 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
	by mse-fl2.zte.com.cn with SMTP id 69G7hiin088882;
	Fri, 16 Oct 2026 15:43:44 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Fri, 16 Oct 2026 15:43:45 +0800
X-Zmail-TransId: 3e816ad1d59f024-b85a8
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: jgg@ziepe.ca
Cc: alex@ghiti.fr, andrew.jones@oss.qualcomm.com, anup@brainfault.org,
        aou@eecs.berkeley.edu, atish.patra@linux.dev,
        fangyu.yu@linux.alibaba.com, gong.shuai@sanechips.com.cn,
        gsh517025@gmail.com, iommu@lists.linux.dev, joro@8bytes.org,
        kevin.tian@intel.com, kvm-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        pbonzini@redhat.com, pjw@kernel.org, robin.murphy@arm.com,
        seanjc@google.com, tomasz.jeznach@linux.dev, will@kernel.org,
        wu.fei9@sanechips.com.cn, zhao.qingye@sanechips.com.cn
Subject: Re: [RFC PATCH 07/12] iommufd: Add RISC-V IOMMU hardware info type
Date: Fri, 16 Oct 2026 15:43:27 +0800
Message-ID: <20261016074327.10809-1-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015235534.GA14213@ziepe.ca>
References: <20261015235534.GA14213@ziepe.ca>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl2.zte.com.cn 69G7hiin088882
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Fri, 16 Oct 2026 15:43:52 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD1D5B8.000/4j5cQ00PmPz8XrrJ

Hi Jason,

> > +/**
> > + * struct iommu_hw_info_riscv - RISC-V IOMMU device info
> > + * @capabilities: Value of RISC-V IOMMU Capabilities register
> > + */
> > +struct iommu_hw_info_riscv {
> > +	__u64 capabilities;
> > +};
> > +
>
> Same here, spec reference.
>
> Also be careful to always use __aligned_u64, check all the patches.

Will add the spec reference ("IOMMU capabilities (capabilities)") and
switch to __aligned_u64. I checked the uAPI structures touched by this
series, and this is the only place that used __u64.

Thanks,
Shuai

>
> JAson
