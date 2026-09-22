Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279E44CCDCC;
	Tue, 22 Sep 2026 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790060971; cv=none; b=VcQpTIeeQrrcKbdACN7avr5IPzuxjqtYv4WehoxhX/Lyu6CkCYB+ovVXI1LiqBLKmDuB1/PFrwKDzsjMF4Beaq1w4QicB7unsJrTkIszvhE0+6n9RONDyf9CoybjQUdhpzlmsX6Kg0swhHL+Su5MOMrg13bzWM7TAN2xCtFY/Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790060971; c=relaxed/simple;
	bh=JpYEmE0aMvyKGA4ffids0WBnSVA1EemEfo95puLGQaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2o2qFHeT2XgdteUQbxD6ovKflH+FAlkdmixetDOB6L6fKD9PP9IrWcROHhOeC9Yq8Lb2nQBikBKx0JF+NVEMkF6if61AfV5tNcrXMTBHiNuV+WOYYvOhijRNgcsKkENJoU9rcRSf3D5M16v1tzxaOcZZ3xUhB+hfhfWoimqSkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EO48EpZ+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EO48EpZ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790060968; x=1821596968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JpYEmE0aMvyKGA4ffids0WBnSVA1EemEfo95puLGQaw=;
  b=EO48EpZ+vdniUXOd4a/6dW3xptYsVMevB3c889688A7WGA6ephpLflNA
   46twZ+QNA/BSa0IDjPAWiuX6I7LJc5DjJO8zXVDUThs6JKWSy+sJC70lX
   qZ42TY+HZS0uHP5mCOnCt+om+9HRZqHuHwTgt+tXvci7HID3VN8cPB8GD
   b6f5LQ2AcesLGnAPwjstwfW+4Gl4fmSvgvjT/m3KaD5KHs8RBOjJhNm+y
   b+2qgpmmlS/1Vak4vtnzeQ+J8zw8lIIWu8nwL9NJZU0t6GABkNuI7fArn
   9IX2lbvkFR1PcB65xFLzrEaEebRZ6wLyrQif7mLm5xF3QXqxIUGCHnNkV
   A==;
X-CSE-ConnectionGUID: Gwl0BLhRRU6Tnqr1/yRhgQ==
X-CSE-MsgGUID: RrMnkNtpQted7lwE7F6n+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="116158938"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="116158938"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 00:09:27 -0700
X-CSE-ConnectionGUID: NlXRbrpDT1e3IPlS8R5VsA==
X-CSE-MsgGUID: wSic7CzwT8Sz6Pfc2YERDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="4313983"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.202])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 00:09:21 -0700
Date: Tue, 22 Sep 2026 10:09:17 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	peter.fang@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, chao.gao@intel.com,
	artem.bityutskiy@linux.intel.com, kvm@vger.kernel.org,
	nik.borisov@suse.com
Subject: Re: [PATCH v2 1/5] x86/virt/tdx: Move TDH.SYS.CONFIG operations into
 a wrapper
Message-ID: <arIpnQEx0ULfqvem@tlindgre-MOBL1>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
 <20260915102658.713079-2-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915102658.713079-2-yilun.xu@linux.intel.com>

On Tue, Sep 15, 2026 at 06:26:54PM +0800, Xu Yilun wrote:
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -998,11 +998,33 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
>  	return ret;
>  }
>  
> +/*
> + * This is an array of HPAs, each points to a TDMR_INFO data structure (see
> + * struct tdmr_info).
> + *
> + * It is the in-memory ABI that the kernel passes to the TDX module to specify
> + * the ranges of TD Memory Regions (TDMRs) and their associated PAMT memory.
> + */
> +struct tdmr_info_pa_array {
> +	DECLARE_FLEX_ARRAY(u64, phys);
> +};

I think you can simplify the comments above a bit, how about:

TDX module in-memory ABI to specify the TD Memory Regions (TDMRs) and their
associated PAMT memory. An array of HPAs. Each element points to a TDMR_INFO,
see struct tdmr_info.

Other than that:

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
