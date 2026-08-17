Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF66A14EC73;
	Mon, 17 Aug 2026 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786947788; cv=none; b=FHgiDZqlLZ+Ar8nvFMN64VAspRNetUXK2s+g+mmtewBPhYktWpItCtT8TVB1B3XW40K+/qMDmnQUSulykjrDyAi81O4qmmKGYcGaIOEfnaoWYRhF2Q7qKFPheWP6wzgKiJpnDWm1JLAxJMxSuRXtRASX276onl/HUlgw5g6TEqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786947788; c=relaxed/simple;
	bh=23iSSkuh36lGvLjrJkVoDyy4RvctwUUCieGWXLIsecY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u46Y7nz+0QzS1jRxDsUycBlys/UkxZj3EqiF52QwgmtC/TaloF7VO65H/K8eWQq/pBmuJOPzVvv9XaUm1bUR9+/zDMPOeJuPeX2b6EVmz6yUgRHg2eAmLQr0d9joYJQM1zNgGP8D96nNLZzO150yeDfLHM/qb4NdVfHIU/n+fTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gWiYtC4f; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gWiYtC4f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786947786; x=1818483786;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=23iSSkuh36lGvLjrJkVoDyy4RvctwUUCieGWXLIsecY=;
  b=gWiYtC4faQ1vvSBzq6dugaP+8uOZYxeHKkWwNOi4aVgTJ6zKWD2wf77B
   qBSnuMTF55UYUTcPz0ji2A4vF1kw9IZ/mQrcaSVftf3cPP8PDSUC3A+mY
   +5rxpyXGDRQDbIIDDDIkbGHC3RyG8uLEleOrVuUyo/+RKyzjPe7Nm0vd+
   CQ53odjJlEq6jDc6S41r3PamMb32Oj8FNpw+DcVer/0Qqoh7jjMDsHq6N
   FQOfnk1tJEV1ZXCcqtoJVoLzORfFVylkzKuYSWsgizWecfhCHAnMWimJA
   AdDzvYsJAcDL0mNFEMOb4rm6tR2qKrUtiqQnyYzyStgiHyOwh4Bj1+sEO
   Q==;
X-CSE-ConnectionGUID: GlmpDtsYSWyXo5ybpn0VZw==
X-CSE-MsgGUID: hoKc/kTWRh24l5h4m5zxGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="86375416"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="86375416"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 23:23:06 -0700
X-CSE-ConnectionGUID: oebs0k+tTgSRV4riA1IgMg==
X-CSE-MsgGUID: O108mbXuSuqIqLdLWDShAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="260604455"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 23:23:03 -0700
Message-ID: <829ad0dc-3e1d-4dd5-bb64-c872e4b53aa0@linux.intel.com>
Date: Mon, 17 Aug 2026 14:23:00 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] KVM: VMX: Rename posted interrupt prefixes from "vmx"
 to "vt"
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>,
 Yan Zhao <yan.y.zhao@intel.com>
References: <20260814161129.2177118-1-seanjc@google.com>
 <20260814161129.2177118-4-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260814161129.2177118-4-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/2026 12:11 AM, Sean Christopherson wrote:

[...]

>  
> @@ -294,17 +294,17 @@ bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu)
>  /*
>   * Kick all vCPUs when the first possible bypass IRQ is attached to a VM, as
>   * blocking vCPUs may scheduled out without reconfiguring PID.NV to the wakeup
                        ^
It's a pre-existing issue, which is missing "be" here.
Maybe it could be fixed up opportunistically?

