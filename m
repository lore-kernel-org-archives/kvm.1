Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE6C358378;
	Fri, 15 May 2026 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778831162; cv=none; b=A5v7Bv8YNp/3OIjbS3ahr6jIy6vjdXTMLL8kBlthSnEywUPNF99Kg41iOLKqRMcb2RKohrG7u0V/TNBNWceoGiKSzPG0JVNQFUx8DFO4ABbrVe0sEkJQYp1kLa9Nn8jnIRaJ0H1ABKUFXWsuBXwqu5l6OzV44n0ZkjszgWreVn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778831162; c=relaxed/simple;
	bh=4RO+f8JYea9b4Wfb+Qd/P0Njf8806ykVDwdXLHD2yNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouqwnA3Mq+J7D921hOYaoBgbPaam/K0WFTnpsWIgLJ5SOa+864vEnLZ+fno75sd/GDZFQEnPYrJk5RQSDpg5LNeDjVZMFlF5QMlqhW8DFRrKAETijJZU0oOB/vsOSZB+zHtxiy5bOtwHffrvT+1jST9lGVjksbrJDZa6fBSPW/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBu8jwfA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBu8jwfA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778831159; x=1810367159;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4RO+f8JYea9b4Wfb+Qd/P0Njf8806ykVDwdXLHD2yNk=;
  b=IBu8jwfAyQESFG+jXxMDJlz7LWH+KgEYo2mkX8MwVTn7ztBMmpkeGV0M
   gxOgUZ0KbK/tm3vznyJmFEEhp+ban6YbCIbEgYUPbBFE2kd0dBy69PbZQ
   5lWWwoviuTjgo3gIWr+C/S3qAYaIZ1zOUDypyrBDDsEsyY89M0hNdIQ0U
   Wybo7Q6yuHKLR1/FOx4Zsx8fCwG7wj7bj0g72y/anY7WeyiKSjQPppMLd
   NvmVFDHMNwgtpLerBjKL66Fk7QofrPcU2fdZghvWCY9w7fh4L3Ru9fTZv
   Ly1c3vG6lBGGiXtPBr+RNeXUjPAj+CmnnupJVw2hLC/SAa0jhoobmtNM4
   g==;
X-CSE-ConnectionGUID: 7n5pgEOBS3+1b+9D2KCzmg==
X-CSE-MsgGUID: BiYRAnzWTQKWgmwEOkxi3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="97357093"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="97357093"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 00:45:58 -0700
X-CSE-ConnectionGUID: UExceNfbQP+i6nE2L5ij6Q==
X-CSE-MsgGUID: Zm0rQCI2SrCST8HNJpdOqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="234371295"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.240.207]) ([10.124.240.207])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 00:45:55 -0700
Message-ID: <e777ebae-d51b-4797-84a9-cfac8e6eda41@linux.intel.com>
Date: Fri, 15 May 2026 15:45:53 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/15] KVM: x86: Rename kvm_cache_regs.h => regs.h
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
References: <20260514215355.1648463-1-seanjc@google.com>
 <20260514215355.1648463-7-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260514215355.1648463-7-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/15/2026 5:53 AM, Sean Christopherson wrote:
> Rename kvm_cache_regs.h to simply regs.h, as the "cache" nomenclature is
> already a lie (the file deals with state/registers that aren't cached per
> se), and so that more code/functionality can be landed in the header
> without making it a truly horrible misnomer.
> 
> Deliberately drop the kvm_ prefix/namespace to align with other "local"
> headers, and to further differentiate regs.h from the public/global
> arch/x86/include/asm/kvm_vcpu_regs.h, which sadly needs to stay in asm/
> so that the number of registers can be referenced by kvm_vcpu_arch.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

