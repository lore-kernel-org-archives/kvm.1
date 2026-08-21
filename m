Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7324E421233
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325742; cv=none; b=uN8wxGKaHQlb+NnYP5Rc2qiWyiiBFQriAz4toj6L98RveLapIYajjDQ6Y4kVzHKV6ngtKQnzMUsS7/weGc8Ye9aRt7HH8yYGFbRJIpuKcFMZy1e98zu9tc6KiVmpfjwxd6kyKXhqqjAC3fjSnzf0hwWRKDO3lHbv1QRhE7xaKSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325742; c=relaxed/simple;
	bh=F/r2zIvbOgN9Q+WhMLhk6PDLDh24dmotCgClSo6W8ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmsFe/KskO+iVOd0s1Y0pn0flVfGQRtAI3ydg/33RURJhGsQ8y283AJ77TJwOUgAwwa5yxo+vkE8VT+brq4wMbnCPJrSu0GuWgiBpG2nC/nbv3UBL81UfkMGRHG3PYAgaezeraAqFvKYc3OsF/0DtTPPc0sy4znToUZSkz4hFoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWH0hoKa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWH0hoKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DBD1F00A3D;
	Fri, 21 Aug 2026 15:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787325739;
	bh=m3Q/uuxqDsORYxRr4gbtOk/5sbmMApPrP1NPH0V0PuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FWH0hoKahHT9NLtiTtHC/IuQi7JyKmK6ORUtFHS3uXOrpVLM9vhzVV03Um8x/Y7tt
	 Tv3HVI+d9lUVg/W30Zzw6+GkAy9+X7JyKvIVtSG4HGpUWVrMkBK9WcjFt34+KqkbMm
	 9/POzmM4Qt0+0G+3XjOHv7lCOPYMBrPyNcbDKk0UZGii0Pu+4BMJ53RLQP5V6y90qF
	 d6xongVYNjLjNq3+FLSiByRCJGLESedhjp2p8aLtX39Yr0qakGDvywr/c73jHqM3a7
	 W4xGhIo+ofcoJ1wzGa8Z/IwB1cfyrjMd0GUkxqXRBC2tvEaOFEfRg6yi4dML0UG/Y1
	 47pzRqk3wAxRg==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.ams.internal (Postfix) with ESMTP id 4B4FB198005C;
	Fri, 21 Aug 2026 11:22:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 21 Aug 2026 11:22:17 -0400
X-ME-Sender: <xms:JW2IaguIF_W1vGEPaAhlXNRjJhZTS4Oavi7CnBZVVgOEI6qpFm3zYg>
    <xme:JW2IastvX9ISEYE599xbQozbqhlL0UAhFCQnPy5l_JGZr7hH96CsAo-1b7kB6IKeh
    NXm3aprVwxAOXyuMDV2ea1Odizae8uRk-CUCvw94FlHOa285N6F95I>
X-ME-Received: <xmr:JW2Ian-Ql6gma7nAGpcDxflRNHHo_gAzj8jJrhY4muGTNSxi_-UeOwfJfXc>
X-ME-Proxy-Cause: dmFkZTEI7xnPoiFK7D2yvFVYe/8dWOV7AHrViby8I79jvd+aJib/EFI9wTm2aOURbionx6
    YVi1kvqYO+WKazD1VN+FXkqjWGhrAcL5n2eK6u/I2BLXSoHVDtT6ejqLs4MbC1EXMl593M
    5i0eWSETiBOjfqvGPzGlRnRm7X7JS21hX20GrKz7D/X5LY/PAFIolsgcxE47fR+JUa9bIy
    5mIUL3pgchALJggwtq1aynRhZqSAAlUSl9u2Vgjgnk4FNOuWoDyV4GSdZtEXUmnSogyS5f
    dJrJO4GlrXZ0roP1Nsj6gT+r/+K/3RTIiCzjp0FGP31N+namhMk6GLGXX7wt/rJwkYsPTN
    zlQj5L4PJKD9Wdf4xOTj9HhQqTNz2QVIf+KK2q/+ICmnYFbKgX30Rdv15R+5QRh22CLUpg
    inXqRt8I3JfVszok6qT+lbs1VG60CaC7C25/qpc+TSUx7Z6CYCBMv5M1qmj2/FcHKDRVvG
    RMmlu1X9y9kt6Yo5W5C2kpjLyiCJZLqns2tHa2q4x/a468DySntkASIYGIDUYZyO5dKGc1
    6gvyqBlVIKtcX/0hrEq/vezuL/MOkTc2TGrO99WoMgQVx/jH3IdpOHRzv5o8rO30sRaUDo
    oQ4cvBrAlYRH3K8CGFMToukxtuljnDX5LZOU7fd8wWsOh8wuwg4+ert2v+9Q
X-ME-Proxy: <xmx:JW2Iat_YX-fwq2Av--cnwdeXE-mbytNPD68ystEfdOyu5D8e9TuIrw>
    <xmx:JW2Iaj9dgO2oFfyheW1CX8Cmna04yJCNdkqEz-lFckL583oq3x_ElQ>
    <xmx:JW2IarFswSnZ0METD-bpk1ZKxidZjxTj00XFjfsFPrmh5JCXh5Vpmw>
    <xmx:JW2IaqZT32ybUcYYxPMCEot1Q93aLicPO4cTGxZsmtbowuP4wueCfA>
    <xmx:JW2IanMJsYS52_8SS7m7f1qfCQzmMumRTnayzYtEfTcR9MxjE6BoA98i>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 11:22:13 -0400 (EDT)
Date: Fri, 21 Aug 2026 16:22:12 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com, yilun.xu@intel.com, 
	xiaoyao.li@intel.com, sohil.mehta@intel.com, adrian.hunter@intel.com, 
	kishen.maloor@intel.com, tony.lindgren@linux.intel.com, peter.fang@intel.com, 
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, chao.gao@intel.com, 
	artem.bityutskiy@linux.intel.com, kvm@vger.kernel.org
Subject: Re: [PATCH 3/6] x86/virt/tdx: Detect if the extensions
 initialization is required
Message-ID: <aohsoZbDBZ8ZIYez@thinkstation>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
 <20260821032920.256225-4-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821032920.256225-4-yilun.xu@linux.intel.com>

On Fri, Aug 21, 2026 at 11:29:17AM +0800, Xu Yilun wrote:
>  static __init int init_tdx_module(void)
>  {
>  	int ret;
> @@ -1229,6 +1253,10 @@ static __init int init_tdx_module(void)
>  	if (ret)
>  		goto err_reset_pamts;
>  
> +	ret = init_tdx_module_extensions();
> +	if (ret)
> +		goto err_reset_pamts;
> +

Hm. Don't we need TDH.SYS.SHUTDOWN/DISABLE on error?

Once TDMRs are initialized the module is functional. Yanking PAMT from
under it is not safe AFAICS.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
