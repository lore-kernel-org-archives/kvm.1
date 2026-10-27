Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111336;
	b=wQnhjqeDT5vtjTDVlqkfTzgtqlay6MZqOQhP3ZBry6hRNFCifDvV9rtLf0WTts3LTMdT
	 iYMg8yjQBStqlnUzH5FRL1WZSq2EBEKaTiW+1nJKnTYMhvh7iVT8KV+Ij8Y7eKpWzPd0x
	 Ce9LBKCnOw0iksFxk9wm6MWCqxLXlnkUjObxyBLZDjtUObhOA8eEBNMjXONPBwhvwPCc6
	 li62RCMqymwzr+Bip2598avR//PsNT3B4dRTJaVCRj9M50v+CyMBsGW9ljTJdWI22t6GE
	 3kjUld/ir5N73f6pnFqNwhZXjSIIS/7bxi+fnnF5ZRc9GtCleeY9D9L5AMb99kAieVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111336;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=AlPPjUUbBh7e6DfqBqr08s54GLk1dBFsaEtgnSWIg7A=;
	b=rmDHqMroer/aoQGgFB1V5Yeim0W59wTWKhM/dIjpObHOURUqCF2VueKW1d5vsyt1Y+Ll
	 tcC1Tu9fqxE3G0OQo0LwERXyvyiXnGSZywXQs86Q0VjsfIQ88soAH72RFh+1+vKqGHC9F
	 lU7+jR1LNmHz4RiHdZJEFSaHA7NS2iXaA99H8xKJPaNmvD7BkiZ2bC/egCNpBne5kLYf2
	 SUsvDWh14ScofJdA5HaM/ErqccWaluB54jn+H7YFgK6RnSURx99/kkrAnqR8eQdMSEjNY
	 YNlCfVOv/9/xLPBtm+uZXLXY8adAn/kVLYzgYt526NEiySy1ZhW6dxu6KODWHAkl9EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="fe84O/Zh";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D4A606A31D;
	Tue, 27 Oct 2026 14:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78D4A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fe84O/Zh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793111335; x=1824647335;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GcD7/c0dhVXaCjOprpb+zsiS0VNVTdgE4fMtrRTvB9k=;
  b=fe84O/Zh+vU/QfMTAuxtC/lM//NsPy+El6qCV/GnCogfDlwkbW1M2p9c
   BKY3jFKm0wI3lm9pMV62f6Bs2xDf2YWH5RxtoeqRYGKpTB0phywJRJXoY
   O3rBwRLcXGbt05YnevrwIRfSiCOIRWDfrobW8cmodrbitSTd+ZpiajGaj
   v+CawEF6rpyddZWPtmB6pMquZXu0WFPcr3vQJyuLo/HWY9/4iTyQLNrat
   e9snYlpPe3JC31xrjCJwUmeYhQCkauGwIOgwaPCX5KQxSjjFsZHcvgVNC
   VE6RZl1/l78XRQfco0DCbTZbWXiYfMkIb6t0+y1wyYXe+V7PwuM3lFfVJ
   w==;
X-CSE-ConnectionGUID: v8vbbA/kRxqzWmWWdaBU2g==
X-CSE-MsgGUID: V4Sh0OozTmi+xWfYy6t94g==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1696012"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1696012"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 07:28:55 -0700
X-CSE-ConnectionGUID: NqeXNhirSl69eZ0FE/vyOQ==
X-CSE-MsgGUID: EVcSGxPCR6yHWNwj5RfDAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4896651"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.108.158]) ([10.125.108.158])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 07:28:54 -0700
Message-ID: <18b03ecd-50af-449b-8e1c-bbe32c9c7628@intel.com>
Date: Tue, 27 Oct 2026 07:28:53 -0700
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
Subject: Re: Kernel Shadow Stacks Versus XFEATURE_MASK_GUEST_SUPERVISOR
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Yang Weijiang <weijiang.yang@intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, John Allen <john.allen@amd.com>,
 LKML <linux-kernel@vger.kernel.org>, peterz@infradead.org,
 kvm@vger.kernel.org, binbin.wu@linux.intel.com,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Bae, Chang Seok" <chang.seok.bae@intel.com>,
 "Mehta, Sohil" <sohil.mehta@intel.com>
References: <2f0560df-69fc-4fc1-81fa-447e289ec2df@intel.com>
 <bd608c7c-676a-4b65-97dd-626d0e8a5514@redhat.com>
 <5c74f231-46a7-4f37-8fcd-bff84842a923@intel.com> <auCyweUI3oWPN1V2@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <auCyweUI3oWPN1V2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/26 07:18, Chao Gao wrote:
> We then switched to the guest-only approach to avoid allocating CET_KERNEL
> space in non-KVM fpstates. The optimization could still be applied on top
> of that, but it was dropped after its benefit was questioned off-list:
> 
> """
> 1. It hacks in an optimization with conditionals around the edges,
> instead of integrating with the way the rest of the FPU works.
> 2. There is no proven benefit of this narrow optimization and x86
> maintainers are already skeptical.
> """
> 
> This optimization can be added back if it benefits kernel shadow stacks.
> But os_xrstor_supervisor() and os_xrstor_safe() would need the same
> handling.

That makes it more functional and less of an optimization. But, no less
of a hack.
