Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E4F2AD3C
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 02:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791254285; cv=none; b=MNKVzLU9K9/a2zkeiG4I0ruXn/W/cNqLevs3qC6mnpZZK5VZbROimIJw0gLcgxQdHG45AcGo25tQHmmz6GpRejuUZL1Iy/Zabhp8UkqQ0o+fAXj9r9AEjjKYY9X5rOYeyCtQplTc2J1FuMsfCab5KB/CdJNOiY4OQOlrUneV4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791254285; c=relaxed/simple;
	bh=D0UxWkrGDJEjJknTZwzjCJ31q1+uUyqqvfVL7rYvYbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKwAn5nUM6pZk5YxwJbSm5rXG4EB9me1OL8UizMb9jyaQ9xUimuCbchWCaQRztSFb8XL2ShRB5XfYWB+kTtmLzPEo8pYBg0MJGYLn6utdR4d+Nm0c4VQRZ9a0QZO7bT+Xvr87tAxVngoSiBh6zfsjj4dS98IQiou5vSujmreLvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVOsThAb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jIvPOPvv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVOsThAb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIvPOPvv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791254282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Di6epxlZpoHDGpBk057UhpR75wL2RoTA8HU7YmJFqJk=;
	b=eVOsThAbjgfJPejjG4bqVZvhQ02QHi7W31R2Yt/SBPIKKAmIwXLnG6TSbHG+IFVVVL7r3x
	1UnqAO+dZWUUmlxJOZfC031BLx5bCl9WYGCY50Te10USKxU6rLOk2n92Z9r4WKhtnJAX27
	cZ3eyilKr3UrFJJ2qQgXpwnQ6P5qQrM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-Ptk8lSIyN-WmX42848svjA-1; Mon, 05 Oct 2026 22:38:01 -0400
X-MC-Unique: Ptk8lSIyN-WmX42848svjA-1
X-Mimecast-MFC-AGG-ID: Ptk8lSIyN-WmX42848svjA_1791254281
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a4b70941efso1893740a91.0
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 19:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791254280; x=1791859080; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Di6epxlZpoHDGpBk057UhpR75wL2RoTA8HU7YmJFqJk=;
        b=jIvPOPvv+546w9cDZwufBKMsOb5vqEqnoPwT3/xtabR4dnTuRFrSpDuZsD13l0xYbZ
         UKsihoDEAZ/CgOdlt22M6kZtlilbvHgruQDmb518lJm5eSD45h5iKT1KeL5Ez8FtF57K
         orXKreI8f6nBCwyRI5zqo3M0ykeyYIXuPeDg91ySBUyTakMyqbjVCI7AdqspPjDaSetG
         yqEcAIAnlU5/fI2Jo2tUh3OLHgktjmHvBHBeG3dAMNuydDmvYQxovAfkuua5jkn+W/sd
         /i2GMWZGFRNCJxSRtGWrXyNDGXlWCu2MqBFjeUnsmw5A43V2ZQxxCvQ6iBJy3LFy3//0
         ZRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791254280; x=1791859080;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Di6epxlZpoHDGpBk057UhpR75wL2RoTA8HU7YmJFqJk=;
        b=EBRKHL+OBOX65AXcDZ0mdXpdSHOWjUHZHmJMPJFhxek6NuFLEZuW2G9KbeoZO6L5vG
         e4iF9uPJq+s8FRIEN0ueYtVjZIiqh7v4QbXXEe07xQI1C3nUcNs4FAU6sgLFlgcJBrhg
         J3C41oCPFbl52rGecG2AW52w/z8Zsaryr6QxeLqN4Nu20NjSennqC38ktsGJdGOTb46+
         jI/k5TYuBd9zkZ9lBT19VlYWTf4ROvEMhzURkGx9v2kNeisXo8Un1YEu67buNzJ49VrC
         L8l7YZgINXniXOZidN7oJoi357c2LdcdiHJTqhfSniQUW8+pKAyzMeLApFLTU3bO7GYT
         nfwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzxUSP5GmQ6dZ9VfExKWqa/AZoAG8Ha4VcnMrfqhwhFllbdbVqUgxzuIH+K0bvpEiVEJ9A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNGpAuF4woZFJypezE4+wApwOO5uy6PVILaFb00H8bQFqhu7T7
	sDm7uwo65jvq3NDI6UP/tFfHj4FULsEly/iCADptcZtMZcHXDeeShS+KEX0cqFGiVsfHwY1avkk
	nEDzwh0DDzh+dYt6RMH8sfLBja2X/SP+NTWwmRJApZ1zfWOPKX2K16g==
X-Gm-Gg: AYBFou2loEstVLPk3t2xqoPuxypkHqlX98W+N4lw14+w1Zb1voZUvb4ILLzpGOcuxS2
	TBqejU5JgAvzWY3CVJaebcsUZyTEJT5wgkfwe3vpKxb8nhzdv9xLDuyEbUTMqHLaOGpTIm54Sym
	/TV4iXNhxKV3If6QX7KL8Krya7RRhpQiqNSHyBNq5UI+Lq4Le1W3LaDmzoar6Dga4dJ4bymk/DT
	BYoh6UFc64q/0nlOrBwREaAeSJ4ord1/EGZt2QRHF8EHdzD/Nw/PvsOIElpDRfcIVnMGcr6UI57
	X5kFKSQa0ge0jxk/KHd2toWOhfN2voXPtebEdpv9AEUGTo1rzUexFvnJe2Mpni8YZTss5Q/vsbM
	udovj4hkr1Gx6Ky+yCNHUyCfA5K7Wk5LCzwc+VqGKyQ==
X-Received: by 2002:a17:90b:4d09:b0:3a7:9413:cfa3 with SMTP id 98e67ed59e1d1-3a79413ddc3mr6299043a91.55.1791254280408;
        Mon, 05 Oct 2026 19:38:00 -0700 (PDT)
X-Received: by 2002:a17:90b:4d09:b0:3a7:9413:cfa3 with SMTP id 98e67ed59e1d1-3a79413ddc3mr6299010a91.55.1791254279897;
        Mon, 05 Oct 2026 19:37:59 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cce6d2406b1sm1679514a12.8.2026.10.05.19.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 19:37:58 -0700 (PDT)
Message-ID: <c8930670-32b1-4f20-af0b-a13d17b45044@redhat.com>
Date: Tue, 6 Oct 2026 12:37:49 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 10/23] KVM: arm64: Consolidate stage2 unmap range into
 kvm_stage2_unmap_range
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com,
 sudeep.holla@arm.com, jonathan.cameron@oss.qualcomm.com
References: <20261005090754.2140522-1-suzuki.poulose@arm.com>
 <20261005090754.2140522-11-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20261005090754.2140522-11-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/26 7:07 PM, Suzuki K Poulose wrote:
> In preparation for adding VM specific backends for stage2 operations,
> nuke __unmap_stage2_range() and fold the logic into
> kvm_stage2_unmap_range(). Also, make kvm_unmap_gfn_range(), the only other
> user of the __unmap_stage2_range() call the kvm_stage2_unmap_range(). Also,
> while at it fix the comment to make it clear that mmu_lock must always be
> held while unmapping. The code already mandates that and the two call paths
> do have the write mmu_lock held.
> 
> Later we would replace the logic in kvm_stage2_unmap_range() with VM
> specific backends.
> 
> No functional changes intended.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Change since v21:
>   - Nuke __unmap_stage2_range and consolidate the stage2_unmap_range logic
>     into kvm_stage2_unmap_range(), in preparation for removing the KVM_PGT_FN()
>     for stage2_unmap
> ---
>   arch/arm64/kvm/mmu.c | 38 ++++++++++++++++----------------------
>   1 file changed, 16 insertions(+), 22 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

