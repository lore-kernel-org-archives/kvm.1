Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608199;
	b=5RGeXwnFWhh4ffs590HivCcd3/D2ON0mhxrvNI3O6647IxEFI7q0xRVzlYM71A3ctrkd
	 DmMwJCUZKXKlm6FvfPVcShfiKHb4F7CL66PQkdVG/3SiHhiX3GS+qNZpn2l9QdD4THtHD
	 sY19MIPb8fJdGV+rUupXzmMfm+Y124AxI0Dn/nQiwSTAEJFPl9j1jIPPO5oBRilS5Ep84
	 G6DV6aX9jCfoTfnNXZiDh0ghpPHq/6Sqrt1MCX6cH9LY7VwFgNTurpSVFYZPCE8x8vupo
	 w0t7oJRYx0+Bljv8Er+1CrnR41pJy/f9nWgtGaHoL0uQFkPLPapXiWfTdegRC2OBMjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608199;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=xgaHGHJ703/BmLgkQ/c7X7zJbd3V5E8MeHEoM0XykK4=;
	b=cDY5EnH22In3KHcN8JEmd233QUh6iQKyVdtIFZC2XU31CyPKTgqjvEAqAbHYUYPkTg5e
	 Vi2DGmUpW1dT2Pb4zBcb1kek+5Ren1qhW9YUyNbn8Ssaubq0IHxWdisUyuPXvT2tAxqgM
	 w/sY6+OsOhQaEZtroZ7aURZ+KYGnRyemaFR/byjnmbln8R0XGmrTQpFwEVtRdgYysZQkC
	 6WKMbe/ZX9W5SnQTiJH9nwHsML/RUQOgBVt8zZSmFJ0Ftf72l7EqYbT2/vT1pqsPINaE6
	 DPZFKy62S0iwhCxcE3UYguD/zodHpSmePAvm4o1Gg8V6NfdNAWMM26KclicGJLM03aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PCJdLjhQ;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829FF606A324;
	Mon,  2 Nov 2026 08:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 829FF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PCJdLjhQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793608198; x=1825144198;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JGjRxR6gm6ACNJIRopKVz3Mv1eqCxBu0rrxBy/s9uoc=;
  b=PCJdLjhQoOPua0HtBNdizFy6Ze/4WTByDmQCAMzOldMx7zf1IaqW9FBw
   r0kIfAb7dTXTEr3BggnAwfo6CNVTN2el/83xZVBJNinq9GbDxteBc624e
   G/orBkQw5qbw3hLhUeqtm5EPUzXTnRZ1EslBS8XQyCsVBRfsRGWf4JCXm
   HnDmu0WpIjOyalQk67MiQ9G8dXaXjnofMozFF9bK3XOhRc6E9AZBhML1F
   VB0WehKaymoUExdtv5pLGlaEUnb7wiTjbtk29ESjNaTzTOdVIh7dG+dKC
   NEH+t0G/MBl+lXKGMj761clk22FwPcPlEooEhDFt9P0W4znG5Nux6Jspt
   w==;
X-CSE-ConnectionGUID: JmkFaQtpSuyEnttKmAsgYg==
X-CSE-MsgGUID: 6VC9+4V4RqqhBt9qyfNrHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2169918"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2169918"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 00:29:56 -0800
X-CSE-ConnectionGUID: f5i1oGraQiCNnG6AikT8IA==
X-CSE-MsgGUID: D20pI9MoSXGOIV3+GHf8eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="5888222"
Received: from unknown (HELO [10.238.2.205]) ([10.238.2.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 00:29:51 -0800
Message-ID: <eb118916-090d-431a-8f78-ab2f320c6bc1@linux.intel.com>
Date: Mon, 2 Nov 2026 16:29:48 +0800
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
Subject: Re: [PATCH v10 20/28] KVM: nVMX: Enable support for secondary VM exit
 controls
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
 <20260911213659.2025974-21-sohil.mehta@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260911213659.2025974-21-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2026 5:36 AM, Sohil Mehta wrote:
> From: "Xin Li (Intel)" <xin@zytor.com>
> 
> Add support for secondary VM exit controls in nested VMX to facilitate
> future FRED integration.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

