Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BD3292936;
	Fri, 27 Mar 2026 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774576525; cv=none; b=drZS/Gas2NGzYrEjOoBLWFlkvXZJoTTwwhE0zg/nMTIUAmqxtLk0+pP4Thv31omr7bvf+xS5IbXQl6UIAjjsqvUNU1QAB3taggFlDwCNavcOC5UFNJxqRhUASU6ebhibtxbhw1E0re2GFd2QlHGMZqQItc2tzwr70ovAbUI+YvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774576525; c=relaxed/simple;
	bh=gmWHcK0itBJflslaMey9sIx8Sa4CGA6KauodlmEmpyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uzTRtwTXirxZ1i1zLOpymODM1FlbRu5cDh5NBp0aXPPHHPf3ldTGWL9xUt4aNzKVG0lCXdIaNLgx/zLsVEl+yFN97t52KHZ6mwS2ao3O8TAMb8yxXJXUjiCiCotwevbmBKDJFYIbzXqWd5MMgnC20L5MRfaLinUzGwCRZzN2rZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jWrjE0pW; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jWrjE0pW"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774576513; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=2uLbyltTDfwJ1fVF2fuBWPNnUybJwtx0WCtLyELmNt4=;
	b=jWrjE0pWJ4cIlazPFmbgrtcGGVMJIL9vWDugyBefcv4MW0QO3LUL1cBQ19e1Mz+tnwfGdarNB98uB3ox7xUlAN4RIj4g+FmqN6f5YFoSZVbibbFsKG6dad+Zup7zpNc3JymBr80CfIgEk9CimWX4SozGtWC2MHyFBwK8/5mWUt8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X.mTcjL_1774576510;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X.mTcjL_1774576510 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Mar 2026 09:55:11 +0800
From: fangyu.yu@linux.alibaba.com
To: anup@brainfault.org
Cc: alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	corbet@lwn.net,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pbonzini@redhat.com,
	pjw@kernel.org,
	radim.krcmar@oss.qualcomm.com
Subject: Re: Re: [PATCH v5 1/3] RISC-V: KVM: Support runtime configuration for per-VM's HGATP mode 
Date: Fri, 27 Mar 2026 09:55:06 +0800
Message-Id: <20260327015506.79079-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CAAhSdy059XmTckHrX8xjk44pR=1BkaUuPQ-Cf+4BRTBoigBZ+g@mail.gmail.com>
References: <CAAhSdy059XmTckHrX8xjk44pR=1BkaUuPQ-Cf+4BRTBoigBZ+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> diff --git a/arch/riscv/kvm/vmid.c b/arch/riscv/kvm/vmid.c
>> index cf34d448289d..c15bdb1dd8be 100644
>> --- a/arch/riscv/kvm/vmid.c
>> +++ b/arch/riscv/kvm/vmid.c
>> @@ -26,7 +26,8 @@ static DEFINE_SPINLOCK(vmid_lock);
>>  void __init kvm_riscv_gstage_vmid_detect(void)
>>  {
>>         /* Figure-out number of VMID bits in HW */
>> -       csr_write(CSR_HGATP, (kvm_riscv_gstage_mode << HGATP_MODE_SHIFT) | HGATP_VMID);
>> +       csr_write(CSR_HGATP, (kvm_riscv_gstage_mode(kvm_riscv_gstage_max_pgd_levels) <<
>> +                             HGATP_MODE_SHIFT) | HGATP_VMID);
>>         vmid_bits = csr_read(CSR_HGATP);
>>         vmid_bits = (vmid_bits & HGATP_VMID) >> HGATP_VMID_SHIFT;
>>         vmid_bits = fls_long(vmid_bits);
>> --
>> 2.50.1
>>
>>
>
>Regards,
>Anup

Hi Anup:

Thanks for the review.

I'll incorporate all of the above changes and post an updated version (v6) shortly.

Thanks,
Fangyu
