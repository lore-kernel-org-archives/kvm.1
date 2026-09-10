Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC325921E2
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066400; cv=pass; b=aXGwytWSrlcYl4onZzNmUsOsP8PZ3In/XjdW6HqGEYy7fE6k+hzo+I4Yz/OKL29sTYa6OUGth4kUF5W5duPGlwTLjMm7Wvm2yNS83KDDNCv31qUyMiPXhrxA2IdpznyH9LyORVvcshwd6hufxQV0mgxOtF40tX5XQ5vZzDtzsqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066400; c=relaxed/simple;
	bh=dT4FNCiiMtIXPLJOvuFJF0jefoKwdOcRJ3SvzlEgqv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tr2XDvvYf/8WxxD2NqbKhZ3qFnI93oyWIGyelZFNNRF9WNkz5CbeXGxQ6uRN+uxWl1yh3M7BulSxGSBjp2mcZy4M55XOw0BzZaeHsEFCPUfZ6aZODXuqUi4NZLDT/6SCjwc7yu2QLYjw0kTkw83qUwwV9q4iIMA8OeU06Gfed+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sw2RHwaa; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sw2RHwaa"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b4a0b17359so9578e87.0
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 11:53:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789066392; cv=none;
        d=google.com; s=arc-20260327;
        b=GhsMsznjjQkxcttwuYXF2xGX28E0NJnrypOWRPyY8fe7nXO6AT63WsIeFNGwAOy4mO
         z6im0AVkbSzoZORXqzEhzkO1Qtxjl6w9mBLp2SfKpJCEswRE5NpEVD0nYiy+Om6wUQxu
         T0Q98ggrs80rxGjX+KvRtplmx7ZGeEymNUHzA7MLBsUQiE77c4dQR+NfqPE+0XAWyCPf
         5dU/Kt8VdBAPz0O+MAFUDAjpNuq6M6Kfzh1IvpUYCPK2+cIoetS2fPPJrKtQVWxokzdL
         hBMXjq/0m1/YyZ+Jm79t7JtGYGIhELR6AzLOicMdaTkiJS5C3VjAf+BjICBjdoQMiVYx
         r69A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uPA7h1yzQiskXY53xtPOVbRZgGvwK1v/3hUYMrYw/Xg=;
        fh=V2gyfNw9GoW+k/bGYAK8RKUQyFjv47qhAHpDhM1V+6g=;
        b=ond1ZSbIA8rEPCULwfaXwZcsll4ks6ha2Tet8e8wG5OtslfjHCwqPpJocfDHbrwIRX
         RiFJFJf5YCEYM81v812Zm+E+AdyQN7ED0M3AToXXDC3a7SewAY+N/rrmb5gfAeLh6NWr
         WcO55tOmLVgM+BvzxfhLj7kjhUtqHps2GVdVmsTrCBlLvgZ6J5G2TtnJM41qQ3526f/G
         qL64+ZgiY7NrW14at/iFsL2XfepGClEV6Pq240zeovXD3+5Z4Goj8T9RjWSpQBkp4mfG
         f2X4lmdIrXYWFCnylMWtWmiwLkT5kR+JaurjovqEObJUsaQL4+21cm4P338gYwrAJJj5
         qNwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789066392; x=1789671192; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uPA7h1yzQiskXY53xtPOVbRZgGvwK1v/3hUYMrYw/Xg=;
        b=Sw2RHwaaXxf51aB+WhflsVPXZjPmG14dd4LokBPYZn/6ZK7idt0TuWHcwAav/rWQ/J
         eDL6t8jrNOzhMjtU1SidTyEOOIwal+t61/w4oylo6ShSyZHYn7vrPXaTTkeJ125mtlzp
         6dgwX6oRGqeQoen7xjJiFujW4kOEQWd5pX8BhfUxGS+fNbJQ7XnqkrnIWsCw0ykKcA1V
         Hru4wYgKWBHQ9f1dQi3R0+hFBxyDmOm4+9SCetyVRT2TG1svlCRnmbi7ps8RcMSy/x+b
         QMEzSPV81L3d30DWJPWPvUFoT7OY6HznQulPA05Ceuu5BvYhjvJPtKUhjtANy084mqoZ
         EVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066392; x=1789671192;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uPA7h1yzQiskXY53xtPOVbRZgGvwK1v/3hUYMrYw/Xg=;
        b=qHQQP74aFjl6toD91r/IERbH+4accGGtoRALaU1kH7NY2hrsLLr1otKqa4iWORerka
         5E7E0YR6DcpcwsbF+F7sV3wI6GlymbtRYEP7QMQ7w7LmjytXOowJYqdfQoE7fV5IG1GV
         /bZ066Hka9lgZtmVCyIldVXSaXQj9xq0evQef9w1iFDnLIxL9NplWc5PPh5PaI8NhHHT
         MbwPLG0RENo3wtdpxV73fHx0UkCx/kIorFqDa5b6KeEklR7P86iNHAasuV1Bu8CWEaAs
         pytYB+ldKaZDRMxfnUK2QO8t5lnQ0BFp88u3QzIw9ZRrykr52aBaB2ot0AoEusr6lB9l
         D9aQ==
X-Forwarded-Encrypted: i=1; AKwUvByrmE6PF8xre4KFUquXClMhtFKuhmow8sfbzrTgwPGhtJQDwR4X9n8fxgbwgl7+YwjuXkU=@vger.kernel.org
X-Gm-Message-State: AFuF++novoPk8lNQOe1lGVGK+erif9ZZRRNsZXEFMuit9aJkkazTNczP
	ct7wNTZW8odfcPvMgc5Os3z1ykAI6gJrIcs0bV/iNnhDIUXMcOXkNZWmjZ3LzzwEWIYbiOtMyWg
	F0k93ZAxRG99dobYKVMalme+AAq/pnT2s02rvp/U6
X-Gm-Gg: AYBFou2jLIT/jNfIbXxJX5Viq2AlrB40q9yNt+XzYN8O5g9ctwWWqdik0hB5Dghk2A/
	RWaJtFHszH3jMm1NdKRsImA7tY+BZRSj0Huv4rArXtWAR4WN5erPF98vL62OMiEMyazEKaRIhHM
	xBLPudtzvNoHxg8+/F+G6PGfl+iS1sf3zSp4aSxyMGtFY4eoZIyeLD1iP0otqtUvBLz7K528wsP
	y0+sdZRPplqmFBieMbuGgPp40YdN4KDUiKiJOBMTNJN5jYMHLXv46BeVP+o30rI4XsOXSFYKwCr
	GvwzQVeZGkpYuSkZ+EX4Jo3QxwfDN7OQQyKX6DsDZ+NTi7II5cUjWce5pRkanXITIn48+P/dmXH
	VvAO1CDwJ0q/N+g==
X-Received: by 2002:a05:6512:4009:b0:5b1:4fd9:ac with SMTP id
 2adb3069b0e04-5b8a07a0e5fmr23463e87.3.1789066391400; Thu, 10 Sep 2026
 11:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-kvm-arm-prefault-v1-0-befe8947702e@kernel.org> <20260825-kvm-arm-prefault-v1-6-befe8947702e@kernel.org>
In-Reply-To: <20260825-kvm-arm-prefault-v1-6-befe8947702e@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 10 Sep 2026 19:52:35 +0100
X-Gm-Features: AcwNN1XPPeWtd-a0jzst6s0fMnTr0aHfMbhg6rA4kjyMckfbadgDOVe553duj-k
Message-ID: <CA+EHjTzOKHNrf=0n2c_E+vbt=pGquz6qzBpJ+eLJ5hjK_nyJMA@mail.gmail.com>
Subject: Re: [PATCH 6/8] KVM: selftests: Enable pre_fault_memory_test for arm64
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Jack Thomson <jackabt@amazon.com>, Jack Thomson <jackabt.amazon@gmail.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Vincent Donnefort <vdonnefort@google.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Leo Soares Passos <Leo.Bras@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Aug 2026 at 17:01, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
>
> From: Jack Thomson <jackabt@amazon.com>
>
> Enable the pre_fault_memory_test to run on arm64 by making it work with
> different guest page sizes and testing multiple guest configurations.
>
> Update the test_assert to compare against the UCALL_EXIT_REASON, for
> portability, as arm64 exits with KVM_EXIT_MMIO while x86 uses
> KVM_EXIT_IO.

The message says this updates the test_assert for portability, but the
parent has no exit-reason assert and no struct kvm_run; this patch
adds both, so there was no hardcoded KVM_EXIT_IO to make portable.

...

>  int main(int argc, char *argv[])
>  {
...
> +
>         TEST_REQUIRE(kvm_check_cap(KVM_CAP_PRE_FAULT_MEMORY));
>
>         test_pre_fault_memory(0, false);

Would it be worth adding an arm64 case for gmem_abort()'s pre-fault path?

Cheers,
/fuad

>
> --
> 2.55.0
>
