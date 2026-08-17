Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FB92405EB
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 03:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786936034; cv=none; b=rOevFOSqban2s7RET4/WKVjCL2Q4d6ZFWSEwn3ep/pBtJ3473M3Z7j8ZnKxYY2S+CtwTsjSm5zZm3Ql9Vu2f15XgUbxPdzHopiZd3fTztp417EYgRW5vsTfMpW2mIbuSypE0/dAR734EqZweWBQOkbfmZRjLZ4FB01MGaYPgeYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786936034; c=relaxed/simple;
	bh=zx70qdlLZTX+xp8Od42KhigdB2tEb9WRMnzoK9FvDgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSO3DscDlmama9IAqsEilIW+kGSX+fJQvYVNwgBNTg8Jkrjx36Ay7KtSl04DtXJlaUUiQ8lR/PLubOaucq1n0wxn0n/u7+zhSlwMZPsfnlourYIoriitYm1aMFfeHotcHG6ojEXBDug64LTJcxTD8m/GzXQlQ4befENtiwK3/lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6wRYQ0B; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6wRYQ0B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786936032; x=1818472032;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zx70qdlLZTX+xp8Od42KhigdB2tEb9WRMnzoK9FvDgU=;
  b=a6wRYQ0BG+wuO2iBmtBpu0sErLUA3ZMPDIENImY/kyHiGLODtzps0t4T
   c/Mrh+yGFzYVEJ+WTb6CXUia7OIY6vCo4l7klpw4dlWDPr/mlGWmsUTA2
   gyct7bvnpOB3nTHnhX2sBfjfZaIQ3HVhnfAqwAs743LzRTnMr+elLu5Zq
   6rxoZnkm8nZIOwAlz/wwlZkYGgTq8gHgKRcs0PBvZkKsRduIvE2eN5hMR
   aVyWSOkP58jDqUrAuQfOUVv3I3nmXxKwL5yODClbUac+qYzSLzADF//Cp
   ghwtLfaWBQMXZdgBUZjmoX9u9cWs2wcgPmDFUQhbGpAM+VxDKl5ce5mwt
   A==;
X-CSE-ConnectionGUID: 3k2EkuvDQuWAqUFquDf5JA==
X-CSE-MsgGUID: fOSKv+L6RNiAJXpbEgJ14w==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="86527038"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="86527038"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 20:07:12 -0700
X-CSE-ConnectionGUID: urmtcBZkRuWLNwkvVW77JQ==
X-CSE-MsgGUID: JbHYTAQcTb6X0OnutPoBjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="264828541"
Received: from unknown (HELO [10.238.208.98]) ([10.238.208.98])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 20:07:12 -0700
Message-ID: <901ee69d-9bd6-45fa-ae0f-0df35d80b94f@intel.com>
Date: Mon, 17 Aug 2026 11:07:09 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] KVM: VMX: Rename posted interrupt prefixes from "vmx"
 to "vt"
To: Sean Christopherson <seanjc@google.com>, sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260814161129.2177118-1-seanjc@google.com>
 <20260814161129.2177118-4-seanjc@google.com>
 <20260814161950.136041F000E9@smtp.kernel.org> <an9KM3Ye-GX7WggF@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <an9KM3Ye-GX7WggF@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/2026 1:02 AM, Sean Christopherson wrote:
> On Fri, Aug 14, 2026,sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>> - [Low] The function `vmx_needs_pi_wakeup()` was not renamed to `vt_needs_pi_wakeup()`.
>> - [Low] The shared inline API `__vmx_deliver_posted_interrupt()` was not renamed to `__vt_deliver_posted_interrupt()`.
>> - [Low] A comment inside `vt_can_use_vtd_pi()` references the old `vmx_pi_start_bypass()` function name.
>> --
> I also missed vmx_handle_nmi() and __vmx_handle_ept_violation().

So for TDX VMDoS series, I need to rename __vmx_handle_notify() to 
vt_handle_notify() and extract handle_bus_lock_vmexit() from vmx.c to 
main.c as vt_handle_bus_lock_vmexit() or just inline function in common.h?
