Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3127D19F121;
	Wed, 19 Aug 2026 03:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787109600; cv=none; b=qT8m4scwUXp4SVbDIdY6Wcz4dJPmwGeyqxG9+5kCX3f96J+YvCgJM76iEiESNXkHTC9u5ji/usTQgYM6BKqqZab3Z/gDCZhSmAYXhL9JSBQVFOj6TBi+aYgYZsCL0824CAMPGDusMHWXSIxjYiOzljE7JVajTRB7uuI5+9HCq38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787109600; c=relaxed/simple;
	bh=2E4sBhsclabfx+BByk/uz3hYBxZJO2f9Z5gk4jl8a5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBBi+soUYIXVDdwC9doDcGPP8G24gyo/TxvGL98wwuVZjDALwuydvx5oaA1D4q8kJa2myLXrvwG+TrMc/QN83p0w0PqwWOIprFXTnxdIhld2+59d42qu+Wlzsr4O5dPU4VomIGC6rcwRXImGWBLWqXjBdblSk21Fhd0cLNcLO7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cGLxPAEA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cGLxPAEA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787109597; x=1818645597;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2E4sBhsclabfx+BByk/uz3hYBxZJO2f9Z5gk4jl8a5w=;
  b=cGLxPAEAtHLmU5BAUKPNQ1OjZfQLNRkb+Nr6q/RcMm99OvcweKU96dLl
   bcPFN6p9gCrbeBwJPNLDq1qsWD9XrV1ZYqzlPh/lMPR2QCNZ2/PuVGEkc
   rNEgH82Vz7c5kRIlNRun/PuyoP8C6A0w8G73TQcUK/GZFDSkU/yaihwYk
   bjC6i/XxOSDG8e6J/PXv+bcB9Pw3s4d2Iyze6/0nTTas5DD/rgwLato8O
   CWBpIBNionbyR+215NQB7GMHt704Qzib9gJpBZiO0j+f3/SO2cob4Sjhu
   pRSmneeg/W2+s3DYBV8WDUTzQ68D6C8KdKifnQiodukKKIRormWWynSsm
   A==;
X-CSE-ConnectionGUID: +G6FE9AyRqyiB7xgyRMXNA==
X-CSE-MsgGUID: +IgOzL0FSiONqUGGPJIYuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="91294204"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="91294204"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 20:19:56 -0700
X-CSE-ConnectionGUID: BBq2Wk9aQ+GddxVS9NCBYA==
X-CSE-MsgGUID: Lz37ZKJfRvmbImjvPZUtnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="259225075"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 20:19:51 -0700
Message-ID: <41a327bd-cbbd-4530-9f30-9175c5840014@linux.intel.com>
Date: Wed, 19 Aug 2026 11:19:48 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] KVM: x86: Use linear_read_system() to read the TSS
 I/O bitmap
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
 <20260806011536.4172258-3-sohil.mehta@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260806011536.4172258-3-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/2026 9:15 AM, Sohil Mehta wrote:
> TSS I/O permission bitmap reads are implicit supervisor accesses which
> are subject to Linear Address Space Separation (LASS) enforcement.

I am not sure about it.

According to SDM vol 3a (253668-089US), Chapter "LINEAR-ADDRESS PRE-PROCESSING",
section "MODE-BASED ACCESSES AND LINEAR-ADDRESS-SPACE PARTITIONING", it defines
and limits "implicit supervisor-mode accesses" to the following operations:
- accesses to the global descriptor table (GDT) or local descriptor table (LDT)
  to load a segment descriptor
- accesses to the interrupt descriptor table (IDT) when delivering an interrupt
  or exception
- accesses to the task-state segment (TSS) as part of a task switch or change of
  CPL
- accesses to a user posted-interrupt descriptor (UPID) during user-interrupt
  notification processing

IIUC, the TSS I/O bitmap read during ordinary instruction execution
(under CPL = 3) rather than during a task switch or CPL transition, I don't
think they fall under the classification of implicit supervisor-mode accesses.

> Though highly unlikely, if a guest configures a TSS base in the
> user half, hardware would raise a #GP on access when LASS is enabled.
> 
> Currently, the emulator reads the I/O permission bitmap from the TSS by
> calling read_std() directly which is inconsistent with other implicit
> accesses in the emulator such as IDT reads, GDT/LDT reads and TSS reads
> during task switch.
> 
> An upcoming change will add a check to linear_read_system() to catch
> LASS violations. For consistency as well as to keep LASS enforcement
> centralized, switch both I/O bitmap reads to linear_read_system().
> 
> Note, emulator_io_port_access_allowed() doesn't propagate faults, so
> even though linear_read_system() will set the exception details they
> will be ignored.
> 
> While at it, fix an off-by-one in the I/O bitmap bounds check to account
> for the 2-byte read and ensure both bytes are within the TSS limit. The
> SDM mandates a trailing 0xFF byte after the bitmap so any out-of-bounds
> access would be all 1s (denying access). Make the change primarily to
> ensure hardware fidelity. A correctly configured OS will not run into
> this issue.
> 
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
> v4:
> - New patch
> 
> There could be a pre-existing issue here. It is unlikely that any OS
> demand-pages the I/O bitmap portion of the TSS. But if it does, the #PF
> details could get lost and the guest would get a #GP instead of a
> restartable #PF. Propagating the #PF to the callers is a larger change
> that is beyond the scope of this series.
> ---
>  arch/x86/kvm/emulate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 8ff28643b2e3..7f04544cfee5 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -2573,12 +2573,12 @@ static bool emulator_io_port_access_allowed(struct x86_emulate_ctxt *ctxt,
>  #ifdef CONFIG_X86_64
>  	base |= ((u64)base3) << 32;
>  #endif
> -	r = ops->read_std(ctxt, base + 102, &io_bitmap_ptr, 2, NULL, true);
> +	r = linear_read_system(ctxt, base + 102, &io_bitmap_ptr, 2);
>  	if (r != X86EMUL_CONTINUE)
>  		return false;
> -	if (io_bitmap_ptr + port/8 > desc_limit_scaled(&tr_seg))
> +	if (io_bitmap_ptr + port/8 + 1 > desc_limit_scaled(&tr_seg))
>  		return false;
> -	r = ops->read_std(ctxt, base + io_bitmap_ptr + port/8, &perm, 2, NULL, true);
> +	r = linear_read_system(ctxt, base + io_bitmap_ptr + port/8, &perm, 2);
>  	if (r != X86EMUL_CONTINUE)
>  		return false;
>  	if ((perm >> bit_idx) & mask)

