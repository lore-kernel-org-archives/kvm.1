Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420328;
	b=q9P5C4OzUe/AecyvGA5NB55nQJq8Sxo0MvqT6kHyOa6C2o3VCNLMUPlqp81IHrKIHYPs
	 tj0MoGuvIVHMjpWmtuYLr2CrmPehUq7mQGizTMPdeFytl1yGmlQYMYu7h/4pge+NVsjzQ
	 HTHjGenV4ufceIeWNevVou9j8PhKUDcbsv5ynalZbJ4XhLvykrhEMBlLPukUps22QtV5l
	 I14UEqOgNcDtLI3HVG4pCZWPE4B37/QCAKR0xxnoXgK4gZdn1+cm1esreRE64Zmm8R5Jv
	 3k5fWDazjnbEcMQPyCyv3aM9qEF2ERgUk/8oKsQ9OSPHJGq2H7jNNzubhBmMZ+TIoHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420328;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=k/cLt6sLs/i57UjSMAYGmUyFLydITmwhGeX0xPWPgS0=;
	b=M7qWNAEwqtcojpvFGQKLZD8Bt3sk0jjFWU+cV0ZI+wH3+sgMaoCmVb304QX+d+qHSpgz
	 4GFaVfDoDQ9uVIsZkkxtzvH8bXKUYGZRjGY90xOt1uRR1NfSIBq/QyKjkt4qL12Yw/pCx
	 nNeR6NHNLzIko2ZcB0sjWvf9lbkafVLw2f4jZC76/FBu4vUWH13vwZ5aB2QFy88oIpODR
	 wqZOhNoz36vVNUrp1wA2yWUELLtxXWonLbNnu4lxlmjkrd78LuD+cpTjL8Pvbs/RjG01z
	 Knh3Cl986ClrMvCsoNwGJcxSt2n5mBwisxqx9whGX3C9Css1hgUOcBF5p4zXX9XR3AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=My9E5fxt;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFC2606A32C;
	Mon, 23 Nov 2026 07:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AFC2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=My9E5fxt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795420329; x=1826956329;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=k/cLt6sLs/i57UjSMAYGmUyFLydITmwhGeX0xPWPgS0=;
  b=My9E5fxte1lnXHEZB6P0y5PtNheYmtNAlBq2WyyFJYzCp8ghNT2cThwi
   WvpoBg42g8OeTery2amYeXdUDNSRt9wICbXti08jK/g042Kggykahs/FP
   Qr7oQRJfS27EBvCY6idHe12bLCz1R0ItY2Peyx3vg4SOc28soKxGxdCSI
   0h5UTi24gK1axJUrPX6qcWMBNCQUfs0mHKXfWAszYlBSxH62/hzuHsV3D
   djLPX2FdLYM0s1CL5JAFEbpMl6goA21AwPOx3F1NW6VHAHlR2J6RxsQ/7
   qTcJ9DBBv3omIbm7y7ME3M8yJJqqy3gpimvCc4S5dJFUTHp4Hwrc83R1q
   g==;
X-CSE-ConnectionGUID: AGuLlqC5T5uR/9u+18Ty7Q==
X-CSE-MsgGUID: GAv2nxHaT+O3uBGNRTX6Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4089504"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4089504"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 23:52:03 -0800
X-CSE-ConnectionGUID: SaASRl1uSRaMxGCpBNNV4w==
X-CSE-MsgGUID: Mg5Yn3UlTi63srEUJBum4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11568566"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 23:52:03 -0800
Received: from [10.245.244.212] (abityuts-desk1.ger.corp.intel.com [10.245.244.212])
	by linux.intel.com (Postfix) with ESMTP id D8B1C20B8CD1;
	Sun, 22 Nov 2026 23:51:55 -0800 (PST)
Message-ID: <31de312c72b2c4ac3b937c91005e24cd0631c876.camel@linux.intel.com>
Subject: Re: [PATCH v5 2/6] x86/virt/tdx: Configure add-on features on TDX
 module init
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org,  Kiryl Shutsemau	 <kas@kernel.org>, Rick
 Edgecombe <rick.p.edgecombe@intel.com>, Dave Hansen	
 <dave.hansen@linux.intel.com>, dave.hansen@intel.com, kvm@vger.kernel.org, 
	yilun.xu@intel.com, xiaoyao.li@intel.com, sohil.mehta@intel.com, 
	adrian.hunter@intel.com, kishen.maloor@intel.com,
 tony.lindgren@linux.intel.com, 	peter.fang@intel.com,
 baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, 	chao.gao@intel.com,
 nik.borisov@suse.com
Date: Mon, 23 Nov 2026 09:51:54 +0200
In-Reply-To: <awPtUgf+YZ0xfD6v@yilunxu-OptiPlex-7050>
References: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
	 <20261111-tdx-module-ext-v5-2-c74f764abc3d@linux.intel.com>
	 <d012c58931efa38a782ac3484ea930d05a6407a9.camel@linux.intel.com>
	 <awPtUgf+YZ0xfD6v@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-23 at 15:37 +0800, Xu Yilun wrote:
> The get_tdx_usable_addon_features0() in this patch is enabling all
> add-ons that *the kernel supports*. And this policy definitely needs
> explanation.

Ah, that part I missed, apologies. My suggestions were based on an
assumption that this patch does not enable any add-on so far, just
adds plumbing.

Thanks!
