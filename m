Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC383491C4
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677078; cv=none; b=PxoDGdht64JD7lOJWryqXis25ADEH0vz1vEPSBQDuD1GrIMKYPs/zBzPQfMtbYYfBjQdy1JWno4aRSuXbYLNV9s7RKfCafkoeu2GSdfOFHAFOhOndwxqRh00TlLXMulDJi99Mghs/c0pk5eMOBO0fbiuEXSfk0oIkkJudVYIsZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677078; c=relaxed/simple;
	bh=c6BgUZwyzPyNuQhz+D04NL0akxRZao5DJpvyAXv8L8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K81UBkwpdza5ydwTpipv2n8YvsdTBtE3zeMYnQGO1HMRPAnj7cChKDksqmdagU8RMqjYhvVLuXKQI3IvJuJx5/4PgHfRf0GsGbbYAxkOWZjPnYL8QlWpsFxsKBUytASjBFjUo2Fakw7N4Oyym8pGXrgAb06s/YruLlrBcdu+0lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ow4yNF5a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ow4yNF5a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343BD1F00898
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 16:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780677074;
	bh=i4ZVTpuIRZsAQ6wXY2K8XXcROClMpRAt/KZq+QogOb4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Ow4yNF5a+H9JVAHbfm4xLVEiWMfNDx7mRAsXP0RAAvn95aJAdN362XRebBVu4ENax
	 F3K4/VY07fEe3blPkhgNaMjrzlSjWad+JAqRrmNWwsjLYSkXerhoP+MKlswTr8ahwu
	 9PANlrakKXOoG4XaMRpwXr8p//wq6+9XFTfFQB1q2glorCnWs9s7gyQL7F8N2+FYs7
	 IQf8Rk9yTYBFzOpHg443BPJbp9XdPj8GmjjVp5bIS3JAbJ4NCvOfsT54UP18D8BywX
	 NJeE+zaiRVAqG4Nhr6mkXG0XHoA7JAkLCOYEZaBo+WWOjGYgObR9YwfSWFaFtpB9b9
	 B1S9QkHZALPoA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bed2195323cso316497366b.1
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 09:31:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9TD3MOIYuMzWkoz+GIIlZiriZHVTfrC8U60N3AP3tjAwZD/rvjwS5FlLpdt0/7hX/XpIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5HZdbjukPbwMfKHV2oPDvfxypc+Nf/HFl7T41zGSiIOESTIxV
	kW6il586jjF8vRDCFn/OR1VcFlASlqXHKPURyTYke8Jq2knUZkDJuNc5xgjOMXoSq/dV1AqaaTf
	8Kus/xlnG/YqT51WJyR9qlj2dMH72tmI=
X-Received: by 2002:a17:907:3d42:b0:bed:6ba7:6b03 with SMTP id
 a640c23a62f3a-bf37057cdbbmr226823266b.15.1780677073062; Fri, 05 Jun 2026
 09:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604203546.365658-1-yosry@kernel.org> <20260604203546.365658-8-yosry@kernel.org>
In-Reply-To: <20260604203546.365658-8-yosry@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 5 Jun 2026 09:31:01 -0700
X-Gmail-Original-Message-ID: <CAO9r8zM5mdUTsT2CH2LdNbMNiKjdX+u6MRbFVJ=7kUAm58HYTw@mail.gmail.com>
X-Gm-Features: AVVi8CceTS8jpmXETbf5ZSYhN8HyIF5-J3XLMube2wg1KoCcwKfBPXNr20-Yud0
Message-ID: <CAO9r8zM5mdUTsT2CH2LdNbMNiKjdX+u6MRbFVJ=7kUAm58HYTw@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] KVM: selftests: Add basic stress test for
 save+restore and #PF handling
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +       while (count++ < NR_ITERATIONS) {
> +               r = __vcpu_run(vcpu);
> +               TEST_ASSERT(!r, "vcpu_run failed");
> +               TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> +
> +               get_ucall(vcpu, &uc);
> +               if (uc.cmd == UCALL_ABORT) {
> +                       REPORT_GUEST_ASSERT(uc);
> +                       break;
> +               }
> +               TEST_ASSERT_EQ(uc.cmd, UCALL_SYNC);
> +               TEST_ASSERT_EQ(uc.args[1], count - 1);

This is off-by-one, it should be 'count', otherwise the assertion
always fails. I made changes between versions and did not run the test
in between changes. The assertion goes away in the next patch so I
didn't notice.

> +
> +               state = vcpu_save_state(vcpu);
> +
> +               kvm_vm_release(vm);
> +               vcpu = vm_recreate_with_one_vcpu(vm);
> +               vcpu_load_state(vcpu, state);
> +               kvm_x86_state_cleanup(state);
> +
> +               PRINT_ITER("Save+restore iterations: ", count);
> +       }
> +
> +       sync_global_from_guest(vm, guest_faults);
> +       pr_info("Guest page faults: %lu\n", guest_faults);
> +
> +       kvm_vm_free(vm);
> +       return 0;
> +}
> --
> 2.54.0.1032.g2f8565e1d1-goog
>
