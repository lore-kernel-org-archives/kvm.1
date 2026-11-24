Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541109;
	b=dVvqyCBcsvuJ3TUZai3iulQIm7NsPrROBLdiViw9ObkpEePxwABa5MiHM1o5VRde0ZU9
	 cXDBHIPrr5KED+s0mijdQFLlsL1+lyBQXs0jtuYNVE+kF7onDmATa73w2Tn9PXWtIN44w
	 RdvU2a0PjmNJ7/H/qJvq8R4WnQ6fsE+HRPHUai+5F61YoZHojvnl1Z8cQo5DA2UVzYDmN
	 BjQI/3LdaGa3I4Xio8e6XPUsqh1MoZEoEpo5orWTB4wU93CGZ/BcD3gzc69cjavZyVbPl
	 7mp691ruZWyZQNmdBDdN06fmutGWtDBKbKZE5CSirCNdDHOdcXj92c68T+Q8N+E+5iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541109;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=FOIkI9R3/c14nxJoA41gu0Asst01agVRhcr5rFxRHLE=;
	b=QjHhMF+R99wEyMsFFcngnBEEDzwNdTp72GO7QIXDqOdb/d844ThtniZqf/L5E9ExzvOQ
	 4xJh3wqcE09AWiHRI3nwW35dAvLU8vjBSq6PIk/zuVox38TudphXgAS35eYCCb0DNKbYR
	 U5DnzOvJsLOsyIBaQfzr+78GwNH2rwjkBnZ9yllFQdwRKzjM0ywzGOMwHcbgP9ya5Hr1w
	 YXbl2hf6bmE/zudQObF7bcuviMVNIl/+6wWWCe+3zGdztiFcmk8IxZukVPqPsmuBLZh0o
	 NlG7AvxZ1Dau+71wi+MbXkwsIVSEBOExoTPmw6kg8jObgDBs8NcvQqFzA7Bcmwd6CQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xmSI12ce;
	arc=none smtp.remote-ip=91.218.175.150
Received: from mta0.migadu.com (out-150.mta0.migadu.com [91.218.175.150])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36B9606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 17:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C36B9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xmSI12ce
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LtOf42LRb6ema5kG9lyhnRBIBEsKhg+Nu5OMnkMKR6Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795541106; v=1; x=1796145906;
 b=xmSI12ceCe6f3psuv8sjdfGJt1qVm7LnkuUnXKnWK8NksrJuFD+/fwzQuj2UyNcE9zdAomIJ
 5Caa2YJG7U60rPatvAv3FSBlRbX9HAX49FzSzMuCYW/SGIuAxq/L89RvJayTnUQlBCsggb1WGsq
 lFzVsNeRhzXfsQE5D/+7lwNI=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e81a7298d22543e7;
	Tue, 24 Nov 2026 17:25:06 +0000
X-Mizu-Trace-ID: e81a7298d22543e7
X-Migadu-Flow: FLOW_OUT
Date: Tue, 24 Nov 2026 18:24:29 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH v2 8/8] riscv: Add BRS SBI requirement
 tests
Message-ID: <awXH92cKFHKZKPFp@orel>
References: <20261105082035.133680-1-wangxiang@iscas.ac.cn>
 <20261105082035.133680-9-wangxiang@iscas.ac.cn>
 <awAxIHVLgbqTIYq5@orel>
 <be563f376884fa46178aa4f78468aeb13272506f.camel@iscas.ac.cn>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be563f376884fa46178aa4f78468aeb13272506f.camel@iscas.ac.cn>

On Tue, Nov 24, 2026 at 08:50:20PM +0800, Xiang W wrote:
> > 
> > I've sent https://lore.kernel.org/all/20261120135613.1388647-1-andrew.jones@linux.dev/
> > to avoid having to do all this DT parsing in the test code. Your next
> > version should add a patch that adds the ACPI support for setting
> > thread_info.imsic_addr and then this patch should use it.
> > 
> Thanks for writing that helper.
> 
> v3 will carry your DT patch and add the ACPI side. The BRS tests then 
> just read cpus[].imsic_addr.

Let's rename imsic_addr to imsic_pa

Thanks,
drew
