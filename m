Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6576B46EF73
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714041; cv=none; b=n92p8WeGYDPqMki31Gb8jFjkIbNFzxoBslu3iQsvapZaLySDuvQ2fYyiRHRUUzbTE0MBZ01fOK95EKo/RqFLkcPOuqfc2elFxXRcbeSJIIUxDOWv/3re7WIzOWQWiafR1ftNaTC/K09zQt/Od74IumZlsN9LHY5VAvaUcN+tQko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714041; c=relaxed/simple;
	bh=CChEzwWKHqvAbDe82pqB+EpRVBOCxUp7FVLoHlKhGNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NADRigT+W+M3LHH8DGBhtfNoEpujtdOdAp7sXRX8QwT67RNOWP30yOQTilZTzDQTAbinc9X6ltiienfR157uDWwiB1dZLLZ9p70IaHmiQLC5TCFan+88Z80yEoDlKg3VHcZfJr7TZzsauqBiy4P5gPm7/h5cuGFBHe+zozPsA7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TCpeiH/x; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TCpeiH/x"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66c71239c48so1366220d50.2
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1786714037; x=1787318837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n4ArN/eG59F6/a+Z1l3n9inh5iDgTQHyg71JvETU2wM=;
        b=TCpeiH/xCWeDcYJotQrUKR+96UF0MG/Njhh1rbUlHRGBrpdQAImKs6oRWI41Q8Eczj
         +mTDkleatlsNeXhOUaGWaFyd3U50OBJvlvu77XCYcYzSq7ARn4Or8iIhiP8w6JBZAK8W
         oAd1trrpj6Ef0CklV1H2zSfBzIviHXmk2sB71HcaujcqJrFDI2zHP23dmMR4YDojp+3v
         GBSdAv+vPbaIHQHbjNZQzTtWNO8h2nh2HWBKxy6PVDPoHfw/brhOp2p2xqx48wXcX9eT
         697sKEtDAhvD4AyqB7mtbV3UuRSbV7yerIPuq30uagL3Wo2jyOy2OULMcp8X/mprik3I
         2+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714037; x=1787318837;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n4ArN/eG59F6/a+Z1l3n9inh5iDgTQHyg71JvETU2wM=;
        b=ex6xedLm17ykkq9McZiCBn3qwNClptrElRLE0ghxF3PeX2QWh1+AQhxmxD81lUsvca
         vaq4o9N3SRWSFEHVMBgEif4B+5EwC8g+smQ6mgZQ6wHnZIY4vwHY0IbOrd2KjfsVUaxN
         bp98v7JZeMJfArGYLQ3b6lJ6mRasnOY7G3vw2ExTPz2/OkJwhIHkqGVI8WUF9sVX3K5c
         O/2HNGIiyANN+XKNF8K2mYVvZyOwsehL6rkpg9Z4bwGsTneJuXjbL5SwssIY7DfQE8BV
         0Bz+dn7/91BaXoZDI8br1KBm3erpNFYr3BtXCIUAYaoVEP0IbRsuUYxVx7bnkRSoBwd0
         Xv6A==
X-Forwarded-Encrypted: i=1; AHgh+RrNnxlrDWX0+qF26eUoXPd40+YDzMcvZODYScrklWGzUsJZxWY/+qynYmVU8bpiuBIP3Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq274cOLwFfG2Q2m0LiFT9QKuPQD2+Lgy4sA+a0KcMM8EoBpbR
	mpTVifod3LtQTY9yNu7Sg/YuIl4GsbYQB2UqDEWNu/8zs7nHolIl/YyymhnwhHt9Ajs=
X-Gm-Gg: AR+sD11VaXWSIgVB+VGGzbSfUOdwgiReYLYTLfTlRwQ6qs3Uict8BDRNSNfpEJ3Jaho
	FBq3o3QlU2W3AD2Tqs3SpHWSYR/4O8Pl4fatRfhCc5ZHrI1W9na2WS7SvoPMVtvhbOWhEsHgHYO
	8RNJZDGZgEaIJoKu0zcr+jeeKnZWUXDnstUGqfe98TIzkkDCVE7oXJU5bqYPxSz2jI0DKFd3m/d
	DJAR9AQV/fp5OzPSXZA2zpG9uSf6cRmZ4Uke/6VAWrYJPGhz7SY/x+cCJBfiQzzNqFhq0BzSgHt
	vWFRuMg6rytVXkSNhKiNVVD9dzbMj7TpBwsmUdzFA0WL+8obOl1ZJtiZIGdX7NY4JAaYEdyXkmO
	rG9gMJffJyiNoVNatu2BU2eGfAcwR1UeZlFHHaaM5qI/U8DQd3p/Ep35raRJOCKzZSwcTZ4lQrj
	AckKKVLp4BuvRYu0KomGlHEA2eFbxDRNHaZGY=
X-Received: by 2002:a53:c584:0:b0:66a:3662:409f with SMTP id 956f58d0204a3-66c72ba0d10mr1917799d50.10.1786714036424;
        Fri, 14 Aug 2026 06:27:16 -0700 (PDT)
Received: from fedora ([2601:19e:8500:d3c0::28fe])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c75c9d90bsm1010793d50.8.2026.08.14.06.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:27:15 -0700 (PDT)
Date: Fri, 14 Aug 2026 09:27:09 -0400
From: Gregory Price <gourry@gourry.net>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: linux-mm@kvack.org, Zhigang.Luo@amd.com, arun.george@samsung.com,
	balbirs@nvidia.com, brendan.jackman@linux.dev, yuzenghui@huawei.com,
	apopple@nvidia.com, alucerop@amd.com, matthew.brost@intel.com,
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, corbet@lwn.net,
	skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, djbw@kernel.org,
	"Gupta, Pankaj" <pankaj.gupta@amd.com>, vishal.l.verma@intel.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	osandov@osandov.com, jannh@google.com, pfalcato@suse.de,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	pbonzini@redhat.com, osalvador@suse.de, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
	kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev,
	baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	longman@redhat.com, ridong.chen@linux.dev, tj@kernel.org,
	mkoutny@suse.com, sj@kernel.org, jgg@ziepe.ca, jhubbard@nvidia.com,
	peterx@redhat.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, lance.yang@linux.dev,
	usama.arif@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-debuggers@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
	cgroups@vger.kernel.org, damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v5 00/36] Private Memory NUMA Nodes
Message-ID: <an8Xrb5Phmvs0xE4@fedora>
References: <20260720193431.3841992-1-gourry@gourry.net>
 <CAM9Jb+jpJ-Ui4qDHxsp2WiERiv8gmrQfKQ8Z0BmabefeQ6pg4A@mail.gmail.com>
 <an0cAMh_m8ZhGIm2@fedora>
 <CAM9Jb+jmxPdL-CdWQHYMT5G=qmjB6z2WFg+4K8Fod5n=2N6YCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9Jb+jmxPdL-CdWQHYMT5G=qmjB6z2WFg+4K8Fod5n=2N6YCQ@mail.gmail.com>

On Thu, Aug 13, 2026 at 10:55:13AM +0200, Pankaj Gupta wrote:
> >
> > A device driver could very well just call memory-hotplug directly,
> > or its memory could be brought up as a private node via a boot
> > paremeter (which I have sculpted for v7).  The former is preferred,
> > but there's a bit of a chicken/egg scenario for bootstrapping.
> 
> I find this interesting as this appears to be evolving towards a vendor
> agnostic framework for hotplugging memory directly to private nodes.
> 

Agnostic would depend on a common standard for such devices.  Otherwise,
there is still a need for per-device drivers - but hopefully the
interaction itself can be generalized.

> How you see this working? In particular, How would the kernel know which
> memory ranges correspond to HBM or other device memory?
> 

Device marks the region reserved at boot, driver hotplugs.

or

Device marks the region normal, but boot param sets the node private.

> Please also CC me when you post v7: pankaj.gupta@amd.com
>

Sure

~Gregory
