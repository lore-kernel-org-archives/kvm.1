Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793064351;
	b=snQ/6dgfWLbnKVpzVUUJR1S4V/sGXL7TPeHZXy3iaUhNQYZL22JjmVEJhxmOkYW0WRe3
	 OL0Ra94N0ZbzmfOqzeI4p9UZW+dcU0t4YXzqPwdP5+C6Tm4/4gL6fXlmTgC+TAkbL4Jr6
	 hMY3M8oe+j+Cw6OoYnT5TPvvIglBjd0A4hp8Sk7dyDMjufvXLY5+IIupUDM1kA/rEtww3
	 pTnCgROxjwgRAs4uBflhem6X16B9/vhPUgsVpuW7RITxoZVOGlOzDbllwwdGCRxOs3EPq
	 WHNLBNNT9F8HfXoSFawT74KUi00Al7MjlMLL8uSKKUwg+xdxf0heEHccDYkz8QRY9TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793064351;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Y+DIHcrA443uqX7QES2ZcgrJrcUrUUQxo223RqYtOdc=;
	b=q2J4aUt6J+8AXcvvqpl3YFJ+M1lT2FA4YVJpKUB0aW98thdVDtZ9SKWR3juBhnuWakOe
	 WqlHlzrdvafEhz3zJAk1xLvCBQ92mGibc0oULdY+5a7cqCjvVQK5oVUgtzYV2nqBZ8AsI
	 XQcsyv1gfTPPdu+u1XgJK12Lp6zMAdM2FJDqcbw8IEY3q/yDTbYpyfpjwVZVHXn67moex
	 UoF2h0WO+mYTvHiBKtVw/xFqXYY34Ytn0arSafLEdtUFVkC0CIeUoYKgL+6ehYBedo3SC
	 jXAtvQhhQBlmh4pnEzrbS47krsdXFDH4oQdH2VyUlPn1QIX9RUw7ShG4OHP9uisYd6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L53lhoCx;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E809A606A31A;
	Tue, 27 Oct 2026 01:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E809A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L53lhoCx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793064351; x=1824600351;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1W0qQOp9dlvhFLQgWLSpC14yTIgst1Lk70JE9hOkfO0=;
  b=L53lhoCxCvJanlIjEpE/6Dp9npkN103lLRTtG+JySOpcoMOgBCsktCaN
   imlKGhC5v3ZTYiaddOaWn8TkaMxdegrxmPu4qtYC1fQCCScajiaFyahjW
   +o7TS2oQCNmGQ+oGYTcLYggOiEOD53TxcHOph32TVex7P+JtOrGiRnpQp
   alXLONnxVEnLnCkNOX/iKh5QnqISDFoxvQorFwI72U2xvGMrn4TkouohL
   j4UQ0GeBLsuVcMfPyl5tW8DGPq1mySQGlGumDVtHCO5GUbP052cKlNUYx
   /yJHTGkCYqWFU6JESu4Syn/5u+76azHitGMf9rb48fEedMEvGu7qyPPgz
   w==;
X-CSE-ConnectionGUID: Ey5msoRsRW6DdEcDgbXx8A==
X-CSE-MsgGUID: NPhX6EtZTK+64IVIaDUaFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1760137"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1760137"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 18:25:50 -0700
X-CSE-ConnectionGUID: 499ixse/RBiiw5XlyzZDTQ==
X-CSE-MsgGUID: 1iitD3rJT+2NzPxwk+903g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4422631"
Received: from unknown (HELO [10.238.2.205]) ([10.238.2.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 18:25:44 -0700
Message-ID: <153dd0db-32d8-4ec9-ab8d-2368a790ac55@linux.intel.com>
Date: Tue, 27 Oct 2026 09:25:42 +0800
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
Subject: Re: [PATCH v10 02/28] KVM: VMX: Initialize VM entry/exit FRED
 controls in vmcs_config
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Xin Li <xin@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Shivansh Dhiman <shivansh.dhiman@amd.com>,
 David Woodhouse <dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>,
 David Matlack <dmatlack@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-3-sohil.mehta@intel.com>
 <acc168cc-e021-43dc-8846-ed1b2d69facb@linux.intel.com>
 <a0f99d8b-b67d-42f3-b76b-90187a0bea5d@intel.com>
 <5af354c7-9bbb-4ff2-b450-c08cc5b46304@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <5af354c7-9bbb-4ff2-b450-c08cc5b46304@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/26/2026 1:00 PM, Sohil Mehta wrote:
> On 10/22/2026 8:10 PM, Sohil Mehta wrote:
> 
>> I couldn't find any precedent for this. I don't have a strong preference
>> here. Is it worth making future-proof?
> 
> 
> I did a bit of digging. The current entry in the table is the result of
> Sean's preference provided early on in the FRED series. See
> 
> https://lore.kernel.org/all/Z739wdGmk4ZuWJ8v@google.com/
> https://lore.kernel.org/all/ZUz3cPmnqSq7Lol9@google.com/
> 
> IIUC, we want the FRED entry/exit controls to be consistent without
> depending on the ordering.
> 
> The current vmx_check_entry_exit_pairs() doesn't cover the FRED case (a
> single entry bit mapping to two exit bits). So, the updated check would
> cover this scenario.

OK, thanks for the info!

> 
>> if (!(entry_controls & n_ctrl) == !(exit_controls & x_ctrl) &&
>>     !(entry_controls & n_ctrl) == ((exit_controls & x_ctrl) != x_ctrl))
>> 		continue;
>>
> 
> 
> 1st line: the entry control is set if and only if *any* exit bit is set.
> 2nd line: the entry control is set if and only if *all* exit bits are
> set (which is specific to FRED for now).
> 
> Also, to make it easier to read, planning to reformat it as:
> 
> struct {
> 	u32 entry_control;
> 	u64 exit_control;
> } const vmcs_entry_exit2_pairs[] = {
> 	{ VM_ENTRY_LOAD_IA32_FRED, SECONDARY_VM_EXIT_SAVE_IA32_FRED |
> 				   SECONDARY_VM_EXIT_LOAD_IA32_FRED },
> };
> 
> Please let me know if you disagree with the approach.

It looks good to me.
