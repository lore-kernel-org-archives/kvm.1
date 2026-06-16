Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093B1313E03;
	Tue, 16 Jun 2026 06:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592936; cv=none; b=i9Ptt1GAonhthOuOu6015LYdRDaXTP9/3u64gpLxTR8OtjVg9vY+9nDulu+fbwMvcY09PngjgOqYqA0L4XSwU13NUSlWIkm9JszBsokZ9RYX8IG/Jrj2e/OlXypNwdJred0b27THzIfBd00bJUVpIT/AsnWpSwxVFsApZkoqHVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592936; c=relaxed/simple;
	bh=EtEgiOlsB3YN8YySDVnhldO5BVT1kImrbNeKQHTE17A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDO02q7b5DTNQObBjzOtJNREneFZMrgxnn/oiX6GtOCfyMB5qHR0yh0NIYP/ZJHGud9/S1rQbYPdwBVrDUvaWFFemTNsYyJCSrxdiHyZsKMQVZgSMyIPJPO8Ri3KH58akDJb76E3BYv7wtWRnwFFJG7Llp4zoC8K1sHfec81xy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U+xuTTm9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+xuTTm9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781592935; x=1813128935;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EtEgiOlsB3YN8YySDVnhldO5BVT1kImrbNeKQHTE17A=;
  b=U+xuTTm9/X151CS1lXEGB5w2N4KpLR/ACAIovACdzMB8vH3WDTDqzevj
   lumnjyDivcefY1gaTYoWNAzU2pH1uevn0T7DoU32Wu557GuZnSlTBXwrR
   4SkYKYuBBfsUVPA6Kq5Zj4FGIl3zvHjuKIkxFagItZS012H6WyROWZler
   MD+Khc5SxcdYsyOyTu7pLHVJ7bkNJrApE7aRDbkkJb/SU1aqejsZRLn4M
   mybp2DjadzV+re0YIg2j3urgSGLJpRf4pdEluNPb2k7ggj8iKTx7xrMWV
   bxPa1NCcrb9d1v/1Q1b26qm9aICvQv90U2qeUqwKZh4+p68bYIrLufNMe
   g==;
X-CSE-ConnectionGUID: N7qTUyjFRfSkW4nU/htNqw==
X-CSE-MsgGUID: /pcX4y6SRRGore1hEtEoMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82453133"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="82453133"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 23:55:34 -0700
X-CSE-ConnectionGUID: TEtISxruTayiIWoPtq+C4A==
X-CSE-MsgGUID: LKCwcDP5SBCZMYVbQqH6DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="246793554"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 23:55:32 -0700
Message-ID: <c958ce06-99ab-4c62-998c-622ac0e49d58@linux.intel.com>
Date: Tue, 16 Jun 2026 14:55:29 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/30] KVM: x86: Move IRQ-related helper declarations
 from kvm_host.h => irq.h
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-25-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-25-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Move the function declaration for APIs to get/query pending IRQs from
> kvm_host.h to irq.h, as the APIs are only used by KVM x86 code.
> 
> No functional change intended.
> 
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

