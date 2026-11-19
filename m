Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795125290;
	b=WNFjLtuh0l0YCpIQ+Dh1yCKY8mZcnLRUzMq/ZCSZ2XvRrNUreQpUqUglovSKvMgZlvF0
	 muUzY6TtK6qK+eHeEHuooyfxaJHiaO2MIqZ9PbRcR2Rrof5A+WSzxX6046NZkzs5WzIm0
	 fe8J6UvqsjiceRFPPXvmJ1/fOdmBJOWae89Kztu7nhVu9E07lYU5RViRaheIaIPrgAOPB
	 97mfkc18sPjuLSEnBiQPY+VmIwNsU08eifQDH68vyivykLnab+HNaQ/9yEg/sYsiVzLGK
	 CQa7s7wmi9QEm6M36pVJPhXfQaBVsLn7vnl+aW5/YgAsz/26xKJvgTVDtkJpkK/QrAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=9oWwO0cY+zSAmEBywqcvt5EowD1mRhhhpuanmPj0nj4=;
	b=em+vgs0BQU4aBxO1kS9iXjLOOvWTurA65luLeDkPcxcrzlujZx9v+hO7zAcNDGHor3+Q
	 nkzWAO2f5UXIrBXMyXewysM00dRKHxxPHsYDsycfJZr8jIakXA7sIf5zo9OqBR5/1Qgbq
	 BzpSAXJN6m+0C5aaTtU+pXnSaPwGxtktIYpeAZdTgFrzTdySA3WvV75MKz6NDc24wTzMp
	 gdrGFjcN1SjNENVotSbaBtVxcBHLGiZ0l9lzsls3LZYwmdld7o7tp2gY5ELylyNIIcp54
	 AHgEC1WZnMuLvnug4f+dWVrYTYFv+o7I3AJ8fMi10KZJZ6QjIQuskFMqShZtbFR7AyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WatmF7Bf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EC7606A330
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 21:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1EC7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WatmF7Bf
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91ccfb88e4dso3367576d6.0
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 13:54:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795125289; cv=none;
        d=google.com; s=arc-20260327;
        b=JrGp5YdhX44OEdZh4qQtz4M0f08Bcf4Z0YKW37YjhJhSKjeu+DrFSFotwylWwTfS8i
         jXTeG8S945p0Z2NTltYDHO+krS8kpNzPpLB3cp4uZkSudUb13u0NetNGiMk/25kh1HgB
         ecuuWmnFpZ7MvxcQKGAiDrxhtcrocW4seutdI0Bf/BjhIzSUNlKMFk9QdD/C/zOjSfsh
         zvSyY7ZGa37zeIbd2SAQyn4ESsAOgLeZQDDUkeLxojGqMP1+z5mqV9jrBbgGd7MCDHUO
         zUvzz+3QANXA9ybivdKCHYg+890aMqc6DdA4LKmQeKuwtT5r1G7R0FWTetsDQO3zbqm/
         jqiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=9oWwO0cY+zSAmEBywqcvt5EowD1mRhhhpuanmPj0nj4=;
        fh=/J520Ij0VyynY0OrI2LKuzEZVDQPYBL2FFFRUV+8F3I=;
        b=QYaah/lvAnj6/rmE2K3uEORZJEx7mk7DJj71XAmSC55ynwxh7XFs0HjCX1q26KqVxk
         Maq73ZCI2qlx6Womz2XByCW4Fte9K8kiG158NZvo4eCQ2Wy0tltsmty37lbi4Um2rpa9
         TSDN5/3wEv7oqbmYssxTZM7MMyie7KsXy9S2zRue5HNNdawUztoQsF127Ip8L0DW8pFK
         9WQoWJL37AIkdYHeFNgLlaW4FvpcfCt6mQpwQkNwxHRydKPBDptpuynAf6Brmk1ronUa
         ON1jIFFY12q9d7zjDZnVNRyddfWmgHVqSVrUqS3YVLhdA0CGMcSj0VTcryJZEsolXdn9
         mcPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795125289; x=1795730089; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9oWwO0cY+zSAmEBywqcvt5EowD1mRhhhpuanmPj0nj4=;
        b=WatmF7Bfb5ve0ZyLGh0y1kNXNwoZkFx/ObXSVKcZvbD/aGijZaGVMqPRbP2KV59Lfl
         fGiLhVypJzx6sJA4HSp5qmT0LqQ6d56W8QvmR4EEK7lCQqRI+Ub9Z18gEohce9yw3v5S
         kNsxdh7/Z4QVXpM8RaExIAMbwZSh5km5m8pvKumK2jLRhVbbrCQ42Y3QjNK6u4fVXBuL
         r2MgjsS4M3e6fE7K5U38FDMbH9GQbfBws2R/RGaBIy+woM/Kcb1wovKM0zYPj6ILecFS
         j+jY1VaNmkzeEKCdw71B0VM9y38RviM5JyjTjNTxA5urC58pTjxX3Zb5S1rvchV9y459
         OBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795125289; x=1795730089;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9oWwO0cY+zSAmEBywqcvt5EowD1mRhhhpuanmPj0nj4=;
        b=Hyjn0V4HkoXDxcSIifsD1PAvD4cG5LhL1+ZEKMiPIiN2g+MP2U39qNTx3uDjK6Dbo5
         i/sU+RqaVJk7vJY+uGDph8Jra8LOODfrR2bRhOsGcO9EcU1iNG8GolT/APi8xQrXI1uA
         CVOk7zU92ptCT1BD5jaKzq6DKRIfGAmHsujdJiuV8bePqsRs5kThE6ZOEgkIwpZsxNEd
         pZoj4HdQIsT1uXrBiRa/tkfMmUyI9rmm4DVvzYEOPTgvZ/p2dV4X7X8eGTTHO0ssbjO0
         IG46DO5q8F1/0SSNwihtdakTH3hIn9Am6HwDcDSWkkWGo2lPkOkmaUc1CuxS18eN3mi5
         A/2w==
X-Forwarded-Encrypted: i=1; AL+hErGv6IAnsRohBUEIQfDcUrmbG2OiF6GBaIJqZ5JvWEE9tnTq+7WUElNLk2ghmPYPKbTgRwE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NgfDIrKpvcBBwDCl6SiqA4cWXRWSHf3xHJljNhOs52WT2+M+Z
	vqf0ZtJgeRcaaKc650dEyJXUyBe6zR3yKY36m79iVk379ygFg5p7h6e/NGzWFHtYp4byKg9+u1N
	szLSfaJRVjVHP19W+GtZMsjCzoWUazMI3nrzz22Xt
X-Gm-Gg: AZFdTZcuYdqaOhlu0cmE1x/rt5UDCjPF7snFZAA9wxYK3fyShuzDioOT7VGkI9q0CeM
	6soG8yiJX/NU2oMfDJMLUrEQZHYIw0/+ultYcXHPR+kXC1KJnmTOhSNwrlhXShRuY45c9KKGWXl
	WwBGTdMBLVXWf5N2rJrlIMLqTBPayY9uUX6Di5ip27ujQauFAkrE6Qs/j1XZHxW6uSf2cUYH9MH
	9T4jLw5E4dohr1AvpUcWcrlagjiPb3RY/W2HoXY0Oh2KYAjFcPMwim7mHE/RbwXDkxnpAvU+Ldg
	Z8+gCI5jukXuAILA76Rk+1YMva5G/L/fenSatmL8Jo37p/wV2bPlr3cTqktj1PZFdAYP0TMS17Q
	dVbdsaelOXAkhB9pvDyN813LmkFDrkALevt2BXm9zFM0a1UlE2AMEX+OyBu0NDMB3rB1OxPM2YB
	4hmFv+iK2v8dNrNGzCuSSgmw==
X-Received: by 2002:a05:6214:4018:b0:921:3369:a766 with SMTP id
 6a1803df08f44-92134a90270mr18304526d6.37.1795125287959; Thu, 19 Nov 2026
 13:54:47 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Nov 2026 13:54:46 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261112074120.1570072-1-aneesh.kumar@kernel.org>
References: <20261112074120.1570072-1-aneesh.kumar@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 19 Nov 2026 13:54:46 -0800
X-Gm-Features: Aa3M54oXacZEF20KAAo0a9xrzHva6i-aYhx3GSm4FZG9y6dnhRg5XpywqLRfWns
Message-ID: <CAEvNRgFKfGEzMzAHCqGv4T3YdkjFbLKjuHW-CR9V0OzYRzTu-Q@mail.gmail.com>
Subject: Re: [RFC PATCH v5 00/16] KVM: guest_memfd: Add a common framework for
 device memory providers
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, linux-coco@lists.linux.dev
Cc: David Woodhouse <dwmw2@infradead.org>, David Hildenbrand <david@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Steven Price <steven.price@arm.com>, Fred Griffoul <griffoul@gmail.com>, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> Confidential device assignment needs guest_memfd to manage device MMIO as
> well as RAM. Device resources such as PCI BARs supply PFNs directly, and
> their protected mappings need architecture-specific map and unmap
> operations.
>
> This series adds the common guest_memfd support needed by device memory
> providers. It builds on the resource-provider API [1] and the existing support
> for folios and RAM PFNs.
>
> The VFIO provider, IOMMUFD integration and Arm CCA implementation are
> available together at:
>
>   https://git.gitlab.arm.com/linux-arm/linux-cca.git cca/topics/cca-da-gmem-backend-v5
>
> This series depends on the resource-provider groundwork from:
> [1] https://lore.kernel.org/all/20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com
>

Just a quick update. I'm still interested, just tied up with internal
work. I'll get to this as soon as I can.

>
> [...snip...]
>
