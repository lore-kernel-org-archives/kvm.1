Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741571;
	b=OzEOxDQtzt/ZPZaZntEgv7YwWCZfF0U/lpOiUIREdZvjliSjylRaC6ob5+BEOfil5XqZ
	 f25lSuJMa7X6w6vmi8RHrTBBssVsmEEAV4QPZOCzOGqhahp9E5+vHSTf+j4vzEFnsGmn+
	 09DByY2Lh9+hugRSavp6ngrqpCI24xO3NStBk2/MhHzsuLN2ykqUcasrEzbD3znMuHoNd
	 I2wJsNVDTQ6ABS6YjZm+9fI/mg2HXxKmYA++qpbuz24uKC7sAZV0cgoUZejDc+9tObkSI
	 /CFqvn3TcRrgSsGIdpN9/9Yl5wbgf5x6Uh0e9JNrg+VzJwAn7XI4lWVv/4oP1+7HI+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741571;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=0vmqenTiO/Ur1kCgbPIkOxfDI3diR+fA38SWISXWKiE=;
	b=cBURQS9KAPllwP0ehE+/XO//xXoEmoz9SIutw7AvnMFZTCOI3se8CSlnQCntj9elx3Ir
	 axQyhUykP2tguOiFlP1182yWGghLh8OYitZchZwN0KrRbNhqDnRIgNXzJg40HaCLQDsEV
	 r2NqrkpSpOB/nx6zCLiVHLq5LNHAKfb8GiFz5DEXR9ZEfQWKRvRqze6/Le7cPO99L317a
	 2wXHc3/mxzPCWBvusi4w3bl2b6aYXUHvZm7Xzi1jBJDXagpiKZoEGmr/fIsUipUmua7Ak
	 apxgzpifdANWMk8+5LlWn/vTzRvANRuX24L4eV8qWkQQvET8wkf0wr41fs72GdKeOZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hO6HGJcV;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87026606A31A;
	Fri, 23 Oct 2026 07:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87026606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hO6HGJcV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792741568; x=1824277568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OnTZ37KIWGCoXkclN2187LudGkSSaXGYJfnRi2DcBeg=;
  b=hO6HGJcV7PZ6NTDk0hwSrSQR/frPm5UxVPj5Ecy04Dc4xZ6gLan4lE1y
   /iilB67bfAvJjcBvP6j6Tnj6IXFn/59KFR90qbhlciouz0LXxVAJybEf2
   TRwm9xuoepDnhNKKR84EnyiGMerT9y8m3O92bt8A3NvZnnSC/u5OFifCJ
   qOeAbLWWwyEmYywH5OoSuWPjsXFABgpiQgg1xwis7+e6XEMakw4y3RC/u
   OmLjl+tSKaLpmJBhmyk2MkATM50/zdh8shpj7LH2rmpz9wugSX1bpCL/z
   CSJeOAIl1/PcVDs+lEcWVhT5X4dKkKL0MbBe9ht220Pjq6EPG4a1v9+2a
   Q==;
X-CSE-ConnectionGUID: NmfHrBZWTKuWBsgqWswevw==
X-CSE-MsgGUID: oBGy4B1SRJWJ8MbRlvsLXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1386527"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1386527"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 00:46:08 -0700
X-CSE-ConnectionGUID: w9/qt7pnTJa6k/C8f18DsQ==
X-CSE-MsgGUID: sZ4QN/vgRpavWmprRCYObA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3451637"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.140]) ([10.124.240.140])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 00:46:04 -0700
Message-ID: <32413bfd-a448-483b-b2b5-7f4ff6cbc56a@intel.com>
Date: Fri, 23 Oct 2026 15:46:01 +0800
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
Subject: Re: [PATCH v5 5/5] KVM: TDX: Validate userspace CPUID input for
 KVM_TDX_INIT_VM
To: Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com,
 andrew.cooper3@citrix.com, nik.borisov@suse.com, kas@kernel.org,
 rick.p.edgecombe@intel.com, chao.gao@intel.com,
 tony.lindgren@linux.intel.com, kishen.maloor@intel.com, dedekind1@gmail.com,
 adrian.hunter@intel.com
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
 <20261016091422.3182216-6-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261016091422.3182216-6-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/2026 5:14 PM, Binbin Wu wrote:
> Validate the CPUID configuration provided by userspace through
> KVM_TDX_INIT_VM against KVM's TDX allowlist, and drop the hardcoded
> denylist-based check.
> 
> The TDX module lets the VMM directly configure certain CPUID bits for a TD
> at initialization time, but KVM must strictly govern which of those bits
> userspace can set, otherwise a feature that clobbers host state could be
> enabled behind KVM's back.  The existing denylist rejects only TSX and
> WAITPKG, and thus would accept any bit that a future TDX module makes
> configurable, even if KVM knows nothing about the associated feature.
> 
> Add tdx_has_unsupported_cpuid_cfg_bit() and reject KVM_TDX_INIT_VM if
> userspace sets any bit outside of the mask returned by
> tdx_get_cpuid_cfg_mask(), i.e. the same mask used to filter
> KVM_TDX_CAPABILITIES.  Don't bother intersecting the userspace input with
> the bits that the TDX module reports as directly configurable, as the TDX
> module itself rejects any bit outside that set.
> 
> As with the existing check, use the subleaf reported by the TDX module to
> look up the allowed mask.  For leaves without subleaves, the TDX module's
> "no subleaf" index is normalized to 0, which matches how such leaves are
> tracked in reverse_cpuid[].
> 
> Note, the change is user-visible, as KVM_TDX_INIT_VM now rejects some
> input that was previously accepted.  The ABI itself is unchanged: KVM
> already rejected unsupported CPUID bits, albeit via a denylist, and
> userspace has always been required to consult KVM_TDX_CAPABILITIES and set
> only the bits reported as configurable.
> 
> The change isn't expected to break userspace or guests:
>  - The newly rejected bits are no longer reported as configurable by
>    KVM_TDX_CAPABILITIES, so userspace that honors KVM_TDX_CAPABILITIES
>    won't set them.
>  - CORE_CAPABILITIES, which older TDX module specs defined as fixed-1, is
>    still allowed.
>  - The dropped features are either obsolete or unsupported by KVM, and in
>    the latter case, a guest relying on them would already have run into
>    problems.
> 
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>

The patch generally looks good to me. However, since it depends on Patch 1,
which, I assume, is going to be replaced by Sean's series[1]. If that's case,
the patch will need a rebase and adjust on top.

Free feel to add

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

if there is no big design change in the end.

[1] https://lore.kernel.org/all/20261022210134.612848-1-seanjc@google.com/
