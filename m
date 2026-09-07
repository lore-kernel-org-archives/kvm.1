Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8205347D450
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781999; cv=none; b=kroHdtbIWmXQkzTMeCBuzIDai7r39s3uphPYlLVj0/j8UnYsMY/O0RuzFhdLy50TijVbEH+aXlcxmMbI4H3EqY0mol+bTNxZ8UJQU0YOG+4VoEn1cOPpu44g5r9FlyO/SWgq8+tb1d6JdO0kwBl93QCU0LcvuRebKMuhqlD9j+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781999; c=relaxed/simple;
	bh=Vj6wAw3VEEKt0qtNDScJmMYhFE4eDIBgmNJZHTaTBZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhRwXYvWMtFw/OCK/DxOisNlepMv8hpMQ9K5FMFW6w4V6Ha+kax/u349vevzJWFthNbuivsnyukcgINHgN8By0RpZZgCoRv39cV3XVkJVeX24fN8wphdZCg2EBOhcK9zuDf4gZpSzaVYyWW/XqFyba4Vd1rwC5Wc2ea9whL0XZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQU0EmVF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQU0EmVF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788781998; x=1820317998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vj6wAw3VEEKt0qtNDScJmMYhFE4eDIBgmNJZHTaTBZs=;
  b=GQU0EmVFLreThwlzhXq63N6wpbgHb3UEIXqRQz6tRzmdBjUscBZ8Bvl5
   Lhk9gK7NhIZcjoBjG4eXGlkPduXNBgXDkpoL1y6ak/AO/69SD50ku3m6a
   +gPvY8+tMJMz2srTLW2x1lb7wxBvUlX+IkNMaJv1sFmOQJP7xTt80Nn+/
   ELwaxm/ggEQdKOefG9ldk2rHoV687xdkj7MmzXQYoNJ/eI22qz/rBGO7e
   cI3dZeYkLDQO72kLr3VKosmaJ3Ud+I4v1Pxhq+fXxaaGpCTRxbeU6/OI6
   UCqpatwWYUO4ckEJOWyrq0c6Gm+PM6Vww8iQ1VZA7A10V+FLrPSw6vV85
   Q==;
X-CSE-ConnectionGUID: f+7kZGGnT5yUym+vVdfP6A==
X-CSE-MsgGUID: 67veK/cLTeWbkub6nCDXZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="93050209"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="93050209"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 04:53:16 -0700
X-CSE-ConnectionGUID: w0ZAmBNKTayHnLkex/udMA==
X-CSE-MsgGUID: YxQIvbRrTPKbq9GiHiKaGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="271205092"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.57])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 04:53:08 -0700
Date: Mon, 7 Sep 2026 14:53:05 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Peter Xu <peterx@redhat.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Fabiano Rosas <farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <steven.price@arm.com>,
	Anup Patel <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	Jakub =?utf-8?B?UsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?iso-8859-1?Q?J=F6rg_R=F6del?=  <joro@8bytes.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
Message-ID: <ap6loazXtvSCqmpR@tlindgre-MOBL1>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831071304.762939-3-tony.lindgren@linux.intel.com>

On Mon, Aug 31, 2026 at 10:13:02AM +0300, Tony Lindgren wrote:
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1670,4 +1673,23 @@ struct kvm_pre_fault_memory {
>  	__u64 padding[5];
>  };
>  
> +#define KVM_MIGRATE_SETUP		0
> +#define KVM_MIGRATE_ITERATION		1
> +#define KVM_MIGRATE_STOP_AND_COPY	2
> +#define KVM_MIGRATE_ABORT		3
> +#define KVM_MIGRATE_END			4
> +
> +struct kvm_transfer_buffer {
> +	__u64 address;
> +	__u32 size;
> +	__u32 reserved;
> +};
> +
> +struct kvm_migrate_cmd {
> +	__u16 command;
> +	__u16 flags;
> +	__u32 reserved;
> +	struct kvm_transfer_buffer buf;
> +};

For the common flags, KVM_MIGRATE_CMD probably should have migration
direction. Or maybe we could have KVM_EXPORT_CMD and KVM_IMPORT_CMD.

The migration direction is needed early for TDX. We currently pass a flag
for delayed init for the migration destination in KVM_TDX_INIT_VM. This
is to prevent the TD and vCPU init SEAMCALLs on the destination. The TD
and vCPU are initialized only later on with the import calls.
