Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EB1382363
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711984; cv=none; b=EwiD+TTd9mNWCvMpC9u3IxBNUUQlvlHQ9LUHwj4qjuhu3OFrhOasUeZhNRHR+TzxaZfZoaGe6j9rDFHwQiLuvex4GUjQsMR1XwTfkOjWp2sbmQ80asQqNdtWjztgD6OJdgXS8g6PT67Y1whpkmf/bOh5G1V8HBEoFTgS5BqOmnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711984; c=relaxed/simple;
	bh=XKd3/sBVdFq7scHu0YsvYg3lOUwCrl49yVJU6hxqojc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sHstHLGUFuhCOqTdWp78n4UCpJmZ8N3O91AhGeHMfEpY9uqlur79XP/wwrWMnAQMQhK+yz8F37CLwwB0W3LMTHJYT16iJ9vc06dY5XjMil1iHy5d8LmFAK6/vClABMtNhbBb4eygTv0qzSiO19hL6bbzHvRNSBf5UP8+a4AaPLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/lOEKCe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3Zb20dV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/lOEKCe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3Zb20dV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779711980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4hkd86DeSZBRxqkEKxXYxQ6Fg5bw2Xdd0Nw7s4mAqxY=;
	b=T/lOEKCeN8ZgBnQe8l+GICI16pqW+1ms7o1ohH2E2atpQ3Y1jZr+TlifjxqtH4vXoE2gdB
	dGBeXM9GX1638hjS/GKkuv2rOCbzFu+enuHLTa+u1FNqvK61BrTH9q+yXj4uC8ZTg6x4b1
	J8M0k6DfGDfssfLhZ8N1wotIbk7Wazc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-87J-NTdVMdur7M3QEpYI5A-1; Mon, 25 May 2026 08:26:19 -0400
X-MC-Unique: 87J-NTdVMdur7M3QEpYI5A-1
X-Mimecast-MFC-AGG-ID: 87J-NTdVMdur7M3QEpYI5A_1779711978
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fe6894f3fso53460875e9.2
        for <kvm@vger.kernel.org>; Mon, 25 May 2026 05:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779711978; x=1780316778; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4hkd86DeSZBRxqkEKxXYxQ6Fg5bw2Xdd0Nw7s4mAqxY=;
        b=V3Zb20dVjHJQvBWw+ViTWlfBtxLVs3bMm4kfJIfFn9XNdNGTATFAh39d8A80NXn5dR
         DNETLpj7ygVeu/wGcu62/rrEP2ui9LQ+LsqnF5i/2944Q6Uv5P9K0uj9zmFoVH9NL90m
         9HORkLlFhjgtI0xk3DyMrCrxqNHZYICj2IRS7x8KJfwoN56uvy+9x65WRF79LTZ3fMfe
         PSztA/nd1BfF/nUP/0q2qxe2RAelscpyo3R6CgzbLtW9qKTjv2qDx4Aloi5Y/Ne13TNZ
         pKIuZ//AOi9NXdPFygtRPnKahv5G0WfD3MWymHcXKDNzLLqD+8PVWZ3+bVw32++BPcYJ
         6HwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779711978; x=1780316778;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hkd86DeSZBRxqkEKxXYxQ6Fg5bw2Xdd0Nw7s4mAqxY=;
        b=MwUogokbU8ZsmEy8+pFt2U285AGZjEOJEZcOMZ5RgzQkzhOp177LpNpI5Fsic9pLSY
         h6OaQNtTWc5sqeyOuXWQND3kuB5TF5aA2c+0I2/ghIDUBAyUGadyFjCpy7n/eC9rNT+q
         rfWDkwvJ7m6U21iLXj8x3J0WE9g7hAt4U9YWt+jHI4ZFu1d6qw2Q8bYoT5jzmzFlull5
         mLvkGMEOoc172n7IJujDO8mqGH13l7haWBZ7vvOtUEi60VWEcYaa5MvruyJ1XGPa3LlS
         i26Duug04BE+HAIfCHHVuV/x1Pbe/zTK7c2mAJY8pUSXFEp1kIc7ZsBUoJ5KHmx356Lq
         Rsww==
X-Forwarded-Encrypted: i=1; AFNElJ+xjIMIHqoEtgOwDewlYxPXGXU6ZXZhI1N85mQ97ZD4kgaXBBPLBG0IngLm/OHG63h07kI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVZ/JCPg+lnJc6rrRUG/hS/XLEiwvmdYP5wSxMBSYskIBDExDG
	uu80SbRflya12GuRF5vuVfjm08DJZRGEJOawUFBK2t8zqjmcTfT9F8CVhZcCx3VAlhRuMmvsjW9
	dip+9Cl5+qSYnwRbNIvJyhAnSgrTigpb3jnbnjqv2BxSvi19GxS4mqw==
X-Gm-Gg: Acq92OEgK7uwRFeni/mxWs02epKnx7Yb33V63yb4Ts6f/i3qmrSs/Mah8ULkr1lSUPB
	S3OAM4NLHz1kYPcjX6bOYTffzkbk741MY6PfhnpoIT4sAx4x2A9nTHHZAZYO8wsaov0W2CAAx2b
	cizzOiZQ/Spp/O0ESn9Yf1pX6SgFS1MQP0FMtkEDIhmvxw4ztKrweHTeT7jrVRobhhY7TzQQ8Qn
	k+64RUD+tMQXKnV3pxtZKNLsnuSLjix/uVDoa4ivnGrm3HYyL8k6pxrB9F8MOjIH+TJIlUNTiMu
	HdGdREN7hvtKgOV5GqajZxI7dXv/Bbg0brbnlDuhige0Er4MX9WuFhfyxUwQqJMGHm4BZiQor42
	fT0ocHCko4y/QHrpkWJcx1Wc=
X-Received: by 2002:a05:600c:34c5:b0:490:601f:d775 with SMTP id 5b1f17b1804b1-490601fd89emr86929525e9.5.1779711977882;
        Mon, 25 May 2026 05:26:17 -0700 (PDT)
X-Received: by 2002:a05:600c:34c5:b0:490:601f:d775 with SMTP id 5b1f17b1804b1-490601fd89emr86929055e9.5.1779711977417;
        Mon, 25 May 2026 05:26:17 -0700 (PDT)
Received: from fedora (nat-20.ign.cz. [91.219.240.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49045282201sm272209365e9.8.2026.05.25.05.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:26:16 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Piotr Zarycki <piotr.zarycki@gmail.com>, seanjc@google.com,
 pbonzini@redhat.com
Cc: shuah@kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: hyperv_features: test write of 1 to
 HV_X64_MSR_RESET
In-Reply-To: <ahGPQDJCT1aW7vVY@arch-piotr>
References: <20260523111857.195396-1-piotr.zarycki@gmail.com>
 <ahGPQDJCT1aW7vVY@arch-piotr>
Date: Mon, 25 May 2026 14:26:15 +0200
Message-ID: <875x4bllp4.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Piotr Zarycki <piotr.zarycki@gmail.com> writes:

> Hi,
>
> After receiving KVM_SYSTEM_EVENT_RESET the test simply advances to the
> next stage without resetting the vCPU. Is verifying
> KVM_SYSTEM_EVENT_RESET is delivered sufficient?
>

For every stage of this test we're basically using a new VM
(vm_create_with_one_vcpu()) thus it does not really matter much what we
do after receiving KVM_SYSTEM_EVENT_RESET.

The basic idea behind the test was to verify that
KVM_CAP_HYPERV_ENFORCE_CPUID works as expected, i.e. the guest gets
access to the MSRs/hypercalls according to the guest visible CPUIDs and
not to everything KVM knows about (I guess we could've named it
'hyperv_feature_access' to actually reflect that). It, however, makes
sense to actually test side-effects of writing to MSRs/using hypercalls,
especially when it's relatively easy and I see that the change here goes
in this direction. With this, I think it is a good and sufficient
change, so

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Thanks!

-- 
Vitaly

