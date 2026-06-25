Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176C827AC45;
	Thu, 25 Jun 2026 05:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364766; cv=none; b=LcmknbVkeAKMQwMbhTzg6HWcIweK1XVSdC8MU9Si7wqKGPfOX2wrgntZQ4TaLdGh/P8Eo4WFQjCpXHwzxzk2lBp7v2xl9zOn5H4Bg1+vsJZe7bdBeApMB9m7ZNbTYTdyUJH66Yeh/+T5/yR6DxEq1AYAmwRAMi1xwIa1LicLNsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364766; c=relaxed/simple;
	bh=dd9YkuM2YzsaF4WuicVaxwqdNyWNt74Oh8Mq7k3AR2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/jVycsxEXIlyoeoGy1Q2eXeNS3LgdrhxqryCfOz9bDTKD9oMO0bJP1LK6Ui4h53inX9hw52jw+ldV9weXYeM8xcdMSYanvhzfQ+L8OCDsDI3JRB22nmHRYtJ14N3qOpmil3Vd6K2MZsUq29LXrXkkGLLHxgZWRuTmDT6Zx4Gzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OzlcuY1a; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OzlcuY1a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782364765; x=1813900765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dd9YkuM2YzsaF4WuicVaxwqdNyWNt74Oh8Mq7k3AR2c=;
  b=OzlcuY1acDXOMriXH7IHSt5T3/vvxFeuqw6DOvrlsE1IkVJAPSb4QoLu
   /6wSpH7qnAw7+jsw4zahhJQhXo9Ew/2wngEvyFggOwhHPywNsaT8ZVL50
   qmqJUbYZQAPXX1DI/cOV0/Q/eJJU8kkOP4iTFRLsC1Qe++MUzRu+WDjjz
   m8G1KgFR4loPIdLzMakLkfic1aRei/Ce6v0rKdlSakAv1JOXZ102MXsAk
   sgJ/4pl0cdXfRZmElMEy0z9NzVc7z7Q+WfMmWH/K9qt2AgLemED5LUpEG
   6F6xcwbxcoi9/Hgsysiiux+aV2ZwnHS0Lop9ZHUa3OQUOGuKV9rK/FzHq
   Q==;
X-CSE-ConnectionGUID: fTXHaFiyRUGdMUPUyxdehA==
X-CSE-MsgGUID: +qfMstEzTK2WiZMkFfqpiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="93789065"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="93789065"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 22:19:24 -0700
X-CSE-ConnectionGUID: 8LQhUKjkRY2o1SFF/NwFUA==
X-CSE-MsgGUID: g98MKyAWT/qeqtQN2zZVsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="247252936"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.64])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 22:19:19 -0700
Date: Thu, 25 Jun 2026 08:19:16 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, djbw@kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	peter.fang@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, dave.hansen@intel.com,
	dave.hansen@linux.intel.com, seanjc@google.com
Subject: Re: [PATCH v2 03/17] x86/virt/tdx: Detect if the extensions
 initialization is required
Message-ID: <ajy6VMlPK08K7kIT@tlindgre-MOBL1>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-4-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618081355.3253581-4-yilun.xu@linux.intel.com>

On Thu, Jun 18, 2026 at 04:13:41PM +0800, Xu Yilun wrote:
> TDX module extensions support extension SEAMCALLs that are preemptible
> and resumable, unlike normal SEAMCALLs that run to completion while
> monopolizing the CPU. This allows for higher-level API constructions,
> so better supports some add-on features that implement higher order
> security protocols.

How about "TDX module extension SEAMCALLs are preemptible and resumable..."
above to make it easier to read?

Other than that:

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
