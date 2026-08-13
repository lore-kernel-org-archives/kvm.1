Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F44442FC9
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611327; cv=pass; b=HnSHP1E5p6ES0gpJ3/lpmaB/brW4udbHXONyvUy9LG6yNaBTm+Kfzv7UH/z74J5oVn/rcWCri1wiwuBAM9wTYVkbr6HRFoT/4PLHQxBQt6BwQP9V42JxrNe2IN3kpTv30tOtXrKrActJqHH/HgTc93FxVTUuoo6Pnee0QI0omS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611327; c=relaxed/simple;
	bh=Jzc8k1yrWfBTMmPd/uTV9o0ew6ZOvHlbY2BVlHKCDmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgFGSQQepINFJld7384NJQ76jMHPBgu/97Az13bme7w5wTReIPc80ofwrv26Hxt1+zYuA3DJSszJpIClUZfkNmK5jlSBvaqrQNrHlK0p9kwZCxNRuH2pojd2aeGoDkJMMT5Ulc23aD9R3RhXogQbbcwAoX3M7vnD2rMv4uhesps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbbGxqob; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbbGxqob"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so424201a12.2
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 01:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786611325; cv=none;
        d=google.com; s=arc-20260327;
        b=sFP6LTnYhSw4m1LlIRSQVYyxqIksR5MiCmdUw1Tuw6af/Od3ffn3jUnRvP+OK9QRI3
         t6ZXCXGSUU8CExibYKQ+/p9rdCzRrvZM382RUxasH1sJdM1Zl1aIMbPac8KY/+JI57h+
         o0VPjKUMCQWph8aPEIKCKiPt3IULJQ+Lt0z0cOf1eK/763r6yL5J2uFG9Iw19d4Czx24
         VPcaEbxBm8Arvl1L2ZWXc3bJc38AHkpMyM7GWOIuWJ1w9vt2RGg3ceZ5Dis2oXZIWvkV
         JoiJ/SvRP5bQwThS0xVGjbXYYYoEM9yhL8VO7M6jK38I8XkUW0NKE+yoeJb+Z0z4gfgN
         9hXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iQkBGHUJCah+5IraL6W1VGnCKmw1qeB0IxjLs3arhcU=;
        fh=s/B4Z7qCvEV8Ak/7YU5c2FJW1T+b8hU8aGJ9XCJrUqM=;
        b=ra3XaZBtiLmsZCOH7OQceqqtyp0LbelqUG+VIApjSVnat1xKQ2JWzS7g15vt3OeFHv
         mJ7yAbyOWRGtXAUzGKBafsMvYl0JLdYhl7a1MjE7dKuDWV6iNA//6L0pTNUDdpbgNR4A
         lrh9wRBU4bYjVOwSmgSG5ZOvkThAaowHGUOX2QMAlDtAqd1Z2nCmOc8qAUsWteloc7L3
         sl1jmMmS+DZN3Si1fm1m2gAqRtHT5A6ltHXmQ0hhtoW7+sQW0VbdhJ9uyH+t8VouPE2Y
         JLnC6VtgXGQZZ7jAdeIe5radKoFNQVOY8demQaWaKVDJCoVnhnfk+hDuL608X2fQ48VO
         R/iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786611325; x=1787216125; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iQkBGHUJCah+5IraL6W1VGnCKmw1qeB0IxjLs3arhcU=;
        b=HbbGxqobFGq6jQ6lr3AJYabpK7r73QkMm2744ocBEgZnA+6LW1VXrJFvpPuRvh7/I6
         TkJKTnNGFbwPfPQkY7vkUNbj4DBRuQjSPrawZdDMGbvp3sfiPH5dD18PB77MjXzZA/qY
         XPo7ahdVsKJJYMaLNASbJYMiZtJ3FafVpzNeEnE/PnWlf476KRrykV3FhC0tMDv4WnNk
         m0y7kATTGB+afK+bUQQPp4AkzCAB81Xl36TrhqC9hE1NujciAOnmDwqF8d/3lvCK9nW1
         K5Dw1FSSyXL13cknl9NsxPbL3l/9WzZv36eVpZthyccF8dHS7UWpyPrQ/uxlaDZPpdzk
         1zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786611325; x=1787216125;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iQkBGHUJCah+5IraL6W1VGnCKmw1qeB0IxjLs3arhcU=;
        b=CQIy5FlDzKsbB7+/rLJVCGf/b1sk2kSRQx0YGGu2zM7fO431O4hHSpRJI+BDVmNucl
         KYjiiHzqnnJiZVeE6V0lRhSZ3JxCPA4D2GrycVLeRt8fJgOXoQELh78kIsgvLmXA3M9K
         r5TWUoSrfqp7+VAunCAUzKZzgjk/F8VkeO+cb6ZwMPn1zu09PJlw1j76YhmZYnRxE7+M
         at5VJ14WGxzJhzIiO9uVmj7gzQTFQmScjnv0xQouqYFXkOKSaSot/yJJwYSC/c3N9GZz
         3XhdkRLT9MimAnzsDJtavnnsGbQJiBcnkjNcQ1nE9oLeG+H5kZYiYJBqAvv7VXMVWc9/
         lTyQ==
X-Forwarded-Encrypted: i=1; AHgh+RrUdyPJ63Avkf5CsDIRmASIAtWi0DAWQCtd5eZ/sDdIX+MkJWxynquyNOyOPzWDb6WQGkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY7MVTO14ysfTEgsDEWckAyOPd8YWGcMD6z1U93FkAHWQ/rp43
	kTzzfWOsVCrmVNRM7Z1KGm78N5W0riI/RjVsxPbZQ1cd3ATjrnqVVFHGU1E6aJAqSIdjY2yKlPc
	DLlq5xFcfo0WaMEUh9ws623ZQM3boTAA=
X-Gm-Gg: AR+sD1144ZktBHmeVz2v7RAn/FyJoWVefN3MAzEFikJRmeQaDybpuVRPbibO8/zU9Eg
	tMPTeQVqkI5LrjiE8qU1CuWmKo/pDCghmkE1oHuiNGGGqkaa/6NJXlW4dnTQTCrvYXqAVPaRENU
	CWRoq8ywd1moA03oSSgZVuZGV2ooy1jc+L7i0gAtaphsir6FEvUqNF/VwVDIYtWKpYP7EYeE1Al
	lM/SuaZ4EsgXRUSdSy7GD2JTlcdqUj9bHodE0fMtsuSTmUq68lKPazvzGhQjS4ruXH7XAweOMG8
	XRlIBUerlW5lGSArg9vPCgGZKZwWv8uQ5NQVNh8GzXgobhc=
X-Received: by 2002:a05:6a21:150b:b0:3bf:8604:9a3c with SMTP id
 adf61e73a8af0-3cc553f513emr5787899637.28.1786611324791; Thu, 13 Aug 2026
 01:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720193431.3841992-1-gourry@gourry.net> <CAM9Jb+jpJ-Ui4qDHxsp2WiERiv8gmrQfKQ8Z0BmabefeQ6pg4A@mail.gmail.com>
 <an0cAMh_m8ZhGIm2@fedora>
In-Reply-To: <an0cAMh_m8ZhGIm2@fedora>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Thu, 13 Aug 2026 10:55:13 +0200
X-Gm-Features: AUfX_mx5aRT_GeBsew982Oll4m1v2zeTSERp4DtDb2YI-VK1slYjLWUFWPkF2ZE
Message-ID: <CAM9Jb+jmxPdL-CdWQHYMT5G=qmjB6z2WFg+4K8Fod5n=2N6YCQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/36] Private Memory NUMA Nodes
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, Zhigang.Luo@amd.com, arun.george@samsung.com, 
	balbirs@nvidia.com, brendan.jackman@linux.dev, yuzenghui@huawei.com, 
	apopple@nvidia.com, alucerop@amd.com, matthew.brost@intel.com, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	djbw@kernel.org, "Gupta, Pankaj" <pankaj.gupta@amd.com>, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, osandov@osandov.com, 
	jannh@google.com, pfalcato@suse.de, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, pbonzini@redhat.com, osalvador@suse.de, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	ying.huang@linux.alibaba.com, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com, 
	linux@rasmusvillemoes.dk, longman@redhat.com, ridong.chen@linux.dev, 
	tj@kernel.org, mkoutny@suse.com, sj@kernel.org, jgg@ziepe.ca, 
	jhubbard@nvidia.com, peterx@redhat.com, baolin.wang@linux.alibaba.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	lance.yang@linux.dev, usama.arif@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	driver-core@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-debuggers@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

> > > Bonus Configuration: HBM device memory tiering
> > > ==============================================
> > > echo 1 > dax0.0/private       # make the node private
> > > echo 0 > dax0.0/adistance     # highest tier
> > > echo 1 > dax0.0/reclaim       # reclaim active
> > > echo 1 > dax0.0/demotion      # may demote from the node
> > > echo 1 > dax0.0/user_numa     # mbind()
> > > echo online_movable > dax0.0/state
> > > echo 1 > numa/demotion_enabled
> >
> > I am bit confused by the HBM device example being discovered as a DAX
> > device. Is it to
> > only to showcase the use-case? Or we see HBM device is actually
> > expected to be discovered as
> > DAX device with N_MEMORY_PRIVATE?
> >
>
> "actually expected to be" -> no.  there's no requirement HBM be
> discovered and boudn to DAX, DAX is simply a convenient intermediary
> to memory-hotplug.  This is at best a demonstration.
>
> A device driver could very well just call memory-hotplug directly,
> or its memory could be brought up as a private node via a boot
> paremeter (which I have sculpted for v7).  The former is preferred,
> but there's a bit of a chicken/egg scenario for bootstrapping.

I find this interesting as this appears to be evolving towards a vendor
agnostic framework for hotplugging memory directly to private nodes.

How you see this working? In particular, How would the kernel know which
memory ranges correspond to HBM or other device memory?

Please also CC me when you post v7: pankaj.gupta@amd.com

Thanks,
Pankaj
>
> Most of these UAPI extensions are going to be consolidated into a
> debugfs interface for testing purposes only in v7.  I've been working
> on aggressive Linux Test Project test expansion to ensure there is no
> UAPI regressions.
>
> ~Gregory
