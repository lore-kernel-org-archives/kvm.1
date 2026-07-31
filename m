Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68F8298CAF
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481426; cv=none; b=YB7+RCCuiEcbsEkGf8a73z4OYLkNTmkWKQAjZ4o0eW11N8cvPkXBrodP/bdj9r+SElZSpcG5XtVpp01/1ypVPDOU4tNT9vy9K/MfJH0p7evHgWQYuIwmuxS+JF8xtEptu+DDc59M9NdU9Z01KYA/uLtDCiTqvdb7VqOhVbimt4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481426; c=relaxed/simple;
	bh=fsR2QftS0gbhwMDEj+tg6yYm3dWNvlhPmNhkKBZzbtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFfgo/A/iWkl+YvauI48hdZ4GTE7MVkTVmorUX8oSuzTbkPHwWYze7Hq9DJiIPylHw4wL0AY705c+wxk8C4DPFTKaBCDUl8c8nKnSSjtuS+AOirs0iDVNNLmG5UAVz4e1rZMw0hxpBi9nqLZ1jL2edJ0DwjGN3BoIZDcNVNfqvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YkWTDjyZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YkWTDjyZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785481425; x=1817017425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fsR2QftS0gbhwMDEj+tg6yYm3dWNvlhPmNhkKBZzbtQ=;
  b=YkWTDjyZdHmt36XA1aXl348a/AYTWdGKC58aN4kcVaM1kSk/mLP7AekO
   qCZhTgIGOwxFoJFvvHPm5VzWGpz5PD76YawiW3MqvrTYRQP4onv6nQg4W
   tPtZSn3E3eWI1Fl7MA0KTu1paqwJ1wGdkPpSl2q47db+hWaZFjGx5VqoR
   7M1I1xHSji1eLa8DM/7CTQ5BHljn51qGY47h9fxl0+mnEGcJDcS1o9zLy
   7+uvncDuRVB1jN11BH0lM5Q2FhqXZpoXStQ4LYPcV0fsgXTsI9XOma8Wx
   GCum5MObomxvobSXTnFZpYlsuQxbAL+jgD1IgwsF7L7nS2SCJa1eY7ZlK
   Q==;
X-CSE-ConnectionGUID: ar98j16GQU2kz8pToF4QVw==
X-CSE-MsgGUID: DZQ8/mIQTVyr9CHzpA05fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="85231577"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="85231577"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 00:03:44 -0700
X-CSE-ConnectionGUID: uliembHEQvOELL0xelCWMw==
X-CSE-MsgGUID: hRWFoFTbTfGE475h0uzvVQ==
X-ExtLoop1: 1
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by fmviesa003.fm.intel.com with ESMTP; 31 Jul 2026 00:03:42 -0700
Date: Fri, 31 Jul 2026 15:03:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: zhang_wei@open-hieco.net
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v1 2/9] target/i386: Hide Intel cache CPUID leaves for
 Hygon
Message-ID: <amxIzcG2sSLLljng@intel.com>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
 <20260706055530.1752094-3-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706055530.1752094-3-zhang_wei@open-hieco.net>

On Mon, Jul 06, 2026 at 01:55:23PM +0800, zhang_wei@open-hieco.net wrote:
> Date: Mon,  6 Jul 2026 13:55:23 +0800
> From: zhang_wei@open-hieco.net
> Subject: [PATCH v1 2/9] target/i386: Hide Intel cache CPUID leaves for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> From: Tina Zhang <zhang_wei@open-hieco.net>
> 
> When x-vendor-cpuid-only is enabled, QEMU suppresses CPUID leaves 2
> and 4 for AuthenticAMD CPUs because those leaves describe Intel cache
> information.  Hygon Dhyana uses the HygonGenuine vendor string, so it
> currently skips that filtering and can expose Intel cache leaves together
> with AMD/Hygon extended cache leaves.
> 
> That is inconsistent guest-visible CPUID: Hygon Dhyana provides cache
> information through the extended cache leaves, so it should not also
> advertise the Intel cache descriptor and deterministic cache parameter
> leaves.
> 
> Apply the same leaf 2 and leaf 4 filtering to Hygon CPUs when Hygon
> vendor ABI fixes are enabled.  The property keeps the old CPUID output
> for pc-11.0 and older machine types.
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  target/i386/cpu.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

