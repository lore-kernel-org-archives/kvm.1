Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01F337E2FC
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780238198; cv=none; b=mlTmH0W5iUR5sePEut0nSinyceF6hL8LclYbJBcZ1JfhZRT0/RvfVCCsmkxE4HBP9Z73vcCpsLQ1XjZ9Lo1wDGh4veARMuTR3XQXbuEQATCDQbkYdvtIjYzZ1V3qw0oaPST2HxgeBFqkn8SehIdJ/ZdyOerZU7dKVKYL4se24iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780238198; c=relaxed/simple;
	bh=VBfST3UXgyTlkP0EH/KCc/5GWH1k8BUjMNuhwJhVe3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHcL3DYYSD3JISleBxqWEfmwrhwguCMp/itpy04GnIQ9lILp0k/i7VK5vq5QCC/gRyatSMdytQ3iObrCTOYMK1VLkVAaGTzjoS1PKOIksOhi7c/LCAUWuj8E+4iEaYlEvJhfVQpmSNnhyEH+UpNRxv9t/Hz5bBu50l8z76VetF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFVBnxH5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFVBnxH5"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c3543590so3196985ad.2
        for <kvm@vger.kernel.org>; Sun, 31 May 2026 07:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780238196; x=1780842996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAmB6qU0tUcDyuQM8cPLpHCE5VdrhYXfLUEjav8vq/s=;
        b=fFVBnxH5kHPqoiPmu7l5fAUMMDsW8LZZWZ3AKlNtwKraIbQwlOXpguDIn5j9iNGq4J
         5RMyuPKsC/3lr6k976+ejmnviukM8S8FKLRh64CfDRdJf/baOgQiq3KG0Lr2Zp+a+yh5
         uYfFUM1DforP5ujnGIUnT0YAFOzj1k8NTxDJM0p6yjnHTQr22/SH2060SOO9iON9C7Sm
         N+KBa5C7WxXEjLTE3XuSzsQwFaC0jshNGgZlHcPr35S+QO/R2u5PTh0Od9fh+2qYr6q7
         NK/8vrxFvMk3k+nygKcUxprPviAsFQCGkRU414OnACp5y6S4084Va6reitM7ZDUufQml
         /qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780238196; x=1780842996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RAmB6qU0tUcDyuQM8cPLpHCE5VdrhYXfLUEjav8vq/s=;
        b=hahDhZs2uC11Fn12NuTE/TQeRaXkRo+Y+L+jJTT80x8gzfeuRIQQAdWLmA3uG8nEDz
         twUeBDbBdhJT3EAYv8NCz6/DoLJB/QiVd/TJqjN2okbOvFc2VDyh6gPNKYaAQLuInj+k
         FbSSy+3EVR2jTjo/eyXQ3OA3R7xAtaroZTBM5MKVxer0u6e7i7pfCAd5YdSO7F5BQ9nF
         pa/VpW/ar4xGjwMWh1oex0+Z/RHfPMeV5kih1iAxoyDN/st9OSFNoIHCFOFKbjZZP/oS
         WejAQdgMteiiWl7tgsUQ2YZ5Oj7ZeNZjvmhcFUnR1fIxtk4/SHJNcqSZkks4ek/+0CIw
         ihLg==
X-Forwarded-Encrypted: i=1; AFNElJ/+QAdUytW1bjl1i9r+RFlAQJG5wCdqpCChBLJFKIK40ljKZRURSzGiJpxItK5HTJfL0vo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+V9Z4C7VcleWiIN6iJE9cNHs+3BdhCMIT89wj/MSaIWUZuy90
	LXsPcaivKpymQYwXlFkF1scOyif7WrpQNdO+6FKYOJEpDlxKdIG8dbIL
X-Gm-Gg: Acq92OGXIEwy6iG0DEV9P4gNaQPVo5H0jqcAMJ+3w6RyTRqeb0HFCW3Bz+eUjDemjDe
	VEUMDPbkLTE6p9M2wxYjh5IgKhRgSDs09KG2T1Zktd5E0k1nYOz0arL0IH4qcyq/Tj/bIHJQJ9R
	hemiAbyToCH50O3+KvBscFsf2FiHHhSqsqAVkWLfBk/99RT5toi4og6v/5QFNVJrYMv8YxmkFLx
	BsAGcR1Jo0dE0WTy6HnG051WocmLahvOitLb/PfGClLTeVQXZSMypOpH9tIpGn8iYvDQHRvwAOm
	W3ko+iK2kYqhA7S2INvTVbdKKl0dgOk1EUBqmEycHSSY4cIR0Ls9aUqF4nf/aTh5FphqNmbtqkF
	G90PygMjG+mOVvCLXc8lIaEnV2DspIGGe3aGD2Nv46QPgKki7cslphc1fQ+7ti3J6drBqmA97ba
	Ie510DIjkN5VN9RILwYjNHi1fot+BTMBHeZn0NlGaTRLoYTfs=
X-Received: by 2002:a17:903:3585:b0:2bf:160f:7038 with SMTP id d9443c01a7336-2bf367c1435mr92914815ad.12.1780238196196;
        Sun, 31 May 2026 07:36:36 -0700 (PDT)
Received: from [10.4.72.5] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b0121fsm77749365ad.49.2026.05.31.07.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 07:36:35 -0700 (PDT)
Message-ID: <5ee310d9-d432-400d-8506-751ee4a41fc6@gmail.com>
Date: Sun, 31 May 2026 22:36:27 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 0/2] KVM: Validate irqchip index in routing entries
To: Greg KH <gregkh@linuxfoundation.org>, Yanfei Xu <yanfei.xu@bytedance.com>
Cc: harshpb@linux.ibm.com, zhaotianrui@loongson.cn, maobibo@loongson.cn,
 chenhuacai@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com,
 sashiko-reviews@lists.linux.dev, seanjc@google.com, pbonzini@redhat.com,
 kvm@vger.kernel.org, stable@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, caixiangfeng@bytedance.com,
 fangying.tommy@bytedance.com
References: <20260531135326.2238555-1-yanfei.xu@bytedance.com>
 <2026053158-cussed-outweigh-6f0f@gregkh>
From: Yanfei Xu <isyanfei.xu@gmail.com>
In-Reply-To: <2026053158-cussed-outweigh-6f0f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2026/5/31 22:15, Greg KH wrote:
>> -- 
>> 2.20.1
>>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> </formletter>

Thanks for pointing out the correct process. I saw
that PPC maintainer added "Cc: stable@vger.kernel.org"
on v1, so I mistakenly thought v2 should cc...

Thanks,
Yanfei

