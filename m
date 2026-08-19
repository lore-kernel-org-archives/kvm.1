Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1899E399036;
	Wed, 19 Aug 2026 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129378; cv=none; b=ZMzfMtEZ3Y89ZtOTsWjoT0VbT/t+4bAHwKmQp1qWAUuMfkmSm5NRGYqTAhvahAeyxEl+nnOIH8RarpBEuqtPcStzbHJlNd6GEVo3zb6EYIOhKAnSyYtyUCeVnTMH+u4RTAeYKe/zzfwJZtOyKUF4DGzJ/o4lcWqF/HwJ1dd0QVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129378; c=relaxed/simple;
	bh=wdrFtWLxs3g1usw6H8CnmFJaJEkUHw1DYhlLs5hjt8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEHntt80o9YM6zpKTe5lHdfaPVD8QVKcoxbjGegazOSSHto3QTjN7rjmsa0ojms6+Ei5AfICrlrhGbxg6ijUOmsrQfeZrMf2z8VzWZBMkQ/bbuDNskJ1+83q52//9YzcdrtUmWPNcaP4FOrp8RR0dPhMMS+TxCJetVpxoIO3+b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TR8fgkdM; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TR8fgkdM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787129376; x=1818665376;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wdrFtWLxs3g1usw6H8CnmFJaJEkUHw1DYhlLs5hjt8E=;
  b=TR8fgkdMX7EJHqjz1R2kJ/VpD3pSS355Ua6wCjg0xcwDCs3bF1gr4FmN
   SNzxrnJ6iwDTqqIW9XfL1PY/YogZW3HvlRpXpOh/xUhuegpYCWZjjGu6u
   6XtrarjkYLtDPTdGmimpOQYUTA86z5gpKuLwBmlnxBMVBsgMZIsrH7A30
   KXc7eQfRwszJHwZouktVdB2U+rncy473GQbfXHzvZq3ccEISk89ol2l6E
   eBRYCrHNpBCGA5phSsH2P5fz5Zlx0G819DtbRlmre+/mKJadLXhTusrd5
   bq8mw9F4pFWcQ7ehVSzA5+TbiGxkK8WDUf9cQ0hAuM8cCSGNvcYpbI7Wc
   g==;
X-CSE-ConnectionGUID: koTqZSLKQ0+dyKiZzriyBg==
X-CSE-MsgGUID: m+pL+QdjTPWwkDHM1nt5hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="86591694"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="86591694"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 01:49:34 -0700
X-CSE-ConnectionGUID: MWKbmFiVTHe1mvn+nY5/sw==
X-CSE-MsgGUID: Jxs/nzajTX2WT9dx2a4Hkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="270697781"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 01:49:29 -0700
Message-ID: <029a0e0a-b311-43ec-b96a-395e239b6532@linux.intel.com>
Date: Wed, 19 Aug 2026 16:49:26 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] KVM: VMX: Implement LASS violation check
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org, x86@kernel.org,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 "Chang S . Bae" <chang.seok.bae@intel.com>, Kai Huang <kai.huang@intel.com>,
 Fuad Tabba <fuad.tabba@linux.dev>, Chao Gao <chao.gao@intel.com>,
 Yosry Ahmed <yosry@kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Matlack <dmatlack@google.com>,
 Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
 Kishen Maloor <kishen.maloor@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260806011536.4172258-1-sohil.mehta@intel.com>
 <20260806011536.4172258-5-sohil.mehta@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260806011536.4172258-5-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/2026 9:15 AM, Sohil Mehta wrote:
> From: Zeng Guang <guang.zeng@intel.com>
> 
> Add a VMX implementation of the is_lass_violation() hook to let KVM
> detect Linear Address Space Separation (LASS) violations on linear
> addresses generated during emulation. LASS uses bit 63 of the linear
> address to determine which half of the address space is being targeted,
> and reports a violation when that half doesn't match the current
> privilege level.
> 
> Note, LASS takes effect only in IA-32e mode; it is ignored in legacy
> mode. LASS enforcement for supervisor-mode data accesses additionally
> requires SMAP to be enabled, and is suppressed for explicit accesses
> when RFLAGS.AC=1.
> 
> Enforce LASS violations on emulated instruction fetches and data
> accesses, including implicit supervisor accesses, so that the mode-based
> protections are applied before paging. Also enforce LASS on the linear
> addresses consumed by emulated VMX and SGX ENCLS instructions.
> 
> Linear addresses used for TLB invalidation (INVLPG, INVPCID, and
> INVVPID) and branch targets are not subject to LASS enforcement.
> 
> Signed-off-by: Zeng Guang <guang.zeng@intel.com>
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>


