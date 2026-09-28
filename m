Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD64356A38
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 01:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558942; cv=none; b=a9EdvFTvC9N7p5CMsBx5aSSi1+RJZEtXpinicx+9DZk4yolmhhfm1ggl2kDA+agrFB8MKGzbw7aEdykiWA0j7lgUWH5Jjl1I68Xsj5K5yjyEZ8+x+9xwVFEYq8wJuf7AiPlHCB6F85RjG+qwLrIcwdrCxiuriBZXIWEhJ0Sk0Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558942; c=relaxed/simple;
	bh=K1Rn6LESGV/7OPV/x6+LGZKGuG6ZqQ4flZrk7mZ+2JA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4VnybhgWvX4hS3Lm3SIhOcpAsnaB94SmH+zQIFo8+0R0kxbemWuNw3l+xV6LR4XN7ANbSIWeLkQpE7TS43XWlNS3BQ1eWCH7GkPAMy6YkwkNs3wyWTbcz1uzm1+Mw9nEd+rXvacTY9mtJhFw0Xc18pmyi12f67+EkFPCMk4t74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfaSuEIV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTa+Quzf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfaSuEIV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTa+Quzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790558939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/Ho7D9pnwA8vFx1jX3g6jxL7io7VVBJIDHq0PV6nYs=;
	b=AfaSuEIVJYhxPBIxTIrDwUHaMLcI6NEa17vPc5mvpFDD5qWE3pNeG17tzoj0qcjB/uWJgY
	+tGeCN0hbHECiYG488GOen35HYexvfXu8WAE3+RnKyrJa1N6zokqJcgj5G6onaNJeAVOzL
	igjjE4nqiyy9qQf2gI0/EeVK/S5Dvtc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-5FJewWjwNpqzCPTakrjvXg-1; Sun, 27 Sep 2026 21:28:57 -0400
X-MC-Unique: 5FJewWjwNpqzCPTakrjvXg-1
X-Mimecast-MFC-AGG-ID: 5FJewWjwNpqzCPTakrjvXg_1790558937
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2db3d832827so29908435ad.2
        for <kvm@vger.kernel.org>; Sun, 27 Sep 2026 18:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790558937; x=1791163737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q/Ho7D9pnwA8vFx1jX3g6jxL7io7VVBJIDHq0PV6nYs=;
        b=TTa+QuzfZPoVjateDW6QK8ltvXv1UlRuyHguTfnRCFd6k+nddv32urKhKCG4XcZhl+
         JWgcJ9OVa9kDs1km1It46VBKFdCeFU/bGc/C9TjRW6A8qvO820rKYXtD1RBn+RgUpig+
         Ml1qw705S+7LR1YmYx/85n761XpcamDN0BMgFKY2pHJ3K13eg5SJFeSS2dUJzf4wyG9l
         eXvTstzkzUpa9bLII78yPyfRHjMlX3sswHpXEcLHXcPySaBWvq3lLc79KBffBTDsG8qq
         0MVYc3hbML1d3NY6IPlAC7534+o+nJ8JKosT84xO4WlIv8KdQ5w6pFAdp3NuE+8LjXUH
         v6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790558937; x=1791163737;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/Ho7D9pnwA8vFx1jX3g6jxL7io7VVBJIDHq0PV6nYs=;
        b=XOO7vPL8XklVwy7ASdbWeodtUQeb0VmRU8toHna8EY5K/wQjM9hwo6yUXonoHkLs9R
         XRBZnnWywS0gYkqE5/63GNNOSbIEe6T5a1ggQl2ZDihdBrWYFF7YdwogvoVX8izR/zFt
         hdNheorBRRNNUJNt2/BEcYVL9H57y6wZf9q0M0zKb2sgUfsnpnPfVrEPrQUXf3vpJk4s
         +IaqYnuI29ziHXT9vyvY+2mV/gYDZIzqiTZFpwdkBD0oC2dEFLfkv1gzD9swRravogOz
         qiYYxQWzELaNkgvCOx7Rdb29LIY5dx6no+0zSkIt4EKf2Ym/e2S1Kf0KRy+cnKPX6p9D
         wNpg==
X-Forwarded-Encrypted: i=1; AKwUvByIh4O+xWR0HFX5Y/tlGVs333LMx5Aur6wpUqeVIcJ76wROnb1nkvouRETpn3oSEyvXWr8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXtY8+tcWCPsnbBzYgwAN4jyxNup9ipxA1OwMPjj+gn3eQw/wa
	Hd63lHB4rkHxOvNtLptwOSTQnuhpubzpOe016t+IG5UxNGWTqCkiyqaydDgxTZSpbkbP5HLdf8E
	2AcqeTK45fUrxmKoO9HeczlaIXlAWOAQow3wDOE0VSNFAQX6Kdvf9Rg==
X-Gm-Gg: AYBFou2qPjEiRKFyRcKKtYKjuimBC3mtnoHRO0rH2oUkv6tHfzNxbeZMEv5awn/usMD
	RGdhE8D8BOwNBF2AWGw60WTSECLzXVj1KU8DLmBs0X1IzVXJ1aH6TyH/tbHLeYSjNOTApxDJf7S
	03sTD4oDHQOZ3+SdwjNuX2tOugEZJLS7YAm6wwr/El+x4O03Jjjqv3ET9XUIwupeWJRTHuX/DBz
	MobTWskTt41nMPd056Z+nw+LHKTUweMaJV4IJ+K3DEdpWQTQ8melqTCiW/kYB7a3Ur462czGNFg
	cwRVkbIZqUap3l8iidAr3o1HJG/PpFKDEuMiuDfYcooadnfwORZpTDYnmVZkNhUQTj2rjkqOsb5
	j+5i7yTOP18iqMU4kHGKTzzfVFjN6DjM6LRNVdDQeOg==
X-Received: by 2002:a17:902:cf0d:b0:2e2:91f:40e5 with SMTP id d9443c01a7336-2e2091f44f2mr12401635ad.59.1790558936706;
        Sun, 27 Sep 2026 18:28:56 -0700 (PDT)
X-Received: by 2002:a17:902:cf0d:b0:2e2:91f:40e5 with SMTP id d9443c01a7336-2e2091f44f2mr12401385ad.59.1790558936289;
        Sun, 27 Sep 2026 18:28:56 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9142b00dsm33448475ad.49.2026.09.27.18.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 18:28:55 -0700 (PDT)
Message-ID: <699c086a-afb1-4738-bddf-54e98b8a3c34@redhat.com>
Date: Mon, 28 Sep 2026 11:28:48 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 17/20] KVM: arm64: CCA: WARN on injected undef
 exceptions
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
References: <20260920212845.707-1-suzuki.poulose@arm.com>
 <20260920212845.707-18-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260920212845.707-18-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/26 7:28 AM, Suzuki K Poulose wrote:
> From: Steven Price <steven.price@arm.com>
> 
> The RMM doesn't allow injection of a undefined exception into a realm
> guest. Add a WARN to catch if this ever happens.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v15:
>   * Switch to KVM_BUG() to mark the VM as bugged as well.
> Changes since v6:
>   * if (x) WARN(1, ...) makes no sense, just WARN(x, ...)!
> ---
>   arch/arm64/kvm/inject_fault.c | 1 +
>   1 file changed, 1 insertion(+)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>

