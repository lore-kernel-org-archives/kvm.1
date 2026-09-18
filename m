Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com [115.124.28.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B8342E41C;
	Fri, 18 Sep 2026 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789733445; cv=none; b=MfODIDCZUCjXTaWmWs56fft0N5id3y0mF2prsldXlb8+GSFj7R9z9909xNdZUfI8WfY199ij0sjMyewRg7nThSaWi+VKA7CHe6GMw4NU/GuOR/AA2hmGVlds35yY79FVRgUS7RjAdeddf3Dfv1+rA2L2ljylZsM1wHJAIqe6eBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789733445; c=relaxed/simple;
	bh=qC80/WyjffPt8YRKSFo25QXE8kge+wLFhwYIxJw/FX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdA6g4HEQTufyAMYviQqKeQBKmRj6S50dQb+x1uG78Dktemu6oSHyaQ3ExNFn64wCu2M/LU2m0NvnZCy0oswYQh4X374VWYjPCwCIczt0CBUBV53bycO6mFWlsVGS24nKOcp5nlESJc/G2/DppNkAIx1f85iInCY/DXFVVnvRNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2304931|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0203765-0.00239436-0.977229;FP=17094244725015803693|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jGpkU-r_1789733431;
Received: from 192.168.1.4(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jGpkU-r_1789733431 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 18 Sep 2026 20:10:32 +0800
Message-ID: <057c0f72-cd6d-483c-8246-8a3db4c0ff2a@open-hieco.net>
Date: Fri, 18 Sep 2026 20:10:30 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/8] KVM: x86: Provide INVLPG linear address to
 intercept handlers
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1789721173.git.zhang_wei@open-hieco.net>
 <2d608f82681532f3010db14ff8d4293f57620514.1789721173.git.zhang_wei@open-hieco.net>
 <CALMp9eQo1WZhtCEmPhsK=BoCkeSmMfwXh-JHsq6-E0HCkOunVQ@mail.gmail.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <CALMp9eQo1WZhtCEmPhsK=BoCkeSmMfwXh-JHsq6-E0HCkOunVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/18/2026 7:10 PM, Jim Mattson wrote:
> That comment misses the main point. Perhaps something like:
> 
>          /*
>           * Ignore faults, just as em_invlpg() does. Calling __linearize()
>           * exactly as em_invlpg() does guarantees agreement with
>           * em_invlpg() on the linear address.
>           */

Thanks. I'll use your suggested comment in the next version.


Tina
