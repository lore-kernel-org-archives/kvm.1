Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09E33AD534;
	Thu,  3 Sep 2026 06:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788415484; cv=none; b=hcDC+AhRNp/WJI8gn3vl2DYUP6sNH90FcHZQlmL+XGAREuSaWZEcNC6pPTIe+IqfTPt6asEiBeYyrJV7+NYis/9LKG6scQA7TZrpAzH607CAcEvwMxfS/6cdnXDsxNxOaLGnUwWpnvkxAmNcBt7ICE3BhpI0Ses51aRlHoxvu4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788415484; c=relaxed/simple;
	bh=44u3vUpXmjnG6jho1rbOyqOuFIw7rksvIUMshxzVXEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzOjhhGLvBsURqQWtEuyzGi+U2bmHxDffDMvE7tZ23QeGUD8cScEvZSD3NP1csBKx5h8Ugr1OzMCtjnTLr9Pt9BVK4Z8sTV/zvFDRrBuZ0Vdw42Imot0dN24K1NApY3StZmmFJir+JcDdNoVUenw73ACxH7NTWG7l5OLaNTh5bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjOdUFBH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjOdUFBH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788415482; x=1819951482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=44u3vUpXmjnG6jho1rbOyqOuFIw7rksvIUMshxzVXEM=;
  b=jjOdUFBHqqJlBdBnkS5u8aI+VUF14OTl2PdjOr03x36qwox2crjU4FA+
   5LmX7lnPkpk8fzKBIwbAj4fDqCWey3c8I0gE2Y5/XJXOWAmbg0NH3XUEq
   hnXls2QsyLCLhAVxQhT8yfEUnCVtYnq/lrk2xxklD8mQPd18+9QbvL5BO
   jIM14iq/AGjtN2NtKi0FFmWbzJ9M9c+gtkzYaFnbN4sRzzdoF1FxfscDz
   WmCzbsZjKBypSxYnyHPfwrBX5OctdfgZL6DewERyfIs67464kecLToUEP
   Jssfp+3BKsLqh6lnRFbqYNUMcwC10RAGjAj0kJkaX6gelnkYnuAECILx2
   w==;
X-CSE-ConnectionGUID: 50TEOIAqQYaZoe7nbcJzzQ==
X-CSE-MsgGUID: PS+GLVmYRAqGHKeaxY8ygg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="114426133"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="114426133"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:04:40 -0700
X-CSE-ConnectionGUID: DEY3/2NlTpuIp1GsbEOI0Q==
X-CSE-MsgGUID: oSYjlh6pQ72XX6g5CD8Gqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="271577206"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.231])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:04:35 -0700
Date: Thu, 3 Sep 2026 09:04:31 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Peter Fang <peter.fang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 1/4] x86/tdx: Add helper to query maximum TD Quote size
Message-ID: <apkN7wfZprnIQiaL@tlindgre-MOBL1>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-2-peter.fang@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729122939.1340412-2-peter.fang@intel.com>

On Wed, Jul 29, 2026 at 05:29:31AM -0700, Peter Fang wrote:
> +/**
> + * tdx_get_max_quote_size() - Get the maximum TD Quote size
> + *
> + * Read the maximum size of a TD Quote from a 4-byte TD metadata field. The TDX
> + * guest driver uses it to size the buffer for Quote retrieval. Older TDX
> + * modules do not support this field and return an error.
> + *
> + * Return: Maximum Quote size in bytes on success, or 0 on failure.
> + */
> +u32 tdx_get_max_quote_size(void)
> +{
> +	u64 val, ret;
> +
> +	ret = tdg_vm_rd(TDCS_QUOTE_MAX_SIZE, &val);
> +
> +	return ret ? 0 : (u32)val;
> +}

I think you can leave out the u32 cast above.

Other than that:

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
