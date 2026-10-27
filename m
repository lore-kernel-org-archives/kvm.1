Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793095679;
	b=Cy4y7t1KFzuFcqyf051anHseQBNwE4/h1MYwPBIXAfyCdh3HRY9CJirJ2b0xjD1GG6aA
	 flvdjk0KyTpVsTjxN2hEgZLs/CoMyUAS1ojEFt+cDlux2LLy/deI5i2hS8tvPDtocS4aP
	 T/EbxaatmL8bCJvUt4CcGsxrzNv7vxnftIxuOv7+UoqMfQYTA2FyfFhbZOAoL1Y5w74jz
	 GZA35vHzLdVH/naqdTntjKNWU1qdqKvIODZ8lgVYqjestnnwlztb+AWWT7DWJy6j+Wwbc
	 49H2CQn1lqmVjsb9YwMSkp/1W0GDsats9dLyDZ07d0Ehh6w4/dlmYbYMVqs45bFx4xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793095679;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Fy1/w0tKCkDMHDFcbllgMw30STzvQwiUbpmEywxPMxE=;
	b=1VTAJ9qrRXPp6Ebz8XyfdyCg9YxHeDJllv1MJBaf0fBvD73CRM+VyrvSXWEdLrUbcmx8
	 nZk8EjCJMHiEuWsNzWm7+/L46LmF0fPSVM60v5K0gz/0AksKI+1Ddi67WiY7rgAEKq0mF
	 hHkVYM8drHtVMIYE6p8LAOg4+hH3XDsTyt+Fc79Skuz0omHf7U10d+73HVYSfvBJzDAFV
	 QbsS//+Qdv0jk6taEMdopisz04nsnajncEShNzwtRlNLB7Z9n7G4M3tf86ruLCaoZd243
	 1q5byTYbvLfPvzqN8tUmHosF8vBSstRm3DON+nqvFZU6MRLnvEuPnuOiQrplkA7TeQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ayw1f5Ok;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14E6606A31B;
	Tue, 27 Oct 2026 10:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C14E6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ayw1f5Ok
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793095679; x=1824631679;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gs69Hr8NaS2oi94sSYiW5CguYSbtSLpu1VvGRgcWZZU=;
  b=ayw1f5OkLZXXoyqt7hy13F9uCOtmDE838VFRrbRFOYv7t4kkZTX8fq3a
   4+eUUdlRW3m3acFIyLGEGkCeTiGV2j+7YruRifLUYn4yja5qpi1F71udm
   bOI0wc+YLQQnxt2zNx4+C8Bntyq1gLf/BNaiKDkTpx1pbWKh2E5JKRN1i
   2/EP4ZdAftj5SX1DKaivqm2fHaPbuXy8DJtOs8u3ItVzhfRXq7u4UCWdI
   myz55jVnU78XTyOwd0UzfqldY0W95gmwOhuYkdnmU08RxTR7l5JueVlwI
   OEQpaCVZoE/eMY9tZiG+nZHveEFwyvwalLjDInagaKRgPxWZtrzlLLVYm
   A==;
X-CSE-ConnectionGUID: 3PiMS/WqQPu2AhvcKT+3Vg==
X-CSE-MsgGUID: TJMgILwcSguBSsKo04553g==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1672949"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1672949"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 03:07:58 -0700
X-CSE-ConnectionGUID: lj3Az8n5RaypGRDzE2NWfA==
X-CSE-MsgGUID: Aw7ZFwKVS6ysJa7lefFcnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4653034"
Received: from unknown (HELO [10.238.2.205]) ([10.238.2.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 03:07:55 -0700
Message-ID: <d4b5d0dc-64fb-46c2-a578-8828e14447a3@linux.intel.com>
Date: Tue, 27 Oct 2026 18:07:52 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] x86/cpuid: KVM: TDX CPUID fixes
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, Changyuan Lyu <changyuanl@google.com>,
 Sashiko <sashiko-bot@kernel.org>
References: <20261022210134.612848-1-seanjc@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20261022210134.612848-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/2026 5:01 AM, Sean Christopherson wrote:
> 
> Changyuan Lyu (1):
>   KVM: TDX: Set SIGNIFCANT_INDEX flag as appropriate when filling CPUID
>     entries
> 
> Sean Christopherson (2):
>   x86/cpuid: Mark CPUID function 0x23 as being indexed
>   KVM: TDX: Reject KVM_TDX_INIT_VM if indexed CPUID functions don't
>     match

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
