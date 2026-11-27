Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769795;
	b=R2aJcaRr1lUJScq4RJu2+6oSACKHdvRg888IKIShQ3edUxr5uHP8NVe5inMRh/CzSsYS
	 XDxFm7YHW9aBdml+Wox3oT2cSrNkwlaWtwIjhCiNgnGfLtTCyOpN1lzeeSEXW2GQKA3sV
	 MEy3cGdyT9OwXKIkYtxivZ77pMLkTtn4lPTWlZpRRE60bn35RZeO7yC07nuTQP/S8kVIO
	 Msejy6Ki7qzp+RzEUBLkPJ0NNcWUGNqOxIsKhNofGXrTy1Qgx17Im9Am1+Df4+TUrpx14
	 061X/YMQJFqDMYMfqLWHNKn4UB5cn7NOWcc7vc5ub2TYDvA8RvnoBZoqkJ+dKdDJzzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769795;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=BuV+QA+s84l8Poq1BBJXJ4FOVTjIgdvHVM0F0eT+wqg=;
	b=IViXjrDisZtBOvbL6MJrm8bBAL1g8aNCvxQZvlqp3d6gseNrC5q9cphiC44Xl+I2A6l3
	 z9bJkJ+EXe4hGwJOQrfnUM7PVmRVRbAqZD/920yX4fyZSPnenyV0aU261SIBBE1A8Sqtm
	 2Lu+OssMSm+3B81+mnYgAdo7QirolLYW5u+/Gkhj4K1g3WOqWgqmJUwWlpxvxUmVAadkW
	 7x1WOYFjWVZhYw3ghuWHtKP6mK4e91WSVhQXF3PFxWBhXUcSB9woPuLgONmI1nNcdue8x
	 yahxcVv7Ztw16uVFbm6PdpXf6ylSFvNq3tPrMsFvzqhlHV3m+OGuNWKEf3sSyqIZ8iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NsYd2OPp;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=buog2fsO;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88A4606A329
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 08:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E88A4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NsYd2OPp;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=buog2fsO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795769793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuV+QA+s84l8Poq1BBJXJ4FOVTjIgdvHVM0F0eT+wqg=;
	b=NsYd2OPpw/KEmAlI5TrF5kIJb1bhAWc9WVQdYwhH3n9KarSqpJy6WFVxLek2o1vrrpAcL8
	lleWAzGpkErklsIRypzC4N+m+w8007Q/dSZCOj53pfOfEGhc+7bEqOK0PgyDEdLxXkLNco
	j4h/54j/WvWeQFPIYefmFVIBi/eUYHc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-ez1qWovzNkaFuYZ4VHsZaA-1; Fri, 27 Nov 2026 08:56:31 +0000
X-MC-Unique: ez1qWovzNkaFuYZ4VHsZaA-1
X-Mimecast-MFC-AGG-ID: ez1qWovzNkaFuYZ4VHsZaA_1795769791
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1fdde384cso56061015e9.3
        for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 00:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795769790; x=1796374590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BuV+QA+s84l8Poq1BBJXJ4FOVTjIgdvHVM0F0eT+wqg=;
        b=buog2fsO99kWbBWmJtX3UnMOGKUKjsGuHk4VtGB5JU8EC71vtWFlzDSNVaz4nmdP97
         CvI5fUA6vm4Mq/KI6H8pEOuIxHYs351BpF+Mp/g/cPlLoULOgHYUaZp11nIcQrxNTwyP
         M8YYPY5bcNV/ZtsmoL+hoZmaHlhxyO8n++2zVMY5zzLjURIl/+pnuFVeIdI1g1noCoa7
         qtbW+rtnslCMh48nZeUsg41iWcI+OoDi4zQb/mUf987N7QjsrbaDqmp8QCHnoqA53hP6
         rcphH9TKNrATEhsbKC15yazbwfMCqcC6GEQ5RZIJuVlNXaEEgV+8D2Y5wyG2aY75tFz/
         IQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769790; x=1796374590;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BuV+QA+s84l8Poq1BBJXJ4FOVTjIgdvHVM0F0eT+wqg=;
        b=Lj7qGaqjcpJv0Hj/a3r1Nxk8oCzTphp3WlyPsij1L3faADqp1lOrVgrVsOnv4w0Bw5
         wn35oz6oCDGxmwF8m5fwcXyjQTqZEFPA78A8Ksv4h/m1as1uGwMZv+Il8YiCaQsLQrY/
         kprIHvXgBIcMbl539HX4+5JXYn15URUcPptai02BEIkeGEvB4/HhbrzyEHusp/7qOFY7
         M3i6/+LAFn168eqT3kUOv/UIR73f2+BHWMbGCFJ1zy6uAcRlwpHoiuE4q1CpIH8lsO9t
         foMWVFs8ViJ7L7OgtMEObHl1v4I7R/zLe+yYGblSWnzv/+/cNqNCl6OMhXZH2W5UiSy1
         BOVQ==
X-Forwarded-Encrypted: i=1; AL+hErHCwL7+s4kEUKjEr0qan4BsQXHlChwv68CNUZSLUjVAO2P1SqfIwn8/QNL8iCYeP9tS6+E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/jjAIidd3JLmg1cPxLhCmma/mLrXNoYJn6hdlb2gGbsmC2R3NE
	KFyUEN0WABhsJyIFZS3gIKtSiNSr1dJiZlVyVym9OW1iHc/nHw3j0OTAMftzdrpe/kq47+WnNs1
	slhbyOVbrMezqQoPVoo9Jvf8KKyelsyDYbZfgKF6V5pa39oh8wHvDUA==
X-Gm-Gg: AZFdTZcVdoUdkigXQd8D8Qlo5iktwMlyDv8shotoNk6WfBUJe+Ri2TfOXPjLxj1gauv
	HiWKXMRzJzE+k7fxyownVWigZtltF3bDdi1pvE1FH6R1cJRRN9+u+WrRPQ2QL6BKaLpzDFNu5ia
	XC3zfiG/14GVlf+xfKprl+NZOllPLtqQ4veTQPqOOn0H4y1slxSK4sM6kSkD2qIAk6vQMTHtoSO
	1PWfOF4RRP3o/Hprvh8uFBv+miyJbxiDZl+3gVXqwzQqwtwJeeal/7V/m6Mm37FdExI62NqWGRD
	gjKFeh+kyfpTjvwY6ZmqcmACI8sDFR9OC0dhhcrkP0Gh30/YM4BxlQ+4JYHZ/u3e0T7/UWPp5e7
	i51sTmCiCHAmmxYbRn9wg7WXq4N6SOqKs5y4Vf9Xj8oP+IbPzN6vQpuXgIh9ekKyTqFkWouAnvA
	WQMBRSYcsJR7nXAPjK
X-Received: by 2002:a05:600c:530f:b0:4a2:677:ad8e with SMTP id 5b1f17b1804b1-4bb8892a21amr442437595e9.34.1795769790701;
        Fri, 27 Nov 2026 00:56:30 -0800 (PST)
X-Received: by 2002:a05:600c:530f:b0:4a2:677:ad8e with SMTP id 5b1f17b1804b1-4bb8892a21amr442437225e9.34.1795769790357;
        Fri, 27 Nov 2026 00:56:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:af16:8320:54ea:4bc9? ([2a01:e0a:f0e:9070:af16:8320:54ea:4bc9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8526cbd0sm894279635e9.0.2026.11.27.00.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 00:56:29 -0800 (PST)
Message-ID: <bb8b3f0b-0948-4509-be89-d896ec94d7e8@redhat.com>
Date: Fri, 27 Nov 2026 09:56:28 +0100
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
Subject: Re: [RFC PATCH v2 0/3] arm/kvm: select an nVHE-only EL2 with
 SYSREG_ID_AA64MMFR1_EL1_VH
To: Haseeb Ashraf <haseebashraf091@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Haseeb Ashraf <haseeb.ashraf@siemens.com>, Eric Auger
 <eric.auger@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 Khushit Shah <khushit.shah@nutanix.com>
References: <63fcaf35-5d3f-42fb-868f-9fcd644bf494@redhat.com>
 <20261125175005.805533-1-haseebashraf091@gmail.com>
Content-Language: en-US
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20261125175005.805533-1-haseebashraf091@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Haseeb,

On 11/25/26 6:50 PM, Haseeb Ashraf wrote:
> Hi Eric,
> 
> Thanks for the feedback.
> 
> I agree that exposing VH as an exception is appropriate for now. KVM
> does not expose VH through its writable ID-register interface; it is
> selected by KVM_ARM_VCPU_HAS_EL2_E2H0 during vCPU initialization.
> Keeping this explicit avoids prematurely adding a generic framework
> mechanism for which no other field currently has a requirement.
> 
> On the second point, my wording was imprecise. KVM updates the
> guest-visible ID registers automatically after vCPU initialization, and
> the guest sees the derived ID_AA64MMFR4_EL1 value. I referred only to
> QEMU's cached isar.idregs[] copy, where the framework currently deposits
> the explicitly requested VH field but does not re-read fields derived
> by KVM.

Effectively get_host_cpu_idregs() is called on the "max" scratch vcpu, ie. the scratch vcpu initialized with all possible features. Then we update isar.idregs[] only for fields which are explicitly set using SYSREG props. 

Thanks

Eric

> 
> Thanks,
> Haseeb

