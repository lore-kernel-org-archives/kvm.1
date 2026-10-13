Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C633A4F59;
	Tue, 13 Oct 2026 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881117; cv=none; b=Mm1/ZFAB808NRsW2QwrnF9EbxMbkSAi9m4beYFkMkctQl2tU7ThocqZ+bLMReTNqg/KmFf9/yA4VaIkSVok+szlyQQ8JdZUvSEGWQjsKT4s0IWNwcZ2sCnmVUodEWMUx891lbcy7kucs4CYNL/g6fbaSHREJ9o4ylinxOh5cbo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881117; c=relaxed/simple;
	bh=tQXLYDsoOTxPoOoTErhqB6NtmbOKy3IOT/1n2Ddr5kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6SHUnKx1RF/HrFJgD/0gYlV2naY/e1oENjiS4baWWiGA4T0zclDfV1xlJG+Ct3T0PuElzrdlLgFurJpUVkve0WohONdEQqO4+p0rOLB3dBKigEiYAyzFONq3XDodDK1739BWO4tdmBLKsfDK5CLgjISPEPuV+6tDk/1FPxOCQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dbAQZ2Dr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dbAQZ2Dr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791881116; x=1823417116;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tQXLYDsoOTxPoOoTErhqB6NtmbOKy3IOT/1n2Ddr5kc=;
  b=dbAQZ2Drh7D6MiPgIgA+wqpVjMokTCHNao4TRddzfdPAVSdLjEJjGugZ
   /dZRO9u+S3XmGV61Ni8MktXvJvtpUU8R73LI7iW/3v3XxcPsWUCfOm8HO
   f0xEvos5bUK+FaUu8hNsUrEgSC3csGGtXtJvO0jBpoMZiVEU5zAl4eWM4
   hDVCw/h3ZWD7iBWunOXtCVlc8qh3XxqoNP42ylPfADkqdWBd6uAM5cVe0
   hQRFZSIbU7YzrbQ+tuGnzoDzA3v4Rw3By4ybtY1yU+aHNjbR/UocRPTAl
   4HdqemRsuKHP80PbvSrCR9lq1ZS7SvnSZhEtgO037oLNCXzWOionwYNpB
   g==;
X-CSE-ConnectionGUID: 1TpnPk5GRx2bRD/yXaGLDg==
X-CSE-MsgGUID: 8Ea6nFvHQrafJ3SHpX3ERg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="702554"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="702554"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 01:45:15 -0700
X-CSE-ConnectionGUID: J4HmsmcfQAKmE40yBRkjqw==
X-CSE-MsgGUID: QP+D3cC/SEaS/cAi9HeXVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1434297"
Received: from unknown (HELO [10.238.2.98]) ([10.238.2.98])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 01:45:12 -0700
Message-ID: <6045f9e7-9376-4460-968d-e8b77428d69f@linux.intel.com>
Date: Tue, 13 Oct 2026 16:45:09 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] x86/virt/tdx: Convert the features metadata
 reader
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, yilun.xu@linux.intel.com,
 tony.lindgren@linux.intel.com, rick.p.edgecombe@intel.com,
 nik.borisov@suse.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>
References: <20261012094754.27702-1-chao.gao@intel.com>
 <20261012094754.27702-4-chao.gao@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20261012094754.27702-4-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/2026 5:47 PM, Chao Gao wrote:
> Continue converting the metadata readers to the table-driven helper.
> 
> Add a table that pairs each field ID with the 'struct
> tdx_sys_info_features' member that holds its value, and read all fields by
> walking that table.
> 
> Even though the structure has only one field, add a table anyway for
> symmetry with the other classes. Adding a field later then becomes a
> one-line change.
> 
> Annotate the table as __initconst as it is referenced only during init.
> 
> AI was used under supervision to review code and workshop logs.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

