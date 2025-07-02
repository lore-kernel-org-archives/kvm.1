Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C16228468C
	for <kvm@vger.kernel.org>; Wed,  2 Jul 2025 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467623; cv=none; b=QvOfxK6kHr7COQVIILPBLvWGiehDWScdL7aVglFfQtfgD29n9503g3Mwe8Oa27WKdKEl+wmiKHpzB2IKa86ZshUk6ZkRe1J5rh+UPXWjCShdWUr6NkDb+UxGCpCcVXdv/qQ+f1rs1yhYIe+wlEIu9N3P73gO9MgRS356JVOwCq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467623; c=relaxed/simple;
	bh=sAc24vMMQ8lMHpSfhPk1fLuth79YVo51u2VRUKwIdQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbqNJy+LAQeUXusWbRyPFRx45ZPJznYTrqeLZGvWgXjXZ55XkbMX1Fef+IgTr9eCP+o29wF+XxPweeeCa7ONb4nfgYbwMjPVCT0ONu8Vv4eeKvqrlYiyalRmAr9Ywo74s420PYhdGRV1AWQybipUaRgWKhHJfmu+c6pUujv1sow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r2iBC0df; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r2iBC0df"
Date: Wed, 2 Jul 2025 16:46:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751467619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1o8Ik1uzgJ1IWJd1kc5Y39/esP2RMVecgfn1KSfY0Wc=;
	b=r2iBC0dfniP2tfETMYrbCW5OlUmfhKZKOgWzunIaBCQcx4XpiW8ptuKC7aufz4JfcZl2mO
	c9u9Q2LKba2EwZlggh/bfEfHdTqlD+V2kBi2fjju280zJV+jnpzD6laDL23R1Gzc6r/61r
	W9uLHJnXWQ9WKS8aaNOCjleFnmu2PKw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	Andrew Jones <ajones@ventanamicro.com>, Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [kvm-unit-tests PATCH 0/3] riscv: sbi: sse: Fix some potential
 crashes
Message-ID: <20250702-03482a5567d2b66e063212ad@orel>
References: <20250623131127.531783-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250623131127.531783-1-cleger@rivosinc.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 23, 2025 at 03:11:22PM +0200, Clément Léger wrote:
> While validating another SBI, we encountered a few crashes and errors in
> the SSE tests. Fix SSE stack freeing as well as handler call checking.
> Also add READ_ONCE()/WRITE_ONCE() for some shared variable.
> 
> Clément Léger (3):
>   riscv: sbi: sse: Fix wrong sse stack initialization
>   riscv: sbi: sse: Add missing index for handler call check
>   riscv: sbi: sse: Use READ_ONCE()/WRITE_ONCE() for shared variables
> 
>  riscv/sbi-sse.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> -- 
> 2.50.0
>

Merged. Thanks
