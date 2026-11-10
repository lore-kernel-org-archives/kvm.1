Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314553;
	b=Mer85/K+XmjnOnc1rVJaL1ngxv8Jn/p/uiApoPkQw59SEJzZCdLCYSb116xdwCWxdbt2
	 /0LchGTRNJvdo8D7gvtQOIDW2Vxk5iYyqNLhhGBOQgEs6X+yU19RYnybe1iLbCILiz/Bj
	 +UeikLwN5yqoAstyM4YzS9b8KxGPnyphgOYS22/WhDlReQZlWR3MjUZauQb2lo0z/DBVC
	 LSLRGGfDWznUsZhyswU55xVvvwZNLGs0ktO5X4dxrbXIaj6M78zBXzJ3CViW1sWXW/WQG
	 gDWXdDXLRpfjDSCL4Ue/CATpFkxxKDQqCQMFScp1WEeocXXGA7TzD6zxZdSs8O9oMPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314553;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=u5SJhx0uN8f0xkp5nVpcIHHCQXZAvgQAW4sa6y83OM4=;
	b=ri+/VmFXQYvxarbz82ihPOBJhikzthLU9WM+5s0XQDvW3DdBDGLhrhPeT4V8S98TkTeX
	 PUGwxDwOaevaz/JjbdfiUmfukTDFZD3oij3DyTPN6g8prvKPmQONDwtU2Ccz40+1alOHf
	 Ql3EWB4DWukecHfSjGdGNnJsRiJ1m9kbeg+bFareYFPD2n3A+tvyJLyDtq0AwatZ1GspF
	 FcGqpOLxcweEggK1MEp1Yc2ymaFPg5b2/CTJZ4eaaEebBkEpB/zm9CcBdTQc0DGfB3B1v
	 60WLvLwhOBmnlFBU+FWi80DuVTjbbFXGYtYaEugYprttNabJrkr3RxfoTQgUAD+28BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="APRjc/Sc";
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C89606A333
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 12:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70C89606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=APRjc/Sc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794314552; x=1825850552;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=4f1/JbJEc6iwOF4/Zc1eG20czIZ5ns5wDzKkIqMs/SY=;
  b=APRjc/Scd/RzA268Mtau8x+7Xxuu35KYb2nXmstPN9G2KoiI0LeyXo2t
   LwCnNnk1svSSf6qsiKNLKd/c0oYYD0G5juCsXXniad7fY8bc3GAXRU7Yu
   iroU6UTSmMAtNsf77rM6xd60BQHHlJ7zDdbVJBwfxk8QZ+V9Sj+17imm/
   iQodjtWnW2kH3ECACDwiF6JcHCQpNZ8pIdiX9yYaiDDyUdwHkQgev2iJg
   NPvVTm7+JGN1zXbbmrFfkwmqzD5o+9j1AhlpvFjqIOGaLYc5kt+caHtVh
   94jGv1i5QLSmcv30JvLOxyAK7oaV55Yq2izFN2z9mt4OjXEMVNQ5zojwc
   Q==;
X-CSE-ConnectionGUID: skNhifkYTBWTkwckiz5BcA==
X-CSE-MsgGUID: 1KaNjxMxS5qeeG3I+1Ichw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3095602"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3095602"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 04:42:31 -0800
X-CSE-ConnectionGUID: cDYGt7P7QhOMvZa6p8q2DQ==
X-CSE-MsgGUID: hQnKdKpoS3iW7yzNUmBOyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="10008643"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 04:42:31 -0800
Received: from [10.245.245.51] (abityuts-desk1.ger.corp.intel.com [10.245.245.51])
	by linux.intel.com (Postfix) with ESMTP id D0E3F20B8CD1;
	Tue, 10 Nov 2026 04:42:23 -0800 (PST)
Message-ID: <61437761ac1bbdf10204084c08a066ee6168feca.camel@linux.intel.com>
Subject: Re: [RFC PATCH v2 1/4] Documentation: KVM: Add live migration API
 for confidential guests
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
Date: Tue, 10 Nov 2026 14:42:22 +0200
In-Reply-To: <20260831071304.762939-2-tony.lindgren@linux.intel.com>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
	 <20260831071304.762939-2-tony.lindgren@linux.intel.com>
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

> +  /**
> +   * @command: One of the defined KVM_MIGRATE commands
> +   * @flags: Hardware specific flags
> +   * @reserved: Reserved for future use
> +   * @buf: Userspace buffer for hardware specific data
> +   */
> +  struct kvm_migrate_cmd {
> +	__u16 command;
> +	__u16 flags;
> +	__u32 reserved;
> +	struct kvm_transfer_buffer buf;
> +  };

I think everything should be _u64. And there should be something like

__u64 reserved[14];

with a requirement to be set to 0. This may be useful for possible future
extensions.

Rationale: If the system can afford CoCo VMs and their live migration,
this must be a relatively powerful system, 64-bit today, where we do
not need to save memory by using __u16 and __u32 and not adding extra
reserved space.

Thanks,
Artem.
