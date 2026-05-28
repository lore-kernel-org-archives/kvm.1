Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949AC4028CF
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991277; cv=none; b=MzNtX6GLThFa3etmWDVvkyQO00KdmfTcRTVP9jKswAGqNgToep108n77u1mIe05yCuV/fjaJtWGfI1TMD9FAVvwODTrGy6NwgomDXn5fAVnS/yB56mZTsMpGlaRJyWk2afQTrK+z8vRLFy4OCRqIzYgoXxj1jox/MFhPQ/wvQUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991277; c=relaxed/simple;
	bh=1hn5YJzkxLhRI3XqC2gnKN/osRX1SPQ92F3PeYRvdkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgUdUuax+himU4MDYhIbu+CbpTDUE/jULkYrhX803N1fCzit+awtg/F+BdgJleWSoDP3iZrNXPkkaJUWrN1hUSEqjc+hR2at5eHNU6hFcElJhbM+9LWhwLeOX4CL7iMjVQH/Yn24Iq73wXOezCyG2b5CZ81kBwL8MJHlrbJZWMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ee/CdgWR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ee/CdgWR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539B61F01558
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 18:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779991276;
	bh=SKkCuNebNzBFgHPFFB39Dbr205adDp6mF0qE0r+N75I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Ee/CdgWRJUoXmr7gwV4dX3u4KD5B29ELWG5sVvFp8yRMfTYvT6vQuqdiqfpIc7bM7
	 vWDo6UwJdlQt8C9ZGKAFzTTK5QjzgEYoP9lI8ukxGDA8AAHKJcklJ5GJ01JxOOLTNt
	 mbLsKBT9o5mwTrQgqrtQdE5/SS2LiEZBuRw6Lg/MsLcABQGK9I2ON12ad0Fr6Ud9h3
	 +lHyU28KHikxCTX86j9xGHI1hJKWwl8Rr9vDgUnY+hlPM+GTt3hGsWdr9YlHGUAdkv
	 hEjhMip9dncXpZ9xYpxnPntIsh2GqM56BQpPsO8rAVd8MHUJ2437n4BZ7zdDoUAmSN
	 mLa12a53jvX1Q==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bd8f9889a8cso1583513466b.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:01:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+IGFv/i3J5tHHSK9XeEdjVFdePZq1qUM2FbpbhzsdV9yFywEL8lVIQWGvkyftctd4rmTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyBKHhd/Y5fHC1ZTaEMk2B1XwUlmFJp9b4KvUIvhiABIz1B+3s
	JlLb19q1g8LM6PEZpM970XaUyftfq1ib67mBK/IGoxxrLM/RdDtsH/klO/OZQJRDH4iiXHWlv0D
	P5jsC2oPzk0tPlYL4QvEZKTu9Lmk9T8Y=
X-Received: by 2002:a17:907:944b:b0:bda:25eb:1893 with SMTP id
 a640c23a62f3a-be97299d287mr15529566b.20.1779991275164; Thu, 28 May 2026
 11:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527234711.4175166-1-yosry@kernel.org> <20260527234711.4175166-18-yosry@kernel.org>
 <ahenmnACHMNKO3WC@google.com>
In-Reply-To: <ahenmnACHMNKO3WC@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 28 May 2026 11:01:00 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNzFWYBqZ_ACC_rfaYoxARn18UdUUymkYaroXizj_+cog@mail.gmail.com>
X-Gm-Features: AVHnY4ICC6hM--Zx7Tg_EpPXkrARphCKKvzfR3G7G7HBs0vNKsXYOHfXSbodiZY
Message-ID: <CAO9r8zNzFWYBqZ_ACC_rfaYoxARn18UdUUymkYaroXizj_+cog@mail.gmail.com>
Subject: Re: [PATCH v7 17/17] KVM: selftests: Add svm_pmu_host_guest_test for
 Host-Only/Guest-Only bits
To: Sean Christopherson <seanjc@google.com>, Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 7:25=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, May 27, 2026, Yosry Ahmed wrote:
> > +int main(int argc, char *argv[])
> > +{
> > +     struct kvm_pmu_event_filter *filter;
> > +     struct kvm_vcpu *vcpu;
> > +     struct kvm_vm *vm;
> > +     struct ucall uc;
> > +     gva_t svm_gva;
> > +
> > +     TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
> > +     TEST_REQUIRE(kvm_is_pmu_enabled());
> > +     TEST_REQUIRE(get_kvm_amd_param_bool("enable_mediated_pmu"));
>
> This can and should be handled in a helper, using either host_cpu_is_inte=
l or
> host_cpu_is_amd_compatible to choose while vendor to query.
>
> > +     TEST_REQUIRE(host_cpu_is_amd && kvm_cpu_family() >=3D 0x17);
>
> Why the family check?  Actually, why check host_cpu_is_amd at all?

I assume you mean that we don't need host_cpu_is_amd because we
require X86_FEATURE_SVM above? Unless H/G emulation doesn't really
work for cross-vendor emulation? I honestly don't know.

I will defer to Jim for the family check, I took this as-is. My guess
is that maybe older families did not support H/G bits or some of the
other PMU features used by the test.
