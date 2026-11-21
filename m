Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795276171;
	b=JgA6Iv6MEC8ax3GnXiQo38ZQhXnQKOLdCrJ2n+1vPqPMVnAgNTpMgW73/C1AEM2OyUs6
	 J07ywgZiox2gzyZgXnPRnN7D4ZKUO4RKuC0lV0T1fQ47a0gyubncKWrBpuQAIoxAjUjcB
	 +kY4k56AVgTOuW5wUHxkpB9VsS25ifGL4BMdKssO9WBffvpi/P7XUwUnTGmZz0BtmUFYH
	 GukXE1zNCQg5KjBSPK1ghrE4DPuM8UFZXwauNlkJjZqFl1n6bB8wc4pfz7h3Teh6HBycK
	 7qAYvKFn7ezJ7rlRVsfCIicycJEb/LvxQLf5U0Nr+z1DmGQXYTt01jiGqkr0kP89wiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795276171;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0YZb9vl8h3h2s9tCOBwKg7YDMBx7IJ0VENcqcFynRLs=;
	b=J6tSzRTdiodSq3FUKik2sOKxsyN5Gj/6Hlg62XDq5oftox7BDTdxOBKy2e/nVwfgwI8H
	 XigOEH9tGtZCMkmnQBYI/5gWn0jubI33p0MeAn8k6fjqH94gNI6YYQQi1M7YenRTXvmD4
	 t9Rggm0XrwKKlf9sZ8T8eVzvOXhAwBgYs+rKyP9u6gRefkjk9kbeW/6PBhVrRkez1aMgn
	 oDok1A0fI+IXZFWd0T4yqcMruamLneNQYos1ROhxUXz/8nlB/pRFD1RxFvXM/Rtf47G2I
	 3dyu63iUQ0YCKaQTiCHCJQvIj9bXGqyN+jHN58OZD8DqP3ku6973nQF6GGV4YO7/KNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w2pR9wVL;
	arc=none smtp.remote-ip=95.215.58.108
Received: from mta1.migadu.com (out-108.mta1.migadu.com [95.215.58.108])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920E6606A320
	for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 15:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 920E6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w2pR9wVL
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=87tG5wTJqa8KKU5Vw1XcYaRFIKmNyRkg1DQIqfjExPM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795276168; v=1; x=1795880968;
 b=w2pR9wVLVUEmNc/0xvbGAfErcyc7Q064cNe2Qb0JIQ8E3trfNPtCcUuXokXWWavloaXnxfRU
 Y3drjX4obip27K21vOfT/kadJGIDVNpdHfim3KoKCHqoBpoWUFI7VggUrR3pFshFi6VvgDpAEym
 dXAczSt5dyLO0XQ6IT/CY/Lk=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1cf4a9c89376da71;
	Sat, 21 Nov 2026 15:49:28 +0000
X-Mizu-Trace-ID: 1cf4a9c89376da71
X-Migadu-Flow: FLOW_OUT
Date: Sat, 21 Nov 2026 16:48:51 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Gong Shuai <gong.shuai@sanechips.com.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Tomasz Jeznach <tomasz.jeznach@linux.dev>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Fangyu Yu <fangyu.yu@linux.alibaba.com>, 
	Tan Chi <tanchi25@mails.ucas.ac.cn>, Wu Fei <wu.fei9@sanechips.com.cn>, 
	Zhao Qingye <zhao.qingye@sanechips.com.cn>
Subject: Re: [RFC PATCH v3 09/10] iommu/riscv: Add
 riscv_iommu_attach_dev_nested
Message-ID: <awG5Q7pmntSme1A2@orel>
References: <20261119132744.396426-1-gong.shuai@sanechips.com.cn>
 <20261119132744.396426-10-gong.shuai@sanechips.com.cn>
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
In-Reply-To: <20261119132744.396426-10-gong.shuai@sanechips.com.cn>

On Thu, Nov 19, 2026 at 09:27:43PM +0800, Gong Shuai wrote:
...
> +	if (riscv_iommu_bond_link(s2_parent, dev, nested_domain->viommu->gscid))
> +		return -ENOMEM;
> +
> +	riscv_iommu_iodir_update(iommu, dev, &dc);
> +	riscv_iommu_bond_unlink(info->domain, dev);
> +	info->domain = s2_parent;
> +

When moving between the S2 parent and a nested domain on it, the parent
briefly has two bonds for dev. bond_link() puts the new bond after the
first bond with the same GSCID, which may come before dev's old bond,
and since it's then dev's first bond, bond_unlink() removes it. dev is
left bonded with its old GSCID, so its new GSCID misses invalidations
once no other device's bond has it.

Passing the old domain to bond_unlink(), like I do in [1] for a
different reason, would let it remove the bond matching both dev and
old's GSCID.

[1] https://lore.kernel.org/all/20260928143113.49838-12-andrew.jones@oss.qualcomm.com/

Thanks,
drew
