Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793279032;
	b=49N//zbEQ/4mYUrEJvbBfKlTj9kfBCHMQa12ryBtAJfX2a68adSlMLD8NztK5axYl5r6
	 mXHUxHmKNbq32PcEvaLVUNwlmQsxjvfHXALc5ZArFPQZXzadCf+Tm4YD/EMaS9MlHN4IX
	 3p948h7PIQWty5Tb14yXhN49s2EdtTSc0ETtomZ1A4SPoPcmPtrDoS1oVAZnW69S65aIJ
	 VQy08d3Nz3cdBBaAoxkeTQnjVFLVpgROiMa0x2zlsNoaOOUt6gTbkf917TOp07H3rcAHu
	 Gt0Qz97TIWHErwaKqaBmeRrjyVwaZDwzzgLPlvxE/Va+k0vmp2sSBowOxLhOOda/UAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=KF90/0GARuMWHyMTMB3Xwv0e5GgnH85LGW7qmrj44J0=;
	b=BKahrG6dWSwaKYJNbFEgLOpuCf7Bsr4SYDwmxgsiYm7znjw+getKLaX/TZ1memfabCwf
	 KkpOSQkXHcgZ7pGCWWEdXm6ROwvGnYQkf72QE0cUOy7cRWbA6nhkJnfpFv4QFjF5yMiGv
	 Ff2N8qzQlu+JIqJd5qMmyy90HdDfpqbtzeGFz5XB6z9+j3fwBvSIbpQ0NnWdrvbyW/dft
	 d/g1q+mDBbtVUSBWRqbB/sz7OQxMLi1D7yZlQSzDNeQgtMFufB5pxmDJV/ga999QP0NHr
	 dxco6DxNwFWFKpRz0/OzzfYOhZFlvYpy+IzbV0irx5pItUOpbd/vRwPRfG16/Yh+zCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=C50p55VE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B34606A31C
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 13:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99B34606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=C50p55VE
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53653e30353so31942091cf.2
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 06:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793279030; cv=none;
        d=google.com; s=arc-20260327;
        b=NDCE1tY0TW/uOovvAlhYz7v9etMrH8eFPoufSjDwSSVhBG9CfEGoOstTVRxNuzeFmp
         6R4a5mc2SO3+JJTwo/gjAfnoFE7d9jbP9pqJXgm7WMJEFmxUdjli4IcMnXBnYPE76ewc
         A7A8eAnYU4zMoCPgEKOyecNSVUeX4jMYFzbAJmgxaDyLBbXB2mh0+jEqeh7YgbZ/WNnu
         Z5879VSZTKuQ/xRuYTMSAc1nHsJSNe+qN598kBKYL2DkvyDQHqn106HKkwKUE0+UPXDL
         PFKGfcS+hD5ptOHVblrKaFkyMXb/sD6sh7nRMqQSM/GIGfgLGYE8lV++RvQz1WR05N5G
         Yneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=KF90/0GARuMWHyMTMB3Xwv0e5GgnH85LGW7qmrj44J0=;
        fh=NmRcvC/tDmvZ/w2pxo/00dXW4um+TzSRC1muUMOQ3zQ=;
        b=AhR4RQs239aZvJRrMzzXuBXjWm2bYns8jk6FUbzjq0ccuGY7uVuesdDRSy5QaYT9lX
         9TwdvxgUmgUiU1/UPcbiUS9g5JRurO1RLzIBfj9J/oYxQVEFj9jN3myOqeO6rflLwoQn
         8OgXjl0dpZqgXAaPP8iXyg4We4NcoVqWLqHBP9D6uKlGwVTvBH0mFXiMibSaPQma50dJ
         4preUlcGWKZRJmtRuWiEaLuwzGuuL6m5eQHaCfAnT8GN2Q7nDUMKKV6T97R2nXMfRTMU
         tDWvJmvpeLz1wMq1jamv7gt50xcgaEJ3HI5bqQm/wmhsTzlSn8Q6K3MzWstfFtCaYhKP
         cuiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793279030; x=1793883830; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KF90/0GARuMWHyMTMB3Xwv0e5GgnH85LGW7qmrj44J0=;
        b=C50p55VE6UDgdJKjElhLNYeFnq2Z4W8Od9eebfXsNR9VAhMbuaucrBe3v34nD049Xh
         yXm9F3TtGHSCUfiyL84unodeE/D/DA4pXmQUqEyGn/jbzwUXL1qz7UhjKg7x/77SkPix
         fsjUQTeybn8SfOvtOZp7Ze23YYniYqtLT1UwOhsEzcphyyhlfKEtsn4tdZBRLgc6VGnn
         khGCfASslvGnrRTfZsJpLUafVUjMR4da5X1aPxkPViKfkQjA5KDrJs0J0Eq/vsUuWr/y
         tjS3p/M+jkqfdwuGB0zuj39WLEgzFkDffjSEsV+2WjPvf4qzkU/p2d+HMbeijeMHkNP0
         cH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793279030; x=1793883830;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KF90/0GARuMWHyMTMB3Xwv0e5GgnH85LGW7qmrj44J0=;
        b=wcVpXcmwrc/Q31eVzQhBhBpQlG2Qf9SKRFOuu9rONo4nN9y0Y3AFowbwJ9MDmsZ3p0
         SSBBPL7mK/TChlnBOOnsWOOBvS27Dita2X7AD1FcOhIpTex02371L2HxtGo0K99M76Dh
         oM3htns4goDU2cbvBQXZUhS4oq/6lWsUMxTJBYk5oScLKEEshqc3RQ7X4QBaPbbYXATL
         ZN37Yo1Y11lnH59aFIOW7K8O/DFbSJ6rSMJ6L4KJ7YIstdix87CIvq+79g7f7hn2i+3F
         pIu2gaqNpMrsx08W+lFeNiNW3f3ecd30ZWalb7ySt/Hz7kafo5vEENyyETHwqq6wj/+b
         1fcQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4hzTaXPLjK3CAe037rPiKGaZ+kKK2UKNIDVdMY2TNXve1cMJOVwLSzuzly/X+ku8tcMQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUcFBJbW0eo+cQlAb5PVdVM1xj3pdsdcXZVqBdmNxjYv0hn+jl
	vQeM3ZFSCv+17lIJuEF+OzmvxKDQ28/f7sWoP3xuf1BIB0GkcUEKoN6glMXDeTzfLFAc8B3c8xt
	1inRymOkjlOXlWNokJNlETkehDfjNc52xynHp8Py9
X-Gm-Gg: AYBFou33I9Y4nkWjjTXmFoW458qLxbwM5uLTggrzUIUiPMt/ITxgwuYDqUIz82ALXng
	NXY1K1P7y0fOyXA4+dlMUOuiUzi+49t8iBMEw0YrI79LzzXp4bJOBhjiYCzvGR1JMnH5SHzcyIb
	HCHn8YCwKCHna5ZwFdI5MoOYOYIsKF9JpJB/4+irs3KpI/Ab7/3ZLrauz5eroV8wg2IGu5efaak
	0LiFXnS/EsNtzvzfD86GyfQASz5Fz9vq0JoMV2ZDcjdn8ip0i4HagZk0CFVuiy8zqYg65p20+G2
	AIqptt9k+UuxqESBhHv8lEPR0ONUYpB9/AZVDDohiIcxEwvw/7UFYIkuDoXKx7uc+yY8hsYPl35
	BrlCnmbv+UDxOg53SNwU6JEhvhKSuha1hMtqMBB03fxcdOsI+lVA=
X-Received: by 2002:a05:622a:528f:b0:537:b9f5:e05 with SMTP id
 d75a77b69052e-53fcc7cc0camr87903901cf.69.1793279029444; Thu, 29 Oct 2026
 06:03:49 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 06:03:47 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261027154649.91571-14-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com> <20261027154649.91571-14-griffoul@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 29 Oct 2026 06:03:47 -0700
X-Gm-Features: AclHuK_J4_B8WHMj3lc3Bqk_zMBRzyMWVypxyBk9aFiFYwwISWnD_-KRrJmOcto
Message-ID: <CAEvNRgFYecSKycFLkxwyK7gWZqKTXTPJVetSZm8YBbo0kg9tTA@mail.gmail.com>
Subject: Re: [RFC PATCH 13/14] samples/kvm: Back absent pages on demand in the
 sample provider
To: Fred Griffoul <griffoul@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Alexander Graf <graf@amazon.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Alexey Kardashevskiy <aik@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, 
	Ashish Kalra <ashish.kalra@amd.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Baolu Lu <baolu.lu@linux.intel.com>, Bill Wendling <morbo@google.com>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Connor Williamson <connordw@amazon.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Hildenbrand <david@kernel.org>, 
	David Rientjes <rientjes@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Erdem Aktas <erdemaktas@google.com>, Frank van der Linden <fvdl@google.com>, 
	Gregory Price <gourry@gourry.net>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	James Houghton <jthoughton@google.com>, Jan Kara <jack@suse.cz>, Jianxiong Gao <jxgao@google.com>, 
	Joerg Roedel <joro@8bytes.org>, Joey Gouly <joey.gouly@arm.com>, 
	John Starks <John.Starks@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	Justin Stitt <justinstitt@google.com>, Lorenzo Stoakes <ljs@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Michael Roth <michael.roth@amd.com>, Mike Rapoport <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Oliver Upton <oupton@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <shuah@kernel.org>, Steffen Eiden <seiden@linux.ibm.com>, 
	Steven Price <steven.price@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Tarun Sahu <tarunsahu@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Tycho Andersen <tycho@kernel.org>, 
	Vishal Annapurve <vannapurve@google.com>, Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
	Xu Yilun <yilun.xu@linux.intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, x86@kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Fuad Tabba <fuad.tabba@linux.dev>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, llvm@lists.linux.dev, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fred Griffoul <griffoul@gmail.com> writes:

> From: Fred Griffoul <fgriffo@amazon.co.uk>
>
> The sample provider fails get_pfn() for an absent page and keeps its
> frames on a punch hole, so tests cannot exercise a provider that backs
> a hole when it is asked for a frame, one that backs more than the page
> asked for, or one that frees the frames that a punch hole gives back.
>
> Add MPS_NEW_FILE_FILL: get_pfn() then backs an absent page with the
> whole 2 MiB block around it, and put_pfn_range() makes the pages absent
> again.
>

Can what MPS_NEW_FILE_FILL is meant to illustrate be illustrated with
the ioctl that sets memory present?

> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
>
> [...snip...]
>
