Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421753F825C
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784654307; cv=none; b=ZY+uCiRwSCgJRzFGL14NhYJyonmwZYsYJcumzpS3fHRKmT9KE1EVgCnL7APfzazPkn6veQeDIIxzpeVxNMRf4dXohSJWIH0Qg3jFCPw0ioKDcFPGKoSuToThdTZWl11dyt9h04rb09H3f2fLn+o/NoqPZbSTNOvOZ8AJOWykchY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784654307; c=relaxed/simple;
	bh=SjqvhxrsnJlMovW4pU2RS91mvs9nZ/kSb5bsQ/v8cRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ART2ZqK4fB2tzODk3/DHt83b+dY5Zp86SqgtEKAReGkBS12gDWJTnSOCeiFXwqy1g+23/6g0UB/Bs0OiE917k1P8LD+U9j/QV0quw6iyQJaprx7iYSZuhGgdnllnF2xzOXdMUa9hdscjSrBchMq/OTsbF8MKzoTPZg3X8XR+bcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TGksaEoW; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TGksaEoW"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c05dcdf49so7894911cf.0
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784654304; x=1785259104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SiPzgqRnSOFoo7wTJovboHrNHjQGCGe0NFhohlpad+8=;
        b=TGksaEoWZzWhcXSxUzzrG4O3GyIxT7k8EPWGQ8V5WdJW8N137HjooMDxcagL7sMvCd
         ROI1BixAhOHJtEP6+SJUI1iLX7eqHWL2FwHXHWluvCGSd/0NbycIqrVR6XBG8rELDXpF
         T+hXmywTOFphBPvsWt4faKozZ11xiILglhx7xc/6SEp0bKx8WTis8a1D/98goGgbfUL8
         /13HsJW82C5tuvAVGLOGzo0dWCUcBKFNRp0NEICm+hD5txPie/nmDsm69MLoCb+L46a1
         3d+jxwMiFKsEnaRxqiPdso/k1/qdTOFnSRACAcElJBdl4Mhb6sv1zyLVRvIFeriP9Gyq
         LpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784654304; x=1785259104;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SiPzgqRnSOFoo7wTJovboHrNHjQGCGe0NFhohlpad+8=;
        b=cdcSRHatPKHE2+dD6STKD0tRW9JdSJ4bNTBVSf7DgwwnJuf9GjLnHmG76D+Qshj5Mn
         b9+fj1KxCSKAdmaAQuiQH9fMLKFRcI6KZ7lnN2eJN3LcnH5mEKO/T/SYELqgZRhFK0A1
         TzEB0KElyRaiSc2bP34HEsYPIWpdoy6z1wdgOwj5vdtXfaijdjRSrJUpJhLqMBav6jPf
         naC26UwtsOIoRFBOpxqvY6pCUcxPDuI+6zwHCSpMXn+DM69pnrpwJ2AfHDzxHQ6J64t3
         C7gs1D431Moieo/0euH1ooVYk562ic5bYLrJ5D9i2U4KvsMSlRG7df2kcqdZiAiHYx/3
         rgoQ==
X-Forwarded-Encrypted: i=1; AHgh+RqiwxSB0ufJiCLuDymabbKbJPyFSndrF6tB6MxG4/lgUE4EJnLwcLEf8A1UASfCk3tNDx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDSbi6EXTYcBvm9QIywP2uGUAnBFHWAJbzanRbMJK0ynj5OhPP
	/yO2Aq4AFUJ5YjziooU0YFc1yyr4m4QMeW64KL4SeoyfEXBdtJStTEolnx0cn9YolEc=
X-Gm-Gg: AfdE7cm7jGpwNe2oY0Mb69zw8fIhTXDmbMo4VKwEW7Bpl/YVAK2uoENBmWttoiS/Sii
	FTFSKhwWll3c474LbV55V2WGM8hXFD3+hCZYq9bmH/VH3nrVti8tUzxPRCgQ0QsDiTOiVC+AnyB
	rDMZdW3wGw0IJLad5tON/ULLQAwShPm7xVQzKhWWTXM13fumgY4SQpa0kQsHs+kYhtCYd9CqXgq
	hXpxQY5ZMRy8Lzho77b5eVSBiIc8PCuSJJkmMx6juy+5Wb817ywP9+o7pB0BMO3m/TrPeiGYABH
	yQYqnUQvrMPxyZiH7mGGfAhOy8tPNwcXDoyokujrIuNPNWyghbcZLOPxcIGBp7jcNQqzBdRPjZv
	MsT0zBIjetYE9gAV9KobXihzJ69iwhbjM4878X8ZkCSgvHDGt8mtZvv6NxCuUQ2itiLXH/5SElk
	TZo3kw7vfi2bWnndSbcgYKqb8LAOlEer7RFNbhtlMY6DBqpam7UUbuhuHaUw==
X-Received: by 2002:a05:622a:5789:b0:527:7521:3f8 with SMTP id d75a77b69052e-52775210a4dmr13363251cf.44.1784654304162;
        Tue, 21 Jul 2026 10:18:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214f504892sm98076131cf.20.2026.07.21.10.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:18:23 -0700 (PDT)
Date: Tue, 21 Jul 2026 13:18:17 -0400
From: Gregory Price <gourry@gourry.net>
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: linux-mm@kvack.org, Zhigang.Luo@amd.com, arun.george@samsung.com, 
	balbirs@nvidia.com, brendan.jackman@linux.dev, apopple@nvidia.com, alucerop@amd.com, 
	matthew.brost@intel.com, akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, djbw@kernel.org, 
	vishal.l.verma@intel.com, dave.jiang@intel.com, alison.schofield@intel.com, 
	osandov@osandov.com, jannh@google.com, pfalcato@suse.de, jackmanb@google.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, pbonzini@redhat.com, osalvador@suse.de, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com, 
	linux@rasmusvillemoes.dk, longman@redhat.com, ridong.chen@linux.dev, tj@kernel.org, 
	mkoutny@suse.com, sj@kernel.org, jgg@ziepe.ca, jhubbard@nvidia.com, 
	peterx@redhat.com, baolin.wang@linux.alibaba.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, lance.yang@linux.dev, usama.arif@linux.dev, 
	xu.xin16@zte.com.cn, chengming.zhou@linux.dev, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	driver-core@lists.linux.dev, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, 
	cgroups@vger.kernel.org, damon@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v5 00/36] Private Memory NUMA Nodes
Message-ID: <al-pkvmgIxGu3LzM@gourry-fedora-PF4VCD3F>
References: <20260720193431.3841992-1-gourry@gourry.net>
 <a9c52bb6-5e04-1d41-913a-685a7be3fad4@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9c52bb6-5e04-1d41-913a-685a7be3fad4@huawei.com>

On Tue, Jul 21, 2026 at 09:26:09PM +0800, Zenghui Yu wrote:
> On 2026/7/21 3:33, Gregory Price wrote:
> >   KVM: guest_memfd: bind backing memory to a NUMA node at creation
> >   KVM: selftests: add a guest_memfd FLAG_BIND_NODE test
> 
> I can't find the last patch in my inbox or on the lore. Not sure what went
> wrong.
> 
> Thanks,
> Zenghui

Apologies, my email account got rate-limited to the number of recipients.

It should be in everyone's box shortly.

~Gregory
