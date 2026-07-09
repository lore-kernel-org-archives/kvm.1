Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40827405C5F;
	Thu,  9 Jul 2026 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593134; cv=none; b=HPXmHhJuFqCbVipwvqHJXkY1TkDz0qHBR2iUti5SSIIvw/OFdFHMQtCkJ2gxudLzafbeCa4b5Z4L+joZ7yhN6VfCsLfFbL5E74t9wBqIKh/WAgtPF08hp1VuXUJpVh5T0BETR9YWt55YqgJd9NkoWWeZmjRuHkI25GMrsc4zru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593134; c=relaxed/simple;
	bh=wa47m20KhvlwQv1JjdWNpfdD1a2wtEqJBBh1snWDgiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gjf4iUHs60C5oPPstTeipNcBfc+4lCpLQuv+34XoA7TpAGDK2YxvI9H0SBLO1i61BLhaONMX4b1qfY+pcd8PpcdWu28mMeaUkYnfXP+mPVNs9+cKlcEPf+y1NmSKoKGXEYTUlcuRW1+UK96O0NoLTwu8M0mOMG3xD4z+8NoXcS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OlAbl1S8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OlAbl1S8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783593132; x=1815129132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wa47m20KhvlwQv1JjdWNpfdD1a2wtEqJBBh1snWDgiY=;
  b=OlAbl1S8g7nq24DGygQnztLrDF9XN6fE+Zl5d9WmZlXeeK4Ja3djlb2w
   0FA1fYn9sOfHtEexqJEeUWqk+UHs92KyZ7SGJxZ4tsjkU4VXKHIF33E4d
   CezXKWKNEn1gvSka3jgfT2Ws9jJBH12OvQn+Vqaa0n9O5WfUNS+Z2oemF
   1R7iUwIG//clw/CCNFugMqJ/rlFuzYY/0OeyRJkf4EMawDn5pQZMLGer9
   jETZ6yN13mLoaWD92rH+yRwOHRwqnAJoaFSWFiVcgKJWmcHrZLSDl4GMj
   XnuDgf6O9RBMiiTAnIgl25/ryVF6HMU4RVPezPOFvOiZBH1/0teCSCWjQ
   A==;
X-CSE-ConnectionGUID: 5LM0sFzASZaloULm+UvBuA==
X-CSE-MsgGUID: QUiSI97PRcakqezI6Kahcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84148774"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84148774"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 03:32:11 -0700
X-CSE-ConnectionGUID: xsTtvBPvQMmmNCrC/5O9XQ==
X-CSE-MsgGUID: stqpUXT2SVezy8urTKOdzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="256468875"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.39])
  by fmviesa004.fm.intel.com with ESMTP; 09 Jul 2026 03:32:10 -0700
Date: Thu, 9 Jul 2026 19:00:44 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com,
	seanjc@google.com, Binbin Wu <binbin.wu@linux.intel.com>
Subject: Re: [PATCH] KVM: x86: Remove AMX-TF32 enumeration
Message-ID: <ak9/XEGJhm+sViKH@intel.com>
References: <20260708210118.402005-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708210118.402005-1-chang.seok.bae@intel.com>

On Wed, Jul 08, 2026 at 09:01:18PM +0000, Chang S. Bae wrote:
> Date: Wed, 8 Jul 2026 21:01:18 +0000
> From: "Chang S. Bae" <chang.seok.bae@intel.com>
> Subject: [PATCH] KVM: x86: Remove AMX-TF32 enumeration
> X-Mailer: git-send-email 2.51.0
> 
> AMX-TF32 enumeration was added based on the Intel documentation [1]. The
> recent update removed the feature, indicating that the feature is no
> longer planned for hardware implementation.
> 
> [1] Intel Architecture Instruction Set Extensions and Future Features
> 
> Cc: Zhao Liu <zhao1.liu@intel.com>
> Cc: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> ---
> Note: The feature first appeared in the September 2025 revision of the
> document and was removed in the June 2026 revision.
> ---
>  arch/x86/kvm/cpuid.c         | 1 -
>  arch/x86/kvm/reverse_cpuid.h | 1 -
>  2 files changed, 2 deletions(-)

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Thanks,
Zhao

