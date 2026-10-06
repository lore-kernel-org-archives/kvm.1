Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F662547076
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 00:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791244961; cv=none; b=HRr/CW8HwT7+CdzR4/iZhqhPG+nqKNVf/pfhHScbvBbi8zbyirR6cgSghu0BsyfdERwc7xIBwnEnC2fsSGMahr0w1GQVs3WAjhpd3aVwo+89TWYUJC1z7lL931aNUsyrvmG5jf7KgaUc9qoEpYG14QVhcjfb1OoGBdl0AydyliI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791244961; c=relaxed/simple;
	bh=bbI1GlrUdF/ahNCG52V/oWZizEAOPQOpaRP4fBVF3RY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYHxTQ4eg7MmzN4lx4WyFVB6xnVwkIzohnReFfVzb7gcx1QJAN7nziXPWQ6FuzfO70QB2t36EKmEVIjWp+eZhR2G3yihBg2E8L3bBRvdyktOkkVO++I9BNnFb5XIFoV1uyC6Hl/ROqZnfleuq9UuvRr6TcrV+6Z0iq5UjCUGwYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HZrDvHx7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JFvC5/d5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZrDvHx7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFvC5/d5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791244958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDFj6k/aDmm3juPYr/fQM/Yto+7HWelNY9uNTEiKbGU=;
	b=HZrDvHx7o2DVQPytjsKqQnQRzDRDzQwlHln09y7C24935MV83DYjNdPtZPjAofwcj+uZYd
	td3cHUyVVDeROmmR4BZJJAnZbD858plOR+RnRJw4X/PeCuHFIEfhRMKFNyQBWtNKSc+iTa
	T/JVm10KrUbjpxNGBwjWdRebUsPWjmg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-ZAEzcPZNNI6_EhLjISewTg-1; Mon, 05 Oct 2026 20:02:37 -0400
X-MC-Unique: ZAEzcPZNNI6_EhLjISewTg-1
X-Mimecast-MFC-AGG-ID: ZAEzcPZNNI6_EhLjISewTg_1791244956
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a4f7eb79f2so2235453a91.1
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 17:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791244956; x=1791849756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PDFj6k/aDmm3juPYr/fQM/Yto+7HWelNY9uNTEiKbGU=;
        b=JFvC5/d50uYgRP4OB2RLRgKHHclOaYtV5rXo5T1saZcmGkmOBYSwK/ZyR0XWfmQaZn
         ida31QpAIpm18qe/0LKRpfLt0jK4GNp6C8XcsTznVb7gl/daF/q/+qeIraPR1V8DkVuP
         o/KlcVNB6AjoshtLg0w+ff6Wq1hi1STtJSvH7E/AL9n5IIe5B2ZEWRd2m7Y/IV5+UpDW
         0gqOSbbvuX15TCgoC20Ud+2Lo9CztkbVAsXaFTIA+kyi5lh2YeNewYNZws45YzuJlfyR
         FCEEQHWCUXb3XzNOCJnImYI0tfmN4cKaDz51ikVDvXus/Y/jybY34KeTK1VWReAGjfv+
         ZXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791244956; x=1791849756;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PDFj6k/aDmm3juPYr/fQM/Yto+7HWelNY9uNTEiKbGU=;
        b=ydOzbl+fPBp/ZkVcUgdC8adIBd/n0F9+6HR46A3v+j91ucreq0V+l5lgCSX4rsx/D+
         jpl5YpBhg8F0d4X4Hy7mr74T820yL8niexVTXUZZuyfV1u1ABHTBOl6KOBBQ78R/RPWd
         z7tNdBng7BKJk5p7SL5s22QkwtKOdGvXgtbZTJJkPeEfMvNuCZSz/JrBlSQmaiXym27S
         TrzyY7ObXnViwWaCXM6ZHK/9PcarJu87bmmhBuVhSJhJhCUnN3r7EVdaECay6UhnN9ZV
         cUMLMlx+aTW5l3IGWQpide73rRuJBVUGaX/pfpXS+XL/25tEb0DET7aPL0jllYC61U28
         LH/g==
X-Forwarded-Encrypted: i=1; AKwUvBwWlbsxSbGV1Qqg9x0T72RhZkLZ70Fqa8v+V/UqmhmAjf9lHyA0y/4+rAB6O/OWcIusJ/E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJq0RJIWCRupF6SlD3gWPOS9/FgW/9rPTJ56Z5PWlIpKKOiT55N
	wf5aRJk99w7+FRAoJWHammO+V65OEeEz2JLutWTM/zazPMtyoT6IkYk6+koUSRFAmfWunHlSB8o
	t1qImSA/f/d1rSu6HsHP6w1vU9+gBqeOj9mhbwQPE8DBBIvNH1c5lXQ==
X-Gm-Gg: AYBFou2lfKdDupriegyWs27l+/1rFvUu8I3NHFBkm8Y/AXpF1luH7BL/7XZ5IxVXC2W
	dti2YoT/a6dD3uFpgRA/bhSy5/nLsKjqiM0erksweUXQ3We5YhhRDkMlCqc3zyp648jSBqlvqDY
	IOHTySatmXK3oaYFiEvgt6k4SbVcW9xuZhaN9m2DWhwodbQjvmCDdneykZXp60Gis2kPPersBu9
	kWl/jmLYg3S7FAfPEvt50i04qXKg+as1RSllQMyWVV10YI+Sa/mGlOau22YTeR/3Wq04WFZSd3V
	xwK1+c8w5rWdaB3rKNqDC4YuiZa8REkiqYtyeoD7tqVLcyFEjIvBSAGbN58VV2CTbvzVU5ike9Q
	0KiA8zBhI/q5Kq8HE+Pad7WL+5qJQibYX/n3b2PpNpA==
X-Received: by 2002:a17:90b:4c05:b0:3a4:ba6e:65c9 with SMTP id 98e67ed59e1d1-3a6ce963ad0mr5001510a91.59.1791244955771;
        Mon, 05 Oct 2026 17:02:35 -0700 (PDT)
X-Received: by 2002:a17:90b:4c05:b0:3a4:ba6e:65c9 with SMTP id 98e67ed59e1d1-3a6ce963ad0mr5001495a91.59.1791244955239;
        Mon, 05 Oct 2026 17:02:35 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a85436fb54sm1801682a91.10.2026.10.05.17.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 17:02:34 -0700 (PDT)
Message-ID: <0fa5d03c-9e6c-4d81-a0de-e7aafc34918f@redhat.com>
Date: Tue, 6 Oct 2026 10:02:25 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 01/23] KVM: arm64: protected VM: Handle user writes to
 CNTVCT_EL0/CNTPCT_EL0
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
 <20261005090754.2140522-2-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20261005090754.2140522-2-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/26 7:07 PM, Suzuki K Poulose wrote:
> Protected VMs doesn't allow setting offsets for virtual and physical
> counters, as the offset is always fixed to 0. The VM ioctl is filtered
> out based on the cap. However we don't prevent the userspace from trying
> to write to the CNTVCT/CNTPCT registers. This would lead to KVM triggering
> a WARN() in timer_set_offset() as the vm_offset pointer is set to NULL.
> 
> Fix this by always "fixing" the timer offsets to 0 and marking that the
> timer offset is set in the kvm->arch.flags at KVM init time for protected
> VMs. This prevents the access to the VM specific vm_offset at low cost.
> A userspace writing to the CNT*CT_EL0 would observe success, without
> any real effect. This is cleaner over spilling "*_is_protected()"
> checks and "matches" what we really do in practise. i.e., always run
> with "fixed counter offset of 0".
> 
> Reported by Sashiko
> 
> Link: https://lore.kernel.org/all/20260908164641.416911F00A3A@smtp.kernel.org
> Fixes: f7d05ee84a6a ("KVM: arm64: Prevent host from managing timer offsets for protected VMs")
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   Changes since v19:
>    - Fix typos in commit description and explain why we choose the approach.
>    - Improve comment in the code
>   Changes since v18:
>    - Retain NULL vm_offset for protected VMs to avoid host tampering with the
>      offset.
>    - Moved the flag setting into kvm_timer_init_vm(), where it should have been
>      in the first place
> ---
>   arch/arm64/kvm/arch_timer.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>

