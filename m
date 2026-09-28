Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D997D5733E
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 00:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790554676; cv=none; b=ptA7EcoA7MKBy+tuIEDYay1oNJR4jaBRFCrA39A07zhSgR0CUl4pdUl3KZCApkpYlmAFErjCc3XWGizl0e8uIAhF0d0JjwXtHY4ElBVdxOByd7JdkuxnA6DnCmlilYQ2FNSTxr1+bxV0UXRptlpC/nwYSdSBcE+dmZ1x9LI/rjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790554676; c=relaxed/simple;
	bh=ifw+HzxZH0UaVzz+sFjUcHPMO+kHUsiZo7FPvHHz3Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhekecF8vTi/0+9FQxL52iZ5ZEkXnmMXiWvS0Xq4bYwnskUyFS+SjySDxUAp2i+WgSTRO2yuABmJ420gPNV+uvEFXB/v08diooWB0m/eF8v5vOm1hLeCAzrMxyp+klSewKNCgxnyzPJ7h1F8zb0HsJBASIkKOT6ZQRqtVwTUbGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BFAqeBTN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oci1sAOc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFAqeBTN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oci1sAOc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790554673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2m73jnLSddTXID/zMijmWEgMqVn35akPc9oFGshsowE=;
	b=BFAqeBTNvA0oPO8w5a16/g2OwWHe4lpQo11zmnLZxZy+veF/QwIbV2XHS1/D4wFYoEKqfV
	/8i03xM0d0vxq1B4rvVLRxwtyFkvO9KW2M4JXr77Egw9x/Buifb9uj6JZeErg9DruWdMKk
	j0h/g/kjRWztKZgJVzPkW7b1TuebXGw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-49VdkUKlOeyurk-0bQf1jQ-1; Sun, 27 Sep 2026 20:17:51 -0400
X-MC-Unique: 49VdkUKlOeyurk-0bQf1jQ-1
X-Mimecast-MFC-AGG-ID: 49VdkUKlOeyurk-0bQf1jQ_1790554670
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-86917d18a02so1953004b3a.1
        for <kvm@vger.kernel.org>; Sun, 27 Sep 2026 17:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790554670; x=1791159470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2m73jnLSddTXID/zMijmWEgMqVn35akPc9oFGshsowE=;
        b=oci1sAOceaFHpy9p6m1BFAcjzRSgzmEJxyjuOUXsvwxeXCkX61mEYLAnpYOWssGAnb
         G4/BYMMJk38phZjYWpRKHS9vzS+RdDg51Z2nfD8dmf9OHRn4uT48crx6gx5qrcVAH7vl
         juuWQ53fpNzONnvKmnoqnKEXYZ0IVpCx2uukvPscGWVwyD7/MsNezxJv2QBaDqE+u3WH
         W06KaWCCnxvfCKyke8cDTMJHgum/uTf9nZXAjGDms/Ff0zgK5kUUqSzVDZ7FfIqrP1Os
         5FsoaM+pQefdz7ZILTX4iJVccGeAl2qzx/cxby7nJNgmzC+Hc39rBSZsMprmjJ4w6ZC1
         6mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790554670; x=1791159470;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2m73jnLSddTXID/zMijmWEgMqVn35akPc9oFGshsowE=;
        b=2jjRFW1tG7UaOvrsqodeSgp6GPg6r2k9YwrTn2iNn+GBTj3TQ7mcBqnYWxl0iTNrBg
         uwjvh6JAw1Voo6qXo1wJL9EaMgLbe2GnNdGJOjxeFifYtM6me+zmha1hqXW8F5ABKCpe
         078fAO2e9pZrzmPzpf1Imw8FIjP9e9+WErQsGH/KJZGF+75a4IGe142J97fQSuZIGUQX
         OrWtnRHJs38M6S8W/jvAC+xIl8aUyREfHn91OoB0dg/rHInZESvtIsMhJXAnmDbkbIPq
         Yx81T0B6CdSsiOJVCH9ZZEnDlNiTEueqimGU2cXdMVTM/Id4DDVIKgvNbWcoPqVv0q+V
         Ml0A==
X-Forwarded-Encrypted: i=1; AKwUvBwr9smuS8f9f/gUc1mx+TcWnvJK0Wzd7SjsRHczcdWUIoM7vvdGM3dejc/U1EEgJNX0DhU=@vger.kernel.org
X-Gm-Message-State: AFuF++kFg1gde2/ZCoAz/zAUqN3Bs0A6NCHyB40Aw17lj3AhT12xO/8s
	rs18wzVg0t9nQOBTpvcTmTwTvERFwPZ+m4A4o7+4msiljCnemUwib7NLryb1BuoNR+KrW6+WY4j
	P3FomJeJpBdlMhWct96thX5Zv7fsyDh17k62pLvJphH48iCIjj6vMrQ==
X-Gm-Gg: AYBFou25pJCnC9ad5DmWwyKtNVnKaGzYeRtbVOQzxtEghYvzWLcd6DPmpjyMh8qfD82
	5Ugs9sG0wd1yg65zR8yKQTLiR9PEGzyBwxnxNLg5DIcB4uIHf8n3HYGis7qkaHaqGnE+yjJe4+u
	a5qKsNi97kQd+uINBPIQjI90OEh4KqyHyKCTyLMCSAtZENPwxjBJZWH/BZGbtyE4Uqm1IEG7efv
	KhuNg2c5xXB6qR5YpYLGxzxq/8tn60/MTBuHwYDJTx/SqeBioKm/lZZJkEXRsM4Dq+1gf8LfNvM
	awlAzqFKAqbVwruXRR574eKKuzJU6zhCqkutwbS07jSXSEWzQwPGbEGtsM9ecwChyEumcmX4Urq
	q3V6QpmeL8cQnX9aSIWhsFK7K8o7kGFktvF6jyoYZ+w==
X-Received: by 2002:a05:6a00:90a6:b0:878:34e7:9a3c with SMTP id d2e1a72fcca58-87e9c06a4b9mr9378149b3a.53.1790554670306;
        Sun, 27 Sep 2026 17:17:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:90a6:b0:878:34e7:9a3c with SMTP id d2e1a72fcca58-87e9c06a4b9mr9378123b3a.53.1790554669847;
        Sun, 27 Sep 2026 17:17:49 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-880951dbb8esm2754588b3a.24.2026.09.27.17.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 17:17:48 -0700 (PDT)
Message-ID: <ca399842-678a-4c82-81fb-2c66b95329bb@redhat.com>
Date: Mon, 28 Sep 2026 10:17:40 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 08/20] KVM: arm64: Reuse kvm_stage2_unmap_range in
 kvm_unmap_gfn_range
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
 <20260920212845.707-9-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260920212845.707-9-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/26 7:28 AM, Suzuki K Poulose wrote:
> In preparation for adding VM specific backends for stage2 operation,
> switch to kvm_stage2_unmap_range() instead of __unmap_stage2_range()
> from the kvm_unmap_gfn_range(). Drop the bail out check for protected
> VMs and defer that to the one in kvm_stage2_unmap_range(). Later we
> would replace the logic in kvm_stage2_unmap_range() with VM specific
> backends.
> 
> No functional changes intended.
> 
> Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm64/kvm/mmu.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>

