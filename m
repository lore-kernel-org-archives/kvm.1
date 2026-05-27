Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF101423152;
	Wed, 27 May 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896147; cv=none; b=JdASQqlPoucRtnyG/tAkgJPM6qxIv8FkbtI/fRess8WBfhhAv6Ytjg15jI6rDveHHMinFyQTDlw8YD8oeyw+GVNSwvtzobWqwQbhveTh1iTP3T4hdzBm/8QJR6vvKmDJj0+beIudv2H8SpxF0wO/sr+nOc/EomFR3ULb95XdEIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896147; c=relaxed/simple;
	bh=iZEYpU3UqQ52hTy/j/ZABAG1Ey71YPSbJEQtq/nMy6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elcXh9iDJPWN57r5IflQiFoXpT34GxhPl4+JWx+1Vub3/jRUZSUVBpfNdKPHjq2C/hgAU3D9AxNzu8tJEitfQvGIgfISeHvT07pbqzgfQq+s7mR5j8hHRdlm63BJtiCqcsk3pGDfU1OkUyxHYaGz/ihAHrKMLRPwTYKkIUtulbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwodluDe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwodluDe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196B91F00A3D;
	Wed, 27 May 2026 15:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779896145;
	bh=lVKAiJd9z3oFJg5GLwDVUktIM2/kkXg0AHvbzBY4Xfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZwodluDeXmG3cYrYPewuNGhpMBE88RYZiIJAvOtQX4M6dbpxTXc43ZnJuhHu8tTKl
	 YrIMrF4pBVwD4o1kmFpbH4kxRdFNS5uKjgccFYHyu/aGJmH9g98iIx+aolV0e5Hrh/
	 BCYvkqIo2Pf9UWLZ3vPpK+WU6dsGkREfDe2qiY2yVUjbgygM+NwGvbI6YuaiUEhOtq
	 OyCMwGt9t8/MEM2+JYk2Cg3jihoAtP0r0RSUF87cf5du6pA6ISot5Y6uiUBF53ue99
	 iKMTGtzs7zXerOG2l2JQv3MT2CgoznZQVY5kjzBmsd0C+GDn515t3EIMAUCnZi7PU9
	 vbtPum2e6db7A==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 69E5BF40082;
	Wed, 27 May 2026 11:35:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 27 May 2026 11:35:44 -0400
X-ME-Sender: <xms:UA8XamsNJln3usXKyyiYyYCy8ZVD1kJFs9gVo1bhdl-S9fQdYF64TA>
    <xme:UA8Xai8w3QV7CBmUrujzNpDKYNusFkjTiuIRHvauisTxJeHYgMEZ_7Q__NeYaCity
    YtvbG-RVY5CQ9Tn12Zcnj2sa5d4VK-HdtacZSjCIEYBh-VwbgPiI7w>
X-ME-Received: <xmr:UA8Xan3Ub-_crWaJDFoDseINwJjJyIxrvMgVIJeWGiXayYMnF2oCCZTNBbsNXw>
X-ME-Proxy-Cause: dmFkZTETb8srkA9tyxBnLNl8cN6127R0y7V8RSlgsB1xBplMAQr0xcPOEV0B97lasvxaaq
    +i4A/vmPmWi9kV+72b/eHMW6kmZ9zxDQl24/nD87X3HqoP/IK6RpX1IfeijYstwPER/m7K
    Da1iCoTDeZI+rozugCqCmQ2wc/ld4uDa29mhCnu0/lUFGjAPCRoEi3Z8bKwBhvjbY6w7XS
    durSznhlANuoRT/x0WbVMe4cuWcfadzDbjT5uWnOOmsdNtraKxdg2aUFBe27qMQUY+NytN
    WNxpY6S0V34WLJZsKcRnRTFyBIIktFOm7KBcEWBCeQqBYNGNjnsxdCSebodCZeAqgW4UAd
    C2cBRnVVerQNnoZOYlQrkI9MKtnKT5l2ZpLy7fS6VlVB3eQVXzmw/QUWzxSu3p4aH+tYjH
    KW0CsnRa0HUpPiS5oqG7Gzx5hJAHZcEGA9smQj8vlvswXIiL7lu0RBzbf3/OWY7ihMXDvg
    m2jzN3CKj5IAUmaBr/R7wuZNBmUXLoBsDg6FvUnOyKlEKb7lV6iaGp3kasprUHVDR77SpC
    F90VTayrC2ucREp38rRqFS+9MnMLFN5f5ccshIfQ6jA3Y9Q26mW/abPT4hiRUKfOEbOFtc
    FcD+IhHWmW7xjHe7T3uFXti9FdVuMMl/LnRwaNKLvp4dqeCTxZzQh1v1p4ug
X-ME-Proxy: <xmx:UA8XavTQcgR7VUqZ-b2jF6QHnroUNStc8n8iIuqwvA1lb91nQf2egg>
    <xmx:UA8XaiARPEP_NUSDm_uLuye_AZfj993E7fqZuTak46BzlWvFyayUSQ>
    <xmx:UA8XattdmV4125FyBGzm6ZVrZHP6NNpAkLRKX9p5xK0SuU919DiTYQ>
    <xmx:UA8XamCiPma8WAh9xWUvBwbTh55I0LEQWsRuyNIoQZIYSRTtbze1wg>
    <xmx:UA8XaqLmWDvoTbZNUdvxcPd9BmbEXXZg7Wne8pdKD1VHgo2uZMzvHmgX>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 11:35:42 -0400 (EDT)
Date: Wed, 27 May 2026 16:35:36 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, djbw@kernel.org, 
	rick.p.edgecombe@intel.com, x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sohil.mehta@intel.com, yilun.xu@intel.com, 
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com
Subject: Re: [PATCH 01/15] x86/virt/tdx: Read global metadata for TDX Module
 Extensions
Message-ID: <ahcDvwEES7vqLLvg@thinkstation>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-2-yilun.xu@linux.intel.com>
 <956fa1e6-2920-4b2e-8037-d4b9d812ae53@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <956fa1e6-2920-4b2e-8037-d4b9d812ae53@intel.com>

On Mon, May 25, 2026 at 02:54:40PM +0800, Xiaoyao Li wrote:
> On 5/22/2026 11:41 AM, Xu Yilun wrote:
> ...
> > +static __init int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
> > +{
> > +	int ret = 0;
> > +	u64 val;
> > +
> > +	if (!ret && !(ret = read_sys_metadata_field(0x3100000100000000, &val)))
> > +		sysinfo_ext->memory_pool_required_pages = val;
> > +	if (!ret && !(ret = read_sys_metadata_field(0x3100000000000001, &val)))
> > +		sysinfo_ext->ext_required = val;
> > +
> > +	return ret;
> > +}
> > +
> >   static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
> >   {
> >   	int ret = 0;
> > @@ -116,5 +129,8 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
> >   	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
> >   	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
> > +	if (sysinfo->features.tdx_features0 & TDX_FEATURES0_EXT)
> > +		ret = ret ?: get_tdx_sys_info_ext(&sysinfo->ext);
> 
> Is it correct to read "memory_pool_required_pages" and "ext_required" so
> early in get_tdx_sys_info()? get_tdx_sys_info() is called before
> config_tdx_module() which calls TDH.SYS.CONFIG.
> 
> If I read the TDX module base spec correctly, the amount of memory for
> extensions and EXT_REQUIRED field depends on the enabled features, which is
> determined by TDH.SYS.CONFIG/TDH.SYS.UPDATE ?

This is my read too. Looks like we need a separate step after
config_tdx_module() to readout config-dependatant metadata.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
