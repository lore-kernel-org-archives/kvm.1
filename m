Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734733;
	b=t5PSR0ZD4sebEYznAQEZgpko3w2rQ4b0KFTOhvXiV3aBhOp6BSf85Cpo16ilreW4R90E
	 XO1tlqhq3zMWtpxC3vUVXsCf5yrjc22BgsSRlHCGHUZrUVIpY6TKR5gZ7cZFsnRCybPqP
	 mIVwsUcWR+Xv59uyV9qA13Dge47WZPmDx8YCd7qa3L50XQSQNfM5GznkY+q6Co78XmQgr
	 ApYTm+DOUMCq5YyapANiBSdQOoxeI0R2k1j042CQ+vs31K/3ciJvA9WWaCoA8CVF15UvN
	 /+FNJlD9kWjwS5Xw/jWO7Vp7xV6DJM1l0g4Edk18iDQHXgLUQdnFDKW7cZCGY1piqng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TK3utwnIPX37GwcC6jBJrNjTtS9pS+ECr0ZBshoSLgk=;
	b=iBQp3lSSgdczsy91oRyh8ck5KaJ3Hk4VL+Ks6N6gmNbh7uHKgte8iLimjMfxe1I8XubV
	 Ga8LbwQFcYYgEEilHVJK45GTM4gmasEy9Bfu482pZaTp9oXfDoer7TUD+0d7Ot32eMXes
	 roSOrOiuUId0yJ3RuepqI8yClXyI/bM/uWlpAEluLvClV4m/PssSz93BnvN9Yqs64qdV9
	 NFKgTrMk7SPemKwwW3RNBBIkaivK6Ulme8S2XB536XV377C0z2U2EKitsFhmVAU7oCilX
	 qHGH+Bd+daJMqG3ppOYU5UwbPYWNYhu+QmUpfablcULYKZ89tF4SY3cR1qyWhDFyaJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kTewroxn;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6500606A31B
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 19:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6500606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kTewroxn
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so13886695e9.1
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 11:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793734731; x=1794339531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TK3utwnIPX37GwcC6jBJrNjTtS9pS+ECr0ZBshoSLgk=;
        b=kTewroxnzRnLBGJm9KK6T0Qt9e8811SKcmrY/TyCHzgqB+Jc0PNoEc4vAc8TXYU7G5
         qLTz1H0bAvYkkGVyAiZH1BEJ5Z3+v23XnQFSOXUuo9TN/GCAikRmDgcXO+/BrxjYMNmA
         gCXJ+MIwmYCOjW+Ris/YH26x85NTU3DDhGEjc9qbUFxFAV589uV2MjZMVB2lqYKP9HOC
         fcLgUwPQqQkymjtTRmVJUok9pUwfAAy+r3ZN9JnoEp4Rh4/vU8DnmbcSWrm8FNt0tDkO
         Cf6HsE5DA46vef7hgrHOagfPTs+LpmMp7bmn10q10nl8hc6EK9JyITLFE24CdmUh3jI/
         2NDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793734731; x=1794339531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TK3utwnIPX37GwcC6jBJrNjTtS9pS+ECr0ZBshoSLgk=;
        b=xD7vltdY6R4eB28vAG9gqYZKTsU5n1SLGRuf4j1+4T38s1UA+v6fS2OnbThO7cqB1D
         TyBwfGsQXShPP7Fs5LTqwWO8/asxtf7AcYwjn32TwYKGkZfbBrI7clVD21Nj0ZuhJ0p9
         B0EjO5bvfva9oJ6+WcgbrlEekpaJp1hFtPP/mUnlWohSvu2TZ0W80lMzwDIsfzdLP7Zj
         O6P55Q6ob87Obi0MpcQVTmmNR2Yr7Y1gZ63Gs8iRy++2RxuaW7WkTOvwLf8V1YYdIyF3
         qp+cPSFsxNpedHxKDJqzMWu5W9XQv0XgcK21PZet4Zpy++tQFZbEP5LRNU/PJRV3LlIp
         mF1w==
X-Forwarded-Encrypted: i=1; AKwUvBygoSd/Pycb1tAC94VP3QYBtP3vNa114uGswbVBlKLHjveVh5tgbgUshNE8vqFtB4jZhpc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yn08sqPBo5T5MZJ7rY4GOgEynXSJOQGfNWyOqbG1AMyGwGDX2
	WJar+d9Ji1hGxVkq5kAM0ZX/pDkjoTSb1nraTGiSt8zD6UX9XlOVdJyz
X-Gm-Gg: AYBFou2lBNuV2m/oNbeVh17RyCNk0cbwP+a4sB4iFqZjdpTvq9ib9/ABWQc95r72Ogf
	SPwt9FlJAJpcGjyKDmaXO+B83IREO3QVt4PXO+qkaRnkGNHQxy1k2dpJGB/cFaq/D+zlGsE2Bf4
	JyVbfLJ6DPiZRJAYVLG6puHu+jGCfUNWbXo7qk3sOshbFeGfPy2d9ju88efEWOE2cv+JBDmY7nu
	GAghWIKo5lC7PWwFUYrsS98LqOfjp4FVon+ewKVs6woDLYIxMkRMWVDx1xTqK4PMO/iuV4mQyU2
	Q54QqiIGu+eI90HFWLnwrlCiegWwytxhB4hmFH5pO3e1iN8FslBFtuUOeeVfI0op7U264gKoV9h
	CwwQzEoaZ+bipFeRd0Ed8TMvm0PRRh/5y0b9W4UuBXULRHSe8pqskh5u3Xi7uc6E7ui3h5b25th
	YY+UaQ23cbnN30D7dtEb6NsvHxTpWtHw3LUkaLKsoPfRQkJmYJX1CNpTwZOZaH348V8fvvF8U27
	CNMVWboooM933XNcrYFvTH+kfdrAS1DKSvXRD8h0ermwY61ObhvRh5eyQAalsZfgsue9jQdZNts
	7tJfagdoOfGzjfCSgW/OSSXYs5kd3Lnc3pi6wcb6a6zNHnja8LmrqiEGjP3TZ+y2DNRBDxezLS2
	bvNMck0BG3JS8ddRHM7NTr1XTUF16bZIhPdtiwuB5ebW4NUO/eQXmXZpW5KrfT3PCGg==
X-Received: by 2002:a05:600c:848c:b0:4a3:5da2:38ae with SMTP id 5b1f17b1804b1-4ac17a3628emr326325635e9.14.1793734731206;
        Tue, 03 Nov 2026 11:38:51 -0800 (PST)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a5372d8bsm87303325e9.0.2026.11.03.11.38.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 11:38:50 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev
Cc: Ackerley Tng <ackerleytng@google.com>,
	Alex Williamson <alex@shazbot.org>,
	David Woodhouse <dwmw2@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Christopherson <seanjc@google.com>,
	Will Deacon <will@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [RFC PATCH v3 07/13] KVM: guest_memfd: Support private/shared conversion of device memory
Date: Tue,  3 Nov 2026 19:38:50 +0000
Message-ID: <20261103193850.15363-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101071928.2462549-8-aneesh.kumar@kernel.org>
References: <20261101071928.2462549-8-aneesh.kumar@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> +			if (!slot)
> +				return -EINVAL;

[...]

> +			ret = kvm_arch_gmem_device_map(gi->device.kvm, slot, gpa,
> +						       (u64)(high - first) << PAGE_SHIFT,
> +						       PFN_PHYS(pfn));
> +			if (ret)
> +				return ret;

Unless I'm missing something, these returns leave the pieces already
mapped in place, while the attributes stay shared. A later conversion
to shared would then find nothing to do, and a retry of this
conversion would run into the pieces that are mapped.

Would it make sense for the error path to unmap what was mapped, e.g.
with kvm_gmem_invalidate_start() and KVM_FILTER_PRIVATE on the range?

Fred
