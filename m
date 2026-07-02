Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724A9242D65;
	Thu,  2 Jul 2026 01:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782954766; cv=none; b=YF57hBOn4cXKjdnh3HxVtJkpJpAKt7hgI78MTufc3xDeCRzXAhWaBDehGfo3tVGgcVfixD4yYhjIN0iFdD/oI+w6mM+s274ivMbIqCvd2/VNA1xCvKnn1kJxtLkivWM52x9Rn2nHSXXyJsZ3zZ1gNUz5kB/ervD4L6Le9RH6yL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782954766; c=relaxed/simple;
	bh=kw9j4CCslJ7mGO/vFNSblXjeost3Lkvw7vwjFJDhYg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0lwUnSubM1Av2QFSjJ8RFx1ZgkVJxKY4rGOG2cgY4FuwgD8ZM1EDlP7TRyw8sNDMPJlcEvVho44zrb84L7IDe5Twi7wYOzCAXd2ykHR8dXs8o+2xmBHNGtFa5HGXfHsIQFPPM5/QSm0gsgW3uxmz3iNHyPT38ORknnC/Mbled4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U16IKiMn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U16IKiMn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782954765; x=1814490765;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kw9j4CCslJ7mGO/vFNSblXjeost3Lkvw7vwjFJDhYg4=;
  b=U16IKiMnU7m677cxLvb2puEhrlxFCVcmlaHrUyimK8j67afLtmG+GI6J
   +E1QeJUmg9ctZ9GtouuxbPdEpSoohPsSms1ElmNdgzPdtpPN4uoDFWl+7
   zcP6qC0aXHwCCGmWJleNxriGNYyOaJrPZ+RzzLkUwZOr4RuD2uL8xXKqU
   Gx+McGH9hHe1sjx7GYStDEvMZZKRXyeNQNe3q0/7X43JbnclGZxwRbD1h
   xFP7dBwCQ48Ns/s82H00CAMOU0swLMmjhpwMzuWRFXZBMoYnkLPXqTrVr
   n6/M2WBPPmY9b8fe/NQ7nkN4VGhEsKpzn94WePZZtG0HxZwTaGboeLUKE
   w==;
X-CSE-ConnectionGUID: K9qHLIHeQjWHWRrlTWMamA==
X-CSE-MsgGUID: AlDJbJLBT3adb4lMklfsug==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83749024"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="83749024"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 18:12:44 -0700
X-CSE-ConnectionGUID: xzefGzGhTVyhugi+mMGbgQ==
X-CSE-MsgGUID: mLLqeVKKRM2/cQIZgebxfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="277028342"
Received: from unknown (HELO [10.238.2.244]) ([10.238.2.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 18:12:42 -0700
Message-ID: <ab5f7b2e-6df6-40bd-83c5-5f245b679548@linux.intel.com>
Date: Thu, 2 Jul 2026 09:12:40 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] KVM: TDX: Return EINVAL, not EOPNOTSUPP, for NULL
 INIT_MEM_REGION source
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Sashiko Bot <sashiko-bot@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Ackerley Tng <ackerleytng@google.com>
References: <20260630213711.479692-1-seanjc@google.com>
 <20260630213711.479692-3-seanjc@google.com>
 <323a9a1a-6cf9-4a68-b92a-867f497b3d34@linux.intel.com>
 <akVKgY6JK9im5aDZ@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <akVKgY6JK9im5aDZ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/2/2026 1:12 AM, Sean Christopherson wrote:
> On Wed, Jul 01, 2026, Binbin Wu wrote:
>> On 7/1/2026 5:37 AM, Sean Christopherson wrote:
>>> Return EINVAL instead of EOPNOTSUPP if userspace attempts to pass a NULL
>>> pointer for the source page of INIT_MEM_REGION, so that KVM's ABI is
>>> consistent between TDX and SNP (for LAUNCH_UPDATE).  EOPNOTSUPP was chosen
>>> to be a forward-looking error code for when guest_memfd supports in-place
>>> conversion, but even when in-place conversion comes along, it's an awkward
>>> error code as KVM is deliberately choosing to disallow virtual address '0',
>>> which is technically a legal userspace address.  I.e. it's not so much a
>>> lack of support as it is that KVM reserves address '0' to simplify KVM's
>>> internal implementation.
>>
>> Nit:
>> Do you think it's worth calling this out in the documentation?
> 
> Yes, though that can be done separate since this series doesn't change ABI.
> E.g. we can probably do it opportunistically as part of the in-place conversion
> series?

Yes, make sense.
