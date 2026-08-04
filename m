Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927863DA7CA;
	Tue,  4 Aug 2026 23:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887028; cv=none; b=bOCw9RaZPwhLOYNRt7O1YD9NERlElo+1V3cUbuZDVjFtjxsO9pRyF73AuklksUk7Uadh2PqNhBRI9ow3ibuL1C1mEWVsBQH6GSxGbpooq0KsT7qxy1gktUMADCLP+hX9lGeJsKwmyE/Im8gIio4VTdG7t9834VAETD8RVjHVU/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887028; c=relaxed/simple;
	bh=Kzlmampl3B9EuybpZzFLmtBI1ka1Z0J+otMGegc3jaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANVyUOgtt299Wj05AAD58ZufjJ27DI2bp4GXcY218i3DcNGdeO0Cdr/IJmRF+94q97zLJrKdAWndwAAX+7rE43scWw/nZsmtDWbIXzlC6FKn624LxY2XVDZsttHNAW8NumCmJ3YLfunT3z0NNNKI9A0TrQPolC1NyckGXlPOB3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HA+vtzUR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HA+vtzUR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785887027; x=1817423027;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Kzlmampl3B9EuybpZzFLmtBI1ka1Z0J+otMGegc3jaw=;
  b=HA+vtzUR3gs3fzAJVAexZ+OmHtp4dCAhv+W00/2LTKnm60E8SHWtEUBO
   8Ziu7FBiIn5+zrIXn0Fyc2iaXF4cdnPgAzmytPAi6k7qY7sBKxVd46Ueh
   jX3sB27K7eOLbYIFvKwJcCmIlrLEB2ch6+p8R+tzNT/CR0uDGN6PNizuQ
   lEI+bODYOXwXwLMNrNk5A8gaWCPKS5IMqKAYfDGOsFf3Q7yfDBEbFQ5RB
   r0Z+oXp9taHvK1Vhm0/3Y6oL44qhUVyAwQ8cZU31BtJ2PH4Hb/wpFGlB4
   T/nGy9bVMzL6jeHz621O8twrr/vVOKV7G9NW/or/MLHX4UfYUHlgQN6RT
   w==;
X-CSE-ConnectionGUID: eCi6tmkrSzSZ6T3Vlx+8NQ==
X-CSE-MsgGUID: IAr1ZbUXRWWWk4EgjRzyCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97955578"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="97955578"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:43:47 -0700
X-CSE-ConnectionGUID: R9t4uPgnRJaLxJTVXYyvYQ==
X-CSE-MsgGUID: fxIRLV00QPOTRQHEx6tJDA==
X-ExtLoop1: 1
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.19]) ([10.125.109.19])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:43:46 -0700
Message-ID: <43bb043e-8a01-484e-905b-41c73ae835d3@intel.com>
Date: Tue, 4 Aug 2026 16:43:43 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/8] x86/virt/tdx: Stop treating tdx_global_metadata.h
 as auto-generated
To: Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org
Cc: rick.p.edgecombe@intel.com, kas@kernel.org, dave.hansen@linux.intel.com
References: <20260804112941.19894-1-chao.gao@intel.com>
 <20260804112941.19894-2-chao.gao@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260804112941.19894-2-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/4/26 04:29, Chao Gao wrote:
> From: Dave Hansen <dave@sr71.net>
> 
> The TDX module exposes its capabilities and limits through "Global
> Scope Metadata" fields, defined in the Intel TDX Module ABI spec.
> The kernel mirrors a small subset of those fields in C structures
> (for example, struct tdx_sys_info_version/features). Those structures
> are populated by reading each field via the TDH.SYS.RD SEAMCALL.
> 
> Today the header that holds these structures is generated by an
> out-of-tree script from a JSON file listing all of the TDX module's
> metadata.  That made it trivial to add a new field, but everything
> else suffered for it:
> 
>   - The header is opaque to anyone who doesn't have the script and
>     the JSON file handy, and the "Automatically generated" tag tells
>     reviewers their edits will be clobbered.
>   - The script ships outside the tree, so reproducing changes
>     requires fetching it from a mailing list link.
>   - The structures are short and stable; the script's value over
>     a hand-edited header is small.

Well, and the big one: after we started doing this, the "ABI Definitions
for Intel® TDX" was declared to be not an ABI. So, even if we code to
the JSON, there's no guarantee the JSON will be stable.

<sigh>

Honestly that's what matters. The script and all the other fluff is just
noise.

> Signed-off-by: Chao Gao <chao.gao@intel.com>

So, I'm curious: What made you feel OK to sign-off on this? I'm not
judging. I'm open-minded on this. All I know is *I* wasn't ready to
sign-off on this.

I really want to know what your thought process was.
