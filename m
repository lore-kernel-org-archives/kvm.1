Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830295;
	b=gYUsehM4LFZ/enqVWBDDJlltxBPdt/5/0s8/+lfxuiyaNRg1m/T/2hzm/SiwG/7hPs4L
	 Zf/Z8/0jhYaO+6e2wWp1bGPxsNLG7sazMZxPVFWToeu86e7tjcB8hIHsFas5hzQxARzIa
	 16wkVG9tI383cFPwrXgWlO+fqtoHFv8FGRJEAkgvkFg9fq9DF7nh2tGD5Umx8Gd4fZ0D2
	 qUfUH2BHT/sVBXcLF5Uxx+xcqCtjT95jr+bpMXf6K8HXadqaUm1tS9aWYrIB894vvJGa0
	 5pvRS2vyU0x04OlG7mUZejPhbjlG9i/upGhEamDRh+a8wSZzH3v4+rdYkm77MWSoHnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830295;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Language:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=ZuGZWcioN7Yz3PJ81xFuW5ma1SXVVbXj+Qg6zlBF1S0=;
	b=ADjvJpmbL3QzrB2FQF1ngSZr+zg7Y0DT+v8AVPAtD04VlNxSXSDlvGHkVfiz4RhYSn98
	 82zCam5GHA1e/tu/mD+PxFjUh0u9chws+LwAolQYuMfxPflFDcARGFnjQJ8NbD2Mx7Nwt
	 /cYoo6OH0tFfQVhji2Q3MbfVHPTWFV0yTFYgO3tKoxAcfr/0ow5LT+4QumSZYL4gTIQEF
	 0BH/y4UgXDYWM1NlwsTCIhO0YC7o1pVZ/oNoJiai032e3hmuS5DA8J5f63QFifkZRYgHz
	 PKBid2AOjnmXSg0gUVsL/NA7uJMY3d6L06oI9SBlUZwidrov8DTWtmAGFHmm2Dh30cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Uq0mDh+o;
	arc=none smtp.remote-ip=113.46.200.225
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258E9606A334;
	Mon, 16 Nov 2026 11:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 258E9606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Uq0mDh+o
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZuGZWcioN7Yz3PJ81xFuW5ma1SXVVbXj+Qg6zlBF1S0=;
	b=Uq0mDh+o8k2YouBjI+m8Bzinp4yVgjrLs/FgLMZyOEpT0wJ8pfIaouYegfrjvH4w/1B/mXjHz
	e53bdjg8wHA21ELSi4obI7VjJ0LxPWkBYXqIcwelklvZY5uYMSi/ph0WDfeMdirXxoTnKmEE2fj
	34hT0tS/qK4ng+Nwx9amorw=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4jSmZt0T8vz1K96X;
	Mon, 16 Nov 2026 19:57:58 +0800 (CST)
Received: from whupemo200006.china.huawei.com (unknown [7.152.185.252])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E6674057C;
	Mon, 16 Nov 2026 19:58:10 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 whupemo200006.china.huawei.com (7.152.185.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 16 Nov 2026 19:58:08 +0800
Subject: Re: [PATCH 0/7] KVM: Documentation and comment fixes
To: Fuad Tabba <fuad.tabba@linux.dev>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank
	<frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Huacai
 Chen <chenhuacai@kernel.org>, <linux-mips@vger.kernel.org>, Will Deacon
	<will@kernel.org>, Fuad Tabba <tabba@google.com>
References: <20261111085448.1130701-1-fuad.tabba@linux.dev>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <f0fb6f7c-385a-dbea-0b4f-e09ec5a4dea4@huawei.com>
Date: Mon, 16 Nov 2026 19:58:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261111085448.1130701-1-fuad.tabba@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemo200006.china.huawei.com (7.152.185.252)

On 2026/11/11 16:54, Fuad Tabba wrote:
> Hi folks,
> 
> This series fixes the generic KVM documentation and comments, mostly
> references to non-existent functions, structures and constants, plus a
> few other one-line fixes and typos.
> 
> Patches 1-4 are for Documentation/virt/kvm, and 5-7 for comments in
> the code.
> 
> Based on Linux 7.4-rc2 (7475ea8b58616).
> 
> Cheers,
> /fuad
> 
> Fuad Tabba (7):
>   Documentation: KVM: Fix references to non-existent identifiers
>   Documentation: KVM: Fix lock names and a lock type in locking.rst
>   Documentation: KVM: Fix the function that implements halt polling
>   Documentation: KVM: Drop the stale number of vCPU request flags
>   KVM: Fix comments that refer to non-existent identifiers
>   KVM: Fix the range of reserved arch-independent request bits
>   KVM: Fix typos in comments

Series,

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
