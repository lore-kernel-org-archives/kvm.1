Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7151634751F
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216684; cv=none; b=jwtbCtY6QUKjhyvP7iHvMGVczd5dn92lc3jxmXUaKmmhn9wZ4fksu5tMGDCBIh1CmWFvtcOZzPpD8/zjOAUXKtFNm1HlFOh4O8oKq8PJXaQID+fX7LNg5Zlj+TCFZkK9O7G86+Iv1we//eCcbT0qQl0lhgYaISxtUtZeeUJ3vAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216684; c=relaxed/simple;
	bh=MBNT4RmlhDZXOrdqScjFaMpobET3nW3VaZ0iff2/mQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lspJvpJ0QPp3dTzz1kPvftnH70aQ4XnrQUoYWg+ktWU1qEvAj3j/3dVnoiyUIMBUamEnF0HFOM+01W98+h2S1LP7AB9pmEZFW0g2Drmj7WtXu0k5K4jIHQNTehzTHnO29jD8OtsZalAQKG2osVMtalR7uRxJs+CHwhd6YL3+l5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G0EwUBrX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0EwUBrX"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cab97c86bdso18995ad.1
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 08:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784216683; x=1784821483; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RZnPgAsegwq5RNUmT4pZ5ZYEwWcgYfPlPFNTQ6BdGMM=;
        b=G0EwUBrXspczOjod1PhU/M3BeT9h05HRPaMp5klNER1NNAIM5V8uqP7Ji3ZPHQtP5i
         M1ttv9cNXxYYeZ+eKPmXl+MA216tRAyw1QkgV4XuUI62dEiDktmwvihEejIEPwJhGceE
         0Yvg2olkUdyDh37TDb8tISwyhR5BZdTMvz9QHreID6MpjqeWPIqi58mDKz7VYfsAa0Eo
         gs8AMXA5F7cSPEPcU9cF/BTD/nJKILlr/W1JDj9O9FI7TlwWb5C0QYLDZM1SBhuDCTmV
         KmgtFf5LJIG2a1PZv0z3eZhFvbs/bTH6ZcpFpNurr7KhBXOSMxgNbdOc8xBrUQih20fe
         zBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784216683; x=1784821483;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RZnPgAsegwq5RNUmT4pZ5ZYEwWcgYfPlPFNTQ6BdGMM=;
        b=KbsIYB5OqlNIM6EEn0Ab3V7BrhJ0lnKRKLdOL/4KRXnI2qEiHF4N9Z6vX+jzOECS0y
         qbLZ+XFgN1Mq1AKmlx+ExcjsoOSHkfCYyPF2DNaMyGPdZorZ9E6Q5vHTmL/LH5INnLLH
         vN2CmcXOuIP6/f6hJjcdke3Op72/yeJpvEdESaL1ImOwxEPMC3mQgPK7nQrP9rG4Owyg
         7GBys4ifsukMmp9CCPCc+QjCPfJGkv56cT0PLW/XG510b88nD0+Uvtsse7jBAfA58ZNV
         zXC2+IYjA9QONIyVtvOon/TET4Rn3f9jY7zenpHetlh+vdcOFV0H663wai0E+dWhBWo6
         xKqg==
X-Forwarded-Encrypted: i=1; AHgh+RprwviS6U9U+N1wpaghUadYZSg3q9+lxeffsUMzt2kON+SJZW3XI7Z+JtGZvpeK0QwTgnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtdBEyCVB/ZmSkKZ+WXZKIcfpGCTjpVgm04xqi3Zk2bLWWHKRR
	mtcd4qyYftCIrxHmRXYGZv/qPnfJbbwErOCeL+M32av5euZ/W/TMlY2tdQmY+OcGkQ==
X-Gm-Gg: AfdE7ckj0qmFBn1tD1Xu+A1X0ynhc57cq/pj6ak93QoaXB7lRiPfI06omisfv6M4CjN
	zft+H13BZ5rHYKfPIFZDBQ9QkAPTc+FsARf2jIL24Qe0xuT0sKNmscRUihIUX+uEq/qP0vfCPh9
	+NUTMOse65rilfrfnNsEpxFG+V96m1AbqFMahXwzGjBoLt2OIdfb2+frtAooBd9Ku2yuNFGEdXE
	7BYHVfP1uHR24cnpUuk4n90n0pQS6/seABEF2e8pMeX1OKtda/0Ns8ox6CdmVcnunJg7inqyuOq
	11pS31SDG72IOuIH4BLpy6+4cYF2G4CXbYApp15Ul/PU/YkbmzfINKf9uK1vrh2+RRWGQk/6fAB
	YoOg6w04OGqFnxka1vq2s4vOK/MBSqsPAVFmKSRNKSFJz398/BeOgFnpgPWlCbhdRBhjaXi7qtk
	TqRIaa+sXUzl3RGWucC4yPVW+Cu3V7rCYjVaXuP6rURhxHbeYMOklG3D+/qsEfX3jET09Nzs27
X-Received: by 2002:a17:903:440c:b0:2ca:e0db:3cc with SMTP id d9443c01a7336-2cf1dafe691mr2849285ad.11.1784216682206;
        Thu, 16 Jul 2026 08:44:42 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a532eab84sm4717586b3a.0.2026.07.16.08.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 08:44:41 -0700 (PDT)
Date: Thu, 16 Jul 2026 15:44:38 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v3 07/18] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
Message-ID: <alj7u3eCPvPYofPs@google.com>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-8-skhawaja@google.com>
 <f3e2fef9-4f8c-4032-8d7b-007f47b3fb61@linux.intel.com>
 <ajl7xfcoKsohfpPJ@google.com>
 <847f0e2e-abfa-4d6b-98a5-5e25ffe66d8f@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <847f0e2e-abfa-4d6b-98a5-5e25ffe66d8f@linux.intel.com>

On Sun, Jul 12, 2026 at 03:35:39PM +0800, Baolu Lu wrote:
>On 6/23/2026 3:19 AM, Samiullah Khawaja wrote:
>>
>>>>+
>>>>+static void unpreserve_context_table(struct intel_iommu *iommu,
>>>>+                     struct iommu_hw_ser *ser,
>>>>+                     u8 bus, u8 devfn)
>>>>+{
>>>>+    struct context_entry *context;
>>>>+
>>>>+    spin_lock(&iommu->lock);
>>>>+    context = iommu_context_addr(iommu, bus, devfn, 0);
>>>>+    spin_unlock(&iommu->lock);
>>>
>>>The spinlock is dropped immediately after reading the address pointer.
>>>If this is guaranteed to be safe, please add a comment to explain why a
>>>UAF or race is avoided here. Otherwise, the locking scope needs to be
>>>extened to protect both the pointer lookup and use.
>>
>>In the Intel VT-d driver, context tables are never freed once they are
>>allocated during runtime, as they can be shared across multiple devices.
>>So I took the lock here to protect against concurrent allocations inside
>>iommu_context_addr(). Once the address is read, it is safe to use
>>without holding the lock until the DMAR unit itself is torn down.
>>
>>I will add a comment explaining this here.
>
>As part of this series, I think this is acceptable. However, there
>is room for further improvement in iommu_context_addr(). We could avoid
>concurrent allocations by replacing the code below with try_cmpxchg64():
>
>                phy_addr = virt_to_phys((void *)context);
>                *entry = phy_addr | 1;

This sounds great.
>
>At the same time, we could also replace the spinlock with an rwsem to
>eliminate the spinlock critical section. Consequently, the GFP_ATOMIC
>allocation in iommu_alloc_pages_node_sz() could then be replaced with a
>normal GFP_KERNEL.

+1 to this also.
>
>Thanks,
>baolu

Thanks,
Sami
