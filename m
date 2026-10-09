Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A5E4D98EF;
	Fri,  9 Oct 2026 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552783; cv=none; b=G0Rf+mJbBu14KLSVOWOIWCPYDhVmeyRRDjWZ8qZhSr/sMlrBWhjI82F0ke6zRbra8mZenvnWCgimCcgGDjkmqJWDFkmNAx8HqTBA5OFA1SKmx/WJ73iJwYJRl4dHdqup6+vUXFs2iwDX5Uu1qK3TIYl0amnFyqPGVTOesp7ToZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552783; c=relaxed/simple;
	bh=WvmolwwrU2Uh/T6wngbddJ+1APU+26EM1WIWvtOFCqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rk2tLTSFl1Wh5L5AweFJGpWNDPjCiXZrQLIdRD9tHgvaN2ZgDrISYvoftJ6Tq3AexJ6v59iHvA0D7r+WzW4Kc/PQCpe7g8TZwGhcN1EXJvsT2jqJdwJszIx/E8z5WK7Y76FdVFFWKAqqF210UltNB/UcS1JcbpBqBQcGEWzWkxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXVaLJ98; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXVaLJ98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF821F00898;
	Fri,  9 Oct 2026 13:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791552781;
	bh=vtNGdwX9226oKEHJSuxKWx/vJU3Syo0UVvzCZlo2IdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DXVaLJ98u2plTIRnoMSLXP6GaMuOLWVBYCu0VJHJinRngPwu3iVMGSCGu89MUhdzz
	 m3VfNipI5ap+B7IuSD2lRkBJzLt3c1Ve+hds6+sN/i8u2937w0rxc+S33dd1IZKPNX
	 C4R+cIF3BA7hHzaeN17XXnr2YhgjNUI4FWBkuBZqnRX257zZihvI6Gxi8qPvaLyUsW
	 K0ew0ofmD0nIaZaeA55wIfzSetqxvmDWzIjFkADgji2d1Apra+L472/tQVtBdhsW7F
	 YurNQyGsXVVcgQkPtL+uSOHx8iqlddx5pyOemEDdQJPfo01ECMb3zEVRdRyr0Qml3j
	 avxDOPCKndsDg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id D77EB198003A;
	Fri,  9 Oct 2026 09:32:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 09 Oct 2026 09:32:59 -0400
X-ME-Sender: <xms:B-3IavDYWapYa4R9AL0TheQkw5fZ37FN1Juc-WdeYXo2AeD8lY64eg>
    <xme:B-3IahuqDUFfV8YS4hKmbjGJmIVKpVpwT4J86j-YdR2CYoOjQQ7P8sSDu7oj2n_Sc
    0RlJ5fQGFAp-xXPxQ3s3j8iXWtujq7-5M6Y1yBJZZtW5Yn5CZSe6G4>
X-ME-Received: <xmr:B-3IahsWWjmBL6J1pyXJmhtL5-YD4n1Nuq7bZrTK-f6r3fBSTaHrVWLJJLE>
X-ME-Proxy-Cause: dmFkZTGw5XdlRQm/UeDPoFIjeNbXbPnx8bZKK8wNLgIIkenoSYaYluSVDqoEtJ7YJfkXfj
    SF5QA7JmvJ9TnpnZhEaMV8E47/6fNOjKjdatHIQMop5uOCvBJUg2GdWfbRpwKtQZlyDb1f
    4iFi8iyEOVZZFFNaKbdrMf2XxrNJ20vHjA4tZwOHtkkvYbwzu/TQc701nBG+0ekAOQTZ0Q
    6DTBpW2EAKK6yn0F9DJDIuzmgUpDFbYYIg9WOBs3vffRv+G6WvdqO7aLd/wJn6Qto4n2O3
    GIPlzUI9UjhLX+lnWUzv29Op846XeT2pHUzppVGFFBRWZ9006vKdxFMdVcoI/iO0EisgYZ
    Uo251Ymb9JuVBFuN3P/glhQuS9xPQFqXlrJz8ybhu/nhOkkZkkfZxDmNZ0xxfgwH5pEb/R
    ZRHqqFXz+hfr1hOJL6gbXXQiuiSNCc9S8plaIzU3E/yZp7kLVr3yvKbg94dlDggfHXw4YH
    Dz1W+zdubZR72kyPpLMbJa1FOTlwE9IGYESfK5UO1pON7ECrpjd/bc++WeCDY6rvdBn36n
    YmtuuRkxpxA64ez22ZbNKf/hHorKk6D6IrmKbLQETbMimo1IQxFQz4m5KOkWqzpquigV/s
    C58c+92/Hf2J0g1U19bke7hs2nhzxRY+y87580Ly9x7QgFLne+3tbJrih9xw
X-ME-Proxy: <xmx:B-3IatUNpxT7jersF2Lo_1r2tRa1JSy5SADLGdzIoAQOmJv2IQ5I7w>
    <xmx:B-3IalnhXTk9w1DHF-PccOfqwvgnStAkKXlJEWzxadKKkHzsynvDGA>
    <xmx:B-3IaqC-N-PU8V-gbBDB_tE8bQpw1WL0gDwYRm24TrXI1eECxrIw7g>
    <xmx:B-3Iav4cbeyaxwyfHbX5v5FbkAkLZsA8yBZpEggYQVSmeY0fSPC3Dg>
    <xmx:B-3IarWOEcCgZXwBox3_dok7oZArWkXrl8s2BeMaMYqvBBGd-_VOs1Ca>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 09:32:54 -0400 (EDT)
Date: Fri, 9 Oct 2026 14:32:53 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, dave.hansen@intel.com, kvm@vger.kernel.org, yilun.xu@intel.com, 
	xiaoyao.li@intel.com, sohil.mehta@intel.com, adrian.hunter@intel.com, 
	kishen.maloor@intel.com, tony.lindgren@linux.intel.com, peter.fang@intel.com, 
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, chao.gao@intel.com, 
	artem.bityutskiy@linux.intel.com, nik.borisov@suse.com
Subject: Re: [PATCH v3 4/6] x86/virt/tdx: Make TDX module initialize the
 extensions
Message-ID: <asjs-TIxKELIVH1v@thinkstation>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-4-db52cb05b918@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-tdx-module-ext-v3-4-db52cb05b918@linux.intel.com>

On Tue, Oct 06, 2026 at 01:41:48AM +0800, Xu Yilun wrote:
> TDX module extensions need memory for their execution environment
> to serve SEAMCALL leafs. Several add-on features depend on the
> extensions to execute their SEAMCALL leafs.
> 
> After providing all required memory to the TDX module, initialize TDX
> module extensions via TDH.EXT.INIT, then those add-on features can use
> their SEAMCALL leafs normally.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
