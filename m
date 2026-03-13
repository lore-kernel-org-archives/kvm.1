Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98073242AB
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 20:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773434324; cv=none; b=rDo1CjghYnUz6miVSQiqXX+zVuiZVRrgy2OBvd+ipPZgBaMqPV+PYqJAhr/js5VY/TQKcrDBFfsGfrhK05bTJyc0EdNK9fFPHsJ/hkMZXhv0l/K2VYueaO3lYbRJIY+grNhCwB3Q3zQwjFI2HENvL7eEYB7IO2ov+IzY2lqC6SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773434324; c=relaxed/simple;
	bh=09n5LzWHKbNT6BBOlRO0wkhI1wX8qUvgbLCgaiHWvy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Emaxv1ONChTI+4mutfq7GUEDwxmsdxg37vePFg685/deUerfA4bu3fa0Rg+1BgtmAwB1tFgNCN1/+x7OU47d2L5DHP/KLqsigGGKJ7bjL7zCPDDjaH1yL1Y4RnY1NIGlYbgTxxKgQHc5T5CfjGC5cuyI/qQeqfZ39V4XfDN6lhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HS/wSzhf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HS/wSzhf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786AAC2BC9E
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 20:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773434324;
	bh=09n5LzWHKbNT6BBOlRO0wkhI1wX8qUvgbLCgaiHWvy8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HS/wSzhfIL61Ey88cBVjCR9odW8N5NpwXIdEHjcCHm2uj8pd9fOQEIqwLHIRGEexb
	 Rz3K13VFBgCXz2SUKPjs6ci333Loj1MsIMjJbWzJkpdufDq9MvxQuN6HJmUL7E7dj1
	 sBqoRMfW+9psDZofYyO6ux6NrG4HEYvcjrZG0Q6/tlVW2nQpQZwudrxEohBCRJFsxb
	 f6U47DncQ9OWpEOYaepsIKcc75L2eobLgwiLhAdQPCYS7+XWURRlOBcjXVQv6o2dmD
	 XU5Ji9Mtn5RJH8jIOL/9f9yiltkS1el0zqcDvvfUoY9I/naGjmlH4LocMC+2tW/RDH
	 RAzoES4IelZxg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-663a6bb0fa1so2682947a12.3
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 13:38:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbOJRYHGTUtljUVkk1Tj7xv2RbeG37cI3VcPVB857PrzctJ117KmjF+2RxmSLmj2FqHvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpDAUSEhWdZi/o/dnDs2+w6QqwKsqIr0chXs1aayLi9OG3XnCv
	QljvrnYa2KySyMrO8OUw/620tHcIlS8HiCCroK9vARc8Lm4tJ6wHM1CZueXJa0kqwjE/1UfcmLe
	NNJAAQ+3glpbtdclixvmm7/Q5gLQ7shU=
X-Received: by 2002:a17:907:da16:b0:b97:8405:640e with SMTP id
 a640c23a62f3a-b978405646emr68549466b.8.1773434323188; Fri, 13 Mar 2026
 13:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310220414.2569208-1-seanjc@google.com> <CAO9r8zOu=CzDeUi0nxukfvKXeE5m+tn-gOsoTVMJ=rHtncx5cg@mail.gmail.com>
 <abRwSJHJ9yS4XAx7@google.com>
In-Reply-To: <abRwSJHJ9yS4XAx7@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 13 Mar 2026 13:38:28 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOaUM+TBcQO=6k2Nt5=VauiDifCU2JvhUpts_VGcPSYKw@mail.gmail.com>
X-Gm-Features: AaiRm51AEeBDbWG71ZL2HFy7lkymG9zXmloODNm78Db3W37WJOj8holm4j_fenU
Message-ID: <CAO9r8zOaUM+TBcQO=6k2Nt5=VauiDifCU2JvhUpts_VGcPSYKw@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Add a helper to get LBR field pointer to dedup
 MSR accesses
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Hrm, I was assuming the compiler would be smart to understand the other cases
> are unreachable.  What clang version, and are you doing anything special with
> your config?

Debian clang version 18.1.8 (20+build1)

Nothing special with my config AFAICT.
