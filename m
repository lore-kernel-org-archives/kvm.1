Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9697531E820;
	Mon, 27 Jul 2026 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142457; cv=none; b=b4R/O0BvVxqwQa7zH+VrAjQINZqvuJVcpGpNaBg/3Q5Da1CFxxrZWrXdzLCKHIiQf0qwlX52lIREXx3hjscY0pVCY1zPgejNWFPzsJrvOQgqQExSU4MOenAt6LNUo8rh99PFuxIrFxhP30bjpLCZUPWzoNAi14TROZPF6Dde7EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142457; c=relaxed/simple;
	bh=2e7YmaErhVUmEndj44eWGDleBVZrCWg9xNfwCH3OgLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1BcfRPKjgtQTswfwGO/0AOVrEnFmb+iqwpdbE6CY0/vdrZcU68cDe0I4wDrqqSrpzKjoZXmbgzfylDCr9Iut/4586Eh2+uux1l9zHjh0jgAY8Mifo5vCVYPYvmgiN33KX94dEvgFTBmnJF9Kn6U50DLs7iiFiH5k42ekqR1d1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GI7WsmEB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GI7WsmEB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785142456; x=1816678456;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2e7YmaErhVUmEndj44eWGDleBVZrCWg9xNfwCH3OgLE=;
  b=GI7WsmEBhRKx1R8umpNQm45y1Il/DCnTSX25NenCXZWGwxOj39rVxrtJ
   HKt0C5DUFpQh38Y8Dy00+rTK6woctyapJKuOi/7HAy1GQD5KlqS+yOmlA
   IsQ3QtFumFG/IK1R76S9lDHlv78GNR/ASpKH40QNFo0TJ85VO72ArGV/w
   7qv9DEIP1ToUEojV7O2ept9a7rABESNYH1+DTAD1FMFniC4JUzKZLL/+s
   jG1kgSOjmQEbM7GKhj2kge5HD3VJnzHJedE7LpI18WHB9yV5jO2DJDFuM
   lmDTqa88Y5aNWeWGoNExkZlWzKnweWJGRXzpM+JkDvv3naCyaaxBmCxVn
   A==;
X-CSE-ConnectionGUID: Eqtdx71YRwS9p9QT+8ldEw==
X-CSE-MsgGUID: L8EWLMdpSk+fyuImrwsC+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="84682689"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="84682689"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 01:54:15 -0700
X-CSE-ConnectionGUID: 5pAvkDr4Sses5WECpVqz2A==
X-CSE-MsgGUID: /GTPENjcRmG7AYdBr/ZMlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="282694105"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.238.208.132]) ([10.238.208.132])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 01:54:13 -0700
Message-ID: <d8cca524-bde1-45fd-8204-ced8ec73e7e9@intel.com>
Date: Mon, 27 Jul 2026 16:54:09 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] KVM: guest_memfd: Add helpers to query SHARED vs.
 PRIVATE for a given page
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <fuad.tabba@linux.dev>, Ackerley Tng <ackerleytng@google.com>,
 Michael Roth <michael.roth@amd.com>, Fuad Tabba <tabba@google.com>
References: <20260723210811.72720-1-seanjc@google.com>
 <20260723210811.72720-6-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260723210811.72720-6-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/2026 5:08 AM, Sean Christopherson wrote:
> Add helpers to check if a given page in a guest_memfd instance is PRIVATE
> versus SHARED, and use the "is shared" helper instead of an open-coded
> equivalent in the user pagefault handler.  In addition to the immediate
> usage, providing an "is private" helper will allow cleaning up the so
> called prepare() code, and eventually will be heavily used once in-place
> conversion support comes along.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson<seanjc@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
