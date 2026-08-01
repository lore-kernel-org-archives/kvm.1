Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A500357D1D
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785564622; cv=none; b=jcouyf8Xpe2oe8p6MIjwLx+VCWmr3IK+b6P4TJQCxxN2XreZONBXbBFhen9Y6QaWLVdhkkrFHqkRWtmwwLzSIq1R80bqvCyYhbrI8iG73Bz/s6ze5WyacM4RafqOfompCJ1a+TXyvwS/23w9kW1YoW7Nqu+rrpph8zrSPYGirms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785564622; c=relaxed/simple;
	bh=FcgT1DlZ5qKQ+i4hWOcaKhX2kBBV5yow/1bVrhzPsic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BB+CMb/A1n1x83uNdh2V73uabEhFibKWBeIoZXEYiFRTklvA4+dDAZxYVzLJnsvOWvcll65+4jxqvDgiCWNdzbc9/Rlyw4N6t4kooFm3ut7unBGfTp+UQU+C8BT7Y7xQ1C6gDFuPUVUOeoZsROMZfT57PHrteHkgFBIQ1QFIKik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNWfRYFy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNWfRYFy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED161F01558
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 06:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785564620;
	bh=T+lPUrW4At6rnw6kymwX4eKloaHv/K1zPk7Ayk2RyM4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CNWfRYFyqzZH8mAs68WBTXdYtatFCnaRlRMizzA+nU2n3fOUcKcXABTH0VcGD+Rhv
	 RSuU6tAArSFqrcKni8FSrcsmj28SO4Zf5us0ijpUF7/AmJie5Xz3eC1uvofqNQVAGL
	 eL0rrTMTSEkWW86yJeBeSHe0T+LWmWN7P+PH6Ge21DzCxcMdVx6yMElEUmoDufHGl/
	 8NRBqmgL8wB94+n65B8uwlcKsMyKUK7yN6IUbC3YWeA+iZKJQ86/30iJVIHEaX37+3
	 oD/4YE/pwkHyo8ot2nraYwA9wrrbwR9YBJpRrMpikTJWYxTuxWDK4zHgy7/Xn9kYCv
	 dRgsuzoum8EVw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15f47e6297so190865566b.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 23:10:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqqBDZgF4CU5sOge54LsS6IcZMsAuXMWW7j3eAMN+B+KBWBDRf1F8tVHnD+MT8FiBQkN2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWL53A/wk1hcrhn30z52M96ZYQyPws+pFPF+6BFKrfPc68Qs3U
	Wl4uMzNLQvzQUddCI027yjJZGTEYZVhfwa9eDqjcji9iwMJ1UWxSgAN5iIj7oYijWphQW6yIAOb
	+OO8ERVyjpSZzeYVz2Yi00Ecs6DVPj70=
X-Received: by 2002:a17:906:f91a:b0:c1c:4752:b5fb with SMTP id
 a640c23a62f3a-c1fe7f3e45bmr121096366b.27.1785564619503; Fri, 31 Jul 2026
 23:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728003557.1136583-1-yosry@kernel.org> <20260728003557.1136583-3-yosry@kernel.org>
In-Reply-To: <20260728003557.1136583-3-yosry@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 31 Jul 2026 23:10:08 -0700
X-Gmail-Original-Message-ID: <CAO9r8zP3=B8Cn58D+0Gp+aF7g1QaxCb6QNV8vvLmeCidC55Tkg@mail.gmail.com>
X-Gm-Features: AUfX_mzE-NKK6no_OQU1lh3jfAx-VDe3r-kqGwJlFAavATar-1NUzUxYv-YTLWc
Message-ID: <CAO9r8zP3=B8Cn58D+0Gp+aF7g1QaxCb6QNV8vvLmeCidC55Tkg@mail.gmail.com>
Subject: Re: [PATCH v1 02/28] KVM: SVM: Document number of ASIDs CPUID setting
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 5:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> KVM arbitrarly advertises 8 ASIDs in KVM_GET_SUPPORTED_CPUID for
> historical reasons. Advertising a small number of ASIDs to L1 is
> currently harmless, as KVM (L0) uses the same ASID for both L1 and L2,
> and flushes that ASID on nested transitions.
>
> However, following changes will add proper ASID emulation and a separate
> ASID for L2, minimizing the TLB flushes on nested transitions. At that
> point, a full TLB flush from a KVM guest (L1) would flush both L1 and L2
> ASIDs, so should be avoided as much as possible by advertising more
> ASIDs to L1.
>
> Increasing the value advertised by KVM is tricky, because a VMM copying
> the number of ASIDs from KVM_GET_SUPPORTED_CPUID may perceive a new VM
> with a higher number of ASIDs as incompatible with older KVM (which is
> not true).
>
> Avoid changing the value advertised by KVM, but document that it is
> essentially meaningless and does not represent a limit or a hint. Also,
> more-or-less encourage userspace to advertise a higher value to avoid
> potential unnecessary TLB flushes from an L1 hypervisor.
>
> Suggested-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  Documentation/virt/kvm/api.rst | 20 ++++++++++++++++++++
>  arch/x86/kvm/cpuid.c           |  4 ++--
>  2 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index a5f9ee92f43e8..2d24bf708d77e 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -9542,6 +9542,26 @@ the APIC ID is found in EDX for all subleaves of 0=
x0b and 0x1f, and in EAX
>  for 0x8000001e; the latter also encodes the core id and node id in bits
>  7:0 of EBX and ECX respectively.
>
> +Number of ASIDs (nested SVM)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +CPUID[0x8000000A]:EBX reports the number of ASIDs supported by the proce=
ssor
> +on AMD CPUs. KVM's ``KVM_GET_SUPPORTED_CPUID`` hardcodes this value to 8=
 for
> +historical reasons. This is value is arbitrary and does not represent a

This value*
