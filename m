Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516E531354C
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 03:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791255736; cv=none; b=t86xA0zooZ8ctfLLIleaF4XF2t9bVMllPFWF+/MbCyJp8x9EcEvaP9wxR4OVu9B5sLkAqVH3abCSUpZu7DmRdMpvWuhC8UKRfshfZYzZ/LWtJmwEzI5H4KYQJ41ILtAtKR97H74AQlvvINZ5xSJbk9dHIEfpJC6IOWQiU8Bd0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791255736; c=relaxed/simple;
	bh=GCdY9Mytk6VjiaMyjYFYbwfdFDoSlwGK8OpG5whr+QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aIBSLXJ1R+5f+4Dthln/HoR/8XtAabzjsrX42pd6S09OuKyAOteqmD8DzEZtHwHR/VVGc8q25mL/cmhXjFg1qdbKKakdNikUK8h2cuM/OlOv+4aWoU5TaQCZSzN/JvlwiWHpaXYNKFTYdO0XpllyO5NcyaJGmZhxstUQxNFC5FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i94iBIAd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=krFzOlGX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i94iBIAd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="krFzOlGX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791255734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cWiG6eJGXgBSN4c8Xoej81PdjyTj8pUWGToWroZ4W4=;
	b=i94iBIAdIBNYVuEJbFWbCmtJ7Ig9rtyVJaZiyETW5Pe/cDjEJY7TiVYabIPsFkvM47+lVL
	gNVz+eQxmdW8SUbaMV7uRciALvVxHxeKxp2cmRcjH5btk+KRopoyTwV5lsLB0aR5ODK798
	TvaBZDVHVlFFn9VWk4kjAiXNC4k+D1s=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-nU6mSQD4OROo3bGA0FvYKw-1; Mon, 05 Oct 2026 23:02:12 -0400
X-MC-Unique: nU6mSQD4OROo3bGA0FvYKw-1
X-Mimecast-MFC-AGG-ID: nU6mSQD4OROo3bGA0FvYKw_1791255731
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a47a81e70bso2523204a91.0
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 20:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791255731; x=1791860531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5cWiG6eJGXgBSN4c8Xoej81PdjyTj8pUWGToWroZ4W4=;
        b=krFzOlGX5NzoR/hquDslfIFfzveQFEvoln7djnwpQRk+PpEMJjUD/KDMw+hwbnsnEZ
         RrnJB7nUNpzo5dyAyiwQw9jfGvTgEl0s/oVJIR4oYU9sTPL81edOnkyc8cJ32gMTK+NY
         HODUsAVLYhHHG+gzFkQWwrSTcryD+VmmSTTXtl1QK6thNMzHSie/XG4LN9ukcLDLIhTx
         Vr2wfIX38RLYsWDEEcKQISfnj5s3bvV9Ka59Y49JTqgQyvBKroDgAKocN7iJfGxGteuS
         QzAmyBk4ji6YttzYqegyEPMsgctn3lBcHY27HCKapNOnoXYSF/HpaJszpwR3sVUVM9wO
         a8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791255731; x=1791860531;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5cWiG6eJGXgBSN4c8Xoej81PdjyTj8pUWGToWroZ4W4=;
        b=l5GxB6QEgzMXqe4lwIHR8Jvt5OxwQ9g51yy/UaaNqMOFu+Ks1EJmhraFbkRrLHKQZA
         zyCIF69doATyayEfdUDUUvo0FlYAL+HffaxDGnbm5oqKZRwTyyhyiKRXFxj9sy5FWOL5
         imgTfovkekpN5m9mhAYMI024qgZ+aZXcN1BKDMTTRig+RS03QrBQrH/zCIw0O9zYAwRK
         FhHduHlDLr8hUZFlhew+y98Sw+4xqxvWHGw4Mk80iTwC6uhKcgFYyyfUSuou1z6Rt7H1
         OVtQWj0940aZ16jcFVooJA7ghK5/paVpI9C8poVM/Igkjb9bxQqNTWAtytZl94GsYtFB
         cJ9Q==
X-Forwarded-Encrypted: i=1; AKwUvByojQ3fJ4dKd5YXQoXNjhJNKa3Eq7OUMZh3tO2d1w9fct8s44UJ/Mco814lzVtp6xAaa/E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJew7B5UGoWKuet/rbHCKZjkPdlWSHPhJhqzv/4oaRUfHc0Vv/T
	WcrzW5JUKo38Zk019b6andYz/5syIDx0FL+HYZdYmfgfD2bC2Ku9vS+cQa9+9ekQh+E7a2cYYk2
	qUx997JD95oKRF0Z0hhJXKh/w0vqPCnc/0RkJFMvZEN0VVMr1tQu2Xw==
X-Gm-Gg: AYBFou1tw7lAspQEW0WlTGyWYk6pFz20BZXvkWzZ0U33oOLYEd7xvyuIQwJIFrdsfhM
	xh1W7ILmCvCi7tfdOJ3+8yXdeCz++Hqpfwb1mtk8eTKSp1l2QbetpYlbUhHTi28iTAML8gxzFKZ
	DVKwtdTHXofOlq6oD2vqU0c6j9YqzKzP90gXIXQguthol4C930qNb8AkalaxghN6ayAPlyD/s8o
	/D5poJElf/6kf1CqgwLThX8D/8VxqOzUlAPBdes9xmN3uqok+QHWng9XNvd2xlFzlwl78qlFBoF
	we3SN0tf3s1K3VR7T1lj6uuhwlYNcDOOqi77nlwHrzJ7a2hBNc3Ooij+Y3kVfHWWiVJGrFKM0mg
	JEXdKb+j00RdMug9dUyowsShA+23z5ND20P6qWRtw/g==
X-Received: by 2002:a17:90b:5483:b0:39e:345b:3322 with SMTP id 98e67ed59e1d1-3a873515234mr14418a91.23.1791255731423;
        Mon, 05 Oct 2026 20:02:11 -0700 (PDT)
X-Received: by 2002:a17:90b:5483:b0:39e:345b:3322 with SMTP id 98e67ed59e1d1-3a873515234mr14387a91.23.1791255730940;
        Mon, 05 Oct 2026 20:02:10 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a851630206sm2440345a91.0.2026.10.05.20.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 20:02:10 -0700 (PDT)
Message-ID: <7a9f554c-f39a-4423-a84e-a4766c7223ff@redhat.com>
Date: Tue, 6 Oct 2026 13:02:00 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 12/23] KVM: arm64: Use a local kvm pointer in
 kvm_handle_guest_abort()
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com,
 sudeep.holla@arm.com, jonathan.cameron@oss.qualcomm.com,
 Fuad Tabba <fuad.tabba@linux.dev>
References: <20261005090754.2140522-1-suzuki.poulose@arm.com>
 <20261005090754.2140522-13-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20261005090754.2140522-13-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/26 7:07 PM, Suzuki K Poulose wrote:
> kvm_handle_guest_abort() repeatedly obtains the VM from vcpu->kvm.
> 
> Introduce a local kvm pointer and use it throughout the function. While
> touching the code, fix the missing whitespace in the
> kvm_is_nested_s2_mmu() call.
> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm64/kvm/mmu.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

