Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9693F20EB;
	Wed, 27 May 2026 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779878846; cv=none; b=PQX3hNLjPPbYBN+I1FmqJtgdWEHpTxf/zWutvVimpCevTJQxXeScZlhoniZJ8pJAnlNAKAD4tVo7S+ztrllgDeHDj2W9KqYPQPc4UUZXcQwI02wBOI1eSKgr5tL+QZNSMVhdRPjXzV3r4lSiAIEwvcB2/bsQ+aPzfzwj0YL7kIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779878846; c=relaxed/simple;
	bh=NG9qFWc8suFuBEIAwPaCqokXulOXVIsBYFkIYBFf05I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoJ/FI8r7T44v3GofwobTVoCGt8oobbYzw1/HGRk7YMqOwEYALPBNhAPYQzldUW5qPdfh98JPzIZfNN/qx71sZSTapjbC1oDABwMhbRjzVin1yK8olkdyRrUStweAF6OOnYRJ5Dq0l82thFUUfQoozNzG6EKTS6fmrdUfFE4VZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tc6dg+Nt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tc6dg+Nt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6EC1F00A3C;
	Wed, 27 May 2026 10:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779878845;
	bh=GF7yqPZxy/UBtAIWdj52Ge5BTK1zGLdahdE7Vukgqwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tc6dg+NtPYwSy6YxvL6ke5G+ogEJhvRTEv2GMFuWbDhreX00XZ2/Zyz59xNivFV6S
	 qAWIQu9boUwAZMCCyjDX1NyOOPnhLZgVpEU1QjrWX2o/aExqBVAduRDtEZOF2AJ4y/
	 xyvR8vxIrMe0ECNzQmRbv9zMsflpgux9eY45iIKjZIY/8g1WA2v3OdKR3cYAYCmfdM
	 QADgpuatWtMtoxEQpx12+fWLX4haxsDoZxlCnbwNzCWdjVl7ytx4iHyEymRiKtGKky
	 sRIVeBiA1wwibApAIRDKoD2lLEtW7XcCNDL+VWOeozP46F9wciT0D1JSSv1c0A9nhZ
	 4ZReIM9fIAH9Q==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 26823F40069;
	Wed, 27 May 2026 06:47:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 27 May 2026 06:47:24 -0400
X-ME-Sender: <xms:vMsWalYxOMLURUfSkV1AA8InzZZLh3UlhJirFusJyEz7QYRfqYApLg>
    <xme:vMsWajwGdYsLKsDUDO4R11uGlDk7vb5QXswhf3LhXSnsbHCAe4rg0DR2bZkCfJ9ru
    l_SDTGaAME86ya3lI35TZx15HhLbxleBIwm03CxDR6vYUNgTrwhrN17>
X-ME-Received: <xmr:vMsWaiS3rXIfauwuIQk5DlsIBtIfl3RdJhMD_0EUjgOACQzkz3L05Usd_QwGmw>
X-ME-Proxy-Cause: dmFkZTFyOlGajrZfYr2FiS7Y+kZQdh0DZ3FDWQRjnBiOtI3qVeVj5SlTCXSqmIQUkdVHhM
    xuasDhH2MID8z+flEntYV99unByU3JmO9+dd5e7REqFA7tcKQIzkqrutFlVhhnXUbO06x2
    m1Hn3+rT1o+Q1qUjqm6NU/Yb51xCabF3gaIMn1oqu61osCZH36ZOAncwzoC7CMcEIKe3kw
    9R51AC4ugba2BPCDIFqzZeyxIjc4LZSG005acWsv13Ha8AQHfRoADLBZ6crsZB5fyz1Pp0
    FgDsHVwPgwOtoF0AcS9D0HJDuvq0/65OIJgSKPLxmH1Uk2Y5EZjlMA+rlKzzUW3s+ggaJ2
    ccdKNYwzkD0qD+awGjZAHobXaFI/5AXGkI0yqJ/XcQEcxr4hvB9dEk1ojHnkd9RsSSEfV7
    p4LT4A9Fquepo9HHrY18vWBu6cLlO0ws00rxteQCycEAOBw98oEgM6QDDzP+WT/+gD+I8X
    AEikLtWTWGwyItv47nbzZROhF2QXQd6R2zJZKdut0smnGUYvtDOcSFPhWf+5zwJXUFD7e3
    VoqjHPAhUSov8rNZlce5lNzDFvpuFbERORo9CKC4A5ygtEvwHSYZbDh2PUlxT1zNoXUiLg
    dq7iBRGT2eCeAZp7AVB2+ZUdE/HpzCgADQWWaGXwJ7qaP2sdqLkLUF2OjTjg
X-ME-Proxy: <xmx:vMsWapqPHRFVzHNZaGRvZ6jw0LyG-8nr9lqQbkLsMB62RLNtT0YG0Q>
    <xmx:vMsWakYXEKVAJ8OILzWUi0TW6xWYDgxprJn6iTKcWn4_Y-NpfAppZg>
    <xmx:vMsWarrNlVSbVhrEyR8F8prHRbF3OzEMidAJKjW7BTtP1cATl0_Fbw>
    <xmx:vMsWaok8_qkFHB9hZjUyiEdNViUtOIUbmGKKO3i8tyRgInFxE4nENQ>
    <xmx:vMsWau8NDtv7gJdpSyMHtijYjickL_M8UR6KuVF72lvRdCXGIUGLThXs>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 06:47:22 -0400 (EDT)
Date: Wed, 27 May 2026 11:47:16 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, binbin.wu@linux.intel.com, dave.hansen@linux.intel.com, 
	djbw@kernel.org, ira.weiny@intel.com, kai.huang@intel.com, nik.borisov@suse.com, 
	paulmck@kernel.org, pbonzini@redhat.com, reinette.chatre@intel.com, 
	rick.p.edgecombe@intel.com, sagis@google.com, seanjc@google.com, 
	tony.lindgren@linux.intel.com, vannapurve@google.com, vishal.l.verma@intel.com, 
	yilun.xu@linux.intel.com, xiaoyao.li@intel.com, yan.y.zhao@intel.com, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v10 02/25] x86/virt/tdx: Move TDX global initialization
 states to file scope
Message-ID: <ahbLRFl5OPtqHr3t@thinkstation>
References: <20260520133909.409394-1-chao.gao@intel.com>
 <20260520133909.409394-3-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520133909.409394-3-chao.gao@intel.com>

On Wed, May 20, 2026 at 06:38:05AM -0700, Chao Gao wrote:
> TDX module global initialization is executed only once. The first call
> caches both the result and the "done" state, and later callers reuse the
> saved result. A lock protects that cached states.
> 
> Those states and the lock are currently kept as function-local statics
> because they are used only by try_init_module_global().
> 
> TDX module updates need to reset the cached states so TDX global
> initialization can be run again after an update. That will add another
> access site in the same file.
> 
> Move the cached states to file scope so it is accessible outside
> try_init_module_global(), and move the lock along with the states it
> protects.
> 
> No functional change intended.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>

Reviewed-by: Kiryl Shutsemau <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
