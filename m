Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15B635F17A;
	Sun,  8 Mar 2026 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772974727; cv=none; b=iDjmNdnuZHFd2wO1LsJUWB9fTxzwBm8aHbFBNDldC9A57xGkM4XvFxblLs+PL3FgdJv6E0E4sZCFO7jIgF0GwMXn+X8IODfB3HgDGgBzxvSu0GDsN5axR2/06t3T+b2N4xlWGO/6MkXMOPUm/TPGgz/loozg4ypEBFhgNVvcoXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772974727; c=relaxed/simple;
	bh=lx9Bb7FLIZfntRr7EkiP7vvmaf9bUOQvG4dmDlCZGYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOpCRZwgIx40n92TqyTPNHahDLQ7CR9gWr9oeS//KsSvcM2r2Dv0z9LUVlIn/UtPs6f5Ce3vmqk1Fkczx2YafCAak4hFU2V1TvjMOqFnGLr8hXUzzU26L6i2k14AReC36Njqv25G/PepTs2MLcU4rLOcYPDB1H31PwVEuG8LzJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A59131570;
	Sun,  8 Mar 2026 05:58:37 -0700 (PDT)
Received: from [10.163.174.99] (unknown [10.163.174.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 772833F7BD;
	Sun,  8 Mar 2026 05:58:42 -0700 (PDT)
Message-ID: <abc4ed51-2129-4bed-a156-e0e9ec4e81c4@arm.com>
Date: Sun, 8 Mar 2026 18:28:39 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: Change [g|h]va_t as u64
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org
References: <20260306041125.45643-1-anshuman.khandual@arm.com>
 <aasZ5NNo7q9MRgzD@google.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <aasZ5NNo7q9MRgzD@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/26 11:46 PM, Sean Christopherson wrote:
> On Fri, Mar 06, 2026, Anshuman Khandual wrote:
>> Change both [g|h]va_t as u64 to be consistent with other address types.
> 
> That's hilariously, blatantly wrong.

Sorry did not understand how this is wrong. Both guest and host
virtual address types should be be contained in u64 rather than
'unsigned long'. Did I miss something else here.
