Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B237081A
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 00:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783903315; cv=none; b=ZtsinXlLNugJ8WLLlfbeMuyals5YnH4yOiv7Oudz9fMXiVj7ngFMNWZn/yL+RhaOmJwtpV3JyUQ4+MBfWOg5gsEwKevry3exLdFCF3s/GWQcp22kfoXZGqZaSY3uXr8CzE7nSGebU4W79qhxcIzuBz5G/MfmzoV9SQKrDenwEpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783903315; c=relaxed/simple;
	bh=c333I0qsK5COfm+CZjvpTbNVfG/RAecfWzyldmFEXgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6DQWCdOnEDXUm8iYrZUb88Zu93nkxFAtqI99JApphETSoxFDpYJaldyMHEfLTouxwsg9I9LEFp6LgXRXZPSe0FKhvs1Vz6QLlNQ/0wg7koldX9HGVj0/I7vVFyH2jyHAfexDAjQJ+3LA8kXIiDrUjT2UeCVmRytfOdntpXich0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXXNu5Mz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ic//3naW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXXNu5Mz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ic//3naW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783903313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zALpRgeuYhXdSugXMHp9pMhVnEo4bMgEkE82Q4hNxJU=;
	b=WXXNu5MzaMbaXlMU1gbqBSQtQnbmRi3vCi5uphlnc7THx8gP+1gLUVjlmbUsSs08HNaAl0
	lbJk9F877UUunkcPaVh+tt862Ph1Mcp+G3/nq/9fFChHqKP9emyEcA3dVvupdJaGdMBvTJ
	3Nd7m3wCr1yHMzDeQqf5q1vVIMwAAtY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-N4HV7k1FPv2Gw4G7qAN37A-1; Sun, 12 Jul 2026 20:41:52 -0400
X-MC-Unique: N4HV7k1FPv2Gw4G7qAN37A-1
X-Mimecast-MFC-AGG-ID: N4HV7k1FPv2Gw4G7qAN37A_1783903311
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8484739a9cbso3489474b3a.0
        for <kvm@vger.kernel.org>; Sun, 12 Jul 2026 17:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783903311; x=1784508111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zALpRgeuYhXdSugXMHp9pMhVnEo4bMgEkE82Q4hNxJU=;
        b=ic//3naWO64p5VUpfh1fMeQYyMGjT3x8WobkshTold2TDvtbID3vSwb/FVegKgW1J2
         nWO+D6gwrZN96HVyAyRHrPUbSRrfQl4R2phu1enw9dPAn1mvq2xQl1VZcwGTWowZfJnV
         z7ZAq5OdI5rxEW/8yKl25njtG8Cj17wABGkhm+gZ0jv6bSoDF0lvIDbxrEKYgnKSYcZI
         599pvZ2eGt7a1FJN85VvLM4wrVuAQFvBqpX9xKOdh0qbYfj772nNqJxTIMZpdi7FmcnN
         l4JdI84mmipxaWgre6LCyF6ZJje6RHaw3y3paCXFljt6jgVwdaHegXLt/hWgABg1yYeZ
         Jx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783903311; x=1784508111;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zALpRgeuYhXdSugXMHp9pMhVnEo4bMgEkE82Q4hNxJU=;
        b=OpoUnlgsgwF/XHzOayqjQ03CnmXWk5UVq2rYFIwZFuetLH9DJFZ6afzk5yjsJHtkk9
         XNbwS2ma/OyP6ZQpLsZoF10hfBWdhyLvOF212LXZGLgssd2H/BmuqShhAzhQe8LsG6pd
         QBMX7aUq0adlq2wM+Oakg8jKezFmi7LYhCrHi5KNzhnhuOjWJvPulAeZCIpPqa5TJHzl
         lke1M/2LjLdkL6aOZm9Qrzh/586Lch2HY5i7C3Tbfc8lMfrowX2KRyv/WYKkoBAYncn6
         HUa59S5sVLsR5pldGlIgcbEPgm+0v+8WaCT/idEsLHIkxTvWZ2WpiF8LnTuZqadZkJ9E
         vluw==
X-Forwarded-Encrypted: i=1; AHgh+RoRa4ah3mwPM1umaDzaOjiiOnEMlE6sifl2Ay+NLYN3rm34rAl/hhF+atF1zSjCqWywIQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrKV3AIu7//r24DcxEwjztZAHT1RCtLm1lLQazb+pLmDToF2UC
	z2eThzbDAxx0nrZNP5nwaXA1QjOGHUcZKoe7YfnUlQoNgVWnXWw42UeC5cEEgNrG8RdhYuyo8M0
	to5v+1ZGROfo1Ug2V2KlvbNl3rW1o71XujkUmRjbsqdSgTKOwR+jQFA==
X-Gm-Gg: AfdE7ckcUhTrqrLNYS1IKlD7h6c2WCx8tUSmPxbCWQ6BDzbKSbOJCHIzt6G50V9CC6A
	dkEhbuo+OmsJYUHuASj//dapzA1BHpZmOCmdCoTm8fqkL8ep1dCj0CXGXHV3+eMdD6IgkI5rZSX
	a49aO8y/NwJOcqumE0IdO2eVvdTqpfWrWp/EgWtz11gT4BD3nClpTCNZEkzUdHPQlNe+uEMPKQT
	LWwL4uuKUK+VvLUVz0rfVL4SobSOCupifTNRuojgLoZZWA8CtA1bkOO05oipgntis5TZP3uqYeh
	5uErhJzQADq2p0yUGc7gZW4qNSBn5lJRptIZ/qpNALGRK2lhU/TMaDHyWL71h1WWSuNaFWYnRKu
	ZOslJouj24ZszBZSykWKyOIVg5QZFi4v7cl8/ZfONDgOMfPPn3KF79Q==
X-Received: by 2002:a05:6a00:a20f:b0:847:9aa8:d3c1 with SMTP id d2e1a72fcca58-8487078c197mr10333602b3a.34.1783903310892;
        Sun, 12 Jul 2026 17:41:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:a20f:b0:847:9aa8:d3c1 with SMTP id d2e1a72fcca58-8487078c197mr10333587b3a.34.1783903310424;
        Sun, 12 Jul 2026 17:41:50 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8483262a17dsm8553175b3a.4.2026.07.12.17.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 17:41:49 -0700 (PDT)
Message-ID: <8ecc5bdb-7686-4627-a2d5-94c50d7921b4@redhat.com>
Date: Mon, 13 Jul 2026 10:41:41 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 01/25] linux-headers: Add RME related definitions
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-2-mathieu.poirier@linaro.org>
 <03a39e32-3b15-49a3-a23a-782f8ba25466@redhat.com>
 <alDNbZ4ZI34nPGKo@lpieralisi>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <alDNbZ4ZI34nPGKo@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/26 8:46 PM, Lorenzo Pieralisi wrote:
> On Fri, Jul 10, 2026 at 11:09:43AM +1000, Gavin Shan wrote:
> 
> [...]
> 
>> After syncing the definitions with those in (v14) host series, I'm able to boot
>> a simple realm guest (no virtio devices) with one warning.
>>
>>    qemu-system-aarch64: Failed to enable KVM_CAP_ARM_NISV_TO_USER cap
> 
> That's because we need to use the VM instance specific check extension
> rather than the global one before trying to enable the cap.
> 
> It is harmless.
> 

Yes, the capability KVM_CAP_ARM_NISV_TO_USER has been hidden from realm guest
in the (v14) host series. With the following changes applied on the top, the
warning is avoided, I think the changes need to be integrated to [RFC v1 08/25]
target/arm/kvm: Use kvm_vm_check_extension() where necessary.

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 3d5e16a21c..4c52ee7e1b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -623,7 +623,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
          return -EINVAL;
      }
  
-    if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
+    if (kvm_vm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
          if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
              error_report("Failed to enable KVM_CAP_ARM_NISV_TO_USER cap");
          } else {

Besides, I think it's known issue that 'reboot' doesn't work.

   Welcome to Buildroot
   buildroot login: root
   root@guest:~# reboot
     :
   qemu-system-aarch64: cpus are not resettable, terminating

Thanks,
Gavin

> Lorenzo
> 

