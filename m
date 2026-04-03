Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8AE18859B
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 21:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775252757; cv=none; b=cZ9+Ek50DIb8H1TIMe9YzbDd85GH8o6Ahex3m1FB1rDWzdsJnv8AZcchP0kOdy+elBhj8ipA5AZ+jXe0iZsoDCaPLzkbV+KI7pIOdxPL/63E5PSewyaNb3T7zMKGl0U3LDJXcutDfw7X9ESkcujJv50mh2S5oiXqPuTjaKm8fQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775252757; c=relaxed/simple;
	bh=JAPW13hsCQb9I7piJBbby0DYY8z3JKaOMpstE+JCq+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjoW5NxjKXVLSRGRWQM11w96BZvHIKyzb7k1xeO/9SCO3FeZ9qK7dQk+8Tf/NvFmSxZmBZj3onnSu+46UdeTTvFV/uDqNSn3wZdDHFa1ojpwWdPYevrZPoWlEBWDa2srGsAgcPe4GV+acagI7a7tJ6zUFDRL9LPxZB6jEBg7XSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJqZm29V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJqZm29V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF14BC4CEF7
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 21:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775252756;
	bh=JAPW13hsCQb9I7piJBbby0DYY8z3JKaOMpstE+JCq+Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jJqZm29Vvvecxq8XLNx//hAM7H3TxlvDMeHRtIpij1LE/EYrXYu5Ia1pSERAgvCO9
	 AlM3yKUM3N1W1yH5hd0DvvVmoWlYwsS9WKBxn6amkSaLf/w5ewM7i30FSRS6rNaZ7U
	 /AHDfkA5LAzsflJ2hCKDfZwIFIMkX0svQpYXJRwzSXt+pkeJYwbRrOIGHyU5ObaG/t
	 xHkMJh5VIlHYYhVmbjoo5r1DrKm9KudQ2cOXlfp+X8H7CJq1sR18QI84+SEUYkuZmc
	 P9YBxPyBRwSvGasJGkccv1Eu1CTCK8Ot/ZLvJpMEG2k6Tj7HyKqvk8tXNk8clqDQYP
	 UPF0XpUD1cYKA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9c1da7ac63so388748366b.0
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 14:45:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnzvdQklgG4Zi9VISPUvSepNsWA/oEar+F2eY2hrVlgrvTz7AZ/gAamjfoL6abpUMe5p0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9wJ0kzv+bHZvYfg2kRorJ6ENCcfOK7beHZXN0GQXZUgT34qzc
	45iJolsUHKVC1uTuppSHWoSTei3DYBTIRHR3dNQCbnRgrISdr++jxTZuTy6/B1nKy9z70h62RsQ
	fafM8NdK+rIXEATedibcKygWf6EvxewU=
X-Received: by 2002:a17:907:3d4b:b0:b9c:513e:34db with SMTP id
 a640c23a62f3a-b9c676a2d7bmr252599166b.23.1775252755665; Fri, 03 Apr 2026
 14:45:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316202732.3164936-1-yosry@kernel.org> <adAPcmksaq8Oq7V-@google.com>
In-Reply-To: <adAPcmksaq8Oq7V-@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 3 Apr 2026 14:45:44 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOf2PppGcA+2Eiz1Eciy_1wJ+csCpC=fotQEcJDNE9Dyw@mail.gmail.com>
X-Gm-Features: AQROBzA5tUjmwubIjH0tPqlpB3iCDlNL1gic9JwXtP1NGcDmPPUqhD2A7WOpXyI
Message-ID: <CAO9r8zOf2PppGcA+2Eiz1Eciy_1wJ+csCpC=fotQEcJDNE9Dyw@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] KVM: SVM: Fixes for VMCB12 checks and mapping
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Yosry Ahmed (9):
> >   KVM: SVM: Properly check RAX in the emulator for SVM instructions
> >   KVM: SVM: Refactor SVM instruction handling on #GP intercept
> >   KVM: SVM: Properly check RAX on #GP intercept of SVM instructions
> >   KVM: SVM: Move RAX legality check to SVM insn interception handlers
> >   KVM: SVM: Check EFER.SVME and CPL on #GP intercept of SVM instructions
> >   KVM: SVM: Treat mapping failures equally in VMLOAD/VMSAVE emulation
> >   KVM: nSVM: Fail emulation of VMRUN/VMLOAD/VMSAVE if mapping vmcb12
> >     fails
> >   KVM: selftests: Rework svm_nested_invalid_vmcb12_gpa
> >   KVM: selftests: Drop 'invalid' from svm_nested_invalid_vmcb12_gpa's
> >     name
>
> Some nits and suggestsions, but I can clean them up when applying.  I'm leaning
> strongly toward applying this for 7.1 even though it's super late in the cycle,
> as there's very little risk (e.g. compared to the gPTA or host/guest PMU series),
> and getting the VCPU_REGS_RAX landed would make my life easier for 7.2.

Thank you!
