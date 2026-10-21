Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792626411;
	b=myaFQAeNjXSWu3c2K+5eSU9c6HUqFXOJ3JxBeyK8qtsq20YDf/pHXuzW6piVKx0wcuP/
	 y8rcXQ9FSVxVoDJ5+4EBSy/kkXQJV/aPiqV1/28Xbxe42JItRbD6fm+DsyevEV+YIV9iA
	 2NIVhzmbAwouJfZEK1mblu6DzVU7ds+4iMtNUP/S2NMcUV5xreMd0TUU8eF2iFUVpj9hV
	 hLa5mujZu0DQuz4FTk2FKy+Zl/gySx4HlTiQ8NKrmwqkJ6WCPZCkzY1UWS2mNkqLFVBbr
	 RCiklre6AjAlj4ae9wnkaujdEYhGNt99E1B2W3yc01o882DE6PrYIf4q118nMSjzvEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792626411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=n5hOymfjgaz7xpjT1ssIdHSQ+wD4cuNPKUAfRnejzdg=;
	b=rbqt/taJ1mQapgqKijgQytXMkz0KZkkl9D/ehDZZ7QDo5CktUaBXIeBLQJC3y2k8jYml
	 tSemsv35m6pW77EH+E/ODRqaEHrUw2bYJfq7HSu7JaheXLucI48w8g0Vwy7a3EMqc29ww
	 XZrZHukAo+mHNTt6XBcLN5vff5ThGH0PlIPq7/16aGMwrHzO4qlHkljI7MXBZuaEYj4La
	 9OpgxCEc/1h8A2n4+tIRslQwBcXTNEH1Ia78OO5GswL+y7/klExKWdBdP6ZofCF/TchX7
	 gec6b2Y6wrond8Y1i92SFEjRw/XWdFUmM4Mwk82QenFqb91Ispb0tiBedzj93tL1N6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8451A606A31F
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 23:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8451A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f1cf92c9eso127759085a.0
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 16:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792626409; x=1793231209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n5hOymfjgaz7xpjT1ssIdHSQ+wD4cuNPKUAfRnejzdg=;
        b=RWEqARLNhr7kM3UoylUxt0c18uD7BW+nnkV6qlrI9YT9zsHGYUDmS0p2u/OOJbEXRO
         SgtdrfJPP8qwXew2mkzTL5kBpez8YAljokMt8HUv0ST5gnPGdO65tJGybD3uqk3DHnFQ
         VEfyFNtRpndd2xu3NGiNoG2k4NxrYb1vsCefZIqb45l7I9z62Aci6eddaiDR77WnIZoy
         eWMUHuI+2+oIZ9KbTn2PavphoEY3W05B528MicbkGhBUCoiwiAwUvz+JZs0AWZblHyFz
         J4NMmzr4UzXCJ11N9e51QR5awZqclvbU5xHpjVK9003y/gTpC40ys8/YEtw5gSAxngqs
         Ulog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792626409; x=1793231209;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n5hOymfjgaz7xpjT1ssIdHSQ+wD4cuNPKUAfRnejzdg=;
        b=SFgCFIUjfGdhVCoOEIIxFDbrV2mPmD5PNV0GZrstoWzs3YAKci5Nk8ZpySKVnMJuiT
         2tA75meUY5vXfNXMtifIyGQoymM6KqZoJNxyvXdcSiJQxGlRcxz0+xlFItZF+aIFUNFM
         EzWaPDBVzJm2XV8iALel2F+cKYrvjoyvaPLFuhM5TlTnADCJjNXA1KQgTiJ06WrDcU/p
         G3RczarUIoouF+THk1558JXF46duulOg7G52ApPV7QbGnzAg2X1Mz99z66a5/sghAkvk
         zLUi355XTdw3skCwNnqwkwWxM0fXvzzo6SyZYSMH81qObnCgLTP+Uz1WmFv0RBgCKN37
         zx4A==
X-Forwarded-Encrypted: i=1; AKwUvBy00r0AGnCF4LTpUKHTwolwhs6LZ7td7d2HhADkelpoMfpR69h9GIs6o/551Kv0n3al+e8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvNhGsTAbeH03Dy8nSJfLoVOXRMJXBeI5UjbEqC7esTeZ9OkwM
	srI3CYt4adqERuAaJGqEe2VhRlKStbwwDgNu5IGqmJfyerYlCnFLncBvR+fUd5/QPVc=
X-Gm-Gg: AYBFou26w4gZhT46tanoGSH/KEYpvwShgEneEIXfl5sdNMiC+x0u6cDWByQBTYg1Pa8
	aEBMWi0eY3gnChNNb86arURBFDEWP+Mun7GF3n7gxkN0l+MWzYSfWq6iHPx+FjurDLDCN8BCuw0
	cL46KFu8Vo4/iLhC5fcEI3xKTLoE3iX/EdWdAb5Yx4zKUgiYIfr00FN2R12zEQp0Nia3Y8brtWK
	mxd05qE1xHlN6vfA+xjKh4g8LmHE7KvNOTYkaG6YP5tpYZTKioVifltnsGoFHduC0Y8YXiNQ4ou
	O0u1PphaYS/NHNk1QlPDq78yz/dE3/R38zl2AVnglPmRziJ9MmReDsRS+LrguKn9zLQG8xonBpg
	hd/Q/GhMlXL2y/GetAw49I1/B5Y/yo1LvFCBhVtbvES91kaLChTKJAOK653/flCuUF6GUO4vhnf
	HETHQzyOTIfdmfTnxBW2LtFBhsar3+55dikz8zWAyC9HCLYVp3MjRH010NxFI8NbZJtlFsQhp7J
	nQsSfVj/iFeZLjG+lHWrophXzp5WahWewSGLvvHd7IFSkV70OUqxeqhhQcCmMjZqm5rajpJP0h9
	HXn4F7xLwc49AnyoJzIRgz76PU69QycvgQ8liTxTFZDHBN7fy9Ly/NhNvbQ=
X-Received: by 2002:a05:620a:17a1:b0:93f:22f1:97be with SMTP id af79cd13be357-93f5800e406mr694136885a.72.1792626409239;
        Wed, 21 Oct 2026 16:46:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e2bee2sm373858385a.42.2026.10.21.16.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:46:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xJg19-0000000EWG8-3cjA;
	Wed, 21 Oct 2026 20:46:47 -0300
Date: Wed, 21 Oct 2026 20:46:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Fred Griffoul <griffoul@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2 06/11] iommufd: Map memory provider files
Message-ID: <20261021234647.GA3381610@ziepe.ca>
References: <20261014093733.90312-1-griffoul@gmail.com>
 <20261014093733.90312-7-griffoul@gmail.com>
 <atkO08eCJzLX6R58@google.com>
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
In-Reply-To: <atkO08eCJzLX6R58@google.com>

On Wed, Oct 21, 2026 at 08:17:05PM +0000, Samiullah Khawaja wrote:

> With this approach, silently skipping holes during IOAS_MAP_FILE means
> iommufd has no tracking of which IOVA ranges in the area are actually
> mapped, which complicates unmap and could also hide a bug if a hole in
> the range was not expected?

I think if we are going to do this it should only work with iommupt
and iommupt should provide an unmap that is compatible with the holes.

There are other places that would like such an operation, IIRC.

This will have to block an access reaching into a guest memfd mapping
as well, so that should be OK.

Jason
