Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B4E8834
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 00:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780015661; cv=none; b=eLRd5wbn7eNtmboWx0A1IS6KMoPawSd5S/XSBDyyZg/t5J8Dr68FPE3PXZFpb4XBy8h5qP28VE079cySPInQRYddLyjIWnl8yOX4CkoShmTajNw2OD11Tg8q+hhHWFEGWULDyclGRVWvk+64/nACepPBUBO9fgL9eTldJnk7zXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780015661; c=relaxed/simple;
	bh=dxTQTPiJMfIdRKjTqv8Sd4Aqk9foWf3PoUPTaGtAqa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hica0yqi464RygVYaD5vEH1+yZJrI1egnHrT0Ds4RpkSL0ksifOz/TdAXz/UrOh7H7we1ejHiGHXhKK2n6G4O3Rp4XucbD089ANb/Njfj4lBUrxoo1dNJB06i2JTbx5uY/ryH5Ur1Vh6xXZIMnMqBIvzjduyxcNe7CPljC5vLzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LR07+sTg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LR07+sTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC461F00A3C
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 00:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780015660;
	bh=eZWF7l3APS9gJbbb7y+3+/9JP1pgIoRVtgnuwtV/NPA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LR07+sTgQ0yp849VIbe41oZh2GvXMJBEvDCNMiT6Twj6tUdg4z157nWOZ6RzfrrfF
	 S7kcMSt3oE5jsx8TZ+yRyLyBYjURGCKJLMXYx4D+025bhaZiFRODyk8/9tazLntXtZ
	 M6JxfVUzIcZ2cd3Ide2/bhQcd8Rr0bWiIODes0umbc4Bp7v9YZfLT1loGBGp1xrDpx
	 vmkpgprICoPWW7C8MM6ffRrnxttdLo/U70By/OXyNMk9xLMp3koMh9PV1LVo+OkdJ+
	 T+dpdlZ/IoPvXWNSKqKytxx29zuThrHY10sSlYQEP1cWEZQf+r1yCY9JupaLICkqUh
	 IPaw+qIMspayg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bd3eb594960so1541214466b.0
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 17:47:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9EriFODaUL/ZdKo/xaqwuBQdoU6cFXUkgdQCteBwtBfqrMAzo/Nk5vNci5ImEQHFSCr0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXVLYfSVwBjhYtvMG6WkQ5X9PJfGmekefnE2/MD3n5JEfuNaWu
	R5ZkWQqYf4mDi7zAwMjSW3ZIxVF+iugWB9zoGBhdlNYcAdM12FCsItr4nhNMPKL41aZB2BNFiha
	5xIRAq9P3eXHiOePNIWO7T+7JJU1foY8=
X-Received: by 2002:a17:907:8694:b0:bd5:151d:2d31 with SMTP id
 a640c23a62f3a-be9c924239emr17879566b.13.1780015658935; Thu, 28 May 2026
 17:47:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528231052.404737-1-seanjc@google.com>
In-Reply-To: <20260528231052.404737-1-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 28 May 2026 17:47:27 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPA7RTwAD+_-knnTJvFbLJgXzsHYa7a_N2j0JdPAoSoUw@mail.gmail.com>
X-Gm-Features: AVHnY4JnwFwlyuNV9pUxMdJR4fJ0ajKl_7VX4TM07EmJs9-bF1T3TPdQ5fgV8kE
Message-ID: <CAO9r8zPA7RTwAD+_-knnTJvFbLJgXzsHYa7a_N2j0JdPAoSoUw@mail.gmail.com>
Subject: Re: [PATCH v4] KVM: selftests: Add a test for gPAT handling in L2
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +int main(int argc, char *argv[])
> +{
> +       TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
> +       TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
> +       TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) &
> +                    KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
> +
> +       if (!kvm_cpu_has(X86_FEATURE_NPT))
> +               goto skip_npt;
> +
> +       gpat_test("Invalid gPAT", l1_guest_code_invalid_gpat, npt_enabled = true);
> +       gpat_test("Nested NPT enabled", l1_guest_code, npt_enabled = true);
> +skip_npt:
> +       gpat_test("Nested NPT disabled", l1_guest_code, npt_enabled = false);
> +       return 0;
> +}

The goto is really unnecessary here:

if (kvm_cpu_has(X86_FEATURE_NPT)) {
       gpat_test("Invalid gPAT", l1_guest_code_invalid_gpat,
npt_enabled = true);
       gpat_test("Nested NPT enabled", l1_guest_code, npt_enabled = true);
}
gpat_test("Nested NPT disabled", l1_guest_code, npt_enabled = false);
