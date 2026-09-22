Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EF637F75E;
	Tue, 22 Sep 2026 02:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042560; cv=none; b=sFDZ2aTNc2keSNJv7QwxJix32l7Pos5PdAxmdAcPtQ+IkGp9DB4KW4HXTsXhSfosZWSMp+Rt3Z+LFjMhf28aRAEmkM3+5qM2KroR95IhPXp/o9IgB368ox0p5UThflttT3EcjArN9VGZNqxSzLcQqmDH4KfXbmKFlu64s1rZeok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042560; c=relaxed/simple;
	bh=FkvSa0r2hQpc8Adrt+6G1en3MkyfPXKYa3vL0SOYLO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZ8F1n80Fh7J0jENAS56klOC1+Tcde3JCeXfe4rsrg6IYT1Jf/06hpdpKSlJsAPK6pZb6XAOZ+iwxTTwZV1xgo3QFISPyCIsy7ylTHSh3EriMh0sZNcvrJB4q8JPMMJLO9fFkaiNQpD04U7+FzQZ/L0jHuIS43Ac4C7O+rUCbr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HSPvmrn4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HSPvmrn4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790042559; x=1821578559;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FkvSa0r2hQpc8Adrt+6G1en3MkyfPXKYa3vL0SOYLO8=;
  b=HSPvmrn4x0VKbKDBAFm/eUs9nuAgvWLOiBDjutyVVCJeJQfI8554boQu
   7S8vGU+O0GSt78akkqYfuBELkLSF2VFTD3Fr4cQn0r1TK/akCrk9IxfZc
   IjcKW6gCIRWmxZ6AkOiBAKK/yQuu+38E6lWjbfyekyfLA5n68TRCrJsg6
   WTnBxBZZh4LGOSvKFXc6TbcJ2zN5PBDYjDeV0MiV6ol/TQQhD2LTyRDL4
   pUvxkOtUcDFTyX75DENH19+CurPFYyQ2Tst8P75WdYjwPxZ2LnQwkuLAY
   VG5l9Uub1YOY6PO8Ktj+F8+9q/c2rc9gUsKvBK0eGJWT3yXK0O8yaFTsW
   w==;
X-CSE-ConnectionGUID: aPqkNV39SaWcvA+3//oe6A==
X-CSE-MsgGUID: nsIP5G66TnyaoA2/1ZTRWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="108105198"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="108105198"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 19:02:37 -0700
X-CSE-ConnectionGUID: VvDIpI/0TXqAbWyrKf9vVA==
X-CSE-MsgGUID: M8z5qtwOSZO+Tk9fw+SyKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="3904516"
Received: from unknown (HELO [10.238.208.182]) ([10.238.208.182])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 19:02:34 -0700
Message-ID: <d5a4ba72-3cce-4f16-ad47-f1c82c85d834@intel.com>
Date: Tue, 22 Sep 2026 10:02:28 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] KVM: TDX: Enable VM-DoS Prevention Features for
 TDX
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 nik.borisov@suse.com
References: <20260819094903.3060020-1-xiaoyao.li@intel.com>
 <6d9113d7-cfae-480b-908a-5cb52020a6c8@intel.com>
 <arHDAVhFXeQXXrfI@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <arHDAVhFXeQXXrfI@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/2026 7:51 AM, Sean Christopherson wrote:
> On Mon, Sep 21, 2026, Xiaoyao Li wrote:
>> On 8/19/2026 5:48 PM, Xiaoyao Li wrote:
>>> Hi all,
>>>
>>> This is v4 of the series to enable the Notify VM Exit and Bus Lock VM
>>> exit for TDX, which fixes the KVM CAP issue related with them and allow
>>> userspace to actually enable the features.
>>>
>>> Compared to v3, this v4 adds 5 more patches.  The first 8 patches target
>>> for stable kernels while only the patch 9 doesn't have to.  Patch 1 is a
>>> single patch to enable Notify VM exit for TDX.  Except patch 6, patch
>>> 2-7 are mandatory for enabling Bus Lock VM exit for TDX in patch 8.
>>>
>>> Patch 6 itself is a fix for VMX and is OK for cc stable though maybe not
>>> necessary.  Patch 6 is added to this series since it can help stop Sashiko
>>> repeating its finding of VMX's pre-existing issue, and it's also necessary
>>> for patch 9 to consilidate the exit handler for VMX and TDX.
>>>
>>> There are other issues of existing code found during previous review, like
>>> the EPT MISCONFIG handling.  Given they are not mandatory for enabling the
>>> Notify VM exit and Bus Lock VM exit for TDX, the plan is to address them in
>>> a follow-up series separately.
>>>
>>> Please refer to v1 for a full background.
>>>
>>> v3: https://lore.kernel.org/all/20260812080229.2481439-1-xiaoyao.li@intel.com/
>>> v2: https://lore.kernel.org/all/20260810112200.2326727-1-xiaoyao.li@intel.com/
>>> v1: https://lore.kernel.org/all/20260805031257.1844914-1-xiaoyao.li@intel.com/
>>
>> Hi Sean,
>>
>> What's your plan on this series? Can you queue it if it looks good to you? Or
>> need me to spin a new version to address Binbin and Rick's comments on the
>> commit message?
> 
> Get it applied, with some tweaks.  I.e. no v5 necessary.

Thanks!
