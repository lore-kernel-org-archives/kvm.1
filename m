Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AC43CE489;
	Fri,  9 Oct 2026 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552888; cv=none; b=a4V+doTlJDqHaAMm2W78QcSN5YeNYTLEzmMY2iiTYk+7B+fXN1HRp0Ybmt9W6/piA8d5GKIud4qU5BGTvrssChqafK+srxLHuOQiOUng0Y6NVaIw11ccMsR7fZnK9HGizJxqcjpQwillOHpoKJxEmONClasI6UDE/lgU2ASa5aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552888; c=relaxed/simple;
	bh=LxKg62PlmNx0MlHe1txpm2hxz+NCk7C1AJusvi2WtXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=By8I2GwPi8ueBsY1BqDeIMczGqXRdWJBUgIIpJfJGuo87PZlbV4Q5s7KobuAaamKORPUKr9LlumuFGdVZyq1U54VmgxYeXfV8CFGyguc5bDEPb9s8xAcRTejDox94FgnjrNYg5gA7Dr3LEpBilDk7oREbpgepzmKGon+YotKkN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIDAvzPQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIDAvzPQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852891F00893;
	Fri,  9 Oct 2026 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791552886;
	bh=TtF3DxvUhanuYnXt1YXLAj9lwWZRC5yyEKdizcebdSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RIDAvzPQUtTEZoD28PiqD0bSNS1a5fzKGcBTYJ3JhB5VOKR4UvzXr5cRsiX+O9Rft
	 v6njrea3Q9DlBrAwnGtbc5K2EC0yJ9olaq+9SDbP/r5VThLmubMUPwKfOIBwM7LPVY
	 arLDpTYS9H0dE+PBUaUPrxBVtGbicRNGX2l1CFZLJvvjCyoHeo2FTI8X44qVpCBN/o
	 LrcWXCcZrB++mzj5sUxTkah6CInb1tASHyFWvL3WcaK5pFZtqPpECmtU7M25LwhePC
	 3gKW4ROfZU15+poeAdh4W4Jct1PAqWno9Uk/TtaSQVSJLVMc+fUKKuemniST0YnQGA
	 LupsDS4Greg6w==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id EDF13198003A;
	Fri,  9 Oct 2026 09:34:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 09 Oct 2026 09:34:44 -0400
X-ME-Sender: <xms:cO3IatkjrceH2Dfvd612El9oBRB_OmDZDWX8wUoNY84ehDv_AHjpGw>
    <xme:cO3IalDlna-WLPFXdToT6HUyyyo6idcgY-x-Zw-ERqVsATMIPIrgvUX0FpHNenY6u
    NYLhP3ayhZNctUecnSNBBfz8az7h1XLSdReJdiEFPTzjwLiu_tspQ>
X-ME-Received: <xmr:cO3Iaqzp0GyhmLBWxlSmoc5FEHGRNTzpoKqwLp76ZDC_7jqaFCkPzZkH7ic>
X-ME-Proxy-Cause: dmFkZTFZKR9ZI/CjT/olIIhYNnBN/AlfFyEQ1++yoCcEcTeUFS2I0EHbFo/1rsNiYswRBJ
    nSG6QvgUhQASsuG1w6uheR+aViCkE4kIXigJXlIkba7/rbkrsS8K/K/xP7pIdR51u6MfKy
    pjtTqnScid/gHM1kgJJNt3m4hXPtExGyb285G1jrYEXsbfQPDA5waONmqNtyJnwN1VmXx1
    O2Md23mRCmTgOvJPS5CWRl6jlJ9i8Cmh/f/rMUXj+5pDIbggrn97MTjy0Lo0sDpkONUuxX
    xzv8AO6dSO+veYf9kUaLdAxs0X1XGCMrQMasjXsb+RqicYAZ4mKUjYZOx6Wz42/YEK+PSG
    GPIGFT669z3tCl8zJ5aa8M0lRsD36xWtG11UIxpZqZJXy+pWq7JwTOKyTa4sejJNnGvGGg
    TUhXJtLOOaCGvj1kUZxz91b+b32TPrSQv4/H02Fo1PwQuvrPNYggOQpQ1b+Y5QktxSAa4r
    qWYLUNZEMk32LA36q9WkZaxTeVdsulsifpl14x06XfyPJA9ojyUjf+BTfVnNHTCtaiHj0Y
    OeFAjP3pOZ+67XWofs/s/GcwvUF+JWB084IiOrJIXucOyPBXcU35nwjYAtU5YYFitHws1G
    5AjyK7EU4eViMXpoeW+5boxl+71n4C8dH2+1Byl0ySID7ayJXAPIHBAdfciQ
X-ME-Proxy: <xmx:cO3IapJo_4ezpAdPK-fkhby-BNDMzX-XoWrGrGvdkMEmIQpMGzZ6zQ>
    <xmx:cO3IatJRvkPseABvDmUMQ8kZPsdmGrXUqsm_tZzb7OLhopHOSe2nGw>
    <xmx:cO3IaiVY4JCebb5JjGJOQUi2jaPkmb-12hRRoERsND-8K2AKZkct5A>
    <xmx:cO3Iap_4vzMXxr_SoYmeBla_3_9Q_W1j5iSEOTgIw4p8w3Acz4bqIA>
    <xmx:cO3IakK4F6Zj8e1EEjN9oMYLmJ9hyD8AFDWy84FZuk5ZqgidyoXaPsdz>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 09:34:39 -0400 (EDT)
Date: Fri, 9 Oct 2026 14:34:38 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, dave.hansen@intel.com, kvm@vger.kernel.org, yilun.xu@intel.com, 
	xiaoyao.li@intel.com, sohil.mehta@intel.com, adrian.hunter@intel.com, 
	kishen.maloor@intel.com, tony.lindgren@linux.intel.com, peter.fang@intel.com, 
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, chao.gao@intel.com, 
	artem.bityutskiy@linux.intel.com, nik.borisov@suse.com
Subject: Re: [PATCH v3 5/6] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Message-ID: <asjtU41QEND7lcTu@thinkstation>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-5-db52cb05b918@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-tdx-module-ext-v3-5-db52cb05b918@linux.intel.com>

On Tue, Oct 06, 2026 at 01:41:49AM +0800, Xu Yilun wrote:
> Runtime TDX module update introduces a mechanism to update the module
> firmware while preserving and restoring TDX operations. The extensions
> functionalities should also be re-initialized as part of the restoration
> process.
> 
> The TDX architecture supports an update flow which allows updated
> extensions to consume more memory than their original boot-time
> requirement. So the arch defines the extensions re-initialization flow
> the same as boot-up initialization: the host queries TDX module how much
> additional memory needed, allocates it, adds it to the module via
> TDH.EXT.MEM.ADD, then re-initializes the extensions via TDH.EXT.INIT.
> 
> Linux runs the updates in stop_machine() context, which prevents memory
> allocation. So for Linux, a compatible update must not install updated
> extensions that require additional memory.
> 
> Given that the memory for the extensions must not increase, the
> re-initialization skips the memory adding steps. It is simplified as:
> 
>   - Check if the extensions are supported via TDX_FEATURES0_EXT. If not,
>     skip the extensions re-initialization.
> 
>   - Re-initialize the extensions via TDH.EXT.INIT. The SEAMCALL leaf
>     will fail if the updated extensions require more memory, which
>     indicates the update image is not compatible.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
