Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC761221F1F;
	Thu, 25 Jun 2026 06:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368139; cv=none; b=mwI/HhqSZckdE+EhT7UtA6hOvf4ddFKjaKsnSsG8oTQXgn9ry4U1D8M4rAl8JJaNGjaJOUJmj5+xz27uE63jSu9yFcIS7l5jpNRal3mAPfjkrP7bVjMaEuvWiUWARs8SEw/37YIk5xJdJvQsdEgJqkJfrPfU+LZK7CMiU9Psd9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368139; c=relaxed/simple;
	bh=Fan7fhpQkOSRFcz+PJcy/ui6N+4CjJOjBX3ltJDdT+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9TSUk3ciqvA6Kw3L8POplHpCp7MmTSTvAM8/5C5lEdlvoOlXl2BgrUyIKORf6gbHmXZBOuPE81RV517XAdx/z9yyrnqc+/jREZx9MFbuBquKTTaP8KdfuXL1tjb2wWEqAmrket9IMVT4eaflWLloULUGvRvg1dBbNOPaTvJ/Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELympg42; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELympg42"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782368138; x=1813904138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fan7fhpQkOSRFcz+PJcy/ui6N+4CjJOjBX3ltJDdT+s=;
  b=ELympg42Auo1GaVOnE8BPTP2xCw2jMAE/tqClGSFWkN7VAvixckKEs4a
   +JM2taAODuaQoRdnCMZD+3PCc1Nr9N7zdtms0tW//pXKkMwG0Oa1vgh4j
   XBDbGZ3CPFjAmrkVdOq1wAwH0DNBnPlRixukyklXFP/DzqsOudgpM4Shn
   lSmsWgdxJmumprSO+92plKwL4AoljbEtA6zftCkVbu7eLwsbgLsFTKnj/
   5vJ3w33Pn4ksfOJjm2v9vlGZOASgKI2bnRB5wSl8jrORkskNtllgLT2bX
   wq2vUPg9ewlN7CylGfEM3wFJaqR6/O9X3tacUc9AERyCEzj2Nhq2A2oIJ
   Q==;
X-CSE-ConnectionGUID: ToijDL9XRAe3bH/iZLiWQw==
X-CSE-MsgGUID: KJvhZSwHSa6Zc3XBvDx+fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="93741469"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="93741469"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:15:38 -0700
X-CSE-ConnectionGUID: WcV9xdCPTSqirkjyAnpGpg==
X-CSE-MsgGUID: FJteUDhSRy+Yvy9L6s06ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="246390464"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.64])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:15:33 -0700
Date: Thu, 25 Jun 2026 09:15:31 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, djbw@kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	peter.fang@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, dave.hansen@intel.com,
	dave.hansen@linux.intel.com, seanjc@google.com
Subject: Re: [PATCH v2 14/17] x86/tdx: Move and rename Quote request structure
Message-ID: <ajzHgxIfpBA7hP7P@tlindgre-MOBL1>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-15-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618081355.3253581-15-yilun.xu@linux.intel.com>

On Thu, Jun 18, 2026 at 04:13:52PM +0800, Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> 
> Move struct tdx_quote_buf to tdx.h so it can be shared by the guest
> driver and core TDX code, as the host will also need the Quote buffer
> format for in-kernel Quote generation.
> 
> Rename the struct to tdx_quote_req to better reflect its purpose, and
> replace "quote_buf" with "quote_req" in tdx-guest.c.

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
