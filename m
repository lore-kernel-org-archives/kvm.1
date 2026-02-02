Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822D730C602;
	Mon,  2 Feb 2026 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770019212; cv=none; b=FhRdbX9Yvz47FVAGCBN2L3TqJ40b4SOi4SQKfnENZ+aExi8P4rFcS8BW8dM0agOP9l0X8AhAg4/Xs/NrhQ5x1pxFFJFtMgkwjr9u4FkDYhEUruVNLAmMwSLEBF7mLbcgnK5Ug1Q7MSo+XZ5vE9f9i/YD9YSVpWX3TIhpL0EQR6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770019212; c=relaxed/simple;
	bh=uBMm2McQFatFgElvqm685Z9lZQRSZ8qPPbAds2y6Rj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDZqAI9c+EK9zpq+PeqEu9V2F8SBt/GQhFJPG4K1gaoH7xkqpQG2YYyrh4i2rcoNC18fvULObURUz1VjUFczWvO/+2j7y96iVR9dYRhmSynnhHRmBIKktYNqKNiH8sZPBQyqLIfRa7hDhIc0uiA5ppknm+hkOUqm5w7od7OZg0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aeVg3QnH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aeVg3QnH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770019211; x=1801555211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uBMm2McQFatFgElvqm685Z9lZQRSZ8qPPbAds2y6Rj0=;
  b=aeVg3QnHamCcfQ0rQ6QaO32m+QxamgqbyjfydaqFT1KsQe2CC7WD42eC
   NpAoqLQRzGN5eR0fQQAS5/TycHin6Hbokj6k47lTKl8JCNyHuSl7TlFOh
   z8hldCFBCEQwlejdho8QyaIVLNgWYjCnPuHnD2Y5HDT7kUXRY6PDTDYDu
   PlLXu9YpscRi7IvzwtCjnFiSLqFEoFUs5imiS2gPO41NKAtSLafd97edG
   l0W/EOz38eYryDKXLrvLBQoC/ItDVYkaR8203CpUzU7r5dPgprYtalE8q
   4gvf8BrasCdCaGgYKy8dQxiWyz5lpAVgn9l9AxYQa/gLYeoCdmgSYHIoq
   Q==;
X-CSE-ConnectionGUID: 3pUyEDL7Tna06I5CUrO7Hw==
X-CSE-MsgGUID: JTGgUqYoQ8qp0gUCqVucWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="75030764"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="75030764"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 00:00:11 -0800
X-CSE-ConnectionGUID: +ob4ptaGQ9iUkhLFD7Zoqw==
X-CSE-MsgGUID: gdWEx/BQQMmb3ogn0KlJHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="209744335"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 02 Feb 2026 00:00:06 -0800
Date: Mon, 2 Feb 2026 15:41:42 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, x86@kernel.org, reinette.chatre@intel.com,
	ira.weiny@intel.com, kai.huang@intel.com, dan.j.williams@intel.com,
	sagis@google.com, vannapurve@google.com, paulmck@kernel.org,
	nik.borisov@suse.com, zhenzhong.duan@intel.com, seanjc@google.com,
	rick.p.edgecombe@intel.com, kas@kernel.org,
	dave.hansen@linux.intel.com, vishal.l.verma@intel.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 23/26] x86/virt/tdx: Enable TDX Module runtime updates
Message-ID: <aYBVNiZIdhgX6IdF@yilunxu-OptiPlex-7050>
References: <20260123145645.90444-1-chao.gao@intel.com>
 <20260123145645.90444-24-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123145645.90444-24-chao.gao@intel.com>

>  static inline bool tdx_supports_runtime_update(const struct tdx_sys_info *sysinfo)
>  {
> -	return false; /* To be enabled when kernel is ready */
> +	return sysinfo->features.tdx_features0 & TDX_FEATURES0_TD_PRESERVING;

Frankly speak, I don't know why we need endless one-line wrappers like
this, we've already exposed all details of the tdx_sys_info to its
users.

But I'm still OK with them.

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
