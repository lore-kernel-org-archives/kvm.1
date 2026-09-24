Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743CE3AE6F5;
	Thu, 24 Sep 2026 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232022; cv=none; b=MESCkHBl3BuIpjg2dawf6zwhUfRt6JbUQkMKnJQe7VqtKJV5om02EnM9D4nu6NG0lAcdRiMxlnWEjuTfZxDlpDAWOtz501UPpe17lLRNupR5LWtv+CjBUm0ONSLtjMDYDXBZlaujc/IP2nsrbZPdxnl3mNjQc6Z9woxm+okoKxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232022; c=relaxed/simple;
	bh=63+CQUCm77nx9iN/CF6fhnFnAJq/okFK65QrDdmNqho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNly2oo4rHsNhtjR2muXwTdZ+KWMx/ZuInPC9OgUa2WBA/ZK4OJhjknvnroPuC11s+yLUQl8WXG95cE7eJi3/KGcPa2dwhb+y1e7CJNgZtYvanVKjy1Huk/4q66cQE1i6n+w9rYPosdi7sJm0gzMcyNMqGVX94sFRTq1qVh1d9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nu0YggUR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nu0YggUR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790232020; x=1821768020;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=63+CQUCm77nx9iN/CF6fhnFnAJq/okFK65QrDdmNqho=;
  b=Nu0YggUR2x/5VAwdyXg6cPpDfAeHUxAq6M/LxTpzTpPKGHCbSWH2AxZu
   P2njzXUuPhAc9RqbBFTQoUqLInsHq7xz7j4Rsb97p1o+FAfRCThPv8BwI
   AFzTvcFHF+1QvuQNljOUZPZulOiMIrkxr5m5XUzlYDsQe5CZ+gO4QntIA
   csjqS8XkAh/3oh8Xh2A+VUm7/E4b0Mr/tMXF17pkJPl1MC6SPlUFPeUXf
   SRR0v6+oAAhvVWQz/MwkO2+pxsYIbspADE7UUgR9hG5/uOqgVZjjdOOIQ
   Kw2zg9EJqxYT1KfK8qBk9Tme3sCHNojrYTSWs7W1vE/LCohJg/61vz4VM
   w==;
X-CSE-ConnectionGUID: b+UwcSCMRGqBtssWpK8C6Q==
X-CSE-MsgGUID: MPSxUqZBRy2mZLVuox3R4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="89949680"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="89949680"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:40:20 -0700
X-CSE-ConnectionGUID: vgWziXq4R/OOZ5ZYsSty7A==
X-CSE-MsgGUID: bsQP7ZzMQD6w95PTwkqo5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="273429824"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:40:17 -0700
Message-ID: <4e4ff512-7aa1-4d91-8ed6-1755a6c67162@linux.intel.com>
Date: Thu, 24 Sep 2026 14:40:14 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 02/10] x86/virt/tdx: Convert the version metadata
 reader
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, yilun.xu@linux.intel.com,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20260918132946.76533-1-chao.gao@intel.com>
 <20260918132946.76533-3-chao.gao@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260918132946.76533-3-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/2026 9:29 PM, Chao Gao wrote:
> With the helper to read a table of metadata fields in place, the
> existing metadata readers can be standardized on it.
> 
> Convert the version metadata reader: add a table that pairs each field ID
> with the 'struct tdx_sys_info_version' member that holds its value, and
> read all version fields by walking that table.
> 
> Name the field IDs for readability, so the table entries don't carry raw
> hex literals.
> 
> Also add read_sys_metadata_table() macro to derive the number of entries
> with ARRAY_SIZE() so that callers don't need to pass it separately.
> 
> AI was used under supervision to review code and workshop logs. It suggests
                                                                        ^
Nit:                                                                suggested

> adding read_sys_metadata_table() macro.


