Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2939F439F68
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344221; cv=none; b=nlGFcEnEyK1wCH0RLeJY7rEdnfPRKkkook2G2iYkkSYx3H5Q1ShFVNXlsUvkrEs3u7drf6SQtmsQHa7cfLJH3ASmYub7fNtSQtkOXvELMV+/80f6z6O5AI5MY1vVafR8QMnt2cqZHr3nqd7sntEGuTeJuvLaOz+UjMhjNuEZgMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344221; c=relaxed/simple;
	bh=3mrv0SmyYUtoltFxvjBhfe7xLwtnV6flfTfcqh42GSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+isau6Yv76xK4Ond9cd5U0YmILz+tEnrEpnZ/o3obZISefBmrHopqwY5AqTRwG7Z2mNa1+lXhz3ypy2uCPxFfXwkICORCW/9qoODyhM7UoYROE3JSOQ2MrTNs8dLj7AF+fgZvnzf3Fxxz83euxZTC919NS9jdCfZJG5O8nLTPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iaeeOjtZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iaeeOjtZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788344220; x=1819880220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3mrv0SmyYUtoltFxvjBhfe7xLwtnV6flfTfcqh42GSU=;
  b=iaeeOjtZqGHlknU9EHSUuVgbI2ivsajoSJt+sXX/LLli+ScskptIfFej
   qniMXRbbhR/bf4qwI15Itqt7WPsDks8qwzaGMiRFGNoR+UCS6czHnMES6
   6tY0f9riooFgschiSSxPhTV7JxIx7Cw0V/gUFU4mHLXLUni2c2VlP8pMm
   uevf41YDXR4Ro+KUqTXiYKZxtgj9YdDHwQqmOIqc+VuJNn1yMVIvwBSFo
   HNnTCPhmZXRP/y75zxGiF3B9BvyFm4iafejZEfBXdF5eat+SeeXtoZPvQ
   AnZ+HiUTIkl7UmpzipzVtBGbvkvxMUoxqJe8QF+ColjKp38ut4stkUAEK
   Q==;
X-CSE-ConnectionGUID: u3XMSymVQrWE7nYA3GK71Q==
X-CSE-MsgGUID: zOcIMJj7TSKl50P+Wojd8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="92665440"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="92665440"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 03:16:59 -0700
X-CSE-ConnectionGUID: t/pH+jfMTL2PjaZjo2fAzw==
X-CSE-MsgGUID: DaKkfQlmT4akNzePE8UKBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="274623550"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by fmviesa005.fm.intel.com with ESMTP; 02 Sep 2026 03:16:57 -0700
Date: Wed, 2 Sep 2026 18:16:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kvm@vger.kernel.org,
	sohil.mehta@intel.com, xiaoyao.li@intel.com,
	binbin.wu@linux.intel.com, farrah.chen@intel.com
Subject: Re: [PATCH 3/5] target/i386: Introduce DiamondRapids-v3 to enable
 LASS
Message-ID: <apf3mEv1+8uSgukX@intel.com>
References: <20260826035734.114685-1-kishen.maloor@intel.com>
 <20260826035734.114685-4-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826035734.114685-4-kishen.maloor@intel.com>

On Tue, Aug 25, 2026 at 08:57:32PM -0700, Kishen Maloor wrote:
> Date: Tue, 25 Aug 2026 20:57:32 -0700
> From: Kishen Maloor <kishen.maloor@intel.com>
> Subject: [PATCH 3/5] target/i386: Introduce DiamondRapids-v3 to enable LASS
> X-Mailer: git-send-email 2.47.1
> 
> Add DiamondRapids-v3 to expose Linear Address Space Separation (LASS)
> on the DiamondRapids CPU model.
> 
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  target/i386/cpu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

