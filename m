Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891B754763;
	Thu,  3 Sep 2026 06:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788415563; cv=none; b=HwH8C0+DFfyDhFdfmaUxROVI+zW67En7Zy765jg17hmqL9DAF/9lXTLgLELcVsuTOwm+gD2XDz/i837Q+EAyn/skgBlimahYaBpLSeuOdTyU7IX0kXSqx2o08pkJn90z4Oe8Qbc6PGXKbpuTYnjtOUwiLUO5n4p/y4pzgIEOqis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788415563; c=relaxed/simple;
	bh=B70DJXAyrZs3n8KEV4Ve18c1Zr60DkbgGI/KipnMe8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqX1l4wgPDHXBZkG0SKccPM9ZVprzxEVCMHam6iAjYO0qXl6qjY2Ant+sIxDQXeD9E7JEO03+QVjV003XcuX7a5eWZ6JVO1sQVcpNFMSUcSBMUoX1gBnf7DkgtPiHhWF2dfV7UO9P8R2odsc1IsbWvw6isRbQkzI5EkzIwJkuhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W6Uxi8RB; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6Uxi8RB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788415562; x=1819951562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B70DJXAyrZs3n8KEV4Ve18c1Zr60DkbgGI/KipnMe8U=;
  b=W6Uxi8RBxzsk1HKOZrcN8jxh40VRQP9206D5Pckx/X78SCt+2Rfj4Uwk
   eTvwonyUYUn4JWBJ2ble/a7ptgvuAIxx3YXLYzQ4NF2NbhJeoPO+KK4w8
   DWk2m89HNc7FFvz/uKptQ2kwQ0aFdaVZus958kSevt0hSWq5PjWfGP9ra
   08jO9LhdTRgsi98QoI2+WeFOB5eIq26gy5zQyVNgUkM22fWHrd5GbWf3j
   3+mfMh1LpSjp7KSq5PF+BLh+sy/MdcoItVrXppnEPup8sj4ZLyT/yH4lj
   8smv8VnZHfRAj888Oe+CdgTnFOkV6n5PAjrqHN8YIim8IUOovh+HTDr8O
   A==;
X-CSE-ConnectionGUID: EyhBohLpQQ2chFqSwM0d7A==
X-CSE-MsgGUID: x1rSfBuZTwO81a5P7OczDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="99483706"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="99483706"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:06:01 -0700
X-CSE-ConnectionGUID: UwGkrInBSUq2k7MaOXY8bQ==
X-CSE-MsgGUID: ir/k+9IvS4yDnkpFJvHuOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="266372074"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.231])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:05:56 -0700
Date: Thu, 3 Sep 2026 09:05:53 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Peter Fang <peter.fang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 2/4] virt: tdx-guest: Calculate the Quote buffer size
 safely
Message-ID: <apkOQTgC8B8qlDl8@tlindgre-MOBL1>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-3-peter.fang@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729122939.1340412-3-peter.fang@intel.com>

On Wed, Jul 29, 2026 at 05:29:32AM -0700, Peter Fang wrote:
> struct tdx_quote_buf has a trailing flexible array member.
> struct_size_t() calculates the size of this kind of struct safely. It
> handles overflow, which is an important property since the Quote size
> comes from the host.
> 
> Use it in place of the fixed length limit.

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
