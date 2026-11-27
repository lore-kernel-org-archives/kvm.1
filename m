Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795768026;
	b=WwrUfLi8LY2tGjn/cQ+pYFOdjl5d6i04GYUPLb1YRtxCm2EaoTblp24SAKDJeHCN+QB1
	 U4cP8uJjXdBWT3w6BJ62WJ3/Guo3poQ7r3kyrInQkq8lAn6+0k7NJG5O+b+Kk+MbImqtG
	 y4dZ1qaj0orYtJ89kVgwC+rybstYWRtXPBWBsZMBIbXRZF/haoytjGWU18QDtSkPUoFlp
	 AaawwhaY5R4OwisgtNV7Q8BzuFYQf4GvUMc4sPPzGVaJp4bxaICHyON8u1h3Jz92nu9r+
	 40U5HrbGcygDXqiyejUooJyn4eTKiXsH61+atu7THldC59ymzsSMj58z9CMKtY1AFeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795768026;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=SkSrPL9Bm07gIeaJwaWdw7FJu9rCcE8NZOTbA0li0j4=;
	b=0G/rPtKUK2QywrWSIiD+XVFwcDlmoG8StH6qlweCzhLsxGX0GrQ6GDL/cp+2thedH6zz
	 oKMkL93H4T7eijikccMe9PiSSJanaa9r6xwVeNi9eOGFlOAgk1GLNKNE0C+/FBWzDjf3N
	 qrAbC8q/KIqFTQS0TuWb7qtdz3wtsBO/y1I5WYlWNJsyAjmYde0DRmuVR6V1A3C/JsRGD
	 5cSbVyKn0wK3KKud/TZ6De6vFVAFWDod+1XYXcBU1994YpbDCSbbj8XRinx9Hr8JWRdQy
	 Y1Lds3cgJO9pOfjbHYbFr5I/IuH71lIzqrjJiXOk6hkx1p6sWHAnCvE0zrdSpggAfGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JxJsL9im;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3985606A31C
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 08:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3985606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JxJsL9im
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795768026; x=1827304026;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=srtf5w+a0R+Uz3aE3kXV9tLw0JLmjJmmnwBLPsLxMqc=;
  b=JxJsL9imtmsZfi+5Buiv7PT0Atg2bNuVH0CbHKohTZzLCdD0se1nIu4m
   KohpzLl+p9HT5WJuyqzIXZQu5kESFEIIUnN+aQiC3EhzLy1fDDYJZniFL
   17shZLwkVxjeZKA3/dsGDa/lDHmOd4GIsu7es1AWuY1+4C2htNyF09J1u
   Swfhxb+rfFFAW5+4w7N/xYB0QYk7AN64iFuvTC/wV6lv1a3v1+Q3udkrP
   xqh2/72QUQRsZVAq7OQjz0WNgQOiO/5qhI1UPjWIUTxwCctAX/3p6pxv6
   HiP3gw69asQZSCWXrQXtCUBif9aTgZJZ68oR6dvKFwvV0vx9Y9ONrBgCv
   w==;
X-CSE-ConnectionGUID: SRMugr7xR762MfOdB294Mg==
X-CSE-MsgGUID: ggf0NRC9Tpe3aO+27YHc/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4585841"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4585841"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 00:25:48 -0800
X-CSE-ConnectionGUID: tsfidv98QqGLFz7I9Crmeg==
X-CSE-MsgGUID: bCLpMw4NRlu5zIkxU1efjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12585685"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 00:25:46 -0800
Received: from [10.245.245.79] (abityuts-desk1.ger.corp.intel.com [10.245.245.79])
	by linux.intel.com (Postfix) with ESMTP id 6427020B8CD1;
	Fri, 27 Nov 2026 00:25:39 -0800 (PST)
Message-ID: <4c6adbb26d17917dfcad3fe0ea085234a0d487fe.camel@linux.intel.com>
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional
 KVM_CAP_LIVE_MIGRATION and KVM_MIGRATE_CMD
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>, Paolo Bonzini
	 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Jon Grimm
	 <Jon.Grimm@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, Tom Lendacky	
 <thomas.lendacky@amd.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton	
 <oliver.upton@linux.dev>, Steven Price <steven.price@arm.com>, Anup Patel	
 <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>, Jakub
 =?UTF-8?Q?R=C5=AF=C5=BEi=C4=8Dka?=	 <jakub.ruzicka@matfyz.cz>,
 =?ISO-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,  Vishal Annapurve
 <vannapurve@google.com>, Elena Reshetova <elena.reshetova@intel.com>, Kai
 Huang <kai.huang@intel.com>,  Kishen Maloor <kishen.maloor@intel.com>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Peter Fang	
 <peter.fang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li	 <xiaoyao.li@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	kvm@vger.kernel.org
Date: Fri, 27 Nov 2026 10:25:38 +0200
In-Reply-To: <20260831071304.762939-3-tony.lindgren@linux.intel.com>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
	 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
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

On Mon, 2026-08-31 at 10:13 +0300, Tony Lindgren wrote:
> +struct kvm_transfer_buffer {
> +	__u64 address;
> +	__u32 size;
> +	__u32 reserved;
> +};

I'd drop this structure and open-code the address/size fields in the ioctl
structs that need them. A buffer pointer plus size is a too generic concept
to deserve a wrapper - churn with no value add.

Artem
