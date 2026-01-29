Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F54337AA9D;
	Thu, 29 Jan 2026 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769672708; cv=none; b=GMz1SvEKfsuRjgyR5hQtA++xyF4kA12pOknw1S2htV5YRRvdK0dKMmHYmmwhzrWR8vYKDnKaLyJM2yNcBObTM2PHifjz2usxayT2wvzSHyiG67G5m4HIudbzTHMZhw11tyB1YI20dYfZZ3aMCoyUR1pyibiAwu4BYbYQM4JQJMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769672708; c=relaxed/simple;
	bh=O57SdiRDRsJRSnQr7DjgeY/ISHGN6hBQr+ivxdhpJoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3bZ7kWF0bK1YuwS2E0051AESMHpnkcvI6M6pFW6zrbVjZ3IRaZcBwyBRFOsE5WnDPef74xt6TfNmNkG2TYoVhcJm4J7qtNDbFpxfKAuWSnCe1S0+eVLjcIEienOi0mHAb7po8v2zZlWvRxvaNkL6WULRCCucoJrU8akJtIhJ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aT5L+K9v; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aT5L+K9v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769672706; x=1801208706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O57SdiRDRsJRSnQr7DjgeY/ISHGN6hBQr+ivxdhpJoE=;
  b=aT5L+K9vy7B7DtjrrubNTXIh/IH0AQ2UpzFgQu2EGMBnvCmmJDVOZPgU
   +fqeKWl4fl6k3Ft5mKJP/rzq/2318FcRiDELuQWTN01PdvHaMSi1y1ja9
   N0zsj/n7L/QSA6MB95ayfBUfdLi7E5Cyz3+06i+Wv4nzVhFkcDg9E9z/a
   pvAuWXsNvVlifSv2ve+has6U/cT02GgFiQGix2mGL2WXqyMLrjVNN/wvd
   PBC2t+hUpVZCc54F3bSOU+LVgGOwBmOLlA7mp1ouvqzH4k9W4Dp/K5a7F
   TKYuLMY9MCUslk2RoqYBnZufn+llrfy7eqg2sSBm1+IwiYJ2Wte7NYXco
   A==;
X-CSE-ConnectionGUID: N1KuOa8BQauPwbnFoU3IMw==
X-CSE-MsgGUID: SITkk4YfSG6+xlJDoJmbdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="93563014"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="93563014"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 23:45:02 -0800
X-CSE-ConnectionGUID: QeXLdr+nRpisrNdjazcg/w==
X-CSE-MsgGUID: gbVKy6UeRW6dMmv10//IJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="239240338"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 28 Jan 2026 23:44:57 -0800
Date: Thu, 29 Jan 2026 15:26:44 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Chao Gao <chao.gao@intel.com>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
	reinette.chatre@intel.com, ira.weiny@intel.com, kai.huang@intel.com,
	dan.j.williams@intel.com, sagis@google.com, vannapurve@google.com,
	paulmck@kernel.org, nik.borisov@suse.com, zhenzhong.duan@intel.com,
	seanjc@google.com, rick.p.edgecombe@intel.com, kas@kernel.org,
	dave.hansen@linux.intel.com, vishal.l.verma@intel.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 04/26] coco/tdx-host: Introduce a "tdx_host" device
Message-ID: <aXsLtC3Kc+tpD8VQ@yilunxu-OptiPlex-7050>
References: <20260123145645.90444-1-chao.gao@intel.com>
 <20260123145645.90444-5-chao.gao@intel.com>
 <2db22e08-88cd-4873-9645-a2e17af29220@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2db22e08-88cd-4873-9645-a2e17af29220@linux.intel.com>

> > index cb52021912b3..b323b0ae4f82 100644
> > --- a/drivers/virt/coco/Makefile
> > +++ b/drivers/virt/coco/Makefile
> > @@ -6,6 +6,7 @@ obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
> >  obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
> >  obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
> >  obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
> > +obj-$(CONFIG_INTEL_TDX_HOST)	+= tdx-host/
> 
> IIUC, the folder name "tdx-host" here stands for TDX host services?

Yes. But I think it is fine here to express "seach into the folder if
dependency meets".

For this patch,

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>

> Should it use CONFIG_TDX_HOST_SERVICES here?
