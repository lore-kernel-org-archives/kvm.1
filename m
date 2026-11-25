Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567195;
	b=ZLbkIw7F1x0FckMyY7eCtZtEWryGXFq43w78H1+2VLZXzo9XnuICKFWOuHQPCY55npWq
	 bfn1pZRqAHrMPSibRMLeASblpnkC4K2g4C5rbiewwGjKsa7GOvv27kMaMEWals229HZFo
	 VQN/foK49kQRbTmGUuCDGojCesOaKjxYH/NgZKlFP+1AL5UHl0Yzp35QYJ7Ak8ZnLu4uV
	 O4fkmKRO1Vz8FDpAHy4LiGUx91GnFRijcoMcDwNiJffrVQQvmTSPzAP09XoazheW2tFiw
	 uYICsQY7q0pSK9H2MjRRvIkA+TEhcaBAM+i6e0aA+Xx8/HROFbWxWSozp2DJF1cNSdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
	bh=YKxHcqUXjQp/1J5J8B8/Kkrmh8UptW8ucEK7buHNuos=;
	b=HYpA1hdn/zB8w0XFdNaIXewv/GKCUFLqGgG+fx7UyPyW9Qc/uRZILrO0gijJ4t+MBh2L
	 i8vX7OWAQs0QaQaPtMTW6B1vl27jcYL1LIQITRt6171cvnFGWmwm9OO25IGRP0ADfXsx6
	 N1hGg19yJGQYaZlqBdeJo/pQePFcpv4EhvYnaw9ABBpMvl2PrhkLdiTGRIdzkGPjJeFiO
	 RBAP4AC8n9Bhf8+o2YhwZjXxYQgauepVt/xlyU0tQtna1gVsxSgMAhfAmhsL3jEwkUbc1
	 sdBUPPyQ+sTAnabCW6E7/V19AdJQHgy23OnIOj8kqexSF2JXgqL2X7/gS75EmL2ZFZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iU0dIwTv;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C457606A329
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 00:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C457606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iU0dIwTv
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2f052ae3c86so27744655ad.1
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 16:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567194; x=1796171994; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YKxHcqUXjQp/1J5J8B8/Kkrmh8UptW8ucEK7buHNuos=;
        b=iU0dIwTvZSJ3oZDT4s2CYWT8eyLf6vImduktWp4JC7yaK0FWQ2FlJA+deyc742kbWF
         QVwexeYViuIyKn++vmTxSfx/1MkWT+BOkKb3tF+tY959jNCyiwk8qs55tnTEDfhJ0M2T
         mvnq7CHLh2b3871yyE6nyAJzzjpQccc6OxjVrFjxtVafR4t2HxJzOoXkgYgYzH0J7Unq
         lggF1KAHJ2om0xtla7kj5dkZHHx6ItR9cpmK9okF7uEZxkN/GaJ4MOCIFXX0rIQtRv/H
         NeyLLGLYEUpwQs+E+lM1o8DK94HnoIZUoNjbfz6QB/NYepP1Pt/oTy6DP3ErzH5Cpi0B
         qK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567194; x=1796171994;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YKxHcqUXjQp/1J5J8B8/Kkrmh8UptW8ucEK7buHNuos=;
        b=yhefoh5ELEOqRy5fCGuDw6sa6p01A5yUbsisqlKai7snxgs/4m2Hf3kYAnNmKSKsTa
         gO7azGYyKuoc0rfLMJVQhBw6wxbs05c87BTraoNgOe0a4rkBv16Piwaxq71R1sJJNoKC
         VKBASAi7gFJM+olC9U58Wai1P0GiThBnV87aAoVtC3SKuXNKPUcCpiRmE4pR8ApD7Exe
         ij2n0VNrhqhdDmbzgj4RNJPRlB21nYQxJP2KqiWDSpnx5aKiJNspLmz6JU2V8ZDo0KKO
         yWM+Tpt9GeAyzPxxeKm2R1Rq7mvI1V+iubHrzvSfIliWzSD8IzycDUsxpmSxkHhbAl9h
         DzzA==
X-Forwarded-Encrypted: i=1; AL+hErFsKs0E1r5la+WJAx+f0pUm0pAHQFbWb3m4ze76Mam6A5mfS9VjPkjULIsIc4Yjaz36B5I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FHpDWOPTh9Wc7GHz6athP5asQx1w8512LJGaGzbQ69UD1PPLR
	b4ZUBgoEwcskn31acg61u9DVUpjtRfFRcA+G6kE3BYXg22OG9X66QN22grVAhQrMcg==
X-Gm-Gg: AZFdTZc3peC9GNrNiVZ597F6UeSogELvK6648TjqlzTxLDDSJREX+VhujnA11amB31A
	lkak9WxpWZFc5eXAXQdXha0Z5fMX4yI0ScoronrRlkwOSwoSGMg7aNkuXx7qneldVg2okI2oFAl
	DgiYULYguDXvJYR37Cg5pmX4O+HIl541839XfnJt98HNjnRxNimDAnIcyVD7jmRKdO8JIXNX+a+
	UtFIbwpkmTOyiuAzyJTnAAL55pC16SQwrH4g/INUIVkcgZPKW/pKM5GEbC5swlgDTVH4qCbL3WN
	9W+FGWafCkbgmwn88dNgMsAfrsfyyGNdVmqAWJhRP2ViKw4d41vtcyyvr7naLVGxIUcnvTIxc3z
	wzaj1qHqn28zxmfqT3wb/A1ykYxaAa9cZpQhRs7EIEk9+WAinJt6ePwRHbsecdUo4ahJnZyVsSl
	kE8yBe6SO16+BG3aXp0Fi2+cOdTM2vs/QMu1zdLQrp/ySsvojUWhNX3YH1N2JYs5zUFmTRcMnii
	Kx6hEmu2KV2CRW8pPTSiIK9jqW6WCJT38hKnDcqFAmxxXYpmPFPBYsAGAJEkR1Ua1wYK4qEveX+
	TbK+WQlCqEWd4wItHT5PkNitxyZ9ndAK2tqixHsHYh296ydUW6CK6IuuJIAh1Kd9
X-Received: by 2002:a17:902:eccf:b0:2f0:25ea:8fa8 with SMTP id d9443c01a7336-2f03f176abamr169618335ad.19.1795567193320;
        Tue, 24 Nov 2026 16:39:53 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee848c1sm75603595ad.10.2026.11.24.16.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 16:39:52 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 16:39:52 -0800
Message-Id: <DN3VG4JCILOO.YN40XHHSWRPH@google.com>
Subject: Re: [PATCH v4 03/19] kho, memfd_luo: Reference struct kho_vmalloc
 via serialized pointer
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "Tarun Sahu"
 <tarunsahu@google.com>
Cc: "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike Rapoport"
 <rppt@kernel.org>, <robin.murphy@arm.com>, <maz@kernel.org>,
 <will@kernel.org>, "David Matlack" <dmatlack@google.com>, "Alexander Graf"
 <graf@amazon.com>, <seanjc@google.com>, <jgg@nvidia.com>,
 <loganodell@google.com>, <arnd@arndb.de>, <dwmw2@infradead.org>,
 <baolu.lu@linux.intel.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 <oupton@kernel.org>, <alex@shazbot.org>, <gle.com@google.com>,
 <pbonzini@redhat.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 <kevin.tian@intel.com>, <joro@8bytes.org>, <kvmarm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <kexec@lists.infradead.org>,
 <kvm@vger.kernel.org>, <iommu@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <skhawaja@google.com>,
 <sagis@google.com>, <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-4-tarunsahu@google.com>
 <2vxz4idb1i2w.fsf@kernel.org>
In-Reply-To: <2vxz4idb1i2w.fsf@kernel.org>

On Fri Nov 20, 2026 at 10:19 AM PST, Pratyush Yadav wrote:
[...]

>> +static size_t memfd_luo_ser_size(void)
>> +{
>> +	return sizeof(struct memfd_luo_ser) + sizeof(struct kho_vmalloc);
>> +}
>> +
>> +static struct memfd_luo_ser *memfd_luo_ser_init(void *mem)
>> +{
>> +	struct kho_vmalloc *kho_vmalloc =3D mem + sizeof(struct memfd_luo_ser)=
;
>> +	struct memfd_luo_ser *ser =3D mem;
>> +
>> +	KHOSER_STORE_PTR(ser->folios, kho_vmalloc);
>> +	return ser;
>> +}
>> +
>
> Hmm, I am not a huge fan of this. This makes doing such allocations
> quite annoying, and I reckon we will be seeing a fair bit of them in
> many places.
>
> The key observation here is that most file handlers need to allocate a
> bunch of preserved memory, but they usually can free it all at once. So
> we can get away with a very simple allocator that hands out memory
> linearly.
>
> I have sketched out some code for this, take a look at the patch below.
> Note that it is only compile tested.
>
> Perhaps give it a try and see if it does the job better.

I agree the manual packing in memfd_luo_ser_init() isn't great, but I'm
not sure we need an arena. This seems like something KHO slab support
will solve properly, and since kho_alloc_preserve() already takes a
size, KHO slab can be dropped in underneath it later without changing
any callers.

Until then, maybe we should just allocate struct kho_vmalloc separately
with kho_alloc_preserve() and accept wasting a folio per object. For
memfd that's one extra page per preserved file.
