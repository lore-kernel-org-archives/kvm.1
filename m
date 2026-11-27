Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795768634;
	b=wqQ72BSOH28u6p8N9ycdhai9M0vKTsMVy/9oZZNbXJFsdEwEIp3J7gEpfA2RenV+Jhfy
	 ViXFfI++JjWTnrr3PHB46jOLc9OO7RrgKnFVz2IydYV0S5wGcWrQ0gclOCjRfKeAgvglR
	 8AhH45Xy6S8LBNVd/62LrzLMUk2IHTAVKFrRtZOU4rBZxfdECf2hAIOaBi3dMWJSKeCt4
	 kijTsOauvVO+Ee4uO3RuaofPJFKI85EFpNAfpjBGeCB+g9gSv47oBd63xveTx6aJg24c8
	 VHGQ8QpSsNzrdKXxiKKiDW5bi0s4yzOD1XL36KHIHpwUXDIgw+0Emwbb7B5Z++rb43Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795768634;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=aoD5ZU0Ax035MhIif0CVeC1FMUoh5FDPG0Ma0ycRi6U=;
	b=TyJCKXsFwuyQsTAxkqEELBXM5qRq2LzgWS2dZ0QX8OR9Zpc1fsmpSNqmYJbe0p2cOyGJ
	 6KhBXsTIA3OxPasL/4Ttyy9RBGivaBmLf9Ajd+TDS6SMzMs5LK6cG09s5UwHV1W5cuV2u
	 0vl4f8BzcbauDNuEr4xw90DYOH0/ZHkrYNvQ35mDSDMiC1TJyEQGGCDx/slppMePoyaIX
	 OhevzpG/lLrS0ncEQez9tPg2+Au63cxME/TEyFPR52z4UdDQ9XtcX+I33q3PBYF4Fc3by
	 WOT44sWDkic+6wqkl2g37zWNlvGGN1G5GuUaMly+iv+CasnFkwqCkqs2mjxlf+TV2LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FnBNeGvB;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0A8606A31C
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 08:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C0A8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FnBNeGvB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795768634; x=1827304634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QTIUzwStxHR1j40nWWmzEH4ufeNzRxO12slU7HmAI24=;
  b=FnBNeGvBjQAzsU+MN8a69oPr9uj3LS4h+Cimynt7o45T6N+MdOIgikwT
   aZzlSXsrPMbFE4DnRuFjP/nRaq3g1ThfElIPOnbaudshtQWNCxxD6wCwQ
   7No2P3O8RXvkBgJqcK780YRwIGk/oxDVYiMATmjWq9/AoLTFXDQvMS6Dx
   VvIbYrw9Q5k8OHWWAH+uCjwdstoUY5VWNIpwKZ1TMrBem6sKWTUS4h32n
   SFvgTjIZfEYJwYVL7IY8H/diRjvPF8EtfBaZNF7BjiRmA6kuIcFneTTyG
   oBcQxeIIQGzd1OW6rSSSRyOkrk7CHxGXtUGJB0TMS3vmNqtWk/PTvkawX
   g==;
X-CSE-ConnectionGUID: smXakGg2QDOlV296hW1LPA==
X-CSE-MsgGUID: 6ZdjLzvLQvWPOlBiatFF1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4675977"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4675977"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 00:37:13 -0800
X-CSE-ConnectionGUID: 9iOYWQI/Ryi3+ZIuFtEb7w==
X-CSE-MsgGUID: 9XaCslNpQPmUSZTCm3R5sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12593050"
Received: from wgawrons-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.241])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 00:37:06 -0800
Date: Fri, 27 Nov 2026 10:37:03 +0200
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
	Jon Grimm <Jon.Grimm@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <steven.price@arm.com>,
	Anup Patel <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	Jakub =?utf-8?B?UsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
Message-ID: <awlBLxncSkFfPoIm@tlindgre-mobl1>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
 <74c6eec32fec9b7db75a8b4cd7f8e00d581eab5f.camel@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74c6eec32fec9b7db75a8b4cd7f8e00d581eab5f.camel@gmail.com>

On Fri, Nov 27, 2026 at 10:33:40AM +0200, Artem Bityutskiy wrote:
> On Mon, 2026-08-31 at 10:13 +0300, Tony Lindgren wrote:
> > +struct kvm_migrate_cmd {
> > +	__u16 command;
> > +	__u16 flags;
> > +	__u32 reserved;
> > +	struct kvm_transfer_buffer buf;
> > +};
> 
> In addition to dropping 'struct kvm_transfer_buffer', we need separate
> input and output buffers. Reasons:
> 
>  - TDX requires them to be separate: using one buffer for both does not work
>    in corner cases such as update-while-setup.
>  - We can't assume other CoCo implementations can use the input buffer as
>    the output buffer either.
>  - It is also a cleaner API.
> 
> So I'd like the next version to have two buffers, each with its own pointer
> and size: one for input, one for output.

Makes sense to me.
