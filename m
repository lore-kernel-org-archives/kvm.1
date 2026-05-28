Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5123F9A18
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991476; cv=none; b=T75o1phmNQVf1eVG3ls69a+3T6pePBnoM3gdsKHkvH9/l15SsDXBUe3qrB+0amIO7ZuOLWanxEcrTxTQs8po4+SYgeKtqwMlWkr/49ZRH6z3Ux2CnOuH8appxUBdD5N2LEJYIWLKTjVEvg2U+qLn2akpfb4mqBPld+aPLdlfLM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991476; c=relaxed/simple;
	bh=+fninTk2fwWXvI75bX2g/Sj0KUrOHEb4XanS80kJkOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vGD7KHH02bmrON8yJjkrpIDfBATpDne95TdBIucIwwZ8mdxr+cHKeArEpTOq+2Hyw4tWXabrM+Ei8t3dcQupP/BRPcR0FB/MxXZK4o99KKZopRUKFPI8csEq648y1Z56wU8WOR8ceqAYJMFltqzSnf2xhh3HYS/c45s/bQo9Tug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MrjxsmrT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MrjxsmrT"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba5f794825so104489565ad.0
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779991474; x=1780596274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0awCcTjj5cBY+k+iW3PYD8qjXoaqFyvWYPYnm5OQPnY=;
        b=MrjxsmrTbanbayy/ZAP8i4Waw63Z8oIWW8pWzYiPpW3n1wfhvS97UZ0bNnmJTXH+0r
         PrsxKysH5wdLvVM4an9yw/mpjP25zrpkhQm6Iopf/JgYorwDA8JIBsKinKBCYkCz9JMl
         tMvjdWD03DfvdBwJkNad2+BTFYxDBJ8rKcaW3b16QQRdKmjJCw3sPZ/mtQLFqDsE8GGR
         Vzzs18gJ3xWV5+3LNcH93aFbEAPZyf1u2FuGx7Ip8kMSigap6MUee+qCQJl3d0T6mtrm
         LLXm7uQHhYcuPdOnmkYdwd2eLxErhLWVakdf8UOc+Z6fLevK2PwtTdT3nuEuxxstgD5k
         QF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779991474; x=1780596274;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0awCcTjj5cBY+k+iW3PYD8qjXoaqFyvWYPYnm5OQPnY=;
        b=dMdyixo5xDRZmlu6bxnRu7ZlTzb8wbqp0+olKZFfhFP/Kz5/Y2FvqTDfTkRvW82zTP
         RkPU3JtzxxAEQ+HH8QFiC9BZFcPsbw/Nwd7OFouSmf9uKr8/ppbVBdo7JaFEyvvEWu1b
         1YFAGxWm/XouxSW+0d+t0qSUm9oBMoORnlJuxjF+oPX0Q3JoqQF/LGO9Qfz1RTxxIeHI
         9gukAzmzogj6cA+WNHhsnt4juPg2/AFxaRr71n6C3wEOSV9yTHHEgwjTrA5j2/SaOdBm
         Pw59hsGKbxS5wuF+bwrd9YXhJ6jr41HacdmUhEs27C58Z3syJn80nz5hyVFkc9wpKF0N
         E3Dg==
X-Forwarded-Encrypted: i=1; AFNElJ965cnQDiq5HrGubJFNroMX7EPUEUf2OldHotpOAB67WzpIqDnvuPrF91ZNKcf1+V3fMQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVxSnZEmp9PBfn2eKo//POsbtwO8GDSOJl4tg70zmfpscDL9pt
	S2Lf9eiRtlzsmo3hNoh8dK+hDhh6lgmko5q1K3xQWiNAfwP1tQZasZ5EtoD7mdqXmyLwOmAt/Ej
	U7j7A0g==
X-Received: from plbjx14.prod.google.com ([2002:a17:903:138e:b0:2bf:1274:c8f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce88:b0:2bd:a3c5:6d96
 with SMTP id d9443c01a7336-2beb0756707mr307756445ad.14.1779991474177; Thu, 28
 May 2026 11:04:34 -0700 (PDT)
Date: Thu, 28 May 2026 11:04:33 -0700
In-Reply-To: <CAO9r8zNzFWYBqZ_ACC_rfaYoxARn18UdUUymkYaroXizj_+cog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527234711.4175166-1-yosry@kernel.org> <20260527234711.4175166-18-yosry@kernel.org>
 <ahenmnACHMNKO3WC@google.com> <CAO9r8zNzFWYBqZ_ACC_rfaYoxARn18UdUUymkYaroXizj_+cog@mail.gmail.com>
Message-ID: <ahiDsTe5Pge2qNxC@google.com>
Subject: Re: [PATCH v7 17/17] KVM: selftests: Add svm_pmu_host_guest_test for
 Host-Only/Guest-Only bits
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026, Yosry Ahmed wrote:
> On Wed, May 27, 2026 at 7:25=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Wed, May 27, 2026, Yosry Ahmed wrote:
> > > +int main(int argc, char *argv[])
> > > +{
> > > +     struct kvm_pmu_event_filter *filter;
> > > +     struct kvm_vcpu *vcpu;
> > > +     struct kvm_vm *vm;
> > > +     struct ucall uc;
> > > +     gva_t svm_gva;
> > > +
> > > +     TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
> > > +     TEST_REQUIRE(kvm_is_pmu_enabled());
> > > +     TEST_REQUIRE(get_kvm_amd_param_bool("enable_mediated_pmu"));
> >
> > This can and should be handled in a helper, using either host_cpu_is_in=
tel or
> > host_cpu_is_amd_compatible to choose while vendor to query.
> >
> > > +     TEST_REQUIRE(host_cpu_is_amd && kvm_cpu_family() >=3D 0x17);
> >
> > Why the family check?  Actually, why check host_cpu_is_amd at all?
>=20
> I assume you mean that we don't need host_cpu_is_amd because we
> require X86_FEATURE_SVM above?=20

Yes.=20

> Unless H/G emulation doesn't really work for cross-vendor emulation? I
> honestly don't know.

Not just cross-vendor emulation, KVM and selftests also support Hygon CPUs.

> I will defer to Jim for the family check, I took this as-is. My guess
> is that maybe older families did not support H/G bits or some of the
> other PMU features used by the test.

If that's true, then the mediated PMU shouldn't be enabled.  If the mediate=
d PMU
_can_ be enabled for CPUs that do _and_ don't support H/G bits, then we nee=
d to
figure out a way to enumerate H/G support to userspace.  Because telling us=
erspace
to check F/M/S ain't going to fly.
