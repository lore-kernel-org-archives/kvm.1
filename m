Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B56935E1C3
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 01:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558977; cv=none; b=qk2DlDsxLFfSukkRs8D1Jo1sjkqNGktE0s2Msohh4QxMZLjPPZfQDH5QnzB05yqGzJeFOngEaCIJuzCko115caG/8crFavIqbeosd5If/ieqKeKk4drDJbxcPTzuThkI450KwylawnEYsmcwa1KtxZXuHEUKQ+orGR8dW7a/5V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558977; c=relaxed/simple;
	bh=6l5SM3odIjYsratn5+hyANF/3A4SjCbou9O2TWWTn/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOshN5qtOXJ7/g3kpE1FT/ZfBKhqAMJInrRsnxeOxVI1u2PqvZ/bTbe1wt26CkTx7aY9T/VeAWASZohqp6wsLzjxPUCCjtzdMfBfBGvEd2qZy8y0que06HhuPFhc8LdHUxAm/xV4hih93nHrUw2MvFl9Ibou5cwI4Vm9xi9W634=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gZ+/TSO2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lU6IxDz5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZ+/TSO2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lU6IxDz5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790558974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPTRGSRmIEuAgsqdZVsCgUbEv8K5pyxuaYYIDQSv9zo=;
	b=gZ+/TSO2s1s2Pu7kdVIYmVgExqkn0OxgXY3hBfV5xuR8t2A5qCYiuUcH1ZclvKtSptr4fW
	kt3O2GUluFXPUspF/tHHuqp4Vo2h2MMnd3MZee4nyO3YAgUVVGE6zpMRR8lbaCglCRZ53l
	QCt3/7DAqe9yJ5X3t0QZmkjEmNnxBUU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-6sDXOfwAMwqOnBHEI165ow-1; Sun, 27 Sep 2026 21:29:32 -0400
X-MC-Unique: 6sDXOfwAMwqOnBHEI165ow-1
X-Mimecast-MFC-AGG-ID: 6sDXOfwAMwqOnBHEI165ow_1790558972
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3968bb86fb7so2566974a91.2
        for <kvm@vger.kernel.org>; Sun, 27 Sep 2026 18:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790558971; x=1791163771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gPTRGSRmIEuAgsqdZVsCgUbEv8K5pyxuaYYIDQSv9zo=;
        b=lU6IxDz5jTcipQ3HtR/8J8BxoetGv/PgjileNChEcLIRU8hD1nISbSmFQmFfQoUC8q
         uAFr08iqf6DGWxO3Xclgje2FQvcxPJmUhuCXGsxXZp/ZB+H/T11uuxfDXEFKEC6+oO5a
         YbHUiMWhhwpCIpv6w0xgIpTYb7nltTU57AVLlIwSvnQdh7MbiWqD1Qjf4MBGd5JbXbK9
         vHoJjXoeQuMuJloa7ALK6wrnbJPwLYkW+iYmQEQBEeWN+1QWVBLCUmRZmiI2AiU9mHMP
         7tvBabahLl5d1FiZ/oU6oFpUDGmQ5n3aS26j3l93qLyN45XrHVER5khwqg037fsYckZ6
         BzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790558971; x=1791163771;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gPTRGSRmIEuAgsqdZVsCgUbEv8K5pyxuaYYIDQSv9zo=;
        b=AU9hCbloSSdjizy8MUvMJXuCuY345aaMzxRFjGPh047TESN6EmT1Qi3rSawOI2B2GK
         9bwPkuFtUCqXZ3CJtv/ef5VTkzvREysGUt+TFaABZL7W07/V7V502CAhaZCYI/z5a5GZ
         ElBL0X6w7oqcnTzB4cpt++R1jB/LZ67PzD4cnIZNm5dpjth5O8n5YsUbbvPYmED7iIiy
         nc5utfW5yVZc46/sXBGiUMS5geAd6sTFbl8hiB3FZC3LOYJSHKGphy6JZ9JVBvRqbrS9
         jta1M/bo38WAkZ7nED3ZqvizwuuNAacspbDDKTbkHAlp1Zt8B5noeqOvXAQrWm4/AACP
         ujXg==
X-Forwarded-Encrypted: i=1; AKwUvBxXdvU6yokiRF5rLi+yFFav1gy49IrC03X7meJ/Ac2/S+CguaKnpd6KwKwnGPacJq0hZnU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUzrbLkphrP8aqsR5KdKDUH3iLjLvMNfO7+MzZ0pQoGAueRVju
	1XE64AgkeJBpSJAbeID+/mJUWEJCX1+jTV7Wpc+aZOJbVkPFCozovVKNvRy7LrwdVJmPF9X22Su
	A3VWwYrng3vSVeHvpigW/9EJEPYD/UsBrZEiu7gMxzw6y9b1/lWfYjRa1jdU3XQ==
X-Gm-Gg: AYBFou0zEw8pS3BDY/6IiE96fgcYfGTah8Tdk0kmW15TqWioHtJkanYGGLTrai+dK0v
	kWSUtVLz4zfxHGPSov0fFS5uKO6VoTnnXMDcQ8Uj9ggW6SWxUErOKh0NTlpR9cXkqIdHmB2DiKt
	e30z41SMIqkvJGK2HbLbRYR4RDYqzWTFH4rBrz5SSLrNXip0w2vjE3R+U3ocy6lCCMAIgZFV5Bm
	Iikr7sOVevVVXAUVZ4EZhMVEY+IWuN7th8uwa2mc77DYD6kSXUCarp2zmnDtq0W/tR1fyIKI9LZ
	7SoepYBa1n/PZ0TpkeRhxMpi1ofbK2AIPdCLsHSwOw2hM532k0/um3jrtIq0ZwBTXvbCfxcsmbq
	7vUBY4kfj2od+RcUfiwbce4hHROQqvNQ4TH3Baq72Zg==
X-Received: by 2002:a17:90b:2ec4:b0:3a2:b59f:639b with SMTP id 98e67ed59e1d1-3a2b59f6deamr1580714a91.54.1790558971580;
        Sun, 27 Sep 2026 18:29:31 -0700 (PDT)
X-Received: by 2002:a17:90b:2ec4:b0:3a2:b59f:639b with SMTP id 98e67ed59e1d1-3a2b59f6deamr1580702a91.54.1790558971111;
        Sun, 27 Sep 2026 18:29:31 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df913ddc55sm32916295ad.23.2026.09.27.18.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 18:29:30 -0700 (PDT)
Message-ID: <d1ad37f1-f87b-4812-a202-8b5e949fa1a8@redhat.com>
Date: Mon, 28 Sep 2026 11:29:23 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 19/20] KVM: arm64: CCA: Expose SVE VL register before
 VCPU finalization
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20260920212845.707-1-suzuki.poulose@arm.com>
 <20260920212845.707-20-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260920212845.707-20-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/26 7:28 AM, Suzuki K Poulose wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Userspace must configure the SVE vector length before the Realm is created
> (as it is part of the parameter for Realm creation), but the Realm VCPUs
> cannot be finalized until after the Realm Descriptor has been created.
> 
> KVM_GET_REG_LIST currently rejects the unfinalized VCPUs, which prevents
> the userspace from discovering and configuring the VLs for  the Realm.
> 
> Allow KVM_GET_REG_LIST for unfinalized RECs and make the SVE register
> enumeration handle the unfinalized case explicitly. i.e., only expose
> KVM_REG_ARM64_SVE_VLS before SVE is finalized.
> 
> One adverse side effect of this change is that a KVM_GET_REG_LIST call that
> only probes for the array size will now succeed even if SVE is not
> finalized, but that seems harmless since the following KVM_GET_REG_LIST
> with the full array will fail.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v17:
>   - Rewrite the commit description to clearly describe the purpose
> ---
>   arch/arm64/kvm/arm.c   | 15 ++++++++++++++-
>   arch/arm64/kvm/guest.c | 10 +++++-----
>   2 files changed, 19 insertions(+), 6 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

