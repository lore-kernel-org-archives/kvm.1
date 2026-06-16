Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AE326738C;
	Tue, 16 Jun 2026 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592625; cv=none; b=XPqhvSjW7xsWEY1Tm82NZYK73udObz9ZKSxbMxPkGfKYEYFMBxmWTw0e5XGmWK/5yvN1ar1yxyhJQT90fhsIvULYXcrzdvu/UUDIgNw33tyd0Hv+LBfxgVn8SUAayY3X6x5w6LRsZ+O/9VDpEsldDRN1F9ZL/q1aM08OFmbxUFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592625; c=relaxed/simple;
	bh=8LzAl9/bUk1HogOilVA79aNZ0POYFNbdeAu35IKJDWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5Vne+WMTFYA5H1OBPm5VHRBMw5xrea6E9EVEYCYbbm3LNF1CHKP4u+0K9/FINC5GQ5HkMquW2NPCuG1D2C82v//mXLAYWhWcf7tPRCKe5bIrig524xY0WSz6DC9B/NxV3GgNbuzQtzIluE94ZYILUB2pfZGjZ+4yXJVTVpxShc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZPDx20eD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPDx20eD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781592624; x=1813128624;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8LzAl9/bUk1HogOilVA79aNZ0POYFNbdeAu35IKJDWA=;
  b=ZPDx20eD5Jvmi+3aALWRQj91bw+VoQBTaA/tP72gVOTUdNxl70sQFVot
   vl1w7TkMLrrNhtFnU1cR9q2p5/ibzqMFuxP+yDYF2xtkJ2nD35+u8y9iu
   a55XMa7ygi5BUqTZoKL6B2AuRBC3gO8BQ19Wd+JCXEdwkq+aPMT9YfLc2
   Zq+SiXiVllNZPepXeFS0M2ITpPUIXPiknAhi+/C4lEv46h+inlINsxlaT
   6ew7ABzqFNg0yfQgHSIE1PyQ0e0vYJJTeu9y5lMIQ81mMiZlILwUnSeJk
   20RrUQ5DIvF74JFdxzTXW+deiO08P9GMulzCNKr49E+I/M1mJxL2GL3mL
   w==;
X-CSE-ConnectionGUID: QkzBsbJtR5eejjxnvrCw4g==
X-CSE-MsgGUID: dSdOeF4QQPuyzl6RR7j2pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86188414"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="86188414"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 23:50:23 -0700
X-CSE-ConnectionGUID: d0Mxoy0cRPOBxTY/oNcG6Q==
X-CSE-MsgGUID: kv1bljgYSX2SK0rwFbxWUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="271404385"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 23:50:21 -0700
Message-ID: <9f6380b5-2d65-4ba3-8d7e-5c0ba2b1ac1a@linux.intel.com>
Date: Tue, 16 Jun 2026 14:50:19 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/30] KVM: x86: Move __kvm_irq_line_state() from
 kvm_host.h => ioapic.h
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-24-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-24-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Bury __kvm_irq_line_state() in CONFIG_KVM_IOAPIC=y code, as it's only used
> by PIC and I/O APIC code.
> 
> No functional change intended.
> 
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

