Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC36156661;
	Wed, 19 Aug 2026 00:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787098360; cv=none; b=qLYbCvc1786p20gFnnqAiJZW8s1EmIOtT5ZPhu/4HOUIbmMQ8mO95lb8Q2As30/xHUA9tEGjX9z/4sAmSZmOUezlvmQa03VeMWHJp7EolhfBN3KB5uflTMSkf5xe73LSSCE/Lh31EVV1SbIsfFgBzqB4bJr7rZ7CizA/JwH0mP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787098360; c=relaxed/simple;
	bh=NOtz/KMbFUOZnL2zFwNMJiagHyVuxrIY25pMuh/YSns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXO+XSan4WEbUBILzePRdWz4lSfNJDz89LAVK62FOrkkwScz6NNRdFovbMz0pXTccp019bd4cyncA7UPaasDFGXOWFt2EEh+pz78CKrEsI7fgsBnrBhORvKe4Up++pHOD1rolI0QBXMZz7zkHC8/ufoMy/OQ9TpMCDCFPP96tN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVZCwXLZ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVZCwXLZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787098355; x=1818634355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NOtz/KMbFUOZnL2zFwNMJiagHyVuxrIY25pMuh/YSns=;
  b=TVZCwXLZstJ0B4SAj9P7l2WOIc1xIFDG9osx2tKXNj60VofE/ubABXQW
   tUn9gnkLgDpsjlIZzoH6SUeGTSUThD6MpV2PaQJzw/f1UyipHugUqezdC
   chd1fJi6gbiHqpVwxVA6geDd+0hJUbhA2WgQm3mXAYVlgzI2mGNLAZU1b
   Tesev+8qOSC8QMH7xBPcOReHRIytPl8JLu94wLddBexkUlaxnwnqLB5xo
   gD2YA8di/9XaWLY7sS2SJfmJeyHjYYydT1z5kxTRgkqYYzTEqe0JUSoeq
   24v0IMsoF8ofFXx5WWpHuLrN/r3ZhZsNZGhkK0tfmR4cQzPtYMTx3DSX7
   Q==;
X-CSE-ConnectionGUID: h71kt4UgTlCmnzUcOu+FbQ==
X-CSE-MsgGUID: NHTQ2foITmS4LZmduCPnxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="98964352"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="98964352"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 17:12:34 -0700
X-CSE-ConnectionGUID: NQ5jcHAlSDeAZCVqqcJctw==
X-CSE-MsgGUID: ST3vxh7OSMa4q2ytbb/zEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="261165807"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 17:12:33 -0700
Date: Tue, 18 Aug 2026 17:12:26 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Kim Phillips <kim.phillips@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, x86@kernel.org, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, 
	David Kaplan <david.kaplan@amd.com>, Dave Hansen <dave.hansen@linux.intel.com>, stable@kernel.org, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 02/10] cpu/bugs: Allow forcing Automatic IBRS with SNP
 active using spectre_v2=eibrs
Message-ID: <lctyimdlenyb5kvfxarzajs2ggzkwn4yehxu233lojynqwa7ej@wjur3lh6szlr>
References: <20260804235611.4053375-1-kim.phillips@amd.com>
 <20260804235611.4053375-3-kim.phillips@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804235611.4053375-3-kim.phillips@amd.com>

On Tue, Aug 04, 2026 at 06:56:03PM -0500, Kim Phillips wrote:
...
> @@ -2192,7 +2193,12 @@ static void __init spectre_v2_select_mitigation(void)
>  			break;
>  		fallthrough;
>  	case SPECTRE_V2_CMD_FORCE:
> -		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
> +		/*
> +		 * Don't use AutoIBRS when SNP is enabled because it degrades
> +		 * host userspace indirect branch performance.
> +		 */
> +		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED) &&
> +		    !boot_cpu_has(X86_FEATURE_SEV_SNP)) {
>  			spectre_v2_enabled = SPECTRE_V2_EIBRS;
>  			break;
>  		}

Can we also account for retpoline availability here? If both SNP and
retpoline are available, then only avoid AutoIBRS:

          case SPECTRE_V2_CMD_FORCE:
                  /*
                   * Prefer retpoline when SNP is enabled because Auto-IBRS
                   * degrades host userspace indirect branch performance.
                   */
                  if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED) &&
                     !(boot_cpu_has(X86_FEATURE_SEV_SNP) &&
                       IS_ENABLED(CONFIG_MITIGATION_RETPOLINE))) {
                          spectre_v2_enabled = SPECTRE_V2_EIBRS;
                          break;
                  }

With this, patch 1 & 3 can be omitted. Also avoids the ping pong: we don't
want AutoIBRS -> We don't have retpoline -> Lets have AutoIBRS.
