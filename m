Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22103033CB
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 03:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791256237; cv=none; b=EjHlBrijRThOMHckqyFVa7kd+ScnmeroxWlI8LhjE4SETWpHGZDnEh21p9B1hPn1xjolVUF1e8tKxGMq75WHUdifQc/YMprRqPklSdTJ0ksgAGZRGUDcq5j7jhCdgUKwY84Jf4pbkQSIAWGK8jfBpMYVSaHpkqz7DscEQ71zncM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791256237; c=relaxed/simple;
	bh=76WpONBN9qNsewPTXdIKmJj1yYZGsKR8SJ9xH6J+4Rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8zzwCiUvud1JyEXr/BtCjQnlOYPRar3k4IQtHOAP9yTbcF2ZCeW4yQbGMIhwuwalnln6/iWtv55bFQ21ZMKiqix0MzEv+eNS5itwEnf9m05qP5c5S6i2OLp9iJXzXfVJESO9IiVrhc8D+9CbGsYVOieS3iKo/orYOeFZa78XTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ij7sOhlJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLSaoDpa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ij7sOhlJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLSaoDpa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791256234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLjBEqzF3bLvG463L+dBKbw7TfCoymi8l+jbKvUBXR4=;
	b=Ij7sOhlJxZbOeQ4c52K85/KW7+CnqBH/oHTIHMIdHqA+sVHz4UDvLykL4RPy1RcHsDmIJk
	lFFvIUM4doxuxSAVKrdmjOS8psBc0y/hF3kM8M7OKOp8PEg0B+3ORWRTlOaK+LfHza0i2a
	8/xCoUEw0J1BABU6celACK5OjRt9Bhk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-LrEMqb6RPJyO4sBCp7VL1w-1; Mon, 05 Oct 2026 23:10:32 -0400
X-MC-Unique: LrEMqb6RPJyO4sBCp7VL1w-1
X-Mimecast-MFC-AGG-ID: LrEMqb6RPJyO4sBCp7VL1w_1791256226
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a7d2f25f65so401336a91.0
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 20:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791256225; x=1791861025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NLjBEqzF3bLvG463L+dBKbw7TfCoymi8l+jbKvUBXR4=;
        b=bLSaoDpa5y1s+n0JlgAI3NDISV8H6Nsdd68V9Q85uYnc/sc8THX2eewHeK0DbMyfju
         wA3MPXUv8fcnbbITWG+Q1zKOw229qXezZRdo2cT3nZcghfj87ThpThnKQq+bJkrX/sdU
         pd1Ncx9b/5s4L1gQnAajiaKpYKozFwl3kRFVdymNhmZI/MUZ+69YVyLg93JcBqWXvk3T
         q5PBhkMNqACBtaNCUbY6DXkwARpJK0w2RRRGDaZ9aKxd4M/ldleO12/IaYxgyb6cD6po
         WaDaLnlxXjbRRRvy8Jz9INxRHrH1fZTudNlLZnlA2BbqY9bA+SDNJJSrZI8BO3OTBl4/
         SsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791256225; x=1791861025;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NLjBEqzF3bLvG463L+dBKbw7TfCoymi8l+jbKvUBXR4=;
        b=Zt9AHQOtZsWgyrwccQpoc6Dq/AdYsoc9LYFs2mC/fLAmaSVpO7GUyiLxMfKES2cJkx
         8uZ0O6JDjKqnoCvVOIqV4KVbJvj3UUeYJ8LijfXjOkLqB13oMVYhplWT4lY0vF9aQ05h
         nQoTYflG2gBFYs/TDUID3WU7BOsRwDlvn5WebO9cKpqYskE6Mh2BTxsQRrv9RFczbBxE
         fK/U3LROYwX4ndPbIJEVcwsMKAXEfup0qOTJykDJPUWki+cHcqaEagQwmcG6XR4e2cXq
         SJPYoFJLzCIXEFnrQTomEkFpbju7EHXHNybkNVn1FKHF6WHQT+jFleDVDFwCyjevX6Fz
         K+uw==
X-Forwarded-Encrypted: i=1; AKwUvBz8QzvBy8p5YZ9eI04S6MzAy1SQKq+nct/yftlAmJnwXdmLZNYc/CukxCgyK/2GI6ccV2U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIcvM6VuAvKd+FNAbOVXSYdboPblqT2Vpydy9pUqwqauBuQ8Psy
	nmnAD+ddHcldReCTQjzgD6YJiqrAbzQg6MvLNa6wMrvB7J1L7639aE/VujNaHSDnd8PJ6RsI1fh
	h8ZK7+Zo2bVEk0RjJtqisgbFx0JxS3P9OAAz9J/0QXNWd1KgNldaUUA==
X-Gm-Gg: AYBFou1bKPUFKXj+WMVJfijXlXLK9HGrmnPtQ8g+Nhe8n9gY5I/QmzUS7r4nW+JUaxW
	F/R3naEJw+empALxtNqnm4FVew7ZKHIMGLBxpUISf1aWpgJ8eDK9OdkpVp5j3LiMXmMtEyXcnk/
	t3N9diS0QCWaZTPG216kxeLIicP53MvpvE/tzCxv7SyVUTQjQOXTlZzI4yfi5oAD936hxJqWkBH
	305RC0lsF2OCwmlrDOAobAjLWqAhF21ay0zNFYfBRKzjlDOP+qC4ZHiLQrkDZ4AqJv3cZxfuVhm
	nDBDZkuWtRSHlGBeLfCzs/PQYNocpyacnyp3WxcCXkYmoodXZ7Bm00ab22V54VdKrzbJsJKFjXX
	lgan5uYtDwtp8J8yMgvpqSPRWHYcJ9SN0nQDQNd1nwQ==
X-Received: by 2002:a17:90a:d64b:b0:3a6:d2ac:74ce with SMTP id 98e67ed59e1d1-3a87368d0admr19243a91.19.1791256224576;
        Mon, 05 Oct 2026 20:10:24 -0700 (PDT)
X-Received: by 2002:a17:90a:d64b:b0:3a6:d2ac:74ce with SMTP id 98e67ed59e1d1-3a87368d0admr19217a91.19.1791256224127;
        Mon, 05 Oct 2026 20:10:24 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8543b0c1fsm3110944a91.14.2026.10.05.20.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 20:10:23 -0700 (PDT)
Message-ID: <9f9575f0-be48-4dd0-ba1f-98d8dd39f10c@redhat.com>
Date: Tue, 6 Oct 2026 13:10:13 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 14/23] KVM: arm64: Mandate VGIC v3 for pKVM VMs and
 Realms
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
 <20261005090754.2140522-15-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20261005090754.2140522-15-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/26 7:07 PM, Suzuki K Poulose wrote:
> pKVM does not trust the host. Realm VMs follow a similar trust model, with
> the Realm Management Monitor owning the protected state instead of the
> host. Add a helper to identify VMs that run under a host-distrusting
> hypervisor.
> 
> Use this for blocking ioremap of vgic-v2 into stage2 and prevent creation
> of VGIC other than v3.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm64/include/asm/kvm_host.h | 4 ++++
>   arch/arm64/kvm/mmu.c              | 2 +-
>   arch/arm64/kvm/vgic/vgic-init.c   | 2 ++
>   3 files changed, 7 insertions(+), 1 deletion(-)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>

