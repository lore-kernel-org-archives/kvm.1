Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081544A0136;
	Wed, 14 Oct 2026 07:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791963875; cv=none; b=TaKMMGOI5cUWBAmjuuH++dMm+8jx/l4ZvXMFh7mJdXK2ZU/AZEmcJ2rPpIm2xXS5CztO1/m0j2JYNl2/qrb+YwXcRpbm4aAmX7r+iTNGBjGxqo7Zj+BMu1VpJ1taNEG4qnyS836zmNPpmQftKztY+ucGtTIq5pL2I9qioOgrWjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791963875; c=relaxed/simple;
	bh=+Zy+y70H3jMJgR6No8Rvd4FUGeBZMlrXUPLiCqrh8SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzNiBQ5CK8e5A8QF+il8vDR2/ulwp6Cuox5+BPcElOo6K1ZvQVUdhdnIspZe2W+5gxO9EZfrjWXRUDVDSOubRBBIP+SW3dmzv2V7sL68do3o5jHb5ACAXYs6Hwhkaz0khyQfKL3Pg5R2mkTYaAMNulGPeL7xbSnLBOZncgEd4U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/9n3oRb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/9n3oRb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791963869; x=1823499869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Zy+y70H3jMJgR6No8Rvd4FUGeBZMlrXUPLiCqrh8SA=;
  b=V/9n3oRb9PILE62u6gdLTJhsIoDC60ZSeh5sUucXun5KyNWKKCo4E9fE
   W+h7a3293GnOY8BlbujvDMFySeWF/INhi1JQDmQvP9d7MkJo56+5tx2h7
   SnE553QZAVWMSp/cIsH8ozoGvUEJq1RV1Rcq4kFyLC8zUSO1aZ2lsLvEF
   FeJqOslKeDSck6hYcrRAK7CczSTc/2dSgH07QqRl4vtUUF4krDTCAGdOn
   ytqawhtm1s/YOldeW7Z/meMG3MaQtYRc4+v65wrivg4cdwkEzSULQUM6U
   5BJZQVLfQoc17iY4A2a3ES/sOXpP434JnGvF/aRqzBOGTKFQwuy7kscLR
   w==;
X-CSE-ConnectionGUID: Ri9fEyLnS4C6PVsfvmUhbQ==
X-CSE-MsgGUID: 7EA9Ti10SliXRYmiWOXnAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="605318"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="605318"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 00:44:28 -0700
X-CSE-ConnectionGUID: /h6iyytVQCmk4cpY+tsOhg==
X-CSE-MsgGUID: 9qHd+vhyRoqd2FH67Ap1cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1337931"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa002.jf.intel.com with ESMTP; 14 Oct 2026 00:44:25 -0700
Date: Wed, 14 Oct 2026 15:40:24 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	kvm@vger.kernel.org, binbin.wu@linux.intel.com,
	tony.lindgren@linux.intel.com, rick.p.edgecombe@intel.com,
	nik.borisov@suse.com, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH v4 03/10] x86/virt/tdx: Convert the features metadata
 reader
Message-ID: <as8x6IIiB12b4neC@yilunxu-OptiPlex-7050>
References: <20261012094754.27702-1-chao.gao@intel.com>
 <20261012094754.27702-4-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012094754.27702-4-chao.gao@intel.com>

> +static const struct field_mapping features_mappings[] __initconst = {
> +	FIELD_MAP(TDX_FIELD_TDX_FEATURES0, features, tdx_features0),
> +};
> +

[...]

> +/* Class "TDX Module Info" */
> +#define TDX_FIELD_TDX_FEATURES0			0x0A00000300000008ULL

mm.. the SPEC defines the class as "TDX Module Info" but Linux defines
it "features". mm.. it's OK, we shouldn't churn the code that use the
features class.

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
