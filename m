Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADF336C5BF
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717487; cv=none; b=cx9ora5xXwoHmxxiYroibHDVKOC/vz0URal6xAUd0dpH5g44L+m8bnOeY8xrHCbhFF2H36EbMYssB0JQ8ZQ5mKnAZLwdYlKiJabU8vB+CFOHXzKV0cpke/lWvyO2SGrGV3rM1173j9nAOfA2OTNqGSTYINUHGx1ZVP3Ne8Yexdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717487; c=relaxed/simple;
	bh=ZsLS64Hnoro9X2Rw44kr4i/FJwSCuS7AdtDzOUVMBw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GIo5vEKeY2lvTe9P1sGfNbe3jfa8rsK1IS1eBzsywygPeYcGlxkjyM53UoAsE/CLpT/UloX99ToBaWPTSRgkrTMiuayfIgzbaQkLLHRyt48W97h/pfLMYgwO6HUTYjbOdBpUCs3GoOY5Nb/xUPs8lzI/La/U8l3EMHC8cOkKpUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VJ0oTRwP; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VJ0oTRwP"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786717475; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	bh=dCVkyBGKUiIwvW+iAlApwR+U4IWGzViKfJ55qQWYBgs=;
	b=VJ0oTRwPkB+9SGPEd+ka7E41FBdXiWtdz6QWcdLLUsw/KZqfYYnqKpaHmgxwWi2O6R0m/2xeumn43BKU7QakDaqcPg3IuQiUzEXscOebr0NNYyUMYDoVppv2fAAApGILi897V5poZbyrka0w0WoOUcgt7ysoM5ExxQhrF2ulBZk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=zhengrong_li@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X8xg1sm_1786717469;
Received: from U-92DF4J33-2338.local(mailfrom:zhengrong_li@linux.alibaba.com fp:SMTPD_---0X8xg1sm_1786717469 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 14 Aug 2026 22:24:34 +0800
From: Zhengrong Li <zhengrong_li@linux.alibaba.com>
To: kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, zhengrong_li@linux.alibaba.com
Subject: Re: [RFC] Expose L1 guest register state for nested VMX via
 KVM_GET_NESTED_STATE
Date: Fri, 14 Aug 2026 22:24:18 +0800
Message-ID: <178671745810.32460.571521428477125444@linux.alibaba.com>
In-Reply-To: <an8QybMBNTk3zdIF@google.com>
References: <178669637845.81620.8189698601844425753@linux.alibaba.com>
 <an8QybMBNTk3zdIF@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks for the thorough review.

You're right -- vmcs12.HOST_xxx already carries the essential L1 context
(HOST_RSP, HOST_RIP, HOST_CR3, HOST_CR4, HOST_EFER, segment selectors
and bases), and KVM_GET_NESTED_STATE already returns this data to
userspace.  I was focused on vmcs01 GUEST fields and overlooked that the
HOST area provides a practical equivalent for debugging purposes.

I'll drop the kernel UAPI extension and instead work on a userspace-only
solution that parses the existing vmcs12 HOST fields to present L1 state
in QEMU's monitor.

Thanks,
Zhengrong Li
