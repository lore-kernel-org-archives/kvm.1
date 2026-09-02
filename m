Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D76B43FD21
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344263; cv=none; b=YzVc+uERCs9/pPZOFyMAed/XLwQBRQCv538yuSAe4vHnIyJdKhkLs5v2j0UaLsEIRamfH+R1KV2T6u8YrXspgzR6agA2VsmWdUwqlIulSY+t+lpLkYmwDJo7sc0JeS7Mw6oT7Bqa3m8OmPGEXqFoyGkdiKVuc/OuJ9D0GzSdTiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344263; c=relaxed/simple;
	bh=GCVIbj/xGTDDwwWNAXoxHETUZ7Pnrwff7qXe4oPkzz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LejCDrVgrkYjc8bk8B8t+sGdxc6OjQzPfVTqQGmno8Gf9anXi0V23ontq1/UD9IfqLlqUGIEeyHhm/r7YGi3NGZirjSCXvEKPZFaw3WhD0tlG7vK6qHOiGbjgjGNYpB8KQdyvqaJYzzYJ6UrWKKBbIdr7YtqAIYmSNzn9sp4IMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JmqF2TB5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JmqF2TB5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788344261; x=1819880261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GCVIbj/xGTDDwwWNAXoxHETUZ7Pnrwff7qXe4oPkzz8=;
  b=JmqF2TB5RUmlxD8liHWNMLzsKcf8+VHheebKDcbPiHqEevbINAB45MAl
   pK1Brz8Rf131pjJOIE/xsJMHu35X4X5lgqdRB/NoebNUDkhd7Nt+qhibT
   /7gADbtfTowx97a9jH3QdMy01E/PjIuNSorjvxnUredwnSbxw0Ii72o1g
   rDIeYBhcBFofY9uLgA3JtT9sGWCIX5g/LMPuCZkf7WlmKAPmchMMonoTA
   g+b20ZWvM7XktZmPhekvjJstJHI9lArSgnIFPVYgVdKc4RhckXnkbSS8D
   M5XuGw8an/R7QUUNmfKJ3+1K7yEkNlaCYWHtZ0JCfp3WJztTwDoVwfLM2
   Q==;
X-CSE-ConnectionGUID: G3vbJj09R2uv2vsZu4DF1g==
X-CSE-MsgGUID: +QxXMnAoQIynEsMz2aUDTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="92498030"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="92498030"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 03:17:40 -0700
X-CSE-ConnectionGUID: 2sY2uzNYRGC6CT6l21mO0g==
X-CSE-MsgGUID: wVNOpjzmRfSicel8/s4p+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="268066684"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by orviesa010.jf.intel.com with ESMTP; 02 Sep 2026 03:17:39 -0700
Date: Wed, 2 Sep 2026 18:17:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kvm@vger.kernel.org,
	sohil.mehta@intel.com, xiaoyao.li@intel.com,
	binbin.wu@linux.intel.com, farrah.chen@intel.com
Subject: Re: [PATCH 5/5] target/i386: Introduce ClearwaterForest-v5 to enable
 LASS
Message-ID: <apf3wqxIIFujdezs@intel.com>
References: <20260826035734.114685-1-kishen.maloor@intel.com>
 <20260826035734.114685-6-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826035734.114685-6-kishen.maloor@intel.com>

On Tue, Aug 25, 2026 at 08:57:34PM -0700, Kishen Maloor wrote:
> Date: Tue, 25 Aug 2026 20:57:34 -0700
> From: Kishen Maloor <kishen.maloor@intel.com>
> Subject: [PATCH 5/5] target/i386: Introduce ClearwaterForest-v5 to enable
>  LASS
> X-Mailer: git-send-email 2.47.1
> 
> Add ClearwaterForest-v5 to expose Linear Address Space Separation (LASS)
> on the ClearwaterForest CPU model.
> 
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  target/i386/cpu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

