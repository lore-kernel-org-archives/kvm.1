Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822DE27B353
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 01:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780103296; cv=none; b=P1VouK9jNSeDFSTFIgHDpMDI5jizAqcZbe8ktLj1fapIgvlAnzw/J0kCG85TYIihc5gtmnGpi3EqStkElc0Ke2t+88VMdxX8A8PgkRHZU6OIXJBejQhZ1AjZNK9m4XhomIpkqIyywcaj1Lgaq3RNmiKjL4wILfAykjngVhTnNuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780103296; c=relaxed/simple;
	bh=wgVP9H3jxl9/T392t7NAw6c02DlLSXohGkZ2yrxb7cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srr6/vYsu04u/NXn07lvNz3DPPM76npiNYRABabe3gjeL+id0pQY9floLfLrU0wcYd/waxm6hh28/8CuMVa+4QtzPctd5jj0LTtPpWYsYJ+Fao2qWxB4jvfpaDi9Yk8cNjPOsEZsua1PhvbMj8yEj+zSTP5zmOHC3lT3SxdkH4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U41IrxRh; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U41IrxRh"
Message-ID: <30421bf9-dc93-4e30-aa63-1284ac79b0ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780103292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Djhqr86UuRC6GV6B4fby+vb6NNY0s9NtSE2NUpbhgoM=;
	b=U41IrxRhmdsYIFcwiKvLJJTa+y5JZNDoKNNJaQ5tP6UbusshG7hPTJVxYvX5rKOskap9kr
	4N7+foj8yRKaWRDCS/T+w6cdLWfLnFmamdCjl0VkzGoDk3N4EXiVnEG+o5CN3geLA2sbwy
	7sSJ26JLySUIjAEL+al265jfDSo9ekg=
Date: Fri, 29 May 2026 18:08:08 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] KVM: SEV: Do not allow SEV-SNP VMs from intra-host
 migration
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
References: <20260528-sev_snp_fixes-v1-1-d67a08151779@meta.com>
 <20260528235151.9E59E1F000E9@smtp.kernel.org>
 <709d9ca6-59bb-4f82-b48a-0aa67a4d6ba2@linux.dev>
 <ahoTEgTSVcEmUMvM@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <ahoTEgTSVcEmUMvM@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/29/26 3:28 PM, Sean Christopherson wrote:
> On Fri, May 29, 2026, Atish Patra wrote:
>>> Because the mirror's vmsa_features is zero, KVM treats the mirror VM as a
>>> standard SEV-ES VM (since ____sev_snp_guest() will evaluate to false).
>>>
>>> When vCPUs are created for the mirror VM, KVM allocates standard SEV-ES
>>> VMSAs and fails to perform SNP-specific initialization, such as registering
>>> the VMSA pages in the RMP via SEV_CMD_SNP_LAUNCH_UPDATE.
>>>
>>> When KVM executes VMRUN for the mirror VM's vCPU, the hardware evaluates an
>>> ASID bound to SNP execution using an invalid, non-RMP-registered VMSA page.
>>> Will this trigger an RMP #NPF (Nested Page Fault) on the host hypervisor,
>>> leading to an unhandled hypervisor crash and denial of service?
>> Nice catch! I don't think it will lead to hypervisor crash though. As per my
>> understanding, the fault on VMSA page would be sent to user space and just a
>> VM instance will crash which is not that critical.
> RMP #PFs on the VMSA will typically crash the host.  In this case, I would
> expect VMRUN to fault, which would trigger the BUG_ON() in kvm_spurious_fault().
> So assuming the "bad" VM can get far enough along to attempt VMRUN, this is
> likely fatal.

Ahh VMRUN would fault it self which would be bad. So no RMP #NPF.
Thanks for the clarification. I will send the v2 with the mirroring fix.

>> Having said that, we should close the gap for such mistakes from VMM side
>> though by rejecting mirroring of sev-snp VMs. I will add a patch and update
>> the migration kselftest as well for sanity checking.
>>
>>>>    		ret = -EINVAL;
>>>>    		goto out_unlock;
>>>>    	}
