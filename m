Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5800A2749EA
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 01:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773193030; cv=none; b=siekkHTda/Hnlf7K0CmGJ8MbBwMliF90KVDN29TCEyRsxfDduhZR29CLeE4Q2rQZ+AibYMx1F/m7wjp38VwybW537zCw0KnSJxFBC8wgCKbS4yS6lFEJBNB0lo6/DgaK1LkLnz6F7Wq12fwghbiMYtlZnM1UW9cUl3CCeyyrxAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773193030; c=relaxed/simple;
	bh=l8eajydujWLTM6vGh/poRU6X3moHiLbcLbNNTKVg78M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZeal1GamXgAJn+WoExmyl1IOFO8BalZGsfXNsOMyS/PvY+UJranzu4JSWZId1Mxct1zLU7eNbY1CpqxB9fEtfuh962SBAZhYPp3HPVoIbAQUpJpIIkiuhZH/pBTadAfxQ4BpPZ7HHntmqkHj/tCEFi+dho6GB6XhL7j0lI7/08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFhleNXs; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFhleNXs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773193029; x=1804729029;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l8eajydujWLTM6vGh/poRU6X3moHiLbcLbNNTKVg78M=;
  b=FFhleNXs8l4k9eDxeo5owJaFilFSufzLzkCYNE2E3ODwKC2hehH/6dBd
   HRVU7taK9NDlamGzya1nIaxeYU9BoZ3GQ+ueogAkxVW9Ql7MMY0F/ehFu
   DO06PKwRmgr6gmgtNO9F41pTYcfycSabMPdWr6qhYrt7Rbc/SCV3kwYGE
   AUMEIXubfpCzx09hAXsMCCxzzm7lwSNz9HssBsYGfMAhLe3Efj18JYtK3
   fLM66T/W5hawYyWdYNwbtoJkIE2JU7NbNPsKVx43O7584CHZuec7NmN07
   MUykrG+muH8nYgT0n5ZoAfaId2/b6/fTh1DnBI1XB9lXZR8dso9hjoz65
   w==;
X-CSE-ConnectionGUID: o2oeqgpbQ4KUS/6bPwMlBw==
X-CSE-MsgGUID: pDKRYnfRQj6VM8kC1BKkbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="96869317"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="96869317"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 18:37:08 -0700
X-CSE-ConnectionGUID: xhUURK0TQjaybC+MPvZexg==
X-CSE-MsgGUID: vzz1yGmnRaaUzvU/9ljSQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="225259050"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 18:37:06 -0700
Message-ID: <81465dc2-6734-4a3a-a0c0-2eefd15866e4@linux.intel.com>
Date: Wed, 11 Mar 2026 09:37:03 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] Upgrade intel vPMU version to 5
To: "Woodhouse, David" <dwmw@amazon.co.uk>,
 "xiong.y.zhang@intel.com" <xiong.y.zhang@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "like.xu.linux@gmail.com" <like.xu.linux@gmail.com>,
 "zhenyu.z.wang@intel.com" <zhenyu.z.wang@intel.com>,
 "kan.liang@intel.com" <kan.liang@intel.com>,
 "zhiyuan.lv@intel.com" <zhiyuan.lv@intel.com>,
 "seanjc@google.com" <seanjc@google.com>
References: <c6590d8d23f4b09be727d8745e2ebfd5a6ab002d.camel@amazon.co.uk>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <c6590d8d23f4b09be727d8745e2ebfd5a6ab002d.camel@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/10/2026 7:56 PM, Woodhouse, David wrote:
> On Thu, 21 Sep 2023 at 16:29:48 +0800, xiong.y.zhang@intel.com wrote:> Intel recent processors have supported Architectural Performance
>> Monitoring Version 5, while Intel vPMU still keeps on version 2. In order
>> to use new PMU features introduced in version 4 and 5, this patchset
>> upgrades vPMU version to 5.
> What happened to this series?

This implementation base on the legacy perf-based emulated vPMU has been
dropped. The support for higher PMU verion (5/6) would be re-implemented
base on the new mediated vPMU framework. Thanks. 



>
>
>
>
> Amazon Development Centre (London) Ltd.Registered in England and Wales
> with registration number 04543232 with its registered office at 1
> Principal Place, Worship Street, London EC2A 2FA, United Kingdom.
>
>
