Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A93C26E706
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 23:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774914464; cv=none; b=RU99rEpSBpOijrRk4Jbn1gkH23oXBN5v4mws9xpqreDvEAYVUS+OPnxNRl4O0JCh8xMMDZ6fNDLW6t8yoAbFQ4kxeSAYVA4zeCrT5KnBFTGbqCFGJ/ZWr37uNKGeg2ij539qVEAAC/e6a+ol7zD0BDQZP5UJT1vuyufulX7xQl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774914464; c=relaxed/simple;
	bh=+3fwCG1qKxLOojihPmepQSc2ZE/nZklG+DGJatd29uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bf5ZjUgCPRP8stflY5fm989izwpCNEfLxEnLgse8SVKvgsR5DbD/smYZxiTgKcSGjZb+GVaLPWP6O1GPHficsuE/8pBal13BuDSwYkpf/UfXzZMMLIaUFyRlGTqL7a1njzOe1P1ui0O3VcdHpGqrgzMawMWnaB4sxSp8rgUjeeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=NcLpuMzz; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="NcLpuMzz"
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id 7GuBwVzSgc9KC7MKXwmMjq; Mon, 30 Mar 2026 23:47:37 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 7MKWwNFocgdjv7MKWwX3Iv; Mon, 30 Mar 2026 23:47:36 +0000
X-Authority-Analysis: v=2.4 cv=DrxW+H/+ c=1 sm=1 tr=0 ts=69cb0b98
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7T7KSl7uo7wA:10 a=r1p2_3pzAAAA:8
 a=pGLkceISAAAA:8 a=dDOLuRY1p3SJo1XcY-4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=r_pkcD-q9-ctt7trBg_g:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4/rBevFXE6E7bBuTDPVuFgP11XxT7qV//szAEW71+DM=; b=NcLpuMzzeyVS2f5ifqYbMzkaS8
	IYDciHUvu162hFsoueHqTLw0xmnUi1jxmYM7pa6v7hsNk71EAvkkVPEDbMT+OvkMzQYjOaL6mYdAG
	mADJB4NTwqzhLpSMZLq6Qstqh2MC6f4W99nVKqSPMmZZYaGe8RF1/n5rG2gUoTBd9rXgH8AJUycmo
	MpT5A+CvMtkYlSMQsAxVR77s7QZXx36absmZmtrrwmufU/+KeZ4ym1/Ui7XHULFKbWYZmMAmoqlq6
	4NVfp/LDeXuNOEeWtI5OuJT4L9FfuNjL+c4hdZno1nLShfxQ0XUucIO2iTB0xf1NdNC8gxKjynRYq
	iuHtPe8w==;
Received: from [177.238.16.13] (port=50212 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1w7MKV-00000002F8t-3hkJ;
	Mon, 30 Mar 2026 18:47:36 -0500
Message-ID: <37378f49-437f-438b-ad6c-d60480feb306@embeddedor.com>
Date: Mon, 30 Mar 2026 17:46:09 -0600
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: pci: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>, Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>,
 Leon Romanovsky <leon@kernel.org>
References: <20260326023747.54485-1-rosenp@gmail.com>
 <20260330161933.6471d473@shazbot.org>
 <CAKxU2N8rpaLXXsD7sUvw3ffMe8JUREGc9ru_HX0r4Uw4RT_q1g@mail.gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CAKxU2N8rpaLXXsD7sUvw3ffMe8JUREGc9ru_HX0r4Uw4RT_q1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.13
X-Source-L: No
X-Exim-ID: 1w7MKV-00000002F8t-3hkJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.16.13]:50212
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHxgqTA35+a9lTm8PB6Vdz9QRM5Cq65wBOBaYeXLy7bbJnN0U2+A3pX1AZfxd+WiirlcYDJSPLxyMLT93hVALKg4piGqNtN+yVzNs5N2V1h616O2iveN
 5y/+wjQS4SYN0NkB58Qvbm6P38ScCHHbyMlKps8/Hlmk4aS6k6BeWqmWirqeyGv0QUgucU6ttA5QDSgJDkslqZdRnZnMZp0v7Dc=



On 3/30/26 17:24, Rosen Penev wrote:
> On Mon, Mar 30, 2026 at 4:16 PM Alex Williamson <alex@shazbot.org> wrote:
>>
>> [Cc +Leon]
>>
>> On Wed, 25 Mar 2026 19:37:47 -0700
>> Rosen Penev <rosenp@gmail.com> wrote:
>>
>>> Simplify allocation by using a flexible array member and kzalloc_flex.
>>> Less memory management needed.
>>>
>>> Use __counted_by for extra runtime analysis. Move assignment to after
>>> allocation as required by __counted_by.
>>
>> I don't understand this statement, nr_ranges was previously set after
>> the allocation of phys_vec.  The only reordering was relative to
>> setting vdev, but that appears arbitrary.
> Yes that one. My understanding is __counted_by mandates immediate
> assignment after allocation. Otherwise UBSAN complains.

Not true. However, it's best practice.

The requirement is that the _counter_ must be initialized before
the first reference to the flexible-array member.

-Gustavo
