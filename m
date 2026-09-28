Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AB02F8EA1
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790554481; cv=none; b=gNydhmTRCrWF9xrk789GxHbMImAtThwy1mel6rtzwkZfgGHrYf/cSDHB80jl0O7kiuVCmkV9bZWtzoW+0y0vr/609r6KeUNi7m16IPjYIj0fInEroK3ZVAnZcaejU8hd8HxiACZW6QsoosjGZlUZ6BeEyUhzsjiswiici53m6sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790554481; c=relaxed/simple;
	bh=IWNXAcTPuVoDpaI/S3Bd3QXcIjw/fAWvlfconBsmVgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9bRcu4dYXCcX6+v6AVVLX5zBm3vmHmwKeEcdN0zLoRKLP2yF/yRgYaOs8lwhP299wxrV8gb3SP12N2CWaYNzBiJ5Yn+eHUDvR/UE1BTRscki97qeHcp9lhxnNpnK7aK8bpINx009Kp4Ymvhl8dzBgJFyt5egw+JOwLyKyqFYtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PbBgAn56; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hAVBn+jY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbBgAn56";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAVBn+jY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790554466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3pHPTXlsx3JeIcn/vypuvLo0a6E/wjvoL+H11fk+xgI=;
	b=PbBgAn564dLOz1h5F8N6agKyxL6Ei4tZK/tUoRQrSxj6Ek1RGEXthhVuIYzCXTtk28i3iL
	DmNPNK4N5EFj+2WLoWlRvVw19FzpvRN9T3jU4aiXOMB++VUD7lnvoJM13pdL9I9uyCr8jG
	ade2j2UZlYThTmddQW2yE512Tysbcjo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-OJuMYvfsNEmzhO2yA_oLvQ-1; Sun, 27 Sep 2026 20:14:24 -0400
X-MC-Unique: OJuMYvfsNEmzhO2yA_oLvQ-1
X-Mimecast-MFC-AGG-ID: OJuMYvfsNEmzhO2yA_oLvQ_1790554463
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so5641950a91.1
        for <kvm@vger.kernel.org>; Sun, 27 Sep 2026 17:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790554463; x=1791159263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3pHPTXlsx3JeIcn/vypuvLo0a6E/wjvoL+H11fk+xgI=;
        b=hAVBn+jYoEiYst/qsNocz621A5GjyD/h2ek8xjPwzmI5ErATcuq72Qz1cK3soaGPwC
         JqXCOLjzISbXZLDSw70QAKPlZtuNc+kKEVzpgWHmYATAWZvLuPtojzyQV3OhLP+pIZRM
         YKyENxQvMsX6RVF1c3SBT7sR3afgHIkFimHtakpVpxYOgnr2FEeHe0sFj98HqMlkslUM
         OkmCN05H6iXTC70JpNU+ira8rBWMIVPEZH/jaW1ZvaZjfnMRwqaIVv7dy8oUjV0PprE7
         l/Xu0lYuqsd/BqNjgidjmEOzYO3uLg27axXXyYIXsGsaAeV5VZnG9qea+dOxRcXYBOk3
         NDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790554463; x=1791159263;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3pHPTXlsx3JeIcn/vypuvLo0a6E/wjvoL+H11fk+xgI=;
        b=n8p/nGO+sfmeW1cS8xL32IG3+iyWcMS/ZQBbKNtWC/9Uv0vMNkZSE/UwUlUMf/gu1S
         kLjhZAV81pvt/n56np495ACT2jK1XC+DW2ci/GpXKFHGldaFK1FTS7dGCyMhnqy0msdK
         6MEmoaWHcGOzLvFr+LGHFYYKAz0/7G8w6FDYvrWQRJx3p6d7sm9tk+vnEZDaRjOU8fPx
         GrECqgBN0/JMj1Y4obOzTr19WUj9wuAkaolSpoHz1bKE9Ti69W5f93W5kL3MHeQr5rtB
         zG99LyQsjQCp7OrvtvApZvwwBnVsIbsVWLX3+gW+DmzQE4db1S1XeM0j2x9b0mBA4kaG
         XJ/g==
X-Forwarded-Encrypted: i=1; AKwUvBxCsQWu544kBrHabojCL6E+tz/121JIH0PdVjeaUbB3fHfhLf4MOV4lVkwYZgeP7y40fEU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtRcv/rqZ+pxdp/IXv26j96/kk05K5u4T8Yr04aq1xIGwKMwwu
	CqW8jowNZ8BSCyQddL1QOv/hjzko3VXgInRE54xcc6YwIZGvSQxgIUfqkqBXOcH95eJkNqGFH0S
	W8kjKkzOzUfKfdz+pA/K+HptgsIDi7IMjdah7VzQEzitOOXp+TyV8fQ==
X-Gm-Gg: AYBFou3vHBTD8ccnPB+IWl4ulKlWKJFjOPSoDqysjIT9aVJS5cIyFqySThI207kZ7eA
	LaDVnV7lXF4ZR7AnOQJfcC5ev2FL67wArnOxzjvFkeGg3tMQp5XAm5Hx8NgqkVikk8k2zqlF9/C
	DB8LX6YnQk6KCEsvTvKS+b9ghIjv9avCfKKla//ho0VbMnlshgjIqjUQ0gTcR0+pUb94P6sf6Z6
	c4VthYRlXd753TDs+JXiX4SH7TF1kZ7qKCapqF/KsoZVCx4N4l9hEX2XJfpN4kePWtWoePAn0nx
	5GFV/kH6/us9AIBincAF8txX+QcgFAU6UrHSKEVwWwrNQGyULGTRgMyC/IGroGX+SerS/vXAPKW
	DoygfNnTN3k5tFg5aN53dQ8aNdrPuu//zm1I7cXEzZQ==
X-Received: by 2002:a17:90b:274b:b0:39e:6ec6:f4d0 with SMTP id 98e67ed59e1d1-3a0bb553222mr5783303a91.8.1790554463423;
        Sun, 27 Sep 2026 17:14:23 -0700 (PDT)
X-Received: by 2002:a17:90b:274b:b0:39e:6ec6:f4d0 with SMTP id 98e67ed59e1d1-3a0bb553222mr5783291a91.8.1790554462940;
        Sun, 27 Sep 2026 17:14:22 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0bec30aaasm16424179a91.15.2026.09.27.17.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 17:14:22 -0700 (PDT)
Message-ID: <5987866e-92b6-41d7-87a7-ca1dee2647af@redhat.com>
Date: Mon, 28 Sep 2026 10:14:15 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 02/20] KVM: arm64: Disable Steal time accounting for
 protected guests
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com,
 Fuad Tabba <fuad.tabba@linux.dev>
References: <20260920212845.707-1-suzuki.poulose@arm.com>
 <20260920212845.707-3-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260920212845.707-3-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/26 7:28 AM, Suzuki K Poulose wrote:
> PVTIME support is advertised by KVM_CAP_STEAL_TIME, which doesn't take into
> account the kvm instance. Even with that, a VMM could skip the CAP check
> and proceed to configure the PVTIME as we don't do further check on the
> DEVICE_CTRL. Tighten this up by passing the KVM instance around wherever
> possible and catch things early.
> 
> Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm64/include/asm/kvm_host.h |  2 +-
>   arch/arm64/kvm/arm.c              |  2 +-
>   arch/arm64/kvm/pvtime.c           | 14 +++++++-------
>   3 files changed, 9 insertions(+), 9 deletions(-)
>
Reviewed-by: Gavin Shan <gshan@redhat.com>

