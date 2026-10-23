Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740954;
	b=yzSU4mbu/eCn6OYhB5J3soDFEex0g+JLimjejuoPsePMPhjJMPesUqjTNt3UB3Q7WXxj
	 YKfyOfPgbqNymCOwD40az0cf46VXkKsB4R030EAuoI6v6vR22jqFFUzhm+z1z6eR9E5ks
	 LS8n/gmz0OoIJAsmK633QO31yv8EBy//IiOAWJFC4iMxikPxAosY7QIRFQ9EVxipD75tW
	 5NHKT4NblMwO+VKPKisKneYGLt044a/PZoX/E5Wxn59K/Jj8FkzuDpPc12XRIUMuYU34j
	 jQQw6xIvEqk6jHgCForfv1ZDVVBfRSFtMrQ+DBASBMDPj7ldK7YYLBRq22d8JIrFZ0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740954;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=BiSGyXP+QREGK8Wc3PsIZ74qAfaabzY3QdOQ4ZzwHqc=;
	b=KjPrXTADHD283XwcrsUMOj/tc7Rwjiyjr8ezHFXKiYviJeEFgZZJoQgQ+I1/POVThEzg
	 ieqJFoGK5NStNhk/3axr0ZvuqA/L07bubZnbD0ju0BfdNKsg8J05egu6lGxLoB6U2189Q
	 EfQcw3OHo1sZNTkCqxxR05Z6F0RAUc1h1QSslAf5WFdcRklrs7g1TYijTfv4uAl+U29CK
	 GpnBAxOPSa6efIY387OpnloHMxzmn9r0dX+g/FxOXQFW7S5sJeue1c1JZNzM+ohVKgmeO
	 FF4DDiT9W+yHRLOFwQeBgAc2JQ1XODS26Qy9bIxecoQFJVylz6xYoK40x8UaaFn5cPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DQqAWdxZ;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189D2606A31B;
	Fri, 23 Oct 2026 07:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 189D2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DQqAWdxZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792740953; x=1824276953;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/Hh7+3oi7jgWem1mXOHUTK/RhapmmdmtrNhmLTg9f4w=;
  b=DQqAWdxZozMRL0zosEI8pkCRSvOz9sZkntt/yD1/mfBMCxX+rkbS8x4M
   JZ3zTc97noiBs/ywWRzZsEUq/H1kWztFY3OVsZPNFw1Yv2sziQ8S+inCZ
   YcWyOpa1mRLjX5HsoEefG2ZaXmgvGXTDM4eOx5wti6WJuTPKejwN25yo4
   +bdy9t8+P3imJXB/+pve3tB1I2qsTrfMdmElYYamED2er/DEaMfZr22e3
   4bhTY//eq4PWmQj2OSgJfNHpz5aC5lar6fLvOkr5s0AuOHDY7H+Mr/WQT
   VXxftN0jO65taxPPojQrG9YIbBu2cvoPwHPbXAaYQlI8ifVaamQdrM0Zn
   A==;
X-CSE-ConnectionGUID: XPBZJlJKQviMyuB91wJBoQ==
X-CSE-MsgGUID: Wnd9agbuSwaoXmdE1krRsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1505345"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1505345"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 00:35:52 -0700
X-CSE-ConnectionGUID: ueGbc93rS56AUEaQ9aM7oA==
X-CSE-MsgGUID: QOnkwFSGRVaA92A8tUCSpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3946840"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.140]) ([10.124.240.140])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 00:35:48 -0700
Message-ID: <a2f3ce61-6451-4464-9d33-07bdcfd2409a@intel.com>
Date: Fri, 23 Oct 2026 15:35:44 +0800
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
Subject: Re: [PATCH v5 2/5] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
To: Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com,
 andrew.cooper3@citrix.com, nik.borisov@suse.com, kas@kernel.org,
 rick.p.edgecombe@intel.com, chao.gao@intel.com,
 tony.lindgren@linux.intel.com, kishen.maloor@intel.com, dedekind1@gmail.com,
 adrian.hunter@intel.com
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
 <20261016091422.3182216-3-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261016091422.3182216-3-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/2026 5:14 PM, Binbin Wu wrote:
> Add tdx_cpu_cfg_caps[] to track the subset of TDX directly configurable
> CPUID feature bits that KVM supports, and initialize it during TDX
> hardware setup.
> 
> The TDX module reports the CPUID bits that the VMM can directly configure
> for a TD, but KVM can't blindly expose every reported bit to userspace.
> Some features imply additional state, e.g. MSRs, that KVM must context
> switch across host/guest transitions to avoid corrupting host state.  The
> existing hardcoded denylist can't account for such features introduced by
> future TDX modules.
> 
> Aside from a few fixed-1 bits required for basic TDX support, features
> that can clobber host state are either directly configurable or controlled
> by TD ATTRIBUTES/XFAM, which KVM already validates.  Thus, an allowlist
> covering only the directly configurable bits is sufficient.
> 
> Organize tdx_cpu_cfg_caps[] like kvm_cpu_caps[] so that the allowlist can
> be built with feature-name based initializers.  Directly configurable bits
> that aren't feature flags will be handled when building the per-register
> masks for KVM_TDX_CAPABILITIES.
> 
> Sort the directly configurable CPUID feature bits into three categories:
> 
>  1) Features that KVM supports and tracks in kvm_cpu_caps[].  Use
>     TDX_CFG_F() so that they are also capped by kvm_cpu_caps[].
> 
>  2) Features that KVM supports, or can safely allow, but doesn't track in
>     kvm_cpu_caps[], i.e. MWAIT and HT.  Use TDX_CFG_INDEPENDENT_F().
> 
>  3) Features that are obsolete or unsupported by KVM, and thus excluded,
>     i.e. EST, TM2, CID, SDBG, XTPR, DCA, PN (PSN), ACPI, ACC (TM), PBE,
>     HLE, RTM, CQM (RDT_M), RDT_A, PREFETCHWT1, WAITPKG, TME, PCONFIG,
>     CORE_CAPABILITIES, RAO_INT, FRED, and AMX-TRANSPOSE.
> 
> Excluding the features in category 3 shouldn't break userspace, as
> userspace is expected to consult KVM_TDX_CAPABILITIES for the configurable
> bits before invoking KVM_TDX_INIT_VM.  Nor should it break guests, as the
> features are either obsolete or unsupported by KVM, and in the latter case,
> a guest relying on them would already have run into problems.
> CORE_CAPABILITIES is a special case; it will be allowed separately to
> accommodate its legacy fixed-1 definition.
> 
> Future changes will use tdx_cpu_cfg_caps[] to filter KVM_TDX_CAPABILITIES
> and to reject unsupported CPUID input to KVM_TDX_INIT_VM, so that directly
> configurable bits introduced by future TDX modules are neither advertised
> to nor configurable by userspace until KVM explicitly opts in.
> 
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
