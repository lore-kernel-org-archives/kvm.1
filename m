Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA510392C4B;
	Wed, 27 May 2026 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779878595; cv=none; b=bNT4RuQSImwDdGp1HvmB8+adPElqN+HrEe0s2g1Pp+yeI1EcjYMJqCRkp4LsTOHXEjj7fhfpthoYy0bjCZNNRBL/Ywl+gxCutJpPOA5NrcTHaKD/X9sZ+J2npXVOdycIsW8uLb8a5wGt+mlEqctxPXImJr1EL8GY9Fe2QnpYJgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779878595; c=relaxed/simple;
	bh=FkOAYjWf4iZz6Ys/zbj9pBI230xldZeZjxl3AzP9JGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMio//9LOWSuIpEAam3eJTcOuTMxXC85N3xHYWpTcaFHeDlRozIQOmCJTDVHx3/wqJ732hm/WLVXoaxHzfhK6rZIM3i6GFiUv+wfGHHw2odYdGLwfeBDmM+IdHh3F7oDt2y83ILO9Bn2umJa4dbVTpJWWqJgg0PtpQuoo32LdCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDZwF8Vh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDZwF8Vh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62501F00A3A;
	Wed, 27 May 2026 10:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779878594;
	bh=q4jFrj26eZZhkUpoGquMb5mLlxB5MchiERqX4NPGDO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SDZwF8VhKdeHjevUm6mlk5tKSJZ6ZJjoz0EBAw8U4tFrCE8wNyb6hiVlbORR40fa1
	 kyql0D5eKphDQt5rotb6LSwugtUeNBT0TihmomaR2Ry0gnXioGi6LvzkD6lckhboFy
	 nsn1D/yqyvoMDQ98EXTcQSQgXkVLSJhbhexG51O5xrnHjoZ4q70rn684ZgWdycRwXT
	 AY1qOnkSm0+FsiMk3xlCPqbhOh7SFBA4WxlQ7BNBFk6GCVXal3mDIQIaU7DCd/uX9c
	 uj/xMaNXkBUGYM0jYWwDQb6bGMZHsByiqdumz2XrptVAFkLBou9drs2Mdpla4q/adP
	 C1aYZAQYNe/oQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id DF7F1F4007E;
	Wed, 27 May 2026 06:43:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 27 May 2026 06:43:12 -0400
X-ME-Sender: <xms:wMoWal7WjKJChem1IYNnGjhbzoMQbzEEmbDEtdwdGlzUKC_nhJsVMw>
    <xme:wMoWaqR6JC9q_Pq7h3gbS0aWMWvC8UvTRM_ESRk9oNqfU10jPfoFI2n_ksg4Q1Lkx
    c-PY0exmEdev258QmANcY_jwSIrGio2AJmIQzrScuBMiD6mVVeatMI>
X-ME-Received: <xmr:wMoWamy310btuks_mAJgbRS2LLxMPuAvLwU2JdNVlxk36P6SpxwdDUEkuoR2Xw>
X-ME-Proxy-Cause: dmFkZTEUJ1t7Y5Lw33ZBxBdMQeRwfzjHtIzHblzrHkSdXxKXl6h7nk1jIO08OFh0Ee2J0U
    fCfvGiYsUjOrtORnu1m2qHPdrEyr1juBnxraojtWHHftVOshMpZWAWPEf0gQlQCGqZF3Jk
    wGEypfQNj24nCgX9UY2GtRtJYWnyNgyVeD+ySMJW/e/eAzgBfsSExuR626lY6lYrRLoPhW
    fG2cyQaVqzIgDgz7mG/gzdAbGGmXPza5M6pTOYcxDwyHhuSG8CCM50cvS25zRkzGJS2hKS
    5NkTpA+4VVKAB7tcqZVbgsgc9nPguFzxGLdyvFbOsAcHvXrCAuCvRq3WZRO5exTuNvfflw
    tNbIrd2//N4bEGZcdk4D/IPOLUvDrgNUYbkqrkGdiX//BrFJoD1GI2qebxi3JcTDdItjUq
    WtUKSbVmoIfW2fGI5Ub2a9VbVJGEmhMxtCmsxpTsG7vyZw2AgQ9AarZ9vsUbPXSXeYDyYo
    +D3u20I0g7+3++0GdILdVpoc7Qdr2x/ysoFk8vq9m8Y2wyNXEqFfz1wAn/MG6r0KRuhCY8
    yg4/1wqzJ+McuAoU9lLpk94VdkYNC+qIVJjWgvifYnWjLv1uHkNXvC9zKFTSmsgeFdD3kp
    CwrrLrxiEfdvZMlW81FTfeaEVRz27As609imKPF77Yw+wnEwhvDYU/UkDrnw
X-ME-Proxy: <xmx:wMoWakJeoNUWQCkUnPWdAhCgP8lPkp2B2_VcrWt5sTfxRbDq_unKtA>
    <xmx:wMoWas4ETQkv9jx0zSVacliUVYYFe2k9_fRcAUv4QYotPzcC4plUmw>
    <xmx:wMoWaqIgT6muoQ0RrUEwEGg7660TPjbDNGw0eGLX6rLqC1vKZ8Vmnw>
    <xmx:wMoWalH5Qtvz-RMNR5343clT2Y8cVxoEiqaMA9j5BNROWqDs0g09Bw>
    <xmx:wMoWahcfTg8MdkL2k0Z1256883yPFbk4fwUxiPJiJrIVBrWIqZy-rsBH>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 06:43:10 -0400 (EDT)
Date: Wed, 27 May 2026 11:43:05 +0100
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
Subject: Re: [PATCH v10 01/25] x86/virt/tdx: Clarify try_init_module_global()
 result caching
Message-ID: <ahbKeixZ5sm1FQKm@thinkstation>
References: <20260520133909.409394-1-chao.gao@intel.com>
 <20260520133909.409394-2-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520133909.409394-2-chao.gao@intel.com>

On Wed, May 20, 2026 at 06:38:04AM -0700, Chao Gao wrote:
> TDX module global initialization is executed only once. The first call
> caches both the result and the "done" state, and later callers reuse the
> saved result. A lock protects that cached state.
> 
> The current code is hard to read because sysinit_done is accessed under
> the lock, while sysinit_ret is not.
> 
> To improve readability, move sysinit_ret accesses within the lock.

Have you considered using the guard for the lock. It would simplify the
flow.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
