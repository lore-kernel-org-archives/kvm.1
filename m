Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFAD349CF0;
	Tue, 13 Oct 2026 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882169; cv=none; b=RjPCrMbnGSqE9NIcTuYg9SYosshNFh/8qwN3vdRYqjYC7/Lh40xqasY+DjovrQDigfFUOvQU3fhB8uPuMon1jAIwk5ITO2E1ugJ+j7Kf6Vg6XjyOQjC8CTpu2YcFgaiF77BqpobmH4lB0G/igx1CrtkouklmAxPu75g4i5kfQ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882169; c=relaxed/simple;
	bh=JwYDCNdXLaGhSF1gDAHg9eApC698pRa6SlDj4UwDP8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBUWNVS1cSMfFamzpYTP02lKDzrdvQZK7HXgis2Rd83kyKgcNEHpzuWef0GLbN6cvUx5w7IMb/UnXEJC9KjxTb3/1bs4umONdGzmjFnA3ibF5JiJ1TF2hrTRvxk3P1SCQbbepqwiuX85ou+H1xfdwPNKmPoNB9TdDq9bX2yqxJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l2GdCJap; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l2GdCJap"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791882167; x=1823418167;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JwYDCNdXLaGhSF1gDAHg9eApC698pRa6SlDj4UwDP8Q=;
  b=l2GdCJaprQwWyxR5smlc/vBuoJZFwAFrYwiF5NLRMDec2kQc41ULOthj
   H6ZI+8irHHX7agsP5QaLOKPy/aaXTPNIrbKcvYGf1kWch5B13yj+gD4kg
   WBHIyKpTpsiXxY/Ssbxh76GmwzyDXBGMr9E/WbzSK/K9SMOB1EOamu3fi
   /qcpoR3b9d/Qea50/VaZyqvmyc28QgTnODJPPjLNnNMCGMbZElmvyHg14
   KBZz3/O6PO25aBa72N6+MMzcGZpexi8yki3fKwUHNMIl0fRwNoh+g2MKI
   /uge8y4qfxqZ7K4W3u2FIIjvO9oGglapwN71iEihXAZD3VeOA+sX7DtQV
   Q==;
X-CSE-ConnectionGUID: aQCtzTlDTl2opxQMM55iyQ==
X-CSE-MsgGUID: jqpL3yGXQwK9B5oppdyKaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="605115"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="605115"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 02:02:46 -0700
X-CSE-ConnectionGUID: C7B5YhSgTIKtoU6Rn9SCgg==
X-CSE-MsgGUID: yHB9gU+8QAynInSmPeF0nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1589486"
Received: from unknown (HELO [10.238.2.98]) ([10.238.2.98])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 02:02:43 -0700
Message-ID: <bd995feb-e8d9-4595-a809-753101b91e48@linux.intel.com>
Date: Tue, 13 Oct 2026 17:02:40 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] x86/virt/tdx: Convert the tdmr metadata reader
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, yilun.xu@linux.intel.com,
 tony.lindgren@linux.intel.com, rick.p.edgecombe@intel.com,
 nik.borisov@suse.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>
References: <20261012094754.27702-1-chao.gao@intel.com>
 <20261012094754.27702-5-chao.gao@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20261012094754.27702-5-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/2026 5:47 PM, Chao Gao wrote:
> Continue converting the metadata readers to the table-driven helper.
> 
> The "TDMR info" metadata class has two readers: one for the fields that are
> always present, and one for the fields that exist only when the module
> supports Dynamic PAMT.
> 
> Add a table for each, both pairing field IDs with the 'struct
> tdx_sys_info_tdmr' members that hold their values, and read all fields by
> walking the tables.
> 
> Annotate both tables as __initconst since they are referenced only during
> init.
> 
> AI was used under supervision to review the code and workshop the
> changelog.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

[...]

>  
> @@ -122,7 +91,7 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
>  	 * DPAMT but don't expose the metadata.
>  	 */
>  	if (!ret && tdx_supports_dynamic_pamt(sysinfo))
> -		ret = get_tdx_sys_info_tdmr_dpamt(&sysinfo->tdmr);
> +		ret = read_sys_metadata_table(dpamt_mappings, &sysinfo->tdmr);

Nit:
dpamt_mappings is a bit inconsistent with others.

May be tdmr_dpampt_mappings?


>  
>  	return ret;
>  }

