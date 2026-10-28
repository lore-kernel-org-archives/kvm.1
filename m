Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212971;
	b=Mj/QE91D81DR3HRVFpuFrq9fOEKOseodi2zV7VBZpCPOEcIWdswZ6YETE287z4x1Luno
	 WWFVvIbAVYy5GamCNfk+s83OaHTuTQ9XOofcBWOrPRm6bzduOgb+KRMrSKdo0va1xTQP0
	 k9uaGyQrmGIQDTzUOIDGRA/vzeNTVxrRGwUgXi1MsrI+hVpWSVvHwLVjo3RVQICXG4CRD
	 NdaSZJs4Sl14+S6VTTbQBxojEiX+rXZ8bbE8j9IsliTItwQNfRpAfztcKMSBGSDJneB1+
	 GvYHIvA4wnQLv4taL3NULfoB7fy9WWxaXc1Pf5bVBtHXr85j/04BhiRaZLFbQPfZ6Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212971;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=wg09h7YeRsOWiLdkimp5LVZvXgJxFBSM6j+wYU4LV4k=;
	b=AwwT0vP/W4kBiWLKwwzR45tm9bzvCrbco1l3HDJRM4YNdIIVL2ILF9hRg3M8AxW4TZEP
	 YdIxTcf8H7LhaXyaNXxgFwkyG1XwflFW7KjJF/1/BT9JgJOxY5WyYVyI8ha06+ITRejwY
	 nLhntk22kFiaks6LeJKJyxl9Gn2LzAnJVyqYP5dOsq4Tv8u6eQufR/qino9yfyytoDB9H
	 OxB06I9+NP4dxcZepL3pboM7YaR91v2tYohFFQ5jjuGUGNZjdKb1ZhSJbpvbHzPvbAM5I
	 kuXdnmCdRElHf/rEKxZgoito+0E2D3fjuLNTL/rYBiN/7RJ+p3aiB0VZSgBV2urVUXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZsSLLocf;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D744E606A321
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 18:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D744E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZsSLLocf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793212970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wg09h7YeRsOWiLdkimp5LVZvXgJxFBSM6j+wYU4LV4k=;
	b=ZsSLLocf3NynyHD0JCGyLQEFZSf6JcJEmeL30ozHdUvlOXldtyExNexeS9R7Iw8VWmxzKh
	4o8PZR14z0cCwtWv6LdUZ/vz61OVxc1Ck19Lr3JC3Mc6rgQA3sWT11L/yoyk3S3z8izSQk
	tCC1EogJy8528TjgpN9+zaVrJeKg0Zo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-laPxXzwLOau8GiqzRlyexQ-1; Wed,
 28 Oct 2026 14:42:44 -0400
X-MC-Unique: laPxXzwLOau8GiqzRlyexQ-1
X-Mimecast-MFC-AGG-ID: laPxXzwLOau8GiqzRlyexQ_1793212963
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 035AE1800990;
	Wed, 28 Oct 2026 18:42:43 +0000 (UTC)
Received: from [100.90.222.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B25118004D2;
	Wed, 28 Oct 2026 18:42:40 +0000 (UTC)
Message-ID: <6f6694db-b1aa-4d9e-be82-b0d11cd814d9@redhat.com>
Date: Wed, 28 Oct 2026 19:42:38 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] KVM: x86: OVMF boot hang with SMM enabled after
 commit b3e6212dea2e ("KVM: x86: Use active memslots for the per-vCPU MMIO
 cache")
To: Sean Christopherson <seanjc@google.com>
Cc: Sami Farin <lkml20261027@mifar.in>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@kernel.org>, kvm@vger.kernel.org,
 kimjw04271234@gmail.com, stable@vger.kernel.org
References: <2026102314-CVE-2026-99082-e5b1@gregkh>
 <20261027124140.upuow4a3kv6kssvn@m.mifar.in> <auIy4UZMGxLhBCAn@google.com>
 <d4214249-5ec0-4600-91be-13632b180425@redhat.com>
 <69437bf0-45fc-4701-9144-a208c12423e6@redhat.com>
 <auI4kViOXpqxT3wA@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <auI4kViOXpqxT3wA@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 10/28/26 19:01, Sean Christopherson wrote:
> 2. 'trace-cmd stream -e kvm:kvm_exit' shows a storm of 32-bit IN reads on port 0x608
>    (the ICH9 ACPI PM timer):
>       kvm_exit: reason IO_INSTRUCTION rip 0x7b125f0c info 608000b 0 

This is already too late - the problem happened earlier.

>>> vcpu_cache_mmio_info() does not use the address space id:
>>>
>>>           u64 gen = kvm_memslots(vcpu->kvm)->generation;
>>>
>>> Will send a patch soon.
>> Nevermind, wrong tree - I was reinventing the (apparently buggy) commit
>> because it's past 7.3.0-rc7... still looking.
> Heh, I did the same thing.  I was like, "this code doesn't exist!!!", then
> realized the commit isn't in kvm/next.

I'll try to reproduce tomorrow.  Sami, can you check

1) if this patch gives the WARN (with vanilla 6.18.58):

diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index cfe96962a4e4..a96d839a317b 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -263,6 +263,7 @@ static inline void vcpu_cache_mmio_info(struct 
kvm_vcpu *vcpu,
  	vcpu->arch.mmio_access = access;
  	vcpu->arch.mmio_gfn = gfn;
  	vcpu->arch.mmio_gen = gen;
+	WARN_ON_ONCE((gen & 1) != kvm_arch_vcpu_memslots_id(vcpu));
  }

  static inline bool vcpu_match_mmio_gen(struct kvm_vcpu *vcpu)

2) if patch 1 or patch 2 separately are enough to fix the issue;

If you have time, can you also check if it fails to boot even before 
reaching Windows (you can try any Linux ISO, or even with no disk at 
all)?  Also, just to cover all bases is your machine Intel or AMD?

Thanks,

Paolo

