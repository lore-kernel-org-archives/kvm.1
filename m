Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8D71A0BD0
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 01:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053366; cv=none; b=N0HTGp9E8Wx8fXYv0G3qprtISbRenMQkVUpYfyiD8uShy4D3YAgiD3NQhFd5/rqnHsfGgl0nIdymM7+E0F55vHbMQepxrCTonrm5IRgyMTgBFeuNr6wCVOtoj4/SxbVTIls6MFF3lHbrWb4vCvyRUbQeYGcQQ0suFbk/pzWOB5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053366; c=relaxed/simple;
	bh=8UWEFz5xc8HwIgYURG3o+VWfvwL8FlRHhf8cAD+DfKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Os6A+WZLmEBzyekZwv7lxPhbjek7wlymhsQ4A5zM/t1YfXxG99KVe2rBShtvb5/zrCoeUwAcGEfPWP5Plcz+dMqrsByQNuk9fnwePhgWemVGkb2SkWrANbVU7P8cQo19IpDkCNtzBSePtWzARslPVWwDH6uF9Z2wiXPHKGhUYd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASCd/Nc+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASCd/Nc+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462991F00899
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 01:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053365;
	bh=vtq2TzIQPc0sOwt4ZlxQX3DJsDR4yPut91teeqgfuns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ASCd/Nc+OeLvSOd+VbIzSuXmOjinZwYRisgBbY+8R5MgUWgzGkzYyIBh6pS8uybs8
	 5cY7yncPA2nOqA3HbOTguj718NWhv6Ggh459MfokFEJfpifYHDyjvmU3esCRZewgpP
	 NvW+KP1XK4CZM0pSRGBxK+cYg74HGAxWbdkKzwl38bEOaFPJNJCSuH3rSGFIlG0Wtg
	 dg/yuMMxzd+8cm0ERAgFBSnEE+KMdkpzt1pHQWLFZIEscQBeN43LDsKvfTv6CdhPvh
	 AOjkUJBdXAQNZjt5HzM2aniL7jEDUJ/c/Cuiv1fd/umBullkUJY1ebOx08R3b/O/24
	 zmPQtqxgJKnYQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68d233bf083so8749054a12.1
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 18:02:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/d82wC21TIfRNN57HKEdIp+MgGLiBkoY5BwU4/EOEgs/2KOIGBjnVGaLhoNbkb5iW4DUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8t8jX8xb+0FP8MEFPD5SS3MPF+rFN2zhC1B1dyMwfnB6n6L/p
	YmHsNYa4zy7sfHVMQ338zx/haR7utNw3YPOqbI1HQ7x7OJkAIgbGFgigkG+ItV7acz9gVirY5k4
	hGABSWxTd8AW04T0A7BmtOkFe4dfT3HQ=
X-Received: by 2002:a17:907:94c7:b0:bc2:70ca:c41e with SMTP id
 a640c23a62f3a-bf372159ff7mr1128691866b.25.1781053364243; Tue, 09 Jun 2026
 18:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610003030.2957261-1-seanjc@google.com> <20260610003030.2957261-6-seanjc@google.com>
In-Reply-To: <20260610003030.2957261-6-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 9 Jun 2026 18:02:33 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMHosEKimDkFsiwT-1mft0XMnOdprzSJUY-WZvXT5ggAQ@mail.gmail.com>
X-Gm-Features: AVVi8CdT9w99oql69u0JP04isfDd1ATVOzzzeShFS1dRfdSIIDKh4WhHFApUIqA
Message-ID: <CAO9r8zMHosEKimDkFsiwT-1mft0XMnOdprzSJUY-WZvXT5ggAQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] KVM: selftests: Add svm_pmu_host_guest_test for
 Host-Only/Guest-Only bits
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

> +int main(int argc, char *argv[])
> +{
> +       struct kvm_pmu_event_filter *filter;
> +       struct kvm_vcpu *vcpu;
> +       struct kvm_vm *vm;
> +       struct ucall uc;
> +       gva_t svm_gva;
> +
> +       TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
> +       TEST_REQUIRE(kvm_is_pmu_enabled());

Nit: This is probably redundant since we can't enable the mediated PMU
when the PMU is disabled, but it might be useful to tell us that the
mediated PMU is disabled *because* the PMU is disabled.
