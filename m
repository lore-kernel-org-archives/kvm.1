Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32365394785
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512007; cv=none; b=Msu3PHoPCz1fMqJFuO/UTimYP05bgAx4y3c3MKOxBJMS5MRcjBRIVxq9WFGPojeWUQV/xVNQEy4V9qpEGkHZXtclW+1T4jO7hacHPn01/wy6WGIQfPImhpphNiKELOs4jEEznHVVgwX+DAA2ZVaWfqNd/zkdB9WgV9MerQTQMd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512007; c=relaxed/simple;
	bh=LEb6SUsj2Kz60SwRoXylLpWh+k0O8fOHb1mx/yrKlzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vgb5/TBDPhr4mqnlDVXDjZ+IA99RKJuNW+OJlagp9Y+UpMZNpZ4L26DSKEaSuvZeJUYJIwtWERXvrmydIImENiOHQsDlBWme3m9v7xrzd8lqD+PaF7toK4nmsyzWxwAubUVLbFA3U6mDOrz7WEaA8na6bnDR4ynJEUhbDP9825Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+hh2/LZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+hh2/LZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8931F0089A
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 18:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780512005;
	bh=0fPJU/s5ZZr41C5FLU7uD3KOkjReY6gbANYgQB/JF+o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=L+hh2/LZK50F8sjSCPYaS6+JVWP/1AmSc1/VgeIF8Q4JXa0gdgjq1sDyQ+Z9m92dC
	 4YDoPDmOUodWVEnxdyneHYiy6zYqRZNK8W9F9thQ5RKw+/J5wpdk4Zytn11AgBLKhk
	 onvrobrAB9ZlGJJl/l1/jE3inH02H0pEbvDlU43HHBuahzmPuhs4ZlTlPzl7xBbwng
	 u5PuCuVi7FZZyr4zPtxXdEjph2af15r0775rgklxxO/+77Ld+PlVM170O4uMf89ebu
	 /jV6oysDglnc0jROl5GzSzhFmbPCDxTxIWS+faKhnoLAFS82DxFOxLX8GfWxaGvFtk
	 hkgEv67DKNx8A==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6896c54a7easo2961709a12.3
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 11:40:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ84u3lsnV1H3L4zZG8V3RGmYoasT4JiDJFp8xGH1NqKE6DB+yC1mdSzV7cmN7LD3dCYPAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHMoO67ickQ36Pn2UwVjhf/gd4MvVMx+ysXeV4VkOnxK1PxYa4
	MshDfgQm/LlGRXh+9rN6f1LXFA29HCcwc209pzO3Q/4CXAESPsQ7AkPY6H7MeZ460hWyfKVM5q6
	0KHQo3yf+r+cOtPOd1yDaCK6ctJ3Drdw=
X-Received: by 2002:a17:907:c207:b0:bec:b177:c346 with SMTP id
 a640c23a62f3a-bf0a7d2b79fmr299967466b.3.1780512004820; Wed, 03 Jun 2026
 11:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528231052.404737-1-seanjc@google.com> <CAO9r8zPA7RTwAD+_-knnTJvFbLJgXzsHYa7a_N2j0JdPAoSoUw@mail.gmail.com>
 <ahmUPsB2nOPFCRrW@google.com> <CALMp9eQ+XmKbpY8QePbjZMA9fNm4-77zbDBNX2M-ZOdumNGyxw@mail.gmail.com>
 <ahoZfWeYsAICk9xc@google.com> <CAO9r8zMrXbGevTgNttshFf88RDKrsaa_r5WryczFK8OMVcdHDA@mail.gmail.com>
 <aiBzZuSk-9d7YnzT@google.com>
In-Reply-To: <aiBzZuSk-9d7YnzT@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 3 Jun 2026 11:39:52 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPX7On5VRMngYJBctMKvyZG_n-kfDrRB7ymt-2wQTi38Q@mail.gmail.com>
X-Gm-Features: AVHnY4JimxYWwcasK7nA-6uHp-0GIdQhHerolNBP-ccso9YKDlLI8G1ICT3uBC8
Message-ID: <CAO9r8zPX7On5VRMngYJBctMKvyZG_n-kfDrRB7ymt-2wQTi38Q@mail.gmail.com>
Subject: Re: [PATCH v4] KVM: selftests: Add a test for gPAT handling in L2
To: Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > Anyone have a strong preference?  I like the goto approach (obviously), so that
> > > that all the gpat_test() invocations are prettily aligned.  But I can live with
> > > an if-statement as Yosry suggested.  I think the only option I don't like is
> > > moving the NPT tests to a separate helper (it's two lines of code, and testing
> > > the NPT case really is the focal point of the test).
> >
> > No strong preference, I obviously also like my suggestion :)
>
> Ok, third option, which I've pushed to kvm-x86/svm (but not kvm-x86/next, yet)
> in anticipation of overwhelming support:

Looks good, thank you!

>
> #define gpat_test(test_name, guest_code, npt_setting)                   \
> do {                                                                    \
>         npt_setting;                                                    \
>                                                                         \
>         if (npt_enabled && !kvm_cpu_has(X86_FEATURE_NPT)) {             \
>                 pr_info("Skipping: " test_name " (no NPT support)\n");  \
>                 break;                                                  \
>         }                                                               \
>                                                                         \
>         pr_info("Testing: " test_name "\n");                            \
>         run_test(guest_code, false, 1);                                 \
>                                                                         \
>         if (guest_code == l1_guest_code) {                              \
>                 pr_info("Testing: " test_name " Save/Restore\n");       \
>                 run_test(guest_code, true, 1);                          \
>                                                                         \
>                 pr_info("Testing: " test_name " Multiple VMRUNs\n");    \
>                 run_test(guest_code, false, 10);                        \
>         }                                                               \
> } while (0)
>
> int main(int argc, char *argv[])
> {
>         TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
>         TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
>         TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) &
>                      KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
>
>         gpat_test("Invalid gPAT", l1_guest_code_invalid_gpat, npt_enabled = true);
>         gpat_test("Nested NPT enabled", l1_guest_code, npt_enabled = true);
>         gpat_test("Nested NPT disabled", l1_guest_code, npt_enabled = false);
>         return 0;
> }
>
> Which (obviously) allows printing out which subtests are being skipped:
>
> # ./x86/svm_nested_pat_test
> Random seed: 0x6b8b4567
> Skipping: Invalid gPAT (no NPT support)
> Skipping: Nested NPT enabled (no NPT support)
> Testing: Nested NPT disabled
> Testing: Nested NPT disabled Save/Restore
> Testing: Nested NPT disabled Multiple VMRUNs
>
