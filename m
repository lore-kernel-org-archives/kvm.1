Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99923BED71;
	Mon, 23 Mar 2026 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285812; cv=none; b=rGjZAN2dlLksjXd2BJDHv1SVFdAerawrzt0LVlxkt/CNG9dlDF2BhS+bsMK1uUjFwkO/0SKBz6qNQapkzJ8xq/GB2XVsL+ElKk7a9ewY7VFeD2ZrimPDlUGmQHmCJ3Iu2VufxZDxVa6+LwYCEGCgvRU57zHF7QoAeNdZdPgyWTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285812; c=relaxed/simple;
	bh=BToZ9MXF18tUkB2EdKwBI+YzBkjfXFqtZ+G55rMzQsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+Ee7Tzi632LJHe2Xah5jP5tfGNJfrw/d/vjKOZj9kA9X4aOUoKUG1/5Xfrsgx2Tp792sYxTmQ82sGbUY6T7Ka3d5lLsb4oaAnES3tcLgw889DZ10qKQjTGqLnKLGupxBD87lwNE1Hrt7Fh3vgc+Tq6CGSnsjo4sKjQdfZ5gXTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wib+0mNP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wib+0mNP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774285811; x=1805821811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BToZ9MXF18tUkB2EdKwBI+YzBkjfXFqtZ+G55rMzQsI=;
  b=Wib+0mNPN8B4ec++jHByyqlq3uz1aFcNDFGoL3kR2rGz9CvM8I6oa4gd
   UKx44Q5ufQOQoknuqeM8ImFZj0wPsoPXIpoVoa9ufX+gCwayZKgXYVn3X
   I931qdxIIZcgxd94q2ju2oNG4Oxxihqs2eyKpXsaT5oQ2/3itzJQkonMX
   fyFNKxBMZgdGDooMhfdujCXO0EoJa+NxoLgNDAxsC+fsTR9Np6trKb4pq
   9ENNsO2BPuJidp1cGGlN85QDkTsh1XTFzSG5gWFNLXRMJSbYw7zRXGmVj
   nWGcLTttIoLxmjQ/B3ymCOhT7UcX9ix1EV7QcXatCQYsF2hM4EVGHzsVv
   Q==;
X-CSE-ConnectionGUID: S43Z/3jOReW0jhMXIkOKuA==
X-CSE-MsgGUID: Is97GuRuT+KM1+XJmJpBIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="74310363"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="74310363"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 10:10:10 -0700
X-CSE-ConnectionGUID: iRwRvSTTRlOfwVCK0oFJqQ==
X-CSE-MsgGUID: 09IKz0B0SaGKNbQfiUiUtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="228820409"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 10:10:07 -0700
Date: Mon, 23 Mar 2026 19:10:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	WANG Xuerui <kernel@xen0n.name>, Yury Norov <yury.norov@gmail.com>,
	David Howells <dhowells@redhat.com>, kvm@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH] lib: count_zeros: unify count_{leading,trailing}_zeros()
Message-ID: <acFz7bEUchB2Arx7@ashevche-desk.local>
References: <20260323170032.109858-1-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323170032.109858-1-ynorov@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 23, 2026 at 01:00:32PM -0400, Yury Norov wrote:
> The 'leading' helper returns BITS_PER_LONG if x == 0, while 'trailing'
> one returns COUNT_TRAILING_ZEROS_0, which turns to be -1.
> 
> None of the current users explicitly check the returned value for
> COUNT_TRAILING_ZEROS_0, except the loongarch, which tests implicitly
> for the '>= 0'.
> 
> So, align count_trailing_zeros() with the count_leading_zeros(), and
> simplify the loongarch handling.

Makes sense,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


