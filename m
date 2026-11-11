Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794382815;
	b=3iLXd1jFS85zz9ToEyfuKhGXykwhOI/3xkdRAGcCU8uWyOBvozwMqYDEVE0HDYcbXC7d
	 v99vP2/M9GOSmZ/zwqBC0JpzmCKJtXyVzFJm1BloyJjxE9bxDY6YehPlKQoONdNzdrJgd
	 ec/UJu26ebk3E9Q2vj2o0zYschmblIywcLjEigsmfL27n2WUT/9QIcBgonATrP1qMsifC
	 NwLJTwBez+VWfE/1ZncE+ekqoI+uZiWteS80DF64nBMEewctGFZ+IX+96m9L9C6c2823L
	 4zLShT4CjEkZ35yhcjgotO08wuqpFPcwGIbjDGV4nyav1EOPp6090a1nn/o9+K3DVLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794382815;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Bo/rSB63QRwvs2FN8ToCi5grrCia6AmWe7fZkN4e0Rw=;
	b=d/DWh382TO+7GSX+lfQyNJk1V2AIsUN8fPnZ/iLgV6iXYcfiLKufcQnIyofbhL3bU09U
	 Payc1GyRcsdOXpyOT13wre5JetJ5emqQeIJ2y6M3/6um7KQHA9dtHUi2OJ7/ADrkwJbLx
	 wGAYmfghA3cC7rO0YDKhr+3Zut2ESTA2fZahcuWTpDst/jWy3xodV34ldt6/LvIk8ISFM
	 tNq2u+CMdBc68y3hk73Mvetv75Qz8IcCV8zhs9DP8cY36cE0zVHFcKFmzBkQDIGoBM2V0
	 Ce/MWgd6C8UiXrjjwX5Q2sNMb9fcngFjmQl9PqQNDA98we3AKVE9hYdulnaZMuA1ayA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XG9JG+8g;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC0A606A320
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 07:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BC0A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XG9JG+8g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794382813; x=1825918813;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/5gd75ih0pdT9xF7iAYuNB4tsfw40cTZRkTaixbow8w=;
  b=XG9JG+8gNnJYuqL6z0AdR6TA4Gccz5A4HiqI0/wep0lxZkqh0UUt9jEf
   EE2TJGpDb4GV1Gtox1hm3yBHw01bi+KKG3zkbVYg4jXvX/l/MGg4FsAPn
   EgFNdcdCe43OLTIdOKEXTZK2XM0JFjvrTdAIK/4lIUIXHh1swc3Y81mMx
   sfmg6vQtEWcZaesrB2fQF00dQzcnyLmFzxP4E9oSENk2nfm/FzlY+Y5vo
   jYa9nmoPnN4Q3pcBdCqmi1u6YKQ3TCsYHRN+SAR+QAGP9ViC9gcjgw2xI
   w3RVECEmHUcBqPHd528cH+q8csvIgNrvpa64lsKQYJ3StFdfaw9SgMknp
   w==;
X-CSE-ConnectionGUID: QtHMNpg1Srq/90uBFiOxjQ==
X-CSE-MsgGUID: d4Nfv3vNStCVx0vrxuNQ6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3055958"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3055958"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 23:40:12 -0800
X-CSE-ConnectionGUID: iBW64SG2T2Sn7MfdMoRD7A==
X-CSE-MsgGUID: L+o+rR5JRcqX5aQRY8/DgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8778571"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.71]) ([10.124.240.71])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 23:40:11 -0800
Message-ID: <3eb8736e-6aaf-4b02-a6bc-19f92016defd@intel.com>
Date: Wed, 11 Nov 2026 15:40:08 +0800
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
Subject: Re: [PATCH v16 18/20] KVM: selftests: Add support for per-VM ucall
 ops on x86
To: Sean Christopherson <seanjc@google.com>, sashiko-reviews@lists.linux.dev
Cc: Lisa Wang <wyihan@google.com>, kvm@vger.kernel.org
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
 <20261105-tdx-selftests-v16-18-2024e8fa517a@google.com>
 <sashiko-outbox-200423@kernel.org> <au3pwtxF9Qs97mfu@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <au3pwtxF9Qs97mfu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/2026 10:52 PM, Sean Christopherson wrote:
> P.S. I'VE GOT THE POWER:

Great!

> # ./tdx_vm_test
> Random seed: 0x26085169
> TAP version 13
> 1..1
> # Starting 1 tests from 1 test cases.
> #  RUN           global.verify_td_lifecycle ...
> #            OK  global.verify_td_lifecycle
> ok 1 global.verify_td_lifecycle
> # PASSED: 1 / 1 tests passed.
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

