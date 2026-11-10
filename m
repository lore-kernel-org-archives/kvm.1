Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318437;
	b=V5MWixG15UX5ofNPT9kgnuACnLDTztnMgBXakpamAudX62bJsA08FQzZNlyIqMKim2AC
	 ufVPe09w22JtYGo4GEMwEdxiD3xxa6cy5k7jhk5f+LyBJmsKIMc18zLlthyAiPwUOPX31
	 jHYCralf2VLZvpT6bPrzuGVst+9VoTSEQLea263tdttBjHe1Kwv3xbWDVwopZrrpo5ZSv
	 EKS2/aTPUu15IkzGcMvCjPdMMxxQ/qVPwELdM357q6HHQH/05uWv6x+KxvQm2ocoAE9YJ
	 HyIfsNW097l21IKNxYa553FWWap/7hdpYY5aR+qUEWFi8i85YbNL8gMcazYTTzBwd1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=GnZf5t7UPSoR7hVFC72+KtUOhGomuwzXct79OPnbGl4=;
	b=qWiztCE5PdhnnzXWShfESxURrRG2bSn6H2jkN3qwL8T+IPoWYjlFm4bXiAHhHiSohm+q
	 pw0F8sX1LWv6i8ycAa6uqm4dNSTclpslgg2T3fu1g/CqDHbMnjzw8qb1sIheTGKSk70OA
	 MDyuvKILBVvqOaWWJVkoPNWJ6qWp6oeVDL1eNg63WNhG8BOYGFrKVqIajqpEBpcYTwYHG
	 xaKCP20V4qbUE/sf5WeeLkOh15E/vosq6x8zMrMVh1z/nle4sdj231sQ1SEOFrO+odjSE
	 RDSd5QXwwmlgrV4RJa9AUOxn9ZWhmMYqNl+3AcCRSHlOuVteV28Ux7XYCFrDvmP1QQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TotfFPlc;
	arc=none smtp.remote-ip=74.125.227.201
Received: from mail-pi2-f9.google.com (mail-pi2-f9.google.com [74.125.227.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F2B60A380D
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 13:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15F2B60A380D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TotfFPlc
Received: by mail-pi2-f9.google.com with SMTP id 41be03b00d2f7-cdb91898fbfso1213164a12.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 05:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794318436; x=1794923236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GnZf5t7UPSoR7hVFC72+KtUOhGomuwzXct79OPnbGl4=;
        b=TotfFPlcTFZ5CfmV1PiPkYGsN1kKgdwuGVBKSnRwJl+8Vhq6S1B830id141rXih+Gy
         3baA3FF1vW4v476sJQhOlxjRMPDZbditQb583rvJF83L6sTW85CHb6JAOqQfi9+hkXTL
         yYAdfhwkWiibHb2UZKPjUiFKGQkWpT6pTaCmTfR8eHNEwoUxcGzeaqxg796ADZDTOvp1
         rAtQ1vAnmBu5lbHqZkbFt4cQhy2cOXkoAzFDdJSTxtOYY7iX14aklG/1vlBUVWlXDVfx
         k42Xlyn+Eu79ntwwEWeD3fzLik3vhZerZo56FJAkHWV73bORkS6qQoB3fJCZimx37uG1
         ujZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794318436; x=1794923236;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GnZf5t7UPSoR7hVFC72+KtUOhGomuwzXct79OPnbGl4=;
        b=tHmGGKoS/pOE+yNrQJltML044CgcanVnxa6/f0gN2Z0gdEosegEXyMcKyCH9gf9iCl
         /6iHWPL2gXfDnpOSf4lS4GzFXyVk9wD2QB5ARa1/p1NKJ4OUIuKI7m//RLffWAYVSa3R
         9JaHmpveZmnFZ4L4gtVJg1igc5n6Uae6tGBWpdsrgicJHeRNK8wrA7Pu67Gv7G3hzMmn
         uxILJhhw/H4dKAAl8pO2UqlXzkeg+AWCj8H+8XwH6c3Ye5vtxY+foXS9eMHfZNyS2b2v
         tTB/ZAFIMgjyKZ/nPNWXVmEJj/O6TK9KPQXEPBFOk1mYSzfzU1UASGgM1VertTKF/huB
         Sf8g==
X-Forwarded-Encrypted: i=1; AL+hErHoWyvQ4ArGjRqMuJ5L6XWtvFVEXrmqbwz7oR+AoqFP6Qd/G8BonGhCLEDAj2KFPzYRm4U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/b1mE/3V8PVP70K0xnhiXPRodHHR+7VzyFwPvGYdVMMIyFLJC6
	jrp473PAIF7DALB/FE9YPsuPqikW9facRR2pcR8rQtkdizpGE5tBo2i5
X-Gm-Gg: AYBFou1NxnXbws3/NupWbl3fUVNpo9/EOu1/If7hN2fMkof/Ine4LH95Isj6a6dIdpm
	IvjrqslvlEAQ0pz8ietHrpPDz2R670+gEhTmxUvsTt4VVlzyv6Nm0sfJrZvbPd8p3Llr6/uEml+
	Q50VzbrbGTwzPvwO7wHRGeQ/ovcgvpJ62Gj+HrczMg3IoP13qYKmKmvcn9o9Ao2sVlpwX553Ts2
	4zkLISU0cDDA2w7zcyYv5kLLwNMBQX5Ge8zLtma5lbmIBWMRgzAhJNQLcrLSqJ7hOp8y9cjzVWr
	ameycgPSS2MHOrH+PaZ9XebPe5eR3s3VhArfSKMLgz8M3aa1cyJgZp8wsF03yPAUQmzCkQuBiU2
	UIGk1zQ8Ta7ojKSfdHRignRvTxv9MquCsbMf3Eb+h0xW1lEdIpfgStDA57O0KhM4YOyEpdTB9OD
	JofodKmMK25dJcC0ke+PJ37S0oYq6X8rVFBJzqX5dr1fTLdObcuEmIQ1pGyTJsin7mPlU1iVtpb
	09m0MzQVvvFIKZ2zQ+IoiRC+sVHQOI3KZ1AtaOEpoFwQuEvjMxX12051hrhM3aaQvx4fLujgB7u
	/BCdrz2/iqMiks6nhxs9JJMN8KlvlSnZVbPdisSPz0kVyjY=
X-Received: by 2002:a05:6300:210f:b0:3de:48e4:c37d with SMTP id adf61e73a8af0-3f18f0b86e1mr2622791637.26.1794318435879;
        Tue, 10 Nov 2026 05:47:15 -0800 (PST)
Received: from [192.168.50.100] ([114.252.97.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaae3e110sm867486b3a.36.2026.11.10.05.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 05:47:15 -0800 (PST)
Message-ID: <42ce73bc-0fb5-46d9-bc45-34a5bef25cb2@gmail.com>
Date: Tue, 10 Nov 2026 21:47:05 +0800
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
Subject: Re: [RFC PATCH v2 9/9] iommu/riscv: Add riscv_iommu_attach_dev_nested
To: Jason Gunthorpe <jgg@ziepe.ca>, Gong Shuai <gong.shuai@sanechips.com.cn>
Cc: tanchi25@mails.ucas.ac.cn, alex@ghiti.fr, andrew.jones@oss.qualcomm.com,
 anup@brainfault.org, aou@eecs.berkeley.edu, atish.patra@linux.dev,
 fangyu.yu@linux.alibaba.com, iommu@lists.linux.dev, joro@8bytes.org,
 kevin.tian@intel.com, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 palmer@dabbelt.com, pbonzini@redhat.com, pjw@kernel.org,
 robin.murphy@arm.com, seanjc@google.com, tomasz.jeznach@linux.dev,
 will@kernel.org, wu.fei9@sanechips.com.cn, zhao.qingye@sanechips.com.cn
References: <20261105144944.10193-1-tanchi25@mails.ucas.ac.cn>
 <20261110115137.184160-1-gong.shuai@sanechips.com.cn>
 <20261110131658.GW663069@ziepe.ca>
From: Gong Shuai <gsh517025@gmail.com>
In-Reply-To: <20261110131658.GW663069@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jason,

On 11/10/2026 9:16 PM, Jason Gunthorpe wrote:
> On Tue, Nov 10, 2026 at 07:51:37PM +0800, Gong Shuai wrote:
> 
>>   2. Use the guest PSCID directly, but allocate a separate host GSCID for
>>      each vIOMMU.
> 
> This is the right model. The viommu should allocate the GSCID directly
> and keep it for the lifetime of the VM.

Thanks for the confirmation. The new version will use this scheme.

> 
>>   3. Share the GSCID and maintain a per-vIOMMU mapping from each guest
>>      PSCID to a host-allocated PSCID.
> 
> AMD is doing this because they don't have something like a GSCID.

Understood. This approach makes sense.

Thanks,
Shuai

> 
> Jason

