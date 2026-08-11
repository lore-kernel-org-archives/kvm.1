Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F45A2F8EA3
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454828; cv=none; b=M4G3saf7FAYYdNeY9eydLkUXi0hhgVFxeqG/IttKT2YCLl9zciLNQBp9lymR+MGGUObROIb4Q1jUSrFHTvV4Ur3k/3p+VF09zUSFPq5M1wVQLqhrb9aXR2tyJXnJjoqUbE3weNlmZ5TcFQoCX0KZefnf7II2XrVmzgp1FYOwAOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454828; c=relaxed/simple;
	bh=HSS2ol7a0YjbjSr7IwadkoiUtq++DDqP02Tw9wqOwC4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l+r+4tzWsoenxUCK824SlYTNiiDMmXrlM4QqyTFLaoP5DFzYEV47fz8UreUHrvz1JflYAQz631aZiCMm7GiM4ZmcoGt9nCE+ftZomNogyRqLeCcpllMy5tIilF9S+XjjKV5yJA9yih2mGrMDN4ansPNM/07IY3WDYJr1LUoREBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aWSvuH3+; arc=none smtp.client-ip=209.85.208.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aWSvuH3+"
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6a17c83732fso2946998a12.2
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 06:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786454825; x=1787059625; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VHer5Euf93guPyEW5SSggQ6xE9fM7y8lLNbmZzisUY0=;
        b=aWSvuH3+7mA+n7ro+qrHnNOk0u2ma4PyI/dkh2Pitat2kGzwFMYEkuZyT0YuEGQcO5
         oHi2q0Fng5EDiMiyvb+6mLLvSyiQJqT9mXITiT3IkcYPOkPHfz2ZSCUQd1zq6OnTxqg6
         rA125X5oBFfdV9abSbExVWJABnVRLlT5PT/5ppvv4oqUL0snnmJAzFjeba5lpfCk3/nf
         0zv34+XAZvQj1RaQredVziC9xZd7Wc7PklI8/lZY7MQOftLsw5O8YELLVVTbWAN0VHMJ
         KgCqzHmqCbrCapRCtN/oup8SRCqw4j7QUMMHvK2xdaKMnt0et+r9FaQ7AVYwdDT970+M
         bsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786454825; x=1787059625;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VHer5Euf93guPyEW5SSggQ6xE9fM7y8lLNbmZzisUY0=;
        b=SEdsxejr0peyRcRCcUiIMgtmyJcx/Ia7Oa0VPxOO+SMZW5hqAPDY2d25CuZmbp58GI
         MJHy5ytiK2AZdloB9DrYKeMSbqhqPj8NEckCNHn+en2v7BfMgM8FPaAMDNTZ8fyld6Td
         qhSSRzDDnzYXHRRoQCaUlKWayesNEjDoXevY7QfRwX0JX/5gwp0hue1ozFb4mv4JQnyU
         D3zQD6iETkoip/bqz+8GRCXCIIV3Vgn9BIRTza3zLD5hCqGK6rdrOT5HXgkbHBiD1vXW
         kNBCzW/tVU8e0NnioWKOzwW2OnO8KY8B7njTyrlEzVeDKhL6zZQKXJqahMKZHJQfpkIH
         voqw==
X-Forwarded-Encrypted: i=1; AHgh+RpIDM7s9zCjwB5sjJ90Fpz+LMrYH4jXRDGUShlRNpNefQRA6LbmRVG/ryD5GvzR/dzqdNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVMfWHChFWmnBlotrUI30pKPnVNvWlNLLTOXZXWp+0f+xJUa7P
	2tijSWqBN/RwtuqLtnn9tgkWVs6UR0lqA9+owtbMlV7oqUZPtnAYwgDAUtoT+ekPlts6c6vTL6R
	EFVPjD7X88Xlfdoj/HQ==
X-Received: from edsu13.prod.google.com ([2002:aa7:d98d:0:b0:69c:835e:2527])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:210f:b0:6a1:b23d:e962 with SMTP id 4fb4d7f45d1cf-6a36c32a68emr218706a12.8.1786454825019;
 Tue, 11 Aug 2026 06:27:05 -0700 (PDT)
Date: Tue, 11 Aug 2026 13:27:04 +0000
In-Reply-To: <anpZMemVz5yC_WLo@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-3-tarunsahu@google.com> <anpZMemVz5yC_WLo@google.com>
Message-ID: <9huzo6f8zt1z.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 02/11] KVM: Introduce kvm_create_vm_file() helper
From: tarunsahu@google.com
To: Sean Christopherson <seanjc@google.com>
Cc: ackerleytng@google.com, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	linux-kselftest@vger.kernel.org, andre.przywara@arm.com, michael.roth@amd.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, will@kernel.org, 
	vannapurve@google.com, maz@kernel.org, fvdl@google.com, kvm@vger.kernel.org, 
	oliver.upton@linux.dev, kvmarm@lists.linux.dev, alexandru.elisei@arm.com, 
	skhawaja@google.com, aneesh.kumar@kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, kexec@lists.infradead.org, 
	suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Jul 28, 2026, Tarun Sahu wrote:
>> - Move ITOA_MAX_LEN to kvm_mm.h for reuse by upcoming kvm_luo code.
>> - Introduce kvm_create_vm_file() to wrap kvm_create_vm() and
>>   anon_inode_getfile(), providing a unified VM file creation API.
>
> As Ackerley pointed out, changelogs that are literally a list pretty much always
> needs to be split.
>
> These also need to explain *why*.  "providing a unified VM file creation API"
> isn't sufficient justification.  In general, all of these changelogs need to
> provide more of the "why"; I can figure out what the patches are doing easily
> enough, but in my speed read of the series, it's hard to figure out the "why".

Okay, Will update them.
