Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FC94C6F09;
	Fri, 15 May 2026 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864041; cv=none; b=U7NBdlp8k5Mel8wTN90jhGQjGQVopu9AtwiESrl/CMuJ4LplyZ0NqtBSFkYUakTdToGotLNiapaqAKNqVZ0meY6vTSS8eU83JGjueX1T/xvkVKY3zxF4i0X+fqYmm6vzFC3Jkt0bnkPPlw5I9jDTJypaHc9Ls3/Z5vgBXgLhdwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864041; c=relaxed/simple;
	bh=2fBKy8JoQa1+SzE35xDVCNt1VHL4lcANHN+S75ugGHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmNI2ekZt2HbGB8/fwwQLnX6uH/UXpww03Ef41CXeyrKoGUEPH3jyFL8QvcycPCp7vfb5WqxKjT/HXk+ZpG1LzMbcV4bo8Yk5Z2IA0F+x7dF7Clmi1zesPrdxTejfd2zGGTQHAsoFwQu2MhwHkdyUfZ4edvAepW3VQR6y658iZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EjaL+ClC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EjaL+ClC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778864040; x=1810400040;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2fBKy8JoQa1+SzE35xDVCNt1VHL4lcANHN+S75ugGHM=;
  b=EjaL+ClCGap2AeksdYkqJ58TbvZOvsr7/4VqLTA9M1KxSnoMdwaCyK1D
   2KFQoTSrwoyTUQ5TZsplw+MQFusIfTupxS+zA9P5uwYACkr9M82FUjUS3
   5b5G/p13S408WLmcSujEUX1O7vXl8Wz7pRWNQqoDVW4W5/6fiBXlG1C8g
   8a4/4MN71e4/cNpQcoxdwNYpdb5rKr6G43FMaWBpAMaw2XRWVM/pwWQw0
   I1Rk7KRRmeTEENR01dSyW+vUnNmvbY54Te2ofYfyxK7kUXHKY8yKOZ60j
   DC17E0Aq7efoKsKNNgOg62dA8N4WefNUhrt5rEWKCcoSBQbkC9sCrQ1/v
   w==;
X-CSE-ConnectionGUID: DuHv7l4YSaa3lgICqpYROQ==
X-CSE-MsgGUID: R5uT+IVlQICMGR4EHJ0/PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="102496610"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="102496610"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 09:53:59 -0700
X-CSE-ConnectionGUID: OJoC6tu+TDOqr3hiWhzkUQ==
X-CSE-MsgGUID: 2aw9FUGcTZ+LYB2TOEzRfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="238988217"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.108.201]) ([10.125.108.201])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 09:53:59 -0700
Message-ID: <5e097cb0-362a-4dee-af68-9ce583312c97@intel.com>
Date: Fri, 15 May 2026 09:53:59 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/23] coco/tdx-host: Expose TDX module version
To: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: binbin.wu@linux.intel.com, dave.hansen@linux.intel.com, djbw@kernel.org,
 ira.weiny@intel.com, kai.huang@intel.com, kas@kernel.org,
 nik.borisov@suse.com, paulmck@kernel.org, pbonzini@redhat.com,
 reinette.chatre@intel.com, rick.p.edgecombe@intel.com, sagis@google.com,
 seanjc@google.com, tony.lindgren@linux.intel.com, vannapurve@google.com,
 vishal.l.verma@intel.com, yilun.xu@linux.intel.com, xiaoyao.li@intel.com,
 yan.y.zhao@intel.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
 <20260513151045.1420990-6-chao.gao@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260513151045.1420990-6-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/26 08:09, Chao Gao wrote:
> For TDX module updates, userspace needs to select compatible update
> versions based on the current module version. This design delegates
> module selection complexity to userspace because TDX module update
> policies are complex and version series are platform-specific.

I'm not sure exactly what a "version series" is. Do you need to say more
than that the policy is complex?

> For example, the 1.5.x series is for certain platform generations, while
> the 2.0.x series is intended for others. And TDX module 1.5.x may be
> updated to 1.5.y but not to 1.5.y+1.

That's not much of an example, IMNHO. How about:

	For example, the 1.5.x series runs on Sapphire Rapids but not
	Granite Rapids, which needs 2.0.x. Updates are also constrained
	by version distance, so a 1.5.6 module might permit updates to
	1.5.7 but not to 1.5.20.

> Expose the TDX module version to userspace via sysfs to aid module
> selection. Since the TDX faux device will drive module updates, expose
> the version as its attribute.
> 
> One bonus of exposing TDX module version via sysfs is: TDX module
> version information remains available even after dmesg logs are cleared.

I honestly wouldn't even mention this bit. You don't need a bonus.

> +++ b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
> @@ -0,0 +1,6 @@
> +What:		/sys/devices/faux/tdx_host/version
> +Contact:	linux-coco@lists.linux.dev
> +Description:	(RO) Report the version of the loaded TDX module. The TDX module
> +		version is formatted as x.y.z, where "x" is the major version,
> +		"y" is the minor version and "z" is the update version. Versions
> +		are used for bug reporting, TDX module updates etc.

The "etc." is silly. Just zap it.

Description:	(RO) Report the version of the loaded TDX module.
		Formatted as "major.minor.update". Used by TDX module
		update tooling. Example: "1.2.03"

That's at least a wee bit of warning to folks about the leading 0 so if
they are parsing it they are a wee bit careful with it.

> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 8b739ac01479..b7f4396b5cc5 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -41,6 +41,12 @@
>  #include <asm/tdx_global_metadata.h>
>  #include <linux/pgtable.h>
>  
> +/*
> + * TDX module and P-SEAMLDR version convention: "major.minor.update"
> + * (e.g., "1.5.08") with zero-padded two-digit update field.
> + */
> +#define TDX_VERSION_FMT "%u.%u.%02u"

I hate "e.g.". I'm not sure why, but maybe it it often misused, or that
it isn't allowed by the style guide I had to use in high school. Either
way, please stop using it.

You don't have to modify this patch for it, but please stop.

Second, this was an opportunity to peel out the creation of
"TDX_VERSION_FMT". It would have shrunk your series by ~10 lines and
made this patch more obvious.

Again, you don't have to go do it, but it was a missed opportunity.


With those updates:

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

