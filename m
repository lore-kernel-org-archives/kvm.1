Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782226;
	b=p0lSIQQwUx26YQFFnrjUvU3ufBhMkDEE4uRNw5iUHYAgL8m6jOvaeWlfKC7iugmyr4hk
	 57EG1DzSWNw+w285IGKwF+XVC8J7fDe4oU7UzFwWPJjYRiiUQNxVHxvONr7jV5fBP2GqL
	 VgorTLQhW+fDvEkscAWJeoH3r6YEwz+H941QQllR3BxzuWyaM/mGy6D9bojDLsAqakL46
	 P4kUknuRN/SHGzxg2YSw9ZRiszfhed+G/VsjIcEiVT7iAGOncrLI5ifQa5GWWMhaVNdpt
	 Z8t/BQJDiMyYe+zdvM/Q7fqSIsleQC3kLjjFb44qpc488JDB4DLEA5Hkwu/50AILqLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782226;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Content-Language:To:Subject:Autocrypt:
	 Content-Type:Content-Transfer-Encoding;
	bh=rNWPRBvHW4GWXMBuyyIQh64Bw8Q74fH6mWDNw5ByBy0=;
	b=frT6aUNIv8bLOz3vS1KmPA5snxVNbupb/vVcu10aUfeVIRjBy77VuW2ZFxhr5/NPPldE
	 p6vcwnk+l0hqEtk7BuojqmvaqOHeFbs5RrJ4f6P8lx+g7BvMHy0JVB1fmHNpEJZZbekv8
	 1D1Q+FBY9bHr2xsuWMDZewJaxe0EF16wxcSBlJkln7BYoabCYa2SIfdtlyAdu67KZIkRp
	 FfX+bOv0wBRrIi9zCiNIWlefQlMJpnVKco491Lfi65BKtEx/tQWMfPMLlLSv1OjQ1cDKM
	 yldSdi4YGrj7dFSYUYdil7+owEa1UGFzRSQ6UrYsHi2g+VIcClOnc18Kvp52Bw60Itw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QjuG51oE;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A9606A31B;
	Fri, 23 Oct 2026 19:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 728A9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QjuG51oE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792782226; x=1824318226;
  h=message-id:date:mime-version:from:to:subject:
   content-transfer-encoding;
  bh=Ik3Tv57+LpiVdT2vVzm4qW8OYFyfXnFLCSBNq2HUF5E=;
  b=QjuG51oEkEhMEQ1puGq2HYwHjqDVD1ZvyT2LBSsuZHgwIcsvCnfbVw1t
   u67dOKDZvY6kn3kgYgXUNXdGEMmFKbLMR4fKYLJGVHbikXrqaC3uJ7mL2
   e8GFEGb+nBOMJEoO7lxGjeslFwMqn23dSGd6l+ybiUiWQPMbeBXwfJYmJ
   m0dA9ahzSdWv+1AFgrw2fLQ+pZ9hlY6flKTjWiynOxxq2BxCDtzmJReH4
   Hx4AE2BvzbBBs8U1pIWC8YrpMlxITguuxIiXqaDiJMkseM7NWlRa0gjCc
   5gFg0BS4pqbGqEUF0DevixVEFS8kZDSlbnE8Wb5ctgV3qbN4xM1dlMbEl
   w==;
X-CSE-ConnectionGUID: zEyGGuK6QJW/qyX03vAY8Q==
X-CSE-MsgGUID: /cWNB2MxSYGY3T+o0G7zjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1434360"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1434360"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 12:03:45 -0700
X-CSE-ConnectionGUID: oX7vb1O2RQeFm/AueZ1Bkw==
X-CSE-MsgGUID: 2XgCkoB0RpaEQnPNVhs9Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3601112"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.108.4]) ([10.125.108.4])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 12:03:44 -0700
Message-ID: <2f0560df-69fc-4fc1-81fa-447e289ec2df@intel.com>
Date: Fri, 23 Oct 2026 12:03:43 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
To: Yang Weijiang <weijiang.yang@intel.com>, "Gao, Chao"
 <chao.gao@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, John Allen <john.allen@amd.com>,
 LKML <linux-kernel@vger.kernel.org>, pbonzini@redhat.com,
 peterz@infradead.org, john.allen@amd.com, kvm@vger.kernel.org,
 binbin.wu@linux.intel.com, Andrew Cooper <andrew.cooper3@citrix.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Bae, Chang Seok" <chang.seok.bae@intel.com>,
 "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: Kernel Shadow Stacks Versus XFEATURE_MASK_GUEST_SUPERVISOR
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

So, I'm working on kernel shadow stacks. I have some nice optimization
code like fred_update_rsp0() for SSP0. It avoids WRMSR's on exits to
userspace if FRED_SSP0 hasn't changed, just like FRED_RSP0.

Well, turns out that FRED_SSP0 isn't like FRED_RSP0 in one very
important way: it is an alias for PL0_SSP, which is managed via
XFEATURE_CET_KERNEL which is in:

	/* Supervisor features which are enabled only in guest FPUs */
	#define XFEATURE_MASK_GUEST_SUPERVISOR  XFEATURE_MASK_CET_KERNEL

So, I was running along just fine in my nice shadow stack kernel going
in and out of the kernel just fine. But the first time I did an XRSTOR,
the XFEATURE_CET_KERNEL feature got set to its init state. My SSP0 cache
didn't notice and I tried to run userspace with SSP0=0. Much hilarity
ensued on the next kernel entry.

The most adorable part of all this is that I have KVM compiled
completely out on my config. The "only in guest FPUs" code is biting me
on a kernel that can't even run guests.

I think this all started because of 8b05b3c98816 ("x86/fpu/xstate: Add
CET supervisor xfeature support as a guest-only feature"), which seems
like mostly my doing. So I have mostly myself to blame.

Any thoughts on what we should do?

Actually context switching XFEATURE_CET_KERNEL seems kinda silly in a
lot of ways. PL0_SSP can always be derived _and_ it isn't actually even
needed at context switch time, only when running userspace.

I could just aggressively blow away my SSP0 cache any time an XRSTOR
touches XFEATURE_CET_KERNEL. That would be easy. But it also seems silly
that XFEATURE_CET_KERNEL is being blown away at _all_ during normal
context switches. Heck, it goes further than that because:

fpregs_restore_userregs() does:

	restore_fpregs_from_fpstate(fpu->fpstate,
				    XFEATURE_MASK_FPSTATE);

Where XFEATURE_MASK_FPSTATE contains XFEATURE_MASK_SUPERVISOR_SUPPORTED.

So a "restore_userregs" function is blowing away supervisor state.

IOW, I think we're using XFEATURE_MASK_FPSTATE a bit too broadly.

I'd like to get to a place where only the KVM code even has
XFEATURE_CET_KERNEL in its RFBM.

Anybody have any bright ideas?
